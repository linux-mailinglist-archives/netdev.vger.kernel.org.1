Return-Path: <netdev+bounces-190769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A34AB8A8C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A843BBBB3
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD6121767C;
	Thu, 15 May 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8XQ82JG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154A5217660;
	Thu, 15 May 2025 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747322404; cv=none; b=kDB3sm33Qbx7ap/b1HCISxThC/a9sbrgQBRwZlAaHdV050pbSPr5SISA8fbj3ObCVj3dHWVhrRLfElB5ND9tO7uZMZmIXpiH/86JY2hRw0fk/g198bbMYtxpNHgHImxs3W6JBGlJHfLRcyHsoEaSr1lFjv+9mGtLweRh28VYGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747322404; c=relaxed/simple;
	bh=2EIl7zlX5CFG01hMCb88L0Do1lywTUGx7ycgEZPt3Y4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l1iWjyfXGvdQZCd1DtGdrHMqZpn2ZY5zCTlay0D/PuWFaCRhJXkojQh7DabANdevEQmKwSZxnAwZ8aC385LNcONLmlSLwzqMecD6et1VzC48Icaogp8Os6P6q6b9QdSfEzA90qtsVQLESwSse98Iw6V6O2ZgdKZWtHflM6vw/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8XQ82JG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68E2C4CEE7;
	Thu, 15 May 2025 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747322403;
	bh=2EIl7zlX5CFG01hMCb88L0Do1lywTUGx7ycgEZPt3Y4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V8XQ82JGbHQWSujaYaTIx4pJUluVMEGs0b996Y09yFWRtNkjQQ2FFqsV5t6hzn9kE
	 Opgc8tM//MQHKDLOl2aZdbLH3zkiUfcEaSgsu6k2HW5KDZZPe1JYxA3lZbJo/qWUvK
	 8Jc/KiFfH42K8RyxbSlDDVjjwbe5piuafZ5JRTcQvU45us2FqfffP1VqgbXgOeWAKO
	 hdTbZhlxIrUt/944488HuCNprvSjxWMkyc5Oie4PqbnJRs673klhkcG9H3MPV6nH2o
	 vukDtrv+d4z8mzeUONcctWdnJ9qFDmfbTJgUMJc78K9Jl++Fn82kQnftEUy1UkBQuL
	 Ib/l3Kz+getIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7E3806659;
	Thu, 15 May 2025 15:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: prestera: Use to_delayed_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174732244077.3145583.7122975290569666709.git-patchwork-notify@kernel.org>
Date: Thu, 15 May 2025 15:20:40 +0000
References: <20250514064053.2513921-1-nichen@iscas.ac.cn>
In-Reply-To: <20250514064053.2513921-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: taras.chornyi@plvision.eu, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 May 2025 14:40:53 +0800 you wrote:
> Use to_delayed_work() instead of open-coding it.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_counter.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: prestera: Use to_delayed_work()
    https://git.kernel.org/netdev/net-next/c/21c608a88f4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



