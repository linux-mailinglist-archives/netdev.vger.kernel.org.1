Return-Path: <netdev+bounces-110977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F30992F306
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99E05B2241C
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8714391;
	Fri, 12 Jul 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InVVqMNb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925B4376
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744255; cv=none; b=FtWGw/ebNXP9CMfrNm0CyocD9Alv38kkByOeftMpJxey1RAJg7aiGskJZko2g64mkqHiFzO+G5Jr5oZvIk06bSJWMkwJA8usfkKuiDLNdUnkcbHlYZAZZ8bTK7aCQuqCzfiHOqQ8aLDSKGl3/vzcrGFUo9KxkJ8xqodMZbsPjFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744255; c=relaxed/simple;
	bh=bSjnPr4RkF5tKD8Mg7tywi7Lp+7uA9a60KVILTDM86c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T405WJhmk3AS/k2IB4y+VMdVb+0MGOxRbggBFiMlRzafHUiitLSLEj9THJZ8j+5Osg8npiHzMEzup5j1foy3JnkyukCnk5fFxTaOmdVIEIWr8YXbKt7xy8RnlwWk53x0tFmRG/yNUlVLOiTCYEQJJnYieSBH7hqeUkHBXdP+Ngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InVVqMNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B329C4AF09;
	Fri, 12 Jul 2024 00:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720744255;
	bh=bSjnPr4RkF5tKD8Mg7tywi7Lp+7uA9a60KVILTDM86c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=InVVqMNbXMrd5PCB3mX71MQVsOI2S+fx9nYV/X2cX3sOc7wMEJnnkxrEIcy6ZiWRK
	 BO4Gyerwt+2N5Tm20cOOsgBiNqHliJ/OfREtz0I2M/sL+VEs4JaqNejbt5pa+V5lDD
	 M/KT6FlH5O93UuaTCO2HZXMbat8TPcCAr9zExTIvBGCcxRaokpvA3Sxw/NImUN3qmo
	 3oLq6VArYIgyfIXyQ8oi3rdwBkgJHcPcti5i1koDdS7oREEB5mQz8dnH7wBdiKfdHv
	 MzyzMqFZ34O+R3ZkgG5bSNua2flv0CB1wdmN6sJewRNtw7/IowAF9GZBOzzK4tDK9c
	 xX1pWYOMhH9PQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BD05C43468;
	Fri, 12 Jul 2024 00:30:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethtool: Fix RSS setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172074425523.19437.4242532876475137482.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 00:30:55 +0000
References: <20240710225538.43368-1-saeed@kernel.org>
In-Reply-To: <20240710225538.43368-1-saeed@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, saeedm@nvidia.com, netdev@vger.kernel.org,
 tariqt@nvidia.com, gal@nvidia.com, leonro@nvidia.com, ahmed.zaki@intel.com,
 dw@davidwei.uk, asml.silence@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 15:55:38 -0700 you wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> When user submits a rxfh set command without touching XFRM_SYM_XOR,
> rxfh.input_xfrm is set to RXH_XFRM_NO_CHANGE, which is equal to 0xff.
> 
> Testing if (rxfh.input_xfrm & RXH_XFRM_SYM_XOR &&
> 	    !ops->cap_rss_sym_xor_supported)
> 		return -EOPNOTSUPP;
> 
> [...]

Here is the summary with links:
  - [net] net: ethtool: Fix RSS setting
    https://git.kernel.org/netdev/net/c/503757c80928

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



