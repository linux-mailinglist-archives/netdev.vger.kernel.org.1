Return-Path: <netdev+bounces-132430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC3D991B4D
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 01:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6BF1F21E8C
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 23:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4D415F308;
	Sat,  5 Oct 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RG1WAV8g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C529E13699A
	for <netdev@vger.kernel.org>; Sat,  5 Oct 2024 23:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728169825; cv=none; b=TRTaXLbt0+X3RMfd5yaHAepUbxphE4mepzcW0lZt3ugtkhVCMTpvaAZMMFDP0C/O2c5TUw0SGsQcKcakmMeIlhmLeFi6JPdN1LBgyTa5Qah79T532EWNFGxWekO60QrJp0ckYBakQjxpCeU7gHdgkOYtFwvBXItz0htNH+mP1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728169825; c=relaxed/simple;
	bh=XQirlrJI2VTceuWTIHe4cmQ3HUOz/OZAEb7cWqDILSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nyckkaiNNHLdeKOR6QXsKJ6wsWMITp0NGro6MceiQaAe1yMy8q6nOdVlYWterZJqITDoh0bCwZhJvjsqy5kbmQDwKBMRM7RidPFer9r4OZHQN6Z/la/JGrBXMuNrCv8iKOSevO4V4j4Y1oxUdd3jX69p9d6XuaozMUM5OMHBafs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RG1WAV8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCADC4CEC2;
	Sat,  5 Oct 2024 23:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728169825;
	bh=XQirlrJI2VTceuWTIHe4cmQ3HUOz/OZAEb7cWqDILSQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RG1WAV8gDEBSI6mqiCS7B33kaFQsV0jqLLp0Uzj2ofP3xf99m0oPLOaBhtxnOXugE
	 vN7To1jK0lKimgd5CyvuNVGGiu2dCloy8X8w4oltbrOdWGs3SYeiffqXXoXyB1vgn1
	 GcEykkm8U9nWfyGgqELoBSsbnu2towUV77dVXaXKexJwanbp8Eyt5+445vCB8GqR2+
	 3wpmc6eqbXyuW6oKeY6uqIt3GeW1OyL34QalPaf/DeacszZ/ybwxIz3p0w0d8HGGRT
	 v/VxM7AQDTLCwzlfhqnu3Gy3u475s9X+5W0wCStgqjZPYkDKEOwM5PuTXUGTZZTElO
	 WPTl+pcyBzQ/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343BE3806656;
	Sat,  5 Oct 2024 23:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] lib: utils: move over `print_num` from ip/
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172816982902.3199940.2972633167958480509.git-patchwork-notify@kernel.org>
Date: Sat, 05 Oct 2024 23:10:29 +0000
References: <20241004093050.64306-1-equinox@diac24.net>
In-Reply-To: <20241004093050.64306-1-equinox@diac24.net>
To: David Lamparter <equinox@diac24.net>
Cc: dsahern@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Fri,  4 Oct 2024 11:30:14 +0200 you wrote:
> `print_num()` was born in `ip/ipaddress.c` but considering it has
> nothing to do with IP addresses it should really live in `lib/utils.c`.
> 
> (I've had reason to call it from bridge/* on some random hackery.)
> 
> Signed-off-by: David Lamparter <equinox@diac24.net>
> 
> [...]

Here is the summary with links:
  - [iproute2-next] lib: utils: move over `print_num` from ip/
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=031922c8a302

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



