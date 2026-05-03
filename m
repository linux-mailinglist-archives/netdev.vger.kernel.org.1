Return-Path: <netdev+bounces-283643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sObWD5t+92lsiQIAu9opvQ
	(envelope-from <netdev+bounces-283643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:58:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B80A4B6B07
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 18:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 52B843001596
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6DD37BE6E;
	Sun,  3 May 2026 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="SkyJi43O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FNSQAcz4"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8511C2D877A;
	Sun,  3 May 2026 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827480; cv=none; b=dmGfRq1I8bJZGQk3SrEUYF+vxWjoSuKEl1nl3vTy1oqu4dPEF1q8NtUWXuleDnJk+ZvWsz6zf/UTxz8bcVZqiwCKG5m57aCASezwtYufbMqVJd6v6Xr7/KcnQiCnS3g8uL3LpC7gyP98GnZvWPusTx13+6yW4pCAxkkVXpztRDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827480; c=relaxed/simple;
	bh=GWXOocp7AUgPPBOxZT6llGYGBfJgPDV3T3W+xglzGNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZrzQFYxzQwyo6l+tOnqHwi9MkiNlLPrI/mr8zYSTN/jeQhffoRgcPhy+8WSLNCIn5+zKeoloC5yesR4JnXBnJAof7sIl9kA+RzQNVPq9OetlPnqBDo5UZ8u9SHbMxCgfYetmfjLMc9pFjebpq5Ljcrm0t7XHCeqFfqU26cQ7JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=SkyJi43O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FNSQAcz4; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6252EEC0081;
	Sun,  3 May 2026 12:57:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 03 May 2026 12:57:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1777827476; x=1777913876; bh=tMCgbw9JP6++EMQIiWQDT
	jkgT5TM8HAnim+IqX1/stU=; b=SkyJi43OEgoQ7sb44Wt0qmoPWote/3EUt6E0o
	sr/vF4d3whWEsNCWWcdHA2YceJu1+E1BUpHLLn0yziGF75MDl1terR9kWXVy7Ndt
	H+d+NHvvnKTZ2hyZ1zCk6IVmuUKeVC1RbSTlccii7l4jLowb13g9ZBlcMdgDGnsO
	mK5bRqad7l5vcqJZVL8FYZyQ5Jb3ymjfSq8P9xht1X1OY+FwNs6j2elitNs8n+Dv
	4VvV3YQ5+qHVE5U13c7jyo8ncbovmDf2XsCb1YTt192ieQelEmqIU5SrMaKaaBDJ
	LFhXZ9ce9k5SnZxxOP1cExNeZXQDP1bfheJycsTADLtY33oWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777827476; x=1777913876; bh=tMCgbw9JP6++EMQIiWQDTjkgT5TM8HAnim+
	IqX1/stU=; b=FNSQAcz45NhHLoUS5XLZbi7XJt8B5sXDAjLHBmw5NQI0L7/LPGg
	/KhyEjTVW4H9oAlxWlGsm3VkP2F8OpmkGkrgjuLT9egSmoq9ST8dCqxVdOf9WWbi
	QuCSV2mSAv1WarRBypsalEt9ezI65BcfvO39OIi5d4iK7cJ0x1EgH9m4PNLLux6/
	U5u9RttRoKeBFQcnHsVAmepQ/jtd5piIlD9jNLkc/kI9IrPQqLnVZszAku14Fo5x
	dARGSgEVoMkvgM9qBlmsUSJ+oRk+xxpn2ZWLqdjP9L7ZhTcFWVOIuO8wilG+EFX6
	NjxTczLUDCuTEVxfhZtD2JrIbkjiPZItE7g==
X-ME-Sender: <xms:k373aZytS-2ZUEny8ZFERSsz7NXf2r8E2-HOjpzUehnaWTjI7hZU4g>
    <xme:k373aXiZe70GFyf9EnMamI3lJKipy-7ttGfxFHhfEiwhydjGJEWl8c5ahEBE3hQwL
    vJZKAKlKBFBcb8qu41cwzjtO1VVB_GuCFG4LDvsaJJVDBRKttUVXg>
X-ME-Received: <xmr:k373acprcDtNT_vit7kSf7_Ca7Vjj8keitF1aEIYoD3n5UsPFjdjahHDsrh6_bgGIPip3tHy9xB_hQnIS5wQ8BU5Dtf_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelieehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcutfho
    shhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehkefgtdevte
    dtkeduudeguefgudejheeugfelgeettdfhffduhfehudfhudeuhfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
    dpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegu
    rghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtse
    hgohhoghhlvgdrtghomhdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrh
    iikheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtoheprh
    gsmhesshhushgvrdgtohhmpdhrtghpthhtohepfhhmrghntggvrhgrsehsuhhsvgdruggv
X-ME-Proxy: <xmx:k373aegz0tAqFzQKrEg-ouNEkv7if0SeaqJwQFl0gEqIsDu0fzKM6w>
    <xmx:k373aeOkzZ0ofZqiCQ0m8sL05nCOeg2h2pwDiJKhg2IH1aPQlEtnAg>
    <xmx:k373aYyRKIsdf5G48L4zcFPHlgqqNBElhsR1nboTHUfRCJWZxfC8ug>
    <xmx:k373aQr6ahD6XUoMSBYpWgYtuUFT5hH6tpelFStD3VKLzPsjF0Q_Ng>
    <xmx:lH73aS2KFC5VbT_zP9LcQDIkbZiZu2coZgNl3tp-oJJ49yYELLCrkog1>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 12:57:55 -0400 (EDT)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 389C17E625A1; Sun, 03 May 2026 18:57:53 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	=?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] ipv6: default IPV6_SIT to m
Date: Sun,  3 May 2026 18:57:14 +0200
Message-ID: <20260503165714.1477819-1-hi@alyssa.is>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6B80A4B6B07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[alyssa.is:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[alyssa.is:+,messagingengine.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283643-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[alyssa.is];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hi@alyssa.is,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alyssa.is:email,alyssa.is:dkim,alyssa.is:mid];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]

This basically defaulted to m until recently, since IPV6 defaulted to
m.  Since IPV6 was changed to a boolean with a default of y, IPV6_SIT
started defaulting to built-in as well.  This results in a surprise
sit0 device by default for defconfig (and defconfig-derived config)
users at boot.  For me, this broke an (admittedly non-robust) script.
Preserve the behaviour of most configs by avoiding building this
module, that's probably overall seldom used compared to IPv6 as a
whole, into the kernel.

Fixes: 309b905deee59 ("ipv6: convert CONFIG_IPV6 to built-in only and clean up Kconfigs")
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 net/ipv6/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/Kconfig b/net/ipv6/Kconfig
index c024aa77f25ba..3cfccb6ce5c29 100644
--- a/net/ipv6/Kconfig
+++ b/net/ipv6/Kconfig
@@ -164,7 +164,7 @@ config IPV6_SIT
 	select INET_TUNNEL
 	select NET_IP_TUNNEL
 	select IPV6_NDISC_NODETYPE
-	default y
+	default m
 	help
 	  Tunneling means encapsulating data of one protocol type within
 	  another protocol and sending it over a channel that understands the

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.53.0


