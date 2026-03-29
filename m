Return-Path: <netdev+bounces-272872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGBNBQP+yGmUtAUAu9opvQ
	(envelope-from <netdev+bounces-272872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:25:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACE83518F4
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 079C1300B456
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 10:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A5623C4E9;
	Sun, 29 Mar 2026 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moehl.eu header.i=maximilian@moehl.eu header.b="ZLIkeQNp"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E22223D2AB;
	Sun, 29 Mar 2026 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774779903; cv=none; b=Nz8rFhXC/S0vJgHrbKiBdWY8h90LqcGh1UEfrIIp+uWRYjJShyPSnHFNfBWey+Ys91bc/ZeRcqBgjw3YkTmrgfMAA6xYMaYW9QzM4amDenikl1YhB84KRszOe69bJHVNae6KLxRvb3vl/IS2z/nJYSvo9daYIDG9DHbS07kxlQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774779903; c=relaxed/simple;
	bh=apYe6lSrS+a3Sp+pbSOXODOzy5wo4UOC8YD4tT7Ki04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J473ChD8XiCXciBdcnLn4zVVkZyJGF7XX5WAWPQByIks8KUy5H4rG7u0AdykkrNXZmd5bJqQZOFBUhhwyXB++777y3YQE2gpVRaYVqlU3PibelFoTTidjU7oG8cb6jnThPOC/hnmFFjXXdHYzALxdkKkz2PBiGP2YMfbckD6H+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moehl.eu; spf=pass smtp.mailfrom=moehl.eu; dkim=pass (2048-bit key) header.d=moehl.eu header.i=maximilian@moehl.eu header.b=ZLIkeQNp; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moehl.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moehl.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moehl.eu;
	s=s1-ionos; t=1774779899; x=1775384699; i=maximilian@moehl.eu;
	bh=Ob0kz/Bt1b8DFffYxiZDCy79PwTTmaiwjGjmfn5xAZc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZLIkeQNpulKnVl9hY+peF3DD951ZpDbxuL8VKSD/iIZqASUG+uoprGunXOq9GDZ6
	 KtR37XGpnV314uc584FSAWuyxUGZXnAOmou9BYmlPIgjYk0f1D43XDWXuDf7wBWGz
	 xhiU8gR/y4GQkUIptWW6O2GyuH72rsAfNCvTl1Vv0TzWSuvQyhRs09tq72KcaK4cz
	 npJAUv/tPW2ND0zO4ezcJfZRnSmDXAVCgQN4NzndrO52/L6upZhvCPdMyrpo52o1Y
	 WRniwbFxdR4s2XR05vTe8A2g0JbHYT6RrEI8fZD6iC+tL+SYEKaC33Qfm89SNYHgS
	 g3hwqAlZvST126UjAA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue011
 [212.227.17.165]) with ESMTPSA (Nemesis) id 1MirX2-1vcx9F2A20-00cE91; Sun, 29
 Mar 2026 11:12:29 +0200
From: Maximilian Moehl <maximilian@moehl.eu>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maximilian Moehl <maximilian@moehl.eu>
Subject: [PATCH] net/ipv6: repeat route lookup with saddr set for ECMP
Date: Sun, 29 Mar 2026 11:12:01 +0200
Message-ID: <20260329091201.63646-1-maximilian@moehl.eu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z3+FHQUWGPd7b8fXdGtA7Wwgfb/EUDNKMRiSriR1HJoncjJE5fa
 QaHTT2m3vQk/B2AkLknxr4oti0HLWfZ9f1XU61Sx32TwMWXnHEyQf0BP+UKMMO/NyagERPR
 FEUngCrzTwXwPu4TimUoIqlK/sKCOlmktBsufsxjp/QRZuYyJQfvfVML5qtIGytyw9pXaKt
 C+ZbO8Ng5tWeW1+aFG34A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:46/8E3Vdst8=;v6Lp1ODk5dOHMOeC4S/OBhvCNnZ
 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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[moehl.eu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[moehl.eu:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272872-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maximilian@moehl.eu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[moehl.eu:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,moehl.eu:dkim,moehl.eu:mid,moehl.eu:email,moehl.eu:url]
X-Rspamd-Queue-Id: 6ACE83518F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When the routing decision involves ECMP, the initial hash is calculated
with saddr being :: and the decision which interface to select from an
ECMP group is based on that hash. If the route lookup has to be
repeated, e.g. because a route was updated, the hash is calculated with
saddr set to the previously selected address. This can cause the
selected interface to change, breaking ongoing connections.

To ensure the initial interface selection is based on an actual saddr
the route lookup is repeated after the source address selection if a
hash was calculated.

Signed-off-by: Maximilian Moehl <maximilian@moehl.eu>
Link: https://lore.kernel.org/all/aOYLRyIlc7XU7-7n@shredder/
=2D--
I've created a write-up of what I've done, including the steps taken
to test the patch: https://moehl.eu/blog/linux-ipv6-ecmp-instability.html

 net/ipv6/ip6_output.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 8e2a6b28cea7..465fce51d017 100644
=2D-- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1148,6 +1148,18 @@ static int ip6_dst_lookup_tail(struct net *net, con=
st struct sock *sk,
 			*dst =3D NULL;
 		}
=20
+		/* If ECMP was involved the initial hash was calculted
+		 * with saddr=3D:: which can result in instability
+		 * when it is later re-calculated with the selected
+		 * saddr. Lookup the route again with the chosen
+		 * saddr to get a stable result.
+		 */
+		if (fl6->mp_hash) {
+			fl6->mp_hash =3D 0;
+			dst_release(*dst);
+			*dst =3D NULL;
+		}
+
 		if (fl6->flowi6_oif)
 			flags |=3D RT6_LOOKUP_F_IFACE;
 	}

base-commit: dc9e9d61e301c087bcd990dbf2fa18ad3e2e1429
=2D-=20
2.53.0


