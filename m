Return-Path: <netdev+bounces-213895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC87B2743E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 337A15C85C4
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 00:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1961339A4;
	Fri, 15 Aug 2025 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPdFgYfv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5669F13957E
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219014; cv=none; b=NU9q8u+Nt4M72TUNOs+x0xq+oqpvL1acL+/mI0PQONx2qhl/qbZ3uzi/KJjFxJzhytfnr9c3tA5RWlQ50L7Xa+5SPAprplbA8V17F9HlovmIMd0xMnY/AwIpgZwxGERyhrf1M2q3qLMjYHXMpUykFxJytCOtTK8bLb+0jrFPoPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219014; c=relaxed/simple;
	bh=/uT18Xw1HrVkwtgAbE9d98qpbTOKUpV5gTa2Pw57Nkw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=drLCRlVbpzDokfRwD4d/ewL+QU0M5beMdSgAjLcNwIntSiFlUQzzToo7pppVTyhQrsIBZ0S71lhXOaO0ttGXLOTqKm/aMsURaeQmOTUfcZy0OC86PcEQTp5pHpYlFj3Y19xFU7f29vypud8sch8/QNp/L/rumTcFyyEzcaE0+Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPdFgYfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C97C4CEED;
	Fri, 15 Aug 2025 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755219014;
	bh=/uT18Xw1HrVkwtgAbE9d98qpbTOKUpV5gTa2Pw57Nkw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RPdFgYfvJChzA5tGb8xSnChX/vYyucFWzAfZwARPGatNnEnuWB6qt6h9SKT4/umZ8
	 rNoc+WcFqnq5K1ZapZ0NHuWzdlb4SqjUegj9n5KO1Lzd+ZWo0PPNwo7RFZ42HZbt7m
	 +w2JkWiCgLleIDWVB0hZwo5/PAw09jKrFhyJMYvYzBSVIX4OD8S/XjPvB85DaaDccg
	 QU+5Nwi8eWfGgyXFyCEC3qerxtkgmwxlk24G8cELqLeYn+1Mcq0CEAeScUowBLUISR
	 dxyVuAbVJ48j40sUT7te1kmkYFCqkfskkuglhUr6OQHH6fvT/U7ZoWw7r8rjSDD5PJ
	 VQpeM6MLkvCzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC7039D0C3E;
	Fri, 15 Aug 2025 00:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] devlink port attr cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175521902523.500228.15621849606665277233.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 00:50:25 +0000
References: <20250813094417.7269-1-parav@nvidia.com>
In-Reply-To: <20250813094417.7269-1-parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 vadim.fedorenko@linux.dev, jiri@resnulli.us

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Aug 2025 12:44:15 +0300 you wrote:
> Hi,
> 
> This two small patches simplifies the devlink port attributes set
> functions.
> 
> Summary:
> patch-1 removes the return 0 check at several places and simplfies
> patch-2 constifies the attributes and moves the checks early
> caller
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] devlink/port: Simplify return checks
    https://git.kernel.org/netdev/net-next/c/0ebc0bcd0aa0
  - [net-next,v2,2/2] devlink/port: Check attributes early and constify
    https://git.kernel.org/netdev/net-next/c/41a6e8ab1864

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



