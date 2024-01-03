Return-Path: <netdev+bounces-61335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E910823733
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08A528257D
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 21:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD96F1DA21;
	Wed,  3 Jan 2024 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfRFEyAl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B891D6BE
	for <netdev@vger.kernel.org>; Wed,  3 Jan 2024 21:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F18C433B9;
	Wed,  3 Jan 2024 21:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704317982;
	bh=0HrVSl54jYmE5eYqRcFCiH2DRtCFbci+W2VMEK50M4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LfRFEyAlxQcs4smvuod9XfOQE0cBmex+P8iayJO+//3NHFYmzWCudnoNrMQx3lRGR
	 ntNt5u81eeocHX4KPbEVl1F0ME19piaAOOoRxDKKKWLxYA6+11rWw65xGZFyt4YXjn
	 cJHATLsgFFEFQIPpTqamOUGD4IK4v6RIie3KTDWTy+6oBTDylU1RN+o6E5svr3Qvsn
	 q2rXmMeiPRWlBsrvwQynPU8OOq+a0XmweM37H41TZ90HI1S7ZIXorU0fSyZQI80at+
	 CNI2hxLSQqCdrFcemd5WiNOUpgQstXRMjBLlDx4u9yLypLzeWcZGf6wOyoe8W6ZdPx
	 0n+w2AeT6TAVQ==
Date: Wed, 3 Jan 2024 13:39:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Ahmed Zaki
 <ahmed.zaki@intel.com>
Subject: Re: [PATCH net-next] net: ethtool: Fix set RXNFC call on drivers
 with no RXFH support
Message-ID: <20240103133940.73888714@kernel.org>
In-Reply-To: <20240103191620.747837-1-gal@nvidia.com>
References: <20240103191620.747837-1-gal@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jan 2024 21:16:20 +0200 Gal Pressman wrote:
> Some interfaces support get/set_rxnfc but not get/set_rxfh (mlx5 IPoIB
> for example).
> Instead of failing the RXNFC command, do the symmetric xor sanity check
> for interfaces that support get_rxfh only.
> 
> Fixes: dcd8dbf9e734 ("net: ethtool: get rid of get/set_rxfh_context functions")
> Cc: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Gal Pressman <gal@nvidia.com>

Thanks, we got a similar patch from Gerhard, applied yesterday:
501869fecfbc ("net: ethtool: Fix symmetric-xor RSS RX flow hash check")
-- 
pw-bot: nap

