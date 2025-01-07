Return-Path: <netdev+bounces-155824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0026A03F1C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966BE164953
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 12:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36F1EE7C6;
	Tue,  7 Jan 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qOBDXH4m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0F21EE7B4
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 12:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736253010; cv=none; b=dYdxZ6DAO6Q5ihXkhomG4AdS0bZzkBEUJlH2NiVhPWrtx1tmgsWZBUmCp015TTuISrudLDjoxCBxCFWFkSTSseFAYL65KflsXW/ToohkdNleCW12geydxoYMlroTBQwI71uA5xtTjtZ6LfJ2m/5gfeR1FcDQKSbFC/Mvzbe1um0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736253010; c=relaxed/simple;
	bh=s9KI8DK8F0J8mXinSZKf5qgc8HR762Q3DmvrGckfb30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gNOCBZGc/C2b1GdoMqXCwE1YTHVzuMYTq5DTbsDUAsp9KSuYRjw7BJAm0vljdK8qkVKnlGZMED8Y7IGjY3s+dPHzTy+FrsE/CpxSEGtk0BevaxlWjX4AETi2iAGgi9oU39PlOgBK3rYOMKK1b9FH2PKsMnV1htLy+xLrg6I7wp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qOBDXH4m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D93DC4CED6;
	Tue,  7 Jan 2025 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736253009;
	bh=s9KI8DK8F0J8mXinSZKf5qgc8HR762Q3DmvrGckfb30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qOBDXH4mYjkn4LBRVoEcJFjunZe5I7sa/gAoEgl5BtiVp/CSFLsYnfOJwzksiNjZ1
	 y2exKSQ/H4ik7aAyU17hIGcDj+XMCY/O8A4XbuDElsbfWFHK5kgSHT8U71ohHHOe8x
	 HMCbxhy45Zu+qgQrEvtns4nypEz/GWn+SPrsXl5Wl6AQaCZUDoPdUyeKzBjakFhWTW
	 8tEZccUFVt6aoZ3WqgJGpL1DNdKT9avhLWOaWWPvzSbkVchemdi9eqx5EmJp/jY2vW
	 KGP7cAlD0HVjKf42GkEIxH31Qxg0PphQBTc1u6IJI7Qw7nhwd+rmNvJ27rp+Lo7kIp
	 CNjjEgell8E+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD2C380A97E;
	Tue,  7 Jan 2025 12:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: don't dump Tx and uninitialized NAPIs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173625303077.4137400.7495590712072075172.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 12:30:30 +0000
References: <20250103183207.1216004-1-kuba@kernel.org>
In-Reply-To: <20250103183207.1216004-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jdamato@fastly.com, almasrymina@google.com,
 sridhar.samudrala@intel.com, amritha.nambiar@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Jan 2025 10:32:07 -0800 you wrote:
> We use NAPI ID as the key for continuing dumps. We also depend
> on the NAPIs being sorted by ID within the driver list. Tx NAPIs
> (which don't have an ID assigned) break this expectation, it's
> not currently possible to dump them reliably. Since Tx NAPIs
> are relatively rare, and can't be used in doit (GET or SET)
> hide them from the dump API as well.
> 
> [...]

Here is the summary with links:
  - [net] net: don't dump Tx and uninitialized NAPIs
    https://git.kernel.org/netdev/net/c/fd48f071a3d6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



