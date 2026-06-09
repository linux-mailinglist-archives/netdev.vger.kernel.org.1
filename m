Return-Path: <netdev+bounces-297163-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4gcTMkVHKGoTBgMAu9opvQ
	(envelope-from <netdev+bounces-297163-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:03:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2270D662BC3
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:03:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CLaFhtzd;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297163-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297163-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6008130D1568
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F3D4921A6;
	Tue,  9 Jun 2026 16:31:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A542848B38A
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:31:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022691; cv=none; b=eH8Hfg+6YhWZULS4/BtpbS8W4Exi3IsVHMQfBrqBextC2LMY8SRC4LbkcnTl0HgVnXqnWFi/KaIXpLYSzGRJtrNY5+sIZnFS9QmaI6wUmU26hynmlPbBQF3D/zdMvSxFzxA0NElUz4Aj6VUIlqBB5Ph36vdtQasf4C2oU2QcD2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022691; c=relaxed/simple;
	bh=CKQ7zjMxV33Xpql5BA8n/9v9zqRfxq06nC1RhTinzkA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UQT7fu1O+z74v3T28MQZXPLOIvXeWA/uLB7dLa5T+SLHTYcrMFtOrsH9NJ3h5Nihl4BqKyEGu0FTlHJ2iej9CjiRwC44syAo+bqF9FJx9m3D8TNfC8+dsiPwmv/NMrCLXed2v+A17AzRxAGq9MDIrAH2mWkKQ4KB+HdfUx1jlo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CLaFhtzd; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c857fba35cfso2817932a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781022689; x=1781627489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mr5itRaGOdJM0OW4OLU24W+WID9quq8c5B9yuT9g/6c=;
        b=CLaFhtzdY9YR6LphasQyWqWEINehXZ8NbkKn6F0mAP9pEhid7MbXr3aocycNAi1Iyp
         hp3DIqCiXD3+KKffiYVuUZTdAxZte5S+TNmMJKhMSzB5kya1/cWK3mkHPrCEXxWqiinQ
         LbS5J+ALTkEQffo2Yn9z9PXLLPj7sbhJeuKtrb+aDKQn027j7uQ3sY3kwHIrMhUgGkux
         WIgnKE6gxqhBzxD9GSx+TwWBPdo2CqCpjbVZ4NWXs4s0M/GOnUP12ibofuU+/kuIJ9XM
         w+zC0uQRK9AkXIuU7kXXhxP04xPs/lYgM4ecXyn4qbOSSn/gf/s/l8+qwxiVeeWk0QM1
         np6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022689; x=1781627489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mr5itRaGOdJM0OW4OLU24W+WID9quq8c5B9yuT9g/6c=;
        b=PPXq7yU/oILNxKK+UB7UYQtHalEBrlQlcvlHKEWdDkrM0wQPSD3ttClDrkQDIP+5oG
         xyWhJbYQK/Jeses15OUwV5+C7umIA1cBMR9wtRChF7KifQRkC2YvxyrGgXnPjeVJAsRN
         1gACaP2d1sFeLc8WC9hqB/mbgcOKqyG0Mm549wIY4Dt09u4RYGvRGwZLSFVpxAqxf583
         JziNoS6aRz/DQAQQJtFeB0EqqI4mp5vEyynDK8oO5cD5pOYCRwsGevEvzIsOJJ7dILVt
         qSLCSNysJ/XDp6rjMLxuuwwgi3CACScYZcOFmOfiWfyY4UryuRPoGQ1jOX37td4T6ICI
         3dLg==
X-Forwarded-Encrypted: i=1; AFNElJ/EsFyPkY8W9Txgeu3BSzOrqOP4B2VPv9NRoDc8H6iZdFrUtxy0MbgWHSOJx6IqIsosoA917mA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/s1kItVPvemVtuzVcu4aV56oqz+88XAu0lXreRwomcFfMyhaI
	zopXdjwfbegSWL0ewosU4C9AlgeXDVeGIn2bsqXyNP29uI5SjTZ6lb8L
X-Gm-Gg: Acq92OEiezQZrayi2lr+Wex+W7vPp5CaihM9eaDwfr0GwZtAkLYn1xAs6P6NZ/7+rQl
	U4OuKbcKLS5qhFHszzvBeUAQ/tKpYJ/1ZjvWte1r4OEx2HF4xhse6Fg0ZVKGmUPQcQXT0oLWwff
	vRHblPbtVyyILuZbvh7wC4+9BQTUtC0Pofqvyl3yeFFe9ZjFVVLHyZdMoJSAdt63npHV4/iTn7G
	pyefX36KAIC6F6G+Une6veuJCL/c50BbpTyg0RGS1zkpHcEEZOqjAku1UAe8wiR2dfnZ6OSwEWT
	Rt2aFi7xfgys+tDuP4Bt8HLu/AvVdl3COeGWo5jQcJmu1fHMn7zzfUlKlBoGWkRB7msasytWoPT
	511Q6lxjlJZEzGbbEqjPKLN+op0rblRrt8uaCq4RsJTm1AlOZSv7a+66ZGyd3aHPjzvenfCzuKD
	AFRZeBGlwzOgrAybBXSwVdkKhnnQSPg7iovz6LNhrglJsYRsXx2LDNg2F6zMQ=
X-Received: by 2002:a17:90b:38cc:b0:36d:f28b:72e0 with SMTP id 98e67ed59e1d1-370ee92adfdmr22988746a91.12.1781022688682;
        Tue, 09 Jun 2026 09:31:28 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629d042sm227710195ad.60.2026.06.09.09.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:31:28 -0700 (PDT)
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
Subject: [PATCH net v4 3/7] net: ip_vti: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 10 Jun 2026 00:31:06 +0800
Message-Id: <20260609163110.1717419-4-maoyixie.tju@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-297163-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2270D662BC3

vti_changelink() rewrites the tunnel in its creation netns. After an
IFLA_NET_NS_FD migration that netns is not the caller's, but the rtnl
changelink path only checks CAP_NET_ADMIN against the caller's netns. A
caller with caps only in its current netns can then rewrite a tunnel in
another netns and pick its endpoint addresses.

Gate the op on net_admin_capable() at its top, before any attribute is
parsed. The check is skipped when the tunnel netns is the device's
current netns, where the rtnl path already checked the cap.

Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=87_CPjPVsTHbq905k8A+BuUg@mail.gmail.com/
Fixes: d0f418516022 ("net, ip_tunnel: fix namespaces move")
Cc: stable@vger.kernel.org
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 net/ipv4/ip_vti.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 95b6bb78fcd2..55ec52bc5db0 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -596,6 +596,9 @@ static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct ip_tunnel_parm_kern p;
 	__u32 fwmark = t->fwmark;
 
+	if (!net_admin_capable(t->net, dev_net(dev)))
+		return -EPERM;
+
 	vti_netlink_parms(data, &p, &fwmark);
 	return ip_tunnel_changelink(dev, tb, &p, fwmark);
 }
-- 
2.34.1


