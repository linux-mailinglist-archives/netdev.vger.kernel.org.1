Return-Path: <netdev+bounces-109188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BA92747E
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 13:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B96828150F
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 11:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E1519005F;
	Thu,  4 Jul 2024 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFIKSJqS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597BE14B964;
	Thu,  4 Jul 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720090830; cv=none; b=MNJy6D9KCia2DFolN/s6OEaEhjXx/CpnPo2a/Xi2QHRupOcWvge2D7z90RGPMiYF11fFWfxnsIkFJ8RmaGAdIaLdRyVl24PC8I/n7d+SVCqaoY5DZ4CnLcPRDi/5j5sdwhc+5x81XNzw0PvqZv6BpPV36xnqT5RFrhxQbeHPzgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720090830; c=relaxed/simple;
	bh=vm0oC4ZdJj9gl7rvbit+Ak68aFEfaG3MLVTFoZQqdHs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XsSymUD7yj4BZfvepGH8nuHW/8xw/Wiy5MZJXPbTPipSDZiWoxi87kccb0z1R3YtHFNQb77TifBwvW5vDrhRK3xH52lGk6mRhg5E2CZ6qTcXukDbzDUznbaJttEmVQAcdlh433ioRubM0eRtlPpwtyH1YiWbihP8bhQujSQPf4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFIKSJqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBAA9C32786;
	Thu,  4 Jul 2024 11:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720090829;
	bh=vm0oC4ZdJj9gl7rvbit+Ak68aFEfaG3MLVTFoZQqdHs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MFIKSJqSLWRYJKpgMaKQBTfjySeTk2sRhQ5MPEY+RRjosz3ANH4V2orRKPlKirPMq
	 kIII+RIRKzCH3YWxekQhoCPPYpQZO33/pMBflwwc5Gm5P8RyhkxWZKhsbvk2psQbVa
	 R7157Fmz+wjYVDGoVOx+6ocDOATMze+53Jgrp3vTO6fu5nC8IAbGfObkXIiDBEmUr9
	 GsL88ox0wVr5plne4DvaHwgJsoBWAPyW76kE+sAi3/Rw1403yAWiYzxWjDnT9AgY0P
	 OrjnA1dHidSfPiDJdd/MSxmJH+gaqDmS/42dF47wBJQ0s4pOYPWOU9g/UDow8Nlevg
	 kQ45kit0mUDfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA7F2C43446;
	Thu,  4 Jul 2024 11:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] l2tp: Remove duplicate included header file trace.h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172009082969.7983.2467621856628928256.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 11:00:29 +0000
References: <20240703061147.691973-2-thorsten.blum@toblux.com>
In-Reply-To: <20240703061147.691973-2-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, samuel.thibault@ens-lyon.org, tparkin@katalix.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  3 Jul 2024 08:11:48 +0200 you wrote:
> Remove duplicate included header file trace.h and the following warning
> reported by make includecheck:
> 
>   trace.h is included more than once
> 
> Compile-tested only.
> 
> [...]

Here is the summary with links:
  - [net-next] l2tp: Remove duplicate included header file trace.h
    https://git.kernel.org/netdev/net-next/c/47c130130de2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



