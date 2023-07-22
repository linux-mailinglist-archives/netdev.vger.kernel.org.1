Return-Path: <netdev+bounces-20147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB80875DD77
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 18:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60D2F1C20A5E
	for <lists+netdev@lfdr.de>; Sat, 22 Jul 2023 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700339A;
	Sat, 22 Jul 2023 16:40:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C869938B
	for <netdev@vger.kernel.org>; Sat, 22 Jul 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44E1BC433C9;
	Sat, 22 Jul 2023 16:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690044020;
	bh=YnmWUhSobKjKsiu+lawoA8TVs2t5J5ygBTNjFxvaNnE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O9GtsICsndIWGHUnsEbWn7Qg0XqraBTfjW5UQ+EY52bvRt7NireYjx2JlD2TcRhFH
	 41S1Ve82X0S4BdkPpfSaWELqc2ZJ6hV9YWdeoxDw4M1RqWnrkgIzrAgHK1xINQboRo
	 mnouaERI5WRo4O8gN+TK13NafuIJEqZxzE7yCsR8sow2mm6wa3lSAp3YWTi7udp5yw
	 ewqTY0RAQd8nAUBkvxg3IgIGWg2Jg2CC0FnqrpGerFrv5IzLs3EyW6ns0w4SxBbflL
	 V1qP6+3yH/2QAzRQB41Jf5T0ogsCSpuMVVzLcjlN6qaACbyNnnE7zkxVqYKWFMXwYd
	 3lHU5iOJo9sRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16EBFC595C0;
	Sat, 22 Jul 2023 16:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] include: dual license the bpf helper includes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169004402008.28176.3672020589811461598.git-patchwork-notify@kernel.org>
Date: Sat, 22 Jul 2023 16:40:20 +0000
References: <20230722024120.6036-1-stephen@networkplumber.org>
In-Reply-To: <20230722024120.6036-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 21 Jul 2023 19:41:20 -0700 you wrote:
> The files bpf_api.h and bpf_elf.h are useful for TC BPF programs
> to use. And there is no requirement that those be GPL only;
> we intend to allow BSD licensed BPF helpers as well.
> 
> This makes the file license same as libbpf.
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> 
> [...]

Here is the summary with links:
  - [iproute2] include: dual license the bpf helper includes
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ac9650fe5c80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



