Return-Path: <netdev+bounces-25753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F5977558E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D950B2817FB
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8A9182C6;
	Wed,  9 Aug 2023 08:30:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AA41CA16
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 08:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87BD8C433B8;
	Wed,  9 Aug 2023 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691569821;
	bh=4Mjj7h1enJcfJyIGcdaxo9qCNmWfFJ3uQOii3hhJbfk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aZPhPpbsAqyX4EiN05taBBURVeytubl4IDJXJo8lqL08LGCBv+lbYa/sHAVFUG8EF
	 omMsp9Qa4XcrRhaphJdbdI0XyxYy87OgbXWJfMZGdp/TL6oC6u5lbMhvYEWfJcDxRy
	 SzCIm/L812oVQ3DcqnGlsqmYXspS5KwZa0esIKmf2SYOgrcrAjJaGo9wuHUtUFktkZ
	 8/2sArt1FQkHfLZOW6ZXpeKf1uPZCipKeXG/LTLlwLaeYe+FP27E+AUpCLy/PW4IYz
	 /PoSPaBurYVwZr+HuLDg3a9Y7L8sx4/7U/DWmvcsYcB0Hncq68q2YYVneIl4Bnty9A
	 84XZ56j3AS6Qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 40E86E505D5;
	Wed,  9 Aug 2023 08:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 pci/net 0/3] Fix ENETC probing after 6fffbc7ae137 ("PCI:
 Honor firmware's device disabled status")
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169156982125.20993.4597878185625596543.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 08:30:21 +0000
References: <20230803135858.2724342-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230803135858.2724342-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, bhelgaas@google.com,
 robh@kernel.org, claudiu.manoil@nxp.com, michael@walle.cc,
 linux-kernel@vger.kernel.org, lvjianmin@loongson.cn, liupeibao@loongson.cn,
 zhoubinbin@loongson.cn, chenhuacai@loongson.cn

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  3 Aug 2023 16:58:55 +0300 you wrote:
> I'm not sure who should take this patch set (net maintainers or PCI
> maintainers). Everyone could pick up just their part, and that would
> work (no compile time dependencies). However, the entire series needs
> ACK from both sides and Rob for sure.
> 
> v1 at:
> https://lore.kernel.org/netdev/20230521115141.2384444-1-vladimir.oltean@nxp.com/
> 
> [...]

Here is the summary with links:
  - [v2,pci/net,1/3] PCI: move OF status = "disabled" detection to dev->match_driver
    https://git.kernel.org/netdev/net/c/1a8c251cff20
  - [v2,pci/net,2/3] net: enetc: reimplement RFS/RSS memory clearing as PCI quirk
    https://git.kernel.org/netdev/net/c/f0168042a212
  - [v2,pci/net,3/3] net: enetc: remove of_device_is_available() handling
    https://git.kernel.org/netdev/net/c/bfce089ddd0e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



