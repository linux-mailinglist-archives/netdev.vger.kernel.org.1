Return-Path: <netdev+bounces-192457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213C1ABFEEF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 23:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7359E3F8E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5406E2BD02B;
	Wed, 21 May 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ngtJQnYb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4242BCF7E
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862850; cv=none; b=EcgYxjJ1ovXc+fkBbIpwZuovfOnVk8c/O9OGzBLbKTyFroELb23h1beXHTH9xkeg9V27k2L4oYANgItxzr8K4KCoMHUDGHMP0RebmkHZaZbv0heaPBPMg8IwyI/Jo0tjpZBJMkSLybnc331xXp9JIT/uZQX2sFb41BkUAEPJwCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862850; c=relaxed/simple;
	bh=Ecf7T8QRhlDUN7WXfc35a69ML9JkkRhqfu3kvc0B3S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv9p9mx8kZ4LLf/yB0DtqjPo9f6F6f3SnkOa2AowArMwdl0LUrFfd2ti5JVZdoR6ha8L3i05tfukEePmV/Cy2qmCGLatIHGTZQnw6hHANQHpa3gPTla9vshzCwnPP3ycIuiJEiyr3dK5bS5o78NXVT/Jf6U1TSFdMN8suFAkQZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=ngtJQnYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6018C4CEEA;
	Wed, 21 May 2025 21:27:29 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ngtJQnYb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1747862848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8rD5LdNQjU1Yu6dW2XiKxfwPbgBqcGf9vAhnCf5uJE=;
	b=ngtJQnYbyIrHj1oTSsNq6hsBCv1mfH1pLUDZKgrTj6+fKgbdTSJL3R1gRZhHm3O+nlXjmz
	3AdHmW5MOsaiG8M/69F+qKDZrmcZBDnvuaPPIlLkFFy6kFF3hFgEgAxCUlW2i3+UI85L2b
	JFmsP8M1B53Ehx4iGpB+YWE7ZuZxohc=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 37dc6b1f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 May 2025 21:27:28 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: netdev@vger.kernel.org,
	kuba@kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH net-next 5/5] wireguard: selftests: specify -std=gnu17 for bash
Date: Wed, 21 May 2025 23:27:07 +0200
Message-ID: <20250521212707.1767879-6-Jason@zx2c4.com>
In-Reply-To: <20250521212707.1767879-1-Jason@zx2c4.com>
References: <20250521212707.1767879-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GCC 15 defaults to C23, which bash can't compile under, so specify gnu17
explicitly.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/wireguard/qemu/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/wireguard/qemu/Makefile b/tools/testing/selftests/wireguard/qemu/Makefile
index f6fbd88914ee..791d21b736a5 100644
--- a/tools/testing/selftests/wireguard/qemu/Makefile
+++ b/tools/testing/selftests/wireguard/qemu/Makefile
@@ -401,6 +401,7 @@ $(BASH_PATH)/.installed: $(BASH_TAR)
 	flock -s $<.lock tar -C $(BUILD_PATH) -xf $<
 	touch $@
 
+$(BASH_PATH)/bash: export CFLAGS_FOR_BUILD += -std=gnu17
 $(BASH_PATH)/bash: | $(BASH_PATH)/.installed $(USERSPACE_DEPS)
 	cd $(BASH_PATH) && ./configure --prefix=/ $(CROSS_COMPILE_FLAG) --without-bash-malloc --disable-debugger --disable-help-builtin --disable-history --disable-progcomp --disable-readline --disable-mem-scramble
 	$(MAKE) -C $(BASH_PATH)
-- 
2.48.1


