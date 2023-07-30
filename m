Return-Path: <netdev+bounces-22644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B2A76869A
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 19:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01BDC1C20A65
	for <lists+netdev@lfdr.de>; Sun, 30 Jul 2023 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AD9100AE;
	Sun, 30 Jul 2023 17:10:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1953D78
	for <netdev@vger.kernel.org>; Sun, 30 Jul 2023 17:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B009EC433C7;
	Sun, 30 Jul 2023 17:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690737008;
	bh=Blk0MOcifY62/PT6aYt/wGrvW/mIHYzvbO1J7C8M9qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hbxN29X2zi6IJVvELrV5PVuqQ57P1McA708sZujvbvk9IlBnVG0yt4N6ey6xRuFam
	 WMhPdE9zgz4DBvqyYrtKjc5/c2NiHMABzgOYcbxnVoL0ks8V8tO9vN5iKBN6V6hDZX
	 8sbpQ8CkdRGFUc9vaSnV4hRglG1D90rzXHq1tI1iz2BleA2mrtr9+l8j9svZqTqYRO
	 kzHUY7xIdJQLfx1K/n85BSrmNABZIBB00XJXS401sFc+HM1SPIQu9D/IvSpeihTdBi
	 WzV67ZSmE73Woc6s1CWeiVtr2Wv0i8dgZEKbhYqk/gy86ejhbtIX1+uWE/1lbs4A/4
	 dlP7SnHgB1QyQ==
Date: Sun, 30 Jul 2023 19:10:05 +0200
From: Simon Horman <horms@kernel.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
	sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v1 1/9] net: Introduce new fields for napi and
 queue associations
Message-ID: <ZMaZbSvFSKrhOXhV@kernel.org>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
 <169059161688.3736.18170697577939556255.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169059161688.3736.18170697577939556255.stgit@anambiarhost.jf.intel.com>

On Fri, Jul 28, 2023 at 05:46:56PM -0700, Amritha Nambiar wrote:

...

> diff --git a/net/core/dev.c b/net/core/dev.c
> index b58674774a57..875023ab614c 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6389,6 +6389,42 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>  }
>  EXPORT_SYMBOL(dev_set_threaded);
>  
> +/**
> + * netif_napi_add_queue - Associate queue with the napi
> + * @napi: NAPI context
> + * @queue_index: Index of queue
> + * @queue_type: queue type as RX or TX

Hi Arithma,

a minor nit from my side: @queue_type -> @type

> + *
> + * Add queue with its corresponding napi context
> + */
> +int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
> +			 enum queue_type type)
> +{

...

