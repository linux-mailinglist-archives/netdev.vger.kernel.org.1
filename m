Return-Path: <netdev+bounces-111325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D9D930824
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 02:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 227A4B216CC
	for <lists+netdev@lfdr.de>; Sun, 14 Jul 2024 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC6E63C8;
	Sun, 14 Jul 2024 00:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+FOHihq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E4823B1
	for <netdev@vger.kernel.org>; Sun, 14 Jul 2024 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720915231; cv=none; b=ZIzHNSsr5l3s7y3KG+a/Vy9+5bJx6DIVFgqz1eev2V1KNV984LJxAyhJQ1fpugqXGYK4ai5tKR3fNG748GgIEy+33ZfIWsJBu7rfMmMxSVv2iqjpI2YmKbiaHLiTLnBfE2gUcc2nat865NpDkO1frPXOklLifhFRJhGFvzVplF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720915231; c=relaxed/simple;
	bh=Q3F5Wx7gTEODasDO/Ny9aMqM9VeU7+qVVj27U5AWuPo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i79aVZ/dhGwJXRVWX5HUILo5ayyLATOCD+tEkWTY+BhqznTxwyjRnTZp5xl9AbgKi8teKBX1VjxHqqVGtREnUYjH06kqLTtA4zUPg4eKETFpEF1unSxDaFUodgrDV3P+gxMqyFL1peLKfsocboR3GXQXF9f1GXBr23JoRbZ17YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+FOHihq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66D82C32786;
	Sun, 14 Jul 2024 00:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720915230;
	bh=Q3F5Wx7gTEODasDO/Ny9aMqM9VeU7+qVVj27U5AWuPo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G+FOHihqdy+bA7YfxulZCxcI8ULsCVWn82AnBMhOFayS2uGTuzMj5cYRfgnecCCnD
	 gVc2OBI3tY0UlXbCNQxq8tZYdMkSd39OH7cWhpz6cGcOXZkRK6WIuKett8lxu8jzdQ
	 ZJce5Ak4+4cEa8kA1RjbZ+GGY5GqtRDPZuCeiid0iXtZ4uLrjPk7wLXAyPzotUggir
	 NHIfVd5BrI2/+yG2T8GwJ15FYmFOSJwMxHT+lAWdN+wnVGjV7o9rC0mrf26zdRip+y
	 bjnFbTeXviyl78uB7Iuosw4+J8WwytVtb5xQYu4Vq0S80emAnafgyaCcUNTAF10WHK
	 xa2e4qKyEK4pQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5A19BC43153;
	Sun, 14 Jul 2024 00:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5][pull request] Intel Wired LAN Driver Updates
 2024-07-11 (net/intel)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172091523036.919.18189384871171457774.git-patchwork-notify@kernel.org>
Date: Sun, 14 Jul 2024 00:00:30 +0000
References: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240711201932.2019925-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Thu, 11 Jul 2024 13:19:25 -0700 you wrote:
> This series contains updates to most Intel network drivers.
> 
> Tony removes MODULE_AUTHOR from drivers containing the entry.
> 
> Simon Horman corrects a kdoc entry for i40e.
> 
> Pawel adds implementation for devlink param "local_forwarding" on ice.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: intel: Remove MODULE_AUTHORs
    https://git.kernel.org/netdev/net-next/c/bf130ed3aaa3
  - [net-next,2/5] i40e: correct i40e_addr_to_hkey() name in kdoc
    https://git.kernel.org/netdev/net-next/c/4c8c36fe4e3b
  - [net-next,3/5] ice: Add support for devlink local_forwarding param
    https://git.kernel.org/netdev/net-next/c/a59618b98543
  - [net-next,4/5] ice: remove eswitch rebuild
    https://git.kernel.org/netdev/net-next/c/aff6e32cc7ff
  - [net-next,5/5] igc: Remove the internal 'eee_advert' field
    https://git.kernel.org/netdev/net-next/c/1712c9ee36d1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



