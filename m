Return-Path: <netdev+bounces-284861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WP3CCpZK+2nWYwMAu9opvQ
	(envelope-from <netdev+bounces-284861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:05:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1BD4DBA48
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD9DF302835B
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7E84657E7;
	Wed,  6 May 2026 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b="aCMt9iWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.cs.msu.ru (mx.cs.msu.ru [188.44.42.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8173F166B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.44.42.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076174; cv=none; b=ftEHQKGyHVHZxjQKFnpmQSOMHKj3Cxgk7+nMpx8sTxQp0R38cw5sf6rIGmvtWg+wZGu6yVNLlN+gDfdyQ8YPAagQQCDMV1mttRtRZbfB/RawPhvWW4mKG9Bp3LvkpFqMCjYCYvvjYoyy4uO+ik6oD9cV08Ib1+hZXyK87/d+nvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076174; c=relaxed/simple;
	bh=3+I9g2GacJAYVbzLCm2XRpwJoxjeFLkwQVctsClDQDI=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=Y844IawNybmvcs8NSWGA8nJO1AwLOxGbcU73fTm4R4mX/HsC79UqEhJXaNu1QvtpeG4a7x/p4U+vZvRGfdhQ70eyj7+g9e94VqG+MXppxMXKOZmC60KOLKhFYdxePk/CzzZAGcco8jcHixm66RDwCB0KXk3h1OdoKP7A8Df6X+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.msu.ru; spf=pass smtp.mailfrom=cs.msu.ru; dkim=pass (2048-bit key) header.d=cs.msu.ru header.i=@cs.msu.ru header.b=aCMt9iWY; arc=none smtp.client-ip=188.44.42.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.msu.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.msu.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cs.msu.ru;
	s=dkim; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Cc:
	To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=NDpdp1h3C4gZFDZelq6sqmqjQ3WCxUXFugDtYEgl7So=; b=aCMt9iWY/grzA0DHfBTbBNDYhv
	qMvJNrVu+WDq3l7HoxG69dLfcW3/gVwj9S1FsGWX44/l5tCF5UjQcsz/9eyew07aSVpWTb+38NPIO
	coFhkUFbbi316uJXBVs6eHy458yla5vflmbWNl4TMHnBpuNuUzIBlSM2oaZvqUQXbeMaV07iTccVB
	u/vP9Muqa3jjl6H2luQ+5h6FPf19qhcWiddF+7YnAt3OyVWN93DMTFoyttwv3YHq2MkyZHbRK+qNO
	5bClq3qpj8P+TNB2RibV6F7PiMM9VVZBl9M3wzX1rkxUZfIkFr5JzgFKqFbDxN2pkmcmk6JkBUWH0
	M7nm+LLw==;
Received: from [37.204.126.93] (port=33078 helo=cello.practicum.cs.msu.su)
	by mail.cs.msu.ru with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98 (FreeBSD))
	(envelope-from <ar@cs.msu.ru>)
	id 1wKcpj-00000000ElO-3lBR;
	Wed, 06 May 2026 17:02:42 +0300
From: Arseny Maslennikov <ar@cs.msu.ru>
To: netdev@vger.kernel.org
Cc: Arseny Maslennikov <ar@cs.msu.ru>
Date: Tue,  5 May 2026 22:36:39 +0300
Message-ID: <20260505193643.2813743-1-ar@cs.msu.ru>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 37.204.126.93
X-SA-Exim-Mail-From: ar@cs.msu.ru
Subject: [PATCH iproute2-next] ipaddress.c: do not show address priority in brief mode
X-SA-Exim-Version: 4.2.1
X-SA-Exim-Scanned: No (on mail.cs.msu.ru); Unknown failure
X-Rspamd-Queue-Id: BC1BD4DBA48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[cs.msu.ru : SPF not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[cs.msu.ru:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284861-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cs.msu.ru:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ar@cs.msu.ru,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.892];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cs.msu.ru:mid]

Otherwise, the following output is possible:

  % ip -br a
  lo               UNKNOWN    127.0.0.1/8 ::1/128
  enp7s0           UP         10.5.0.9/16 metric 1024 fe80::546f:33ff:fee1:9/64 2001:db8:0:a:546f:33ff:fee1:9/64

This was observed on a machine with systemd-networkd stable 258.5 active.

The point of `ip -brief a` is to provide basic information about addresses
easily processed by awk(1) and the like. Consumers of its output have come
to expect $3 and further fields to be a space-separated list of addresses.
The above output breaks this expectation. While a human reader may
distinguish "metric" and "1024" from an address/prefixlen pair, existing
scripts won't.

Fixes: 78d04c7b27cf ("ipaddress: Add support for address metric")
Signed-off-by: Arseny Maslennikov <ar@cs.msu.ru>
---
 ip/ipaddress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/ipaddress.c b/ip/ipaddress.c
index 4d93a04a..80070a1a 100644
--- a/ip/ipaddress.c
+++ b/ip/ipaddress.c
@@ -1636,7 +1636,7 @@ int print_addrinfo(struct nlmsghdr *n, void *arg)
 		}
 		print_int(PRINT_ANY, "prefixlen", "/%d ", ifa->ifa_prefixlen);
 
-		if (rta_tb[IFA_RT_PRIORITY])
+		if (!brief && rta_tb[IFA_RT_PRIORITY])
 			print_uint(PRINT_ANY, "metric", "metric %u ",
 				   rta_getattr_u32(rta_tb[IFA_RT_PRIORITY]));
 	}
-- 
2.50.1


