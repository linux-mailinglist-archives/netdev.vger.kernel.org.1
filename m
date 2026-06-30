Return-Path: <netdev+bounces-303202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gEocEybNQ2o4igoAu9opvQ
	(envelope-from <netdev+bounces-303202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:05:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B53966E534F
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 16:05:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=tcnMLnZo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303202-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303202-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF6F230E9DB4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 14:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B6F32C957;
	Tue, 30 Jun 2026 14:01:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E98317A2E8;
	Tue, 30 Jun 2026 14:01:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782828111; cv=none; b=gqBwkSBAajWM8SSZsnpJ4nqBTX6Nfcf76+YgoQeEtH+oOI/4wsn2l6KQzQICkrhMdpoWfbl2+HvJby+xqnNErcBLAUP63YOiGd7sXsH7mx20NMxbWv7Q2aF2jt0M0Umv/kLZncck6i5d8SWaoSpSaBXvzAduXySslAdsdwW84vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782828111; c=relaxed/simple;
	bh=pqnDmfpozQdLF8X8/+ihJJg8y6+oqORe18JZB+lF7Sk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CkFh0x8t22wjd3jk8BZIMCMxiKxplfShd3KlFalNByYHvTAVqPuMrEOLO3ej87leis0AN/nYatqposs36FXPDUzEDwuP2WrcxOFGiEuiBr52GBeNsKupOVNplDXTs4ZU2CUWz86EFvKzUsvcMgNeCGdzwmNDU8DZ2FDKfIQwA5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=tcnMLnZo; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Ca/FumOWBkJcXOWzWEakZyxu696nHwSgTRatAghd7bM=; b=tcnMLnZo1zT2w98/2Lv+/WI0sm
	g2HxXI+ZnW4lw/6rVjS9TJIP5QOaREBZk0cQuV6+2fespMblZ71N4tIMcR7yFnZ25gjPB5B1rllAI
	ByQWyYDbyTR8EnOiakV82H6Q+0se5fbxaF2lngaOqJpwK6X3ehAATjvhfk5H39q+Hb9vAemPSkC3P
	1wgKp4cn4NPK7OsDa8AzvvzV96gTtyin8Rp17uKkdLNVYGyXTr4/5DbPLD8wAHuj5KBVJ7Fs6dqrj
	i9f/KQORUclRzxjb2sZwZhxqf7y7rQA0SmLj+mJCuZhnUMKEWmWrmTB8+tgTCN+o/C5s0JMmvAJb2
	FTFlgYoQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1weZ20-0077Hy-1z;
	Tue, 30 Jun 2026 14:01:45 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next v2 0/4] net: convert UDP getsockopt to sockopt_t
Date: Tue, 30 Jun 2026 07:01:25 -0700
Message-Id: <20260630-getsockopt_phase2-v2-0-193335f3d4d1@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADXMQ2oC/23NQQrDIBBA0avIrGNxpLE0q96jhGJ0kgwFDSqSE
 nL3gnTZ9Yf3D8iUmDIM4oBElTPHAIPQnQC32rCQZA+DAK20UQZRLlRydO+4lde22kxaOn+991Y
 h9s5CJ2BLNPPezCcEKjLQXmDsBKycS0yfNqvY+s/Vf9yKUsnbpHDGufeozMPTxDZcYlpgPM/zC
 +00dPK9AAAA
X-Change-ID: 20260611-getsockopt_phase2-cd495a0115ca
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, sdf.kernel@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3168; i=leitao@debian.org;
 h=from:subject:message-id; bh=pqnDmfpozQdLF8X8/+ihJJg8y6+oqORe18JZB+lF7Sk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqQ8xERMBLGdeZMILVm3ay3dia6rPwvBwoBMDLk
 w2GOpG7MT2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCakPMRAAKCRA1o5Of/Hh3
 beIiD/wKZ/JZU554uvDXqBEL/LW39HuLgqfAlvGd4S/ktwXjLN3GCNBWfxpIAd8a3kyk2KRVODF
 7TKA+12x5XOkzmjzfBMY/Fs4LHTQTIrXAtnq5VTv50VnYXY9hqVYsqR3/ggbKwHrLQaYS752uAo
 wmlMjaeXowPvZuz/ZGrUfJy2xdP80EkaQ7wcJtjuF40R38RKsS22R4QxX9iZuHsJbIKWVi8Qk15
 j2Qk7MC6t3AL3/4Fcy2/Owyunnul6+RcPHlRaoOrmHqqiGWaGi13mbcfI9A9cVmCU8GpZdAJVNa
 GyeggOq+OSbwCKOtQXeDmjNupzBFuJ0f8POn8kn2auQb5Z54RT3DNQ0htsBRlwWPMGGK/exGIp/
 YraS6caKEJ5VekRSNuMxGkMvig3f972dzQBffP08L8MjlPj+vBOxwTilRLK1eKvWzBNdHvHr6Vw
 /quarvSoatGA+hHQoV7aNtkp78wZDQsK2MEK/h/Vh/uz3j4dQHkHGOD1tRxN7WrQNI/V3nkNWQ1
 vn+VjtJQHwEICuSvHNA5Du6ned2Qtpjg+vUm8WY8bMIK7VjL5SObpvD13rLFhndpsyeSa90X3Mk
 kJJKwVdW6FGfp805MJ/WK9GXWe4JaY/BDSx6h8c2mXl1LAtDFlObIrI0fy/aJo/t2OzmjIL1zbD
 AEZX+PIrySSFY/g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303202-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:sdf.kernel@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:leitao@debian.org,m:kernel-team@meta.com,m:willemdebruijnkernel@gmail.com,m:sdfkernel@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B53966E534F

The leaf proto_ops getsockopt callbacks have been moving to the new
getsockopt_iter()/sockopt_t interface.

I was trying to get SMC into getsockop and retire .getsockopt, but,
I found the best approach is to keep converting other protocols.

This series starts the same conversion one layer down, at the struct proto
getsockopt path, beginning with UDP.

Example of the current code.

	static int udp_getsockopt(struct sock *sk, int level, int optname,
				char __user *optval, int __user *optlen)
	{
		if (level == SOL_UDP)
			return udp_lib_getsockopt(sk, level, optname, optval, optlen);
		return ip_getsockopt(sk, level, optname, optval, optlen);
	}

We want udp_getsockopt to go to .getsockopt_iter, and there are two
approaches in this case:

1) Create a patchset that moves both of them to getsockopt_iter, which
   is will be a huge change (ip_getsockopt() is used in many places)

2) Break this down, and transform from bottoms up. First
   udp_lib_getsockopt() up to the point we can easily convert
   others, such as ip_getsockopt().

I am taking the approach 2), so, the intermediate code will be something
like:

static int udp_getsockopt(struct sock *sk, int level, int optname,
                          char __user *optval, int __user *optlen)
{
        sockopt_t opt;
        int err;

        if (level != SOL_UDP)
                return ip_getsockopt(sk, level, optname, optval, optlen);

	// Convert optlen/optval in sockopt // (first patch)

        err = udp_lib_getsockopt(sk, level, optname, &opt);
}

The work is bottom-up and mergeable in small steps: a protocol's inner
getsockopt helper is switched to sockopt_t behind its existing thin
__user wrapper, one patch at a time.

Once every inner helper speaks sockopt_t, a later series flips the shared
struct proto.getsockopt and inet_connection_sock_af_ops.getsockopt signatures
and drops the transitional wrappers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Check for invalid `len` at call site (Stanlislav)
- Do not rewrite `optlen` on error path (Sashiko)
- Converted ipv4 raw
- Expanded the selftest to test this new helper.
- Link to v1: https://lore.kernel.org/r/20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org

---
Breno Leitao (4):
      net: add sockopt_init_user() for getsockopt conversion
      udp: convert udp_lib_getsockopt to sockopt_t
      ipv4: raw: convert do_raw_getsockopt to sockopt_t
      selftests: net: getsockopt_iter: add raw ICMP_FILTER coverage

 include/linux/net.h                           | 23 +++++++
 include/net/udp.h                             |  2 +-
 net/ipv4/raw.c                                | 41 ++++++-----
 net/ipv4/udp.c                                | 39 ++++++++---
 net/ipv6/udp.c                                | 19 +++++-
 tools/testing/selftests/net/getsockopt_iter.c | 97 +++++++++++++++++++++++++++
 6 files changed, 191 insertions(+), 30 deletions(-)
---
base-commit: c8459ee2fef502d6ef6c063751c33d9ac7943eab
change-id: 20260611-getsockopt_phase2-cd495a0115ca

Best regards,
-- 
Breno Leitao <leitao@debian.org>


