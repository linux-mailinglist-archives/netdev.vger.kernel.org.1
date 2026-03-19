Return-Path: <netdev+bounces-269714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKV1IOmAvGnfzQIAu9opvQ
	(envelope-from <netdev+bounces-269714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:04:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5832D3F78
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A27243149FE1
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFAA3C13EE;
	Thu, 19 Mar 2026 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="OzQ+/OV+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MgasiUc0"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAE23BE627
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961388; cv=none; b=IYinD/CJei9q2/AZmui1OMWskvfmLWzbRab4bRBKn+73AchY1W/7O2Xw7dKDV0bGNeVqzThWS77y/IgvF07NCJQeLKz9PsNndgsGJWKRN2VmO2+EqJtlLQ06R94CcauDE1yTyF3O73fKXjZpzc9sRtyRdOEwnKtVuILX62Y0ZMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961388; c=relaxed/simple;
	bh=DYfTNsLKXf86NNGte2Pkk2plwMnRKC7YSb47hzrOExY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ea1OcBv2ZNRm+hsAnnU1gC2DtLNkE7QNF0B9Yvxd31E2Wv3gmfZ4LLnrFBZLEwIKS9OKc0QZCLNU93BjNw3Z25Z9j8/26ISO63c18OHKOBWGykx829xEo6qJkUZiC45D8Z8pOu5J4zeNOk9D/N+2ZxjSrEj3/6Ub6r/WrUXE/s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=OzQ+/OV+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MgasiUc0; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id ECBD81D001CD;
	Thu, 19 Mar 2026 19:03:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 19 Mar 2026 19:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1773961385; x=
	1774047785; bh=lrVqC1+UFbj9n3VbiotKoouwWnUvPvsu+7NEobC/Mrc=; b=O
	zQ+/OV+bkNc2u9sXTKJMeLAv6pGWzdCSYRtqDa1rhyIUS27X+3//lVZajMFjp7fT
	3UQG+cS8FqzPRZWVOqWbg8ZmTtv8GlhkvaLCcwQjhsldW1eoC7mZwJ6Gzrz/mWNX
	VPovkbrS5G716sYGDHx0mqxP+CB/YLE8Luva8/nLEO1NIEY7uz7g7Gx1+mvs4yms
	XVg4WumZ9VsqRzyOPDo4WwHXq24p4di2OIv9Pcx4ctGaVWZzQolPe4/Pd2PvOUNQ
	M1y4EWAyisdL7UtP3nmj45CzBMWIVmDacpd31kqyY8Yca+H+Lp76IoJlxXTCs4AY
	WNZFoP5CEBLU8S6l/6OTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1773961385; x=1774047785; bh=l
	rVqC1+UFbj9n3VbiotKoouwWnUvPvsu+7NEobC/Mrc=; b=MgasiUc04BeyVlbee
	A8SGVmtIWWrANpdW2AcRqAlahO56Y/GpzvLcxjp2Y5TgSnTUvdMXLOAiKCEC68fC
	ZAAphvkRjYnXw0EDiJNjkvgS9Xyi8lA6nQGcbc2d4oM41ALxnC9C9W3TB1CPmSsW
	VqMFeyAgB6Oe9prCIh5K8m/5OnJuHClmW81JRTBcYEQzxrXPtOXL0aqt/TZd6suf
	NS/1ZH1CtSX3ctkJSVo44Kg+fIB9n1odOoNFoChdG8oxqThy36Cu/Y9031y6mTsh
	IjUXcg8JP/J6CVXtAVfI5s+UkRF7u9baIMRdSLkRRK9grrjJ++z2J5Uj/1HDCe4/
	Y63Xg==
X-ME-Sender: <xms:qYC8acDw_HWJNni6w-BlfqXsnPp84jgywDevnZ_XWAWYN84ESyZwmw>
    <xme:qYC8aV_50J8Mloz0fETdKkioC6zXjJl9J6fMdK1vhvRY-8Bu151ab1Wnnm_2zR5A_
    0iKnuVQntE2CybbOL24EDaLvK0Z4Zj3FrkuwSp-Yxgb25OJobGd75lL>
X-ME-Received: <xmr:qYC8ac-PF0YxLsZlTvkkyMZHXRypxKKAwZ1hXk-mVHnUzwBhRCbbBAAAkYka>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdekvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrsghrihhn
    rgcuffhusghrohgtrgcuoehsugesqhhuvggrshihshhnrghilhdrnhgvtheqnecuggftrf
    grthhtvghrnhepieeiueeiteehtdefheekhffhgeevuefhteevueeljeeijeeiveehgfeh
    udfghefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgusehquhgvrghshihsnhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsugesqhhuvggrshihshhnrghilhdrnhgvthdprhgtphht
    thhopehjihhrihesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:qYC8ace42gCBGc-RRUlBWl3q2LYa32FI8VAgRGoEVseB31SuH5m3ig>
    <xmx:qYC8aVHy-DIRTObO3RP6vtV6pujJJW9zx2u4omg6erNeIZkfg9kXcQ>
    <xmx:qYC8aadz8Qgx6NMl0Jh25I8SBZBZdT0JdIIStkdmIp7VVdK_kr1GXQ>
    <xmx:qYC8afFRfZodPlfyr-bACoyIT_5acIjPwESQBPCNS01ktlmnipyJYw>
    <xmx:qYC8aSFpIYxIRl8-LxyUOkeFXZAsg8bCJqT9dHGD8VJ-TrqgL3bdAMrF>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 19:03:05 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net v2 2/2] rtnetlink: count IFLA_INFO_SLAVE_KIND in if_nlmsg_size
Date: Fri, 20 Mar 2026 00:02:53 +0100
Message-ID: <049843b532e23cde7ddba263c0bbe35ba6f0d26d.1773919462.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1773919462.git.sd@queasysnail.net>
References: <cover.1773919462.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm2,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269714-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,queasysnail.net:dkim,queasysnail.net:email,queasysnail.net:mid]
X-Rspamd-Queue-Id: DC5832D3F78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rtnl_link_get_slave_info_data_size counts IFLA_INFO_SLAVE_DATA, but
rtnl_link_slave_info_fill adds both IFLA_INFO_SLAVE_DATA and
IFLA_INFO_SLAVE_KIND.

Fixes: ba7d49b1f0f8 ("rtnetlink: provide api for getting and setting slave info")
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/core/rtnetlink.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

v2: unchanged, keep Reviewed-by from v1

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 0fe279432d82..4a2278614250 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -707,11 +707,14 @@ static size_t rtnl_link_get_slave_info_data_size(const struct net_device *dev)
 		goto out;
 
 	ops = master_dev->rtnl_link_ops;
-	if (!ops || !ops->get_slave_size)
+	if (!ops)
+		goto out;
+	size += nla_total_size(strlen(ops->kind) + 1);  /* IFLA_INFO_SLAVE_KIND */
+	if (!ops->get_slave_size)
 		goto out;
 	/* IFLA_INFO_SLAVE_DATA + nested data */
-	size = nla_total_size(sizeof(struct nlattr)) +
-	       ops->get_slave_size(master_dev, dev);
+	size += nla_total_size(sizeof(struct nlattr)) +
+		ops->get_slave_size(master_dev, dev);
 
 out:
 	rcu_read_unlock();
-- 
2.51.2


