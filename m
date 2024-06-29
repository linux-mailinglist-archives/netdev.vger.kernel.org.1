Return-Path: <netdev+bounces-107865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E16591CA1B
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 03:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DC31F234FE
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 01:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83214430;
	Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxz9KWB0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8B84C9B;
	Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719625857; cv=none; b=LdnjdhtlWXpcVxAfbdP2rRGdElZ0O85XDDXMqfZKdViRPUv3XFIQjgXSaOWIwM3o10FlwB1XZnqckXSO6lv27HcTMzjXgmNFGNPUh12NEuOwWQq1DPkbIMi2BQ61J+h6knDDC7cfBAebOmx9247PBfRWGop4UH9ytugGw+9xN5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719625857; c=relaxed/simple;
	bh=tMBJ2LXx/dnk78cRCcMR9KMlYhZ5F3RBrYlA8i/kjcg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hBuQXs7H3tiqsckH5wQz6Ua0iU6iLmqFD7SRkke18pl4//ItieKFgCPc6/YGbOMS/j784PVmPgv+FbrmHPnnz3TJ4jClhWQLVPjlXCPy9dBISeg1ihr7TmMOtk7NA2Zi+OgAhBoUDfAXw1LkRTyBUb8P1VUxSYi3EAw/jYlFEPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxz9KWB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F202C4AF0A;
	Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719625857;
	bh=tMBJ2LXx/dnk78cRCcMR9KMlYhZ5F3RBrYlA8i/kjcg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lxz9KWB0xfSLgGjM/SOF/M5qpKq3g6r5sPXSFgSWdNwCNsB5V1vSMb2HYDwHqPC8G
	 VN4uKA6aQIHjfLJ8TwoD2CQL8NNt+M7NYoGYEZqnfIQcKYPTVYHqj/F8/EtiPhnSVi
	 WJx3rA+7wnmsG+1GncBX/AknfbhjbWiV62KHKRTPZQA0XqLlqOf7QnwY6mZZ351fqK
	 s/Okp3HvcJRBrWPVIpJ+AfyKOgjeD0wn3/OyKgh5+sruPpL0bj7abBBPimdCWO43oA
	 4pZQeDbTLtvnsRsw9oj4cWeFCfWgCjKO9K05GZkWHbbsqXe75WRN5KbAwgIQ8RZOWc
	 EDkTAZFcJqi8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2648AC4332E;
	Sat, 29 Jun 2024 01:50:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] enic: add ethtool get_channel support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171962585715.15618.2237630568990329339.git-patchwork-notify@kernel.org>
Date: Sat, 29 Jun 2024 01:50:57 +0000
References: <20240627202013.2398217-1-jon@nutanix.com>
In-Reply-To: <20240627202013.2398217-1-jon@nutanix.com>
To: Jon Kohler <jon@nutanix.com>
Cc: benve@cisco.com, satishkh@cisco.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jun 2024 13:20:13 -0700 you wrote:
> Add .get_channel to enic_ethtool_ops to enable basic ethtool -l
> support to get the current channel configuration.
> 
> Note that the driver does not support dynamically changing queue
> configuration, so .set_channel is intentionally unused. Instead, users
> should use Cisco's hardware management tools (UCSM/IMC) to modify
> virtual interface card configuration out of band.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] enic: add ethtool get_channel support
    https://git.kernel.org/netdev/net-next/c/bf7bb7b43097

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



