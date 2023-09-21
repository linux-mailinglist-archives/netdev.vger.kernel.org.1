Return-Path: <netdev+bounces-35380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FC87A93AF
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 12:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 833F7281874
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 10:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8077946D;
	Thu, 21 Sep 2023 10:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2572A955
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 10:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65ACAC4AF6E;
	Thu, 21 Sep 2023 10:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695293423;
	bh=YtckvwlBrMMC7jLRVjbOvKATSxSXSNmZ/+v9UB3RbkM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T6v53WU6Yex4FShxB8P+8lFNVSZQLqIPB8bfL8dmLoEfaHGPgoIMNCmEGJ4CGGwxw
	 TfIKOHHRlT712xhw2r31Pv+qaJXoVpT+GMJJiCKFO4mB9bxRkdjJLfOOFfkdnFAs6N
	 M+CJYclZs7ao/FkjOYfP4vvI7fH1sKQH/93Riw/4aUpniwNo+UwFvy9MXN33SNXLy7
	 2CdCG0Vk0XIasyttx8/eWdYcpI/dE/nNAxsqbXD+WCfs6TrvI0sxGaZKg0hn94WiD1
	 HU5DO/XpikEmRoMomRJZuVBi4h4+V7T7Q9dIlKlIpNS9q43z1YuwQtM+/noEP022Ot
	 i8YSRvcM7EajQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BF9FC43170;
	Thu, 21 Sep 2023 10:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v9 0/4] vsock/virtio/vhost: MSG_ZEROCOPY preparations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169529342330.31237.17425238939443569716.git-patchwork-notify@kernel.org>
Date: Thu, 21 Sep 2023 10:50:23 +0000
References: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
In-Reply-To: <20230916130918.4105122-1-avkrasnov@salutedevices.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: stefanha@redhat.com, sgarzare@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
 jasowang@redhat.com, bobby.eshleman@bytedance.com, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@sberdevices.ru, oxffffaa@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 16 Sep 2023 16:09:14 +0300 you wrote:
> Hello,
> 
> this patchset is first of three parts of another big patchset for
> MSG_ZEROCOPY flag support:
> https://lore.kernel.org/netdev/20230701063947.3422088-1-AVKrasnov@sberdevices.ru/
> 
> During review of this series, Stefano Garzarella <sgarzare@redhat.com>
> suggested to split it for three parts to simplify review and merging:
> 
> [...]

Here is the summary with links:
  - [net-next,v9,1/4] vsock/virtio/vhost: read data from non-linear skb
    https://git.kernel.org/netdev/net-next/c/0df7cd3c13e4
  - [net-next,v9,2/4] vsock/virtio: support to send non-linear skb
    https://git.kernel.org/netdev/net-next/c/64c99d2d6ada
  - [net-next,v9,3/4] vsock/virtio: non-linear skb handling for tap
    https://git.kernel.org/netdev/net-next/c/4b0bf10eb077
  - [net-next,v9,4/4] vsock/virtio: MSG_ZEROCOPY flag support
    https://git.kernel.org/netdev/net-next/c/581512a6dc93

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



