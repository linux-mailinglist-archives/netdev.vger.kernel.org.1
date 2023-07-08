Return-Path: <netdev+bounces-16166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFB974BA52
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 02:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9653E280ED3
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 00:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6BC197;
	Sat,  8 Jul 2023 00:02:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC92195
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 00:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CC6C433C7;
	Sat,  8 Jul 2023 00:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688774518;
	bh=Ems+EKXwQA6oSusGgVodL1Hdfvdv/wmqk+JwPBsQFd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jhtuqCmoXo1h5jzgXUzl1AM9bdaSyQyQ3ej5jf75gP3cWlNk9CLseSnplwTyHVnMq
	 /GLngSsJIF7IabzZ6UzzS67hoLbzdzD5TjSeFkxfKVK0uLIP/phopc+pQ5s5w54oTy
	 kDVu0jphco0S1YQtiit4fQIE/keOdRHp5dDQxDQJTZoNDAEX5TrBKDJYOvJdpk+2gH
	 NyuzXjVTZ2dA8OOgVS32XatRE7McnTtgAncd/d7iai02ihaXnyx7kF0q8CITOMtVDL
	 8L+XYKfyRFBUHaKZoRMKg8HspsQP1DSbbM1Q3BvuU6FseJsPeezOpx806PpInsoAR0
	 gOzSsyn3lsUxw==
Date: Fri, 7 Jul 2023 17:01:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: <davem@davemloft.net>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>, Liang Chen
 <liangchen.linux@gmail.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Eric Dumazet <edumazet@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
Message-ID: <20230707170157.12727e44@kernel.org>
In-Reply-To: <20230629120226.14854-2-linyunsheng@huawei.com>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
	<20230629120226.14854-2-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jun 2023 20:02:21 +0800 Yunsheng Lin wrote:
> -#include <linux/dma-direction.h>
> +#include <linux/dma-mapping.h>

And the include is still here, too, eh..

