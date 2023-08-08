Return-Path: <netdev+bounces-25615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 482CD774EAD
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017412817D8
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F65171DF;
	Tue,  8 Aug 2023 22:53:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A630F100B2
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 22:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E512EC433C8;
	Tue,  8 Aug 2023 22:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691535196;
	bh=1gOeRTsFXmQto/w6QtWmIOTr5WO2jJS/Rnlqgow9WNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EePUFjZuFqQjcPPRVFStz5aFRARMwCXyHEG10Ao6tbEk8Osw71qQU0NQfUbArfVP3
	 6IK9UJeh2+tABdWa78TfEvVCvlK6W6m9qeRD1gMemE09avgyhT43sZuI+gOCOQ9UMu
	 XI90EDt5z6Rp4k+bzHbBDkYCkSYo1Q5t7ImxIKGDZlmwXZLvKVVylwthx9fQeotQkI
	 TGi2CRyqeVxv00rM0wsvfSVbj71ZSi9JItImRYDwCLzopF2Ubg05WjRoIoULx9nkit
	 m80u6o2+CBGZolkKLkb+f+4Rd9jL+uOIWmkvkzWehbWZ2c/+YF6LpqWeHpn0JmnXy0
	 IUyCibHwArkpw==
Date: Tue, 8 Aug 2023 15:53:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <vkoul@kernel.org>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, <robh+dt@kernel.org>,
 <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
 <michal.simek@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <linux@armlinux.org.uk>, <dmaengine@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <git@amd.com>
Subject: Re: [PATCH net-next v5 00/10] net: axienet: Introduce dmaengine
Message-ID: <20230808155315.2e68b95c@kernel.org>
In-Reply-To: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Aug 2023 11:21:39 +0530 Radhey Shyam Pandey wrote:
> The axiethernet driver can use the dmaengine framework to communicate
> with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
> this dmaengine adoption is to reuse the in-kernel xilinx dma engine
> driver[1] and remove redundant dma programming sequence[2] from the
> ethernet driver. This simplifies the ethernet driver and also makes
> it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
> without any modification.
> 
> The dmaengine framework was extended for metadata API support during
> the axidma RFC[3] discussion. However, it still needs further
> enhancements to make it well suited for ethernet usecases.
> 
> Comments, suggestions, thoughts to implement remaining functional
> features are very welcome!

Vinod, any preference on how this gets merged?
Since we're already at -rc5 if the dmaengine parts look good to you 
taking those in for 6.6 and delaying the networking bits until 6.7
could be on the table? Possibly?

