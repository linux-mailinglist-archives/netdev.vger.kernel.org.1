Return-Path: <netdev+bounces-169808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EA5A45CAE
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 12:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 821DA1612C6
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 11:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2988B1A7044;
	Wed, 26 Feb 2025 11:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plK2QdQz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35B71A3169;
	Wed, 26 Feb 2025 11:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740568154; cv=none; b=AhodpCiclRpapqsaQxKu9qMdoPJy51dYpb50gjZS23McN67qjR/Y9C8TU5cCFlsGiOQR3i79QP6Gi3/nN07kw8aG4Vc7siHB7WagS673LBCzy/oqxDXr5eg7FTuYcW/Pt+b8b50yx28TDjKLSaHPqw4NVVW/OSgYboSWHXcrnhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740568154; c=relaxed/simple;
	bh=qnEajDHUCwepEGAUFAsAhm2JRjPjHQTxGeTJmktbUQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bvABItC9vIn4DvFCkCCYVfY5R1EFmzc/VEl7CNbWZACasvcyiET0nd+A7zsXnBuILnTWCZ1fqbKloAdCnTiZebdz5Cvgv9KPNlwhil25Tc3pBqJKvzlm1wM5RqpNxxShpcjqHDDKbxxCJlJbqmzTLIoHjhvbSLGWbwFJs6gKQcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plK2QdQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DCCC4CED6;
	Wed, 26 Feb 2025 11:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740568153;
	bh=qnEajDHUCwepEGAUFAsAhm2JRjPjHQTxGeTJmktbUQU=;
	h=From:Date:Subject:To:Cc:From;
	b=plK2QdQzO4TepCVaZRV67MmLZmhLSnJ/wVt2sxfAE2fs3jdJJM+lwu90rg/H5O/qF
	 BnARmUkCh+1s8HJ9cvuKafRG6RI6jlvdxIB+QdTovRyakWeDIresrh5Cu9Lp/KXPlz
	 ck66DnmOKcU/KpfZi0oTvaYnu0AZrZzJ7z9XglBq9i9o4XsvIOe8Cg/ONhKalWaeps
	 kBJiH0vUNZzznHLIiAv21ygJBQ5kU3WbrYRRq1WdF1gz4CmOk39vEOoMhG0pU5T+HQ
	 MavqFyN5P0OjlH6VUV0r5rC09T4nctmJenwBqqwOCisgmuU5Q3wcqpyo+zeL+uV9iT
	 mHtR3rucle3Yg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 26 Feb 2025 12:08:44 +0100
Subject: [PATCH iproute2-net] ss: mptcp: subflow: display seq counters as
 decimal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-iproute2-net-ss-ulp-mptcp-dec-v1-1-4f4177cff217@kernel.org>
X-B4-Tracking: v=1; b=H4sIADv2vmcC/03MQQrCQAxG4auUrA1Mg5bqVcRFmf6tAZ2GyVSE0
 rs7uOryW7y3kSMrnG7NRhkfdV1SRXtqKD6HNIN1rCYJcgkiHavlZS0QTijszuvL+G0lGo+IfJU
 +tOjPQ+wmqg/LmPT7/9/pmNJj33/3X7/CfQAAAA==
X-Change-ID: 20250226-iproute2-net-ss-ulp-mptcp-dec-92801e84ac6f
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org, 
 MPTCP Upstream <mptcp@lists.linux.dev>, 
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 Davide Caratti <dcaratti@redhat.com>, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=qnEajDHUCwepEGAUFAsAhm2JRjPjHQTxGeTJmktbUQU=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBnvvZX4Tm35bn+k5BpmIVjATYzUmH+7O6twqIq9
 elsqT8LigqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZ772VwAKCRD2t4JPQmmg
 c+LiD/0Y0+aa7wN6uC3Q6wHxo6bVeI866pnCfczScd7etqp8SIByUTslHiqD7CIlJjeMJJmIdxb
 aUWvFBv5jPj0igYXVu/lgWaMfFXvE5onYZSo83nFmCFnWX7iZzbmWl1Aedju+kz+maW9oNnU7Ha
 W8sXcxeAB/Pm5n3pXgXJOy+IvLQszqqbmqu5fjMBg5UgcYC8vbG+tA+bDgASUpVMglfq4w5VZN3
 hW9Ep/hi1gbqDKebr6g7nzzp6w5SqmridSCehaarhDUCafqcT8qCSF6XLKKGgLVLXFjYAW/WKY5
 3ACk39w918V3CRwTekzXqy3e/BFJ3JqZQmoR96ZmS004cpbTxwkH7GSzlnb7tifUNzDFmiIzjrC
 hOQ/HIoIwxpcKjaiYkszZOsyTWany6+zPpb4fXoooaCvLB0ZL39pMSu7poQ2D5AzsHzXLBXNf0P
 gjt9/bHQL/mNbZtVpVUu8Nwp7frSU/YvfvkabGH7jV6SNRREjTMszTEWNpsm+GNQCeZMY2PgAsi
 uwVLjLWDVnFvPWaz4FUyXFtxjikQTN03CZNzhU1BI44fsWdpENdnb1D2vIkd3Y8PFjY9hT6X4wS
 ci1Foqr+Cy7fGeg0/DtK7p7+RPnTTM4I8CxEGY/2o/lpQWeCV+zAQGnRGiex4Ftbj3BwZNnoz5T
 EWom8sTW7839jFw==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

This is similar to commit cfa70237 ("ss: mptcp: display seq related
counters as decimal") but for the subflow info this time. This is also
aligned with what is printed for TCP sockets.

That looks better to do the same with the subflow info (ss -ti), to
compare with the MPTCP info (ss -Mi), or for those who want to easily
count how many bytes have been exchanged between two runs without having
to think in hexa.

Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 misc/ss.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index aef1a714b130900d6f3061c150639235c1eb13ca..6d5976501467842b1681d7dfc1ca56cc1b4a98d5 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3055,16 +3055,16 @@ static void mptcp_subflow_info(struct rtattr *tb[])
 		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_TOKEN_LOC]),
 		    rta_getattr_u8(tb[MPTCP_SUBFLOW_ATTR_ID_LOC]));
 	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ])
-		out(" seq:%llx",
+		out(" seq:%llu",
 		    rta_getattr_u64(tb[MPTCP_SUBFLOW_ATTR_MAP_SEQ]));
 	if (tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ])
-		out(" sfseq:%x",
+		out(" sfseq:%u",
 		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_MAP_SFSEQ]));
 	if (tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET])
-		out(" ssnoff:%x",
+		out(" ssnoff:%u",
 		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_SSN_OFFSET]));
 	if (tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN])
-		out(" maplen:%x",
+		out(" maplen:%u",
 		    rta_getattr_u32(tb[MPTCP_SUBFLOW_ATTR_MAP_DATALEN]));
 }
 

---
base-commit: 48717184ba3700938b75542046c5108b21e95ea7
change-id: 20250226-iproute2-net-ss-ulp-mptcp-dec-92801e84ac6f

Best regards,
-- 
Matthieu Baerts (NGI0) <matttbe@kernel.org>


