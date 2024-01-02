Return-Path: <netdev+bounces-60806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FB3821908
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 10:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4709B216D2
	for <lists+netdev@lfdr.de>; Tue,  2 Jan 2024 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CB07470;
	Tue,  2 Jan 2024 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tAZBdVDF"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02686ADE
	for <netdev@vger.kernel.org>; Tue,  2 Jan 2024 09:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2c7d53d8-7d54-40cc-8125-9ba5386d79f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1704188738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjMCcoTaY4VEGSTp02c4ClvQDmLyaLw1IwNwdYNG/Yc=;
	b=tAZBdVDFzz8odBW2BdocAs+uff5mAvUsJWuIZHosiSjwTAgH1hWgkNCdnoFkB8DEhhoYMK
	68k1aCWVFjwSmah/hlEM57Kx864lFM0bl1cbsCcLjGmj0kgGq+0BCYpY3Hq/HMU1djYEa9
	iZofCM5BEDUuNMwgV+eOCT90LzNUwI4=
Date: Tue, 2 Jan 2024 17:45:31 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v1 3/6] virtio_net: support device stats
To: kernel test robot <lkp@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev
References: <20231226073103.116153-4-xuanzhuo@linux.alibaba.com>
 <202401020308.rvzTx1oI-lkp@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <202401020308.rvzTx1oI-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/1/2 3:56, kernel test robot 写道:
> Hi Xuan,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on mst-vhost/linux-next]
> [also build test WARNING on linus/master v6.7-rc8]
> [cannot apply to net-next/main horms-ipvs/master next-20231222]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Xuan-Zhuo/virtio_net-introduce-device-stats-feature-and-structures/20231226-153227
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
> patch link:    https://lore.kernel.org/r/20231226073103.116153-4-xuanzhuo%40linux.alibaba.com
> patch subject: [PATCH net-next v1 3/6] virtio_net: support device stats
> config: x86_64-randconfig-121-20240101 (https://download.01.org/0day-ci/archive/20240102/202401020308.rvzTx1oI-lkp@intel.com/config)
> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240102/202401020308.rvzTx1oI-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202401020308.rvzTx1oI-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
>>> drivers/net/virtio_net.c:3432:52: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __virtio16 [usertype] val @@     got restricted __le16 [usertype] vq_index @@
>     drivers/net/virtio_net.c:3432:52: sparse:     expected restricted __virtio16 [usertype] val
>     drivers/net/virtio_net.c:3432:52: sparse:     got restricted __le16 [usertype] vq_index
>     drivers/net/virtio_net.c:3457:83: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __virtio64 [usertype] val @@     got unsigned long long [usertype] @@
>     drivers/net/virtio_net.c:3457:83: sparse:     expected restricted __virtio64 [usertype] val
>     drivers/net/virtio_net.c:3457:83: sparse:     got unsigned long long [usertype]
>>> drivers/net/virtio_net.c:3429:81: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __virtio16 [usertype] val @@     got restricted __le16 [usertype] size @@
>     drivers/net/virtio_net.c:3429:81: sparse:     expected restricted __virtio16 [usertype] val
>     drivers/net/virtio_net.c:3429:81: sparse:     got restricted __le16 [usertype] size
>>> drivers/net/virtio_net.c:3519:82: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __virtio64 [usertype] val @@     got restricted __le64 [assigned] [usertype] v @@
>     drivers/net/virtio_net.c:3519:82: sparse:     expected restricted __virtio64 [usertype] val
>     drivers/net/virtio_net.c:3519:82: sparse:     got restricted __le64 [assigned] [usertype] v

I can reproduce these warnings in the local host.

It seems that the followings can fix these warnings.

"

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 1f4d9605552f..62e40234e29c 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3426,10 +3426,10 @@ static int virtnet_get_hw_stats(struct 
virtnet_info *vi,
         num_tx = VIRTNET_SQ_STATS_LEN + ctx->num_tx;
         num_cq = ctx->num_tx;

-       for (p = reply; p - reply < res_size; p += 
virtio16_to_cpu(vi->vdev, hdr->size)) {
+       for (p = reply; p - reply < res_size; p += 
virtio16_to_cpu(vi->vdev, (__virtio16 __force)hdr->size)) {
                 hdr = p;

-               qid = virtio16_to_cpu(vi->vdev, hdr->vq_index);
+               qid = virtio16_to_cpu(vi->vdev, (__virtio16 
__force)(hdr->vq_index));

                 if (qid == vi->max_queue_pairs * 2) {
                         offset = 0;
@@ -3454,7 +3454,7 @@ static int virtnet_get_hw_stats(struct 
virtnet_info *vi,

                         for (j = 0; j < m->num; ++j) {
                                 v = p + m->desc[j].offset;
-                               ctx->data[offset + j] = 
virtio64_to_cpu(vi->vdev, *v);
+                               ctx->data[offset + j] = 
virtio64_to_cpu(vi->vdev, (__virtio64 __force)*v);
                         }

                         break;
@@ -3516,7 +3516,7 @@ static int virtnet_get_sset_count(struct 
net_device *dev, int sset)
                                 __le64 v;

                                 v = 
vi->ctrl->stats_cap.supported_stats_types[0];
-                               vi->device_stats_cap = 
virtio64_to_cpu(vi->vdev, v);
+                               vi->device_stats_cap = 
virtio64_to_cpu(vi->vdev, (__virtio64 __force)v);
                         }
                 }

"

Not sure whether the above diff are good to the whole commit or not.

Zhu Yanjun

>
> vim +3432 drivers/net/virtio_net.c
>
>    3352	
>    3353	static int virtnet_get_hw_stats(struct virtnet_info *vi,
>    3354					struct virtnet_stats_ctx *ctx)
>    3355	{
>    3356		struct virtio_net_ctrl_queue_stats *req;
>    3357		struct virtio_net_stats_reply_hdr *hdr;
>    3358		struct scatterlist sgs_in, sgs_out;
>    3359		u32 num_rx, num_tx, num_cq, offset;
>    3360		int qnum, i, j,  qid, res_size;
>    3361		struct virtnet_stats_map *m;
>    3362		void *reply, *p;
>    3363		u64 bitmap;
>    3364		int ok;
>    3365		u64 *v;
>    3366	
>    3367		if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
>    3368			return 0;
>    3369	
>    3370		qnum = 0;
>    3371		if (ctx->bitmap_cq)
>    3372			qnum += 1;
>    3373	
>    3374		if (ctx->bitmap_rx)
>    3375			qnum += vi->curr_queue_pairs;
>    3376	
>    3377		if (ctx->bitmap_tx)
>    3378			qnum += vi->curr_queue_pairs;
>    3379	
>    3380		req = kcalloc(qnum, sizeof(*req), GFP_KERNEL);
>    3381		if (!req)
>    3382			return -ENOMEM;
>    3383	
>    3384		res_size = (ctx->size_rx + ctx->size_tx) * vi->curr_queue_pairs + ctx->size_cq;
>    3385		reply = kmalloc(res_size, GFP_KERNEL);
>    3386		if (!reply) {
>    3387			kfree(req);
>    3388			return -ENOMEM;
>    3389		}
>    3390	
>    3391		j = 0;
>    3392		for (i = 0; i < vi->curr_queue_pairs; ++i) {
>    3393			if (ctx->bitmap_rx) {
>    3394				req->stats[j].vq_index = cpu_to_le16(i * 2);
>    3395				req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_rx);
>    3396				++j;
>    3397			}
>    3398	
>    3399			if (ctx->bitmap_tx) {
>    3400				req->stats[j].vq_index = cpu_to_le16(i * 2 + 1);
>    3401				req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_tx);
>    3402				++j;
>    3403			}
>    3404		}
>    3405	
>    3406		if (ctx->size_cq) {
>    3407			req->stats[j].vq_index = cpu_to_le16(vi->max_queue_pairs * 2);
>    3408			req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_cq);
>    3409			++j;
>    3410		}
>    3411	
>    3412		sg_init_one(&sgs_out, req, sizeof(*req) * j);
>    3413		sg_init_one(&sgs_in, reply, res_size);
>    3414	
>    3415		ok = virtnet_send_command(vi, VIRTIO_NET_CTRL_STATS,
>    3416					  VIRTIO_NET_CTRL_STATS_GET,
>    3417					  &sgs_out, &sgs_in);
>    3418		kfree(req);
>    3419	
>    3420		if (!ok) {
>    3421			kfree(reply);
>    3422			return ok;
>    3423		}
>    3424	
>    3425		num_rx = VIRTNET_RQ_STATS_LEN + ctx->num_rx;
>    3426		num_tx = VIRTNET_SQ_STATS_LEN + ctx->num_tx;
>    3427		num_cq = ctx->num_tx;
>    3428	
>> 3429		for (p = reply; p - reply < res_size; p += virtio16_to_cpu(vi->vdev, hdr->size)) {
>    3430			hdr = p;
>    3431	
>> 3432			qid = virtio16_to_cpu(vi->vdev, hdr->vq_index);
>    3433	
>    3434			if (qid == vi->max_queue_pairs * 2) {
>    3435				offset = 0;
>    3436				bitmap = ctx->bitmap_cq;
>    3437			} else if (qid % 2) {
>    3438				offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
>    3439				offset += VIRTNET_SQ_STATS_LEN;
>    3440				bitmap = ctx->bitmap_tx;
>    3441			} else {
>    3442				offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
>    3443				bitmap = ctx->bitmap_rx;
>    3444			}
>    3445	
>    3446			for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
>    3447				m = &virtio_net_stats_map[i];
>    3448	
>    3449				if (m->flag & bitmap)
>    3450					offset += m->num;
>    3451	
>    3452				if (hdr->type != m->type)
>    3453					continue;
>    3454	
>    3455				for (j = 0; j < m->num; ++j) {
>    3456					v = p + m->desc[j].offset;
>    3457					ctx->data[offset + j] = virtio64_to_cpu(vi->vdev, *v);
>    3458				}
>    3459	
>    3460				break;
>    3461			}
>    3462		}
>    3463	
>    3464		kfree(reply);
>    3465		return 0;
>    3466	}
>    3467	
>    3468	static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>    3469	{
>    3470		struct virtnet_info *vi = netdev_priv(dev);
>    3471		unsigned int i, j;
>    3472		u8 *p = data;
>    3473	
>    3474		switch (stringset) {
>    3475		case ETH_SS_STATS:
>    3476			virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_CQ, 0, &p);
>    3477	
>    3478			for (i = 0; i < vi->curr_queue_pairs; i++) {
>    3479				for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
>    3480					ethtool_sprintf(&p, "rx_queue_%u_%s", i,
>    3481							virtnet_rq_stats_desc[j].desc);
>    3482	
>    3483				virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_RX, i, &p);
>    3484			}
>    3485	
>    3486			for (i = 0; i < vi->curr_queue_pairs; i++) {
>    3487				for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
>    3488					ethtool_sprintf(&p, "tx_queue_%u_%s", i,
>    3489							virtnet_sq_stats_desc[j].desc);
>    3490	
>    3491				virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_TX, i, &p);
>    3492			}
>    3493			break;
>    3494		}
>    3495	}
>    3496	
>    3497	static int virtnet_get_sset_count(struct net_device *dev, int sset)
>    3498	{
>    3499		struct virtnet_info *vi = netdev_priv(dev);
>    3500		struct virtnet_stats_ctx ctx = {0};
>    3501		u32 pair_count;
>    3502	
>    3503		switch (sset) {
>    3504		case ETH_SS_STATS:
>    3505			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS) &&
>    3506			    !vi->device_stats_cap) {
>    3507				struct scatterlist sg;
>    3508	
>    3509				sg_init_one(&sg, &vi->ctrl->stats_cap, sizeof(vi->ctrl->stats_cap));
>    3510	
>    3511				if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_STATS,
>    3512							  VIRTIO_NET_CTRL_STATS_QUERY,
>    3513							  NULL, &sg)) {
>    3514					dev_warn(&dev->dev, "Fail to get stats capability\n");
>    3515				} else {
>    3516					__le64 v;
>    3517	
>    3518					v = vi->ctrl->stats_cap.supported_stats_types[0];
>> 3519					vi->device_stats_cap = virtio64_to_cpu(vi->vdev, v);
>    3520				}
>    3521			}
>    3522	
>    3523			virtnet_stats_ctx_init(vi, &ctx, NULL);
>    3524	
>    3525			pair_count = VIRTNET_RQ_STATS_LEN + VIRTNET_SQ_STATS_LEN;
>    3526			pair_count += ctx.num_rx + ctx.num_tx;
>    3527	
>    3528			return ctx.num_cq + vi->curr_queue_pairs * pair_count;
>    3529		default:
>    3530			return -EOPNOTSUPP;
>    3531		}
>    3532	}
>    3533	
>

