Return-Path: <netdev+bounces-181264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E57A84383
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A6144A4BAD
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327BC2853FA;
	Thu, 10 Apr 2025 12:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQIW1YN8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E447284B4B
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 12:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288805; cv=none; b=TeF6H52/i9qp7N3cHgfUkx5vRaRyBg1V7zjiBjkmzStKX23y0ANr+gOx7GB7IvNlad+z4kBxxt9R4GoILhEq+1FQNBITvY89bln4u9teB7/ZdPZOxor32kEfk6ITuP4dAUdbP7DNRk/G7gVbgbm1d/GvnJuwqUCRia58v/xakbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288805; c=relaxed/simple;
	bh=+1/TGOpczVD0Su+kju5DpaZRmGMZI+EkUDlmNF4Kvqk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ThiMGczLqJT9CmwgL+eMhrAPUxbEaJyEJtB72WoE3S6hLaGJYT4KcGazlSPJ31BEifxiDTRSi/0DEyzCorwyr2obsc+BJy13WPVEJI6VMxRH55AYcL8IwldCnsrZrQamrGxYsYpuHRfW8S5qHDWh2vEeKCGZbO0QzqtshOp1oeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQIW1YN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E95C4CEE9;
	Thu, 10 Apr 2025 12:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744288804;
	bh=+1/TGOpczVD0Su+kju5DpaZRmGMZI+EkUDlmNF4Kvqk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UQIW1YN8U25FrwYI+5Fm3GDg3wFsAXntxwQi4E0EbL9mYDiLkX5Mw7inT5hEuW1u2
	 S0qSA5aWGaYJxJYGyz0wI0304rCJXgOqU6hpx93mBzLnHF01/jpQgTIpYKz66B1CaV
	 PeSyYVSXT+MnZluDy7rBkjM/rkg2C5LZZbmcRYiZLGQastl5AULVxWe7J0aB+a0riE
	 B1OL9GV7p2uLafpElRpMmQExNBiV5PwWkSkEuc3A2nVmJgJi/z7Z9PdbHoDbkhv4R8
	 bQZZEDBTdMQKkfWavK5c1BcvBltVzmJtSBAgvk1jHFGIvpTvRCp6jK26pihij2UlAF
	 dq7aDMoTT5dEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34193380CEF4;
	Thu, 10 Apr 2025 12:40:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethtool: cmis_cdb: Fix incorrect read / write length
 extension
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174428884203.3651632.2197341307164250382.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 12:40:42 +0000
References: <20250409112440.365672-1-idosch@nvidia.com>
In-Reply-To: <20250409112440.365672-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org,
 danieller@nvidia.com, petrm@nvidia.com, andrew@lunn.ch,
 damodharam.ammepalli@broadcom.com, michael.chan@broadcom.com,
 andrew.gospodarek@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 9 Apr 2025 14:24:40 +0300 you wrote:
> The 'read_write_len_ext' field in 'struct ethtool_cmis_cdb_cmd_args'
> stores the maximum number of bytes that can be read from or written to
> the Local Payload (LPL) page in a single multi-byte access.
> 
> Cited commit started overwriting this field with the maximum number of
> bytes that can be read from or written to the Extended Payload (LPL)
> pages in a single multi-byte access. Transceiver modules that support
> auto paging can advertise a number larger than 255 which is problematic
> as 'read_write_len_ext' is a 'u8', resulting in the number getting
> truncated and firmware flashing failing [1].
> 
> [...]

Here is the summary with links:
  - [net] ethtool: cmis_cdb: Fix incorrect read / write length extension
    https://git.kernel.org/netdev/net/c/eaa517b77e63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



