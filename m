Return-Path: <netdev+bounces-210545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE1AB13E0B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FFDD17FEA3
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EAC26D4E2;
	Mon, 28 Jul 2025 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="UFFCEJ4o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IKJGKB1E"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990461E2823
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715885; cv=none; b=ITYae0Vx+GrRxMl6Ce5Ag6FF/HGjS1zIsw4+X1Z9xka+61wgRlwOxSUkjUlfaFSB+SFM+pqNuXJ0HbmYjiz56j+UXGAHpH5U5O/5iICMTZ8f6GkL5AM316p+UH0ZkPcKWWsTR/gZ2OwWEK02muVQZUy4LXag7Nxvip8D1lb7fpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715885; c=relaxed/simple;
	bh=PtZVe5gBpzQtegvnTWsAD6iD2zw4rsTAT55j4WxM4jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AIf+/KCtJ1ALMAV2YZc+gAJ2NpGmKspdZe+CQddEsso1J06EeywIc3QMku2xoLhM14ev+0fwUxBGRfYMrn23m7NkBgePAPL1AIODaPOipXghVbIluY8dgoylFuZXIlkltG1MA0psgjSJVW7FVE2R9KpvvccYBt3umKXfpfc06E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=UFFCEJ4o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IKJGKB1E; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1C05140025B;
	Mon, 28 Jul 2025 11:18:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 28 Jul 2025 11:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1753715881; x=1753802281; bh=2H2tSXWCXw
	kD9ucxZRzVEoVfm9cjJ0khbhko47wSlRY=; b=UFFCEJ4opKoba3UPYvf3jw/vkM
	y6g61Tum/8QBeWhWvGVsQA4ZhVUz+yMOxHX041VZ7id6wOLCKceUH1GvB7XwKpX2
	qNWqACxzcS0kUsDHlJCpjdYoy4Fpsbst0HLoy4OVeNkrn8rZCFd1zgiGTGH2rDqv
	9Fn9LSGjNlRQ+VgEJOGsCilFiwBslaJTPJMZkZyLR/tWrRwvkBvPmGrrP0AUqOuX
	2yr5gulCICYpWPXsuFToodnmWva4ASXVPFj/0ip4DgVl4n2lOOOEZuxnR6WgCtB0
	0mTBRhD2lwLQlKbwXHzap8lkIkbEYmJdSNyOSKEQ3UPwF+H8upKKC49jFvPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753715881; x=1753802281; bh=2H2tSXWCXwkD9ucxZRzVEoVfm9cjJ0khbhk
	o47wSlRY=; b=IKJGKB1EfzD1k13xJfnB/8MMd4YLoFQN8EHMpYXdOv/CMxo77oR
	zi15NUNJ4PCbgdGScVhgUXDsi9CSMV5MXoNH0I8ma7HH2RlF2CxwDSmB5mbZAowi
	yN5ssJSg74WTfOnrSklJOT3jNpnRB16ir3tvmh7yT3Fb7tF91Oii5pqyK5IBGK1I
	C2X1EkOVOE2+OHhsDB4DXziGvaV5ZD/LdncFXDW89kSZFrgwilmNb8d1SYYK+cEj
	+td6/jeVeru9eZGSAUGc4yjuRPCHuFS3ftSGzewHNHd50bj6I+JPOFELYWFFHuWK
	RRB24+jLq2IDOaUdhFXj8o84IRxLojxoM2w==
X-ME-Sender: <xms:qJSHaN7diiNs83RJw7k4eBBSgzMEQx5A0Hdp8_XbK85yjNjIBhX4qA>
    <xme:qJSHaHzAO3lxCeqXhHxBtBdFvrTFoAFDsmDEsZkKl7-W8mcep2BL_HuQhjj1_IrWj
    JVNAmKO8arpSGTrLEs>
X-ME-Received: <xmr:qJSHaEMSPVUNr6J4oT8KgBaLFyphaS17ZHE4g98-ZMTPWSLxeIew_otptFIj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurggsrhhinhgrucff
    uhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrghtth
    gvrhhnpeejtdeugfffkeejfeehkeeiiedvjeehvdduffevfeetueffheegteetvdfhffev
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsug
    esqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhrtghpthhtohep
    shhtvghffhgvnhdrkhhlrghsshgvrhhtsehsvggtuhhnvghtrdgtohhmpdhrtghpthhtoh
    epughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivght
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhr
    mhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvght
X-ME-Proxy: <xmx:qJSHaFkorZq2spVpiOLaZ2n2aedzQ11ZtQn_AoN6ctEB2chbdxSOrA>
    <xmx:qJSHaBTap98vXxEeysudqSUIMaV2PBfieIL-H2TaXxjBz8bskwSjuA>
    <xmx:qJSHaMXO3DMEkHXqnaPi62u0NFj8eFuQmJelth18ByYmYCfvvzscNA>
    <xmx:qJSHaNLuMGJXS14q6qsj6e2OGYebRfCrFaiWP4zyp7_5MzqXvcNbEA>
    <xmx:qZSHaBfhkzzKAZL2pCyIuOUKwQrFDRLFFoWhzDOMlKidTjVNgA8Vk6AS>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:17:59 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH ipsec 0/3] xfrm: some fixes for GSO with SW crypto
Date: Mon, 28 Jul 2025 17:17:17 +0200
Message-ID: <cover.1753631391.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a few issues with GSO. Some recent patches made the
incorrect assumption that GSO is only used by offload. The first two
patches in this series restores the old behavior.

The final patch is in the UDP GSO code, but fixes an issue with IPsec
that is currently masked by the lack of GSO for SW crypto. With GSO,
VXLAN over IPsec doesn't get checksummed.

Sabrina Dubroca (3):
  xfrm: restore GSO for SW crypto
  Revert "xfrm: Remove unneeded device check from validate_xmit_xfrm"
  udp: also consider secpath when evaluating ipsec use for checksumming

 net/ipv4/udp_offload.c |  2 +-
 net/xfrm/xfrm_device.c | 16 +++++++++++++---
 2 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.50.0


