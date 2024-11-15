Return-Path: <netdev+bounces-145483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409789CFA40
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03645B31E43
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21E41917D6;
	Fri, 15 Nov 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Syqjtrs+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2A11917D0;
	Fri, 15 Nov 2024 22:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731709825; cv=none; b=nn3l9UJvx4zFhffFzMZLB1osKOcra46fEOTb/eW3RXf/2egtwwU8fgS51+0ehm1WPmol2ql7/l20Z/QfdBXTaLxtZWwBo2NyDyVecoi5XKsv7lvZ9U+JsVOdpYFUM02EUeAMJjZb5eQXE5jidzZJwnd3lDkKqBeQSq9aYPl63gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731709825; c=relaxed/simple;
	bh=Gi2ZH9EKTcBtX8Fa9EnCgtNxNmF5lOvsbNCYFOxZkuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kUbmrMv8ztb2DZsPkVhmM9AIKg0QepaAdb4Tk+fn2F9NvGpb8WbqYXReTcwlSaRSAPYgQfy/MN/0L9/RUMF+/FQyTCjTD2E4s20N9Y8q8qgPYnXiMi5Kb7r2Vpoz3T/HdPyZT/AS98rUaOSb9T83NqLeig52ASPXBpk3Tm8UCeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Syqjtrs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2973BC4CECF;
	Fri, 15 Nov 2024 22:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731709825;
	bh=Gi2ZH9EKTcBtX8Fa9EnCgtNxNmF5lOvsbNCYFOxZkuk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Syqjtrs+dddBa1TP5zGz5Cf3f2OBwme09kRAy2RIn1R7G2Tl7ev3F9Q2ffJ2UksP1
	 DM91QD4LbrTmzNLi7yBfwW3TlsUYVNyeuDdMI7eUVqQ825ARCZ3j9breHtdlOFrSIb
	 zgweq5ZIEo9F655YKClH+djq/SWup6j7BEU4f3/FT2ltTClzPv5eJ+bfBLCabSXjo8
	 ncbITyaNOt0MbRryhZrQ4VXBNPyslKqV1jC6wzfew9lIPIYwUwy/f1/NQiFEoKmW7d
	 aa7Brx94wgxXxDj2nDNdE/gt0fNqUkJqpeZeItz9+M7it35B/I4NNr2uuuWwBMmxra
	 8FGrBly9urH0Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B8C3809A80;
	Fri, 15 Nov 2024 22:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2024-11-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173170983599.2752190.3344493222127602005.git-patchwork-notify@kernel.org>
Date: Fri, 15 Nov 2024 22:30:35 +0000
References: <20241114214731.1994446-1-luiz.dentz@gmail.com>
In-Reply-To: <20241114214731.1994446-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Nov 2024 16:47:31 -0500 you wrote:
> The following changes since commit 3d12862b216d39670500f6bd44b8be312b2ee4fb:
> 
>   eth: fbnic: Add support to dump registers (2024-11-14 15:28:49 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2024-11-14
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2024-11-14
    https://git.kernel.org/netdev/net-next/c/6cd663f03fa6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



