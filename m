Return-Path: <netdev+bounces-232940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A774CC09FF3
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 22:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97B3D3B0197
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B346D30596A;
	Sat, 25 Oct 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO/6fv8U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826A11367;
	Sat, 25 Oct 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761425617; cv=none; b=XSZmT1XhkEGpAZseMV7zkYbrzUZM60P16+5Lu24qGxMeKfg416ozRTRNl3+pzHljyXlY+0eTIii1Zvw6zxqUFyVWm0KNboV2ZYLsD/PxEAlav0HnIYWGx9yfBUheHsL4lFl6VlvEjfCrwNmnj3rGOqKSpKUo1Z4ma0TKb9GRt3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761425617; c=relaxed/simple;
	bh=rFP6/tMgv7qEPLocj8aUGISHZ+Qd8YkLgA3SOHA7IFg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rzqgXjZdY+k5KajFF5NrroJzgTy78X3IHiY8z+bc2ca3kl3hOBfFPHmOIrOzs+6JcL6ObmwCakFqyHyl1YXwXBf6cmA4H5z0nXKp+xnrJXOcNCwayXD886RiXiE6HBhFwxixLvC/ZPSAx2GKzgblIkFOaPWmoQ1uZxIczCAiS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO/6fv8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19D9C4CEF5;
	Sat, 25 Oct 2025 20:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761425616;
	bh=rFP6/tMgv7qEPLocj8aUGISHZ+Qd8YkLgA3SOHA7IFg=;
	h=From:Subject:Date:To:Cc:From;
	b=dO/6fv8UzBrVLHCd0fc5uz0cG4KMB4yZCCKfEv9PNfJyt84N4HvvFkr9SLnMqoDFq
	 MC6eeGlHxKjdFusduqS7whF3+LI8uKHHteq3L9cWbYdyemGHfH0ZSATjn/+MON4nS+
	 SGGq1Cu+x5RfhbSJy4JDd4k8QNud+Gl3MRmzbK3Ov/jHNuzYhE+y1BYrF3vbNNsq+Z
	 VmnU+g43DmrJD1Yeb54OmFGrJsvhVL+6rzRnlCyQruroujbYpynmGyUkhljT/ulpWi
	 Xeeaa19Wt57Ra1CCiMogevG+w3M2zt0PY0oPJYav6FKkRGvOhDbcTjcx4VqYVYJpKr
	 0oc7OvhL9PEMA==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/3] Resolve ARM kCFI build failure in idpf xsk.c
Date: Sat, 25 Oct 2025 21:53:17 +0100
Message-Id: <20251025-idpf-fix-arm-kcfi-build-error-v1-0-ec57221153ae@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL04/WgC/x3MQQoCMQyF4auUrA3YajvoVcRFp001jM6UFEUov
 fsEF2/xwePv0EiYGlxNB6EvN95WhT0YSM+4Pgg5q8Ednbc6ZS1Y+IdR3rikwjh/+JWRRDbB4CP
 5S7DhNJ1BG1VIv//+7T7GDuPH3rVvAAAA
X-Change-ID: 20251025-idpf-fix-arm-kcfi-build-error-65ae59616374
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=939; i=nathan@kernel.org;
 h=from:subject:message-id; bh=rFP6/tMgv7qEPLocj8aUGISHZ+Qd8YkLgA3SOHA7IFg=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBl/Lc6kLCj/wcq3yeGsWg7TjF1BU1OvzJSQmSEluq/5j
 HWb2Dr/jlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjARxxhGhpMGy3/Le1eG6FrY
 x++odOT0dJn48p5ImrV8U3D8r61Bbgx/+Lv3M71ZtCXF/VdhpWPpuyP58q4bnoSFhR9hYrlkFtP
 KCgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

This series resolves a build failure that is seen in
drivers/net/ethernet/intel/idpf/xsk.c after commit 9705d6552f58 ("idpf:
implement Rx path for AF_XDP") in 6.18-rc1 with ARCH=arm and
CONFIG_CFI=y. See patch 3 for a simplified reproducer on top of
defconfig.

I think this could go via hardening or net.

---
Nathan Chancellor (3):
      compiler_types: Introduce __nocfi_generic
      ARM: Select ARCH_USES_CFI_GENERIC_LLVM_PASS
      libeth: xdp: Disable generic kCFI pass for libeth_xdp_tx_xmit_bulk()

 arch/Kconfig                   | 7 +++++++
 arch/arm/Kconfig               | 2 ++
 include/linux/compiler_types.h | 6 ++++++
 include/net/libeth/xdp.h       | 2 +-
 4 files changed, 16 insertions(+), 1 deletion(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251025-idpf-fix-arm-kcfi-build-error-65ae59616374

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>


