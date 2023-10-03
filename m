Return-Path: <netdev+bounces-37720-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44EB7B6BE1
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3DF852816D4
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B9631A89;
	Tue,  3 Oct 2023 14:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308306FD2
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 14:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99DCFC433C7;
	Tue,  3 Oct 2023 14:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696344028;
	bh=j5LjUAIxZfI9RYpxr7AaOacd7muMFvRsL9eB9x9Qy5M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lA1wuhA8TUmg14KIziscX+3r/NudJpvMv1nhsupTmYxBnG27+2FsLdaESHeUe/CFE
	 URES64n1ntlxMBNRNVBYUBIDGkfrR6oE6ks21UVyGJO/nJ/FdXm7EhWIjWhqsToVQ0
	 iNrad0GBicuIW3p3QxIXKjVQgqGnV97Cx4k1wb9E2VWoBQsjGUf7NBA7Q6c0PaEGiV
	 8DUZhIbAAOAk39U6rrxXLeT7vzgSIlhfjMfqENEiVjgRgMh7+UHB3HKXiis3MO+JwO
	 Osc6/KLTu0gGlfyqD5urFqnxArUIbBU4SBkXdMEFzcrcknydBerTHkkaxj4GcMT/Ki
	 cETK0/6BlkN6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D38DC595D2;
	Tue,  3 Oct 2023 14:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ethtool: plca: fix plca enable data type while parsing
 the value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169634402850.1390.2495686509983886461.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 14:40:28 +0000
References: <20230908044548.5878-1-Parthiban.Veerasooran@microchip.com>
In-Reply-To: <20230908044548.5878-1-Parthiban.Veerasooran@microchip.com>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: kuba@kernel.org, piergiorgio.beruto@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
 Nicolas.Ferre@microchip.com, Thorsten.Kummermehr@microchip.com,
 UNGLinuxDriver@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 8 Sep 2023 10:15:48 +0530 you wrote:
> The ETHTOOL_A_PLCA_ENABLED data type is u8. But while parsing the
> value from the attribute, nla_get_u32() is used in the plca_update_sint()
> function instead of nla_get_u8(). So plca_cfg.enabled variable is updated
> with some garbage value instead of 0 or 1 and always enables plca even
> though plca is disabled through ethtool application. This bug has been
> fixed by parsing the values based on the attributes type in the policy.
> 
> [...]

Here is the summary with links:
  - [net,v2] ethtool: plca: fix plca enable data type while parsing the value
    https://git.kernel.org/netdev/net/c/8957261cd814

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



