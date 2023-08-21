Return-Path: <netdev+bounces-29308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AFD782A06
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC3E280E8F
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEF36FA4;
	Mon, 21 Aug 2023 13:11:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292C04A29
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31450C433C7;
	Mon, 21 Aug 2023 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692623466;
	bh=JcjSJgA+kO+taEl9CzPKO96+/wFQLCjavvmjUHsUWLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awcZpnDQVa2PYKJPh2PJorDEGm6oOnoIYe89mjzw9u+3d77IUqHrdYEzUxEJQQ3pq
	 xJPpuvWjpwtUETu97+4Ivae+vQqRmizbCFm5YtsxJUFvxNWWJWpgWVRltv3z8uEcQo
	 vW+GWreYMtFHpeuu/uvS19xK3d2kuX59N8vv+oMmCGQJFWeZbQVMJCgUThwqljRV0u
	 jxWpFwH6OUxtp4bIJgv067H8uC/WECo+I3Vnvn5EnfVJ6x8krPi60HX8wACgM5FNil
	 c7v5MSvcBLK4XedmzWgNa7ehgGotjM+nmzB7pKLPg/RONSqUun+7Gm1Lap8KQmH0Td
	 8rW3GUsyamumA==
Date: Mon, 21 Aug 2023 18:41:02 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	michal.simek@amd.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, linux@armlinux.org.uk, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v5 00/10] net: axienet: Introduce dmaengine
Message-ID: <ZONiZq/qCqhfViqM@matsya>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20230808155315.2e68b95c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808155315.2e68b95c@kernel.org>

On 08-08-23, 15:53, Jakub Kicinski wrote:
> On Mon, 7 Aug 2023 11:21:39 +0530 Radhey Shyam Pandey wrote:
> > The axiethernet driver can use the dmaengine framework to communicate
> > with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
> > this dmaengine adoption is to reuse the in-kernel xilinx dma engine
> > driver[1] and remove redundant dma programming sequence[2] from the
> > ethernet driver. This simplifies the ethernet driver and also makes
> > it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
> > without any modification.
> > 
> > The dmaengine framework was extended for metadata API support during
> > the axidma RFC[3] discussion. However, it still needs further
> > enhancements to make it well suited for ethernet usecases.
> > 
> > Comments, suggestions, thoughts to implement remaining functional
> > features are very welcome!
> 
> Vinod, any preference on how this gets merged?
> Since we're already at -rc5 if the dmaengine parts look good to you 
> taking those in for 6.6 and delaying the networking bits until 6.7
> could be on the table? Possibly?

Yep, I am picking the dmaengine bits


-- 
~Vinod

