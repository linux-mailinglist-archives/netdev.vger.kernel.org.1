Return-Path: <netdev+bounces-298616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dTxEMWXyK2pHIQQAu9opvQ
	(envelope-from <netdev+bounces-298616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:49:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C70C16791B3
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:49:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=NzvM8dcU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298616-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298616-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07E973001055
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 11:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BE93E95A8;
	Fri, 12 Jun 2026 11:45:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B13E9584;
	Fri, 12 Jun 2026 11:45:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264726; cv=none; b=Hx8IS7VCAw6PwhzvllELl/g0YDu7a+4Wz0DJKMuIcPbD/Xl9jHvecQ7uSHPsD28J0afzfxulyVW01JBIL/Kxfk5Fc8oqX2mD92XOHrLyF2I23ALaXTOQiAZMBVGR5LoZuQqdGk8PGuPL9zxgVocqfk6vMBaZVYRAY3f7Kl9H+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264726; c=relaxed/simple;
	bh=nCgVbY6UHsUjmlT+EqGWCVqryxqymG+d3qln6pEdYkE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Niag6imlVhI2+uG5jK03uYn/krnsnxcuLABqhsbK46FrapV7J00eY+p0+C4Qd5lNxq9fncocJzmwi3wCUEei8DFXz1R7aC2AwogUukWejdT5TuTbzHa2+bw3ePm/MDw0hRFRJh9oHYmsmLoBPvoaKkGQHbtvJs0FPntPLy6I9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NzvM8dcU; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:From:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=3qTJD0mnlizmNPEYv3EQolBeBrKLlazkNdRNqGXV6b0=; b=NzvM8dcUVXBg5g0bZ9Y08sptj6
	AXcKHUMs0bMGfUwO0yPORNyu4gTw6K+EZ0wkC+u1d8br5D+Dw/H9T6D3jTby/f8cSg1lvAEj9pdNj
	H9znvanecVfp0d8/pgNGPnmg/7UcwAcFL7EA9e2ZSv+cYEJlIVoFHO+quMCt1bIqfFQAmWHI9rSf6
	y4D5M5xjsHjA6oCmoszE96zDiR34DyTnL6JgHiFh10WqS+Ez+6XcHSnZMJT+gEylcOMWj6cj5qJqb
	9io1JCRwbj11jR3AfBKeO6VeDEcBnjSrele9qLL1Bz4J3443vC68nB5S3bTtyTs2RO/iYCmrJOTNo
	PL8xBfGg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wY0K5-00Ai6b-2v;
	Fri, 12 Jun 2026 11:45:18 +0000
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH net-next 0/2] net: convert UDP getsockopt to sockopt_t
Date: Fri, 12 Jun 2026 04:45:04 -0700
Message-Id: <20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEHxK2oC/x3MYQrDIAwG0KuE73cFI2thXmWMITZrw0DFyCiU3
 n2wd4B3wqSrGCKd6PJV01oQiSdC3lPZxOmKSAg+LH5hdpsMq/lT23i1PZkEl9fbfU6eec4JE6F
 1eevxPx8oMlyRY+B5XT8Dr+BWbQAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2551; i=leitao@debian.org;
 h=from:subject:message-id; bh=nCgVbY6UHsUjmlT+EqGWCVqryxqymG+d3qln6pEdYkE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqK/FJB7apKe2UguSPraytt6CWHlw0dCpq4rfnW
 PybQai6i9+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaivxSQAKCRA1o5Of/Hh3
 bX4aD/4hcS1x/bj0ER+ca6/y9fTviMFVYWFAdSIQ8M1JQsY3D399k+SsjS4fVURvk9Wexe5DoVB
 WVGs7tJygyIkjJHoXZFpqlHKaWPBz4LkGRKdY9pSS86A3Qm3Kf1ncj7wBqgfBpFuCg2ny37mXiI
 NWqcVi6nioc7hi0QgB/StqulGUdxybus4pfMBr0AlGyv2/UKk7IZKYJQqD1DhGL03TXZmvNDC9W
 YUEMMOKEmns26AiM97fJXHFSigZXrQBfRMdf3x/wA/Yds2FjVqAM48E5cxW8SP5yQcK2uhpWVuy
 1EdhR6xuDYq4HT5YWGS1kuSadzeBW0Wqku6GxLgRi8XQ450hnoUOHZiCnMYya1k0nB2qJPmuuyA
 KAMXxNCFuMe0ruO5c0o/NhNSEqBFR3DX8XFCamj5THgfHXLgqHume8dOUDIMiCCsQBX7YDQm272
 CdlVmJjUbS8BcieO6BYqrEI4Kv9lL5JYvQGqwxytFKirx8ratOMQx/b3kwm+PE6Xox0ECXXrU86
 jGuuTWpPHTEMqRRb6QSHsl8YN6zsC9db8oWYmgTx2HTrhdTAzWWa9592QIN/0Q3Wz7LMOnl8WQc
 AwdYMLuD4HaiPdelnYKqV0Z3c3FWQ9rioDCCgaE9CAp5uvXDUZSG9HiYPvV5vStx6SGqMUwKKYV
 KFZf1Sunt4dkOyA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298616-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C70C16791B3

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
Breno Leitao (2):
      net: add sockopt_init_user() for getsockopt conversion
      udp: convert udp_lib_getsockopt to sockopt_t

 include/linux/net.h | 23 +++++++++++++++++++++++
 include/net/udp.h   |  2 +-
 net/ipv4/udp.c      | 40 ++++++++++++++++++++++++++--------------
 net/ipv6/udp.c      | 17 ++++++++++++++---
 4 files changed, 64 insertions(+), 18 deletions(-)
---
base-commit: c8459ee2fef502d6ef6c063751c33d9ac7943eab
change-id: 20260611-getsockopt_phase2-cd495a0115ca

Best regards,
-- 
Breno Leitao <leitao@debian.org>


