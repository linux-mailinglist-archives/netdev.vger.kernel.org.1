Return-Path: <netdev+bounces-148447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C029E1A65
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19A9283E85
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 11:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9691E3786;
	Tue,  3 Dec 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eu/RPfgA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD441E2306;
	Tue,  3 Dec 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733224221; cv=none; b=PZROCV2Bx4Xdb/eIONP2fAa9/+Dz/fiC3sxsiCVmNn4NwUNt5CVkg8Ow0BPrWfKDshwmTM2JXNbPew9Bg8orR/s0ZHze8IlGqaY20yfNlFPf0YxCIF/bz5T0XjELyrt4RTuCdeJs9V6iD1+Ce+5Qu2et9c3BFqdoOXjVKR48vP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733224221; c=relaxed/simple;
	bh=qvTC4AocM4Quomex+L8jcyEBNAkqvLqThpuiWvfPR+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cf3k5qcUYAFgs30rH3BPEpqdcUd7g3PtLZR2JPfdXo6pSU61stml3Ep3yp+XJ8Yn74LuINJ+8dncDNjIbjmRKwVcvXFEbdpPBVGt/RpMjeq2Ry7/bcge0m18zAnmOJskW+y3Rw99gUnRuD02sfaZD1AQGfDHPt8QCLHWxkLIlzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eu/RPfgA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FD82C4CECF;
	Tue,  3 Dec 2024 11:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733224220;
	bh=qvTC4AocM4Quomex+L8jcyEBNAkqvLqThpuiWvfPR+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eu/RPfgAEPXz0DosbjuPC5XahsFjkf9YnHuMzazmWKzCremlZB2wqWgvZaFDi32bn
	 uyCKZQkE+DTGiVTZLl3mtb4xK/acgKjiaq7sHtyMIYLS2H2B9+gqrXYqHghlxrC2Yu
	 RXO6QnsuzoA8R8YwdMcGuisXa6oUeEoZAjbGQ9L8FMSCBEYHEuHAtqSGUig6tjdXF7
	 mQigtopbHcdQwIwg4Pk9ytzoGqoYLtG4p4iRAxRnossGizhiIacKa0fqnlNNv8othy
	 nZFElsUagEmQCv7E6FnvJT9S1h7pJYd3vUFgLe3fyU2ErDRJDtMAzOHUUsP26dtx+Z
	 RgA08jRPa8ssw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EDEEF3806656;
	Tue,  3 Dec 2024 11:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mctp i2c: drop check because i2c_unregister_device() is NULL
 safe
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173322423477.21908.12510880029615292263.git-patchwork-notify@kernel.org>
Date: Tue, 03 Dec 2024 11:10:34 +0000
References: <20241202082713.9719-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20241202082713.9719-1-wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, jk@codeconstruct.com.au,
 matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Dec 2024 09:27:13 +0100 you wrote:
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> Build tested only. Please apply to your tree.
> 
> [...]

Here is the summary with links:
  - mctp i2c: drop check because i2c_unregister_device() is NULL safe
    https://git.kernel.org/netdev/net-next/c/e8e7be7d212d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



