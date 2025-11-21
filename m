Return-Path: <netdev+bounces-240809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77695C7ACF7
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED00A3A20E4
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F67634C838;
	Fri, 21 Nov 2025 16:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mebQs2FH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3EC33B6C8
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742051; cv=none; b=uP4YFLj9yb65PMF9FB/6L1AJYqLt0AFN/p841gTuz8sZNg3TBljgFE0XmCtK4x2C7zVEzG4d1wDbgn/sn8kgMfRUqKbzfg17g4hpq1YvIWvhaDlWpyHRlUD1QjvLu2D798AChTsuFIYWeGghepSXUPjAFp0+CSpu7f/uYUn3m/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742051; c=relaxed/simple;
	bh=cT9sm+guAW81oq2mhAv86lto4IfxaQrH8SKVWmojCs0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OYHAPdg7zi7EKb53LbEouXfCHUs4LX3bNBOz/rIVPvSucHhS1lYL25mgShlI3RrYLoNBLStsPRmB/2Z76NC8zJi28Aq+zTrdon1Os22U9L7ZJmql+OZ6u6smwcz2M/vUTO+Fz8OfAhh2FA/Lx180GD5geCnMQChoP2ikFjE7RoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mebQs2FH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A136C4CEF1;
	Fri, 21 Nov 2025 16:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742050;
	bh=cT9sm+guAW81oq2mhAv86lto4IfxaQrH8SKVWmojCs0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mebQs2FH31M53G0VrV493j0krCgf2646UrRQV2TfFckKgVKJgL0PKJEUnAKS66IC3
	 MXg3Z1Wtma/gTTF8naKzbiBx5dhz0Pv8XwA7rhu7cgBA9+VowACCKSWng3V3mgdFTy
	 bsz7pM1YKXwSt07+MIA5xN9+YRaT11E2tEgWRT1EK8xE/DHRC8GVxuS0jy8i/E7Z0Y
	 27AVrVB5KXHhCmyo2H0OIGiIKVMtv9ljXK18bQIJO82eQquCAFXKpUaAXVmBsy3g25
	 gEjxIyeR3dALNRTYoYk/yoTEIKs3s1eKlKQCcrRDLgJdmDHSUO/0kypPz/Bn118t39
	 8AM03Xaj5S3AA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBC3A78593;
	Fri, 21 Nov 2025 16:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v5 0/3] Add DPLL subsystem management tool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176374201524.2493405.6110675318889491185.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 16:20:15 +0000
References: <20251118141031.236430-1-poros@redhat.com>
In-Reply-To: <20251118141031.236430-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
 ivecera@redhat.com, jiri@resnulli.us

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 18 Nov 2025 15:10:28 +0100 you wrote:
> This patch series adds a new userspace tool for managing and monitoring
> DPLL (Digital Phase-Locked Loop) devices via the Linux kernel DPLL
> subsystem.
> 
> The series includes preparatory patches to move shared code to lib/ and
> the main dpll tool implementation with full support for device/pin
> management, monitoring, and JSON output.
> 
> [...]

Here is the summary with links:
  - [iproute2-next,v5,1/3] lib: Move mnlg to lib for shared use
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=0d61015ba991
  - [iproute2-next,v5,2/3] lib: Add str_to_bool helper function
    (no matching commit)
  - [iproute2-next,v5,3/3] dpll: Add dpll command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=656cfc3ce05b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



