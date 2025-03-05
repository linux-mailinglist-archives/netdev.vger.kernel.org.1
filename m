Return-Path: <netdev+bounces-172019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8B9A4FEFE
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C84B3ACB67
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FEA1EDA26;
	Wed,  5 Mar 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTSUJq5Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F313633F
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 12:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741179000; cv=none; b=Mghh5t1/qSish20Az41Owwozev4/FkT/kOD7PxiSOM9+HpXXFPWb0jGDILy1xU4QPqxojS3td8waNj7GOd9o8MV+fMB8FXri6tAxkhXTF/EtF2zjMPQZIoPtCjeez5pyELTz4B8T3cXy3KJmiYB5YX0Hu1sluj/MrJWD5gFSnqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741179000; c=relaxed/simple;
	bh=KHlpuzuOwYVWpkheoJ2LxJf2IaKbdHRqMjdN29NewF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TTXGc31qFeeW0f80OHosPrVUh4iZinO4UiBwEOXBVT+9nrGdfpAnI10ybq3YgpAXzGH8TYwhnoLHVQr70xqrgF/Owwg3qbJTL+ap07cYQfu+09ZlLxNhcWW/QuPJb0ks3gyzpwCL36f1rMpN/EiqzlF0Ehtlr/MdmDY7VuE5Cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lTSUJq5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2201DC4CEE2;
	Wed,  5 Mar 2025 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741179000;
	bh=KHlpuzuOwYVWpkheoJ2LxJf2IaKbdHRqMjdN29NewF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lTSUJq5Z/JpED0QqVCgPQx723A5a3od7xZDIbT2W5dXFDjPbJfh0JAwP6Z814ZXCT
	 EANhQlt/BsOyvveahKfRkIhufFQBr2YHTPX/dZys4jC7fhp01hhtBezBZ7puU/XQK1
	 IzTwYvgWkQbfqgF7F6gl/K3pNZcafcK6ofDI+8EtgLzF9CTGXHrsoHXsbAG/cT7NPq
	 ezqHXKzVc4Ux5iUFyIRdYf3/AtFNSRmsYFhwb+XLUfqnb9dgWCh+2Utxqj9IKJUepE
	 qywfjhV1/HRGUnI+T6GGH6QE3KOkIv1wTWo8IOpEApMPvtysCGJIdH1kzmgYoiLc1H
	 YmqD1J4gtSDjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE9380CEDD;
	Wed,  5 Mar 2025 12:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/3] Permission checks for dynamic POSIX clocks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174117903325.870005.17317001813536727921.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 12:50:33 +0000
References: <20250303161345.3053496-1-wwasko@nvidia.com>
In-Reply-To: <20250303161345.3053496-1-wwasko@nvidia.com>
To: Wojtek Wasko <wwasko@nvidia.com>
Cc: netdev@vger.kernel.org, richardcochran@gmail.com,
 vadim.fedorenko@linux.dev, kuba@kernel.org, horms@kernel.org,
 anna-maria@linutronix.de, frederic@kernel.org, pabeni@redhat.com,
 tglx@linutronix.de

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Mar 2025 18:13:42 +0200 you wrote:
> Dynamic clocks - such as PTP clocks - extend beyond the standard POSIX
> clock API by using ioctl calls. While file permissions are enforced for
> standard POSIX operations, they are not implemented for ioctl calls,
> since the POSIX layer cannot differentiate between calls which modify
> the clock's state (like enabling PPS output generation) and those that
> don't (such as retrieving the clock's PPS capabilities).
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/3] posix-clock: Store file pointer in struct posix_clock_context
    https://git.kernel.org/netdev/net-next/c/e859d375d169
  - [net-next,v4,2/3] ptp: Add PHC file mode checks. Allow RO adjtime() without FMODE_WRITE.
    https://git.kernel.org/netdev/net-next/c/b4e53b15c04e
  - [net-next,v4,3/3] testptp: Add option to open PHC in readonly mode
    https://git.kernel.org/netdev/net-next/c/76868642e427

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



