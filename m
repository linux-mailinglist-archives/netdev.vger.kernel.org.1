Return-Path: <netdev+bounces-185822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4852A9BCF8
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E07E1BA08E4
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEB815B543;
	Fri, 25 Apr 2025 02:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDNpjffH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A3158520
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549004; cv=none; b=UElG532CUbDlWrM6e9ECMug3aGlI0Lx93kxGyQoRMcgWajfC4cjyxtHtBGRmJSGHm6JXQ6JWHMBz/WVJ8MGiSPF7ELDEJklKZxuSBanwhwbLSoddi8ZlOWwr+1jvxGatgmsTzOhMKk7fpguXlxLuIqQPJAeftU2m3rPyriXfeYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549004; c=relaxed/simple;
	bh=cRS/E+u6bOcYOSlf93XnkfirTwUeFy/yhRKG46h2O5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0zGZcoNzrKIMlnQLp7782Q+js2cnfUwuVbXsqokzRBAi9ZxyzO6ayhRsiZo2vIE6M5ZkcFmZ8dYVE3ZtHZxBaZTtVvweX5bkWMbvYCzCaiNbHzr2kLqDyQun0ZKMqDE32H5Le6sC1YMiuRuyYhcwF21IVFqc9oc1FkzkBNYoV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDNpjffH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C051C4CEED;
	Fri, 25 Apr 2025 02:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549003;
	bh=cRS/E+u6bOcYOSlf93XnkfirTwUeFy/yhRKG46h2O5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDNpjffHrujcJFSLXmpy9AnJMW10TiJYjph72g8REOw1Il5FORpSgPNmFU1mp+cIC
	 X1cUj5hboUHl8Ot/es06qBo4SQROTcbeE091PajmmpRWZFcQiagyMxgIFO7VUQc5er
	 7U9uwkcYWSHOFoH6a7rFT6FcR0Egh+1PrDvhWc1kHETqYtHrJXKIwUlSSupatAdXgj
	 vPYAB1bUT18suT9SODOIHQ/dzNH2kRcE+wmF6ROMOvf8B3j7IAouipxt/ZWzxH2L0C
	 3VZVLUYQsrcnxEVJ9XJ7LUubbFneba5aWULriVp7mSZQiGc2i/yHS2i0nWrSgB809d
	 FOY9QoI/gANLg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 01/12] tools: ynl-gen: fix comment about nested struct dict
Date: Thu, 24 Apr 2025 19:43:00 -0700
Message-ID: <20250425024311.1589323-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425024311.1589323-1-kuba@kernel.org>
References: <20250425024311.1589323-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dict stores struct objects (of class Struct), not just
a trivial set with directions.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 9613a6135003..077aacd5f33a 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1015,7 +1015,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
 
         # dict space-name -> 'request': set(attrs), 'reply': set(attrs)
         self.root_sets = dict()
-        # dict space-name -> set('request', 'reply')
+        # dict space-name -> Struct
         self.pure_nested_structs = dict()
 
         self._mark_notify()
-- 
2.49.0


