Return-Path: <netdev+bounces-111551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D9931833
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 18:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5D91F220FA
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD493D982;
	Mon, 15 Jul 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AimO3ZGs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703617C67;
	Mon, 15 Jul 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059830; cv=none; b=DEOFTqaL/rNV+rFuZq/aE7riQiGGAGiq47UK2GIF24rZ33bnbAqV2b/ClDsIL2wVweGuONuq+lwzUJUSL3jCeTOpE9TJ8hHv42hRdYmVRu8RSLlhvWF7E9VXROwMksWRyIx7lG/hXhM+tFnACumTvqFit8+ILYGEJCq3bhAC78s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059830; c=relaxed/simple;
	bh=MHKbDjhMNiFYxJ/gGPAZhxDmz/n0Au+38x900Q4HPeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eu6GKh8flqt4SkzmnpbLsFov3C1/xkPy8jcSlsqRO2+ROv2HhDA899hG3mj35SEJtj3R9Pl/6v93I/9/wqS8naKFVvWgFAHqoi9/PVmkVylyKc8e7Ij2Lj+SXOTunrFUsU6faMsCpDI7gq1g0cXLVhy7cO5tCfKrDj1WVfUPmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AimO3ZGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6BF7C4AF0A;
	Mon, 15 Jul 2024 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721059829;
	bh=MHKbDjhMNiFYxJ/gGPAZhxDmz/n0Au+38x900Q4HPeY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AimO3ZGso4BUI9mPA9iZuwDnlQdrfpSnBrHC07OV0Dm+XoPSWRJ2LU4RlB6j9OdNQ
	 snztMG3/jcQjK2blhkX+WWxpATJH7/XQ8uQAIcLDNt57ZHIynZ4v35tg7wsq7D3esd
	 UJlwCo0XorL37GiLZtK475umlavmc7hPd+aOVGEvwh06iFJf6pC66RGQ3MV0SkKlI+
	 9ZoMz26Uw29eO34e/8Fa++xBdQ6ud7Q0IJeKaIB3acSLGOwGf/n6kn3xixnGZfFmPY
	 fy/bU+LxjOTUNv42osg0VSTeZijR5isgH7fHWftLRAvzFu5fgNM8FA6VVF0By0tWev
	 XrEjf7dVCtgoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7EE5C4332C;
	Mon, 15 Jul 2024 16:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] llc: Constify struct llc_conn_state_trans
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172105982974.6134.3480413843064784008.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jul 2024 16:10:29 +0000
References: <87cda89e4c9414e71d1a54bb1eb491b0e7f70375.1720973029.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <87cda89e4c9414e71d1a54bb1eb491b0e7f70375.1720973029.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 14 Jul 2024 18:05:56 +0200 you wrote:
> 'struct llc_conn_state_trans' are not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig, as an example:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   13923	  10896	     32	  24851	   6113	net/llc/llc_c_st.o
> 
> [...]

Here is the summary with links:
  - [net-next] llc: Constify struct llc_conn_state_trans
    https://git.kernel.org/netdev/net-next/c/70de41ef7857

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



