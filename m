Return-Path: <netdev+bounces-44628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC587D8D3F
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 04:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D681C20FC3
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 02:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84431857;
	Fri, 27 Oct 2023 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhXAZJkO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE0417EF
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 294A0C433C8;
	Fri, 27 Oct 2023 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698375026;
	bh=rmVX8CHyx0Dm4Zgd1F3HyD+fdjwR0gdjEyfIWAhPOIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bhXAZJkOa14QCMzJCwec7vldNrCbx6JFGBDIkk13Y5ZZ9dcpAQWELDotPuwlHLkNh
	 aLSjClFdN5Puv5mgMJMXyd75LHBVg7cOw/+kbvrSMFMFlxr6DE5CI+t0UXrBR0bISX
	 Q18HaVhxHeMUjixDxDCFd629ogzOdwtZ/tBK6/8+xM7U0e1ner1Bn84LKEd2pkdudA
	 GxfC/EkEAiTMJDHQgywLAboqyqqYKbh4LNaWYcgYKmPZOWK5iC1vmJRicJVACruoB8
	 QMIQjwLTVuZjNzpuYGCDyuvZiRbU8ZQVwKjLn8zK3QkNuJcKoD0y/lPVQXFc9yIfJp
	 spjCxFDEUtBNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A523E11F55;
	Fri, 27 Oct 2023 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen: respect attr-cnt-name at the attr
 set level
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169837502603.8979.8223001513024007856.git-patchwork-notify@kernel.org>
Date: Fri, 27 Oct 2023 02:50:26 +0000
References: <20231025182739.184706-1-kuba@kernel.org>
In-Reply-To: <20231025182739.184706-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, martineau@kernel.org, dcaratti@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Oct 2023 11:27:39 -0700 you wrote:
> Davide reports that we look for the attr-cnt-name in the wrong
> object. We try to read it from the family, but the schema only
> allows for it to exist at attr-set level.
> 
> Reported-by: Davide Caratti <dcaratti@redhat.com>
> Link: https://lore.kernel.org/all/CAKa-r6vCj+gPEUKpv7AsXqM77N6pB0evuh7myHq=585RA3oD5g@mail.gmail.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen: respect attr-cnt-name at the attr set level
    https://git.kernel.org/netdev/net-next/c/eb9df668381d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



