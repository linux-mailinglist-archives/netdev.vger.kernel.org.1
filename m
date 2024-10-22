Return-Path: <netdev+bounces-138032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B6E9AB9E2
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 01:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42B661C22EF0
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 23:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808B81CF282;
	Tue, 22 Oct 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHpt8BkT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588D61CEEB4;
	Tue, 22 Oct 2024 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729638633; cv=none; b=I5quul/MMDjKQlAqqiy3JZ/zH/hUtELTNnoKCR6wHi4C2eu1oz8BroBNbiUDNlnmexfFHhVXxTL00sZVcCprcvfWjzfddLEUrEAGhtfVvZIcwzQirCAUX/fAdnkB3OMEOBT2LTHnfeBa2x02YkDnai23HKsDKRt7mDmk9/5nmc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729638633; c=relaxed/simple;
	bh=I88E4oNCpbVw+Z9v/6Q4zO21IGjhjS8bq1Z18yl7P5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YzjlSQ1lQXhywQsH5eEtDfDM55REN/NrknfFUpQlAk7ZQRiBXxurdM1FpSeMuFexKHzXNDn8Z3k2Sjpd1pSP5WvLM6di8Ie9K6hBK/IEUm/quB5WeBugE8/648U2/KoMofJq6tSUnEh2h04cK9YJoc3/F3DyUqJCI/Z/kZaZvTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHpt8BkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E404AC4CECD;
	Tue, 22 Oct 2024 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729638633;
	bh=I88E4oNCpbVw+Z9v/6Q4zO21IGjhjS8bq1Z18yl7P5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mHpt8BkTvoz4pl+jYDv8QD8lpPztdZEhBpksB7jWVpWUEjSgkDqPnvYTBZPz7B8TV
	 re2eHacDr5+pHCJjKIjJdjxjRhbieEs6qLHg+YX8vVUGixOYzIVCtPphZqnTQFAQmU
	 VACMkwRHDsiQSr4dcDbaR209HNAhLIsjHfGqQZDVrePwhB+vBRGe/irKdn9l48ogf/
	 ROwejAz3Od462q87DA2g7vzZO4osGA1puKxtk68QiMxCqS0pagYQg2sQCUdrWTdUFQ
	 GkOKtHNeeveFQpUXeeVZxiHQo1HXUenDQg5euAk1+WYixtAGcmH01yw/coZBYdtNnE
	 4cTcj9S0gH/Hw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C863822D22;
	Tue, 22 Oct 2024 23:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: atlantic: support reading SFP module info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172963863899.1106081.12457247311084301548.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 23:10:38 +0000
References: <20241018171721.2577386-1-lorenz@brun.one>
In-Reply-To: <20241018171721.2577386-1-lorenz@brun.one>
To: Lorenz Brun <lorenz@brun.one>
Cc: irusskikh@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Fri, 18 Oct 2024 19:17:18 +0200 you wrote:
> Add support for reading SFP module info and digital diagnostic
> monitoring data if supported by the module. The only Aquantia
> controller without an integrated PHY is the AQC100 which belongs to
> the B0 revision, that's why it's only implemented there.
> 
> The register information was extracted from a diagnostic tool made
> publicly available by Dell, but all code was written from scratch by me.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: atlantic: support reading SFP module info
    https://git.kernel.org/netdev/net-next/c/853a2944aaf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



