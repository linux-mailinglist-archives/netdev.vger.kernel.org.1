Return-Path: <netdev+bounces-14052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879D073EB3C
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 21:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407D2280E38
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 19:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C6513ADE;
	Mon, 26 Jun 2023 19:36:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E38FC0F
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 19:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40E6C433C0;
	Mon, 26 Jun 2023 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687808216;
	bh=PP/GTx4QLdaWRtLnnpCysj5uuCRgSOia5f0XjRfzq1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sy2tp4qcq+PfJPxXR8yzfzOcJU4bOevfwuBzYqBpI3Hum6p/EOrzHhoY/Y8gsb8Nz
	 VT1K997c9v1Rk6z6hfqMI1QxbAvpvWDlqsu2bh1IN/HS5XuO4YTtfCPUMO+f2MffJ4
	 iaZV5tgGSCrKlDFvOK0oo4vB1CnE32IM0y7OwNCSJ7VoDt4O6kdhHvOaOWkbqw9puy
	 22+GBtmesUB9OrQi4OjTWkZoBOKn1rQ4aLdCaKqJxheNKGE6VSdOqtMK9rOQDMbRSd
	 ifIwMn4l9UO9d0ntJ5OoAwdevYDc10JnvFfhUTJZU/jHzxIbrx9z4M6IwQ7KwZk1f7
	 4J/Vwlaz+GTbw==
Date: Mon, 26 Jun 2023 12:36:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <davem@davemloft.net>, <willemdebruijn.kernel@gmail.com>, <andrew@lunn.ch>,
 <sgoutham@marvell.com>, <lcherian@marvell.com>, <gakula@marvell.com>,
 <jerinj@marvell.com>, <sbhatta@marvell.com>, <naveenm@marvell.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <jhs@mojatatu.com>,
 <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>, <maxtram95@gmail.com>,
 <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: Re: [net-next Patchv2 0/3] support Round Robin scheduling
Message-ID: <20230626123654.71d1bf38@kernel.org>
In-Reply-To: <20230626072407.32158-1-hkelam@marvell.com>
References: <20230626072407.32158-1-hkelam@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Jun 2023 12:54:04 +0530 Hariprasad Kelam wrote:
> octeontx2 and CN10K silicons support Round Robin scheduling. When multiple
> traffic flows reach transmit level with the same priority, with Round Robin
> scheduling traffic flow with the highest quantum value is picked. With this
> support, the user can add multiple classes with the same priority and
> different quantum in htb offload.

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer


