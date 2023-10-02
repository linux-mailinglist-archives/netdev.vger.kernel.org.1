Return-Path: <netdev+bounces-37317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF89D7B4B76
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 08:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 948471C20756
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 06:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F00384;
	Mon,  2 Oct 2023 06:30:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052B7383
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 06:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60E17C433C9;
	Mon,  2 Oct 2023 06:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696228256;
	bh=51D3jAWjqLEab76pPQmJ5kfBAfDmgnzB+pvMpo7r1BU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KEw3MegVxhjpNh+d+zdBD+D1t6g0QLdeyOllMocnFBwfeTLqinBZ2vsQIBIpKktn7
	 PQnf2RfOEJZZKvBLmmHhYqWbezoM/qdZBFYSW5rjGyij3YnkdCc/wh2+5HjrYo+WKy
	 TkisFNlIMHJJ8NVbDGzw7zw4/DryK0TEc9aw4vK1xQ6Sevnh08juHoaUcO+NjuP57X
	 cII9F/Gq8as9GEqdm8I8s/gm2zbZ7l3Q6uJ47niZxVc7Q6Yqatar/5RWOAO8h4AN62
	 C1C/93NY6q/Wo08Z1L9/UhCeaF2HU9xc3APpSkPJzSbId+hcdNPoB0C23K9F51bALV
	 F6656xD1VAthQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43BC2E632D2;
	Mon,  2 Oct 2023 06:30:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM
 is absent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169622825626.32662.10323231031478671932.git-patchwork-notify@kernel.org>
Date: Mon, 02 Oct 2023 06:30:56 +0000
References: <20230922124741.360103-1-festevam@gmail.com>
In-Reply-To: <20230922124741.360103-1-festevam@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: kuba@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 l00g33k@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 festevam@denx.de, florian.fainelli@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Sep 2023 09:47:41 -0300 you wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 23d775f12dcd ("net: dsa: mv88e6xxx: Wait for EEPROM done
> before HW reset") the following error is seen on a imx8mn board with
> a 88E6320 switch:
> 
> mv88e6085 30be0000.ethernet-1:00: Timeout waiting for EEPROM done
> 
> [...]

Here is the summary with links:
  - [v3,net] net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent
    https://git.kernel.org/netdev/net/c/6ccf50d4d474

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



