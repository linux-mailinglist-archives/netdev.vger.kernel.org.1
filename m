Return-Path: <netdev+bounces-140952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2BA9B8D37
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 09:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5734B2103E
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ABF156C70;
	Fri,  1 Nov 2024 08:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeJNe5QC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2684087C;
	Fri,  1 Nov 2024 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730450316; cv=none; b=oS8QGJWlFItUbr3EHCEkluB3F8ZRnUgBtwMULoNNbi+tmiEL5l13hgFK4HcresScGOgYZPXLm7CPhuxa/q0YWWjgEcBYrZAa6J+BHU8BLl8awvpHPe66ExzbWe8zcXWI953XjpMHZKPrGjD4GzFqfVl3T71LUVn71i6bn5zU/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730450316; c=relaxed/simple;
	bh=PhXxH3Z/ltNgwYhM5c6aEv3VTRIKKPaInCVryOk19KU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NI/IBm1Yrma6GJqH+FO6dN7P4Fv+b2w0x3KH6l7nWur4O4Y4hGUKX8s4Qo5H3s8/Il2m+OoOZaztZ03NldbEJAGBcZztqvJ23Y39qNwNzKineXcNOMLEH8QXOJNQ4tmHc4DyS88aHGG19ZZhJEYAzpzhr6oml5u08x0D3gVfkfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FeJNe5QC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730450314; x=1761986314;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=PhXxH3Z/ltNgwYhM5c6aEv3VTRIKKPaInCVryOk19KU=;
  b=FeJNe5QC9xM9LxAVy9mlnmelVlTSlrVmRGvXVlVkRzuGrTbA+Ea9iekU
   tOucTzd6nxP8OzIEmMrgoKuXywloV5t6JPQZL2lSFnhjHTt8J9B529IEn
   1ru1rkrJtSmVfiaH9SYalcj2Xn1XbbRGL9GI1UQq6WUQEnIVJazyBj5U2
   i3uMj5J9uqSeyZCYc++XD9CZf5Pj6zZfc8mPFOy4rJ7BUmkINsZ3w1kst
   s2ZLdHmbtxxrcZirGdqITrMZsDtzvINZ7IFifQYdJ3+URxCqGuKRKTvgp
   176kLfamckT3KNILRQJAqpLmeX3iuXc3JrM8O8+0y1+5j6j6S4ofjnBzd
   Q==;
X-CSE-ConnectionGUID: 4KnUsKF5Sem2LGLwX/y1Xw==
X-CSE-MsgGUID: vaVnYYdGSKyPa7ANc/2z9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30325689"
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="30325689"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:38:33 -0700
X-CSE-ConnectionGUID: 3SJb+PQpTZ+pFH8NKO3uCA==
X-CSE-MsgGUID: jJM27wa3Qpm+88z9uC9o4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,249,1725346800"; 
   d="scan'208";a="83052207"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 01:38:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 1 Nov 2024 10:38:23 +0200 (EET)
To: Jinjie Ruan <ruanjinjie@huawei.com>
cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com, 
    haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com, 
    ricardo.martinez@linux.intel.com, loic.poulain@linaro.org, 
    ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch, 
    davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
    pabeni@redhat.com, Netdev <netdev@vger.kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v3] net: wwan: t7xx: Fix off-by-one error in
 t7xx_dpmaif_rx_buf_alloc()
In-Reply-To: <20241101025316.3234023-1-ruanjinjie@huawei.com>
Message-ID: <1645aca2-2231-6ac4-d8cf-eddbb16259be@linux.intel.com>
References: <20241101025316.3234023-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-140363434-1730450303=:1235"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-140363434-1730450303=:1235
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 1 Nov 2024, Jinjie Ruan wrote:

> The error path in t7xx_dpmaif_rx_buf_alloc(), free and unmap the already
> allocated and mapped skb in a loop, but the loop condition terminates whe=
n
> the index reaches zero, which fails to free the first allocated skb at
> index zero.
>=20
> Check with i-- so that skb at index 0 is freed as well.
>=20
> Cc: stable@vger.kernel.org
> Fixes: d642b012df70 ("net: wwan: t7xx: Add data path interface")
> Acked-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v3:
> - Remove suggested-by.
> - Use i-- to simplify the fix.
> - Add Acked-by.
> - Add cc stable.
> - Update the commit message.
> v2:
> - Update the commit title.
> - Declare i as signed to avoid the endless loop.
> ---
>  drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c b/drivers/net/wwa=
n/t7xx/t7xx_hif_dpmaif_rx.c
> index 210d84c67ef9..7a9c09cd4fdc 100644
> --- a/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> +++ b/drivers/net/wwan/t7xx/t7xx_hif_dpmaif_rx.c
> @@ -226,7 +226,7 @@ int t7xx_dpmaif_rx_buf_alloc(struct dpmaif_ctrl *dpma=
if_ctrl,
>  =09return 0;
> =20
>  err_unmap_skbs:
> -=09while (--i > 0)
> +=09while (i--)
>  =09=09t7xx_unmap_bat_skb(dpmaif_ctrl->dev, bat_req->bat_skb, i);
> =20
>  =09return ret;
>=20

Thanks.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-140363434-1730450303=:1235--

