Return-Path: <netdev+bounces-110994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0342F92F360
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FEF1F24E8F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF73524C;
	Fri, 12 Jul 2024 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndHwvBpn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F363E4683;
	Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747232; cv=none; b=bwbdZN6wXv//P17eWID10bMY1gCa3UZYqjez+jB4ThJsjUiqpEGISjbx+KKUJKtalcqwmhfqEZp3AqFKG9scAhz89FFarMEPBYHIMbbx6g3L7aFvl5jSxWAZq0BDQnsG9ODwGrxVgHptP09jnd1p6pXBRlNY6GBr7hlwGVosO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747232; c=relaxed/simple;
	bh=NDv+xcjC3JODqlDkyIwFKrZbzw3ElybaRCkFK/Rf7Wo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bwSEDY/DA5KqVeOIkWW51v09T4pDhQsVieXZJ6+iFd9Av4Z7CzbuKnDySLrM1R2qkT6StUknF3ejiMHYWD3aDHY0Qqm+gTzzj1o1JGUKL+FpaP2XCC6jfh2T2BHN92Z0dB4Grs8PS5/yuwwZX//xtSnGuFf3T/D8ZMKoOI5G4TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndHwvBpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABB00C4AF12;
	Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720747231;
	bh=NDv+xcjC3JODqlDkyIwFKrZbzw3ElybaRCkFK/Rf7Wo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ndHwvBpnCs+Ru7Rw8f65j54fHl/y4RRpNwIAvINORGlMEMFf8e+RjKNibremplvwK
	 BNGewEkKnDE/nW/+Mh2UaSVo8ozk9m9/BxQ6AsUV86HsuGvtLu1lyK6WrDHz/LWFWg
	 F3LRErKsLRExBEBhWYmNGwHuDP1BrSRghMyFiaWxLXtJWrX76rsI+PTp9gKlPdam3c
	 6OuXjQQCOBY8rsNjVODN2D1mlxTK+RzQIBJWWbUzDAPrkyftPA2/8VzYuyZrAmfC30
	 a5ZP9GaPhh8N9YgneRUJ11XGX1c7g3omVwPnR03UCtOsrxdAAVaJTBbwjAhFKBJIoh
	 Rrfh8CMYIFrzQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CB71C4332C;
	Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] netdevice: define and allocate &net_device
 _properly_
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172074723163.25041.6587317350607512702.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 01:20:31 +0000
References: <20240710113036.2125584-1-leitao@debian.org>
In-Reply-To: <20240710113036.2125584-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kees@kernel.org, gustavoars@kernel.org,
 keescook@chromium.org, horms@kernel.org, linux-hardening@vger.kernel.org,
 aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com, jiri@resnulli.us,
 bigeasy@linutronix.de, daniel@iogearbox.net, lorenzo@kernel.org,
 johannes.berg@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 04:30:28 -0700 you wrote:
> From: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> In fact, this structure contains a flexible array at the end, but
> historically its size, alignment etc., is calculated manually.
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.
> Declare the array explicitly, use struct_size() and store the array
> size inside the structure, so that __counted_by() can be applied.
> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> allocated buffer is aligned to what the user expects.
> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> as per several suggestions on the netdev ML.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] netdevice: define and allocate &net_device _properly_
    https://git.kernel.org/netdev/net-next/c/13cabc47f8ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



