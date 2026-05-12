Return-Path: <netdev+bounces-286992-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEsSHGfeAmoMyQEAu9opvQ
	(envelope-from <netdev+bounces-286992-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:01:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 180B551C540
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90FD63037416
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525FE48095B;
	Tue, 12 May 2026 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="la16prRE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8DF379C37
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778572754; cv=pass; b=hdBPiaAsIBJKpKEfgpbLYlgYvHUMmcdG8c6wSjcm6+fvLa+dnMl2hRlUO6IB62n/jxfZhQhRc4MoD7zxus2PTB6FVt3cAkn/KGtxvlUMNCjpLkh42WxP2DJNX0RToTSezl+xux7waECk631YxJqT8J2x6E83SQrRSmWlaGBTpXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778572754; c=relaxed/simple;
	bh=30iutcuNkxA3MbU8ClPbF9XgC6/qeK2gA65ZZUzFKfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUfnv4+ErnOFm5rMTGWxecvksTfWciuK3VClMxbAlnWcpmen5IxvIUKDsNetCGbYpMePP54CgAOfC0tywnY/ow7umotMz5w+Ej/kAe9tZ1pOvUoKkOq7i/JGIFqOwrShwD9JTE2hb3v5p5FzkGNVM3PxnI25Q9lgGP4O6WPNohY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=la16prRE; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-43587e63a8eso1623280fac.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778572750; cv=none;
        d=google.com; s=arc-20240605;
        b=ZL8utNI9XRUgshd56U2VhA9TOpsu5whU8Av5eXtqvPy65Jec/vThLZlCWTrpNldltz
         jUiZtK8mKID6tEOBQ2RwWPkmyfhFkhZl8ZHtOCG27qN/paLtRMr1WrNISluTu90RhYQx
         G+VSuUilwckgdcTUs0w+M9yBfLMTac5o5DZmhH9eZ8g1CYPgIwLT4UaX0ByPUSWeBi4O
         oqrcAor0fNMbfhxq0DF0EKQxcuWln+Ktq5pFWEfR2hYv5goWblNfruBxi6PuYz59gevj
         kfW0UMdLnFSxPMHYMwZtGN2DVCs5XSjVc4gB0bTkv/CewqZGOsKtvDiGEuibMVS9/eDo
         7EcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GNxFi0i3Eh2p+y16pwvSqh55C8YjwWwX1e+4QDG9pEw=;
        fh=RRHKAVMdC/vZA6pbcCkQPatFAqLDBF4xvoPMH/QuE8A=;
        b=J7sGssTE5h223YjjDkPwiAMJtciJvsuZ+H6c9YU9/ArhlGXct8/1SKSIKZ+BCwd+zY
         mF3jrnR91k5ZNvQcq5Tq1oNqBoKN+UZcIy/aphLMjL58akTwworP+uLfPdqhRg8X2QE7
         plSHTmkclfRq8W67y4OJrblA20+OnApCnm/i9IoaRsXdXEOQ0Htjlrfp7AfPblwZ6kyS
         SB4RfhYjzlVi+EQgd6Ujt395vWFDzXhIgUxTm48oGtQaJzzHnThRob0pKteAZt0cCoA8
         WB+jo2+mxR5Xn0D9nev3HYR/WSW1DuR+GHGP1hQJgnYcqKI5N/oCp7fVDHUen6J8cyaD
         WJ+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778572750; x=1779177550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNxFi0i3Eh2p+y16pwvSqh55C8YjwWwX1e+4QDG9pEw=;
        b=la16prREOPQxt1NSM/azbfSZGedMqtjqeQOslYha2sMqERwz+2pOKVMBHPL8NLmAnP
         snHXyZH8ur5dXoXByJpbjQZKxJzqLwg3cavHhV3LyNiltl6ehAf24m0kOq5ruBPZTgZn
         t3EF6B+8D0YIIQP2lELxbeD85kR8IRSfKWqE293Anz90pR3O4aUsg8wZd1/7PgiInc7u
         WYcpVHGqka6pXcvTYJvOWw5DqQwhBOMetRgD+HggRCjhUXfPML3Em2VaghVlI19dTm7F
         61eFCvh4U24M04fvgb09kFyHqIA4svjc9uuJXPfhHH6L0rVNuglvq617CC7G8+NdNQMm
         nitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778572750; x=1779177550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GNxFi0i3Eh2p+y16pwvSqh55C8YjwWwX1e+4QDG9pEw=;
        b=g3kyLYuYNpCh8ytK5xfLsr8Y8kBcnnJzGTfm5VorlEt/CKtTRPZugL2/aUjkgB5eXz
         2UmFB6KDlA/NHLhw/qzUsScTesqW5BzeJ9NGlpAEdkfDZaKUjp/fjX9ObvS0p8PcKCNF
         0mGEG+gqBAUJYsMMnIfKlpv7l11Dvo0DUj9hNUq6Fi8WlpgYWovRp08QjmmE4flqeBVT
         VDsk51kbgfbwFIu0N2r95YhuJJZdPtAu14zZszqxl4BTGN+LhR3eUqTFsT4XRJ9U7M83
         k+79QRVf8jJ3+46UVSTqpI2jk0SwPX7YLXUHzDJFMHETNmOepUtE/uUXgrvuSIoWN41w
         Trlg==
X-Forwarded-Encrypted: i=1; AFNElJ+slN9KT96AWsZO/ppSwZ0RByX+nGQpW0W+XV6MdTmHuq+E/FzyW7auiS7OvvftV87lez1KOf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCYX9v9ffwpmcUoD/y80b7tCZrORuC7qYXOOhhRKL7PGG0kq1D
	+kftuX22RybU8JHmIXSzIlUowRQelAdpFU9FU8vUf3dKv8ukmvVXDumK6KXIEhwSR+50vkZ4Eob
	vKJnKShzudr4232+5OejVGynUQSjj0Cc=
X-Gm-Gg: Acq92OGkSicL9CCGKFj7qjGRNv7lVKhVxrzpy7IvaJJYvhJwrAnRMleD0jTDn8bN7pZ
	fsTk6sjhZnDeQEC9Wpf2P1Xt0MlLABUM+vTpZO40IwnPudYQ61w+Y3BNg5Xomk9uCTvRtWmlAsS
	OodsPi8vPBc0skh8iFTILsUmo7UkEkFS+zoUXTHHRS3lKBqcbjyrModqSIOBCVlynVmrApYMP8A
	e5OdaY8yZafXQSa5ZfKJc8+NxnVOhRcJSc4863Sk450TumxljBjaClcrGW4tcuzBEYKqKZRCWlC
	bwBj0lCu2ScNvMJPE75qt9Oq9L4WM4xpILwFZA==
X-Received: by 2002:a05:6871:3412:b0:42f:af81:2765 with SMTP id
 586e51a60fabf-434f69a0b03mr16855497fac.16.1778572750275; Tue, 12 May 2026
 00:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512060627.3781329-1-danishanwar@ti.com> <20260512060627.3781329-2-danishanwar@ti.com>
In-Reply-To: <20260512060627.3781329-2-danishanwar@ti.com>
From: David CARLIER <devnexen@gmail.com>
Date: Tue, 12 May 2026 08:58:59 +0100
X-Gm-Features: AVHnY4KyYcOEEwQtm4OTa_bKSqp7vmL-5pqMaYZfRIc_VgOTVcf64VUdTb9yyXI
Message-ID: <CA+XhMqykBWcMdk+iNnOtUxM4MX6jpDyUwfuAVZFbjAShO9_v7Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: ti: icssg: Derive stats array lengths
 from ARRAY_SIZE
To: MD Danish Anwar <danishanwar@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Roger Quadros <rogerq@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jacob Keller <jacob.e.keller@intel.com>, Meghana Malladi <m-malladi@ti.com>, 
	Kevin Hao <haokexin@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Vignesh Raghavendra <vigneshr@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 180B551C540
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286992-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,intel.com,ti.com,gmail.com,linux.dev,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnexen@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi MD,

On Tue, 12 May 2026 at 07:06, MD Danish Anwar <danishanwar@ti.com> wrote:
>
> Replace the manually maintained ICSSG_NUM_MIIG_STATS and
> ICSSG_NUM_PA_STATS constants with ARRAY_SIZE() expressions derived
> directly from the corresponding stat descriptor arrays, so that adding
> new entries to icssg_all_miig_stats[] or icssg_all_pa_stats[] no longer
> requires a separate update to a numeric constant.
>
> To make this self-contained, break the circular include dependency
> between icssg_stats.h and icssg_prueth.h:
>
>   - icssg_stats.h previously included icssg_prueth.h (transitively
>     pulling in icssg_switch_map.h and ETH_GSTRING_LEN).  Replace that
>     with direct includes of <linux/ethtool.h>, <linux/kernel.h> and
>     "icssg_switch_map.h".
>
>   - icssg_prueth.h now includes icssg_stats.h, giving it access to
>     the ARRAY_SIZE-based ICSSG_NUM_MIIG_STATS and ICSSG_NUM_PA_STATS
>     before they are used in the prueth_emac struct and ICSSG_NUM_STATS.
>
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  drivers/net/ethernet/ti/icssg/icssg_prueth.h | 3 +--
>  drivers/net/ethernet/ti/icssg/icssg_stats.h  | 7 ++++++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/e=
thernet/ti/icssg/icssg_prueth.h
> index df93d15c5b78..e2ccecb0a0dd 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -43,6 +43,7 @@
>
>  #include "icssg_config.h"
>  #include "icss_iep.h"
> +#include "icssg_stats.h"
>  #include "icssg_switch_map.h"
>
>  #define PRUETH_MAX_MTU          (2000 - ETH_HLEN - ETH_FCS_LEN)
> @@ -57,8 +58,6 @@
>
>  #define ICSSG_MAX_RFLOWS       8       /* per slice */
>
> -#define ICSSG_NUM_PA_STATS     32
> -#define ICSSG_NUM_MIIG_STATS   60
>  /* Number of ICSSG related stats */
>  #define ICSSG_NUM_STATS (ICSSG_NUM_MIIG_STATS + ICSSG_NUM_PA_STATS)
>  #define ICSSG_NUM_STANDARD_STATS 31
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_stats.h b/drivers/net/et=
hernet/ti/icssg/icssg_stats.h
> index 5ec0b38e0c67..b854eb587c1e 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_stats.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_stats.h
> @@ -8,10 +8,15 @@
>  #ifndef __NET_TI_ICSSG_STATS_H
>  #define __NET_TI_ICSSG_STATS_H
>
> -#include "icssg_prueth.h"
> +#include <linux/ethtool.h>
> +#include <linux/kernel.h>
> +#include "icssg_switch_map.h"
>
>  #define STATS_TIME_LIMIT_1G_MS    25000    /* 25 seconds @ 1G */
>
> +#define ICSSG_NUM_MIIG_STATS   ARRAY_SIZE(icssg_all_miig_stats)
> +#define ICSSG_NUM_PA_STATS     ARRAY_SIZE(icssg_all_pa_stats)
> +
>  struct miig_stats_regs {
>         /* Rx */
>         u32 rx_packets;
> --
> 2.34.1
>

One thing that caught my eye: icssg_all_miig_stats[] and
  icssg_all_pa_stats[] are 'static const' arrays in icssg_stats.h with
  ETH_GSTRING_LEN name buffers per entry. Right now only icssg_stats.c
  and icssg_ethtool.c pull them in. After this patch icssg_prueth.h
  includes icssg_stats.h, so every .c in the driver (classifier,
  common, config, mii_cfg, queues, switchdev, ...) ends up with its own
  static-const copy of both tables.

  Would a static_assert() work for what you're after? Something like:

    static const struct icssg_miig_stats icssg_all_miig_stats[] =3D {
        ...
    };
    static_assert(ARRAY_SIZE(icssg_all_miig_stats) =3D=3D ICSSG_NUM_MIIG_ST=
ATS);

  next to each array, keeping the numeric #defines as-is. Then 2/2 fails
  to build the moment a new entry is added without bumping the count,
  which is the case you're guarding against =E2=80=94 without touching the
  include graph.

What do you think ?

Cheers.

