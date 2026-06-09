Return-Path: <netdev+bounces-297164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KJuiN9lFKGqrBQMAu9opvQ
	(envelope-from <netdev+bounces-297164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:56:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E4662AC3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 18:56:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AajOKwAi;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297164-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297164-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3CF7315E469
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A056C421F12;
	Tue,  9 Jun 2026 16:31:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE6495536
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:31:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022695; cv=none; b=QACNLcpRZCxUZQXuOMsgXs4m0ZdFUAo62D8avj9A6oBcAMPd6/4VO4K2mzzrBqaQVdo5pZ8lCfst+b5XHDK5YU2JqJf1vUGcnavatAuqVpMw5YR1fdICN8H0ChBcQhS1Yotw8AROgJU8WgzyTKRC0NtYugdQKyVNH9WXCx/s8RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022695; c=relaxed/simple;
	bh=9CeSQ65EFy++LfGUh9ogh5aCzFhQ1qyM6WnEMY0Q8zY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HHcMI2j/QRBujj8EbjxJLI3ed+IPIm5882YlfLKkwnaHBpr9ICfR6F/+HZaphlxuufgtTxMqIkKEsvr4pABpXsvyLLbN9n3FDRACI9obdXr/tf8NvljKCg98c7gD5slqedAizAQ8W/Qbf7SQZ0om8Y7qNsaDsxnm8Ok09sJGYg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AajOKwAi; arc=none smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so48511815ad.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022693; x=1781627493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b/NUtWL+pGSdZG256FKpKppSfEdak3fTDyGu+gJY7Vw=;
        b=AajOKwAiXrBCsuRnXG7hDUCjLxFkiy0QtamciUoMbPVBSHg80MJMqHMHHIxFtC4Kp3
         jjrZ01g9uI1ZvSa1PHn/MlU1HF2bpk4NbdzwZD+wyz7LEaKlqXOK7+yeKEHpRNV71vDg
         e8SHdFyWYkDc05DOMHkD5qZYBqRJRlGL19y9qWXPP2bfJL+KOhKMOVlnR+Ic4cld1dSu
         +bJaVOjHZwxIKqpNnCiXucleIBDP5+ZbaGtOKLPc6MIV+FH4GDe60cT/QygWQic72JXE
         ijz6k3QqUhEdsdHLT4DW6NS0JlNqixMseVk+JhwhHIA7ZBKtQz9+R6K9vvTn1vqcnbwv
         OQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022693; x=1781627493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b/NUtWL+pGSdZG256FKpKppSfEdak3fTDyGu+gJY7Vw=;
        b=bzdMKIK9z3w+7nO5hDsCF0ZkkW8L3oLgh5PovNwyaF1x6ks8Wo/lz3uBzsITsCgFZJ
         9CkfMY7FWXheS6M56MPuXxJm+b8WiT/roquWBKrIHmX0j8qEjcUsHSCebM0/Jk0KSL8j
         NfVR5ohKi9sidx+ArPs2tHz2civajExpqvg2OT6sHc5Ci6jURdEbwWW7RAoaR1NxnTE6
         noRFY3D7i99F6i7XRXctTyU2iPB6sL8+rrXCeldbieFr+a0UDn5EEAYAqHQvnj46fqvR
         /lT1CYT7TGhb0z0WYwE/6Ot+VXaGOgtZo90Sztlr6IC9tsq70KMFZT6Esx92R3SnVW0e
         9b6w==
X-Forwarded-Encrypted: i=1; AFNElJ+Hi9dFduWY1MEeYODf3+/hx/GjVaP9bVnkYGUIEykxWtamra63s2CIq+uF55my8CXCo66qioU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDPfKRGniuv6i+mbFb75hUHbOpSp9a2gNWiXl0fZyXFoMrqc81
	vfQVB5pq+8n0qwGtiMjXewSgxVAnWqpIrj0c+n8/x5Pd92LLKgvhdnOb
X-Gm-Gg: Acq92OEXU79n5Z4EFwIHgQTawP+C3zqtaxpj0kSTlL7o0CoD7231vIxptifHRoOYjqu
	pZLbC5BNpMfb1yUqHC6v0hmTNBpmU5LEnR6dBRYvf62WNR6Xo3UFqY0XlWUNMnVrGMi3ujju+yj
	YLKcrjzHJ25hXSe419LS4rqqCNMuf1+1DB0ZSudBMlx/enOIuzAnwqAlnGbPTEDyUIvAe94SvFM
	emGIN5vVOiotu56P2khad4QP1c/iD+efBNEk65hDAHBPlnP+SV31+9MsS8OgODNUWs4qi8JgOu/
	IYkjBtOOcD+g+KHZtRti97g26AN43kF8LtKvSW9trqybLT4zpgRadA2iMKKSR3sBVEeQBdXvw02
	VyvmIAQPT+ziQgvCTKn/0x2phP0eQmVq+nBrFueiO5SC4shAVTBo5D8Gcraj8u4ac/f2lI8Otm1
	4h1teVCJkBMEoHv2JvYI55kdoL5RXcuqc7JLO79PFHwTIL06Eca6yUXvfLFSk=
X-Received: by 2002:a17:903:2a8e:b0:2c1:20fe:9d5a with SMTP id d9443c01a7336-2c1e83502b0mr303154615ad.35.1781022692635;
        Tue, 09 Jun 2026 09:31:32 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:31 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Xiao Liang <shaw.leon@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v4 4/7] net: ip6_tunnel: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:07 +0800
Message-Id: <20260609163110.1717419-5-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
References: <20260609163110.1717419-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297164-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:kuniyu@google.com,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:shawleon@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 584E4662AC3

ip6_tnl_changelink() rewrites the tunnel in its creation netns. After an
IFLA_NET_NS_FD migration that netns is not the caller's, but the rtnl
changelink path only checks CAP_NET_ADMIN against the caller's netns. A
caller with caps only in its current netns can then rewrite a tunnel in
another netns and pick its endpoint addresses.

Gate the op on net_admin_capable() at its top, before any attribute is
parsed. The check is skipped when the tunnel netns is the device's
current netns, where the rtnl path already checked the cap.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: 5311a69aaca3 ("net, ip6_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv6/ip6_tunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index 9d1037ac082f..5ff8e057fb1e 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -2102,6 +2102,9 @@ static int ip6_tnl_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip6_tnl_net *ip6n = net_generic(net, ip6_tnl_net_id);
 	struct ip_tunnel_encap ipencap;
 
+	if (!net_admin_capable(net, dev_net(dev)))
+		return -EPERM;
+
 	if (dev == ip6n->fb_tnl_dev) {
 		if (ip_tunnel_netlink_encap_parms(data, &ipencap)) {
 			/* iproute2 always sets TUNNEL_ENCAP_FLAG_CSUM6, so
-- 
2.34.1


