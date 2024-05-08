Return-Path: <netdev+bounces-94457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFB08BF88C
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B98DB21BF6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 08:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA974EB46;
	Wed,  8 May 2024 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idk8V330"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A3F2744E;
	Wed,  8 May 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157145; cv=none; b=tBM44O29IKYpHbtpSmxFVte5Fsrl1MUhVoG3A5ysZFunWHPwm/7/1joIBf+4SKYsxp+XJsHutdKvEjp6yLSWzhkvHfr8/ITLYaUQnkqHXpquC5EB6ZcpQbJzKvBK8U769ZVMwo5/9R9v06B+CRbGTVL7rKlezw+FaEuOQZYf7mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157145; c=relaxed/simple;
	bh=Vt5cX7zmfHeHinfwGDDMHWkXUrTdxQlCgb8lPaR1ERo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R0jxytVUUabDJOL+VbyQabyPpWSFP05uAYPrc51L4DWUiH0SGAVOMz7JpyFEs5ooDKZ1Sjyz1qhjYnPT9a1HO4z8bK/m0eUFwTy6lxoRm5MuK1TjYAU8J2sABGvAbQlfdC6z/Bou1k07ldljIEFghscfUv1uy9NSGLWyiUD2598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idk8V330; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADEFC113CC;
	Wed,  8 May 2024 08:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715157144;
	bh=Vt5cX7zmfHeHinfwGDDMHWkXUrTdxQlCgb8lPaR1ERo=;
	h=From:Subject:Date:To:Cc:From;
	b=idk8V3301Kka9a8DuA96+NbZTacmOFhuxkpA+tue6W3iEqeCU7ado7bcA9oOYVfS0
	 0y1iaw4vdMOcKOTmb6W8YLP9EX04Ir8dFUA7Khkh70Nxv5cwQdGy0Ds2LDJFu1s1s1
	 EXeXLESC5cFTftn5iVUN7Rm4C//MnMrzWOJbg/lZpoVGa3P5wW+xiwlb0NCAyjx7ia
	 /yWWBxox2XTfxH+V/nnMzA6dMhbMR6r5C6/vxDhX8iCQJBZtvh7jkDoP5lfDP2Cr6f
	 o6XVYU5/nq5WKUMwoqNEAB/T+sJaOeNJGkEThWwMuK7hb8nvL8zSdqpVJ4h/eaOxfW
	 0CYiEcp8jL+sg==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v2 0/2] gve: Minor cleanups
Date: Wed, 08 May 2024 09:32:18 +0100
Message-Id: <20240508-gve-comma-v2-0-1ac919225f13@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJI4O2YC/22NwQ7CIBAFf6XZs2uAliqe/A/TQ4tLS7RggJCah
 n+X9OxxMi/zdogULEW4NTsEyjZa7yqIUwN6Gd1MaJ+VQTDRMclanDOh9us64kRKt/J6UZJLqPt
 PIGO3o/UARwkdbQmGahYbkw/f4yTzw//pZY4MJ8mM6mWvOjL3FwVH77MPMwyllB+HsG+drQAAA
 A==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, Kees Cook <keescook@chromium.org>, 
 netdev@vger.kernel.org, llvm@lists.linux.dev, 
 linux-hardening@vger.kernel.org
X-Mailer: b4 0.12.3

Hi,

This short patchset provides two minor cleanups for the gve driver.

These were found by tooling as mentioned in each patch,
and otherwise by inspection.

No change in run time behaviour is intended.
Each patch is compile tested only.

---
Changes in v2:
- Collected Reviewed-by tags, thanks!
- Rebased
- Link to v1: https://lore.kernel.org/r/20240503-gve-comma-v1-0-b50f965694ef@kernel.org

---
Simon Horman (2):
      gve: Avoid unnecessary use of comma operator
      gve: Use ethtool_sprintf/puts() to fill stats strings

 drivers/net/ethernet/google/gve/gve_adminq.c  |  4 +--
 drivers/net/ethernet/google/gve/gve_ethtool.c | 42 +++++++++++----------------
 2 files changed, 19 insertions(+), 27 deletions(-)

base-commit: 09ca994072fd8ae99c763db2450222365dfe8fdf


