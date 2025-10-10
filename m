Return-Path: <netdev+bounces-228487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD06BCC2B2
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 10:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49D3D18909E2
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 08:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2029262FFF;
	Fri, 10 Oct 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNohewgs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89DD231830;
	Fri, 10 Oct 2025 08:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085621; cv=none; b=EAtFglcV+okKXq+GfRzgUyv1+8Yd5ifQO5SpnyjUDnHMog7E+pnJay/pERwSqMJEx5oD7M9Ge+USK79RGTHL9X9JXppOtbwaWQm54YMk/HElzxsYpShAMnGI4cb34f0maVv3gScFNNLHLYDbGFz7wFmmRHbyK3acSnxs/MnFiqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085621; c=relaxed/simple;
	bh=qmLqDgQuv+cGmjLMRvxbSjJqED3hCzcjEzRyIeRiXmU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mIhPZhyfMybzwFYg6DHpPc4khXLECESe5PsHDgO2KcyDsHY0bfa4BXVFpnjJ7isYdi36OBHMWPghIKxwOrsekXJd51aXKi3hm7ryuNSOoBFa+7sq2CMOYHB51drsAN9CLfgJxU7ZR7fT4n12dbzcjlJy29m+aCunzVElip8kk2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNohewgs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4858EC4CEF1;
	Fri, 10 Oct 2025 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760085621;
	bh=qmLqDgQuv+cGmjLMRvxbSjJqED3hCzcjEzRyIeRiXmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KNohewgs2K5YtFzI4WUvJhZL5CAMaEQvxezD90ie+IpS18wmwUn/sCbF12aEEapUc
	 KhQ0V+DxKWRxPW42fDa3M+9wQSqz40iqhbWFGkdgTnfmvGuX9csaoYnx7OwW/lPd5m
	 jlm468D8D08fFBUSR/qw0P9tICzbZ7fMkrhIJNfYgurTlC0/qN8D82Qmzc3HDH04BX
	 CEed3IB//Ne7+VCA3326lWxckp6CEeGxJ2CK4I/+1iO+CQ5M14xX9tIcmA8NHfjeMI
	 5hmlBFlQbmekHSzsFj7GqssKLzSleoMINffS+5XcUwa6nA6KVZF85EHAqeTFe39Sgz
	 fFFmyxn8qmovA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9A3A72A60;
	Fri, 10 Oct 2025 08:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: zl3073x: Increase maximum size of flash utility
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176008560900.506662.10655355854851923523.git-patchwork-notify@kernel.org>
Date: Fri, 10 Oct 2025 08:40:09 +0000
References: <20251008141418.841053-1-ivecera@redhat.com>
In-Reply-To: <20251008141418.841053-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Prathosh.Satish@microchip.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, jiri@resnulli.us,
 kuba@kernel.org, przemyslaw.kitszel@intel.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  8 Oct 2025 16:14:18 +0200 you wrote:
> Newer firmware bundles contain a flash utility whose size exceeds
> the currently allowed limit. Increase the maximum allowed size
> to accommodate the newer utility version.
> 
> Without this patch:
>  # devlink dev flash i2c/1-0070 file fw_nosplit_v3.hex
>  Failed to load firmware
>  Flashing failed
>  Error: zl3073x: FW load failed: [utility] component is too big (11000 bytes)
> 
> [...]

Here is the summary with links:
  - [net] dpll: zl3073x: Increase maximum size of flash utility
    https://git.kernel.org/netdev/net/c/f3426ac54c42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



