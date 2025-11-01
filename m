Return-Path: <netdev+bounces-234805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 46477C27527
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 02:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 886D44E2D26
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED5221DB1;
	Sat,  1 Nov 2025 01:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqeNFOCV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049ED22127B;
	Sat,  1 Nov 2025 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761959434; cv=none; b=SpkbgM0V3a3A2mUIj38Qo3LcsGanBMrgDJgIjmyl3tTERFjZgfxVyhtk+G3hHLUANTrWltALVqhJYDRKBy7ui7gE9EnboSZtVR3J4enBJ0EQo+5SOF9bG0LMoskHPKI+vNoNCXkONaq8YxtEk0243yFzld/gne8WvdpOIsGdVjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761959434; c=relaxed/simple;
	bh=v86Zi9yv2WKTbQkY4cy2wNKFJWs/PbH6ZahKpXag39A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=deXRMBlCMq5Ficl3UxUwnfs2z+pfIcunregoghcon62hNP/GkWcFHZZSgYH6S84nGg+CazWd8bTTrPX4gxhxNYtpZPHxMb6Wex4fTwPUiuqGcWoGBFTDYtk5vowLDGDPpHBBbtmNo+dZeFyX38UU8WMe+paSzuyySAENv+Ogk8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqeNFOCV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86676C4CEE7;
	Sat,  1 Nov 2025 01:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761959433;
	bh=v86Zi9yv2WKTbQkY4cy2wNKFJWs/PbH6ZahKpXag39A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uqeNFOCVCWnLQnQdjc0/dPqgeYI5YHgHiMvmZmBpe2NQNKYfpKZ/OpkIKXYWhPKOK
	 eV3BLPHnwF7nNI7szYO2C+dMQh4I1q3Vtz1WnDPlRZKd2nQQ72/AGx4RWhuUIR0QLb
	 K1QgP7tX61cz62myRKbskpM251vdP24w0kOZGrZOuslFn37Midnr0VJ5iBxFjTxX8Z
	 aVE0GcjwGpMCbq01rjrsNG1zTCAWBJ8ay2wTa3n/h93Ev9csyluHAlYALU28NA0Ay4
	 Tj25u8j922qu4uVfB/VCmQ9OAz7Rl8cWbyzgsUsRqUJiFUE6bvytuydcFJuWZupfjO
	 an0ZxhSWX57Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B63809A00;
	Sat,  1 Nov 2025 01:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] dpll: Add support for phase adjustment
 granularity
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195940952.685348.6442531076361684866.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 01:10:09 +0000
References: <20251029153207.178448-1-ivecera@redhat.com>
In-Reply-To: <20251029153207.178448-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, donald.hunter@gmail.com, Prathosh.Satish@microchip.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 16:32:05 +0100 you wrote:
> Phase-adjust values are currently limited only by a min-max range. Some
> hardware requires, for certain pin types, that values be multiples of
> a specific granularity, as in the zl3073x driver.
> 
> Patch 1: Adds 'phase-adjust-gran' pin attribute and an appropriate
>          handling
> Patch 2: Adds a support for this attribute into zl3073x driver
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] dpll: add phase-adjust-gran pin attribute
    https://git.kernel.org/netdev/net-next/c/30176bf7c871
  - [net-next,v2,2/2] dpll: zl3073x: Specify phase adjustment granularity for pins
    https://git.kernel.org/netdev/net-next/c/055a01b29fd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



