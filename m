Return-Path: <netdev+bounces-23447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C72E76C008
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7F1C210E5
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2399275BF;
	Tue,  1 Aug 2023 22:00:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681E3275AD
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB012C43391;
	Tue,  1 Aug 2023 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927226;
	bh=TfTWerrT151QkA9LdcUjyC/O6PsLiVHfw7rM1IQ6jMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q7jZlrsAOvLcG8zlqTXiRuz8wEHuiC53UF7AQ4XXdtmBD1YfwpxC8P4JJYAnfqO2m
	 vor/Oy9m1cWPiJ7cCbP+H2Hg1KbPLuxyJVC6a9fb0eJMHWZoPf5Dy+DrrVKYxnJAlo
	 AH2U572+qg/yKotNzj2NQT4AY3nJjMMy6Z72dc/qu7y+dEOZrZMHi1lsHffamQDWRx
	 JxdOo+u+YlTpbiJ7uAZVoD9cfxdiqQPiH6Vp3gAOc9Kc9m7POBWuKn0eh5hk0Y8HjA
	 MrDF6Dld5t7X60WnLMVZfUyEUzXBAngKIV5L4ABiRr6zu3FQqVr2ngSoLIKqTxPyUK
	 64nlLjduQKr8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3C25C691E4;
	Tue,  1 Aug 2023 22:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/macmace: Replace zero-length array with
 DECLARE_FLEX_ARRAY() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169092722585.12287.10967772625799606285.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 22:00:25 +0000
References: <20230730231442.15003-1-rauji.raut@gmail.com>
In-Reply-To: <20230730231442.15003-1-rauji.raut@gmail.com>
To: Atul Raut <rauji.raut@gmail.com>
Cc: avem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
 pabeni@redhat.com, rafal@milecki.pl,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 30 Jul 2023 16:14:42 -0700 you wrote:
> Since zero-length arrays are deprecated, we are replacing
> them with C99 flexible-array members. As a result, instead
> of declaring a zero-length array, use the new
> DECLARE_FLEX_ARRAY() helper macro.
> 
> This fixes warnings such as:
> ./drivers/net/ethernet/apple/macmace.c:80:4-8: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
> 
> [...]

Here is the summary with links:
  - net/macmace: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
    https://git.kernel.org/netdev/net-next/c/005c9600003e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



