Return-Path: <netdev+bounces-158052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA7FA1041A
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 11:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2971889AD6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF8F22DC4A;
	Tue, 14 Jan 2025 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS8H5KmU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FF22960A;
	Tue, 14 Jan 2025 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850613; cv=none; b=YJMHuYpB11yID0zUsY+nMGBLJeUsYFR/9haXbscUb4I+cb/Gg+QowGNM7WrCKREmK8p6RV1NJNIbRmWcWvgoDw57+mek15pCIAbaSA51LqcSHIaOFmY9ml0nWynBfJsaiLRCn36vQMRboEmDFHeRi6HL309JDSzxrxWtjjUU7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850613; c=relaxed/simple;
	bh=caLyTsrsq+Ds0zhean1mvhe1mD7qnouTvrF7Nc6b++Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IL6xzPEpzfylv9LZeKx8g3jsQiBG2pKsK8Mhgg9e68L4vz/hPJc7lpxmxYwZBGxipFpcO6h3AOyxYQ5529ak2H+47TFGs3knevMZ8NlbTZyxXeWFgbHIGdMIyS2xx+oIKeo4uglWIuhKS1vryKJzrJqmkWOq4tQvXCPGBU/ee7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS8H5KmU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F1C3C4CEDD;
	Tue, 14 Jan 2025 10:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736850612;
	bh=caLyTsrsq+Ds0zhean1mvhe1mD7qnouTvrF7Nc6b++Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NS8H5KmUnw6Mmz1/RDsshGdP1cgLSLalzHWegrfTTrokSSuLv/VT4IRP03RQlEktP
	 KHUkyu8Cj5O4F7OKn9UMnZ22idxVfbcO628+Es+Ipin0Ph29UQ//L6trcMq4lqSoDX
	 vNrsP5RHzFXSQ2VM67Gj59jATVsE9NrEE42tvmDuYzNrMy03SLQ9DvOqFQ4phtePs8
	 9Bfd/jfwepaf8eE5ZOImDWjh+wSZHZ3CmhR8Q0JZwRo1SIh84cTRs8MrH167pNdbwg
	 pA6tGsYfE0OHayLL3npB29BwxGgKukwpL9ROy417rqgW6rOsb9uDKhhqBJvSBQ9iRw
	 x8oV1LgcIKbYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71127380AA5F;
	Tue, 14 Jan 2025 10:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: microchip_t1: depend on
 PTP_1588_CLOCK_OPTIONAL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173685063523.4128008.15547823758049587409.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 10:30:35 +0000
References: <20250110054424.16807-1-divya.koppera@microchip.com>
In-Reply-To: <20250110054424.16807-1-divya.koppera@microchip.com>
To: Divya Koppera <Divya.Koppera@microchip.com>
Cc: andrew@lunn.ch, arun.ramadoss@microchip.com, UNGLinuxDriver@microchip.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 richardcochran@gmail.com, vadim.fedorenko@linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 10 Jan 2025 11:14:24 +0530 you wrote:
> When microchip_t1_phy is built in and phyptp is module
> facing undefined reference issue. This get fixed when
> microchip_t1_phy made dependent on PTP_1588_CLOCK_OPTIONAL.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:
> https://lore.kernel.org/oe-kbuild-all/202501090604.YEoJXCXi-lkp@intel.com
> Fixes: fa51199c5f34 ("net: phy: microchip_rds_ptp : Add rds ptp library for Microchip phys")
> Signed-off-by: Divya Koppera <divya.koppera@microchip.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Simon Horman <horms@kernel.org> # build-tested
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: microchip_t1: depend on PTP_1588_CLOCK_OPTIONAL
    https://git.kernel.org/netdev/net-next/c/6a46e3e87b59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



