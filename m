Return-Path: <netdev+bounces-190264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30D7AB5F28
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4939D4A177A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F53B1FFC46;
	Tue, 13 May 2025 22:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf+RzKLD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFEC34545
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174400; cv=none; b=X2FHm+i+TbtFUJBLhEzndDvbRMC1N0drb3fh1Mb13EL14ltUJSykOfGLQSo2wxTYwQiDL9X43KDtJTXcLX49AYERoUYI1YRtzR2K0wNRghDUZtPjSwH/J4Os2NDqcsg+bmv6OFQNmUl2FwKSuNJcSEoKy9YgesXBQRcGjiUK9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174400; c=relaxed/simple;
	bh=zkUdi8cBOb2Hqdu6CygDKRF28BY66m3h46ngRxrtgyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sfRJxamgkj1u3+wHiEYZg/UKkSkF8f0xDnKyrn5y4nQJlYxE8PDCdyFwM86aefDf1XP3bTXGgOC/NjJdZ4eBbQP0ECzrG2m/SzX0ipKgxsS5EQf10IQHT+WXzFFYS8JvZPW7XcCw3p8u3BAWCByhML7mUfjAy1L6gQDNPWXoqqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf+RzKLD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96A64C4CEE4;
	Tue, 13 May 2025 22:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747174397;
	bh=zkUdi8cBOb2Hqdu6CygDKRF28BY66m3h46ngRxrtgyM=;
	h=From:To:Cc:Subject:Date:From;
	b=lf+RzKLDTt2iMyHteHFissFEBvjKp7Xjj063m0/bKlYvT58SZxqfwKAw1jl4RNFLk
	 jr8VHeRYf+GrtJ05Aj9jzugOwu1AFPsz2muK/wlNOVmOJg7RQPo4S+OxDFbMRQBHL9
	 cSFWaCAWLwx5COjyXQBo0JHeGhT15hnycSY/x2H9yLj/tLA+xl1uPaCiOSp+UGFERw
	 JAXF0u9ovGGvwW0uQa1CnRKlk3DG4Mx1SF+3SLps1nZwgu1R2HhKJLyvQzv3n5OYmC
	 5UmCYH3nVctpriywLNH9DzZj3wC/+vReerZH1x3vXHZieVEYK2Ad6NUSWKNPIeYSVX
	 JtMP7E0Nl2OXw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	xandfury@gmail.com
Subject: [PATCH net] netlink: specs: tc: fix a couple of attribute names
Date: Tue, 13 May 2025 15:13:16 -0700
Message-ID: <20250513221316.841700-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix up spelling of two attribute names. These are clearly typoes
and will prevent C codegen from working. Let's treat this as
a fix to get the correction into users' hands ASAP, and prevent
anyone depending on the wrong names.

Fixes: a1bcfde83669 ("doc/netlink/specs: Add a spec for tc")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: ast@fiberby.net
CC: xandfury@gmail.com
---
 Documentation/netlink/specs/tc.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index aacccea5dfe4..5e1ff04f51f2 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -2745,7 +2745,7 @@ protonum: 0
         type: u16
         byte-order: big-endian
       -
-        name: key-l2-tpv3-sid
+        name: key-l2tpv3-sid
         type: u32
         byte-order: big-endian
       -
@@ -3504,7 +3504,7 @@ protonum: 0
         name: rate64
         type: u64
       -
-        name: prate4
+        name: prate64
         type: u64
       -
         name: burst
-- 
2.49.0


