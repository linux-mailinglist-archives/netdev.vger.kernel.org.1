Return-Path: <netdev+bounces-105092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD1890FA44
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7940D1F21F10
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4E8469D;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaEWEVIF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB91C06;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843428; cv=none; b=sbFm4ZFgWQihrq12eFE+EsmaGj/EBHx4Z2Rp5QFfNXu/09WWdRrrFQZwcAb5xooXFTlmeLVzY3VQweXyYJNn1tHq9kJYrZmtXrW/qmdIdtxVfCZ00x/mwDp5T7Zmbewc3O6ElO7S0pT8FaJyWoIfeJIEKLXi9eTJYxqH8KQZwWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843428; c=relaxed/simple;
	bh=5tbk9+Fr16/riDnMOtgnfheqzFQwhcOjQtRbMoh4Fgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k4fMpHJK1dOQgS2eGxklf9O9GraEvMB5VHcMygkL0A8Qtjt7HQcuCUOpF55fB+EsjH+6Y/tj5tU5h7E6AvWbAVCtaS63pBEARi8XUmFYdnOft2k2rU+g8c/xXYczoNuPUuHVTyMO0/3lFEtXB1tW608ljL/+gGrYDxYXDRSoTKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaEWEVIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0579CC4AF0B;
	Thu, 20 Jun 2024 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718843428;
	bh=5tbk9+Fr16/riDnMOtgnfheqzFQwhcOjQtRbMoh4Fgc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jaEWEVIFwMtn4wdcGZOcRJK1fX5AQ+Wlh9iiv26PBUVr0MjPcVOuJm+WY9YCoFgAO
	 QSOCgPDs3o9zJuz4/qPru0UYWcqoytoD5GZQMM6VFtw2K93XzV53tI5aBL2VXgqRN6
	 2xBnQErshPnDqCCcaPBQjfQLS6YW/tCm4oZcbp4+0KR6sZezXlqTS+TrLp9TG3mKGu
	 fRh1YA1IktrzT+oEJUeI1LqwAcM4Tf3bBSAKvn38YOIZy6nuMAqa5qzA2IN55OacRu
	 d9Oq7XSVJPkUS+9jZBGCpggHfc5eZUBfkqY0mlxrtGGNjEXBjZpK8y2s6XUl4qs/2I
	 3IV/EMh7uCLQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F1D4AE7C4C5;
	Thu, 20 Jun 2024 00:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: smc9194: add missing MODULE_DESCRIPTION()
 macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884342798.23279.345235713034514694.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 00:30:27 +0000
References: <20240618-md-m68k-drivers-net-ethernet-smsc-v1-1-ad3d7200421e@quicinc.com>
In-Reply-To: <20240618-md-m68k-drivers-net-ethernet-smsc-v1-1-ad3d7200421e@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 10:56:28 -0700 you wrote:
> With ARCH=m68k, make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/smsc/smc9194.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: smc9194: add missing MODULE_DESCRIPTION() macro
    https://git.kernel.org/netdev/net-next/c/2b0cd6b7270e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



