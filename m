Return-Path: <netdev+bounces-207295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0AEB069EF
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 01:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8664A392A
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 23:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661612D4B62;
	Tue, 15 Jul 2025 23:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EotaRwYU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D47F2D3A93;
	Tue, 15 Jul 2025 23:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752622786; cv=none; b=CltHJUCHaTCibwlDe/muOTWn9uJ4i8+el1AWWtPv2wqhiHQzLN7J+q1q3rFCCjinY7aEPNAq5FftZfRPe99sKb3kLF3DzZvnVo4lABkanTv4w5hkwr3awIShSUo1cKqApNIavvVSOLHsZ9DvsCcdR2oINmRp3+Ms+0phDsPn93Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752622786; c=relaxed/simple;
	bh=q3QIBc/TsdXBWirwIMIHxwp+8kRlnWdwqh1CRlQ82NU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L3mRDxtTriBXW85Drtl7HYO00hH9NN9OII18wVRJ7TQ6hZyDLaAOxEVVXvds8/2sDd7q45R6eY9IPugTn7trSvNUeW1fI4CyLXTR85slXPoOswVyzjYJt72x41m2mCozU4RGZsbPD5FyP79hy+xdgP5u8GOE/Ttf0qyNjhdUDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EotaRwYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9497C4CEE3;
	Tue, 15 Jul 2025 23:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752622785;
	bh=q3QIBc/TsdXBWirwIMIHxwp+8kRlnWdwqh1CRlQ82NU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EotaRwYUI7AAtHpn69V6T63FUu/TQgcsEuWQOrGJo5F/IWGf/z8IHUenYw8Wive+q
	 SW+2AYdXXZnmnd1P07d86pJso5KevSYAytDeXBV8yKUD8jzz8mYgCQGDyf91U4sHFq
	 P6IMnFoISHnRqz3EQjKoshItmjaTR2ckZ6hVNdApnhi06fRk7/SC1Ug8Fzsqatr2IY
	 Dx9rJYvDkp/2iyFt4NSFObtVDPvbC0Wy40Fs2/gScMSVKTw2qrM83nX406DfumOpWO
	 fDyy21UbuPE1UQBOdAlXT8ewL0TuaC6fcxGrIBpcfh3CdnUH2vzUnPkpaADF5HJmS1
	 w9ZyS9PBNsmhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7167E383BA30;
	Tue, 15 Jul 2025 23:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: stmmac: intel: populate entire
 system_counterval_t in get_time_fn() callback
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175262280626.617203.5242260114409933910.git-patchwork-notify@kernel.org>
Date: Tue, 15 Jul 2025 23:40:06 +0000
References: <20250713-stmmac_crossts-v1-1-31bfe051b5cb@blochl.de>
In-Reply-To: <20250713-stmmac_crossts-v1-1-31bfe051b5cb@blochl.de>
To: =?utf-8?b?TWFya3VzIEJsw7ZjaGwgPG1hcmt1c0BibG9jaGwuZGU+?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, tglx@linutronix.de,
 lakshmi.sowjanya.d@intel.com, richardcochran@gmail.com, jstultz@google.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 markus.bloechl@ipetronik.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Jul 2025 22:21:41 +0200 you wrote:
> get_time_fn() callback implementations are expected to fill out the
> entire system_counterval_t struct as it may be initially uninitialized.
> 
> This broke with the removal of convert_art_to_tsc() helper functions
> which left use_nsecs uninitialized.
> 
> Initially assign the entire struct with default values.
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: intel: populate entire system_counterval_t in get_time_fn() callback
    https://git.kernel.org/netdev/net/c/e6176ab107ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



