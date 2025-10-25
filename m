Return-Path: <netdev+bounces-232942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DE717C09FF6
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E7BA4E3B2B
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781F5309F00;
	Sat, 25 Oct 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIOI0fBX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4033081B8;
	Sat, 25 Oct 2025 20:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761425626; cv=none; b=bbJk1+PCYyr5DXoS0pPTLMD04G4PzNGBIoMgjjMmU3umx6lr7gNFI/PlzalAoiQeHDC0rVla3ADu4xlhstxLUcUVAkT2hR3QXPfGDf5gyTP27lZvNZKPaYSTun8/SfhXbmyIzp++K4BFZxdjdltiO9dZ+fYTMCsBXUnl+ZHgNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761425626; c=relaxed/simple;
	bh=iG5SfyTk4AKapcKPPrgaFC/L53w+793p/xw4lohb8j4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gcaO0ml15nfyXs1UEiGFrY3QIJJYTAU1Ty0rKv1q1C9xzvsQmA+NzMpwaycGR6pZIzqevDMotftWwwMYDyo5t8wBAXP9IGAOgLc3rpN7PIjZeweCp1Cniz4dtvYzEkK9ZNnhpMeWMfV7Xy92o1CmdlhmFbS7sd6/DtxAV8vQrjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIOI0fBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0286C4CEFF;
	Sat, 25 Oct 2025 20:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761425625;
	bh=iG5SfyTk4AKapcKPPrgaFC/L53w+793p/xw4lohb8j4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tIOI0fBX3xZrYkIIJKOTTujgZFS5HWbD5Fq0jy1bprFv8lhHtqpaHaNXYfigNsuvV
	 IPJSVSUUb/H19XVseECrJfWHff5FzANCf/bFsgYXSmZ/XitcJLQDCQGQ202ZyXySnC
	 djE0aeNgokJhBAFjxVoNpURGUPu2DzKnoiu2vgAb900a+kKkBB0z2R6qGyQHX9QfRF
	 1U4yvR2tstfL8mdlQBpehKXVDp/ifN51kZf6nVyfEZIRrNPsGSDhaEalZBTe+tnZ9h
	 A+qqxJAg6ovg04sN7aHZT34rLlamKBuPYTeqC6s31CrnnGAbsnTjvE6oV5d2oD76aQ
	 ctQrpfhR7nA/w==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 25 Oct 2025 21:53:19 +0100
Subject: [PATCH 2/3] ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251025-idpf-fix-arm-kcfi-build-error-v1-2-ec57221153ae@kernel.org>
References: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
In-Reply-To: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
To: Kees Cook <kees@kernel.org>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058; i=nathan@kernel.org;
 h=from:subject:message-id; bh=iG5SfyTk4AKapcKPPrgaFC/L53w+793p/xw4lohb8j4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBl/Lc7cXRGgEvFzhe+9sFOGP38axfW9tZlhLmOZX/NkW
 wwnw6SbHaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAiySwM/wxDz1zd/XRjSMYZ
 vym50b0nP25112lec31i1Ha1lzW5idmMDF3XTz96kqbppmE8gT+FIdqm4Ne2c1cVVkeGynAsFN3
 FxQ4A
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Prior to clang 22.0.0 [1], ARM did not have an architecture specific
kCFI bundle lowering in the backend, which may cause issues. Select
CONFIG_ARCH_USES_CFI_GENERIC_LLVM_PASS to enable use of __nocfi_generic.

Link: https://github.com/llvm/llvm-project/commit/d130f402642fba3d065aacb506cb061c899558de [1]
Link: https://github.com/ClangBuiltLinux/linux/issues/2124
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/arm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e3f93b690f4..4fb985b76e97 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -44,6 +44,8 @@ config ARM
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
+	# https://github.com/llvm/llvm-project/commit/d130f402642fba3d065aacb506cb061c899558de
+	select ARCH_USES_CFI_GENERIC_LLVM_PASS if CLANG_VERSION < 220000
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_GENERAL_HUGETLB
 	select ARCH_WANT_IPC_PARSE_VERSION

-- 
2.51.1


