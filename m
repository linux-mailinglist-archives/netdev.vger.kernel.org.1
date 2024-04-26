Return-Path: <netdev+bounces-91509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 969EC8B2EA0
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 04:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F651F21142
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 02:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228DC186A;
	Fri, 26 Apr 2024 02:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8hRfjfe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31E11849
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 02:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098029; cv=none; b=VQsw+5xqswNsV2ZKPknqA6Q11sFCCOAsMW+F+P488xlFyID2MUlyVo8Iwn+0zilDy7ZtbFg5ii2Kfc8Vz307levkeO6Xjhqsw68HRp/ohwulEVCLT5Zc10eWcL7FDHQUTp4aBnH4i55ybIe2LNtDI3wHKl+HCwNnRmgiKzlE/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098029; c=relaxed/simple;
	bh=WN+jNcwDEfQ6pOtaJSrADx+N2lOqITTTm7d/rist+Zc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TQXHWQBsNWxZDMsRMWpQIIQOjt3ITK/O3YX3dg16lk012dZV3MmLXKXHyqI3nmR7TbmcmsvP+ZiwNTt+yLIZZWqxUIBBDW1EoDocEyli0l9hMlaaYQ3t7f+ZO/wow2plmSV+T1qTfQiIKPPKaTRppWtwzvGnivdcT7bkzSTRR/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8hRfjfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6674C2BD11;
	Fri, 26 Apr 2024 02:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714098028;
	bh=WN+jNcwDEfQ6pOtaJSrADx+N2lOqITTTm7d/rist+Zc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B8hRfjfeRT0zKBhlP5QKV8nnPA2DqcYC41Bnapl7n2XDBtg8sV3xcN2+QLdfl4m8x
	 po/RLXXH77MCZuFyXPboDjKhq0etlmbfwNR7tzAe1dcVEb8nx5hnzomjQTOcTTlqHA
	 3bu6DslfZjqOj+ODscrmzrzcsksE0EeuJ+dPKQdwORFq1/+PshUq/BE0b3629HdWcw
	 geL1Mw6n6wSnnQtH+DhbGtAenjHqIh2Kw+H29rj1T1PprGhwuybxLJp/aYkg0BZ2pg
	 zJJF2iO1+gXNvgfo/zhUgv029CvFelG0Ob6sPiR1c6bH14LsWgPRE6OjV6Sh+ik+Zh
	 uirHsywNuDGuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A926AC595CE;
	Fri, 26 Apr 2024 02:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/4] net: microchip: Correct spelling in
 comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171409802869.9165.13553858149750335707.git-patchwork-notify@kernel.org>
Date: Fri, 26 Apr 2024 02:20:28 +0000
References: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
In-Reply-To: <20240424-lan743x-confirm-v2-0-f0480542e39f@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bryan.whitehead@microchip.com, richardcochran@gmail.com,
 horatiu.vultur@microchip.com, lars.povlsen@microchip.com,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Apr 2024 16:13:22 +0100 you wrote:
> Correct spelling in comments in Microchip drivers.
> Flagged by codespell.
> 
> ---
> Changes in v2:
> - Patch 3/3: Use 'extack' in place of 'extact', not 'exact'
>              Thanks to Daniel Machon.
> - Link to v1: https://lore.kernel.org/r/20240419-lan743x-confirm-v1-0-2a087617a3e5@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] net: lan743x: Correct spelling in comments
    https://git.kernel.org/netdev/net-next/c/632c9550b999
  - [net-next,v2,2/4] net: lan966x: Correct spelling in comments
    https://git.kernel.org/netdev/net-next/c/896e47f5f481
  - [net-next,v2,3/4] net: encx24j600: Correct spelling in comments
    https://git.kernel.org/netdev/net-next/c/49c6e0a859f7
  - [net-next,v2,4/4] net: sparx5: Correct spelling in comments
    https://git.kernel.org/netdev/net-next/c/d896a374378a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



