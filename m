Return-Path: <netdev+bounces-184942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8B4A97C1D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 03:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D572E7A767D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 01:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658025DAED;
	Wed, 23 Apr 2025 01:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ol/VPYxC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BF81A23BE;
	Wed, 23 Apr 2025 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745371797; cv=none; b=F3m8hHv2PwsjNJGk87ZA7dMaFTK4KGvAxLNWOEvaOFgqnwMKfbWQGW/zJXPpC+5Xf8rIS3HqrtAx1/NCtkvgCB9s7esFHev3L+I7thjSg8PCTVMvawYUrLV2WHdU42EU7bvlHxNSAuo7ARg2HXnN4ha1N8JDPCUsKqCp2oiKoa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745371797; c=relaxed/simple;
	bh=6bpKDBR2BDDTGU/I9qFpK/iyxCRkcRl5HU2QmuaI5XI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EFtx4Jx6AMv9iGaYWDlATNa7KImVWyi4aUKBD8NOiXjwSWsHMdW5EggDNpGStEWW0QF3tIMs+Z8Ue2zDNVpn0utUAzBpHqxcmRiV9Ys+251q10A+RDrTVmXchdw2b+7ddHhzOSOnRqQopzAoHEILvc+9rzEBTglm6Ku1JsS8FkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ol/VPYxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA1CC4CEE9;
	Wed, 23 Apr 2025 01:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745371796;
	bh=6bpKDBR2BDDTGU/I9qFpK/iyxCRkcRl5HU2QmuaI5XI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ol/VPYxCFRAcf6aQs1lwNoyzmO8CItYA0YWS5nNVlygtOraxwKPNBrE46dALRUz00
	 vGqdeVYUiugX+IY6Y0ysV04J09fQht+xD0tmji/50OCpCebQAA8aQhI7BWrYLds4fT
	 cB1EMCkoq3sq+5bwY41vZtwFnpHmAuw5wpFFp5CXBar2SCqTnlWgozQRHI4UjrxT64
	 BPXY69TCXXqQuN/W8aYxnvgvQdpPyk/gyCgr7L3ureiaTs+t0jaUor6LtuGWwJicEz
	 pV0L9okEjgMz/2uP2dTdCqnzvbEijCITQgF40CJRS06CRd4dc1l66qttG2HamV80St
	 xxxZHrDYIFBow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B96380CEF4;
	Wed, 23 Apr 2025 01:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] emulex/benet: Annotate flash_cookie as nonstring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174537183474.2107432.8708898684594266936.git-patchwork-notify@kernel.org>
Date: Wed, 23 Apr 2025 01:30:34 +0000
References: <20250416221028.work.967-kees@kernel.org>
In-Reply-To: <20250416221028.work.967-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
 somnath.kotur@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Apr 2025 15:10:29 -0700 you wrote:
> GCC 15's new -Wunterminated-string-initialization notices that the 32
> character "flash_cookie" (which is not used as a C-String)
> needs to be marked as "nonstring":
> 
> drivers/net/ethernet/emulex/benet/be_cmds.c:2618:51: warning: initializer-string for array of 'char' truncates NUL terminator but destination lacks 'nonstring' attribute (17 chars into 16 available) [-Wunterminated-string-initialization]
>  2618 | static char flash_cookie[2][16] = {"*** SE FLAS", "H DIRECTORY *** "};
>       |                                                   ^~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - emulex/benet: Annotate flash_cookie as nonstring
    https://git.kernel.org/netdev/net-next/c/f0f149d9747f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



