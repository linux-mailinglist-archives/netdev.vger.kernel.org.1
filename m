Return-Path: <netdev+bounces-47762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D40C7EB472
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 17:08:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB09A1F2531E
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 16:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263FE41A84;
	Tue, 14 Nov 2023 16:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="CJqOeyWK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GiNU4WY9"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE74174B
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 16:07:54 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB01131;
	Tue, 14 Nov 2023 08:07:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 28F865C027F;
	Tue, 14 Nov 2023 11:07:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 14 Nov 2023 11:07:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to; s=fm3; t=1699978068; x=1700064468; bh=/o+gGzs0tL
	AoVAa+IINmr16/aOhoTBXojzZiBHw5gCQ=; b=CJqOeyWKwx7CA87TzPMKzYmj2y
	gS1YT4bb1NYNBSzq9lpBdXzybCGBTh0GPpAwhGxGel53I2tC9l/0g+wkS23Lltee
	OffEsA4+cogGZKYTqB2SG9kJpCRUsHcpS3YCcBkiqGZ7Uu6pM6D/awAuXlJzPHon
	qu6RbXnYMo9elr2XE0/TQxkzDMNYbF6gMA+78yKcxZ9fOwqUhCOnVi1xADxG9v6m
	aM4LevkMUPWrni1ymeE0MfnV2GFAGODR9bvOSNW0+iLZ4CwTofvF806IjAbUH69r
	bmiKZpvmcxRXOJyvdun0aZa5UPRXSm8vinvjl4wvHyPCPqnN7zt7X3wi9FZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1699978068; x=1700064468; bh=/o+gGzs0tLAoV
	Aa+IINmr16/aOhoTBXojzZiBHw5gCQ=; b=GiNU4WY9h6T2zC53oaCbFZgjR4O0P
	FFcBMqepglcSFCLYhjMTf3BrO+jtecLaOIaqVpw4jz1xqagzt9j6rINnCG046pJJ
	rJGbrvhztXCU77LlmA7q2ImJaVqpmGVqb75z7I8oF2celdNyCQ7K3r9fqPSc2JYx
	2Nb2S0IitcLmZupwz3L9u/Hru+N4n6smUxBjEkZNGNUdtEKM8rQf0eKEo2bSkxq7
	FHxLaTuuZ4mtWoPrysQV0f7hlxeWAazSQnW6invXsyESSufUoEVtnjRCuiNiyg9Q
	Ki1F5xT7bWMHrd9U1i+11nYxvx3Vi4GErpR/CBYt0d8l8N3lJ/tQdT4yA==
X-ME-Sender: <xms:UptTZZp5_ZvDt201OUXVwXf7OfeypWxbtrkb5SNwsREFh9PbcCG2dw>
    <xme:UptTZbo-GxSXEmhmKQaFHNtMdyini6-QBitVkLWjQl0mzSm2nLY5IhzLNIFW0-yMw
    dSQDZrLutZTbCj-PEg>
X-ME-Received: <xmr:UptTZWMpzSAE5CH16fKX2HMKzw2PMhTu1W7eYwHkHdN26qbD2JQs6tEwMLECJARIaal5jVh0ipsxEUZJMq7KEvFgHJy1bBW6Jbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudefvddgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    hmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnegfrhhlucfvnfffucdlvdefmden
    ogetfedtuddqtdduucdludehmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghksehs
    thiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeegheevvdfhtdeljeefgfeugeekue
    ejueehveduvdekteeugfekkeelgffggedvffenucffohhmrghinhepughmthhfrdhorhhg
    pdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:UptTZU79sJC_D3YRNekszXMlDXHFivXS2W_pKZBToigsJaUpoC0Ptw>
    <xmx:UptTZY6yGwNhS2CREnf1DoHXnj8QpJT2gxnNlxTvWRbXzwvO4RTkNA>
    <xmx:UptTZcg2BXVIM7n8wUs17-chxGDx-8EG6fAxMEQoIfDmRBWP1TQ3zw>
    <xmx:VJtTZZENWEM2k5zTR5MNYr1TZqWmjjJYJD_4Mw_0EysHr3tYNzh3yg>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Nov 2023 11:07:45 -0500 (EST)
From: Patrick Williams <patrick@stwcx.xyz>
To: 
Cc: Patrick Williams <patrick@stwcx.xyz>,
	Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joel Stanley <joel@jms.id.au>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>,
	Peter Delevoryas <peter@pjd.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net/ncsi: Add NC-SI 1.2 Get MC MAC Address command
Date: Tue, 14 Nov 2023 10:07:32 -0600
Message-ID: <20231114160737.3209218-1-patrick@stwcx.xyz>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NC-SI 1.2 has now been published[1] and adds a new command for "Get MC
MAC Address".  This is often used by BMCs to get the assigned MAC
address for the channel used by the BMC.

This change set has been tested on a Broadcomm 200G NIC with updated
firmware for NC-SI 1.2 and at least one other non-public NIC design.

1. https://www.dmtf.org/sites/default/files/standards/documents/DSP0222_1.2.0.pdf

Peter Delevoryas (3):
  net/ncsi: Simplify Kconfig/dts control flow
  net/ncsi: Fix netlink major/minor version numbers
  net/ncsi: Add NC-SI 1.2 Get MC MAC Address command

 net/ncsi/internal.h     |  7 +++--
 net/ncsi/ncsi-cmd.c     |  3 +-
 net/ncsi/ncsi-manage.c  | 29 ++++++------------
 net/ncsi/ncsi-netlink.c |  4 +--
 net/ncsi/ncsi-pkt.h     | 17 +++++++++--
 net/ncsi/ncsi-rsp.c     | 67 +++++++++++++++++++++++++++++++++++++++--
 6 files changed, 98 insertions(+), 29 deletions(-)

Signed-off-by: Peter Delevoryas <peter@pjd.dev>
Signed-off-by: Patrick Williams <patrick@stwcx.xyz>

---

I am taking over this patch set for Peter D, who has moved to another
team and no longer working on this.

Changes v2:
    - Conform to published NC-SI 1.2 spec (switch byte order).
    - Use netdev_info instead of netdev_warn for MAC.
    - Fix checkpatch warnings.

v1: https://lore.kernel.org/lkml/20221221052246.519674-1-peter@pjd.dev/

-- 
2.41.0


