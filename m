Return-Path: <netdev+bounces-197696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BF1AD9974
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC33B7ADABB
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65A4D599;
	Sat, 14 Jun 2025 01:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL1piyIM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211BD40855;
	Sat, 14 Jun 2025 01:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749864619; cv=none; b=YkkyqBYRvszlL0azOclf1N8pVdMqOS68AMW3HjHg+AVaALUulVg7qsXEUamKyFhm+HaJHYic57Vp1ezB9Jn+5A8s2FaxgaTLKThisBrC+qo2TC/M1WCy/lCBNH1o6jj/0zza/0vP5hUaXnSBezJuAABGzUWZVPHUapzpn15SB0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749864619; c=relaxed/simple;
	bh=BOUQQm7YC/kdLqzLOm9kVlopGQIxbesBZW/qKm13bNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NI8adTcqL+UzJRHEt3engD4mu6+EhdiAH90u55xWAN3FQMzLWfFvFAsdzGrHjXpf+zQ/SQzolWIxAxtn/ijSLOVw+94aVM2YwFNSvk+vwtPd37y5g05A36HoCDXBU7gJTnChE0s5UKTIXrsz0rmfhaLFMYcDdetQpLObPyoBUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL1piyIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1359C4CEE3;
	Sat, 14 Jun 2025 01:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749864618;
	bh=BOUQQm7YC/kdLqzLOm9kVlopGQIxbesBZW/qKm13bNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EL1piyIMN0gmQW8PIlwyk8n47hfqlQdRkpWECjz2k5I0WjcOs3LRaEPxI3aqFngBD
	 lT6LAJ+4oxSCCGT2lxwT+MfAWw9rk5W3NYR7f/lDoGxQ3+oaAmreiVA3v9UKol23ZC
	 wzgF7Mx2ee4ddsI7ciQ0O3SU1Orgf5ef2P22Mvix2FpIAIOl+/ZmAE9qGMi3ff3KCO
	 ezsXUs4nRb7Ngl4WDhv1miP2uql/j6zHciR5zh+jKpMILCJH7kn3Q3FPa1z6sv7Iqe
	 psia8ChZoOAxbgkPPo6kDgu0OS0v/SKc7EDT7S0rNWOGpljON0z5/CFXo5hVP8rCPv
	 iE6xppgOxMN2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBA380AAD0;
	Sat, 14 Jun 2025 01:30:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/3]  dpll: add all inputs phase offset
 monitor
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174986464799.950968.5025787246516730195.git-patchwork-notify@kernel.org>
Date: Sat, 14 Jun 2025 01:30:47 +0000
References: <20250612152835.1703397-1-arkadiusz.kubalewski@intel.com>
In-Reply-To: <20250612152835.1703397-1-arkadiusz.kubalewski@intel.com>
To: Kubalewski@codeaurora.org,
	Arkadiusz <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 vadim.fedorenko@linux.dev, jiri@resnulli.us, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 aleksandr.loktionov@intel.com, milena.olech@intel.com, corbet@lwn.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Jun 2025 17:28:32 +0200 you wrote:
> Add dpll device level feature: phase offset monitor.
> 
> Phase offset measurement is typically performed against the current active
> source. However, some DPLL (Digital Phase-Locked Loop) devices may offer
> the capability to monitor phase offsets across all available inputs.
> The attribute and current feature state shall be included in the response
> message of the ``DPLL_CMD_DEVICE_GET`` command for supported DPLL devices.
> In such cases, users can also control the feature using the
> ``DPLL_CMD_DEVICE_SET`` command by setting the ``enum dpll_feature_state``
> values for the attribute.
> Once enabled the phase offset measurements for the input shall be returned
> in the ``DPLL_A_PIN_PHASE_OFFSET`` attribute.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/3] dpll: add phase-offset-monitor feature to netlink spec
    https://git.kernel.org/netdev/net-next/c/c035e7360380
  - [net-next,v6,2/3] dpll: add phase_offset_monitor_get/set callback ops
    https://git.kernel.org/netdev/net-next/c/2952daf44a84
  - [net-next,v6,3/3] ice: add phase offset monitor for all PPS dpll inputs
    https://git.kernel.org/netdev/net-next/c/863c7e505936

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



