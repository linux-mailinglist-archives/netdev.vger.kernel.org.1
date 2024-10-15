Return-Path: <netdev+bounces-135396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C944D99DB2A
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 03:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48184B214C2
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391CA1591F0;
	Tue, 15 Oct 2024 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAHe7MY6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C2158D8F;
	Tue, 15 Oct 2024 01:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728954636; cv=none; b=cQJQPl9hm0LjGIvLPZBo9kBrCgdnL9U7AW6XPQSufPLGYCDBaMEsIM2mQ7oswqt7pm2xkylwEVCwB1VQk9cOsZFA+7poXagQc6t+eapIi4RSd5a2uJmkCKKEp0s5rcSCepsi9cBZkNomjbG/D2TA4WEOn8aj1fScQj1+PnXfyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728954636; c=relaxed/simple;
	bh=pEPZn5Z1invD5+6aWwaKcd1YWvBJST7QTlQPxDSXNbo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q91LBnH1WBAiLmlB8RqNF0ej95poDLieFiqYGm6Au5xbMLHYMvhpUZWzVJWw85ayI4cSrPax5fEouiXzMsz0eNBwDP9KecKWH5vdCFtTyGIhS/4OeEtmRbBj2m/wvdMmsLfOWx3EC/MWpmTUW+xV4XaSun8rUMBHcR6EjTY93hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAHe7MY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98405C4CEC3;
	Tue, 15 Oct 2024 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728954635;
	bh=pEPZn5Z1invD5+6aWwaKcd1YWvBJST7QTlQPxDSXNbo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KAHe7MY63+CGMnlFWhUxf5LxYqmPVoY0JX342edt0cVYpBUyLfi/wWOgvFrc32/j1
	 yZEUtm2J55ktU2AcIG/wlSBSmbmgLkRCVOmVCwtvbStirv2zNA43DcbO3kCwBGqOBb
	 J4q4FPVU0EZcM6JFVGqGrDwkzAPZXxT0I9OaAeOAtmEaSeEZJNo+kOlzOR2kJe3g4a
	 sFMRCBoyuT4QXWPL+UT0baatldvxXwj5DrdCsp2KaCtec7Wn/cMWKCXjrlSUPKv3QV
	 Bg3AhhhIaCc3QxFRO2tML3y4Kf9D5O2hqgsYFdP4BGUbqkCfVCCl5rZEkhbQlEndH3
	 ve8Rmu7E3cvTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF73822E4C;
	Tue, 15 Oct 2024 01:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mvneta: use ethtool_puts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172895464048.686374.13760246615148217081.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 01:10:40 +0000
References: <20241011195955.7065-1-rosenp@gmail.com>
In-Reply-To: <20241011195955.7065-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Oct 2024 12:59:55 -0700 you wrote:
> Allows simplifying get_strings and avoids manual pointer manipulation.
> 
> Tested on Turris Omnia.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Here is the summary with links:
  - net: mvneta: use ethtool_puts
    https://git.kernel.org/netdev/net-next/c/9de722c144d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



