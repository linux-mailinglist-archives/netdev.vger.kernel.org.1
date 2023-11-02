Return-Path: <netdev+bounces-45635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E25F07DEBF3
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7D4281A06
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 04:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCDBEA1;
	Thu,  2 Nov 2023 04:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPPnrpyu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B910EF
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:42:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041E7C433C7;
	Thu,  2 Nov 2023 04:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698900145;
	bh=SdcnFgAMPvml22ndDL1ro8QzzwIFpE/APZHZjpE2mRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CPPnrpyuFEFaOf1GOL8iEw0u6PiEQANR5D6CaAlBZZiblAg86Bkv7NyNPk/pYYP+u
	 bMMfuQGmHKwXEKlPVFI7l0VuxfKWssy0TPvbACTc1MjQhym2ohDd/ZMJeXWxkO+MZb
	 UiGz6PeGPZKW98WsPinIimfOLgsG7rSd3UDEre1boI0q+2QyfMAA1FzIVytw1JQZcq
	 HOYZpBl2jwBj+uaVU3z+UF4XnZj6wj3BKnN1ZHfQAqIU/7ppvxiulbnZmP+50DltZU
	 CVPogkwr1nzn4hrWxJuXODrAv6psKv1jlMHrOBFeMHZdQhHBDlfglUR6JMgNJcQABh
	 Rxx+rt8ymrMHA==
Date: Wed, 1 Nov 2023 21:42:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
 <sgoutham@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: Re: [net-next v2 PATCH] octeontx2-pf: TC flower offload support for
 ICMP type and code
Message-ID: <20231101214223.0de10cdb@kernel.org>
In-Reply-To: <20231031165258.30002-1-gakula@marvell.com>
References: <20231031165258.30002-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Oct 2023 22:22:58 +0530 Geetha sowjanya wrote:
> Adds tc offload support for matching on ICMP type and code.
> 
> Example usage:
> To enable adding tc ingress rules
>         tc qdisc add dev eth0 ingress
> 
> TC rule drop the ICMP echo reply:
>         tc filter add dev eth0 protocol ip parent ffff: \
>         flower ip_proto icmp type 8 code 0 skip_sw action drop
> 
> TC rule to drop ICMPv6 echo reply:
>         tc filter add dev eth0 protocol ipv6 parent ffff: flower \
>         indev eth0 ip_proto icmpv6 type 128 code 0 action drop

## Form letter - net-next-closed

The merge window for v6.7 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after Nov 12th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


