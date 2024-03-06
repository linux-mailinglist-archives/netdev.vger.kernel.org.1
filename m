Return-Path: <netdev+bounces-77885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA0787359A
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55EB1C20E62
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF187F7E6;
	Wed,  6 Mar 2024 11:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A++akRIO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB12B78668
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724634; cv=none; b=FrmXY5TRDCUKuycrRmNyBrAtoTNRyTCu8XZDLMZHr2pHlC93Ky6xL0ez32BWVTj5kT9UZVCweyqX5pb/vsEpYa1XJYypWBaluyhPUQzt59D0XRKdNC8EDEWUqMqOT3E1PsKT9KSfA2VRvbwC1OgM08ORPHefG3klBID/gD8fkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724634; c=relaxed/simple;
	bh=yrMjEbuTPXLSM5duIJBK3HTusgt1EJlvfZXvAt+2/6Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R1Hnr6yC7r75peblWfHkYSQc65aquqTqjLOAzOvgIFc0yI5UObiOYGpNPVlsTimwJGAPg/+M+lqoykLHGlilqmMpInxx3fTqbp2jmh2IF5ls2hafKfyfAENS5VyBV5fXOd8A5FxibL6QjBsReODLfKdooHxZcE4krZEy1XPcme4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A++akRIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88A0DC43390;
	Wed,  6 Mar 2024 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709724634;
	bh=yrMjEbuTPXLSM5duIJBK3HTusgt1EJlvfZXvAt+2/6Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A++akRIO52IzLP1l8v/a6jqX1MaEMzawMwyKaeIN3cstuf6UK01cVHlWQ2Q0H4R4i
	 fEllfyH3KG28Xet1EnNtvMnFBfR8ScRQDBPefsuGolwBV46ZyAcvyvpw1UUgSHvvrd
	 KxkUslZ2lnaXNdBvAq7rRL9kB5+P8IGkPiiJU52WDXC5RDh3b9IfHJGbsLAtEd3TT3
	 mC7Qjd5dk6C/jz420Fp/ncsI/ngCQLJGFrcn79Xl/qgMPtI5t03RJVcufmlQGq9ArZ
	 OBten8Km5GUTnHV9o8O0V6hhhsQTD1vbZqNeFxlvn4qGyPb7KdtVJS7RrMRoiMEMSn
	 eGD+vPWpsCfHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B222D84BDB;
	Wed,  6 Mar 2024 11:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9][pull request] Intel Wired LAN Driver Updates
 2024-03-04 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170972463443.20219.7929561637502572855.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 11:30:34 +0000
References: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240304212932.3412641-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  4 Mar 2024 13:29:21 -0800 you wrote:
> This series contains updates to ice driver only.
> 
> Jake changes the driver to use relative VSI index for VF VSIs as the VF
> driver has no direct use of the VSI number on ice hardware. He also
> reworks some Tx/Rx functions to clarify their uses, cleans up some style
> issues, and utilizes kernel helper functions.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] ice: pass VSI pointer into ice_vc_isvalid_q_id
    https://git.kernel.org/netdev/net-next/c/a21605993dd5
  - [net-next,2/9] ice: remove unnecessary duplicate checks for VF VSI ID
    https://git.kernel.org/netdev/net-next/c/363f689600dd
  - [net-next,3/9] ice: use relative VSI index for VFs instead of PF VSI number
    https://git.kernel.org/netdev/net-next/c/11fbb1bfb5bc
  - [net-next,4/9] ice: remove vf->lan_vsi_num field
    https://git.kernel.org/netdev/net-next/c/1cf94cbfc61b
  - [net-next,5/9] ice: rename ice_write_* functions to ice_pack_ctx_*
    https://git.kernel.org/netdev/net-next/c/1260b45dbe2d
  - [net-next,6/9] ice: use GENMASK instead of BIT(n) - 1 in pack functions
    https://git.kernel.org/netdev/net-next/c/a45d1bf516c0
  - [net-next,7/9] ice: cleanup line splitting for context set functions
    https://git.kernel.org/netdev/net-next/c/979c2c049fbe
  - [net-next,8/9] ice: do not disable Tx queues twice in ice_down()
    https://git.kernel.org/netdev/net-next/c/d5926e01e373
  - [net-next,9/9] ice: avoid unnecessary devm_ usage
    https://git.kernel.org/netdev/net-next/c/90f821d72e11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



