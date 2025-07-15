Return-Path: <netdev+bounces-207297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C49B069F5
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FEA81AA1F02
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E0C2D4B62;
	Tue, 15 Jul 2025 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbUH+syl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DC2571C3
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 23:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622793; cv=none; b=HhT7c8/UlFtVHxImWV576FGnHWWHA9XmYijZqh04Wrw6QJhMM6bm2rrH0Lv7vPMWQz9CBl58WKWo/r4BIl2b8CjYUBgHWI1EaY6BJeHgbco4P1J0yQ0E63XYf/Ydjr1FEFuSimjsgqEF3jkkl+Wfo3Ua7oLbmNFP8tCi4j+1XnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622793; c=relaxed/simple;
	bh=EdUVU71lKqsEiAfN1jNs2cp/gKF9ykokK/ehDureoY8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q7nayGC1FTfuy9WRcwEyTLhszUCzXapffjpSog7PCHnKnXM8Cq2CLZFkzUq3sl2c+CDWxSeIw1OS4JzXP1KVoZLV33Hl+EozwhikOZB6YKAOcQGLUyZ/xDXEHWn2HjCODIFjxyIx9RdHxWkklROTjmLxXdCvVldbonbtDR9oSxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbUH+syl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73BAEC4CEE3;
	Tue, 15 Jul 2025 23:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752622792;
	bh=EdUVU71lKqsEiAfN1jNs2cp/gKF9ykokK/ehDureoY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qbUH+sylJuSfearjErpK7ThfhLPmabJacBoweC4wKMhOfYjDOmNM8S6bs9a6+QED7
	 bKQ1VHWRuoftdG7E60/jnlbE74e/fLO+uaZgmaqT3eAFeOPo4WcOls828YvJk07MVR
	 Rhp0QoOuOzxlZGdOORHCpVaCKp/z1hqkANQ9KakeVIWmUfXJlmcBVZ4i4ZLGhEA0aa
	 MEZPR/3uClyxKkGQfxIAPP5CKV+1CpaJhumJz9/EwOLlDaZpW5mSu5npFsM0PRM51s
	 WMxpEZ1ofzrGyOtB7JKYUd0nWpz6C0uwi0yyugvEmMXTKGo/nnkEQKzqG38+XS2u0U
	 8qtAyMus08y+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E0C383BA30;
	Tue, 15 Jul 2025 23:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bnxt: move bnxt_hsi.h to
 include/linux/bnxt/hsi.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175262281274.617203.17200656875788495871.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 23:40:12 +0000
References: <20250714170202.39688-1-gospo@broadcom.com>
In-Reply-To: <20250714170202.39688-1-gospo@broadcom.com>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: netdev@vger.kernel.org, vikas.gupta@broadcom.com, gospo@broadcom.com,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Jul 2025 13:02:02 -0400 you wrote:
> This moves bnxt_hsi.h contents to a common location so it can be
> properly referenced by bnxt_en, bnxt_re, and bnge.
> 
> Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> [...]

Here is the summary with links:
  - [net-next] bnxt: move bnxt_hsi.h to include/linux/bnxt/hsi.h
    https://git.kernel.org/netdev/net-next/c/c34632dbb29b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



