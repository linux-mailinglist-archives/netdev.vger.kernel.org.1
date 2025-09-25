Return-Path: <netdev+bounces-226172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21371B9D57F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 05:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA457B3316
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 03:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5062E6CC3;
	Thu, 25 Sep 2025 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="G9sOACPm"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604B0202963
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 03:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772586; cv=none; b=otqY7E6LD42EUiOFFm/p8QpV2odmZoHfHSaSLuVc8aIlyMLR3s2spRMkxgcqROVcmR2LR3+o0WMrNPWPtDBIAIeS0P+KWsL6QRv67Jie32lqUow6i7g9hYac4cKCMx0W1GzSIy1Y7OpxwlUZMC8PQdBkwnC+f5m8UZh8qqz3Gfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772586; c=relaxed/simple;
	bh=/KIoZd0r1Y7KKzJ2RR52blGQ3ZRO0Y22C8ZgVh8YRwE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=oklCBcTRD5uqJDeWkdxv019SbIypAzi+CbvwOx14RTg8jApDCn+3iQUNrd9FUmK36tseoK5Wl/Vlpswo30g/wPLkiDw+7jxiSexh8epc8BU7yUqUU4uMNeaJBWOsE4AbANkAYeclMap0ksNp47tKJipHgJL2C29wpxoGYPAGbkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=G9sOACPm; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758772579; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=cYnBq4FpMSnVpjQPz1SwhErmA/eqFcylsAK7kkWeQSI=;
	b=G9sOACPmZRI20eM9VTmvXfy3TJKOk0Nt8FmSQZbciT+0eK7oHkaQ44by7ILgatg642PLesLPFC3of8EmnwMj+2ipsTwwxZ57alAgBEgUTACFvF3e+JXEaD/GSr/8LP61UPt2sc3+1Y4438YWxW1kjyXOZ/9FI9SW1q+1Xe/Pib0=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wom3LfR_1758772578 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 25 Sep 2025 11:56:18 +0800
Message-ID: <1758772569.13948-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 03/11] virtio_net: Create virtio_net directory
Date: Thu, 25 Sep 2025 11:56:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: <virtualization@lists.linux.dev>,
 <parav@nvidia.com>,
 <shshitrit@nvidia.com>,
 <yohadt@nvidia.com>,
 <xuanzhuo@linux.alibaba.com>,
 <eperezma@redhat.com>,
 <shameerali.kolothum.thodi@huawei.com>,
 <jgg@ziepe.ca>,
 <kevin.tian@intel.com>,
 <kuba@kernel.org>,
 <andrew+netdev@lunn.ch>,
 <edumazet@google.com>,
 Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>,
 <mst@redhat.com>,
 <jasowang@redhat.com>,
 <alex.williamson@redhat.com>,
 <pabeni@redhat.com>
References: <20250923141920.283862-1-danielj@nvidia.com>
 <20250923141920.283862-4-danielj@nvidia.com>
In-Reply-To: <20250923141920.283862-4-danielj@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue, 23 Sep 2025 09:19:12 -0500, Daniel Jurgens <danielj@nvidia.com> wro=
te:
> The flow filter implementaion requires minimal changes to the
> existing virtio_net implementation. It's cleaner to separate it into
> another file. In order to do so, move virtio_net.c into the new
> virtio_net directory, and create a makefile for it. Note the name is
> changed to virtio_net_main.c, so the module can retain the name
> virtio_net.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>

To help this work move forward smoothly, I don't recommend splitting the
directory structure within this patchset. Directory reorganization can be a
separate effort=C3=A2=E2=82=AC=E2=80=9DI've previously experimented with th=
is myself. I'd really
like to see this work progress smoothly.

Thanks.


> ---
>  MAINTAINERS                                               | 2 +-
>  drivers/net/Makefile                                      | 2 +-
>  drivers/net/virtio_net/Makefile                           | 8 ++++++++
>  .../net/{virtio_net.c =3D> virtio_net/virtio_net_main.c}    | 0
>  4 files changed, 10 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/net/virtio_net/Makefile
>  rename drivers/net/{virtio_net.c =3D> virtio_net/virtio_net_main.c} (100=
%)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8a770714101..09d26c4225a9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -26685,7 +26685,7 @@ F:	Documentation/devicetree/bindings/virtio/
>  F:	Documentation/driver-api/virtio/
>  F:	drivers/block/virtio_blk.c
>  F:	drivers/crypto/virtio/
> -F:	drivers/net/virtio_net.c
> +F:	drivers/net/virtio_net/
>  F:	drivers/vdpa/
>  F:	drivers/virtio/
>  F:	include/linux/vdpa.h
> diff --git a/drivers/net/Makefile b/drivers/net/Makefile
> index 73bc63ecd65f..cf28992658a6 100644
> --- a/drivers/net/Makefile
> +++ b/drivers/net/Makefile
> @@ -33,7 +33,7 @@ obj-$(CONFIG_NET_TEAM) +=3D team/
>  obj-$(CONFIG_TUN) +=3D tun.o
>  obj-$(CONFIG_TAP) +=3D tap.o
>  obj-$(CONFIG_VETH) +=3D veth.o
> -obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
> +obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net/
>  obj-$(CONFIG_VXLAN) +=3D vxlan/
>  obj-$(CONFIG_GENEVE) +=3D geneve.o
>  obj-$(CONFIG_BAREUDP) +=3D bareudp.o
> diff --git a/drivers/net/virtio_net/Makefile b/drivers/net/virtio_net/Mak=
efile
> new file mode 100644
> index 000000000000..c0a4725ddd69
> --- /dev/null
> +++ b/drivers/net/virtio_net/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the VirtIO Net driver
> +#
> +
> +obj-$(CONFIG_VIRTIO_NET) +=3D virtio_net.o
> +
> +virtio_net-objs :=3D virtio_net_main.o
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net/virtio_net=
_main.c
> similarity index 100%
> rename from drivers/net/virtio_net.c
> rename to drivers/net/virtio_net/virtio_net_main.c
> --
> 2.45.0
>

