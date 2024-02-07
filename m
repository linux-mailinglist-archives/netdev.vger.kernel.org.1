Return-Path: <netdev+bounces-69893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA5484CEE2
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 17:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23F631C25D60
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 16:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7D781AA1;
	Wed,  7 Feb 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiW52+9C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1BA80035
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 16:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707323428; cv=none; b=s7v4ZXv/BQ3bOk+W007UkFIj6Ss0K3b4dLzOgH1seitpSyymyL8dUxk7It8sSRuGnwbg7jaF6d4kRnm1xt9oWTTDzKa/ZZeVKOogzDlj5OI+aFAL3ZajY5tsOm8n/4DsArWrmWqMZkhH2oxMJJUYIYcFQeSTjQeBGtmr2iMHGho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707323428; c=relaxed/simple;
	bh=K0adONo8PpzTxplkQJIQkLflc3fHvAAoNNFtGVHuV8c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RryJ5j+5y4qm4KEDaHdZ68cpHz0VkvnDUwHWhY15mmgJVFDl8Y2Av4CEcQAkekxpmKwdBc7AvhfggTQoSVhSUIHGjgsxMVii1aymfzcceXVNTVfllbYx4rmjAnjAEy17K6RmHjBOL/n1n04Q2uGwHfGU2L45K6Xn8nnafdUzX4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiW52+9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 982FEC43390;
	Wed,  7 Feb 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707323428;
	bh=K0adONo8PpzTxplkQJIQkLflc3fHvAAoNNFtGVHuV8c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fiW52+9CY7SPOzVuQCksExvnnHfNzSC5g4Sob373e8ASjzxCbaq87xs0J2eBCsWkD
	 KAIgH0s6uHeuQZyezzk8CxZl81KXzUHKYVwMe3esvWyaegSBqdPLt4u7T0GQxcgtJg
	 C+4DZIqbW84PoZRP9cSCQP3jgTB4cPu3LD4aasaZf1fsh2i1ns6m79czDrLUC2Q02V
	 G2ZrzEUD44Y+oxkiPnhnuo0flU8kasWywC+z/v6+kH2CqVtwBdlYuoeqREmynTq2pr
	 5XaW+QRhhe9RsC6ZLcYjdfBc57O9NIOqu3HOxwXSc54lvRkwge6+WcNT90WZU/IQ1q
	 GqKVv50Dgaoqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E5B6D8C96F;
	Wed,  7 Feb 2024 16:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] ip/bond: add coupled_control support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170732342851.21265.15674501372010367095.git-patchwork-notify@kernel.org>
Date: Wed, 07 Feb 2024 16:30:28 +0000
References: <20240125231148.416193-1-aahila@google.com>
In-Reply-To: <20240125231148.416193-1-aahila@google.com>
To: Aahil Awatramani <aahila@google.com>
Cc: maheshb@google.com, dillow@google.com, j.vosburgh@gmail.com,
 dsahern@gmail.com, liuhangbin@gmail.com, stephen@networkplumber.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 25 Jan 2024 23:11:47 +0000 you wrote:
> coupled_control specifies whether the LACP state machine's MUX in the
> 802.3ad mode should have separate Collecting and Distributing states per
> IEEE 802.1AX-2008 5.4.15 for coupled and independent control state.
> 
> By default this setting is on and does not separate the Collecting and
> Distributing states, maintaining the bond in coupled control. If set off,
> will toggle independent control state machine which will seperate
> Collecting and Distributing states.
> 
> [...]

Here is the summary with links:
  - [iproute2-next] ip/bond: add coupled_control support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=e8dcb1214a21

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



