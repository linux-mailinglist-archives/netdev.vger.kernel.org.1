Return-Path: <netdev+bounces-282067-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB1WNVgb8WnadQEAu9opvQ
	(envelope-from <netdev+bounces-282067-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:40:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F9848BDAA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 22:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 603B430055CE
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 20:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D74730B517;
	Tue, 28 Apr 2026 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQoM650a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA5C3090E2
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 20:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777408766; cv=none; b=XTOvGteqHsfA/jElLksppBeqGQKOrrWpU+NfxfFmHYMbgAMzEKFy2DlrL61gzNLc8o4f3GnbOzKF7wJFbOq+dyZgI8D2mZFe6vbyJidB2PRaQjbyETZMW6DovOUTbtyU6xzH7Vd3N4EKiYe7WYmcuz4APUkDd02lUfBxkxNS7g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777408766; c=relaxed/simple;
	bh=prmRY6/ckm5/oIfr0fuK/BDLwFlhbbWczIFYf2+dT7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pvsqStcJsJm7HBqAAj6K+KgYareRpSf3aD21H3ZPuOK19SD8xe+SCf7C3lkipnaiTpo1TtjVuNtC0jU1ivGcxDp8ehZlljX1ANOe2fin6VSNq7X3PfjtcIS7lwMFF5t9+OSAbn4RfBBBinM9Sn6rs3AJQ2W9qq+L72SAZVU4y/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQoM650a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E776C2BCAF;
	Tue, 28 Apr 2026 20:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777408766;
	bh=prmRY6/ckm5/oIfr0fuK/BDLwFlhbbWczIFYf2+dT7g=;
	h=From:To:Cc:Subject:Date:From;
	b=oQoM650ahjojqrOOazOqEUgwFK5ddBYVMBhHdREuegM9Z8TGTZpCndxsiQ1eve1q9
	 4vB88f0OKhapSkszaS3UTJdz+tCOi11k38PCt7FR3dSSM7UOLQdjy89zxkL5jCxTUx
	 kzoUHYM3z4bi1cE3cUHaFKmpIWDcSi6ZAgPTrRUy6jqPhiSBUJllRFXOhXdMN3WWSa
	 3BIdLDY2Niff5yoIIkmmGyUAd201QilVeUW0OHB2cSD1hryLxnWY224BfOcJCsgPmf
	 km8L87cyv49VpsgG53FRrfk2QDLrZRfL+n2wc/nK5uQwdVWdfB0ie2SJ2KIS6UOJV1
	 bwcy+7KSqkQvA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net] MAINTAINERS: update the IPv4/IPv6 entry and add Ido Schimmel
Date: Tue, 28 Apr 2026 13:39:24 -0700
Message-ID: <20260428203924.1229169-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D8F9848BDAA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282067-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email,paul-moore.com:email]

The IPv4/IPv6 and routing code is not very well separated from
the TCP/UDP code. Scope it down properly by providing a more
accurate file list, instead of net/ipv4/ and net/ipv6/

Now that the entry is more accurately representing layer 3
and routing merge in the nexthop entry into it.

Add Ido Schimmel as a co-maintainer, Ido's git history speaks
for itself.

Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 63 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..70663f4387dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18672,19 +18672,59 @@ F:	net/xfrm/
 F:	tools/testing/selftests/net/ipsec.c
 
 NETWORKING [IPv4/IPv6]
-M:	"David S. Miller" <davem@davemloft.net>
 M:	David Ahern <dsahern@kernel.org>
+M:	Ido Schimmel <idosch@nvidia.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
-F:	arch/x86/net/*
-F:	include/linux/ip.h
-F:	include/linux/ipv6*
+F:	Documentation/netlink/specs/rt-addr.yaml
+F:	Documentation/netlink/specs/rt-neigh.yaml
+F:	Documentation/netlink/specs/rt-route.yaml
+F:	Documentation/netlink/specs/rt-rule.yaml
+F:	include/linux/inetdevice.h
+F:	include/linux/mroute*
+F:	include/net/addrconf.h
+F:	include/net/arp.h
 F:	include/net/fib*
+F:	include/net/if_inet6.h
+F:	include/net/inetpeer.h
 F:	include/net/ip*
+F:	include/net/lwtunnel.h
+F:	include/net/ndisc.h
+F:	include/net/netns/nexthop.h
+F:	include/net/nexthop.h
 F:	include/net/route.h
-F:	net/ipv4/
-F:	net/ipv6/
+F:	include/uapi/linux/fib_rules.h
+F:	include/uapi/linux/in_route.h
+F:	include/uapi/linux/mroute*
+F:	include/uapi/linux/nexthop.h
+F:	net/core/fib*
+F:	net/core/lwtunnel.c
+F:	net/ipv4/arp.c
+F:	net/ipv4/devinet.c
+F:	net/ipv4/fib*
+F:	net/ipv4/icmp.c
+F:	net/ipv4/igmp.c
+F:	net/ipv4/inet_fragment.c
+F:	net/ipv4/inetpeer.c
+F:	net/ipv4/ip*
+F:	net/ipv4/metrics.c
+F:	net/ipv4/netlink.c
+F:	net/ipv4/nexthop.c
+F:	net/ipv4/route.c
+F:	net/ipv6/addr*
+F:	net/ipv6/anycast.c
+F:	net/ipv6/exthdrs.c
+F:	net/ipv6/exthdrs_core.c
+F:	net/ipv6/fib*
+F:	net/ipv6/icmp.c
+F:	net/ipv6/ip*
+F:	net/ipv6/mcast*
+F:	net/ipv6/ndisc.c
+F:	net/ipv6/output_core.c
+F:	net/ipv6/reassembly.c
+F:	net/ipv6/route.c
+F:	tools/testing/selftests/net/fib*
+F:	tools/testing/selftests/net/forwarding/
 
 NETWORKING [LABELED] (NetLabel, Labeled IPsec, SECMARK)
 M:	Paul Moore <paul@paul-moore.com>
@@ -18819,15 +18859,6 @@ F:	Documentation/networking/net_failover.rst
 F:	drivers/net/net_failover.c
 F:	include/net/net_failover.h
 
-NEXTHOP
-M:	David Ahern <dsahern@kernel.org>
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	include/net/netns/nexthop.h
-F:	include/net/nexthop.h
-F:	include/uapi/linux/nexthop.h
-F:	net/ipv4/nexthop.c
-
 NFC SUBSYSTEM
 L:	netdev@vger.kernel.org
 S:	Orphan
-- 
2.54.0


