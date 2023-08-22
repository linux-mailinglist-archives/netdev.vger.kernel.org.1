Return-Path: <netdev+bounces-29753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F4784942
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B321C20B9F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DBB1DDDD;
	Tue, 22 Aug 2023 18:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515012B577
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CBC33C433C8;
	Tue, 22 Aug 2023 18:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692727826;
	bh=JlXtwqw3qN0SrFpb6Jw60yf77Ktdd36fwbQwgHMMxJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ld3KWsxTpHpU4yXIy7sXpZtYrFUSvbCqzEVlIIXDA6YKdyrSTkIs/1p6zQ6WaQu/e
	 rwoEtgywd05Y35DutUsuiAD/fm2ohIx9ROnotGhCm2849/j7N6rWjoBP/k+kkVJX6r
	 giAeBj/iO22JO6slxr2yFCNTX176FKIzqzfIpx4iS4hnCeWjmszDzLhyUYmnN/JymJ
	 D3cn6gY5Jyy5bFxQ5yTvABCXpWDXcD6C41h3gnVu787R227m2NItK3cMay8LposTqu
	 sDKVOQ2jYloT1x7ocpnk6HqqtS0jNvsRzvra9n1qVVwX4V8bVpGn34SvQX2YeeeLZ2
	 pW0/JOI4GPfvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AF4BAE21EDC;
	Tue, 22 Aug 2023 18:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] leds: trigger: netdev: rename 'hw_control' sysfs entry to
 'offloaded'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272782671.18530.3096881075670234902.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:10:26 +0000
References: <20230821121453.30203-1-kabel@kernel.org>
In-Reply-To: <20230821121453.30203-1-kabel@kernel.org>
To: =?utf-8?q?Marek_Beh=C3=BAn_=3Ckabel=40kernel=2Eorg=3E?=@codeaurora.org
Cc: kuba@kernel.org, netdev@vger.kernel.org, andrew@lunn.ch,
 ansuelsmth@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 14:14:53 +0200 you wrote:
> Commit b655892ffd6d ("leds: trigger: netdev: expose hw_control status
> via sysfs") exposed to sysfs the flag that tells whether the LED trigger
> is offloaded to hardware, under the name "hw_control", since that is the
> name under which this setting is called in the code.
> 
> Everywhere else in kernel when some work that is normally done in
> software can be made to be done by hardware instead, we use the word
> "offloading" to describe this, e.g. "LED blinking is offloaded to
> hardware".
> 
> [...]

Here is the summary with links:
  - [net] leds: trigger: netdev: rename 'hw_control' sysfs entry to 'offloaded'
    https://git.kernel.org/netdev/net/c/44f0fb8dfe26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



