Return-Path: <netdev+bounces-218884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4039EB3EF33
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3051A86F53
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817EB267B00;
	Mon,  1 Sep 2025 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjQ5R9q+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE25265629
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756757405; cv=none; b=bozYfLfrA0sddtVWCVwivSW/cD5mD4dNwAN8FOiiUYTH/xShHiLb9gQvFAni2MLC+t979k2HsTb8NYGAL17/oM8jChX/mT8DtW9B//+R9+l9qpzK4n1nScBkH3m/EXQmMnAjHwdmKHj904vJJgsrEEtPEwDnNllY3sb6x5hOBMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756757405; c=relaxed/simple;
	bh=bbVq/cx/nAO9L8IB9GgZSobg/Lsav7bG4gFSomJdBrw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XH5q1z4RS4LeYM1VjeTT6FNCPAJp6Rn79Uv2E+oxLzE8S4SKlSqQcWDk0YsMXbWM0QeH910rW9joaw4mkfDgBMhbPU7mUlU6ZSXPbZ9c6WN+wjLTX8jLXsbfKiZcFuSl/LdEq/se8SXn1OPW0vfO/6Tj6sk8rbqyi1jrGhziSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjQ5R9q+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393C9C4CEF0;
	Mon,  1 Sep 2025 20:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756757405;
	bh=bbVq/cx/nAO9L8IB9GgZSobg/Lsav7bG4gFSomJdBrw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gjQ5R9q+FfV/WSMSDHUR/S/2XFLWF2d54muyZjnKbJvM02UWLhhk1U8UGERKRHYNA
	 mQCkEW1CQNhvFw/Y/qsfy5c3CamRhga5I/6KlxqphizJuZwiP1N5FKcHcz9NX8AIiS
	 P+6oshfnZE9pr2eYj16C/D6M9I7MSROIDX3jl0QfYObIR48ekM5/nfTe6P0BERzWSh
	 ldO14h9QNrjetWQDNyD2wFJJGliu6V00QUudmz6TESGv7mPqyFFvj+jldsPNRosDvp
	 l52fk3BBj5KYc+/EwnV9DO4eJ9Sh+5iKe9NbYE2yLd7lM9vT4SbJ0RLLhXYtbm1Ftk
	 6vUNX+nUMz+4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E25383BF4E;
	Mon,  1 Sep 2025 20:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] ptp: Limit time setting of PTP clocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175675741099.3870710.1056034775487131143.git-patchwork-notify@kernel.org>
Date: Mon, 01 Sep 2025 20:10:10 +0000
References: <20250828103300.1387025-1-mlichvar@redhat.com>
In-Reply-To: <20250828103300.1387025-1-mlichvar@redhat.com>
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com, tglx@linutronix.de,
 jstultz@google.com, arnd@arndb.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Aug 2025 12:32:53 +0200 you wrote:
> Networking drivers implementing PTP clocks and kernel socket code
> handling hardware timestamps use the 64-bit signed ktime_t type counting
> nanoseconds. When a PTP clock reaches the maximum value in year 2262,
> the timestamps returned to applications will overflow into year 1667.
> The same thing happens when injecting a large offset with
> clock_adjtime(ADJ_SETOFFSET).
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ptp: Limit time setting of PTP clocks
    https://git.kernel.org/netdev/net-next/c/5a8c02a6bf52

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



