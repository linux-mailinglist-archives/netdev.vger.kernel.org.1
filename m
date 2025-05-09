Return-Path: <netdev+bounces-189308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F28FAB190C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C80B1C46600
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A77417D2;
	Fri,  9 May 2025 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyZs3o6z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A823026B
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 15:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805341; cv=none; b=IkWA8AEasja6es6O5bY0EH7/7NT1nCsevDCU/CW19k8J7D+ui3veip+tPIJSIRIvJ7HjgrEtu90jlx1Jga3nWCWEgKhVR4PzOdM/fljkxQTBM5gR04wgOpaWkAG+9JSdFG0VHgdpAqwW4Taoxr/+VwlyC7KZukgdtxOcQyShFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805341; c=relaxed/simple;
	bh=O3KIz5VwT9bfBJ4zuS5ljbcCvbfJS177vEZ0YdiGdog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cSz8fhaiNiSoBR9mBjD6X0U5VnRsrCEv6oh5dqPTcXoBSPB33pVO1mMs4PqOh3laadkHMECYr6SO37D073FBWrMNxgi22IZUTmofsa74QwHw0MBGc+3AzRPGMsb2+AEFIwFTug2HQ0aJC54gecgfss5iUEdn7eoJyq2bVwGsmBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyZs3o6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34849C4CEF1;
	Fri,  9 May 2025 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746805339;
	bh=O3KIz5VwT9bfBJ4zuS5ljbcCvbfJS177vEZ0YdiGdog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HyZs3o6zqf6Ld3lad+LlOP87clqdeNXqZ2D+yWTkr4qbJrI84f4E0a5k6P5FPa/FZ
	 wIufvXjwS9EmvNk0xGc1EwFkNFPOh2+rVJLM8KOCrqupKhtO+oF5G+gBLOvK6AXWsH
	 pPEjNOOtMVBBo0EErKLWH+BiGEbm8RLI6m8pfZie01eP//aEotEoQ0kSAIYylYYKbt
	 FHEm6ewW4e15ZCB+hSf6nRMgEAOGZ9nw3R7yC8cL5Dk8n+U+jNeVN7sdn8lG2KQSkH
	 BoAYRqrN4jV1fDQpUs9QVtOTo3X/N0Svqo9j6z+0fmNHTjxhJfvZ+9dEEZuObjWOpH
	 DSyj4IsUvLdJQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/3] tools: ynl-gen: auto-indent else
Date: Fri,  9 May 2025 08:42:12 -0700
Message-ID: <20250509154213.1747885-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509154213.1747885-1-kuba@kernel.org>
References: <20250509154213.1747885-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We auto-indent if statements (increase the indent of the subsequent
line by 1), do the same thing for else branches without a block.
There hasn't been any else branches before but we're about to add one.

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 4e2ae738c0aa..9a5c65966e9d 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -1458,6 +1458,7 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
         if self._silent_block:
             ind += 1
         self._silent_block = line.endswith(')') and CodeWriter._is_cond(line)
+        self._silent_block |= line.strip() == 'else'
         if line[0] == '#':
             ind = 0
         if add_ind:
-- 
2.49.0


