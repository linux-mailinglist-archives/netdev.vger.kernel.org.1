Return-Path: <netdev+bounces-60285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6AB281E733
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 12:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F101C20FE3
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 11:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0BB4E605;
	Tue, 26 Dec 2023 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GFTEudeO"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF954E1DE
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b1034710-62df-4623-a0ad-d09a6bb12765@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703591644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLCcnkK5biKO6x64oecDD2AmldlFVyLGs0Jfsxv6Q+4=;
	b=GFTEudeOQ+r4mw7bVPntWNURZ9p16OSToW8mOrWFvaFFP54ko2ehbBcu6yM3Qp0LGUnUNl
	4rzHqendVduV+UV5yBVZaDFXDJLbsfZSHWCFWmMEMfgIgh2VjQWpC+cBvzZK9Qm+ard4Vi
	VqtKXWMnfAR1YjNhr8jj6icJxgeMlAw=
Date: Tue, 26 Dec 2023 19:53:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxLzFdIHZpcnRpb19uZXQ6IEZpeCAi4oCYJWTigJkg?=
 =?UTF-8?Q?directive_writing_between_1_and_11_bytes_into_a_region_of_size_10?=
 =?UTF-8?Q?=22_warnings?=
To: Zhu Yanjun <yanjun.zhu@intel.com>, mst@redhat.com, jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20231226114507.2447118-1-yanjun.zhu@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20231226114507.2447118-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The warnings are as below:

"

drivers/net/virtio_net.c: In function ‘init_vqs’:
drivers/net/virtio_net.c:4551:48: warning: ‘%d’ directive writing 
between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
  4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
       |                                                ^~
In function ‘virtnet_find_vqs’,
     inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
drivers/net/virtio_net.c:4551:41: note: directive argument in the range 
[-2147483643, 65534]
  4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
       |                                         ^~~~~~~~~~
drivers/net/virtio_net.c:4551:17: note: ‘sprintf’ output between 8 and 
18 bytes into a destination of size 16
  4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/virtio_net.c: In function ‘init_vqs’:
drivers/net/virtio_net.c:4552:49: warning: ‘%d’ directive writing 
between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=]
  4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
       |                                                 ^~
In function ‘virtnet_find_vqs’,
     inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
drivers/net/virtio_net.c:4552:41: note: directive argument in the range 
[-2147483643, 65534]
  4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
       |                                         ^~~~~~~~~~~
drivers/net/virtio_net.c:4552:17: note: ‘sprintf’ output between 9 and 
19 bytes into a destination of size 16
  4552 |                 sprintf(vi->sq[i].name, "output.%d", i);

"

Please review.

Best Regards,

Zhu Yanjun

在 2023/12/26 19:45, Zhu Yanjun 写道:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>
> Fix a warning when building virtio_net driver.
>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>   drivers/net/virtio_net.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 49625638ad43..cf57eddf768a 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4508,10 +4508,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>   {
>   	vq_callback_t **callbacks;
>   	struct virtqueue **vqs;
> -	int ret = -ENOMEM;
> -	int i, total_vqs;
>   	const char **names;
> +	int ret = -ENOMEM;
> +	int total_vqs;
>   	bool *ctx;
> +	u16 i;
>   
>   	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
>   	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by

