Return-Path: <netdev+bounces-135998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4FE99FEA8
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 04:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2838E1C20A48
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA00E14884C;
	Wed, 16 Oct 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJry3fXr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57C913B298
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 02:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729044628; cv=none; b=Om0qWW8aO80wWIRHBEqPC9NJzKuG/qH0Lc7iEBhIFo5p+uMygyM7rBEj9NSm6+KsJQeGUb+fzyKyFnJKykNh8J7Zxsx13tHpSEJSLrULWt1bIUTrJukmi9Hi3Fr5cQdZ7WKSJffwtW6GB5D2C0amq7PfYpfWdV+tueP0BX/7Rdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729044628; c=relaxed/simple;
	bh=i1vz7VftQSmx6iw3x1wUi6jRTgpOVzd4ACOsyLuMVJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Or4IfYXxMv2XEraGBBKttDAkJeCxAOyYcPq49c8x/UR7yH8D0s+Cr1YEkQvak79gg8nDAGKCOjxDFo0Vm7+COel1DJtBRrvXzkDLuI3E2YHlJ/ujcC7CtbuX9QEaG36JUj4N17pm0FjzDMO16aLXKqK6yDlQK2ZSNeoxGD02qKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJry3fXr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4971CC4CEC6;
	Wed, 16 Oct 2024 02:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729044628;
	bh=i1vz7VftQSmx6iw3x1wUi6jRTgpOVzd4ACOsyLuMVJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XJry3fXrw/Rb1CeDqoNod4SnwVAMI/jjUcFE4yLC6U5yq7RqTuz+nBrh2zBpY7Gmt
	 6Yf+XbCeyBLIqgHqtbvAE/1KmU/104fXbycDExFaG9qbi73zXxMA/IJ2wg0Ao3BZeU
	 iVv4JKhhsOIH489ZaTiVkGoRrk8KvD6Xogxpt8URyayRu2aHfV4eFw2H+xirmkMYL9
	 f2Z8ltGS4pbBWnuLYOnyrES2dD6i6t944eneBKsws+3iRLryTez92eaIVcRQe7EMu0
	 us859jwsDMpPDDvXsar0Un79xA3Bsns2vN57+nSAWIo4p6FGPvLsXW/xFEPNGDhdTi
	 9osF7edvxvxAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE51F3809A8A;
	Wed, 16 Oct 2024 02:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] gve: adopt page pool
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172904463350.1358504.15567518656633150675.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 02:10:33 +0000
References: <20241014202108.1051963-1-pkaligineedi@google.com>
In-Reply-To: <20241014202108.1051963-1-pkaligineedi@google.com>
To: Praveen Kaligineedi <pkaligineedi@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com, jeroendb@google.com,
 shailend@google.com, hramamurthy@google.com, ziweixiao@google.com,
 shannon.nelson@amd.com, jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 13:21:05 -0700 you wrote:
> From: Harshitha Ramamurthy <hramamurthy@google.com>
> 
> This patchset implements page pool support for gve.
> The first patch deals with movement of code to make
> page pool adoption easier in the next patch. The
> second patch adopts the page pool API. The third patch
> adds basic per queue stats which includes page pool
> allocation failures as well.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] gve: move DQO rx buffer management related code to a new file
    https://git.kernel.org/netdev/net-next/c/93c68f1275f9
  - [net-next,v3,2/3] gve: adopt page pool for DQ RDA mode
    https://git.kernel.org/netdev/net-next/c/ebdfae0d377b
  - [net-next,v3,3/3] gve: add support for basic queue stats
    https://git.kernel.org/netdev/net-next/c/2e5e0932dff5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



