Return-Path: <netdev+bounces-287073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XY9JBasBA2pczgEAu9opvQ
	(envelope-from <netdev+bounces-287073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:32:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6613D51E9CB
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C37BF303A924
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2042B349CEE;
	Tue, 12 May 2026 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etehtsea.me header.i=@etehtsea.me header.b="ZK8m8et+"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2007f-snip4-2.eps.apple.com [57.103.84.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81679395AFC
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778581884; cv=none; b=BMt9Oub7I4w6aOCWjN/8hGf8L+KMa0odyiLKMQifGq7peNgJRBrpeSHpp7FGnrjXRJrDgy53kxjxAICWKRKiNJQCfkWAgdWKKeRqj4vXl2pQlWHpBibxdaoUA3ns7UCeXFjQ0IYI2b3016rGW7i8WCMY1hFt3WWgYRGg6Pzz2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778581884; c=relaxed/simple;
	bh=PLsBuyVUT1+9K3ZI+4TzkYnlpJGN+OjGY1s5cTT6hxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=higopWLA0coI9YmJTVh+g6cMDjcoZtN/GFa77FqkcVYkwtY6jz8GK0y947qxHzgYXpXYvOk5F9IJ1hsAQB6JeYayt5nVfu7aNcVmfQeMp4ns2jd1ufgIDL7exjzdxWu/nh5+b2HGKZuqoQcWr3anxuHnGTYngoK+Q1Fq7KtP4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etehtsea.me; spf=pass smtp.mailfrom=etehtsea.me; dkim=pass (2048-bit key) header.d=etehtsea.me header.i=@etehtsea.me header.b=ZK8m8et+; arc=none smtp.client-ip=57.103.84.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etehtsea.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etehtsea.me
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id 1A89B1800159;
	Tue, 12 May 2026 10:31:17 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5AHVwDWxxBAFYHXxcOVk1UGVoBdw5GFVEMQAhWRV8VGR5XUFoKWxx5HUcIXx9BFVhWXggXGVFNCEkTBVIHXU1WDUcPWB5cFBcJQENeCF4fTBwdDlgGEgBNCg42BlkFXglWA0MFNhIUXUVWGVIDRgNcGR0AUktfGV1FD18HWQRADEkBXAdYA0AIVgJdAF0DRwpVAkBaClsceR1HCF8fQRVYVl4ICUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etehtsea.me; s=sig1; t=1778581881; x=1781173881; bh=LBAQC4Sn+2TwAckVef00JukmOky6tMRvYvv/CRHAIMY=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=ZK8m8et+ycglmE+lh00qy+ONQcKUq+16kI+MAtp/bq+mBUgUlCU8/PgnMUxHWRONP0J5VmAH/W2GpIVwN4SLY1+sDxZRQbYvHvfdNxBsHHHVTTqDMyWlh34LG6ub8bZCe5dDiX/xY9vxakVL7xrh6PlPlehvqLz5QhPyYIX+gPgbJ5GLo6F5A6LEhMRSK9NMhdcmOx/ZmwBFGA+f/zanTzdkL6H0BK+GrV5hu3/xwLdCNeCsmhX1E5wEjhY4oRKVcv2wxb3TH+u9OO/AZVk7VHqS4SGhvXavk6PlUeqUi8fhcihCEB/MW63ZLrc6kY+b+HTMAzMg63x717V6o0qRQQ==
mail-alias-created-date: 1634905887181
Received: from localhost (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id 9D0701800134;
	Tue, 12 May 2026 10:31:16 +0000 (UTC)
From: Konstantin Shabanov <mail@etehtsea.me>
To: linux-doc@vger.kernel.org
Cc: Konstantin Shabanov <mail@etehtsea.me>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: netlink: Correct buffer sizing info
Date: Tue, 12 May 2026 17:30:53 +0700
Message-ID: <20260512103101.1076173-1-mail@etehtsea.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=aKX9aL9m c=1 sm=1 tr=0 ts=6a030177
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=ghC8wwoHDixrMWJZ6csA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDEwOCBTYWx0ZWRfX9jxyYVDwt3iz
 BeKq2Sjv3CN0Sh7FwcTBKnmgdUd6T2qMYzmgPHEwMJ/0ulyogUyCgFSVUjtEeBVr26gmF+axtr5
 alcxa6eXdmN/GAzNSmB6VEIFqmPfBcEAj81YcLH77abuRseuHXNLjXYzgBSjZR6JjGFGRW258cM
 9+Zh0Xylb449iZIkfnUVnQ1PIbH8z7OwQ+Ww3KFYKzIC4/OYnjs4w12c69gspBSz8FCAtyMVMqr
 sD2xeamwa0PgCQQHSVeeH0/tHBuHaLt1+sSdmS7orCo5AFVnDuiPbYiPE4uJBg/pk6iSOCNLDi2
 coVbvCxPpqOdGqH9K8d6uoTuJkL151n1rgqsCZ/YgORchu40F7o65AlGN7lGrQ=
X-Proofpoint-ORIG-GUID: yxi057uWUid0oBFw4GkAAHDbB15BQrkh
X-Proofpoint-GUID: yxi057uWUid0oBFw4GkAAHDbB15BQrkh
X-Rspamd-Queue-Id: 6613D51E9CB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[etehtsea.me:s=sig1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287073-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[etehtsea.me];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etehtsea.me:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mail@etehtsea.me,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,etehtsea.me:email,etehtsea.me:mid,etehtsea.me:dkim]
X-Rspamd-Action: no action

Update the docs to match the code (include/linux/netlink.h):

  /*
   *	skb should fit one page. This choice is good for headerless malloc.
   *	But we should limit to 8K so that userspace does not have to
   *	use enormous buffer sizes on recvmsg() calls just to avoid
   *	MSG_TRUNC when PAGE_SIZE is very large.
  */
  #if PAGE_SIZE < 8192UL
  #define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(PAGE_SIZE)
  #else
  #define NLMSG_GOODSIZE	SKB_WITH_OVERHEAD(8192UL)
  #endif

Link: https://lore.kernel.org/all/20220819200221.422801-2-kuba@kernel.org/
Signed-off-by: Konstantin Shabanov <mail@etehtsea.me>
---
 Documentation/userspace-api/netlink/intro.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/netlink/intro.rst b/Documentation/userspace-api/netlink/intro.rst
index aacffade8f84..ca60abe94e3d 100644
--- a/Documentation/userspace-api/netlink/intro.rst
+++ b/Documentation/userspace-api/netlink/intro.rst
@@ -526,8 +526,8 @@ of the recvmsg() system call, *not* a Netlink header).
 
 Upon truncation the remaining part of the message is discarded.
 
-Netlink expects that the user buffer will be at least 8kB or a page
-size of the CPU architecture, whichever is bigger. Particular Netlink
+Netlink expects that the user buffer will be at most 8kB or a page
+size of the CPU architecture, whichever is smaller. Particular Netlink
 families may, however, require a larger buffer. 32kB buffer is recommended
 for most efficient handling of dumps (larger buffer fits more dumped
 objects and therefore fewer recvmsg() calls are needed).

base-commit: 917719c412c48687d4a176965d1fa35320ec457c
-- 
2.53.0


