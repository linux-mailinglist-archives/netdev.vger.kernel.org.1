Return-Path: <netdev+bounces-29130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9806B781AC3
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 20:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8739E1C209DA
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 18:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EB819BDD;
	Sat, 19 Aug 2023 18:34:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E3F62D
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 18:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2D9EC433C8;
	Sat, 19 Aug 2023 18:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692470062;
	bh=Y4Zns78+cJfLS978OPLxTr9B/6Op6cnG5Zjax3Kt1Zg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u9EzD78DeXlOj+JCB41gMuZxgbeVmUGOdwBrT8HrI/UD6IyLgtDaHI/zhez/PIj7w
	 VoLcaAK/eb+pUcbQQI9e40CuKvkVwKBsP4bC0rX/lP8ASoVCjxAJQM4eq34GF3wn5u
	 klxT0PbaauGrQV3CwQCfK1Tn9cNt/ugRbpTnZI4MD3MZujF7Mj9Bz/yfnrGZtIfVOb
	 vWP62fbcTPDSb/E5nxdYiqA5oq5DTJiboeo+cORBqrmo133A2M7UTPjM6FeaYFjNi/
	 J3zXRb2jHRZFyaIMifKg7CvT63R/ik+rw6XwYhNovS3YiPTQDjTv1e7rPtuixIgmFY
	 y7eTv7p2AJWTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9B94C395DC;
	Sat, 19 Aug 2023 18:34:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: sfp: handle 100G/25G active optical cables in
 sfp_parse_support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169247006188.18695.13360615227785939934.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 18:34:21 +0000
References: <20230818110556.10300-1-josua@solid-run.com>
In-Reply-To: <20230818110556.10300-1-josua@solid-run.com>
To: Josua Mayer <josua@solid-run.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 18 Aug 2023 13:05:56 +0200 you wrote:
> Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
> for active optical cables supporting 25G and 100G speeds.
> 
> Since the specification makes no statement about transmitter range, and
> as the specific sfp module that had been tested features only 2m fiber -
> short-range (SR) modes are selected.
> 
> [...]

Here is the summary with links:
  - [v3] net: sfp: handle 100G/25G active optical cables in sfp_parse_support
    https://git.kernel.org/netdev/net/c/db1a6ad77c18

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



