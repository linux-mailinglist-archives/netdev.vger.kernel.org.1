Return-Path: <netdev+bounces-86367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CA389E7E3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 03:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB761C20C66
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 01:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21B110F9;
	Wed, 10 Apr 2024 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRUkRKNw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C832710F1;
	Wed, 10 Apr 2024 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712713222; cv=none; b=ikLIZ6s66K7dGNR4/vp+UjxcUaPL6yDzmZh/IL/gNShJ+Ikg0dVrb3nhIl1FIWd8Qi228HtgZeWDwshG4QhQbrZstL0F/QaXxZuEOcCa0UFZueLcDjD12wNleZQRFlxzhcYd7wAadcgQiYa1aDse4oNy44AL7BpWdStsNug7KLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712713222; c=relaxed/simple;
	bh=cL1meAldF9lys+VQ+fiked9/RI+8Snr6xCIact96PqU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CrdbSWEuB5K145yT2vUMBCeVvQLl3iOj+TtNhkAQBGEu7NXwpSEc9IFN333PcXbH2qxchmJSxqx2M1DXnwwlGz9yhMRcClydcJXaL6EinBEJrHuLWiXfo07dvsAIq7h0kY9JFjLyJEQFOj7JrSZuE33zp182cIy+jB/0/fkmh2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRUkRKNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0A8C433F1;
	Wed, 10 Apr 2024 01:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712713222;
	bh=cL1meAldF9lys+VQ+fiked9/RI+8Snr6xCIact96PqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MRUkRKNw25gvh5rP8IRcbq/JG7dw9Eam5R1mAJEbtzG2z564AFcH3FziPKU/2wRrP
	 q5+lA+gRdcQuYtJxWrXMmMqxm/RtEYPeUBhNl9+lGd+gvggXWtAmD2GnAvPGPRNGkg
	 5ilCeqfetgTMJKRvnAUqMpn3XxwbKCbJvu9zx7ttfueD6jtWrUH0s5uxKaxR8ZFcc+
	 5oDEDwVCy1gPZ4NT4/0jcWXOzbmP2HFRYWIGjOVzYTKj/pEbKaAGgkEwn2E9T8+gRr
	 XrVHVzRMmMUexjW2tSEwIJZZGD3lbvJBJyrd58d1quIZJWasJQa2XQYgdAu36ICs96
	 t/K2+z1n9h62g==
Date: Tue, 9 Apr 2024 18:40:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 4/4] virtio-net: support dim profile
 fine-tuning
Message-ID: <20240409184020.648bc93c@kernel.org>
In-Reply-To: <1712664204-83147-5-git-send-email-hengqi@linux.alibaba.com>
References: <1712664204-83147-1-git-send-email-hengqi@linux.alibaba.com>
	<1712664204-83147-5-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Apr 2024 20:03:24 +0800 Heng Qi wrote:
> +	/* DIM profile list */
> +	struct dim_cq_moder rx_eqe_conf[NET_DIM_PARAMS_NUM_PROFILES];

Can you please wrap this into a structure with other necessary
information and add a pointer in struct net_device instead.

What's the point of every single driver implementing the same
boilerplate memcpy() in its get_coalesce / set_coalesce callbacks?

