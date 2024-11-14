Return-Path: <netdev+bounces-144661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A32D39C810D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 03:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F8551F223DB
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 02:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DC51EABCF;
	Thu, 14 Nov 2024 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQ0+wV4O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8739C3D9E;
	Thu, 14 Nov 2024 02:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552634; cv=none; b=cMdXmNP+Iey6/3K4ErArp2B9BYQ3plamot+LXTrjWcHz+qpcXDXO4RrveQwd+maMbnwILlrjKuZi8rCRirXBw3hGgQ/txLsV0JIMcdqWedmVOkCGeIWIx7XiArTXrYbdzHLsS8GxRn28jgqiL76WyRSYTyOv0MWR/gYt8gufB5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552634; c=relaxed/simple;
	bh=tZ+wK232zpCSaaV8XrJUp0wjTdSkP8yXE5HAL8GzFwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KOsNXMJHsk5bYNcLH5AGl4cJMa6yzamUn7+wPz0nO0uPl+FkzcofTDNP8GOtmjtlOLo8hpShU2UfWkxqRdA5OOfA8kFXQBBiwlKR6fAiqFxUTGJGGgxeJrcCeST6D1qH2DQWkS4hxtmKOlNWI/1o0xabzf8iOQtmLF2bmc7i1AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQ0+wV4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF56C4CED2;
	Thu, 14 Nov 2024 02:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731552634;
	bh=tZ+wK232zpCSaaV8XrJUp0wjTdSkP8yXE5HAL8GzFwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FQ0+wV4OBiHZeNkke3i/5Zen1i3akFJX1zZ+ircGwBOtqE6dlAFCB2nHagBkUntRY
	 AGZ22TYLWo2+Z9DVFhpnOSFKNfGl3XY9T5ywpSJqv+EpbQbceJskZ+2uEFckRt4TcW
	 Oitwa23I7oBu5KUULpcOmBQRGL4MM69ETZ/bkTQxmCngVoEj2+OIQ7O8MOQ+mNx+KJ
	 NPlJHib7L3FEmDC9zYVTgrpDkXm1e23tKaTYuh24IACm/Y6MphVFeviGOymW+FpPgE
	 b3MsKRIERm4/bJzwKxVTM7WL0UKPw1lMXkiHt7RftCJKKgQ52ASEgEgh80xd17NX3r
	 8CC+kne9Ihkgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE35D3809A80;
	Thu, 14 Nov 2024 02:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] tools: ynl: two patches to ease building with rpmbuild
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155264423.1461768.15559112771408021687.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 02:50:44 +0000
References: <cover.1731399562.git.jstancek@redhat.com>
In-Reply-To: <cover.1731399562.git.jstancek@redhat.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Nov 2024 09:21:31 +0100 you wrote:
> I'm looking to build and package ynl for Fedora and Centos Stream users.
> Default rpmbuild has couple hardening options enabled by default [1][2],
> which currently prevent ynl from building.
> 
> This series contains 2 small patches to address it.
> 
> [1] https://fedoraproject.org/wiki/Changes/Harden_All_Packages
> [2] https://fedoraproject.org/wiki/Changes/PythonSafePath
> 
> [...]

Here is the summary with links:
  - [v2,1/2] tools: ynl: add script dir to sys.path
    https://git.kernel.org/netdev/net-next/c/c3b3eb565bd7
  - [v2,2/2] tools: ynl: extend CFLAGS to keep options from environment
    https://git.kernel.org/netdev/net-next/c/05a318b4fc13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



