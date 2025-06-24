Return-Path: <netdev+bounces-200444-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5680AE584C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2642F1B61625
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414FE61FFE;
	Tue, 24 Jun 2025 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUMJLQez"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185CC487BF;
	Tue, 24 Jun 2025 00:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750723798; cv=none; b=oFeT56WkoQ3+GPEbfiySY2lYErUfGOjNJRlgRUDX+6d5+pHzi1hQ+T+NOpvCx3zGNl5TkszZc53+fNxTotgaXmZ5DwK0hZhoqtCHHMIGas7KepebjHgDcIKwhTKMUCKAOgM2GRF/V+xmM55mOEAczuCBnNstK2UsZKXykQrwTR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750723798; c=relaxed/simple;
	bh=sTyd6R3g6GJ6h98CpIkeXpt+zWfEz5gMgJ7HGnY9vRA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hlz4mZDtDxjghs7lHy70wM5vdG0wA/eQz9H5tWsOejtWSqBoVmB+oFQ0yM6m3/UdoNL4j0eJPUKmH5/vhuWXQAT5P2H5+bemACnJjDf+zhU/rcxKbrRmdCi1y0U9fBmSmDvFFM3khy3T3MdDADn0pLeHBJ4rV9vfFKcgFDboPXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUMJLQez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA07BC4CEEA;
	Tue, 24 Jun 2025 00:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750723798;
	bh=sTyd6R3g6GJ6h98CpIkeXpt+zWfEz5gMgJ7HGnY9vRA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uUMJLQezSHKfrm/VmcoJGf1TSpnbFKOyB28nHRfdYhkxv9tVqLES3cU/NC2Xtl7Bt
	 RUKGrYvfZxIEoBP/Zz2RZzOjymLxbvzW5trmNeXFwGaqZoHdEI3Ks4P11e799JtBTO
	 u3vqktFtdEkVUAQtHYaBhlSC7rxtDxrrbGN9b0a6qs4xD5cQ9l4wICkfGcTKBc9k1C
	 4X8YZWi6negCkx373zeAnFNwjNIFIqcHld3ZO9ymPfX1BCTQCv93GO9mNrg5HVg+AV
	 YAvJcc7nIk0ihD4khRZsCeCsjHVzYMAEWee76lz2B9TYynpcG+Ikr/99TABbXGSyTV
	 6wvk02VPkrlMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3403339FEB7D;
	Tue, 24 Jun 2025 00:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] lib: test_objagg: split test_hints_case() into two
 functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072382499.3339593.3753942399801716527.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:10:24 +0000
References: <20250620111907.3395296-1-arnd@kernel.org>
In-Reply-To: <20250620111907.3395296-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: akpm@linux-foundation.org, jiri@resnulli.us, arnd@arndb.de,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Jun 2025 13:19:04 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> With sanitizers enabled, this function uses a lot of stack, causing
> a harmless warning:
> 
> lib/test_objagg.c: In function 'test_hints_case.constprop':
> lib/test_objagg.c:994:1: error: the frame size of 1440 bytes is larger than 1408 bytes [-Werror=frame-larger-than=]
> 
> [...]

Here is the summary with links:
  - lib: test_objagg: split test_hints_case() into two functions
    https://git.kernel.org/netdev/net-next/c/7df6c0245595

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



