Return-Path: <netdev+bounces-226253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80784B9E93B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6EA381D25
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4552882B6;
	Thu, 25 Sep 2025 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmjVl+Kd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87B14EC73
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 10:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758795010; cv=none; b=fiQtt88hlBJyZ6nZBC4QOPjF/26OmDUqZ52SNfT7bNZpn6ZsF6jHRBwPOV6ENxcgZslEKTNh4OwE5GESP1q9vCkA7eidW3w65dsoc5kCnKp/NjShcPPrBV9UZ2zHg9zJqzjW9mEZLEKZybnUti0TpOp0ZoTmR6JSBE0zC2CcCao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758795010; c=relaxed/simple;
	bh=YfE4chbEs6WUOmUFqJD7rWfkUoK667e88WJ0YyvcqoQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KZebcRSof2RRIUG2qWa5fDCHaBxcHsK3HAGoXS3DC1+TDQHi/Z2tgrW3wrNlb2v+7XGZkJImlv42fxiOVVc5vTW3g8bSAdFTqomU8HrRadm4IzClsACywD9qdMCWmR7DVCVoQyb3UgTjcp+N6cg3QS5Ee0hqWOazFJTNI8H/QhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmjVl+Kd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF91C4CEF0;
	Thu, 25 Sep 2025 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758795010;
	bh=YfE4chbEs6WUOmUFqJD7rWfkUoK667e88WJ0YyvcqoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HmjVl+KdaAq8ptQ9Zor4DZdFCWl9nsd9agPOpklDvhwI7R1VMYDxPd82pEYoeTDUn
	 lFYAdcRklb51bs9AKwLNpXmndGu6RTW5rBuhCebYrCd7XTvEm+Js1fJHgQTaes73Pp
	 e3iO9ctEx+vQHCYdUyrv4fn2FBqRk7v7jVbj8oORs8NVTisZEEynSDPjhDflJmsfZX
	 9a1OKbbi9CAKDZzMMGqJ+GbeCT9kNrieC7XleYsnGcUMLt/H8psKNEP7Gl9g2Y4hz+
	 giyVrBRhtmPfhE8IzdH8znwPeaNK+6TDEcq2kARLKetC1jUKoI9LYlTFMBaBEaAdp8
	 9oA9Hy60C2JtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE07739D0C21;
	Thu, 25 Sep 2025 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2] eth: fbnic: Read module EEPROM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175879500650.2910522.9871303400722801567.git-patchwork-notify@kernel.org>
Date: Thu, 25 Sep 2025 10:10:06 +0000
References: <20250922231855.3717483-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250922231855.3717483-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, gustavoars@kernel.org,
 horms@kernel.org, jacob.e.keller@intel.com, kees@kernel.org,
 kernel-team@meta.com, kuba@kernel.org, lee@trager.us, linux@armlinux.org.uk,
 pabeni@redhat.com, sanman.p211993@gmail.com, suhui@nfschina.com,
 vadim.fedorenko@linux.dev, idosch@idosch.org, idosch@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 22 Sep 2025 16:18:55 -0700 you wrote:
> Add support to read module EEPROM for fbnic. Towards this, add required
> support to issue a new command to the firmware and to receive the response
> to the corresponding command.
> 
> Create a local copy of the data in the completion struct before writing to
> ethtool_module_eeprom to avoid writing to data in case it is freed. Given
> that EEPROM pages are small, the overhead of additional copy is
> negligible.
> 
> [...]

Here is the summary with links:
  - [net-next,V2] eth: fbnic: Read module EEPROM
    https://git.kernel.org/netdev/net-next/c/bb6a22651b89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



