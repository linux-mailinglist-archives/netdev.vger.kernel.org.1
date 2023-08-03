Return-Path: <netdev+bounces-23936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDECA76E354
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 10:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012491C2148E
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAAC2592;
	Thu,  3 Aug 2023 08:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2007F7E
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 08:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F6BEC433CA;
	Thu,  3 Aug 2023 08:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691052020;
	bh=zqaImOZFE/jE/ZNN/goryGj4cs2q9UN8ZkgSCjFPuac=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RMLg9gVMqXV8ZWIY/EfeCasq5y1d+zgt7iUNv4CcRMtMj/ZswYMinUcRzqj5jqqgy
	 2OGPD107YjTe5gNkDN/WrXvK78fmx0jEfzbkW5MzILPOkCAP33LO5KOv72IrWq0naB
	 dOv5yd/Ka2E9BNgZWKg3FV+Q8BG9Dhnr+hUg4IELn2eHivzNouJi9lp3IOdb+5UFP/
	 XC8wNl+5QaJ/OzMAcQU2ESmXfl9RiMeLdGYkSe85biP/1yujwvDgka0J9Hy716IH8z
	 IPjWLrMvJck9s/rn3vo00HUI0I/D7XqHv/hnxVQYrn9+Eu0z2rg4xSoRdUoQyYeYK/
	 DeP8GCCKYmb6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64DE8C43168;
	Thu,  3 Aug 2023 08:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,v5] bonding: support balance-alb with openvswitch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169105202040.6738.6599282261013962900.git-patchwork-notify@kernel.org>
Date: Thu, 03 Aug 2023 08:40:20 +0000
References: <9fe7297c-609e-208b-c77b-3ceef6eb51a4@redhat.com>
In-Reply-To: <9fe7297c-609e-208b-c77b-3ceef6eb51a4@redhat.com>
To: Mat Kowalski <mko@redhat.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, andy@greyhouse.net,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 1 Aug 2023 14:37:50 +0200 you wrote:
> From: Mateusz Kowalski <mko@redhat.com>
> 
> Commit d5410ac7b0ba ("net:bonding:support balance-alb interface with
> vlan to bridge") introduced a support for balance-alb mode for
> interfaces connected to the linux bridge by fixing missing matching of
> MAC entry in FDB. In our testing we discovered that it still does not
> work when the bond is connected to the OVS bridge as show in diagram
> below:
> 
> [...]

Here is the summary with links:
  - [net-next,v5] bonding: support balance-alb with openvswitch
    https://git.kernel.org/netdev/net-next/c/f11e5bd159b0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



