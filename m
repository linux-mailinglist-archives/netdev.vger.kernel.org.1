Return-Path: <netdev+bounces-301715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id foslJpUHPGqKiwgAu9opvQ
	(envelope-from <netdev+bounces-301715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:36:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DB26C0010
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 18:36:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OkoOhfe6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301715-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301715-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF9CA30315CE
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 16:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FB931716E;
	Wed, 24 Jun 2026 16:36:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C731618C
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 16:36:00 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782318962; cv=pass; b=ZpK45yfuAa1wA9Au0HWqgJTNyYbPau9MDKfGLcsiV0Lad/XRRjmsZkMyKDxlWxrTfeLz9RZ/kqr7CJyQJ4KKQ+6fObbEF+dbHHvaWMtsvf5qXkbah2QpsxHkdX8+GchtFLMhEVCEbXc91uP7jh//j1zjXaadNcmXxvrZaXfvIQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782318962; c=relaxed/simple;
	bh=YJLja8NZiLh5xM81qS4eYNeJaiHsYZqrYJ8oauedz5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYHIL/z+er9UFVfgFLUuxAtyoWw699yZM37sm7zc1v/lGXp1wUQsPufVTV8/x/dR8CDJfY53sDl7KqFVVBIa4x8YULRYX+U6U6yRC6PMy/GTdXoNwyjdbbm9C1lknS2/II2YucnMZ/qTGQY3zcDWh46i12TQ13k7O5eWMkSAEmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkoOhfe6; arc=pass smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8dea42b547eso17829316d6.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 09:36:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782318960; cv=none;
        d=google.com; s=arc-20240605;
        b=dl+PwYJJkct5GBSnQqqRd9Hj2AXvSMF/ut3kU8fYIPYecBqIsSYU8lakTeOaDmtohn
         QtFbE5KA1W7p+QfezZkk8pHVwGTy+xmzsQBNUHfY5ujpcWAsCgUCRbmW/ZXTr6r0aTG9
         w+FKlaq1WHt1M5HUllA2OfcOhgvZPjLkAP/lYydt3eAh0zfcV4EvcgKF4Fs2ih/KlIxc
         /JDrcssvUm+x7UIDF5aOb35ed5TvRMNG3nChE9bzyEYinTAs9uOLFZVTBq0pSESkZtrf
         fw+5fs6UQB+5U/t8tBsX7kUA5TSE187fYXUzGkkjbqiqbjMJgaWYzHmn0Euh9Wch71Y4
         WPqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ag3arPzgsG01460xBP6wd3ebtB9yQcGRyUhWicd9oMY=;
        fh=EPHik4d9x6TDo6UNfYIBuVSDnzDY82yQjZbr5SxZZVw=;
        b=OBAMK0TfbKJGXm3ej+aeoAyVNCeRCg1414gW2nBEdMyLE3+4DCPec6H5lDm5JhfUb2
         XmybBYvN11YL4MKfVwn790VZlSeZwrapFmzp+i48+yak6r8YKFZLuNYCBy8HgCOx9DB8
         ufOo+FmVsWo0iRPdTPVDflUciGwoIVWQNuhgGnae8CLYTTeNRwY2JrMLVJhHOo9n+BUO
         fnUqFFOPQCKj+MjIBfFdwc+0SZa03BV8IZBabL+yxuHVWxU1DaV+Vn4WoAMbQ3MvAqHq
         S2RMp4vNStEUCNvF4rR37tRvxpauZOOde4DchwwKygzLaBuwGQmXwbNjgR+6DHVTF8+A
         FmLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782318960; x=1782923760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ag3arPzgsG01460xBP6wd3ebtB9yQcGRyUhWicd9oMY=;
        b=OkoOhfe6QjE1YxL4VQBIV0QvNfjG7f4obHOTDKhXfe4PP7FvVQ2y1dX0QP8qfNLWX+
         g4B6xxAuBBG5EUMj54y/4+j74vLlKJhgqjqihtT0ArIlJvVc/t+uu8eVuH11oDT076rN
         K/j1tXfkDZsQUcRBLQr6Xx1iClDsEPm7TifPoePlrBkMlgGcTvqwKJDIEKB0KL3r+WPK
         r9qDN3q5T7mRTLT4gELqFQMBKoFM3NqRMYmfh1/3KOC9oc5867TerfX4dIGQ4I/oRsC1
         7PxM6V9hbGp3wWxput5DVuztai1TL6okZ1Ngw+wKFdMaDELsE09jOxjzUlNUeM86citz
         Jq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782318960; x=1782923760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ag3arPzgsG01460xBP6wd3ebtB9yQcGRyUhWicd9oMY=;
        b=Cfhe0Z8LEVSkLtxtiThxUR6Tk6/SNlliGRSAOUoPFnrz+HSTdEbXrJfEW9NfvsbPZH
         hujEnpV8ttKXSYjIakgq+GtYQW2OuhREUMXhiwpLadRxjnDalrv4jVziv/sURtz0zis0
         lE7kJm/6lDgprr+/zsyE4CTCYC4J4q8b93EEkoQC2IyiKOTGIzopCSL54FyIvzJ0PoqA
         qqmqkigZKqK2H2mMySZg+uP/Jo0EYM/QhuDDk7wGECGTydTyG0x/d1GlXWT675b9DnSf
         /JRwff/b1KsdeZLczh51T9ZK7tzcora10FChxf9AX92pF3rO1ZLAXIbcIaawjvam4P7j
         kCcA==
X-Forwarded-Encrypted: i=1; AHgh+Rofc2q5eF3xUQ2Xndu9QeVazajftI1xInk+7iTgHJA4ctYwD5ttu4UyOE+VPuf9/36a4jptMBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYEDDRps/X6jUcIpLO+0S/gCn/m6KzgVup641oumfJSYsEb3B7
	8hMNVnDPEddZ3B5DRP+no4fZG1AfDdVcjJ1afUF6gxl8UKMU2aqiq2c3XNdsICSnt74v0UJTgZs
	jxuiF9nuTTPMIytCKYcSmhl04nxWsyKs=
X-Gm-Gg: AfdE7ckKSUh+NzovHi+QSL2+f5/ECwyFdT25VkglY4TEifDUcrJu2LrImf6ye7JzJvr
	kyMkZCzlPiKgZAHNKR5CXOSh5MMi96ItRYdvMb4f96AeCpdHmeUu84Cn5G6w4WtOmVzNzkXY9ML
	NFROdDJ4eBN8RerMPLMZEXmmpjyuXPP39tcTRVDf4Li8O1tUyDNU+EkEcdpGTXljgH17av/rMaf
	FlgJGlLMhRa8bltH9us9tStSFhK8wCKJ13Vwu6KM1tXaunK5CNYigk/f9LoBZgIaFDdw/rdHA==
X-Received: by 2002:a05:6214:19cb:b0:8cf:92e:f9f6 with SMTP id
 6a1803df08f44-8e52fda09demr64912096d6.25.1782318959560; Wed, 24 Jun 2026
 09:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624090135.95763-1-samsun1006219@gmail.com>
 <CANn89iKD=4_A+7K2erw5AZPnzvBrQqTKXJyfKN5ZfNpAYZ+y3A@mail.gmail.com>
 <CAEkJfYN4Uep_WEzZyaDGkW5p4rW+oVRqq2DgBt2xiYp9ARt0GA@mail.gmail.com>
 <CANn89iJ5wKuvKy=Ed-JkeyzKYaEoA_8S=mEMBicMjEPxLCY0Vw@mail.gmail.com>
 <CANn89iKhPmbJW_6DA1_okSGsr_e_Jz47qns-nFcZpnQZ-nAUOA@mail.gmail.com>
 <CAEkJfYMXsNuJjKWJ5nvvw0afSP77F0WWT0gfj2-sQM3VyZ0brQ@mail.gmail.com> <CANn89iKgwNmTZ98MW92VVgC5zPqtQDBFBFspCphKpS-5i6+-7A@mail.gmail.com>
In-Reply-To: <CANn89iKgwNmTZ98MW92VVgC5zPqtQDBFBFspCphKpS-5i6+-7A@mail.gmail.com>
From: Sam Sun <samsun1006219@gmail.com>
Date: Thu, 25 Jun 2026 00:35:48 +0800
X-Gm-Features: AVVi8CfDD_1mkP7E-6k4gLp0c80BKjagvmSr-rgdqpH7deCFr5eD4d1kHtZiPww
Message-ID: <CAEkJfYMZvy1XWuA_y13NfwXef+wUh4jaiQpkzHfr4=HDbr2HAQ@mail.gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301715-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzkaller@googlegroups.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[samsun1006219@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0DB26C0010

On Wed, Jun 24, 2026 at 11:01=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Wed, Jun 24, 2026 at 7:46=E2=80=AFAM Sam Sun <samsun1006219@gmail.com>=
 wrote:
> >
>
> > So we are still freeing struct udp_tunnel_nic while its embedded work_s=
truct
> > is active. debugobjects catches this at kfree() before the active work =
gets a
> > chance to run later and dereference the freed utn.
> >
> > My read is that the conversion from bitfields to atomic bitops removes =
the
> > plain bitfield data race, but UDP_TUNNEL_NIC_WORK_PENDING is still only=
 one
> > boolean state. It can represent "some work is pending", but it cannot
> > distinguish between:
> >   idle
> >   queued
> >   running
> >   running and queued again
> >
> > In particular, the workqueue core clears WORK_STRUCT_PENDING before inv=
oking
> > the worker. At that point the same work item can be queued again by
> > udp_tunnel_nic_device_sync(). If an already running instance later exec=
utes:
> >
> >   clear_bit(UDP_TUNNEL_NIC_WORK_PENDING, &utn->flags);
> >
> > it can still clear the bit that was set for the requeued instance. Then
> > udp_tunnel_nic_unregister() may observe UDP_TUNNEL_NIC_WORK_PENDING cle=
ar and
> > free utn, even though debugobjects still sees utn->work as active.
> >
>
> -ETOOMANYBUGS
>
> Ok, we could try to convert pending bit to a refcount.
>
> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> index 9944ed923ddfd10f9adf6ad788c0740daeaf2adb..2e14686f35896cb0caba3f8f5=
87ef8b369090fbf
> 100644
> --- a/net/ipv4/udp_tunnel_nic.c
> +++ b/net/ipv4/udp_tunnel_nic.c
> @@ -3,6 +3,7 @@
>
>  #include <linux/ethtool_netlink.h>
>  #include <linux/netdevice.h>
> +#include <linux/refcount.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/workqueue.h>
> @@ -30,9 +31,8 @@ struct udp_tunnel_nic_table_entry {
>   * @work:      async work for talking to hardware from process context
>   * @dev:       netdev pointer
>   * @lock:      protects all fields
> - * @need_sync: at least one port start changed
> - * @need_replay: space was freed, we need a replay of all ports
> - * @work_pending: @work is currently scheduled
> + * @flags:     sync, replay flags
> + * @refcnt:    reference count
>   * @n_tables:  number of tables under @entries
>   * @missed:    bitmap of tables which overflown
>   * @entries:   table of tables of ports currently offloaded
> @@ -44,9 +44,11 @@ struct udp_tunnel_nic {
>
>         struct mutex lock;
>
> -       u8 need_sync:1;
> -       u8 need_replay:1;
> -       u8 work_pending:1;
> +       unsigned long flags;
> +#define UDP_TUNNEL_NIC_NEED_SYNC       0
> +#define UDP_TUNNEL_NIC_NEED_REPLAY     1
> +
> +       refcount_t refcnt;
>
>         unsigned int n_tables;
>         unsigned long missed;
> @@ -116,7 +118,7 @@ udp_tunnel_nic_entry_queue(struct udp_tunnel_nic *utn=
,
>                            unsigned int flag)
>  {
>         entry->flags |=3D flag;
> -       utn->need_sync =3D 1;
> +       set_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
>  }
>
>  static void
> @@ -283,7 +285,7 @@ udp_tunnel_nic_device_sync_by_table(struct net_device=
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
> @@ -291,21 +293,24 @@ __udp_tunnel_nic_device_sync(struct net_device
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
> -       queue_work(udp_tunnel_nic_workqueue, &utn->work);
> -       utn->work_pending =3D 1;
> +       if (queue_work(udp_tunnel_nic_workqueue, &utn->work))
> +               refcount_inc(&utn->refcnt);
>  }
>
>  static bool
> @@ -348,7 +353,7 @@ udp_tunnel_nic_has_collision(struct net_device
> *dev, struct udp_tunnel_nic *utn,
>                         if (!udp_tunnel_nic_entry_is_free(entry) &&
>                             entry->port =3D=3D ti->port &&
>                             entry->type !=3D ti->type) {
> -                               __set_bit(i, &utn->missed);
> +                               set_bit(i, &utn->missed);
>                                 return true;
>                         }
>                 }
> @@ -483,7 +488,7 @@ udp_tunnel_nic_add_new(struct net_device *dev,
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
> @@ -552,7 +557,7 @@ static void __udp_tunnel_nic_reset_ntf(struct
> net_device *dev)
>
>         mutex_lock(&utn->lock);
>
> -       utn->need_sync =3D false;
> +       clear_bit(UDP_TUNNEL_NIC_NEED_SYNC, &utn->flags);
>         for (i =3D 0; i < utn->n_tables; i++)
>                 for (j =3D 0; j < info->tables[i].n_entries; j++) {
>                         struct udp_tunnel_nic_table_entry *entry;
> @@ -696,8 +701,8 @@ udp_tunnel_nic_flush(struct net_device *dev,
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
> @@ -713,8 +718,8 @@ udp_tunnel_nic_replay(struct net_device *dev,
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
> @@ -728,6 +733,25 @@ udp_tunnel_nic_replay(struct net_device *dev,
> struct udp_tunnel_nic *utn)
>                         udp_tunnel_nic_entry_unfreeze(&utn->entries[i][j]=
);
>  }
>
> +static void udp_tunnel_nic_free(struct udp_tunnel_nic *utn)
> +{
> +       unsigned int i;
> +
> +       for (i =3D 0; i < utn->n_tables; i++)
> +               kfree(utn->entries[i]);
> +
> +       if (utn->dev)
> +               dev_put(utn->dev);
> +
> +       kfree(utn);
> +}
> +
> +static void udp_tunnel_nic_put(struct udp_tunnel_nic *utn)
> +{
> +       if (refcount_dec_and_test(&utn->refcnt))
> +               udp_tunnel_nic_free(utn);
> +}
> +
>  static void udp_tunnel_nic_device_sync_work(struct work_struct *work)
>  {
>         struct udp_tunnel_nic *utn =3D
> @@ -736,14 +760,15 @@ static void
> udp_tunnel_nic_device_sync_work(struct work_struct *work)
>         rtnl_lock();
>         mutex_lock(&utn->lock);
>
> -       utn->work_pending =3D 0;
>         __udp_tunnel_nic_device_sync(utn->dev, utn);
>
> -       if (utn->need_replay)
> +       if (test_bit(UDP_TUNNEL_NIC_NEED_REPLAY, &utn->flags))
>                 udp_tunnel_nic_replay(utn->dev, utn);
>
>         mutex_unlock(&utn->lock);
>         rtnl_unlock();
> +
> +       udp_tunnel_nic_put(utn);
>  }
>
>  static struct udp_tunnel_nic *
> @@ -759,6 +784,7 @@ udp_tunnel_nic_alloc(const struct udp_tunnel_nic_info=
 *info,
>         utn->n_tables =3D n_tables;
>         INIT_WORK(&utn->work, udp_tunnel_nic_device_sync_work);
>         mutex_init(&utn->lock);
> +       refcount_set(&utn->refcnt, 1);
>
>         for (i =3D 0; i < n_tables; i++) {
>                 utn->entries[i] =3D kzalloc_objs(*utn->entries[i],
> @@ -776,15 +802,6 @@ udp_tunnel_nic_alloc(const struct
> udp_tunnel_nic_info *info,
>         return NULL;
>  }
>
> -static void udp_tunnel_nic_free(struct udp_tunnel_nic *utn)
> -{
> -       unsigned int i;
> -
> -       for (i =3D 0; i < utn->n_tables; i++)
> -               kfree(utn->entries[i]);
> -       kfree(utn);
> -}
> -
>  static int udp_tunnel_nic_register(struct net_device *dev)
>  {
>         const struct udp_tunnel_nic_info *info =3D dev->udp_tunnel_nic_in=
fo;
> @@ -863,6 +880,7 @@ static void
>  udp_tunnel_nic_unregister(struct net_device *dev, struct udp_tunnel_nic =
*utn)
>  {
>         const struct udp_tunnel_nic_info *info =3D dev->udp_tunnel_nic_in=
fo;
> +       bool last =3D true;
>
>         udp_tunnel_nic_lock(dev);
>
> @@ -889,6 +907,7 @@ udp_tunnel_nic_unregister(struct net_device *dev,
> struct udp_tunnel_nic *utn)
>                         udp_tunnel_drop_rx_info(dev);
>                         utn->dev =3D first->dev;
>                         udp_tunnel_nic_unlock(dev);
> +                       last =3D false;
>                         goto release_dev;
>                 }
>
> @@ -901,16 +920,11 @@ udp_tunnel_nic_unregister(struct net_device
> *dev, struct udp_tunnel_nic *utn)
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
> -       udp_tunnel_nic_free(utn);
> +       udp_tunnel_nic_put(utn);
>  release_dev:
>         dev->udp_tunnel_nic =3D NULL;
> -       dev_put(dev);
> +       if (!last)
> +               dev_put(dev);
>  }
>
>  static int

I tested the refcount version, and I could no longer reproduce the bug with
the C reproducer. I think this patch fixes the specific lifetime problem
exposed by the reproducer.

Thanks,
Yue

