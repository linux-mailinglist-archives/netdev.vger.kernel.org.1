Return-Path: <netdev+bounces-298800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V66dKr6DLGrpRwQAu9opvQ
	(envelope-from <netdev+bounces-298800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:10:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D2967CAA0
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:10:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ZJr43n2M;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298800-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298800-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB60430D157A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9B139A07E;
	Fri, 12 Jun 2026 22:10:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217E2395D86
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 22:10:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781302203; cv=pass; b=KlxR4G1uSZCAreVkF3nwAFMLumjBnnHmKTskODV7OzCw26siIscCuohx6uf7s/bAz55buCfMC0ZY/j0RltfmU7UAdOOLWbup5+wOiNyXURWrZL6lcqkXSLxJRcvS0i++slvKizC0iZLCQDzKsoed/Gwg9UtCEpKmx69HntoZOlo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781302203; c=relaxed/simple;
	bh=5k6yqdBaTPSP5JPVkYb+f2wIlhX/CpftvOgPEkPmKT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h758+J0/k//rDZeE8UkefmBk3CqfTSm2mJDBAULFnWWd86YSZD6nCbCpd6fM6zqYweD64WG4e/Ncxy9JA5DZ/1/32QsO/vf84F6AaMkXp0jfyKogiVWpVF2GZZe29+W0uwqh8XR2r8tiGuchO5AEMrwVsANsqSYWwlNRJ5FUQD4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZJr43n2M; arc=pass smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf2d865383so11905ad.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 15:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781302200; cv=none;
        d=google.com; s=arc-20240605;
        b=gYCcT4b8hmTWUgktxYwEnxwi9ZC4ydrYyB+Y3XQX5CoTNO82aab6it9RVQV7gDfP2c
         pYhpC+stcpwHJkWFlU4cLvFeIufAp8bRkFriCOTsD41yWYpcjEhN2Zj7kCkpkDSxpHqa
         SCwWMKYCNnM8zDb7YjyKMeWJT2EFBcXKaaCMCD6A0E4V04cQwQnHRXuS1OxERrdPrylk
         xnZpWKTquMB/B+M/HaIEz80k4Lj7vpwd8GV3LQ9ROaEPuhg04Suy+kW+UULcPxHAsfTk
         zxQuByjIhgrVj+VPq16mgLRKxc/nNxI2WGubGhWjO7uQ1d6KhC4zqoy5VFj+D3AP+bl9
         AJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QKE2ZtQnvdGOpkvugwRZpVP5AphORfxwr0s2buOnxRE=;
        fh=n/WltIjTHLixzIg1xPkcIQHmGvVWDW+ulzzwkI3iv4A=;
        b=Iw8oEmILnmirfouycywttc7fp9PSvKnI2o7hMIyXo5rlHkFYIsvC34mgOVTjj4weJB
         OateXGca8Gyg34BNvb/V5r3fYM6dGcZSY6rvYgAjsQ2PxVMo0zJxKYfTanXbESwfKufo
         naqgMq0PkluvliiQwbD5xr+M+nkshPkQ+irmnmAih7jHLuNTVWth4UjglrEftIohMpW2
         cL1ygZ01atYytDW1a4+tCcw3H8uqMIvMBEy7AuBYdtKaenjDptRQLpPWQbfihG4H3PFd
         917A7sJDbO7uBW+1mJvgU0put1fQIXfKohbJMsEILfcwKGUIpb2UufAdstPm4m+6u6Mj
         Itiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781302200; x=1781907000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QKE2ZtQnvdGOpkvugwRZpVP5AphORfxwr0s2buOnxRE=;
        b=ZJr43n2MOgFRmV07dlOC1GsD+ReS3ToltuX8ypbkPT4ts88jyLZzSnuIkq882hDbjW
         2G5EuOXxtLgAHu0s5th8ayeCg4tG3BkDeKX+ZqQyFYB4F6yNmAcea2GQKsPUOlBNa5M3
         +D8TGj+hR24ik3nf4wdMeFDF+1iHQ3MEbaPwWYLKpoge5XwnSJHNPbSPbY6O/9sw3LBK
         mxkdSAWsY+FiDOwbq6fXRZvnFhAYf+CI2h85kK4rSRYhYDKJzquO4jps2FP478Kv8/Te
         3S4A7L3IuamGDgvGN0dXeR9z0mxBnzzsMg+abXsZdvTS76RhtHyRCK1+LtTsE4CY41MO
         Jv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781302200; x=1781907000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QKE2ZtQnvdGOpkvugwRZpVP5AphORfxwr0s2buOnxRE=;
        b=ZtqLEOwG+sh0gS+q5NseRB1AY3RBn63lLdEW9YQkmuljMyrF7gO4/yDOkf/+jaQyQI
         A0Kqx8aG/PXr11hCG5Z47aNS5fn6OEXQTuC0b5a67hpLBWtRypT+ttnUD9vfxp7qASW4
         tF8ce6Lv8MRqDJVjI+nY6Zm+7Be3TEQsD+96wp7xOuHCe28vkRjTARh9XcPRl55HHAc+
         EAkxZEbOP5jXPdAg/hE0uMWAAK69OFAdUGIjEpZpesTksYWJ8ygJ6QzBaYghnOQvF0S3
         JOv1K/NAvXme1g+wDxmQyG2zWJ4YLKBHLDR25YRcRSMxX+mKuU/IDUnM5uuznjLcfSmS
         EQCw==
X-Forwarded-Encrypted: i=1; AFNElJ9lpfSoIUwPLwfHas8bx7RtEmAy0ei89Zg4ostSTsEe5qbuQtTO/GO8nqX4lJji1t32dP2ztGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM7Rr2Nf728/8UE3fxJV2ApO8qTqY31dH3MOGRiyHNxtswiCYl
	EUXoAiJBt4rsICE67gRnSSjZbCZ/EwaLgiKV9DcIB3+beZyA9jk8T9dEFtR3J0MTXsDoblzEEgT
	fj1p9bpChgsH9CUx3hgAymemE/mE1jySQ0CzX7vK4
X-Gm-Gg: Acq92OEDsGgOw5xNbYkZVNZOEJ5Fit7dpBMdzW7HQkZKzk/SYbqxpKJE+06gBAwM7AK
	D7tFN310WanpT6oNBjWtBIH+86hPVHnUWaaBt7sLbPGQVlEG6vDusTgm6G1CPgu0jyoC68YTYwM
	bdc3+2qhu2CRM7IRn86Hwgo/PynMko+Jfbl1oJiDE75auOmX7eSIzFq/HGyjdTtl1YMk9RjWcAo
	F8rZEvHrsZn7cHaiHsa9JF0NM8vhgkfjZW03ibkKnjGB+gf0ToaEZ5tO6MtLTA6avHUc621NJSs
	9d7DSH5c5WGf2n4KNsqyjdc49IS1MKsdSORora8MVDhPFHRAtewzmE6VE4+nrkgwaVBFYMiitfT
	cG0IJ
X-Received: by 2002:a17:903:1a10:b0:2c1:ee6e:be21 with SMTP id
 d9443c01a7336-2c665ee29acmr325995ad.31.1781302199752; Fri, 12 Jun 2026
 15:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781062575.git.wudi234@huawei.com> <02e87952a65aa268526ade2f03de6c76fbc1fe9d.1781062575.git.wudi234@huawei.com>
In-Reply-To: <02e87952a65aa268526ade2f03de6c76fbc1fe9d.1781062575.git.wudi234@huawei.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Fri, 12 Jun 2026 15:09:48 -0700
X-Gm-Features: AVVi8CdxJqeMmSzjQ53v5Dn8_bpQQKd9-BdDzC2HB19TjFcuu-SZVS7l5rWXz3Y
Message-ID: <CAEAWyHe6np4FjBjckicWNQjJB7nf9s=EC6sTtMkJ6niyffmBCw@mail.gmail.com>
Subject: Re: [PATCH net-next v09 1/5] hinic3: Add ethtool queue ops
To: Fan Gong <gongfan1@huawei.com>
Cc: Wu Di <wudi234@huawei.com>, Teng Peisen <tengpeisen@huawei.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>, 
	Mohsin Bashir <mohsin.bashr@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, luosifu <luosifu@huawei.com>, 
	Xin Guo <guoxin09@huawei.com>, Zhou Shuai <zhoushuai28@huawei.com>, 
	Wu Like <wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, 
	Zheng Jiezhen <zhengjiezhen@h-partners.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gongfan1@huawei.com,m:wudi234@huawei.com,m:tengpeisen@huawei.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:ioana.ciornei@nxp.com,m:mohsin.bashr@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:luosifu@huawei.com,m:guoxin09@huawei.com,m:zhoushuai28@huawei.com,m:wulike1@huawei.com,m:shijing34@huawei.com,m:zhengjiezhen@h-partners.com,m:maxime.chevallier@bootlin.com,m:andrew@lunn.ch,m:mohsinbashr@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298800-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[huawei.com,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,nxp.com,gmail.com,h-partners.com,bootlin.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04D2967CAA0

On Wed, Jun 10, 2026 at 12:05=E2=80=AFAM Fan Gong <gongfan1@huawei.com> wro=
te:
>
>   Implement following ethtool callback function:
> .get_ringparam
> .set_ringparam
>
>   These callbacks allow users to utilize ethtool for detailed
> queue depth configuration and monitoring.

The patch adds a new mutex. Would be good to call it out in the commit mess=
age.

>
> Co-developed-by: Wu Di <wudi234@huawei.com>
> Signed-off-by: Wu Di <wudi234@huawei.com>
> Co-developed-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Teng Peisen <tengpeisen@huawei.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> ---
>  .../ethernet/huawei/hinic3/hinic3_ethtool.c   |  93 ++++++++++++++++
>  .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   5 +-
>  .../net/ethernet/huawei/hinic3/hinic3_main.c  |   6 +
>  .../huawei/hinic3/hinic3_netdev_ops.c         | 104 ++++++++++++++++--
>  .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   9 ++
>  .../ethernet/huawei/hinic3/hinic3_nic_io.c    |   4 +-
>  .../ethernet/huawei/hinic3/hinic3_nic_io.h    |   8 +-
>  .../net/ethernet/huawei/hinic3/hinic3_rx.c    |   2 +-
>  8 files changed, 217 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c b/driver=
s/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> index 90fc16288de9..be9992a235f7 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_ethtool.c
> @@ -9,6 +9,7 @@
>  #include <linux/errno.h>
>  #include <linux/etherdevice.h>
>  #include <linux/netdevice.h>
> +#include <linux/netlink.h>
>  #include <linux/ethtool.h>
>
>  #include "hinic3_lld.h"
> @@ -409,6 +410,96 @@ hinic3_get_link_ksettings(struct net_device *netdev,
>         return 0;
>  }
>
> +static void hinic3_get_ringparam(struct net_device *netdev,
> +                                struct ethtool_ringparam *ring,
> +                                struct kernel_ethtool_ringparam *kernel_=
ring,
> +                                struct netlink_ext_ack *extack)
> +{
> +       struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
> +
> +       ring->rx_max_pending =3D HINIC3_MAX_RX_QUEUE_DEPTH;
> +       ring->tx_max_pending =3D HINIC3_MAX_TX_QUEUE_DEPTH;
> +       ring->rx_pending =3D nic_dev->q_params.rq_depth;
> +       ring->rx_pending =3D nic_dev->q_params.sq_depth;

copy-paste error

> +}
> +
> +static void hinic3_update_qp_depth(struct net_device *netdev,
> +                                  u32 sq_depth, u32 rq_depth)
> +{
> +       struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
> +       u16 i;
> +
> +       nic_dev->q_params.sq_depth =3D sq_depth;
> +       nic_dev->q_params.rq_depth =3D rq_depth;
> +       for (i =3D 0; i < nic_dev->max_qps; i++) {
> +               nic_dev->txqs[i].q_depth =3D sq_depth;
> +               nic_dev->txqs[i].q_mask =3D sq_depth - 1;
> +               nic_dev->rxqs[i].q_depth =3D rq_depth;
> +               nic_dev->rxqs[i].q_mask =3D rq_depth - 1;
> +       }
> +}
> +
> +static int hinic3_check_ringparam_valid(struct net_device *netdev,
> +                                       const struct ethtool_ringparam *r=
ing,
> +                                       struct netlink_ext_ack *extack)
> +{
> +       if (ring->tx_pending < HINIC3_MIN_QUEUE_DEPTH ||
> +           ring->rx_pending < HINIC3_MIN_QUEUE_DEPTH) {
> +               NL_SET_ERR_MSG_FMT_MOD(extack,
> +                                      "Queue depth out of range tx[%d-%d=
] rx[%d-%d]",
> +                                      HINIC3_MIN_QUEUE_DEPTH,
> +                                      HINIC3_MAX_TX_QUEUE_DEPTH,
> +                                      HINIC3_MIN_QUEUE_DEPTH,
> +                                      HINIC3_MAX_RX_QUEUE_DEPTH);

Consider updating this error message to only call out when the ring
sizes are below the minimum supported value - since that's the check
introduced here and also since ethtool core will reject any values
that are higher than the maximum supported ring sizes.

> +
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
> +static int hinic3_set_ringparam(struct net_device *netdev,
> +                               struct ethtool_ringparam *ring,
> +                               struct kernel_ethtool_ringparam *kernel_r=
ing,
> +                               struct netlink_ext_ack *extack)
> +{
> +       struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
> +       struct hinic3_dyna_txrxq_params q_params =3D {};
> +       u32 new_sq_depth, new_rq_depth;
> +       int err;
> +
> +       err =3D hinic3_check_ringparam_valid(netdev, ring, extack);
> +       if (err)
> +               return err;
> +
> +       new_sq_depth =3D 1U << ilog2(ring->tx_pending);
> +       new_rq_depth =3D 1U << ilog2(ring->rx_pending);

Why not use rounddown_pow_of_two()? More readable...

> +       if (new_sq_depth =3D=3D nic_dev->q_params.sq_depth &&
> +           new_rq_depth =3D=3D nic_dev->q_params.rq_depth)
> +               return 0;
> +
> +       if (new_sq_depth !=3D ring->tx_pending ||
> +           new_rq_depth !=3D ring->rx_pending)
> +               NL_SET_ERR_MSG_FMT_MOD(extack,
> +                                      "Requested Tx/Rx ring depth %u/%u =
trimmed to %u/%u",
> +                                      ring->tx_pending, ring->rx_pending=
,
> +                                      new_sq_depth, new_rq_depth);
> +
> +       if (!netif_running(netdev)) {
> +               hinic3_update_qp_depth(netdev, new_sq_depth, new_rq_depth=
);
> +       } else {
> +               q_params =3D nic_dev->q_params;
> +               q_params.sq_depth =3D new_sq_depth;
> +               q_params.rq_depth =3D new_rq_depth;
> +
> +               err =3D hinic3_change_channel_settings(netdev, &q_params)=
;
> +               if (err)
> +                       return err;
> +       }
> +
> +       return 0;
> +}
> +
>  static const struct ethtool_ops hinic3_ethtool_ops =3D {
>         .supported_coalesce_params      =3D ETHTOOL_COALESCE_USECS |
>                                           ETHTOOL_COALESCE_PKT_RATE_RX_US=
ECS,
> @@ -417,6 +508,8 @@ static const struct ethtool_ops hinic3_ethtool_ops =
=3D {
>         .get_msglevel                   =3D hinic3_get_msglevel,
>         .set_msglevel                   =3D hinic3_set_msglevel,
>         .get_link                       =3D ethtool_op_get_link,
> +       .get_ringparam                  =3D hinic3_get_ringparam,
> +       .set_ringparam                  =3D hinic3_set_ringparam,
>  };
>
>  void hinic3_set_ethtool_ops(struct net_device *netdev)
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/ne=
t/ethernet/huawei/hinic3/hinic3_irq.c
> index e7d6c2033b45..bc4d879f9be4 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
> @@ -137,7 +137,8 @@ static int hinic3_set_interrupt_moder(struct net_devi=
ce *netdev, u16 q_id,
>         struct hinic3_interrupt_info info =3D {};
>         int err;
>
> -       if (q_id >=3D nic_dev->q_params.num_qps)
> +       if (q_id >=3D nic_dev->q_params.num_qps ||
> +           !mutex_trylock(&nic_dev->change_res_mutex))
>                 return 0;
>
>         info.interrupt_coalesc_set =3D 1;
> @@ -156,6 +157,8 @@ static int hinic3_set_interrupt_moder(struct net_devi=
ce *netdev, u16 q_id,
>                 nic_dev->rxqs[q_id].last_pending_limit =3D pending_limit;
>         }
>
> +       mutex_unlock(&nic_dev->change_res_mutex);
> +
>         return err;
>  }
>
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c b/drivers/n=
et/ethernet/huawei/hinic3/hinic3_main.c
> index 0a888fe4c975..c87624a5e5dc 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_main.c
> @@ -179,6 +179,7 @@ static int hinic3_sw_init(struct net_device *netdev)
>         int err;
>
>         mutex_init(&nic_dev->port_state_mutex);
> +       mutex_init(&nic_dev->change_res_mutex);
>
>         nic_dev->q_params.sq_depth =3D HINIC3_SQ_DEPTH;
>         nic_dev->q_params.rq_depth =3D HINIC3_RQ_DEPTH;
> @@ -315,6 +316,9 @@ static void hinic3_link_status_change(struct net_devi=
ce *netdev,
>  {
>         struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>
> +       if (!mutex_trylock(&nic_dev->change_res_mutex))
> +               return;
> +
>         if (link_status_up) {
>                 if (netif_carrier_ok(netdev))
>                         return;
> @@ -330,6 +334,8 @@ static void hinic3_link_status_change(struct net_devi=
ce *netdev,
>                 netif_carrier_off(netdev);
>                 netdev_dbg(netdev, "Link is down\n");
>         }
> +
> +       mutex_unlock(&nic_dev->change_res_mutex);
>  }
>
>  static void hinic3_port_module_event_handler(struct net_device *netdev,
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/dri=
vers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index da73811641a9..047214cfc753 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -288,7 +288,8 @@ static void hinic3_free_channel_resources(struct net_=
device *netdev,
>         hinic3_free_qps(nic_dev, qp_params);
>  }
>
> -static int hinic3_open_channel(struct net_device *netdev)
> +static int hinic3_prepare_channel(struct net_device *netdev,
> +                                 struct hinic3_dyna_txrxq_params *qp_par=
ams)
>  {
>         struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
>         int err;
> @@ -299,16 +300,28 @@ static int hinic3_open_channel(struct net_device *n=
etdev)
>                 return err;
>         }
>
> -       err =3D hinic3_configure_txrxqs(netdev, &nic_dev->q_params);
> +       err =3D hinic3_configure_txrxqs(netdev, qp_params);
>         if (err) {
>                 netdev_err(netdev, "Failed to configure txrxqs\n");
>                 goto err_free_qp_ctxts;
>         }
>
> +       return 0;
> +
> +err_free_qp_ctxts:
> +       hinic3_free_qp_ctxts(nic_dev);
> +
> +       return err;
> +}
> +
> +static int hinic3_open_channel(struct net_device *netdev)
> +{
> +       int err;
> +
>         err =3D hinic3_qps_irq_init(netdev);
>         if (err) {
>                 netdev_err(netdev, "Failed to init txrxq irq\n");
> -               goto err_free_qp_ctxts;
> +               return err;
>         }
>
>         err =3D hinic3_configure(netdev);
> @@ -321,8 +334,6 @@ static int hinic3_open_channel(struct net_device *net=
dev)
>
>  err_uninit_qps_irq:
>         hinic3_qps_irq_uninit(netdev);
> -err_free_qp_ctxts:
> -       hinic3_free_qp_ctxts(nic_dev);
>
>         return err;
>  }
> @@ -428,6 +439,74 @@ static void hinic3_vport_down(struct net_device *net=
dev)
>         }
>  }
>
> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +                              struct hinic3_dyna_txrxq_params *trxq_para=
ms)
> +{
> +       struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
> +       struct hinic3_dyna_txrxq_params cur_trxq_params =3D {};
> +       struct hinic3_dyna_qp_params new_qp_params =3D {};
> +       struct hinic3_dyna_qp_params cur_qp_params =3D {};
> +       int err;
> +
> +       cur_trxq_params =3D nic_dev->q_params;
> +
> +       hinic3_config_num_qps(netdev, trxq_params);
> +
> +       err =3D hinic3_alloc_channel_resources(netdev, &new_qp_params,
> +                                            trxq_params);
> +       if (err) {
> +               netdev_err(netdev, "Failed to alloc channel resources\n")=
;
> +               return err;
> +       }
> +
> +       mutex_lock(&nic_dev->change_res_mutex);
> +       hinic3_vport_down(netdev);
> +       hinic3_close_channel(netdev);
> +       hinic3_get_cur_qps(nic_dev, &cur_qp_params);
> +
> +       hinic3_init_qps(nic_dev, &new_qp_params);
> +
> +       err =3D hinic3_prepare_channel(netdev, trxq_params);
> +       if (err)
> +               goto err_uninit_qps;
> +
> +       if (nic_dev->num_qp_irq > trxq_params->num_qps)
> +               hinic3_qp_irq_change(netdev, trxq_params->num_qps);
> +
> +       nic_dev->q_params =3D *trxq_params;
> +
> +       err =3D hinic3_open_channel(netdev);
> +       if (err)
> +               goto err_qp_irq_reset;
> +
> +       err =3D hinic3_vport_up(netdev);
> +       if (err)
> +               goto err_close_channel;
> +
> +       hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_p=
arams);
> +
> +       mutex_unlock(&nic_dev->change_res_mutex);
> +
> +       return 0;
> +
> +err_close_channel:
> +       hinic3_close_channel(netdev);
> +err_qp_irq_reset:
> +       nic_dev->q_params =3D cur_trxq_params;
> +
> +       if (trxq_params->num_qps > cur_trxq_params.num_qps)
> +               hinic3_qp_irq_change(netdev, cur_trxq_params.num_qps);
> +       hinic3_free_qp_ctxts(nic_dev);
> +err_uninit_qps:
> +       hinic3_get_cur_qps(nic_dev, &new_qp_params);
> +       hinic3_free_channel_resources(netdev, &new_qp_params, trxq_params=
);
> +       hinic3_free_channel_resources(netdev, &cur_qp_params, &cur_trxq_p=
arams);
> +       mutex_unlock(&nic_dev->change_res_mutex);
> +
> +       return err;
> +}
> +
>  static int hinic3_open(struct net_device *netdev)
>  {
>         struct hinic3_nic_dev *nic_dev =3D netdev_priv(netdev);
> @@ -458,6 +537,10 @@ static int hinic3_open(struct net_device *netdev)
>
>         hinic3_init_qps(nic_dev, &qp_params);
>
> +       err =3D hinic3_prepare_channel(netdev, &nic_dev->q_params);
> +       if (err)
> +               goto err_uninit_qps;
> +
>         err =3D hinic3_open_channel(netdev);
>         if (err)
>                 goto err_uninit_qps;
> @@ -473,7 +556,7 @@ static int hinic3_open(struct net_device *netdev)
>  err_close_channel:
>         hinic3_close_channel(netdev);
>  err_uninit_qps:
> -       hinic3_uninit_qps(nic_dev, &qp_params);
> +       hinic3_get_cur_qps(nic_dev, &qp_params);
>         hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_par=
ams);
>  err_destroy_num_qps:
>         hinic3_destroy_num_qps(netdev);
> @@ -493,10 +576,15 @@ static int hinic3_close(struct net_device *netdev)
>                 return 0;
>         }
>
> +       mutex_lock(&nic_dev->change_res_mutex);
>         hinic3_vport_down(netdev);
>         hinic3_close_channel(netdev);
> -       hinic3_uninit_qps(nic_dev, &qp_params);
> -       hinic3_free_channel_resources(netdev, &qp_params, &nic_dev->q_par=
ams);
> +       hinic3_get_cur_qps(nic_dev, &qp_params);
> +       hinic3_free_channel_resources(netdev, &qp_params,
> +                                     &nic_dev->q_params);
> +       hinic3_free_nicio_res(nic_dev);
> +       hinic3_destroy_num_qps(netdev);
> +       mutex_unlock(&nic_dev->change_res_mutex);
>
>         return 0;
>  }
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h b/driver=
s/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> index 9502293ff710..005b2c01a988 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_dev.h
> @@ -10,6 +10,9 @@
>  #include "hinic3_hw_cfg.h"
>  #include "hinic3_hwdev.h"
>  #include "hinic3_mgmt_interface.h"
> +#include "hinic3_nic_io.h"
> +#include "hinic3_tx.h"
> +#include "hinic3_rx.h"
>
>  #define HINIC3_VLAN_BITMAP_BYTE_SIZE(nic_dev)  (sizeof(*(nic_dev)->vlan_=
bitmap))
>  #define HINIC3_VLAN_BITMAP_SIZE(nic_dev)  \
> @@ -129,6 +132,8 @@ struct hinic3_nic_dev {
>         struct work_struct              rx_mode_work;
>         /* lock for enable/disable port */
>         struct mutex                    port_state_mutex;
> +       /* mutex to serialize channel/resource changes */
> +       struct mutex                    change_res_mutex;
>
>         struct list_head                uc_filter_list;
>         struct list_head                mc_filter_list;
> @@ -143,6 +148,10 @@ struct hinic3_nic_dev {
>
>  void hinic3_set_netdev_ops(struct net_device *netdev);
>  int hinic3_set_hw_features(struct net_device *netdev);
> +int
> +hinic3_change_channel_settings(struct net_device *netdev,
> +                              struct hinic3_dyna_txrxq_params *trxq_para=
ms);
> +
>  int hinic3_qps_irq_init(struct net_device *netdev);
>  void hinic3_qps_irq_uninit(struct net_device *netdev);
>
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c b/drivers=
/net/ethernet/huawei/hinic3/hinic3_nic_io.c
> index 87e736adba02..0e7a0ccfba98 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c
> @@ -484,8 +484,8 @@ void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
>         }
>  }
>
> -void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
> -                      struct hinic3_dyna_qp_params *qp_params)
> +void hinic3_get_cur_qps(struct hinic3_nic_dev *nic_dev,
> +                       struct hinic3_dyna_qp_params *qp_params)
>  {
>         struct hinic3_nic_io *nic_io =3D nic_dev->nic_io;
>
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h b/drivers=
/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> index 12eefabcf1db..571b34d63950 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.h
> @@ -14,6 +14,10 @@ struct hinic3_nic_dev;
>  #define HINIC3_RQ_WQEBB_SHIFT      3
>  #define HINIC3_SQ_WQEBB_SIZE       BIT(HINIC3_SQ_WQEBB_SHIFT)
>
> +#define HINIC3_MAX_TX_QUEUE_DEPTH  65536
> +#define HINIC3_MAX_RX_QUEUE_DEPTH  16384
> +#define HINIC3_MIN_QUEUE_DEPTH     128
> +
>  /* ******************** RQ_CTRL ******************** */
>  enum hinic3_rq_wqe_type {
>         HINIC3_NORMAL_RQ_WQE =3D 1,
> @@ -136,8 +140,8 @@ void hinic3_free_qps(struct hinic3_nic_dev *nic_dev,
>                      struct hinic3_dyna_qp_params *qp_params);
>  void hinic3_init_qps(struct hinic3_nic_dev *nic_dev,
>                      struct hinic3_dyna_qp_params *qp_params);
> -void hinic3_uninit_qps(struct hinic3_nic_dev *nic_dev,
> -                      struct hinic3_dyna_qp_params *qp_params);
> +void hinic3_get_cur_qps(struct hinic3_nic_dev *nic_dev,
> +                       struct hinic3_dyna_qp_params *qp_params);
>
>  int hinic3_init_qp_ctxts(struct hinic3_nic_dev *nic_dev);
>  void hinic3_free_qp_ctxts(struct hinic3_nic_dev *nic_dev);
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net=
/ethernet/huawei/hinic3/hinic3_rx.c
> index 309ab5901379..b5b601469517 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> @@ -541,7 +541,7 @@ int hinic3_configure_rxqs(struct net_device *netdev, =
u16 num_rq,
>                 rq_associate_cqes(rxq);
>
>                 pkts =3D hinic3_rx_fill_buffers(rxq);
> -               if (!pkts) {
> +               if (pkts < rxq->q_depth - 1) {
>                         netdev_err(netdev, "Failed to fill Rx buffer\n");
>                         return -ENOMEM;
>                 }
> --
> 2.43.0
>
>

