Return-Path: <netdev+bounces-93364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F368BB4DC
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 22:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85481C22A58
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 20:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F3718633;
	Fri,  3 May 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D79pOhs6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF2610C;
	Fri,  3 May 2024 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714768295; cv=none; b=GcN0PeSVx63a+MLX2FetkHXk0Ut8Z704uR5UIvBzJboBJuKrWzUzT6Tp4gS5d/tQTLDQO2fAhtwRSwSKCs5aIn8NlXAHUw0FNH2l9YvaaI5wOyqejtNYcyBw0Hi39pN44q1CtBCiTfQ7dFJI6kiEBzAoZAISw7IicFHP5WhzvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714768295; c=relaxed/simple;
	bh=0uOZVBeVL8e2cRQ2gUABsEIS51gG8RT48KCgftKLBss=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KWDETEfD1a4hAns36+UHc9ThwAl1fqzc10FjE8K+Fv9dFnt6G5hE8+IGxTPRfbKDEwZcw2XO1U7UAa/pVg9Qu+BgGcS4uUGJVksetKcShuUuD8Z894sFNQYsYnHqRb1DxQ7L5CcxQBjDkgpa5mrsDmKStaaqBWwD+lDkVujafSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D79pOhs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF9CC116B1;
	Fri,  3 May 2024 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714768295;
	bh=0uOZVBeVL8e2cRQ2gUABsEIS51gG8RT48KCgftKLBss=;
	h=From:Subject:Date:To:Cc:From;
	b=D79pOhs6j4z+mgsr15pBzwaG3ndDF8i8Q28j2N7YUdbnaj+9b1Roj1r/3lU2vF7HV
	 zGk0U6pJkWwfb1NgcRPGVpI8QjXNv4DUkM9vO6/4obxQ7jo1iqILbNcxo45rGDTVIb
	 Exg2RjFUj2MRrIB/Xzj5i+jUup8OU+DW/TtETwmx+3aw6mHs4cE84/pWz5Tpk5suoS
	 sXWRSOwwqPHtMkfalv/nBeV5aJskaCLX1tgBTNfOuf/OP2hdGkRdL77vB6vw/dOD7M
	 LnIxsSQojaaS7ozcTIULro1aB94ARQreU//WB809yn++NnUPxIcZ2pUP6EXa0DiCxd
	 oiJ2bdsBJEr5g==
From: Simon Horman <horms@kernel.org>
Subject: [PATCH net-next 0/2] gve: Minor cleanups
Date: Fri, 03 May 2024 21:31:25 +0100
Message-Id: <20240503-gve-comma-v1-0-b50f965694ef@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1JNWYC/x3MSQqAMBAF0atIr22IQ3C4irjQ+I29MEoiIkjub
 nD5oKiXArwgUJ+95HFLkMMlFHlGZpucBcuSTKUqa6VVxfYGm2PfJ57RmUq3TacLTak/PVZ5/td
 ADhc7PBeNMX5ivXipZQAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jeroen de Borst <jeroendb@google.com>, 
 Praveen Kaligineedi <pkaligineedi@google.com>, 
 Shailend Chand <shailend@google.com>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
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
Simon Horman (2):
      gve: Avoid unnecessary use of comma operator
      gve: Use ethtool_sprintf/puts() to fill stats strings

 drivers/net/ethernet/google/gve/gve_adminq.c  |  4 +--
 drivers/net/ethernet/google/gve/gve_ethtool.c | 42 +++++++++++----------------
 2 files changed, 19 insertions(+), 27 deletions(-)

base-commit: 5829614a7b3b2cc9820efb2d29a205c00d748fcf


