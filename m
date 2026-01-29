Return-Path: <netdev+bounces-254521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPOBKEfMemmu+gEAu9opvQ
	(envelope-from <netdev+bounces-254521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:56:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2F1AB476
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 03:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 35982302173B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 02:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B723570B2;
	Thu, 29 Jan 2026 02:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwepzzJk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBfp2RtX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E353B259CBD
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 02:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769655357; cv=pass; b=B9daXdIndb6kP6vgcyNEeWw/m3w1ex7/11Jpp4iK7NKHLmBwrsVTQY1ieyEhiCdhlhp7POZ68oiBXYinwQGqQ2VI/IYKOTS7RE1pRRiO+JdeBuZXMvUM7wtSP8uhUxzAeEVxABHw084Q8qL1i9BZ5jTyGS78gLi01WIJWk72Jwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769655357; c=relaxed/simple;
	bh=8WHLTkIFY9R865s0/M6Z7RuX05rqpNFQ6Nu/ELhE7N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdaHue5qGAOjU3R/2o54LdUxrzb2fHWy3ggKljbeUFKXTL82XgbDfbyT27kufSN7szuvGNlnw2+YY8Uzx7iALDMy6hNgFILjkw9fGmMbZUVwpQyStTG22PW8E5XaFqfChTCIBrk1D+um0+USRJpb941oMk3R/HM2tSKBcShNo60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JwepzzJk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBfp2RtX; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769655348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=laTNjwzjXI7QepEnGjmg2CpRxzpsO5Laq3qTT9ZtSVU=;
	b=JwepzzJkyNlh+mS5FTI0xjJcaaaDDonEkajITZfFURS0X8ToxduFCK1Eg9i6uxJ+g56j0l
	u/RwfBYM1YthNbvnFv6RIITKuLsw+m+kChBDUo3HafkPrNXEvRtWABPC2MrP+7Nhy9PBpG
	SrI1GzwxC/fnsibwTcuFtIWIpU/36G8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-jImnP6IqMq6ChZLAOv5CLQ-1; Wed, 28 Jan 2026 21:55:47 -0500
X-MC-Unique: jImnP6IqMq6ChZLAOv5CLQ-1
X-Mimecast-MFC-AGG-ID: jImnP6IqMq6ChZLAOv5CLQ_1769655346
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c213419f5so494729a91.2
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:55:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769655346; cv=none;
        d=google.com; s=arc-20240605;
        b=SUUBrjM9AiszRxkmchGW8KUWab4x3ZytSubBPMDllXaxMdrv7BBNFj0SDfq1XzM9Tx
         FGS66M8pzg/U7wF2xGojzbwJ4+0intROjNlvDDQ2I2dEVQnGQ8XGL4nkQAOAiYNqCH7T
         zw0hTc6z/Y+O9TrnvaDzBoEfxP9jDlw4YxZ5WAU8vwSaHfxvRHcyf+SplepjsdqlTwFq
         2IbktqYKVIK++WLsI+T9VarsPB1PMHPQnMFZ01rNi3Y4hfNjHqifPTx8a5HHncvm9aAE
         Ky0Zqox4JkuHpTl2Uz9l1efhXeidyuapcSmUZy8Eo8gtai6UwTw1yNkqYmEDGFoX0P1R
         6NBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=laTNjwzjXI7QepEnGjmg2CpRxzpsO5Laq3qTT9ZtSVU=;
        fh=lZYIL74MltPDcVkeUheZespTzemFYoo12dGjuBxrcJM=;
        b=cYsFecjauRe1OfMnLbCEA/bD7gAQA5S2Yd6NeW/Z6YUPp1aV2qMO2xMOiYWDkrYXUM
         VsP9t4yk9YBGLaqgpFDs9CQfaBLcINsMOJfbnxrBr+FfTuMf6oS99IzPHBwU4Ridac4h
         HBV+eImM/fX+m5+cpo8oB69WzlgvXIxwI/1HeoKCVcB5SZTcwsGZqcEOplCnrtilaXMT
         LhT98s0pDVEvJSxf0/jv2FLNleS/mELetx/m/x1A0M9Ud53o2/b9rVGUYMr2qoyPBdWy
         hFg39IkUFGZQ+cK+x0h7qjRJvtZU1g+aKzjMsnBvPB02gzQNnswzP+gdEk/6ngUdtCj9
         pt3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769655346; x=1770260146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laTNjwzjXI7QepEnGjmg2CpRxzpsO5Laq3qTT9ZtSVU=;
        b=FBfp2RtXkCeNGwrISMKpdFxS+sWAhwyswMAlptMNk8olBBQXM27n+0L2Fwtim5syuF
         PHrbLaWKXXBp5BupL6B0lh2D36ONR6WPkAsocVquDEnpkn3K3f+hom6XRkd/CqKtnVGE
         DR/IbV2Ijq3vdviNabv41nPSR9/lluZe2bWhHHLFqF7RiaJ6xXdek44BPYEX+zYUcITC
         ZhWjOqgXmmNv1ITz5KPMHoc87QxJ/p4JsUFJ+M+wDeWPwIIO7ESy4em1aS3Gk8zBQMAv
         zjt1pJVxr8NPRs8RRF8nhO1bVcQD2hH1VjBKYry8GBoJ7by+G2phnAYEVKLyEXxq2k4/
         gv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769655346; x=1770260146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laTNjwzjXI7QepEnGjmg2CpRxzpsO5Laq3qTT9ZtSVU=;
        b=N3pB2HoMb8pAoJbH6rzhXYdTU5HGi7PuIYKv2IWtO9386GzFvLPtso6CXMQyV6955W
         rulHb27S6d2sEX8fB5IjzV5JpzHb1I8MPYfwEw/RGKTjBF7MmuDFYybIsMkTLhve9DsI
         nMRDcdoCbd50s6iQaYCfE/dBRzwoIrIjO86ox8BoSfGR6eNemJfNiV0Z1peqBMw+IdRt
         JZTRxnX9xIK+jHB7s9z7WxBG9uozkbygS35Cu8hKy5joYcSAZO8tsjpgwyOvSWlrEyyn
         9QidrCW566AaF4ux4cVQr69cUJV6Z+yIZ/wLxZ7wIj2/O76nYSAtO4ipDFk+gVY9ZoHC
         grHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7q6FdJW+dfHV3bMOHLbc8i/GBF/2/8LE5zU4//RSAZdjVV8bGnBWKut5I3wXEPcYNfEPVJNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWCMb8zy5e8zlYz0hvdnOADz9kwYPTtm/7y2MLSIis1zEewL2H
	nnDvHhQlDZR9ZVkahRNiLncGyYIBnQVfN/rkMz3lyD85/Gbhw9F780IHQAtEeMB0VpmwySImxPB
	n4sVjHAlNt6l8c6wsBvZd1hSuUjELgdPi5+Kd5ECbrsZiUHbCIr1A9vHJdYdvVSNUQMUw8FLIOj
	N+aLgsHtzx2VmXy5RCdi48ONbY4CNQy8hlqBposbPo
X-Gm-Gg: AZuq6aLPfYF7npvZI0ogLLthsx6wtBa/jTfjriuCuyQcGE89K0exfzXsY0HBA3Swsiq
	28aPVpGh4Dyail+Bivwc5Q2HiBbVh4wyUikvFlg0/lyqO2ia9hb64doUAd+R1ciOzn8a2f2Yw/e
	GEIrTueekqkCuLMjj532HSoktjZInxYsJrCuKP8QONjORXEnUmJjQgKsDNxXfZ7zZo
X-Received: by 2002:a17:90b:1fce:b0:33b:bed8:891c with SMTP id 98e67ed59e1d1-353fed7583dmr7398707a91.23.1769655345893;
        Wed, 28 Jan 2026 18:55:45 -0800 (PST)
X-Received: by 2002:a17:90b:1fce:b0:33b:bed8:891c with SMTP id
 98e67ed59e1d1-353fed7583dmr7398682a91.23.1769655345448; Wed, 28 Jan 2026
 18:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128212031.1431746-1-vishs@meta.com>
In-Reply-To: <20260128212031.1431746-1-vishs@meta.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 29 Jan 2026 10:55:33 +0800
X-Gm-Features: AZwV_Qh3rU3z9hasWrlauUxdKQvDrk_izc_BcKGtFI-jPDEG4gU-QARYYCm_XLY
Message-ID: <CACGkMEvYv-gJFDtQMWgfA9BfsfMQjn+xbqg4cgDET9eXrcRwvA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 0/2] virtio_net: add page_pool support
To: Vishwanath Seshagiri <vishs@meta.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254521-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jasowang@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1D2F1AB476
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 5:20=E2=80=AFAM Vishwanath Seshagiri <vishs@meta.co=
m> wrote:
>
> Introduce page_pool support in virtio_net driver to enable page recycling
> in RX buffer allocation and avoid repeated page allocator calls. This
> applies to mergeable and small buffer modes.
>
> Beyond performance improvements, this patch is a prerequisite for enablin=
g
> memory provider-based zero-copy features in virtio_net, specifically devm=
em
> TCP and io_uring ZCRX, which require drivers to use page_pool for buffer
> management.
>
> The implementation preserves the DMA premapping optimization introduced i=
n
> commit 31f3cd4e5756 ("virtio-net: rq submits premapped per-buffer") by
> conditionally using PP_FLAG_DMA_MAP when the virtio backend supports
> standard DMA API (vhost, virtio-pci), and falling back to allocation-only
> mode for backends with custom DMA mechanisms (VDUSE).
>
> Changes in v2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Addressing reviewer feedback from v1:
>
> - Add "select PAGE_POOL" to Kconfig (Jason Wang)
> - Move page pool creation from ndo_open to probe for device lifetime
>   management (Xuan Zhuo, Jason Wang)
> - Implement conditional DMA strategy using virtqueue_dma_dev():
>   - When non-NULL: use PP_FLAG_DMA_MAP for page_pool-managed DMA premappi=
ng
>   - When NULL (VDUSE): page_pool handles allocation only
> - Use page_pool_get_dma_addr() + virtqueue_add_inbuf_premapped() to
>   preserve DMA premapping optimization from commit 31f3cd4e5756
>   ("virtio-net: rq submits premapped per-buffer") (Jason Wang)
> - Remove dual allocation code paths - page_pool now always used for
>   small/mergeable modes (Jason Wang)
> - Remove unused virtnet_rq_alloc/virtnet_rq_init_one_sg functions
> - Add comprehensive performance data (Michael S. Tsirkin)
> - v1 link: https://lore.kernel.org/virtualization/20260106221924.123856-1=
-vishs@meta.com/
>
> Performance Results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Tested using iperf3 TCP_STREAM with virtio-net on vhost backend.
> 300-second runs, results show throughput and TCP retransmissions.
> The base kernel is synced to net tree and commit: 709bbb015538.
>
> Mergeable Buffer Mode (mrg_rxbuf=3Don, GSO enabled, MTU 1500):
> +--------+---------+---------+------------+------------+--------+--------=
+
> | Queues | Streams |  Patch  | Throughput |   Retries  | Delta  | Retry% =
|
> +--------+---------+---------+------------+------------+--------+--------=
+
> |   1    |    1    |  base   |  25.7 Gbps |      0     |   -    |   -    =
|
> |   1    |    1    |   pp    |  26.2 Gbps |      0     | +1.9%  |   0%   =
|
> +--------+---------+---------+------------+------------+--------+--------=
+
> |   8    |    8    |  base   |  95.6 Gbps |  236,432   |   -    |   -    =
|
> |   8    |    8    |   pp    |  97.9 Gbps |  188,249   | +2.4%  | -20.4% =
|
> +--------+---------+---------+------------+------------+--------+--------=
+
>
> Small Buffer Mode (mrg_rxbuf=3Doff, GSO disabled, MTU 1500):
> +--------+---------+---------+------------+------------+--------+--------=
+
> | Queues | Streams |  Patch  | Throughput |   Retries  | Delta  | Retry% =
|
> +--------+---------+---------+------------+------------+--------+--------=
+
> |   1    |    1    |  base   |  9.17 Gbps |    15,152  |   -    |   -    =
|
> |   1    |    1    |   pp    |  9.19 Gbps |    12,203  | +0.2%  | -19.5% =
|
> +--------+---------+---------+------------+------------+--------+--------=
+
> |   8    |    8    |  base   | 43.0 Gbps  |   974,500  |   -    |   -    =
|
> |   8    |    8    |   pp    | 44.7 Gbps  |   717,411  | +4.0%  | -26.4% =
|
> +--------+---------+---------+------------+------------+--------+--------=
+

It would be better to have more benchmark like:

PPS (using pktgen on host and XDP_DROP in the guest)

We can see PPS as well as XDP performance as well.

Thanks

>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
>
> The patches have been tested with:
> - iperf3 bulk transfer workloads (multiple queue/stream configurations)
> - Included selftests for buffer circulation verification
> - Edge case testing: device unbind/bind cycles, rapid interface open/clos=
e,
>   traffic during close, ethtool feature toggling, close with pending refi=
ll
>   work, and data integrity verification
>
> Vishwanath Seshagiri (2):
>   virtio_net: add page_pool support for buffer allocation
>   selftests: virtio_net: add buffer circulation test
>
>  drivers/net/Kconfig                           |   1 +
>  drivers/net/virtio_net.c                      | 353 ++++++++++--------
>  .../drivers/net/virtio_net/basic_features.sh  |  70 ++++
>  3 files changed, 273 insertions(+), 151 deletions(-)
>
> --
> 2.47.3
>


