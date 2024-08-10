Return-Path: <netdev+bounces-117360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B4294DADC
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 07:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B4D2828E7
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 05:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E213C9D5;
	Sat, 10 Aug 2024 05:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEfWud5v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373F913C9A1
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723267237; cv=none; b=MyTinv38fYwmynYRn8xbM7YEgmWQ/DANND3vP8Ph0K8b7wNSEcgulyYJUUyOgIsHLqBNaOzOAZm7AqMH/fhGMtZ4G2c0tNJSuNJEm8pYyDDNyfa32uwuMmp+kpacFG1PCnUNFDT8v+6Od3bDsP4JhuTkI72qXIsvsEsN6hSTt0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723267237; c=relaxed/simple;
	bh=pEEfv3vmgsgWjFL9twxRXvCoYhddOrILhxLgfBFZqS4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Exe/Ak9YDVfBqIVbFGOQI0wnvFXusQ0T5av2lksSJkWcRcHcwywypJDgupcjrTe4Gjp0FfkOmwPGnzdGSX7CjM08XNcksf3ngE4wjK+zqFDney/wMJBCWfDGCcbmFq/1DnU6GJgvV2m3GVtyNPq/Vttv7D4AgTt1tzyfW02QhNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEfWud5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6408C32781;
	Sat, 10 Aug 2024 05:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723267236;
	bh=pEEfv3vmgsgWjFL9twxRXvCoYhddOrILhxLgfBFZqS4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YEfWud5v9UDJl2pgZhsd4X/bI9QPBY7FDHUMXavLAy+i1HAIYeIHH2qFA1YfroElo
	 2wlq5nZsargsL3plt8Q/w5CY5Ac5/SIFFpNxli/dBEeqRDYJeJwNbC64B8/cZkQOky
	 x5qS5NHmXI86BpXujsY0BlTNKyzgVF6+cWtq1G5PyZs84p+Nx03lRubfu++zY+YiYt
	 lm1CPbz0Q56foP3V2cXvg0JyYCeblXp1vteREpz9lUpUyVEx2nxKsRzeUi85tGgr4F
	 OG9jRulPxaBkKQcGOD5vAMNwu5nUsRi7BABCS7ZVVhtBzzn/nSWh1zU/hembtBdiLK
	 YGtRNRXTFO35A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACAB382333F;
	Sat, 10 Aug 2024 05:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/7] ibmvnic: ibmvnic rr patchset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172326723549.4145426.17320604935943866028.git-patchwork-notify@kernel.org>
Date: Sat, 10 Aug 2024 05:20:35 +0000
References: <20240807211809.1259563-1-nnac123@linux.ibm.com>
In-Reply-To: <20240807211809.1259563-1-nnac123@linux.ibm.com>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, bjking1@linux.ibm.com, haren@linux.ibm.com,
 ricklind@us.ibm.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Aug 2024 16:18:02 -0500 you wrote:
> Hello again!
> Thanks Simon and Jakub for the feedback, much appreciated.
> I just learned about NIPA so hopefully I will get a local
> instance up and won't have to clog the mailing list as much.
> 
> Changes since v2:
>   - edit kdoc's in patch 3
>   - fixup commit message formating in patch 7
> Changes since V1:
>   - add performance data in patch 7 commit message
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/7] ibmvnic: Only replenish rx pool when resources are getting low
    https://git.kernel.org/netdev/net-next/c/dda10fc801a9
  - [net-next,v3,2/7] ibmvnic: Use header len helper functions on tx
    https://git.kernel.org/netdev/net-next/c/b41b45ecee6b
  - [net-next,v3,3/7] ibmvnic: Reduce memcpys in tx descriptor generation
    https://git.kernel.org/netdev/net-next/c/d95f749a0b5e
  - [net-next,v3,4/7] ibmvnic: Remove duplicate memory barriers in tx
    https://git.kernel.org/netdev/net-next/c/6e7a57581abe
  - [net-next,v3,5/7] ibmvnic: Introduce send sub-crq direct
    https://git.kernel.org/netdev/net-next/c/74839f7a8268
  - [net-next,v3,6/7] ibmvnic: Only record tx completed bytes once per handler
    https://git.kernel.org/netdev/net-next/c/1c33e29245cc
  - [net-next,v3,7/7] ibmvnic: Perform tx CSO during send scrq direct
    https://git.kernel.org/netdev/net-next/c/e633e32b60fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



