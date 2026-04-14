Return-Path: <netdev+bounces-278464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJVvJm5J3mkzqAkAu9opvQ
	(envelope-from <netdev+bounces-278464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:04:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E182C3FADB9
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 16:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56EBE3013A44
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90373E714F;
	Tue, 14 Apr 2026 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B475bes6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7D355F54
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 14:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175218; cv=pass; b=csidwDmMgB3whJVDo5/Yi05IXKtkN0p9/zaoGU8npaWS0uJzaehSIWjqrz3nYY73yX0jVTd+kAPZd8FqUSACF2q5wJFu0iqlbDvTKjHyeSUkm5gZZTSA9270tw0r0nYNW/Ux4O8mzzuTk9cHqt/tXFe1Q2JRKzoeA1pyLl8OqhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175218; c=relaxed/simple;
	bh=tRdcvGDu2KlZy2Aw8Uf9ZHNnXnblpja1kseer4xSQZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nII1VdIN/kmltrsEfcLWjetisiRztQ2dCeC7iZlAAFRUprnF0CFGeDmJKV9kmJ56OQPdKCSEZEEbQ3tE4kafZTqd0MP7vCu704ifyNs6jo3CuEz724nh0ctfuPzphxaUsOS4sZ9E1t+E6uOxf5DmBOLDao5nEKuquuRPE7xNovQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B475bes6; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-68a2f93b42eso1961458eaf.3
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:00:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776175216; cv=none;
        d=google.com; s=arc-20240605;
        b=IJ+6PgGmnR1D0WCkC8vu+1WpGmgtPApOMopJP3Kv3XrDSfrL69vswRFJ1YAHh/5CH5
         8Ni37ZjRgMgjhX0g+8l1dYO946DhZtiGIUYBPNum9m9oyjG70nhbsKar3kdDpHD6CVQU
         Zv7NYI+8jzpPx0Q5SnHaiqBwl/udaKC63oLivegBlen9NykTowDQCLMfUUrOCfRrNpz7
         goG7WjCCSJXPumPbzAkv7j2Hz5hXoiWjM7bVdXKva7d8FtvSTXvbzxcJlz1QunleOTru
         8uO3Bt5mCTNLT0YhoV8OF4AYW4iKoURJ98zSNup6mDwQ8O+0vg8qE+HKvXznYQh2Vrhm
         VcIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=49AG2x6pEGoNnPJicOOKoScg9J+gRSWBSIBGOGB3T+I=;
        fh=gJUR/3t7dGjuDHbotFhECyGdL5LmrackdNrr6A7RA7s=;
        b=Hx4MP3CFJmSmBDvKz+GbP4DdSN87ojVE5ryZpVUmiQKyMy4icJiGx6rsV1yeGOpO8B
         VzcdaoKAueiBVounc+GMxlG0NzjlilBc43gMGZb8NuuXcJ0Uh5ViTp64k6fAG3RC5rBc
         2UnTl3ITm+z4kEZoat/EQ3yZQYKoFWg34npN+qhqfeahEvWp5XhM3rnuzCLX2eTLp4I2
         0stKZWDJidTO686uVYKdApmOeAafRukHEXWWo2L9dF37BZO5TQ+9HYDjuCitQmG7JQ6r
         QXDjrTjwu2IWiJrZ0fcAI5ZxSfys5fmJVq1y6hcTI2yowFKo4Q4A75AXA5e/E/ZRhp4z
         0S8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776175216; x=1776780016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=49AG2x6pEGoNnPJicOOKoScg9J+gRSWBSIBGOGB3T+I=;
        b=B475bes68b6SMIrHNJi6PezRqBeD4jfO81Ltcrehh0pXEFGKewZc23S06CtIvgorX9
         0tiCIm4NBFic5QN3CFFhVfWNgQ6tBN093/UKwWvdEqp+vWxUYL9o7ie9Fpb3AydObg8e
         4bfk3rEPh+SAsdh3RyUXsbv/kcK0zly2WGhv+0SpReZgIgYTVhxn9U5ynIu3X979OYOD
         /5u+KaLlpOAX5X/12jaRzif2prI773RvjgajqXglUZrz4o6yxW2/Ebgve2JTqkWRAqb6
         KbVo4S0Ywr0zpCycMvlq4unYrsRLK7JCGItY/BjgO81Cq6cOz6RM9/ruyYXTY4tHZ5tG
         fK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175216; x=1776780016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=49AG2x6pEGoNnPJicOOKoScg9J+gRSWBSIBGOGB3T+I=;
        b=V9wkUWYMwXpgH/z3BvWFUekTuyK21qsvzKeZSEZO0bsycFCZLPOLw/JpuUr6z70v/l
         F1kiGeKtPGU69THTMtsC4Plv4fQJDvx7qEN6klYcHbP3e0x/T2DUfg+B2cZUYx02UU22
         8STt61Ib2LA/tep+OURhIofKH4Out68HKaLlkfsTmUvFR1yy430pwyxi1uOvf6bAPYTq
         1e+PNhF98fiszoU9fm/XMINy+ss6g4MDfsU5HzqaumWmhwVveNjfuXysdiKZ20GNBi6/
         oN7yWHNzSoKAcMR1k2JdSulfFSZ6/t3ywIXwMsVLKNJu8ZLSMT7m6ZUW1xwjmYEirwhM
         fSdg==
X-Forwarded-Encrypted: i=1; AFNElJ+asNip63PJgQjKR/aeE8iZ5x716s8e8DeaN1YaqPk7I9QGd/fAypCdqWVyYwVVnUqpgpUOrLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEFrU2QftPdYzS7sqUC58tflxapyeBI9dnbrmS/me6ma9Kej3
	YCW2ba7fTF054WcPVycgdmVsOgW1gn/5N78Kpxajr4Msg0De/MyzPyNCYgrHG169OZYNVQcQi44
	xK4XmrBHBITKSuwAlHIE/938v2SwB7/o=
X-Gm-Gg: AeBDievXEtSLMib9C/+niRo/xuKtaqBKMpJxyVgozZeyQJqpCG4m8yOszywHIShzoi4
	a7jjSvZk1fmGVoXCb8fWRyc9s49jR3jsYUrWTkBsgzdXT66Vtd2sIQkrhr2XTx59RYxVKp5ROvB
	xOYEBB9vKEh83Rt2pvBT3KzGj3FCCI1ESfGamPugRU3yGryBdu+U01bCtWaGxnZvYLv1/gAuBA5
	SA3bvbIX3HfnQa55do7HCSpb45bSWuQjZJ5n7WgvwFBfDtP8YITZmw7BjSZ6OSQPL5uG6djhoWS
	BDtfth6i1NS3R5H6mBmVdvamTTCmiRZorp5ayTIqhtS8TBJtHRy4Rjj0ppWipFebymOQHhwCHPG
	pbyVz
X-Received: by 2002:a4a:ee08:0:b0:692:9c90:8e9a with SMTP id
 006d021491bc7-6929c9093admr97107eaf.45.1776175215502; Tue, 14 Apr 2026
 07:00:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
In-Reply-To: <20260407-brcm-prio-v2-1-3f745edf49af@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 14 Apr 2026 10:00:02 -0400
X-Gm-Features: AQROBzDtNMc0E_keXTqptniCR183NjGNZBRqq-7Qjon6jglhw36fYEjsseB1EhQ
Message-ID: <CABBYNZJAEqwfTuVqbFAnx97HBSjcwn3Hb+y+r4r2C=MMPxFoDg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: Add Broadcom channel priority commands
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278464-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,axis.com:email]
X-Rspamd-Queue-Id: E182C3FADB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sasha,

On Tue, Apr 7, 2026 at 1:46=E2=80=AFPM Sasha Finkelstein via B4 Relay
<devnull+fnkl.kernel.gmail.com@kernel.org> wrote:
>
> From: Sasha Finkelstein <fnkl.kernel@gmail.com>
>
> Certain Broadcom bluetooth chips (bcm4377/bcm4378/bcm438) need ACL
> streams carrying audio to be set as "high priority" using a vendor
> specific command to prevent 10-ish second-long dropouts whenever
> something does a device scan. This patch sends the command when the
> socket priority is set to TC_PRIO_INTERACTIVE, as BlueZ does for audio.
>
> Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
> ---
> Changes in v2:
> - new ioctl got nack-ed, so let's use sk_priority as the trigger
> - Link to v1: https://lore.kernel.org/r/20260407-brcm-prio-v1-1-f38b17376=
640@gmail.com
> ---
>  MAINTAINERS                       |  2 ++
>  drivers/bluetooth/hci_bcm4377.c   |  2 ++
>  include/net/bluetooth/bluetooth.h |  4 ++++
>  include/net/bluetooth/hci_core.h  | 11 +++++++++++
>  net/bluetooth/Kconfig             |  7 +++++++
>  net/bluetooth/Makefile            |  1 +
>  net/bluetooth/brcm.c              | 29 +++++++++++++++++++++++++++++
>  net/bluetooth/brcm.h              | 17 +++++++++++++++++
>  net/bluetooth/hci_conn.c          | 28 ++++++++++++++++++++++++++++
>  net/bluetooth/l2cap_sock.c        | 13 +++++++++++++
>  10 files changed, 114 insertions(+)
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
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index 69eed69f7f26..07a250673950 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -457,6 +457,7 @@ struct l2cap_ctrl {
>  };
>
>  struct hci_dev;
> +struct hci_conn;
>
>  typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 =
opcode);
>  typedef void (*hci_req_complete_skb_t)(struct hci_dev *hdev, u8 status,
> @@ -469,6 +470,9 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 o=
pcode, u8 status,
>  int hci_ethtool_ts_info(unsigned int index, int sk_proto,
>                         struct kernel_ethtool_ts_info *ts_info);
>
> +int hci_conn_setsockopt(struct hci_conn *conn, struct sock *sk, int leve=
l,
> +                       int optname, sockptr_t optval, unsigned int optle=
n);
> +
>  #define HCI_REQ_START  BIT(0)
>  #define HCI_REQ_SKB    BIT(1)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index a7bffb908c1e..947e7c2b08dd 100644
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
> index 000000000000..9aa0a265ab3d
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
> +               return 0;
> +
> +       cmd[0] =3D handle;
> +       cmd[1] =3D handle >> 8;

Adding a packed struct and then using something like cpu_to_le16 is
probably preferable over above.

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
> index 000000000000..fdaee63bd1d2
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
> +       return 0;
> +}
> +
> +#endif
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 11d3ad8d2551..096163840f62 100644
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
> @@ -3070,6 +3071,33 @@ int hci_conn_set_phy(struct hci_conn *conn, u32 ph=
ys)
>         }
>  }
>
> +int hci_conn_setsockopt(struct hci_conn *conn, struct sock *sk, int leve=
l,
> +                       int optname, sockptr_t optval, unsigned int optle=
n)
> +{
> +       int val;
> +       bool old_high, new_high, changed;
> +
> +       if (level !=3D SOL_SOCKET)
> +               return 0;
> +
> +       if (optname !=3D SO_PRIORITY)
> +               return 0;
> +
> +       if (optlen < sizeof(int))
> +               return -EINVAL;
> +
> +       if (copy_from_sockptr(&val, optval, sizeof(val)))
> +               return -EFAULT;
> +
> +       old_high =3D sk->sk_priority >=3D TC_PRIO_INTERACTIVE;
> +       new_high =3D val >=3D TC_PRIO_INTERACTIVE;
> +       changed =3D old_high !=3D new_high;
> +       if (!changed)
> +               return 0;
> +
> +       return brcm_set_high_priority(conn->hdev, conn->handle, new_high)=
;

The skb carries the priority (skb->priority), not sure why you need to
capture the sk_priority instead, doing so ignores the load balance
that hci_core performs to avoid starving connections.

> +}
> +
>  static int abort_conn_sync(struct hci_dev *hdev, void *data)
>  {
>         struct hci_conn *conn =3D data;
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 71e8c1b45bce..d5eef87accc4 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -891,6 +891,16 @@ static int l2cap_sock_setsockopt(struct socket *sock=
, int level, int optname,
>
>         BT_DBG("sk %p", sk);
>
> +       if (level =3D=3D SOL_SOCKET) {
> +               conn =3D chan->conn;
> +               if (conn)
> +                       err =3D hci_conn_setsockopt(conn->hcon, sock->sk,=
 level,
> +                                                 optname, optval, optlen=
);
> +               if (err)
> +                       return err;
> +               return sock_setsockopt(sock, level, optname, optval, optl=
en);
> +       }
> +
>         if (level =3D=3D SOL_L2CAP)
>                 return l2cap_sock_setsockopt_old(sock, optname, optval, o=
ptlen);
>
> @@ -1931,6 +1941,9 @@ static struct sock *l2cap_sock_alloc(struct net *ne=
t, struct socket *sock,
>
>         INIT_LIST_HEAD(&l2cap_pi(sk)->rx_busy);
>
> +       if (sock)
> +               set_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);

This is more complicated than it needs to be. I'd just add a new
callback, `hdev->set_priority(handle, skb->priority)`, so the driver
is called whenever it needs to elevate a connection's priority, that
said there could be cases where a connection needs its priority set
momentarily to transmit A2DP, followed by OBEX packets that are best
effort. Therefore, `hci_conn` will probably need to track the priority
so it can detect when it needs changing on a per skb basis.

>         chan =3D l2cap_chan_create();
>         if (!chan) {
>                 sk_free(sk);
>
> ---
> base-commit: bfe62a454542cfad3379f6ef5680b125f41e20f4
> change-id: 20260407-brcm-prio-b630e6cc3834
>
> Best regards,
> --
> Sasha Finkelstein <fnkl.kernel@gmail.com>
>
>


--=20
Luiz Augusto von Dentz

