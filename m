Return-Path: <netdev+bounces-181456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C4EA850AB
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 02:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FFC34C36BA
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5592C29CE1;
	Fri, 11 Apr 2025 00:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEyYAwMF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4110A1E
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 00:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744331995; cv=none; b=GQ0aU6NQYwc5JAXiBi/W2I96Zfr+ui67fvFN2tYOAGNsBAF4HpxFcDnaaho+FENDcp7WjG+PyHntHlFYIffYzZ4Kq/vySoUKxgHEO/EDdkBxddox1pHvu83ZJhZfetIa3T7q3Ki0s9lN/WED6l04EkYR2+0aDWMq0IqrnOX+2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744331995; c=relaxed/simple;
	bh=pVKE2jDQF6OgVSo4v9ss4yjjh444S2nDUrdjccccDUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dGP36tfruJpjpO31VK7HMKtVIlaJOeeq91TfZyrZtuQmSmZwXCzqJ14acq45ge80GJLUcOJi58ZiGrC8HIEaH+DGftHNSLxJU/jUqOVVy7MRU+TRFemxLnK9H/Tsh3tnUdrYim094MUIVadY+kd9q5B/EYsLlvhKUQhbEg5fczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEyYAwMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C2CC4CEDD;
	Fri, 11 Apr 2025 00:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744331994;
	bh=pVKE2jDQF6OgVSo4v9ss4yjjh444S2nDUrdjccccDUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PEyYAwMF62M/myraNRjWA8LwnQuhXUm6H3ZAfi/WWXhcesrSgmcRVZhyAZzikcgH6
	 9OwRJH7HKX0lCvg1IR4cQxIz8GLOOTWFRDnumqgnyqdeofnXbc6ot7nsD48hikon2o
	 DB4DDWUFGW9+8sMTduhP2WlHdgv5mDKGP3SGvBYZ3uJyvbLnmFittg4dPUcmM/TUP9
	 JSXwQXDpmyF7nIevbpzYlsl+Yk6kAM02T6R8TcHpkzBjLklFfrfsyfd7djNbVrjkV0
	 TPsRdajxkdzyD/VZiVIdsZddtWDkdxBlDiVhnu8NQRKXlUD98LcEX7ZLbNHFaMZ8o4
	 ARbVzl3Wzfnvg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71126380CEF4;
	Fri, 11 Apr 2025 00:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] io_uring/zcrx: enable tcp-data-split in selftest
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174433203228.3874879.12009244231647703546.git-patchwork-notify@kernel.org>
Date: Fri, 11 Apr 2025 00:40:32 +0000
References: <20250409163153.2747918-1-dw@davidwei.uk>
In-Reply-To: <20250409163153.2747918-1-dw@davidwei.uk>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Apr 2025 09:31:53 -0700 you wrote:
> For bnxt when the agg ring is used then tcp-data-split is automatically
> reported to be enabled, but __net_mp_open_rxq() requires tcp-data-split
> to be explicitly enabled by the user.
> 
> Enable tcp-data-split explicitly in io_uring zc rx selftest.
> 
> Signed-off-by: David Wei <dw@davidwei.uk>
> 
> [...]

Here is the summary with links:
  - [net-next] io_uring/zcrx: enable tcp-data-split in selftest
    https://git.kernel.org/netdev/net/c/6afd0a3c7ecb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



