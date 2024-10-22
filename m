Return-Path: <netdev+bounces-137840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AEF9AA0BD
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 13:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 701CB1C2224B
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7358C1993AF;
	Tue, 22 Oct 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiIKhXSj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE4E1991A1
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729594828; cv=none; b=eV2ziPS4OzrkN7nFj8j8EuMVvtSdq7IKceOs8d3DOZk7L4lbjwkLar09hSibM3QeheC1H4l3LE3G+EwfhnMYyGNadEes7OGb6t1Fr5FaeQYc0t0lEjarZ34uLUmWI/J8mUkCc8tbpPxEGqi88jshWmhDDWR0vrT7lpwgmhhj4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729594828; c=relaxed/simple;
	bh=jyomz7Sjmu20861u8ZNZQbaw2uqKwsh1VDQ9EksgZUk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QN4EOz0jeEyKMviH1RmR6NuUvEiHc5qkh3IqygvfJhv4F80Fdiepi9etkWxONyuGJESXoWgL7zwrH100fUGoEAkCLHxcdfQT5evStI23LxexshKGnvrxKnkxjRTiF99v8N25vFD1BZxN75xHPGu0f4uzMxkLOW0wf0d9/Jm1eKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiIKhXSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDA5C4CEC3;
	Tue, 22 Oct 2024 11:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729594826;
	bh=jyomz7Sjmu20861u8ZNZQbaw2uqKwsh1VDQ9EksgZUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qiIKhXSjt0oNvYm2GxGQ8CXl1LnctZ6UBfQ1OGz/3TnlCRCkTtZMxanzOQNtyiyAt
	 c0EwknnjPtiuqfSIVlLld6LoAzKqXhbzI3+/xpkD/YyKLrbr3BvRXPOLWRqoizyRf0
	 L0+KY0/454APnjjH6cUPZiRwRpU5R2FX3idHBA0WKPwFj4k/GpUMIA/kn35qwxBpea
	 Nsc5KPWl9spESks4fhFf3vF5xGeDsXN1NcNDMkUEAVhKbrweO7FnL2FF1G362Va+eC
	 /LIvJgoWeZwk5DJpiX+2/v9eA30gj4SnZQObweXdhsLQaVpxh4DtXR3jkaexlP1+Bh
	 sN01E01mmPhzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D933809A8A;
	Tue, 22 Oct 2024 11:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: Programming sequence for VLAN
 packets with split header
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172959483281.930149.12211861779177755420.git-patchwork-notify@kernel.org>
Date: Tue, 22 Oct 2024 11:00:32 +0000
References: <20241016234313.3992214-1-quic_abchauha@quicinc.com>
In-Reply-To: <20241016234313.3992214-1-quic_abchauha@quicinc.com>
To: Abhishek Chauhan (ABC) <quic_abchauha@quicinc.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, ahalaney@redhat.com, horms@kernel.org,
 Ong@qualcomm.com, boon.leong.ong@intel.com, mohammad.athari.ismail@intel.com,
 vee.khee.wong@linux.intel.com, tee.min.tan@linux.intel.com,
 jonathanh@nvidia.com, kernel@quicinc.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 16 Oct 2024 16:43:13 -0700 you wrote:
> Currently reset state configuration of split header works fine for
> non-tagged packets and we see no corruption in payload of any size
> 
> We need additional programming sequence with reset configuration to
> handle VLAN tagged packets to avoid corruption in payload for packets
> of size greater than 256 bytes.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: Programming sequence for VLAN packets with split header
    https://git.kernel.org/netdev/net-next/c/d10f1a4e44c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



