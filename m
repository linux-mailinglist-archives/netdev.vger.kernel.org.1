Return-Path: <netdev+bounces-78468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 994B68753CB
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 17:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55721287FF1
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 16:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77DA12EBF6;
	Thu,  7 Mar 2024 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBKuUY+V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7461EB41;
	Thu,  7 Mar 2024 16:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827421; cv=none; b=PrfEp59p0yHe0MhYY6ojPon0fpGvPi/anUl7WFLLwzc1Sv1QAHus9unAuIQPTcnf4pwoK1/SRt8cytanmeCSTQ5JHt7rH+fj/ttZCq7G5P83kdWPbRO+H64aC/lh/n8drYCqwl8xHPde+BRl+UW4o0hFGPvjFX8Nj6rwrGZucR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827421; c=relaxed/simple;
	bh=SU328L/3a03URFpGFeSgFziUoItF27LZLRfwrrtANVI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2ITSAUPMMxesWh56LzoD5LGfxSeZLSdDyKFCOeI23XaUoUksSeiBmwIGEQNg2r9ffmYCUxdyPVrO5F7IGZCP81u2BXzMEiTGVulxvH1XkMUlhf+pU4FiJhYDm8TGJQqg0K2CdAZioH8+bC3c39Wp4NmhPlKKCtYF0bLBgTdFxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBKuUY+V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB7CC433F1;
	Thu,  7 Mar 2024 16:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709827421;
	bh=SU328L/3a03URFpGFeSgFziUoItF27LZLRfwrrtANVI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iBKuUY+VTo+hojn3Y/yKUFQEO/ZlLkR18bLpAtmpCqHAXnXyc6XNGPP1zBn6qmGv2
	 IR8mJgwpxl153KzZqzydFKEzW6S0bpXesKD7+whtpYrPZDoTMVQmxxwpT+dal/BF7M
	 h44cviyPQ90ck4QdNkkyNDbXziaUj0JD5EaiHoq+ubiy7ClvmySEcU+zNcKG1thS7w
	 3hxmg9lmEOYibViugiqmzj6wZB8w1+q9nQp16DAqAiX3X7Rc6PZ5wFQtJf16jlVxyE
	 k2USoDN+oaL6tFQ2djyBhPeIExn/kdi1Xgcakdo0zmupbT60Edf3Vvoi5YqeBsgaBZ
	 hRqJRSnphb30g==
Date: Thu, 7 Mar 2024 08:03:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason 
 Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric 
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 5/6] virtio_net: add the total stats field
Message-ID: <20240307080339.09125a2f@kernel.org>
In-Reply-To: <1709804195.5639746-1-xuanzhuo@linux.alibaba.com>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
	<20240227080303.63894-6-xuanzhuo@linux.alibaba.com>
	<20240227065424.2548eccd@kernel.org>
	<1709804195.5639746-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 17:36:35 +0800 Xuan Zhuo wrote:
> > Please wait for this API to get merged:
> > https://lore.kernel.org/all/20240226211015.1244807-1-kuba@kernel.org/
> > A lot of the stats you're adding here can go into the new API.
> > More drivers can report things like number of LSO / GRO packets.  
> 
> In this patch set, I just see two for tx, three for rx.
> And what stats do you want to put into this API?
> 
> And on the other side, how should we judge whether a stat is placed in this api
> or the interface of ethtool -S?

A bit of a judgment call indeed, let me reply on patch 3 and we 
can go over them one by one before you invest the time re-coding.

