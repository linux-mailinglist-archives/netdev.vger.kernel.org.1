Return-Path: <netdev+bounces-167929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F94CA3CDD9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B8B1894379
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E1A26460B;
	Wed, 19 Feb 2025 23:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBfqJJnK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EACE264601
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009010; cv=none; b=D8dAGVvGYLegdst0+Pt0hGflU4weij2Ib+3PNG5WJMZBh/AybhA/4R/fGIie6Io6G5iLrFBYxdujQ4HGaiO32CcY2dHKn7Rw7bu/YN41hJ+kukP7MSk/dYzH5mIU4G12YyinovYClUQW2MZ6iUFGV/lHy648uS2pub/zzEqvuIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009010; c=relaxed/simple;
	bh=PUWCN/zDo+dSpf3wfrOCdFXZvEgrKymfubjaDAw6GQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrzNtwtdRgIWkqam5A9nNrziiydJuILJnWHmFWqL8MunZduUr/DuNvdWf8JEqqk2S4EeKkO0fyyJbEeL55MZlDM3dZ/daJIRB2tWP4npOx1xZOELytiwUVi0R6IVo2zLjhuAt27h9jf7v2KyoGd3pwSe6R9pLS1wbpw7O2Gmpbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBfqJJnK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51863C4CED1;
	Wed, 19 Feb 2025 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740009009;
	bh=PUWCN/zDo+dSpf3wfrOCdFXZvEgrKymfubjaDAw6GQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RBfqJJnKbZy/CwvlmFdKlqzX3jdIWlJpu0NrzwigJSqI8tJov+WCcmJPSIX6J2TE9
	 H94FU+Ew5kiDOb3PM9ZoQzpPmOl8yTWZ0jFQCJnd0AVmQnS8tDvb8glANho2F2Xrx9
	 8e6x/T4ku9vpF79ZLoCfpjumZDxWMCeUzCtqE8JVghJxUjQsM/H+7Fqrf7TgJAOB+R
	 UoLMYvGpNj0zXgNX8lXNk8DUz4ska50XAKHAWHa88S+H3qcJjTWWS+OIdvEFcnZ51n
	 9/CsOpNqPFoS3St8daHd/hCy5L2tB/EkL2WzwlX+G4wjWZB26tE9yq1cx92KEaT+3/
	 lKWj0+RdOGPaA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	stfomichev@gmail.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 7/7] selftests: drv-net: rename queues check_xdp to check_xsk
Date: Wed, 19 Feb 2025 15:49:56 -0800
Message-ID: <20250219234956.520599-8-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219234956.520599-1-kuba@kernel.org>
References: <20250219234956.520599-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test is for AF_XDP, we refer to AF_XDP as XSK.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/queues.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index a49f1a146e28..9040baf7b726 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -23,7 +23,8 @@ import struct
         return len([q for q in queues if q['type'] == qtype])
     return None
 
-def check_xdp(cfg, nl, xdp_queue_id=0) -> None:
+
+def check_xsk(cfg, nl, xdp_queue_id=0) -> None:
     # Probe for support
     xdp = cmd(cfg.rpath("xdp_helper") + ' - -', fail=False)
     if xdp.ret == 255:
@@ -116,7 +117,8 @@ import struct
 
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([get_queues, addremove_queues, check_down, check_xdp], args=(cfg, NetdevFamily()))
+        ksft_run([get_queues, addremove_queues, check_down, check_xsk],
+                 args=(cfg, NetdevFamily()))
     ksft_exit()
 
 
-- 
2.48.1


