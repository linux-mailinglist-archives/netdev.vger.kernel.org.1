Return-Path: <netdev+bounces-191826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F85EABD75B
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 13:51:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEC04C00A6
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A93272E7C;
	Tue, 20 May 2025 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm3NxKKd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D55021C9E4;
	Tue, 20 May 2025 11:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741860; cv=none; b=ukSmM8ti8PcfsQHug/uzhNrAc2JZ/jg4QcDtsZ/Q7R3f5am04cNsWWndeHW/tInbzgI3HTFAb5VRtOrnBZJqGJheeORpWv2lncmb1VWPf2IlcXVF8gLBVuuj+fO0OFD7xb5RN1VoWq2EMpPQ1J4Pmyk8c5S0EfELlXDyzjlBrR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741860; c=relaxed/simple;
	bh=wMmHFS/gxUNNJrLm22zPA7ZFKO+YAqOzLA8fh4rwx2c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gDO9sVv+hjAiiMOwDRW297Yrft3hm7be6WAhdLZ2UhSsevFm8hS034Wa5J1lnfefgsGxXd73R3F97djz5jqY5NQrN2MGt9kMrHQ58l5CJ6pIayjAhNtuenIjKN2FD12XPdn/KMPGxqOgHxIyC0CUaalsjbemU3Ha+sDytfQ8sI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm3NxKKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C11C4CEE9;
	Tue, 20 May 2025 11:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747741859;
	bh=wMmHFS/gxUNNJrLm22zPA7ZFKO+YAqOzLA8fh4rwx2c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tm3NxKKdZURD99cPkKRWm8amh5/VXVYB1zb8111LQguUYGjsTb2pM3400/J7klL+f
	 ntS9uqOHl8fl1heIbJmdgmFKY9LOYtHkXaEKPoQA99z0HL7/Igm/irr4KQAQLPw8tc
	 SabuNtg1jDfsJ4ZA48fe0D3GoN8oI2OYgyPuE5xL2Tk4WaUzr2meJ/4AytAABr8wGZ
	 6J3ZzBEufCWENWLvzwdNGc41JIHwNHzw0ScD1UUadL+gyzibOXqhK+RhoHmm/Ht1te
	 u/hwYVss6CrvNbJFT+IBHIfKZc0SQMqQttsGQt/yc4ScaIEAX9q8+nOuAQwC4gAxGV
	 aQDkklfKGDIJQ==
From: Mark Brown <broonie@kernel.org>
To: krzk@kernel.org, bongsu.jeon@samsung.com, cw00.choi@samsung.com, 
 myungjoo.ham@samsung.com, lee@kernel.org, lgirdwood@gmail.com, 
 Sumanth Gavini <sumanth.gavini@yahoo.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250518085734.88890-1-sumanth.gavini@yahoo.com>
References: <20250518085734.88890-1-sumanth.gavini.ref@yahoo.com>
 <20250518085734.88890-1-sumanth.gavini@yahoo.com>
Subject: Re: (subset) [PATCH 0/6] fix: Correct Samsung 'Electronics'
 spelling in copyright headers
Message-Id: <174774185808.57504.13103081614395740317.b4-ty@kernel.org>
Date: Tue, 20 May 2025 12:50:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Sun, 18 May 2025 01:57:26 -0700, Sumanth Gavini wrote:
> This series fixes the misspelling of "Electronics" as "Electrnoics"
> across multiple subsystems (MFD, NFC, EXTCON). Each patch targets
> a different subsystem for easier review.
> 
> The changes are mechanical and do not affect functionality.
> 
> Sumanth Gavini (6):
>   nfc: s3fwrn5: Correct Samsung "Electronics" spelling in copyright
>     headers
>   nfc: virtual_ncidev: Correct Samsung "Electronics" spelling in
>     copyright headers
>   extcon: extcon-max77693: Correct Samsung "Electronics" spelling in
>     copyright headers
>   mfd: maxim: Correct Samsung "Electronics" spelling in copyright
>     headers
>   mfd: maxim: Correct Samsung "Electronics" spelling in headers
>   regulator: max8952: Correct Samsung "Electronics" spelling in
>     copyright headers
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[6/6] regulator: max8952: Correct Samsung "Electronics" spelling in copyright headers
      commit: c451e2da54bce183fbb270ec01ab3ca725ddf943

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


