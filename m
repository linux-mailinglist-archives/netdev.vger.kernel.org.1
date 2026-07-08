Return-Path: <netdev+bounces-305785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +L1ICFA6Tmp0JQIAu9opvQ
	(envelope-from <netdev+bounces-305785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:53:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB5A7260B9
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 13:53:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=SHXb7tjA;
	dmarc=pass (policy=none) header.from=debian.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305785-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305785-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DBF4301372A
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 11:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70244438496;
	Wed,  8 Jul 2026 11:52:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C30436344;
	Wed,  8 Jul 2026 11:52:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511551; cv=none; b=hi3rQNsR9VX2FIJ3M0SI2RqIpMmTmOZBT+AhTOiLw2Dp4zOVWCnUAMmuurDPR2AFqjIcG+HKgS7bcQNbXtKoUYdTe8vBP+tMwkcNb14GdczzhqfK2qT4EYCd+hSWanVL8peOoI1CkPp8vW7NIje6dmrABKUgh3eGodN5eDXw8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511551; c=relaxed/simple;
	bh=1lyS9Nx33n+ZSOi2YYjJExVJzisWva/KLKQ3f/M0gIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ggT9OZvN0VztJKgssRcGYtET4gf9xgcBVY3jxFKQRyEwFLG8U09wkCJuh/R5lDATHRxwtZ4YqNDv4JeMs+RYxSV1DjHWeVlf3cITaV7dBImDa8VpGtcWsbwE3FEuIbDe60ytRMW+vKNz2JDst80yNrpldN9FMqTOzdV68Bp1VAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=SHXb7tjA; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=Mr2f81EJjHFA6kBs7MfF1UgCCOQVfR0N9htuSbb4qmM=; b=SHXb7tjAHbNrTPFDiZaHw40WF6
	U3N0CaiRhHSPluXxjUAtYRkCM1ZceYfAI9bpZIs9Rt6KT1+jYuQWX0DlzzUa+bhGNea5+59QcuIsS
	SQPY/mwfmW86BAjhAdWo+2uqBwLsFaOQMt4VWbINarEPN73Oj9lj8TQv7cqkNL4+Q5TjG/pFxLwLf
	tJbCD6ysbgUi0uYp+DvoLuTWG4ejH0yR2IAcmYkedzcMl5ax8uP8gfojO2uXUnPL6T+XUGEAg7NCN
	xmixMDmNBL4oIpbpufZvZtpL4f7j255wQ5YJfK+92qwbnR98JqNSELWEaPpodaZaePjzBPYlnTkOY
	ldGESgcA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whQpB-002veA-1b;
	Wed, 08 Jul 2026 11:52:21 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 08 Jul 2026 04:51:58 -0700
Subject: [PATCH net-next 1/2] nfc: llcp: widen getsockopt value locals to
 u32
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-getsockopt_phase3-v1-1-d8394f2fc554@debian.org>
References: <20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org>
In-Reply-To: <20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org>
To: David Heidelberg <david@ixit.cz>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sdf.kernel@gmail.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214; i=leitao@debian.org;
 h=from:subject:message-id; bh=1lyS9Nx33n+ZSOi2YYjJExVJzisWva/KLKQ3f/M0gIo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqTjnt89fGuUmtkpkr7URXrs6PzlHgBDr57qwJf
 YUTthISjRaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCak457QAKCRA1o5Of/Hh3
 bXAiD/9i7IsUtBlitclR8zay5jtrdzzq7Y95/+VmDY/zENaLls9ZRgSUGqMRECoqQx6HrhJ2SpT
 22OEShg6oJ777sAypCx0pENNm/L8RsVoZf3zI5olIOhuho8MtAn0vt0pdP7fNPGp6DjsesffSy5
 Gq6gcW/84lhOkDPryfNv2Z47DTIya8W3ecK2UG2YbuX1YiEW7CtXAp9g6Q42/9wQmwavzEa+/UL
 vcFNAoHKy5e3c8LLsLMet4BYAH/cw04vWiCfr/dU7qeM/3FJac15qN2K9+6gGRn60acnJqg2u85
 Hjxp/7H9LgmwT/xNPnNTMZ7JIeS3efajowBVsCF7mdEDhT8hUgAXuh8zdkkNpWC5eA9gf97OoDx
 hW06F76OTuyYSuDOl0MAAundvDnLxgc39Mf7f0prqKFzMg4Q2BqrmaXCNq+Aa7AiAfha2rKBp2f
 tfLP5OI8HOxkYkLKraghQk+ii9r0Ipln90Nv9oOtceF/l76RCfVfl6J1l2akVL0fX9v5396g5xF
 IIokDOb41noa/961BKD330FvRO1u5PU5/8cOjM/W1S71A9T/hG/UBkktesbAuk8Dc8ZvBcU5zWB
 7nRWC2txBp3aVglS1YhN/+IFfaZOojniQqV4wUk6h2IeEuu0vz/MxjYUZZBAgfAiF09VJ+OHrhp
 WHFZqBTwZ7bLekg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305785-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:david@ixit.cz,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:oe-linux-nfc@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sdf.kernel@gmail.com,m:leitao@debian.org,m:kernel-team@meta.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,debian.org,meta.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EB5A7260B9

nfc_llcp_getsockopt() returns each option as a u32 (written through a
(u32 __user *) cast), but the temporary variables are smaller than that,
and they are promoted at write side, example:

  u8 rw;
  put_user(rw, (u32 __user *) optval)

That is fine, but I want to widen the rw/miux/remote_miu locals from
u8/u16 to u32 so the following getsockopt_iter conversion can pass their
address to copy_to_iter(), which expects an object of the exact width.

No functional change.

PS: I am sending this as a separated patch to make sure this conversion
explictly reviewable.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/nfc/llcp_sock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 5558d8a4d48b3..94850fbe3620d 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -308,8 +308,7 @@ static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
 	int len, err = 0;
-	u16 miux, remote_miu;
-	u8 rw;
+	u32 miux, remote_miu, rw;
 
 	pr_debug("%p optname %d\n", sk, optname);
 

-- 
2.53.0-Meta


