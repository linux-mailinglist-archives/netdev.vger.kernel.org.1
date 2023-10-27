Return-Path: <netdev+bounces-44652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2657D8ED1
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 08:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C70281AAC
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57324185D;
	Fri, 27 Oct 2023 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PQRjFVhp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DslQ1kmh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB48F41
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 06:36:04 +0000 (UTC)
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C33D1A1
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 23:36:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 1695A32009B2;
	Fri, 27 Oct 2023 02:36:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 27 Oct 2023 02:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1698388561; x=1698474961; bh=8o
	eFjRmViNvhSBXJ3KgmcftxyjkynSsYN3ByXPSnAfI=; b=PQRjFVhpiKFnacw/UV
	gZ4BbhzhHdrIzrTEJFWV94+eVu3jJWN9ETh/c59hCF5NBzgFWZOs6cF7boKedVWb
	/oBQkYWWfuQtB2UnVvYpZKQVDdTw8PtDlaPTqgy8t9+vwJLrdRRhOc0ObYYoDxZJ
	ekVVyfAfoMBWd29z+wyIm6fElMcg8OKOnGRNdE1Pt1HeBN4zoUnBJmYmEgLuTliM
	2t9T/KTkTaJ3tgtot344eeeKrbDeaiCZr1eZplPtru0P5Klgsp2wJDA0NydmmtTx
	j/uu8Cq+zPVZeDIxr4t8CIUE7hxWAIMOoqBdTSMtB9Ipi+myc5XuyVli3u2PsLRN
	lEag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1698388561; x=1698474961; bh=8oeFjRmViNvhS
	BXJ3KgmcftxyjkynSsYN3ByXPSnAfI=; b=DslQ1kmhwO/N99KJnNUWVOjPTAidT
	HsfDDHKAvCFVxuKmqVXtPuwEgEi9YwEOu+t8TSG2ci/vWoHcrpIg/qK5Xx13wCgW
	H75h+NKvqJ0S78blSzZZR50o1pKwOCxr4neOaXJqjs5U576PiZZyZfVggBircfM3
	QTbuQnX+D6Dc9X0/LpCiidq5uY/9kDUl7/vgX4hRRNqgVv3YI5jU13zgPZwmhE+g
	8joJ6jfDjM8nFmHdYblt0/m8fsBHCjj0lsnxz9M/EPhYkuG0sS2sX7Jb0dx9oFit
	C5mOwwoJTmKamyeItHU3ib+sWVx+zCysj5rPOOYxUed05wYNguS/dE4Ug==
X-ME-Sender: <xms:UVo7ZVoy6HPZ32r8CRGVUUL6ONRdQ5Qx3XJD7wliS4wrPMaEdThqXQ>
    <xme:UVo7ZXpoCLa1VtaTHlWutCSq0m6X97OtdAxIMxTMZL9GADNQnDdFPg-Jp0sW8Ji43
    DuryPxCJXQ6NjHmGv8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleefgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:UVo7ZSNwSiMDnDgXkYJppyM16_xD09AhJYmYiHgAXUDGqVdhHeIN3Q>
    <xmx:UVo7ZQ6dmObWXSFALpyzcu6ZUlna2C37g79P_ICCTFWi4o4Tc-iyXg>
    <xmx:UVo7ZU43QXWkzMtvL64QFzjmjpPsoO6blHj8rE2intXototFL4DQkA>
    <xmx:UVo7ZRvijnrbCNGIxFQNwODpGmfc3U9s1sPr1KCkPTgcILXL1Cfyiw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 53252B60089; Fri, 27 Oct 2023 02:36:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1048-g9229b632c5-fm-20231019.001-g9229b632
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5b54219e-8db0-4e07-a123-01fd67311f56@app.fastmail.com>
In-Reply-To: <20231026190101.1413939-5-kuba@kernel.org>
References: <20231026190101.1413939-1-kuba@kernel.org>
 <20231026190101.1413939-5-kuba@kernel.org>
Date: Fri, 27 Oct 2023 08:35:41 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jakub Kicinski" <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: Netdev <netdev@vger.kernel.org>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, jhs@mojatatu.com, ap420073@gmail.com,
 "Willem de Bruijn" <willemdebruijn.kernel@gmail.com>,
 "Jason Wang" <jasowang@redhat.com>
Subject: Re: [PATCH net-next 4/4] net: fill in MODULE_DESCRIPTION()s under drivers/net/
Content-Type: text/plain

On Thu, Oct 26, 2023, at 21:01, Jakub Kicinski wrote:
> W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

