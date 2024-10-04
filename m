Return-Path: <netdev+bounces-132218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC98B990FDF
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 831521F23262
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 20:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A29C1DF96E;
	Fri,  4 Oct 2024 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRtIjbT9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5F1DF971
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070829; cv=none; b=fM7ezuJGciI7wsDIj0pqKjfSu5YlbtiytzQY7XHSknN0tffEkb/nqL8iTjkQv2m2cGxnjww7OzV4bCk687kZ4dN/te4+hU8fngS0A7QrUrzkv5jfint7Gn20xpceb6BPgXR+NE37muDvlUgQlDavPVyyblZzj5lLK9ONAVgrPI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070829; c=relaxed/simple;
	bh=h3lyfASBxgKqHzc5PijqKO3f/7W9rXYv3WYu7fbI5eo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ffCv/+v4DvFJ9d/m5MlgCkJKBsBwYKporY9lgXLNwUj/MFKClDNxh8Gow0eh1Al9D+VrAlnhMtz9ZpayCvXWmtFXnRYCn2RlJk/N4SEQhnq42m8iKOoMpUqI+YWqEvyi/1KKFbsLndt6+KW0L115V0IOEnNPJ1SxPy71be4bvd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRtIjbT9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A534AC4CEC6;
	Fri,  4 Oct 2024 19:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728070829;
	bh=h3lyfASBxgKqHzc5PijqKO3f/7W9rXYv3WYu7fbI5eo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WRtIjbT9AP6WSa2bH5GsEcZ7bNv2BnY4Ry/i8lzCXk7ncEB0tEv1XFe6I+EyRJorg
	 G6VFB6AvnAw4J2WPR3wCrjwDExmqgOlRjkQmtzmfXjDB5p9Sql0BrBbKY4C+qWafex
	 RGNuVS7luALUJb+zAyZSVkri56O/8fJshQ26YI5BcUgEOhbLVRbjWa2vPgu3fHsZ+c
	 IeVRHbko5pW12cu4SRuaX9CQOHPBm79+nP6Z/mfTVhU9v22T655YRK0/HNbZ/QirpW
	 z2RVxfcl2tYToBfxZS1KzMB/xNpT6jrO+294OSEsoB4NmitNOM+pBIT6AhoZcXTHTM
	 sz/ulq6KHRFhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714E639F76FF;
	Fri,  4 Oct 2024 19:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/12][pull request] Intel Wired LAN Driver Updates
 2024-10-01 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172807083327.2719163.11548124456389587908.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 19:40:33 +0000
References: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20241001201702.3252954-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, richardcochran@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue,  1 Oct 2024 13:16:47 -0700 you wrote:
> This series contains updates to ice driver only.
> 
> Karol cleans up current PTP GPIO pin handling, fixes minor bugs,
> refactors implementation for all products, introduces SDP (Software
> Definable Pins) for E825C and implements reading SDP section from NVM
> for E810 products.
> 
> [...]

Here is the summary with links:
  - [net-next,01/12] ice: Implement ice_ptp_pin_desc
    https://git.kernel.org/netdev/net-next/c/26017cff6890
  - [net-next,02/12] ice: Add SDPs support for E825C
    https://git.kernel.org/netdev/net-next/c/1d86cca479d7
  - [net-next,03/12] ice: Align E810T GPIO to other products
    https://git.kernel.org/netdev/net-next/c/e4291b64e118
  - [net-next,04/12] ice: Cache perout/extts requests and check flags
    https://git.kernel.org/netdev/net-next/c/d755a7e129a5
  - [net-next,05/12] ice: Disable shared pin on E810 on setfunc
    https://git.kernel.org/netdev/net-next/c/df0b394f1ca7
  - [net-next,06/12] ice: Read SDP section from NVM for pin definitions
    https://git.kernel.org/netdev/net-next/c/ebb2693f8fbd
  - [net-next,07/12] ice: Enable 1PPS out from CGU for E825C products
    https://git.kernel.org/netdev/net-next/c/5a4f45c435fa
  - [net-next,08/12] ice: Introduce ice_get_phy_model() wrapper
    https://git.kernel.org/netdev/net-next/c/5e0776451d89
  - [net-next,09/12] ice: Add ice_get_ctrl_ptp() wrapper to simplify the code
    https://git.kernel.org/netdev/net-next/c/97ed20a01f5b
  - [net-next,10/12] ice: Initial support for E825C hardware in ice_adapter
    https://git.kernel.org/netdev/net-next/c/fdb7f54700b1
  - [net-next,11/12] ice: Use ice_adapter for PTP shared data instead of auxdev
    https://git.kernel.org/netdev/net-next/c/e800654e85b5
  - [net-next,12/12] ice: Drop auxbus use for PTP to finalize ice_adapter move
    https://git.kernel.org/netdev/net-next/c/0333c82fc6b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



