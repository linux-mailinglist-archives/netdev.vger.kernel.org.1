Return-Path: <netdev+bounces-301675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4SXRCwnuO2otfggAu9opvQ
	(envelope-from <netdev+bounces-301675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:47:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 980FD6BF48C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:47:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Omaw5qsB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301675-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301675-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79D14303EDA9
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 14:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1AA38A714;
	Wed, 24 Jun 2026 14:46:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1987C2F8EAF
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 14:46:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782312386; cv=pass; b=rbEt2Vl8PGdm1M42ekab6ki9NOxKhhrhpbsyxT4ipnCNbH6iAsuTHYo3r66bY6uqtYS5yq0X3ZGTK/c3K5C5XjXUMJ7L1h4mKA6mP63hkHj/PVrdS6t3lyC/zeOBIHwoY6p8q8j6lIHjWv83JNJNic7HaoSBfQXEu8q621JUiDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782312386; c=relaxed/simple;
	bh=oUwcZ29V0LHJY2Oc0OkYhWXF7vx1tek5XJUYh1PQ528=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGp9YNjqbTAb5ngZ8i9lViVi3jDC6q0ZAvwBTLZ4Ffh2VohQRzZbWflZQXVrYf8uaF5hQvdURyyFLUa7pRDDgKxtmSZ8WMsY1KntnMKAr3BIIZR0PJbJypht3TohFW9b1H5cvx2UmBZtaXfW4wmVJ56mnHVry0bZDHrVgXKcxKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omaw5qsB; arc=pass smtp.client-ip=209.85.221.180
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-59ebcbfb2b0so449756e0c.2
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 07:46:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782312381; cv=none;
        d=google.com; s=arc-20240605;
        b=hAeT3S1rIz8HtNk4/LbCDts6x87Z2oP/STpqVXpI30rSfK/PinU5LFtzUMo/p8zgge
         /dkfgLm3ET9/+Hu+SQU5SbQcB0UgH9OPIylY/blSZLDDOW2yApRLHh4UPjxpnYVO0n0W
         usQ19JGAvVKPYbyi79ghuVE9sKVTSkaqXsYVgR8Lt81rRG4AjCOustFYVCvXwgTY9ktN
         J5YNlZEFggkxFTo5IfLZiTx3gS/eSERJ/wdZ06SUhi8Jm8Gqg72gL3fqL5264LwiOrDi
         MVnAdMmqKlAUfWOU/37KMdNVJgcAIja9z4OgW3cqVYok9OM2zHHtyM0dkncGnQ+fDQtb
         S7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lwlZy8IZW4jHve88XvupnasIiZLCTctwhyq6dT8eShc=;
        fh=J9wins0VH7R5ZeafyCI+aJI2FIKDyMsITPOGVtpDPVk=;
        b=SyrcxFJOzOUaRiPv0GLZMZTiNHP5f5KzGdqxdYmvzThDZr5WoD0EDjOYfGZ/fPN4ZT
         VeMnbbkOhnDGA5coSd+iOzq/u+P+4O+2BBgM1uGRX2bLcXDgrun/5GNnUrOofg/XZJ08
         nGhY3grcPcDNRfhbkjx84ZV3Mi//addR8ULto8DVfFBW/fdJv5hrGpPvs1UbVIi/wE4z
         MWSB880BrnbAUco/Qrm9WSepYySKJ9uQ9iKFD3za2tMAQn53D+VGGbiODNkOWrLxTn0/
         sFj72B9fVrlQKo3yzku5D+1IlfSP4Tz9ZN5sU+w96U65NTF1r4qqmmXv6DV33Pjw2MWJ
         PlPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782312381; x=1782917181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lwlZy8IZW4jHve88XvupnasIiZLCTctwhyq6dT8eShc=;
        b=Omaw5qsB+LaSnC094YsMMATZA63AozhQW3EEaHpI3OiYs5U+8Y+ooFzPqko14oQRRV
         gxC/9Iwv3Nyvbjp2i+lzVRvs+jAgrQFK1bJoP/H8cvOG+DacvL/HLJSGNIx3k4TiSBdu
         goUNRUlxxnez9kQlhasw6sagss3LfPd6k3JIoSrxp3Ao7Y19A63J5EIQy8De6d9xk2UY
         z8vlR5LN6trjzfhs1dlP8smalPsQuncfKH66+9AyycKh+PdIXwnKn7IDSJUBUWfDz/RQ
         f7GWOlly6zmaMZESc5BE9U8XYy1UFtzxw4JN2yT3qoh2xEgzvlpcow3zFpEOEi8hy2+U
         O+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782312381; x=1782917181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lwlZy8IZW4jHve88XvupnasIiZLCTctwhyq6dT8eShc=;
        b=c0LB8sUN0Z1KsMNLSle11JbU2njAJCt3OjUF40n32axAJVWV/bHHQKkF//necKhQiB
         k0jQv86JwLl+mt0+6NNqRXl2OoWnT/ewkEbZLDnn+sRG+min8WqcnponM45J7EuENyyj
         r44RJ1emLNUwZ46IH3eKYMCkEE92FyT2d/F8VN6GuOPsCt8x5xUscOrfSoqQeKv83qCi
         cjiqG34PTzjeMweQP8SK6X51Y28SxqA+ZkIA1FwGVHgasdQIqaIExOy6M9HygxH5Nv44
         mzWzvQKA5z+JJeHbmj/LMDyz1dgFV7445s857yBDWJ1kQMoiLVIBFZkH6fwXchvdjKfm
         AGpg==
X-Forwarded-Encrypted: i=1; AHgh+RrRfls4r6KeIE2ctY7rcFqwRRT9ffOFLLs8PgVwKLgU55ElwkQsuV5Pa4QEhOVljVRMGdyXeH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGPOxisxmLUE82T4/K3XXj3FC+k5F9PWsYr40rufKJ3wuAl47P
	+7BU50vOAeMy91DWqIhO6ox3/E8Y2I5hm6LK1jHMVonbodLVqPUUrC9FZPBeS4UfEdWFxGeB8zk
	JqTsPK9fFtmekuibMCNWt0yUE8taR48A=
X-Gm-Gg: AfdE7ckcH93t5AMPBYunsdLqdSa8nynfv+vtL01WSWjHetmY1FOMHEOAebd+9axJysl
	0jDbYMAS4MX13QN+w5tNrQrIL9BXlk0VPV+N7tC0VkN4srtK+GJCJ88prXlgSH267VBYxl/uPTQ
	x5jStL/WgpEa6urwIWQahqBepg2EelXhrlS9e0hocdEBYea+eZPgkTLHFG+0RLPj1wodv4aazwX
	AUI9fO+4Qwi1Amxl3wT3oiJ7TJWWKUd16XTVXX1cXggvAud6Qh10HfOrKdU/5F9LiP+lyykIg==
X-Received: by 2002:a05:6122:c90:b0:5bc:1a31:ba6c with SMTP id
 71dfb90a1353d-5bc3efc8d6amr1688978e0c.14.1782312380268; Wed, 24 Jun 2026
 07:46:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624090135.95763-1-samsun1006219@gmail.com>
 <CANn89iKD=4_A+7K2erw5AZPnzvBrQqTKXJyfKN5ZfNpAYZ+y3A@mail.gmail.com>
 <CAEkJfYN4Uep_WEzZyaDGkW5p4rW+oVRqq2DgBt2xiYp9ARt0GA@mail.gmail.com>
 <CANn89iJ5wKuvKy=Ed-JkeyzKYaEoA_8S=mEMBicMjEPxLCY0Vw@mail.gmail.com> <CANn89iKhPmbJW_6DA1_okSGsr_e_Jz47qns-nFcZpnQZ-nAUOA@mail.gmail.com>
In-Reply-To: <CANn89iKhPmbJW_6DA1_okSGsr_e_Jz47qns-nFcZpnQZ-nAUOA@mail.gmail.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Wed, 24 Jun 2026 22:46:07 +0800
X-Gm-Features: AVVi8CeG1lFvR_a6PY0-9OlIftRaK2LkGZ-bIfjgaHUg6j0mc5FobpcjSepHuTg
Message-ID: <CAEkJfYMXsNuJjKWJ5nvvw0afSP77F0WWT0gfj2-sQM3VyZ0brQ@mail.gmail.com>
Subject: Re: [BUG] KFENCE: use-after-free read in udp_tunnel_nic_device_sync_work
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-301675-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 980FD6BF48C

On Wed, Jun 24, 2026 at 10:10=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Jun 24, 2026 at 6:59=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
>
> > Oh well.
> >
> > u8 need_sync:1;
> > u8 need_replay:1;
> > u8 work_pending:1;
> >
> > These bitfields are not safe, obviously :/
> >
> > Time to convert them to atomic bit operations.
>
> Can you try:
>
> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> index 9944ed923ddfd10f9adf6ad788c0740daeaf2adb..939d6f656bb71814718bc3bf8=
4be665adad27e4b
> 100644
> --- a/net/ipv4/udp_tunnel_nic.c
> +++ b/net/ipv4/udp_tunnel_nic.c
> @@ -30,9 +30,7 @@ struct udp_tunnel_nic_table_entry {
>   * @work:      async work for talking to hardware from process context
>   * @dev:       netdev pointer
>   * @lock:      protects all fields
> - * @need_sync: at least one port start changed
> - * @need_replay: space was freed, we need a replay of all ports
> - * @work_pending: @work is currently scheduled
> + * @flags:     sync, replay, pending flags
>   * @n_tables:  number of tables under @entries
>   * @missed:    bitmap of tables which overflown
>   * @entries:   table of tables of ports currently offloaded
> @@ -44,9 +42,10 @@ struct udp_tunnel_nic {
>
>         struct mutex lock;
>
> -       u8 need_sync:1;
> -       u8 need_replay:1;
> -       u8 work_pending:1;
> +       unsigned long flags;
> +#define UDP_TUNNEL_NIC_NEED_SYNC       0
> +#define UDP_TUNNEL_NIC_NEED_REPLAY     1
> +#define UDP_TUNNEL_NIC_WORK_PENDING    2
>
>         unsigned int n_tables;
>         unsigned long missed;
> @@ -116,7 +115,7 @@ udp_tunnel_nic_entry_queue(struct udp_tunnel_nic *utn=
,
>                            unsigned int flag)
>  {
>         entry->flags |=3D flag;
> -       utn->need_sync =3D 1;
> +       set_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
>  }
>
>  static void
> @@ -283,7 +282,7 @@ udp_tunnel_nic_device_sync_by_table(struct net_device=
 *dev,
>  static void
>  __udp_tunnel_nic_device_sync(struct net_device *dev, struct
> udp_tunnel_nic *utn)
>  {
> -       if (!utn->need_sync)
> +       if (!test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags))
>                 return;
>
>         if (dev->udp_tunnel_nic_info->sync_table)
> @@ -291,21 +290,24 @@ __udp_tunnel_nic_device_sync(struct net_device
> *dev, struct udp_tunnel_nic *utn)
>         else
>                 udp_tunnel_nic_device_sync_by_port(dev, utn);
>
> -       utn->need_sync =3D 0;
> +       clear_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
>         /* Can't replay directly here, in case we come from the tunnel dr=
iver's
>          * notification - trying to replay may deadlock inside tunnel dri=
ver.
>          */
> -       utn->need_replay =3D udp_tunnel_nic_should_replay(dev, utn);
> +       if (udp_tunnel_nic_should_replay(dev, utn))
> +               set_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
> +       else
> +               clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
>  }
>
>  static void
>  udp_tunnel_nic_device_sync(struct net_device *dev, struct udp_tunnel_nic=
 *utn)
>  {
> -       if (!utn->need_sync)
> +       if (!test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags))
>                 return;
>
> +       set_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags);
>         queue_work(udp_tunnel_nic_workqueue, &utn->work);
> -       utn->work_pending =3D 1;
>  }
>
>  static bool
> @@ -348,7 +350,7 @@ udp_tunnel_nic_has_collision(struct net_device
> *dev, struct udp_tunnel_nic *utn,
>                         if (!udp_tunnel_nic_entry_is_free(entry) &&
>                             entry->port =3D=3D ti->port &&
>                             entry->type !=3D ti->type) {
> -                               __set_bit(i, &utn->missed);
> +                               set_bit(i, &utn->missed);
>                                 return true;
>                         }
>                 }
> @@ -483,7 +485,7 @@ udp_tunnel_nic_add_new(struct net_device *dev,
> struct udp_tunnel_nic *utn,
>                  * are no devices currently which have multiple tables ac=
cepting
>                  * the same tunnel type, and false positives are okay.
>                  */
> -               __set_bit(i, &utn->missed);
> +               set_bit(i, &utn->missed);
>         }
>
>         return false;
> @@ -552,7 +554,7 @@ static void __udp_tunnel_nic_reset_ntf(struct
> net_device *dev)
>
>         mutex_lock(&utn->lock);
>
> -       utn->need_sync =3D false;
> +       clear_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
>         for (i =3D 0; i < utn->n_tables; i++)
>                 for (j =3D 0; j < info->tables[i].n_entries; j++) {
>                         struct udp_tunnel_nic_table_entry *entry;
> @@ -696,8 +698,8 @@ udp_tunnel_nic_flush(struct net_device *dev,
> struct udp_tunnel_nic *utn)
>         for (i =3D 0; i < utn->n_tables; i++)
>                 memset(utn->entries[i], 0, array_size(info->tables[i].n_e=
ntries,
>                                                       sizeof(**utn->entri=
es)));
> -       WARN_ON(utn->need_sync);
> -       utn->need_replay =3D 0;
> +       WARN_ON(test_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags));
> +       clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
>  }
>
>  static void
> @@ -713,8 +715,8 @@ udp_tunnel_nic_replay(struct net_device *dev,
> struct udp_tunnel_nic *utn)
>         for (i =3D 0; i < utn->n_tables; i++)
>                 for (j =3D 0; j < info->tables[i].n_entries; j++)
>                         udp_tunnel_nic_entry_freeze_used(&utn->entries[i]=
[j]);
> -       utn->missed =3D 0;
> -       utn->need_replay =3D 0;
> +       bitmap_zero(&utn->missed, UDP_TUNNEL_NIC_MAX_TABLES);
> +       clear_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags);
>
>         if (!info->shared) {
>                 udp_tunnel_get_rx_info(dev);
> @@ -736,10 +738,10 @@ static void
> udp_tunnel_nic_device_sync_work(struct work_struct *work)
>         rtnl_lock();
>         mutex_lock(&utn->lock);
>
> -       utn->work_pending =3D 0;
> +       clear_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags);
>         __udp_tunnel_nic_device_sync(utn->dev, utn);
>
> -       if (utn->need_replay)
> +       if (test_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags))
>                 udp_tunnel_nic_replay(utn->dev, utn);
>
>         mutex_unlock(&utn->lock);
> @@ -866,6 +868,11 @@ udp_tunnel_nic_unregister(struct net_device *dev,
> struct udp_tunnel_nic *utn)
>
>         udp_tunnel_nic_lock(dev);
>
> +       if (test_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags)) {
> +               udp_tunnel_nic_unlock(dev);
> +               return;
> +       }
> +
>         /* For a shared table remove this dev from the list of sharing de=
vices
>          * and if there are other devices just detach.
>          */
> @@ -901,12 +908,6 @@ udp_tunnel_nic_unregister(struct net_device *dev,
> struct udp_tunnel_nic *utn)
>         udp_tunnel_nic_flush(dev, utn);
>         udp_tunnel_nic_unlock(dev);
>
> -       /* Wait for the work to be done using the state, netdev core will
> -        * retry unregister until we give up our reference on this device=
.
> -        */
> -       if (utn->work_pending)
> -               return;
> -
>         udp_tunnel_nic_free(utn);
>  release_dev:
>         dev->udp_tunnel_nic =3D NULL;

I tested this version as well, but it still does not stop the C reproducer
on my side.

This time the VM panicked after about 50 seconds on a debugobjects warning:

[ 50.420529][ T9744] ------------[ cut here ]------------
[ 50.421258][ T9744] ODEBUG: free active (active state 0) object:
ff110001114b5a00 object type: work_struct hint:
udp_tunnel_nic_device_sync_work+0x0/0x940
[ 50.424052][ T9744] WARNING: lib/debugobjects.c:629 at
debug_print_object+0x1a0/0x2e0, CPU#0: repro/9744
[ 50.425766][ T9744] Modules linked in:
[ 50.426279][ T9744] CPU: 0 UID: 0 PID: 9744 Comm: repro Not tainted
7.1.0-11240-g840ef6c78e6a-dirty #33 PREEMPT(full)
[ 50.428614][ T9744] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[ 50.429661][ T9744] RIP: 0010:debug_print_object+0x1a5/0x2e0
[ 50.430338][ T9744] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 8a 00
00 00 48 8b 14 ed 60 33 1e 8c 48 83 fd 05 77 47 48 8d 3d e0 0c 1e 0c
41 56 4c 89 e6 <67> 48 0f b9 3a 58 83 05 42 30 14 0c 01 48 83 c4 20 5b
5d 41 5c 41
[ 50.432538][ T9744] RSP: 0018:ffa0000012c8ee60 EFLAGS: 00010293
[ 50.433045][ T9744] RAX: dffffc0000000000 RBX: ffa0000012c8ef40 RCX:
0000000000000000
[ 50.433710][ T9744] RDX: ffffffff8c1e32a0 RSI: ffffffff8c1e2e80 RDI:
ffffffff90e31820
[ 50.434390][ T9744] RBP: 0000000000000003 R08: ff110001114b5a00 R09:
ffffffff8bae17e0
[ 50.435050][ T9744] R10: ffffffff90d907d7 R11: 0000000000000000 R12:
ffffffff8c1e2e80
[ 50.435719][ T9744] R13: ffffffff8bae1820 R14: ffffffff8a0f69e0 R15:
ffa0000012c8ef58
[ 50.436393][ T9744] FS: 00007f8430d5b640(0000)
GS:ff1100018394a000(0000) knlGS:0000000000000000
[ 50.437149][ T9744] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 50.437749][ T9744] CR2: 00007f422d7b8000 CR3: 000000010b850000 CR4:
0000000000753ef0
[ 50.438404][ T9744] PKRU: 55555554
[ 50.438716][ T9744] Call Trace:
[ 50.439004][ T9744] <TASK>
[ 50.439277][ T9744] ? __pfx_udp_tunnel_nic_device_sync_work+0x10/0x10
[ 50.439856][ T9744] ? _raw_spin_unlock_irqrestore+0x58/0x70
[ 50.440942][ T9744] debug_check_no_obj_freed+0x3ec/0x520
[ 50.441419][ T9744] ? __udp_tunnel_nic_lock+0x47/0x60
[ 50.441878][ T9744] ? __pfx_debug_check_no_obj_freed+0x10/0x10
[ 50.442403][ T9744] ? kasan_quarantine_put+0x10d/0x230
[ 50.442875][ T9744] ? lockdep_hardirqs_on+0x7c/0x110
[ 50.443325][ T9744] kfree+0x2a0/0x6d0
[ 50.443663][ T9744] ? udp_tunnel_nic_netdevice_event+0xc14/0x1e40
[ 50.444214][ T9744] udp_tunnel_nic_netdevice_event+0xc14/0x1e40
[ 50.444730][ T9744] notifier_call_chain+0xbd/0x430
[ 50.445164][ T9744] ? __pfx_udp_tunnel_nic_netdevice_event+0x10/0x10
[ 50.445729][ T9744] call_netdevice_notifiers_info+0xbe/0x110
[ 50.446236][ T9744] unregister_netdevice_many_notify+0xbab/0x2130
[ 50.446781][ T9744] ? __pfx_unregister_netdevice_many_notify+0x10/0x10
[ 50.447907][ T9744] ? __pfx___mutex_lock+0x10/0x10
[ 50.448351][ T9744] unregister_netdevice_queue+0x305/0x3c0
[ 50.448842][ T9744] ? __pfx_unregister_netdevice_queue+0x10/0x10
[ 50.449369][ T9744] nsim_destroy+0x231/0x980
[ 50.449773][ T9744] __nsim_dev_port_del+0x197/0x2c0
[ 50.450215][ T9744] nsim_dev_reload_destroy+0x105/0x490
[ 50.450677][ T9744] nsim_dev_reload_down+0x67/0xd0
[ 50.451143][ T9744] devlink_reload+0x197/0x7b0
[ 50.451564][ T9744] ? __pfx_devlink_reload+0x10/0x10
[ 50.452020][ T9744] ? security_capable+0x210/0x250
[ 50.452466][ T9744] ? ns_capable+0xe2/0x120
[ 50.452858][ T9744] devlink_nl_reload_doit+0x541/0x1160
[ 50.453323][ T9744] ? __pfx_devlink_nl_reload_doit+0x10/0x10
[ 50.453828][ T9744] ? genl_family_rcv_msg_attrs_parse.constprop.0+0x1e5/0x=
2f0
[ 50.454458][ T9744] genl_family_rcv_msg_doit+0x1ff/0x2f0
[ 50.454930][ T9744] ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[ 50.455442][ T9744] ? bpf_lsm_capable+0x9/0x10
[ 50.455845][ T9744] ? security_capable+0x210/0x250
[ 50.456297][ T9744] genl_rcv_msg+0x532/0x7e0
[ 50.456683][ T9744] ? __pfx_genl_rcv_msg+0x10/0x10
[ 50.457115][ T9744] ? __pfx_devlink_nl_pre_doit_dev_lock+0x10/0x10
[ 50.457690][ T9744] ? __pfx_devlink_nl_reload_doit+0x10/0x10
[ 50.458218][ T9744] ? __pfx_devlink_nl_post_doit_dev_lock+0x10/0x10
[ 50.458776][ T9744] ? __lock_acquire+0x476/0x2420
[ 50.459208][ T9744] netlink_rcv_skb+0x147/0x430
[ 50.459633][ T9744] ? __pfx_genl_rcv_msg+0x10/0x10
[ 50.460062][ T9744] ? __pfx_netlink_rcv_skb+0x10/0x10
[ 50.460520][ T9744] ? netlink_deliver_tap+0x1ae/0xd10
[ 50.460976][ T9744] genl_rcv+0x28/0x40
[ 50.461330][ T9744] netlink_unicast+0x58d/0x850
[ 50.461739][ T9744] ? __pfx_netlink_unicast+0x10/0x10
[ 50.462198][ T9744] netlink_sendmsg+0x88d/0xd90
[ 50.462610][ T9744] ? __pfx_netlink_sendmsg+0x10/0x10
[ 50.463092][ T9744] ? __pfx_netlink_sendmsg+0x10/0x10
[ 50.463557][ T9744] ____sys_sendmsg+0xa27/0xb90
[ 50.463982][ T9744] ? __pfx_____sys_sendmsg+0x10/0x10
[ 50.464438][ T9744] ? __pfx_copy_msghdr_from_user+0x10/0x10
[ 50.464938][ T9744] ? find_held_lock+0x2b/0x80
[ 50.465347][ T9744] ? futex_wake+0x4f7/0x5e0
[ 50.465735][ T9744] ___sys_sendmsg+0x11c/0x1b0
[ 50.466129][ T9744] ? __pfx____sys_sendmsg+0x10/0x10
[ 50.466586][ T9744] ? __pfx_futex_wake+0x10/0x10
[ 50.467002][ T9744] ? __fget_files+0x1f1/0x3b0
[ 50.467440][ T9744] ? __fget_files+0x1fb/0x3b0
[ 50.467836][ T9744] ? __lock_acquire+0x450/0x2420
[ 50.468298][ T9744] __sys_sendmsg+0x142/0x1f0
[ 50.468696][ T9744] ? __pfx___sys_sendmsg+0x10/0x10
[ 50.469133][ T9744] ? __cpu_to_node+0x8a/0x130
[ 50.469538][ T9744] do_syscall_64+0x11f/0x860
[ 50.469953][ T9744] entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 50.470454][ T9744] RIP: 0033:0x451a4d
[ 50.470783][ T9744] Code: c3 e8 a7 23 00 00 0f 1f 80 00 00 00 00 f3
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8
64 89 01 48
[ 50.472393][ T9744] RSP: 002b:00007f8430d5b198 EFLAGS: 00000246
ORIG_RAX: 000000000000002e
[ 50.473102][ T9744] RAX: ffffffffffffffda RBX: 00000000004e9440 RCX:
0000000000451a4d
[ 50.473761][ T9744] RDX: 0000000000000000 RSI: 0000200000000800 RDI:
0000000000000003
[ 50.474419][ T9744] RBP: 00000000004b66b4 R08: 000000000000006d R09:
0000000000000000
[ 50.475085][ T9744] R10: 0000000000000001 R11: 0000000000000246 R12:
0000200000000280
[ 50.475738][ T9744] R13: 0000200000000190 R14: 0000200000000180 R15:
00000000004e9448
[ 50.476418][ T9744] </TASK>
[ 50.476683][ T9744] Kernel panic - not syncing: kernel: panic_on_warn set =
...
[ 50.477297][ T9744] CPU: 0 UID: 0 PID: 9744 Comm: repro Not tainted
7.1.0-11240-g840ef6c78e6a-dirty #33 PREEMPT(full)
[ 50.478201][ T9744] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.15.0-1 04/01/2014
[ 50.478952][ T9744] Call Trace:
[ 50.479240][ T9744] <TASK>
[ 50.479492][ T9744] dump_stack_lvl+0x3d/0x1b0
[ 50.479895][ T9744] vpanic+0x7f2/0xa70
[ 50.480241][ T9744] ? __pfx_vpanic+0x10/0x10
[ 50.480621][ T9744] ? is_bpf_text_address+0x96/0x1a0
[ 50.481070][ T9744] ? debug_print_object+0x1a0/0x2e0
[ 50.481512][ T9744] panic+0xc2/0xd0
[ 50.481844][ T9744] ? __pfx_panic+0x10/0x10
[ 50.482230][ T9744] ? check_panic_on_warn+0x1f/0xc0
[ 50.482673][ T9744] check_panic_on_warn+0xb1/0xc0
[ 50.483102][ T9744] __warn+0x108/0x3f0
[ 50.483460][ T9744] __report_bug+0x42c/0x510
[ 50.483854][ T9744] ? debug_print_object+0x1a0/0x2e0
[ 50.484297][ T9744] ? __pfx___report_bug+0x10/0x10
[ 50.484721][ T9744] ? __kernel_text_address+0xd/0x40
[ 50.485166][ T9744] ? unwind_get_return_address+0x59/0xa0
[ 50.485664][ T9744] report_bug_entry+0xe1/0x280
[ 50.486068][ T9744] ? debug_print_object+0x1a5/0x2e0
[ 50.486508][ T9744] handle_bug+0x428/0x4e0
[ 50.486889][ T9744] exc_invalid_op+0x35/0x80
[ 50.487281][ T9744] asm_exc_invalid_op+0x1a/0x20
[ 50.487693][ T9744] RIP: 0010:debug_print_object+0x1a5/0x2e0
[ 50.488194][ T9744] Code: 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 8a 00
00 00 48 8b 14 ed 60 33 1e 8c 48 83 fd 05 77 47 48 8d 3d e0 0c 1e 0c
41 56 4c 89 e6 <67> 48 0f b9 3a 58 83 05 42 30 14 0c 01 48 83 c4 20 5b
5d 41 5c 41
[ 50.489814][ T9744] RSP: 0018:ffa0000012c8ee60 EFLAGS: 00010293
[ 50.490362][ T9744] RAX: dffffc0000000000 RBX: ffa0000012c8ef40 RCX:
0000000000000000
[ 50.491033][ T9744] RDX: ffffffff8c1e32a0 RSI: ffffffff8c1e2e80 RDI:
ffffffff90e31820
[ 50.491698][ T9744] RBP: 0000000000000003 R08: ff110001114b5a00 R09:
ffffffff8bae17e0
[ 50.492384][ T9744] R10: ffffffff90d907d7 R11: 0000000000000000 R12:
ffffffff8c1e2e80
[ 50.493043][ T9744] R13: ffffffff8bae1820 R14: ffffffff8a0f69e0 R15:
ffa0000012c8ef58
[ 50.493718][ T9744] ? __pfx_udp_tunnel_nic_device_sync_work+0x10/0x10
[ 50.494288][ T9744] ? __pfx_udp_tunnel_nic_device_sync_work+0x10/0x10
[ 50.494845][ T9744] ? _raw_spin_unlock_irqrestore+0x58/0x70
[ 50.495347][ T9744] debug_check_no_obj_freed+0x3ec/0x520
[ 50.495825][ T9744] ? __udp_tunnel_nic_lock+0x47/0x60
[ 50.496276][ T9744] ? __pfx_debug_check_no_obj_freed+0x10/0x10
[ 50.496794][ T9744] ? kasan_quarantine_put+0x10d/0x230
[ 50.497266][ T9744] ? lockdep_hardirqs_on+0x7c/0x110
[ 50.497706][ T9744] kfree+0x2a0/0x6d0
[ 50.498038][ T9744] ? udp_tunnel_nic_netdevice_event+0xc14/0x1e40
[ 50.498577][ T9744] udp_tunnel_nic_netdevice_event+0xc14/0x1e40
[ 50.499107][ T9744] notifier_call_chain+0xbd/0x430
[ 50.499544][ T9744] ? __pfx_udp_tunnel_nic_netdevice_event+0x10/0x10
[ 50.500096][ T9744] call_netdevice_notifiers_info+0xbe/0x110
[ 50.500625][ T9744] unregister_netdevice_many_notify+0xbab/0x2130
[ 50.501169][ T9744] ? __pfx_unregister_netdevice_many_notify+0x10/0x10
[ 50.501737][ T9744] ? __pfx___mutex_lock+0x10/0x10
[ 50.502174][ T9744] unregister_netdevice_queue+0x305/0x3c0
[ 50.502660][ T9744] ? __pfx_unregister_netdevice_queue+0x10/0x10
[ 50.503186][ T9744] nsim_destroy+0x231/0x980
[ 50.503564][ T9744] __nsim_dev_port_del+0x197/0x2c0
[ 50.503966][ T9744] nsim_dev_reload_destroy+0x105/0x490
[ 50.504406][ T9744] nsim_dev_reload_down+0x67/0xd0
[ 50.504808][ T9744] devlink_reload+0x197/0x7b0
[ 50.505220][ T9744] ? __pfx_devlink_reload+0x10/0x10
[ 50.505679][ T9744] ? security_capable+0x210/0x250
[ 50.506113][ T9744] ? ns_capable+0xe2/0x120
[ 50.506490][ T9744] devlink_nl_reload_doit+0x541/0x1160
[ 50.506962][ T9744] ? __pfx_devlink_nl_reload_doit+0x10/0x10
[ 50.507471][ T9744] ? genl_family_rcv_msg_attrs_parse.constprop.0+0x1e5/0x=
2f0
[ 50.508094][ T9744] genl_family_rcv_msg_doit+0x1ff/0x2f0
[ 50.508577][ T9744] ? __pfx_genl_family_rcv_msg_doit+0x10/0x10
[ 50.509098][ T9744] ? bpf_lsm_capable+0x9/0x10
[ 50.509495][ T9744] ? security_capable+0x210/0x250
[ 50.509924][ T9744] genl_rcv_msg+0x532/0x7e0
[ 50.510327][ T9744] ? __pfx_genl_rcv_msg+0x10/0x10
[ 50.510753][ T9744] ? __pfx_devlink_nl_pre_doit_dev_lock+0x10/0x10
[ 50.511291][ T9744] ? __pfx_devlink_nl_reload_doit+0x10/0x10
[ 50.511795][ T9744] ? __pfx_devlink_nl_post_doit_dev_lock+0x10/0x10
[ 50.512365][ T9744] ? __lock_acquire+0x476/0x2420
[ 50.512785][ T9744] netlink_rcv_skb+0x147/0x430
[ 50.513197][ T9744] ? __pfx_genl_rcv_msg+0x10/0x10
[ 50.513627][ T9744] ? __pfx_netlink_rcv_skb+0x10/0x10
[ 50.514090][ T9744] ? netlink_deliver_tap+0x1ae/0xd10
[ 50.514542][ T9744] genl_rcv+0x28/0x40
[ 50.514879][ T9744] netlink_unicast+0x58d/0x850
[ 50.515302][ T9744] ? __pfx_netlink_unicast+0x10/0x10
[ 50.515760][ T9744] netlink_sendmsg+0x88d/0xd90
[ 50.516181][ T9744] ? __pfx_netlink_sendmsg+0x10/0x10
[ 50.516640][ T9744] ? __pfx_netlink_sendmsg+0x10/0x10
[ 50.517109][ T9744] ____sys_sendmsg+0xa27/0xb90
[ 50.517520][ T9744] ? __pfx_____sys_sendmsg+0x10/0x10
[ 50.517965][ T9744] ? __pfx_copy_msghdr_from_user+0x10/0x10
[ 50.518457][ T9744] ? find_held_lock+0x2b/0x80
[ 50.518871][ T9744] ? futex_wake+0x4f7/0x5e0
[ 50.519271][ T9744] ___sys_sendmsg+0x11c/0x1b0
[ 50.519677][ T9744] ? __pfx____sys_sendmsg+0x10/0x10
[ 50.520117][ T9744] ? __pfx_futex_wake+0x10/0x10
[ 50.520542][ T9744] ? __fget_files+0x1f1/0x3b0
[ 50.520945][ T9744] ? __fget_files+0x1fb/0x3b0
[ 50.521347][ T9744] ? __lock_acquire+0x450/0x2420
[ 50.521770][ T9744] __sys_sendmsg+0x142/0x1f0
[ 50.522176][ T9744] ? __pfx___sys_sendmsg+0x10/0x10
[ 50.522617][ T9744] ? __cpu_to_node+0x8a/0x130
[ 50.523021][ T9744] do_syscall_64+0x11f/0x860
[ 50.523417][ T9744] entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 50.523926][ T9744] RIP: 0033:0x451a4d
[ 50.524264][ T9744] Code: c3 e8 a7 23 00 00 0f 1f 80 00 00 00 00 f3
0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b
4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8
64 89 01 48
[ 50.525868][ T9744] RSP: 002b:00007f8430d5b198 EFLAGS: 00000246
ORIG_RAX: 000000000000002e
[ 50.526579][ T9744] RAX: ffffffffffffffda RBX: 00000000004e9440 RCX:
0000000000451a4d
[ 50.527243][ T9744] RDX: 0000000000000000 RSI: 0000200000000800 RDI:
0000000000000003
[ 50.527914][ T9744] RBP: 00000000004b66b4 R08: 000000000000006d R09:
0000000000000000
[ 50.528614][ T9744] R10: 0000000000000001 R11: 0000000000000246 R12:
0000200000000280
[ 50.529305][ T9744] R13: 0000200000000190 R14: 0000200000000180 R15:
00000000004e9448
[ 50.529982][ T9744] </TASK>
[ 50.530453][ T9744] Kernel Offset: disabled

Resolved from the patched vmlinux:
  udp_tunnel_nic_netdevice_event+0xc14/0x1e40:
  udp_tunnel_nic_unregister at net/ipv4/udp_tunnel_nic.c:913
  udp_tunnel_nic_netdevice_event at net/ipv4/udp_tunnel_nic.c:943

So we are still freeing struct udp_tunnel_nic while its embedded work_struc=
t
is active. debugobjects catches this at kfree() before the active work gets=
 a
chance to run later and dereference the freed utn.

My read is that the conversion from bitfields to atomic bitops removes the
plain bitfield data race, but UDP_TUNNEL_NIC_WORK_PENDING is still only one
boolean state. It can represent "some work is pending", but it cannot
distinguish between:
  idle
  queued
  running
  running and queued again

In particular, the workqueue core clears WORK_STRUCT_PENDING before invokin=
g
the worker. At that point the same work item can be queued again by
udp_tunnel_nic_device_sync(). If an already running instance later executes=
:

  clear_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags);

it can still clear the bit that was set for the requeued instance. Then
udp_tunnel_nic_unregister() may observe UDP_TUNNEL_NIC_WORK_PENDING clear a=
nd
free utn, even though debugobjects still sees utn->work as active.

Thanks,
Yue

