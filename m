Return-Path: <netdev+bounces-200846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E4EAE7158
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B60561BC34BE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B62925B2ED;
	Tue, 24 Jun 2025 21:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBu6rYWi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3025B1F7
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750799412; cv=none; b=ZpmEXrVhS1xglMMEqSXR8dTeI/HtH2rttEqLYGB6lr3YTmRmts1R/a75LrXKo6qMpl538QpIAPnQOC8gfkWWHSUgMgKT2ofRxn3iksm6bV3WYsoY5hiB0GPR82M+CUv5Afy4E3qF0ohSrgoZV9BoEQpKKqaRbntOJwcPNct8yK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750799412; c=relaxed/simple;
	bh=rPMG2c2Ii3q59bj5WR1UK1xFHgDR8Fp6n6qjSMlKl2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdzfl5bNQjrBKRRxh29SbtdTX1Oz0irjq2W+Z7MyrASxui40VbhbqBdrhjDLJOywBooUd3f6FszpODAG2S869GsTR5x11J9Oq+qgLvStZCtomFMTL0aXSYwUjZrl4XLVEoufGZa4xzh8wjI2tzo95Ou4zVoTSIlWhY5E2/FSEwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBu6rYWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0FF2C4CEF0;
	Tue, 24 Jun 2025 21:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750799412;
	bh=rPMG2c2Ii3q59bj5WR1UK1xFHgDR8Fp6n6qjSMlKl2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBu6rYWin/0mjB6OOrpP+qDaprwha3LJNew+XXT8nb2e9M1WBZhZz9G0UN+clpW75
	 AmljjhAPgW9uATnBuM8HlWfJBoyF/0wk/hl6zHyKssvKUxFdkdVp0t4i7DNNlJi/KZ
	 vJa98KSvUOQFzoIFs7zxvzR3E7LWCJjI5HR1mCk7dJuw8F/skZ1JjT2yORFISjPZld
	 rsVxEmvNqpCqt1Xq8dnF2adQyScPWJAxX9vP86/gHiKcijH8ZynXbXPtza3cxNWXgf
	 y7uS93k9JpXvGtxURugAnwTMxOcsd/whM+XlJmYM0J1H0IYls+UbBKIGSHZZ7dxhHC
	 SnLVBNXbMgLiw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	ast@fiberby.net
Subject: [PATCH net 09/10] netlink: specs: tc: replace underscores with dashes in names
Date: Tue, 24 Jun 2025 14:10:01 -0700
Message-ID: <20250624211002.3475021-10-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624211002.3475021-1-kuba@kernel.org>
References: <20250624211002.3475021-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're trying to add a strict regexp for the name format in the spec.
Underscores will not be allowed, dashes should be used instead.
This makes no difference to C (codegen, if used, replaces special
chars in names) but it gives more uniform naming in Python.

Fixes: a1bcfde83669 ("doc/netlink/specs: Add a spec for tc")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: donald.hunter@gmail.com
CC: ast@fiberby.net
---
 Documentation/netlink/specs/tc.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index cb7ea7d62e56..42d74c9aeb54 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -232,7 +232,7 @@ protonum: 0
         type: u8
         doc: log(P_max / (qth-max - qth-min))
       -
-        name: Scell_log
+        name: Scell-log
         type: u8
         doc: cell size for idle damping
       -
@@ -253,7 +253,7 @@ protonum: 0
         name: DPs
         type: u32
       -
-        name: def_DP
+        name: def-DP
         type: u32
       -
         name: grio
-- 
2.49.0


