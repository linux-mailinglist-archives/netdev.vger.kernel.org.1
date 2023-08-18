Return-Path: <netdev+bounces-28798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507BD780B90
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1891C21614
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8630182D9;
	Fri, 18 Aug 2023 12:12:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5365C17FE9
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E724C433C7;
	Fri, 18 Aug 2023 12:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692360754;
	bh=NBGFt5eEWfHJ21aKAdl7v+uvCkOurbbahAK/Or24JXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=edr1+ub/Irb20ndnP3vetXj19FArIYcRWluZgt20aX5H/TdrS4m8JMj8n5T5PDSqB
	 RAZhBhVLBT25GJE6C4vDq0Ml45ScJsjlm2wCmU4mcXw8SsYp0GJZqAyXouZ8vCU4iy
	 YPGfCQC0ENVp4QsOrsUQ2ZjDhLRWF0L9CLxQ7HeMXewKAVJwRMTh7qZ5dfoJ9Niaok
	 nETvJMSeJbiiVEy8l+J7Y1LEjme12lkHKVf7PBe5F6j9ltgA+46T7wRcPvaqqaXEvm
	 AtM1UznmoYACuEE56uQMpmAlG+fsW7NzKO2NLo+9Je2f2cnnGnpRSeqhwiZTC96t0u
	 uGIjLfYdh754g==
Date: Fri, 18 Aug 2023 14:12:29 +0200
From: Simon Horman <horms@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sujuan Chen <sujuan.chen@mediatek.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: fix NULL pointer on hw
 reset
Message-ID: <ZN9gLcMOsB220R5F@vergenet.net>
References: <6863f378a2a077701c60cea6ae654212e919d624.1692273610.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6863f378a2a077701c60cea6ae654212e919d624.1692273610.git.daniel@makrotopia.org>

On Thu, Aug 17, 2023 at 01:01:11PM +0100, Daniel Golle wrote:
> When a hardware reset is triggered on devices not initializing WED the
> calls to mtk_wed_fe_reset and mtk_wed_fe_reset_complete dereference a
> pointer on uninitialized stack memory.
> Initialize the hw_list will 0s and break out of both functions in case
> a hw_list entry is 0.
> 
> Fixes: 08a764a7c51b ("net: ethernet: mtk_wed: add reset/reset_complete callbacks")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Simon Horman <horms@kernel.org>


