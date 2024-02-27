Return-Path: <netdev+bounces-75460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E16786A005
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 20:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8684A1C238AF
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D46351009;
	Tue, 27 Feb 2024 19:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKWuOCRa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D0BEEDD;
	Tue, 27 Feb 2024 19:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709061585; cv=none; b=tJQpXIWvFzFn1HHHwVH6YH0fcbJ2Vd8nAhlbpFaghQGw98QBLp1kWxwneLfyJgJi5ha+rkkxCUp2Qp9fg/tC5pyB4IXG9m16qP+cbjfBs/zr8avEYkOtBp8eWrdGb9+VSoX2YpEOEdAyKfzapT6fGIJdwRIPEmqCCOXhS0VU2CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709061585; c=relaxed/simple;
	bh=7Y3r+EJtxbHthsDme0mY5gR+malntaQv6UjEuo6p+TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBuVQeBmOauDdplvWQqsd6JLg7BwQQCdbtEvPEOfH7cBAG1gkuZKM+4TtgFPq94SKHMKkZFotPATsbEozWHRh/ogPn2XOY+CUL4K1LdHG5OK/+7ph+mzghUdWHYEMsQUF7sJ++XwbY9SQt1apW9ftaziQRZ0rxvgh98Kl9elSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKWuOCRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA510C433C7;
	Tue, 27 Feb 2024 19:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709061584;
	bh=7Y3r+EJtxbHthsDme0mY5gR+malntaQv6UjEuo6p+TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKWuOCRadSwwZAbUAoA4YqNVQfMxsf4tADIp++AMn3d7WimEALFdpQVyUFSNjVqKL
	 UG+1vFPy7r+WIRqO/nv8CXfVrpUb10VQYTXz04ZMf+Q9lBpU30A2Dsem/MKcfbTrAn
	 ujndKLEiu+9liEo2pJxIX8Jq8bS/VwCwfyTgfUrZ5B/fvMREEsk3jBvkVD6CcEXkqj
	 B/7/w68pyB+dpIca1Jgmp+pEch3qRnoge7t2D+z+Y3dqOREqZfSXM3am8b3Oo8mZPe
	 7sJ3/uoy5/Onvo9oIwiAxEWdqj3dRBn2ak/D2rqDyry9oqpJ/E7OOIuQ57Wk9H7IXO
	 QEnA3bbJxOySw==
Date: Tue, 27 Feb 2024 19:19:40 +0000
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v3 3/6] virtio_net: support device stats
Message-ID: <20240227191940.GM277116@kernel.org>
References: <20240227080303.63894-1-xuanzhuo@linux.alibaba.com>
 <20240227080303.63894-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227080303.63894-4-xuanzhuo@linux.alibaba.com>

On Tue, Feb 27, 2024 at 04:03:00PM +0800, Xuan Zhuo wrote:
> As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> 
> make virtio-net support getting the stats from the device by ethtool -S
> <eth0>.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

...

> +static int virtnet_get_hw_stats(struct virtnet_info *vi,
> +				struct virtnet_stats_ctx *ctx)
> +{
> +	struct virtio_net_ctrl_queue_stats *req;
> +	struct virtio_net_stats_reply_hdr *hdr;
> +	struct scatterlist sgs_in, sgs_out;
> +	u32 num_rx, num_tx, num_cq, offset;
> +	int qnum, i, j,  qid, res_size;
> +	struct virtnet_stats_map *m;
> +	void *reply, *p;
> +	u64 bitmap;
> +	int ok;
> +	u64 *v;
> +
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
> +		return 0;
> +
> +	qnum = 0;
> +	if (ctx->bitmap_cq)
> +		qnum += 1;
> +
> +	if (ctx->bitmap_rx)
> +		qnum += vi->curr_queue_pairs;
> +
> +	if (ctx->bitmap_tx)
> +		qnum += vi->curr_queue_pairs;
> +
> +	req = kcalloc(qnum, sizeof(*req), GFP_KERNEL);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	res_size = (ctx->size_rx + ctx->size_tx) * vi->curr_queue_pairs + ctx->size_cq;
> +	reply = kmalloc(res_size, GFP_KERNEL);
> +	if (!reply) {
> +		kfree(req);
> +		return -ENOMEM;
> +	}
> +
> +	j = 0;
> +	for (i = 0; i < vi->curr_queue_pairs; ++i) {
> +		if (ctx->bitmap_rx) {
> +			req->stats[j].vq_index = cpu_to_le16(i * 2);
> +			req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_rx);
> +			++j;
> +		}
> +
> +		if (ctx->bitmap_tx) {
> +			req->stats[j].vq_index = cpu_to_le16(i * 2 + 1);
> +			req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_tx);
> +			++j;
> +		}
> +	}
> +
> +	if (ctx->size_cq) {
> +		req->stats[j].vq_index = cpu_to_le16(vi->max_queue_pairs * 2);
> +		req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_cq);
> +		++j;
> +	}
> +
> +	sg_init_one(&sgs_out, req, sizeof(*req) * j);
> +	sg_init_one(&sgs_in, reply, res_size);
> +
> +	ok = virtnet_send_command(vi, VIRTIO_NET_CTRL_STATS,
> +				  VIRTIO_NET_CTRL_STATS_GET,
> +				  &sgs_out, &sgs_in);
> +	kfree(req);
> +
> +	if (!ok) {
> +		kfree(reply);
> +		return ok;
> +	}
> +
> +	num_rx = VIRTNET_RQ_STATS_LEN + ctx->num_rx;
> +	num_tx = VIRTNET_SQ_STATS_LEN + ctx->num_tx;
> +	num_cq = ctx->num_tx;
> +
> +	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
> +		hdr = p;
> +
> +		qid = le16_to_cpu(hdr->vq_index);
> +
> +		if (qid == vi->max_queue_pairs * 2) {
> +			offset = 0;
> +			bitmap = ctx->bitmap_cq;
> +		} else if (qid % 2) {
> +			offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
> +			offset += VIRTNET_SQ_STATS_LEN;
> +			bitmap = ctx->bitmap_tx;
> +		} else {
> +			offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
> +			bitmap = ctx->bitmap_rx;
> +		}
> +
> +		for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
> +			m = &virtio_net_stats_map[i];
> +
> +			if (m->stat_type & bitmap)
> +				offset += m->num;
> +
> +			if (hdr->type != m->reply_type)
> +				continue;
> +
> +			for (j = 0; j < m->num; ++j) {
> +				v = p + m->desc[j].offset;
> +				ctx->data[offset + j] = le64_to_cpu(*v);

Hi Xuan Zhuo,

Sparse complains about the line above because the type of *v is u64,
but le64_to_cpu() expects __le64.

> +			}
> +
> +			break;
> +		}
> +	}
> +
> +	kfree(reply);
> +	return 0;
> +}
> +
>  static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);

...

