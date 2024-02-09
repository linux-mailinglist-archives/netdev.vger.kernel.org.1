Return-Path: <netdev+bounces-70650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040C984FDF5
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15C581C221A7
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A7E107B3;
	Fri,  9 Feb 2024 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmS/JPtx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D02FC1F
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707511832; cv=none; b=A86OcI2c7nkcXljHwHeCiAnI7N+fzwlabzPMAPf8GGDiUxzAI85gwjm+Y+YxQiNhXWSPEQrMwP2fZ8NrrFhncbvtUDUEj6O26PkVHjIlOYLs5U1NQovL9+fJLJvpZ1x0rsz/oHUqMqA1f3TKhS0eqVvTuIsZrFB/9kJ8BkFqZ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707511832; c=relaxed/simple;
	bh=ZIKkBMsiuYq9a2xUuCUt8P1qOtwBHjKzmCMrgRufKdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uB9W8YhcJRSxlA2heEh/9LPH3N1U5THtano8YaFsxzCGo4gP6/g4IB3w/SwWnJvSIzCrbdDwQKU48Gg+dPr3aXXQlunwc0YAU5UktD0bPRWSW5qjd4xYwFs5YrcBrU/0H6cgUWxvilP5F60ppAMsraIFNsn2Zp6Csb0GwNUO/Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmS/JPtx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00B81C43390;
	Fri,  9 Feb 2024 20:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707511832;
	bh=ZIKkBMsiuYq9a2xUuCUt8P1qOtwBHjKzmCMrgRufKdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SmS/JPtx2VvbtVtUyJh9leVQRv9L/FuRhhc6pqS97a3t9raHjij8bWmhP8dKN7LyX
	 stwOWrETKVf0/RkLTF8eTITENdrmqNaeIt96sHTqtWakPM3ZOU6hOoGCLEBub7Jyxi
	 ntbzzyohgolGmXZTWHtmYs7z7FBnWMNSs2hbMHCHntbiPSVLQgAH1LHr4VzDOomZS1
	 aswMYg1MlgCPbOpeUCphx1WDcTH7fnYDGnfAbgWbj4TcZw9KTL/N7rSC+y9CL06HCf
	 nTZ41pnA1ldOBHAjuXZNC5acWffY1RWqn9pKnpxQEbXsbCRijXSY+L4AoB0ZScvafx
	 oaMJkEbnkVdYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7B1AC395F1;
	Fri,  9 Feb 2024 20:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/13] bnxt_en: Ntuple and RSS updates
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170751183187.4516.2535943419634917869.git-patchwork-notify@kernel.org>
Date: Fri, 09 Feb 2024 20:50:31 +0000
References: <20240205223202.25341-1-michael.chan@broadcom.com>
In-Reply-To: <20240205223202.25341-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew.gospodarek@broadcom.com,
 pavan.chebbi@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Feb 2024 14:31:49 -0800 you wrote:
> This patch series adds more ntuple and RSS features following recent
> patches to add support for user configured ntuple filters.  Additional
> features include L2 ether filters, partial tuple masks, IP filters
> besides TCP/UDP, drop action, saving and re-applying user filters
> after driver reset, user configured RSS key, and RSS for IPSEC.
> 
> Ajit Khaparde (1):
>   bnxt_en: Add RSS support for IPSEC headers
> 
> [...]

Here is the summary with links:
  - [net-next,01/13] bnxt_en: Use firmware provided maximum filter counts.
    https://git.kernel.org/netdev/net-next/c/f42822f22b1c
  - [net-next,02/13] bnxt_en: Add ethtool -N support for ether filters.
    https://git.kernel.org/netdev/net-next/c/e462998abc62
  - [net-next,03/13] bnxt_en: Support ethtool -n to display ether filters.
    https://git.kernel.org/netdev/net-next/c/7c8036fb71ce
  - [net-next,04/13] bnxt_en: implement fully specified 5-tuple masks
    https://git.kernel.org/netdev/net-next/c/c8d129c437f6
  - [net-next,05/13] bnxt_en: Enhance ethtool ntuple support for ip flows besides TCP/UDP
    https://git.kernel.org/netdev/net-next/c/9ba0e56199e3
  - [net-next,06/13] bnxt_en: Add drop action support for ntuple
    https://git.kernel.org/netdev/net-next/c/7efd79c0e689
  - [net-next,07/13] bnxt_en: Add separate function to delete the filter structure
    https://git.kernel.org/netdev/net-next/c/be40b4e9cac8
  - [net-next,08/13] bnxt_en: Save user configured filters in a lookup list
    https://git.kernel.org/netdev/net-next/c/8336a974f37d
  - [net-next,09/13] bnxt_en: Retain user configured filters when closing
    https://git.kernel.org/netdev/net-next/c/25041467d093
  - [net-next,10/13] bnxt_en: Restore all the user created L2 and ntuple filters
    https://git.kernel.org/netdev/net-next/c/44af4b622a3d
  - [net-next,11/13] bnxt_en: Add support for user configured RSS key
    https://git.kernel.org/netdev/net-next/c/5de1fce33695
  - [net-next,12/13] bnxt_en: Invalidate user filters when needed
    https://git.kernel.org/netdev/net-next/c/1018319f949c
  - [net-next,13/13] bnxt_en: Add RSS support for IPSEC headers
    https://git.kernel.org/netdev/net-next/c/0c36211bac9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



