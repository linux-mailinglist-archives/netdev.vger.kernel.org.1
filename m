Return-Path: <netdev+bounces-275998-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MWlN5YJ1WnMzgcAu9opvQ
	(envelope-from <netdev+bounces-275998-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:41:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA003AF54F
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 15:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69DF83010775
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4071B3B583B;
	Tue,  7 Apr 2026 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPGjlP+E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E1A3A8726
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775569274; cv=pass; b=fe5PPw4KPU3v2J3OYgZyBjIvxfeCZaY8G7el/H2oIIgOa7JfbBPfdbWmcbk9+UA88NiCTCND1l5YUoq6wrHjsYl9MNqMIVolurxYtDxiUQQ421RiPQPG+NAa5EBx+vSwja0AOLNEb/WD4biyLIilHh54NXzF71euxv0TS9jyjaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775569274; c=relaxed/simple;
	bh=LRZ5hVwhom1Ev34WQmfOX4SnFiCZuFXFmOdeDfsbWdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SaQcaduhtGJiw+PeaDxQQl+dEH0HMmnzYUlTH2qyUoIAKQZ6FoFeDtNzUDBYoqwj9cEvxifWWEYa3R3TE1z8HSJMTtnwYqMalAh9acug/r5lqA5QgS0E58b2MiwfviJzZqZGCXzU/BtmpUOIWbdZD2IMNCvVu1jX38aF/pvUbxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPGjlP+E; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6501d242e2fso4713490d50.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 06:41:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775569271; cv=none;
        d=google.com; s=arc-20240605;
        b=SWT1DCwGYOjBttLljILaZReZsqNzDhKm1z98Qrzr0mi0ilVTqEXJgCPOaqEimySI5x
         pv4SqIeKzjtTohf9qDuikU/9/QuZkgrLdp7HR8eob09yU1o+uqtRHXf3gIy5Gii20iC3
         /thANny6SCrbfOWVYE8eW5SqZuvAM3jDeTTRhG4t8+2h3Tg7pM43ilenP5fXy1i5B7gI
         2ehjSjTP3UwlTz+HoQFLYnkHEP5tiybjZS2RSMLzgblOMNwpCI7RngxMIHuQOey0LO5E
         j+WTL2YaP7WokAOEdJ5NA9TQDqyPaRlOmV7KX8XG03mrpgvBIX2v25Y221TGYeJz5Uif
         5B4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K6+qhHS9U2NR5KN/+3DgIjEjwrsUhOTdOACQA1DQXNk=;
        fh=FGkILC5uYYAHfuTqpu+wFJ49Ny9ujXOo1nhTfGlEuBg=;
        b=AeFNgVw9YYSqwH697ZQbU/j8QH+CITsPEt4ZN7OtJnVw6nwijSFhZhYFGx0B+603Lr
         C25g5XEoFSVAkP0FQZq63MFj6XLDlX1uoxrdXOkQm1WU5e4+fuRjmF7Twe43RuVixTDd
         +L+hTvGN0xttwepbeLeZIKuE8V8XdrCGLfx+tcFYqlCYWIzNIgvew5DI3FO/m2lABa43
         cfGm1FODjQmPhMGjK7nANr3/lWr7B1vRkGdTnxavJBSoXFsH9Fpk0sN1lPJ/jMzXVzE1
         TYL+qTqAmShLxvLUHgm3OV10m+jYSigMNPuVZuUj+uOzAkqEiXn7b1M6yjRD51IGeHlb
         iIDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775569271; x=1776174071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6+qhHS9U2NR5KN/+3DgIjEjwrsUhOTdOACQA1DQXNk=;
        b=NPGjlP+Em9/B7FeLU5R5rF2Haq3Qamo10rYh6dtpsy42uglXzg5HgCE1COof/1Ggqo
         kO5SW568JmGlzIsrao72duqmSqlEpPAM3qbX1Zsw0bz/Tfsj7sXtDQtMxC2gmPLt2lEf
         aOQpBYZlGfnlHmeFHJXjWi2X5jPGgChBRcccqz4vc8apIrh8qYuqK/3xRFPfCsqthBVw
         DS5FA/+nWsilyx0NzKH3rS2VLpg8MvtzL1QNb+mowiWDNu7pJ2mG+FUWwBr3KYZqY0hD
         8b/RyEVDXV7hboHZdy9eZ8QxK2lhH3JuawGfM9HiE/jSn9eehWlXG2VQ8Q+DMLV1MHj3
         V1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775569271; x=1776174071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K6+qhHS9U2NR5KN/+3DgIjEjwrsUhOTdOACQA1DQXNk=;
        b=bP0gnqjxXduCQN69YH3rIr0fEVGsge4MqZr7rsYLyaFXkKjHzy90r6D/0QG22Q+3Vw
         1fHAPIFoI5tWqxTlKBurVf8rhrNQk7UbajnUgkz6UzLNODJAFH2HQogRsBb3ybXWDHpz
         iW6BjqtcE0nCnPJ+y6JkBgX813es58Ov0yPT/naRrQrYTl77whWhuVqL07jV7hYIRr7N
         p5ijDG14tNCV0fv6C0QuRkeT6SqWCmrIO3DrXSUPbcd8nT54wlD00WLi2s5rxM6VxVhm
         Twv20aQ8/wcTRdG+o+c1K9L1Y8Dq4S2K8oy/cbajRcW3N/62MUaGXbf7y41Wz5uQ61rk
         ujSw==
X-Forwarded-Encrypted: i=1; AJvYcCWLO5iJGS0pAXlEZ3CaSNMZi5ET4xKYuo/1VdYl34DWA0khUYNmYRVMnaa5b19ZBUJ9PCodtMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwCa3g3RmEGLWIJvoJ2nyPQVR9PnUgiacez2Mh29gNE2/XOn77
	ldlxap/zhrR0qwOuYYxhHGcGq/eN3rJcvk9TuckXCASQMsCG2m/Cbsz5keSQiQGeOiXU1UlU1og
	Il20C4dwA4ziWtC0NGV0tVVcXMKmJkwk=
X-Gm-Gg: AeBDievup5YzM1Krmy5fET3Sm6Y+nBkouvHtxa1GhJh73RXGeonoXvZ6oxWIZPXv2ZH
	gVLsdGqhYcvI3hggiBX6JpzAW9fDpUuVBi4tHUCE18NM+FWxxMjvcxj4ebP9CpZ/5PhxXb4CGmo
	6GFH6WomX/ySAxiDaL7v78h64iZfiKBkLIoPj6Kqntdi1nXmbtv9PuN7kWB0/gYSEX4SJRAhBON
	/aS19wEkJuCCe6R2sYWvUvkhMVGWx7k5yC4t0TeicA++mAabjfvACxtBjZdLJC6CFPVA5kxQYsd
	Upacsy7+652UkbBPnzM0KkzuFoGy8HNJZ1sCt3pni0nTaSVJIg+7zveX36wNjdLoAJtoFg==
X-Received: by 2002:a05:690e:4397:b0:64c:b81d:2cb7 with SMTP id
 956f58d0204a3-6504881bc03mr10964580d50.39.1775569270543; Tue, 07 Apr 2026
 06:41:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v1-1-f38b17376640@gmail.com>
In-Reply-To: <20260407-brcm-prio-v1-1-f38b17376640@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 7 Apr 2026 09:40:58 -0400
X-Gm-Features: AQROBzAa16hYCox9YuiofHUqjsYpvs_frFTh54dv3AlFBuE-XJcb0jeBhhoCcSI
Message-ID: <CABBYNZ+OrkJWcbVKkyrpX3HHJr7vGgC92Y=wkf6PPwR9Zr+mOQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add Broadcom channel priority commands
To: fnkl.kernel@gmail.com
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
	Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275998-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,axis.com:email]
X-Rspamd-Queue-Id: DBA003AF54F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Tue, Apr 7, 2026 at 8:09=E2=80=AFAM Sasha Finkelstein via B4 Relay
<devnull+fnkl.kernel.gmail.com@kernel.org> wrote:
>
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>
> Certain Broadcom bluetooth chips (bcm4377/bcm4378/bcm438) need ACL
> streams carrying audio to be set as "high priority" using a vendor
> specific command to prevent 10-ish second-long dropouts whenever
> something does a device scan. This series adds an ioctl to control
> the priorities and hooks it up for the relevant chips.
>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
>  MAINTAINERS                      |  2 ++
>  drivers/bluetooth/hci_bcm4377.c  |  2 ++
>  include/net/bluetooth/hci_core.h | 12 ++++++++++++
>  include/net/bluetooth/hci_sock.h |  7 +++++++
>  net/bluetooth/Kconfig            |  7 +++++++
>  net/bluetooth/Makefile           |  1 +
>  net/bluetooth/brcm.c             | 29 +++++++++++++++++++++++++++++
>  net/bluetooth/brcm.h             | 17 +++++++++++++++++
>  net/bluetooth/hci_conn.c         | 11 +++++++++++
>  net/bluetooth/hci_sock.c         |  4 ++++
>  10 files changed, 92 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3fe46d7c4bc..81be021367ec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2562,6 +2562,8 @@ F:        include/dt-bindings/pinctrl/apple.h
>  F:     include/linux/mfd/macsmc.h
>  F:     include/linux/soc/apple/*
>  F:     include/uapi/drm/asahi_drm.h
> +F:     net/bluetooth/brcm.c
> +F:     net/bluetooth/brcm.h
>
>  ARM/ARTPEC MACHINE SUPPORT
>  M:     Jesper Nilsson <jesper.nilsson@axis.com>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4=
377.c
> index 925d0a635945..5f79920c0306 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -2397,6 +2397,8 @@ static int bcm4377_probe(struct pci_dev *pdev, cons=
t struct pci_device_id *id)
>         if (bcm4377->hw->broken_le_ext_adv_report_phy)
>                 hci_set_quirk(hdev, HCI_QUIRK_FIXUP_LE_EXT_ADV_REPORT_PHY=
);
>
> +       hci_set_brcm_capable(hdev);
> +
>         pci_set_drvdata(pdev, bcm4377);
>         hci_set_drvdata(hdev, bcm4377);
>         SET_HCIDEV_DEV(hdev, &pdev->dev);
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index a7bffb908c1e..ef3b5433203c 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -642,6 +642,10 @@ struct hci_dev {
>         bool                    aosp_quality_report;
>  #endif
>
> +#if IS_ENABLED(CONFIG_BT_BRCMEXT)
> +       bool                    brcm_capable;
> +#endif
> +
>         int (*open)(struct hci_dev *hdev);
>         int (*close)(struct hci_dev *hdev);
>         int (*flush)(struct hci_dev *hdev);
> @@ -1791,6 +1795,13 @@ static inline void hci_set_aosp_capable(struct hci=
_dev *hdev)
>  #endif
>  }
>
> +static inline void hci_set_brcm_capable(struct hci_dev *hdev)
> +{
> +#if IS_ENABLED(CONFIG_BT_BRCMEXT)
> +       hdev->brcm_capable =3D true;
> +#endif
> +}
> +
>  static inline void hci_devcd_setup(struct hci_dev *hdev)
>  {
>  #ifdef CONFIG_DEV_COREDUMP
> @@ -1812,6 +1823,7 @@ int hci_get_conn_list(void __user *arg);
>  int hci_get_conn_info(struct hci_dev *hdev, void __user *arg);
>  int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
>  int hci_inquiry(void __user *arg);
> +int hci_set_acl_prio(struct hci_dev *hdev, void __user *arg);
>
>  struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
>                                            bdaddr_t *bdaddr, u8 type);
> diff --git a/include/net/bluetooth/hci_sock.h b/include/net/bluetooth/hci=
_sock.h
> index 13e8cd4414a1..95d156ac4cae 100644
> --- a/include/net/bluetooth/hci_sock.h
> +++ b/include/net/bluetooth/hci_sock.h
> @@ -91,6 +91,8 @@ struct hci_ufilter {
>
>  #define HCIINQUIRY     _IOR('H', 240, int)
>
> +#define HCISETACLPRIO  _IOW('H', 250, int)

Nack, not going to introduce an ioctl command for this.

>  /* Ioctl requests structures */
>  struct hci_dev_stats {
>         __u32 err_rx;
> @@ -171,6 +173,11 @@ struct hci_inquiry_req {
>         __u8  length;
>         __u8  num_rsp;
>  };
> +
> +struct hci_acl_prio_req {
> +       __u16 handle;
> +       __u8  high_prio;
> +};
>  #define IREQ_CACHE_FLUSH 0x0001
>
>  #endif /* __HCI_SOCK_H */
> diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
> index 6b2b65a66700..0f2a5fbcafc5 100644
> --- a/net/bluetooth/Kconfig
> +++ b/net/bluetooth/Kconfig
> @@ -110,6 +110,13 @@ config BT_AOSPEXT
>           This options enables support for the Android Open Source
>           Project defined HCI vendor extensions.
>
> +config BT_BRCMEXT
> +       bool "Enable Broadcom extensions"
> +       depends on BT
> +       help
> +         This option enables support for the Broadcom defined HCI
> +         vendor extensions.
> +
>  config BT_DEBUGFS
>         bool "Export Bluetooth internals in debugfs"
>         depends on BT && DEBUG_FS
> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
> index a7eede7616d8..b4c9013a46ce 100644
> --- a/net/bluetooth/Makefile
> +++ b/net/bluetooth/Makefile
> @@ -24,5 +24,6 @@ bluetooth-$(CONFIG_BT_LE) +=3D iso.o
>  bluetooth-$(CONFIG_BT_LEDS) +=3D leds.o
>  bluetooth-$(CONFIG_BT_MSFTEXT) +=3D msft.o
>  bluetooth-$(CONFIG_BT_AOSPEXT) +=3D aosp.o
> +bluetooth-$(CONFIG_BT_BRCMEXT) +=3D brcm.o
>  bluetooth-$(CONFIG_BT_DEBUGFS) +=3D hci_debugfs.o
>  bluetooth-$(CONFIG_BT_SELFTEST) +=3D selftest.o
> diff --git a/net/bluetooth/brcm.c b/net/bluetooth/brcm.c
> new file mode 100644
> index 000000000000..d03d2af5dc7e
> --- /dev/null
> +++ b/net/bluetooth/brcm.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2026 The Asahi Linux Contributors
> + */
> +
> +#include <net/bluetooth/bluetooth.h>
> +#include <net/bluetooth/hci_core.h>
> +
> +#include "brcm.h"
> +
> +int brcm_set_high_priority(struct hci_dev *hdev, u16 handle, bool enable=
)
> +{
> +       struct sk_buff *skb;
> +       u8 cmd[3];
> +
> +       if (!hdev->brcm_capable)
> +               return -EOPNOTSUPP;
> +
> +       cmd[0] =3D handle;
> +       cmd[1] =3D handle >> 8;
> +       cmd[2] =3D !!enable;
> +
> +       skb =3D hci_cmd_sync(hdev, 0xfc57, sizeof(cmd), cmd, HCI_CMD_TIME=
OUT);
> +       if (IS_ERR(skb))
> +               return PTR_ERR(skb);
> +
> +       kfree_skb(skb);
> +       return 0;
> +}
> diff --git a/net/bluetooth/brcm.h b/net/bluetooth/brcm.h
> new file mode 100644
> index 000000000000..a501f2988a96
> --- /dev/null
> +++ b/net/bluetooth/brcm.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2026 The Asahi Linux Contributors
> + */
> +
> +#if IS_ENABLED(CONFIG_BT_BRCMEXT)
> +
> +int brcm_set_high_priority(struct hci_dev *hdev, u16 handle, bool enable=
);
> +
> +#else
> +
> +static inline int brcm_set_high_priority(struct hci_dev *hdev, u16 handl=
e, bool enable)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
> +#endif
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 11d3ad8d2551..b2c7414a9c5b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -35,6 +35,7 @@
>  #include <net/bluetooth/iso.h>
>  #include <net/bluetooth/mgmt.h>
>
> +#include "brcm.h"
>  #include "smp.h"
>  #include "eir.h"
>
> @@ -2775,6 +2776,16 @@ int hci_get_auth_info(struct hci_dev *hdev, void _=
_user *arg)
>         return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
>  }
>
> +int hci_set_acl_prio(struct hci_dev *hdev, void __user *arg)
> +{
> +       struct hci_acl_prio_req req;
> +
> +       if (copy_from_user(&req, arg, sizeof(req)))
> +               return -EFAULT;
> +
> +       return brcm_set_high_priority(hdev, req.handle, req.high_prio);
> +}
> +
>  struct hci_chan *hci_chan_create(struct hci_conn *conn)
>  {
>         struct hci_dev *hdev =3D conn->hdev;
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 0290dea081f6..4be6aeeb6bad 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -1035,6 +1035,9 @@ static int hci_sock_bound_ioctl(struct sock *sk, un=
signed int cmd,
>                 if (!capable(CAP_NET_ADMIN))
>                         return -EPERM;
>                 return hci_sock_reject_list_del(hdev, (void __user *)arg)=
;
> +
> +       case HCISETACLPRIO:
> +               return hci_set_acl_prio(hdev, (void __user *)arg);
>         }
>
>         return -ENOIOCTLCMD;
> @@ -1072,6 +1075,7 @@ static int hci_sock_ioctl(struct socket *sock, unsi=
gned int cmd,
>         case HCIGETAUTHINFO:
>         case HCIBLOCKADDR:
>         case HCIUNBLOCKADDR:
> +       case HCISETACLPRIO:
>                 break;
>         default:
>                 return -ENOIOCTLCMD;
>
> ---
> base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> change-id: 20260407-brcm-prio-b630e6cc3834
>
> Best regards,
> --
> Sasha Finkelstein <fnkl.kernel@gmail.com>

The simple solution would be for the driver to set all ACL connections
with high priority since in most cases we do want connections having
higher priority than scanning. That said, we may need to identify
which connections are performing audio versus those that are not. For
the audio connections, perhaps we could use skb->priority to set their
priority (provided userspace sets it for audio).

--=20
Luiz Augusto von Dentz

