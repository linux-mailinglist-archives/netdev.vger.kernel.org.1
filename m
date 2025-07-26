Return-Path: <netdev+bounces-210318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD33B12C01
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 21:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C29C4E506B
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 19:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B57289E39;
	Sat, 26 Jul 2025 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QggkLvJD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140F289E2C;
	Sat, 26 Jul 2025 19:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753556998; cv=none; b=ntBtm2HB8CMB1baljO9prypLVVtld4Xf5KOcQOXYFiCMZWkACazZb0/IsmA1r3uA60Iw+EwTiVmsdJdpv8VYXU3YHf05ep2YfPajhZ7ORCpgx02YqpYUFRhfonut2TDd95faxvLU22puO5aAmVsZPQMSeL3vL/IQc+2/5t266Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753556998; c=relaxed/simple;
	bh=Z0esAkJVznS9mu9HvUJRGlrFEH4aPDr4qzvHcwf65CA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XFUMst2mQKLMNm0wvmkq1Y6NVfhVUl3y5c/hQzBWuo23KEDVrmNBYQ16HutgF9LSOFYVD7g1NsNrA0Ga1fZ79ChFfwfHcz8x3hOUrrxB7Q2XLSxtKI02egbPZYf9TeGcLw98dn8mSv3tJNWzVpGohisgAFUxpCeP85FfTiFOG14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QggkLvJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD34C4CEED;
	Sat, 26 Jul 2025 19:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753556998;
	bh=Z0esAkJVznS9mu9HvUJRGlrFEH4aPDr4qzvHcwf65CA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QggkLvJDWoy60Kj7Gs5yIbjZ3agSdXk2QFMP/FWRqOnpDG8Pfv8GB/jpzUlp6yPgM
	 auVRyEjKqmc3LtTYoDg/nVA8HOjt4XJbtQ9Df+eVqbJ5rH/ayeQAZtTFxWmnA2xLUu
	 jFDUZOwSlWu0GV/InEqrcj6xbOOrAx2T7R4iSHhfOEzq7+OcTzmKRkjBljdk3R0eAm
	 iYxXEAiLMh2TrKdS1QCItY37inahP7KzS02lkNaPdr2g6M6GOTY3+UD6BGMfYBBXz+
	 zZNTdIgUXJLG0RNdPCmcdrIJYMnzf0cTJ1t9q7BHg4WKmU4lXcrZzNj1ANMbB5hXnv
	 bc2NvZq1QTshQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE79383BF4E;
	Sat, 26 Jul 2025 19:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dpll: zl3073x: Fix build failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175355701525.3670812.15763912931192252437.git-patchwork-notify@kernel.org>
Date: Sat, 26 Jul 2025 19:10:15 +0000
References: <20250726184145.25769-1-ivecera@redhat.com>
In-Reply-To: <20250726184145.25769-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: kuba@kernel.org, Prathosh.Satish@microchip.com, jiri@resnulli.us,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Jul 2025 20:41:45 +0200 you wrote:
> If CONFIG_ZL3073X is enabled but both CONFIG_ZL3073X_I2C and
> CONFIG_ZL3073X_SPI are disabled, the compilation may fail because
> CONFIG_REGMAP is not enabled.
> 
> Fix the issue by selecting CONFIG_REGMAP when CONFIG_ZL3073X is enabled.
> 
> Fixes: 2df8e64e01c10 ("dpll: Add basic Microchip ZL3073x support")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next] dpll: zl3073x: Fix build failure
    https://git.kernel.org/netdev/net-next/c/fa582ca7e187

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



