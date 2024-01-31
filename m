Return-Path: <netdev+bounces-67412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294C384340E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 03:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC5F21F27205
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCD6CA7F;
	Wed, 31 Jan 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RZUxGRmf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC50EE544
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668827; cv=none; b=XDMIyqJzUymb6wzuyun2rweUaetvQ72gAcq/YmDFESrMw+LLnf9oNR3PbMtZQS+o5Pc3jjuZR0j0XObjUImQ/de3zsqp33waWACh/ljQP+uDB+mq1Ir6bIlpVSDwfAL27m0fVYMBCglqRMwgITcZkSrhEtm3CujxQhyHM02Fjtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668827; c=relaxed/simple;
	bh=KPD6mOSeADi78oWV0K/t0GJ9iSIMEPmfbVn4bkkIKhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L5EdIh2dfTBRqK7X9jhKaWc46dLh7ZEo8g43gDceRMXLgZpJoX/T1+u0JLf+n5bGPh7wz0Fs8YwMfvcTzKPXilOz99UhG4eBOvFhQwE8fTknuykcD9HDrnx7jFfPxTVvXkbi79n4yYOlscb9YfCm6ragOWeU9ritI7H8zUWr3Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RZUxGRmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85100C433F1;
	Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706668826;
	bh=KPD6mOSeADi78oWV0K/t0GJ9iSIMEPmfbVn4bkkIKhc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RZUxGRmf//i5+ovNcSk+9eL4i9Adgrx51isRH/Z8BEg2mG8wXHGUtQ3clWNVnUXxw
	 Xl3LlAEd5kamOTAWicNzTMYCsiNvTpLePxJPsV+lyWHPGDn0GJHcVtGTokVAYJQAQi
	 h0B13x1R8tNDJLUFLmcr3BtKw7MXxBP6gNEIKato/TioMqeLJNzAd5Cx2iw/vtLuhL
	 jf9ez4u6jNAnyw7BbVWlE1lecr8gRBHlQOcAtqkuIWKjtXz6v/Et+4GlSXWmOCr2IB
	 DVY4Jox9EZFYNfsNR+lva2S4Z2TavkX+2fmTh9+p5luH8YV6vD62veSCyp3CasTHjY
	 Y9PJda8ylTgFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C6DADC99E8;
	Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: Fix referring to hw_addr attribute during state
 validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170666882644.24091.14098617573369079768.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 02:40:26 +0000
References: <20240129191059.129030-1-parav@nvidia.com>
In-Reply-To: <20240129191059.129030-1-parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shayd@nvidia.com, netdev@vger.kernel.org, jiri@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jan 2024 21:10:59 +0200 you wrote:
> When port function state change is requested, and when the driver
> does not support it, it refers to the hw address attribute instead
> of state attribute. Seems like a copy paste error.
> 
> Fix it by referring to the port function state attribute.
> 
> Fixes: c0bea69d1ca7 ("devlink: Validate port function request")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net] devlink: Fix referring to hw_addr attribute during state validation
    https://git.kernel.org/netdev/net/c/1a89e24f8bfd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



