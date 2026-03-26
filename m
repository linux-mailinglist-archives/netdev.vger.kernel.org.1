Return-Path: <netdev+bounces-271842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id COb5A5HCxGku3QQAu9opvQ
	(envelope-from <netdev+bounces-271842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:22:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A428132F576
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 06:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EF933032768
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 05:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A221285CAA;
	Thu, 26 Mar 2026 05:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6wqPrUY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B138288B8
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 05:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774502495; cv=pass; b=g/S03tsdxG66Et2nBF3XO0SoLsAXW9LlU5oHizD/zE9NLQQqWMAKWhns+fBVSRQKe8EZd7RQFJg/r34U9StqMA+zI9Ci3QH/GfYq5zn/MBfsClunO/aWyMzOWhSppZbdfDLJJmrMP1oON6txFxE+3Dnxw6fyothQXLOWBWTIIfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774502495; c=relaxed/simple;
	bh=1KLe6rDQVRFQjMxaPXxhn+NGY/CqijoGUoYB+Zy3F7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+pwNqFWlDoAQK8fWQIcP8vTOyk0RGIMR0Yt9ApFKvaHJ9JNhHuFiLbz2170ucf4niJNlxzcCOhNS7QiKy724t9BiM/Lm/ky/Q06O0g6ElCEI+S2qSomeMIBYzbYSH3vkiHCyCVgvwZ0TidtA4DKVyGn2QNRNGGHJczH0/UtbLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6wqPrUY; arc=pass smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-67c0c4a3ee1so8508eaf.2
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 22:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774502492; cv=none;
        d=google.com; s=arc-20240605;
        b=RDIDWHKNbHoCIOwMmFLOigRIgLrKsnUY//ThjEDzFfF0wHloJjnAWIcf0DizlN+Iv6
         SqHlf8Bcyva3/LfYVNDxXFaepS3ZR9/PNlUv+gVcFf/D7ltC3sGrN0lAw6FGhEtfufTk
         hiGJK1gI0IfGyzHR5xwmvZ7wcYg/A/jJv+6mzD8qGB/841OtUmMT07MNXlD9lN9zciTD
         V+tbzhmsQR1M+U+FY8k6jObqDVaVwfr4G8R0KQ7sOv+B0Xb0PU0bocx81Mfv5vU8brn9
         qLb1/HpZcB+zoeEqVs4FyXrtXAqss15SFiNfmjdiNzq3lDJ8I3+YIP03svQUrwhIu5rm
         KEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iQ1ukNCLcyThwdzMkCPXWnZDaidmsqrZuHnMSpAKXJ0=;
        fh=8SZhFBubAwufb3Pzoa2FuEuHg6JSzeBoEHJdKTKykXM=;
        b=GhCAXx9oY0F/kFrUh3j6/Bw51qmbsUkIADm3A+YUsRfeIUTDLWn9f5sbGpuf5ZJIkE
         PLeoW6OVF8EH6I9JncsgKRyncht2NO6YA7AhT59emyN9Ck7/4AqpI3IrQnuvN3XND/EG
         zVDCLswsT1Lz/hsUzjnpFQSbXs9Z2ojI9XYZSfaLgoR9QfBaKdW6zLpXKqwLnfBWlMy0
         t3JlbfPF9uGeRLpN/ln//1f588r/CMwRE2fMmgRIPC9uwR2y7RRZxQY/zq22GkX+//h1
         jkrScyIiZhYxo7SE+fwoMQIYURU+irzvjEzozVmDz2GGCjWotSmrMQYIcx9GzasV6tLh
         swMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774502492; x=1775107292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iQ1ukNCLcyThwdzMkCPXWnZDaidmsqrZuHnMSpAKXJ0=;
        b=f6wqPrUYXOkm7TGDq3fHL28TXYULlM1auB7FNwsu/qGEIPRqxrT15gg3K5gIbskCHZ
         d1fRwXctLqyFc/CJiZ9b+me7EhoPPeYgOuMiQo6b4uMv/ndBKGlrsTvCNyvtSvAi+5RY
         Ei6PYNkJ9McyMbNHbGYUY9pKSZjeX70zxScG3WmgH7BTS+41hCx8DfcV8tJKCdz48LDH
         uLIloTTFi+Jin2jOiNMSuyedkA86pfZASDrTfpqiHpiAD6LLaj8EFu9xt1FDRN3LgHdJ
         nMUB00Vr76F4XdJEf0Ap6KihsIEgk8+w78nHKGDVeuY5YBzSM3LZi63j6fGA3L5BAyvq
         e0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774502492; x=1775107292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iQ1ukNCLcyThwdzMkCPXWnZDaidmsqrZuHnMSpAKXJ0=;
        b=XQ4nj27fjveImxmPfs4MtyQtiM+I8oJ6qqpZSYEurDsiz3WF8+JO24TKbKtdsj2Vhv
         llsnwC13UCiZX6Zb8IOpBCAabOY1on3tnAoCBj3MFO9jIiwoSifbYSwgKGSF7ZvaqBSo
         9AcwE7U3u8gfWtuYMqS23TVyofrsu2l65q/dksl0+IHWttPSAdfBRDpDjzYX0VLoR/Lz
         zztjOq2u0CiLnUrCtvlVMMLJMpqb/DAgK0yoPg6qqvmD/v9XyvhYOJfOo/Imjg8bDud1
         FWliGLvQN6TLQT0Nn8JjUgVK4sKgBB68zRfo1tYs+yQu91umRxZ4gOG31zb28lQX0Dji
         bwQg==
X-Forwarded-Encrypted: i=1; AJvYcCWTb6RxUrO29dDs1/TgZqxdODz0FFuRjaO/Ae7lWwCXQxvYNFIymT/dY5brbD8qNStO0YCjhmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhLHQgrHgcRTpQFXYTJKSbWftPEcoARvnTqJDSKeGx98OhZHEv
	GTQbHg6aU6bET60Ba4kiH1SuE5iK40zsSuUVilj65LH71prvwdTxcrnHUtHneFUQL8Pmgf8TEb9
	xvBNsXtFuSpUGu9jRXiOIzZfv95VHJ24=
X-Gm-Gg: ATEYQzy1itMZjprSpmzZpqvO2idB60Riqzon3D0AguWZsysyj/XBSHzvAZ9rnQYrwdW
	YnCSDbeEh8cIJ26M+EgJ0NG/n1aayvHIqCRP7pL8acOHWWV9HomGEekjRfR2MY5eZLz1LQoTom7
	cDfiReDvzLyV5i/IKnsPUi2Ob0NCcJb5eHlHfD93UoUkH61QQPGy7bLJ3L0Qhlv6lYu5gquBGtL
	rz2bYgkS+I32hCxReP++2A2iyw1q4chE0gjMQUBQgj2vIMsdLAtlw4b/Ol9k4iqUTB13Tm5hYtR
	FSD+Dw==
X-Received: by 2002:a05:6820:8606:b0:67c:3021:908a with SMTP id
 006d021491bc7-67dff554099mr1428783eaf.3.1774502492272; Wed, 25 Mar 2026
 22:21:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322040704.991766-3-weibunny.kernel@gmail.com> <20260323182357.177116-1-horms@kernel.org>
In-Reply-To: <20260323182357.177116-1-horms@kernel.org>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Wed, 25 Mar 2026 22:21:21 -0700
X-Gm-Features: AQROBzAPAts7nlO-5nUR3MUgPplOCpprOuUPeza8FrUo6x72y1HZ16AvL-4WA14
Message-ID: <CAGqc4nVPcbFQhh6GFo60nN6_Cu7dYyqZ=HKVzMJk+QbWFJUF6A@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, willemdebruijn.kernel@gmail.com, 
	netdev@vger.kernel.org, weibunny@fb.com, daniel.zahka@gmail.com, 
	bobbyeshleman@meta.com, kuba@kernel.org, davem@davemloft.net, dw@davidwei.uk, 
	andrew+netdev@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271842-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,fb.com,meta.com,kernel.org,davemloft.net,davidwei.uk,lunn.ch];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Queue-Id: A428132F576
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026 at 11:24=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> psp: add new netlink cmd for dev-assoc and dev-disassoc
>
> This commit adds new netlink commands (PSP_CMD_DEV_ASSOC and
> PSP_CMD_DEV_DISASSOC) to associate non-PSP-capable devices (e.g. veth or
> netkit) with a PSP device, enabling them to act as PSP-capable devices by
> performing PSP encryption/decryption on the real PSP device.
>
> > diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> > index 82de78a1d6bd..178b848989f1 100644
> > --- a/net/psp/psp_main.c
> > +++ b/net/psp/psp_main.c
> > @@ -37,8 +37,18 @@ struct mutex psp_devs_lock;
> >   */
> >  int psp_dev_check_access(struct psp_dev *psd, struct net *net, bool ad=
min)
> >  {
> > +     struct psp_assoc_dev *entry;
> > +
> >       if (dev_net(psd->main_netdev) =3D=3D net)
> >               return 0;
> > +
> > +     if (!admin) {
> > +             list_for_each_entry(entry, &psd->assoc_dev_list, dev_list=
) {
> > +                     if (dev_net(entry->assoc_dev) =3D=3D net)
> > +                             return 0;
> > +             }
> > +     }
> > +
> >       return -ENOENT;
> >  }
>
> Does this list iteration have a race with psp_dev_unregister()?
>
> The new list_for_each_entry iteration over psd->assoc_dev_list in
> psp_dev_check_access is called from psp_assoc_device_get_locked
> (net/psp/psp_nl.c:615) without holding psd->lock.
>
> That caller obtains psd via psp_dev_get_for_sock which takes a refcount
> but does not acquire psd->lock before calling psp_dev_check_access(psd,
> ..., false). Since admin is false, the new code path is entered.
>
> Concurrently, psp_dev_unregister holds psd->lock and performs list_del +
> kfree on the same assoc_dev_list entries:
>
> net/psp/psp_main.c:psp_dev_unregister() {
>         ...
>         list_for_each_entry_safe(entry, entry_tmp, &psd->assoc_dev_list,
>                                  dev_list) {
>                 list_del(&entry->dev_list);
>                 rcu_assign_pointer(entry->assoc_dev->psp_dev, NULL);
>                 netdev_put(entry->assoc_dev, &entry->dev_tracker);
>                 kfree(entry);
>         }
>         ...
> }
>
> The list iterator in psp_dev_check_access can follow a next pointer into
> freed memory, causing a use-after-free.
>
> Other callers (psp_device_get_and_lock, psp_nl_dev_get_dumpit,
> psp_nl_get_stats_dumpit) correctly hold psd->lock before calling this
> function, so the race is specific to the psp_assoc_device_get_locked path=
.
>
Grabbing psd->lock before psp_dev_check_access () in the next versions.

> > diff --git a/net/psp/psp_nl.c b/net/psp/psp_nl.c
> > index b988f35412df..aa60a8277829 100644
> > --- a/net/psp/psp_nl.c
> > +++ b/net/psp/psp_nl.c
>
> [ ... ]
>
> > @@ -291,6 +446,140 @@ int psp_nl_key_rotate_doit(struct sk_buff *skb, s=
truct genl_info *info)
> >       return err;
> >  }
> >
> > +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +     struct psp_dev *psd =3D info->user_ptr[0];
> > +     struct psp_assoc_dev *psp_assoc_dev;
> > +     struct net_device *assoc_dev;
> > +     u32 assoc_ifindex;
> > +     struct sk_buff *rsp;
> > +     struct net *net;
> > +     int nsid;
> > +
> > +     if (GENL_REQ_ATTR_CHECK(info, PSP_A_DEV_IFINDEX))
> > +             return -EINVAL;
> > +
> > +     if (info->attrs[PSP_A_DEV_NSID]) {
> > +             nsid =3D nla_get_s32(info->attrs[PSP_A_DEV_NSID]);
> > +
> > +             net =3D get_net_ns_by_id(genl_info_net(info), nsid);
> > +             if (!net) {
> > +                     NL_SET_BAD_ATTR(info->extack,
> > +                                     info->attrs[PSP_A_DEV_NSID]);
> > +                     return -EINVAL;
> > +             }
> > +     } else {
> > +             net =3D get_net(genl_info_net(info));
> > +     }
> > +
> > +     psp_assoc_dev =3D kzalloc(sizeof(*psp_assoc_dev), GFP_KERNEL);
> > +     if (!psp_assoc_dev) {
> > +             put_net(net);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     assoc_ifindex =3D nla_get_u32(info->attrs[PSP_A_DEV_IFINDEX]);
> > +     assoc_dev =3D netdev_get_by_index(net, assoc_ifindex,
> > +                                     &psp_assoc_dev->dev_tracker,
> > +                                     GFP_KERNEL);
> > +     if (!assoc_dev) {
> > +             put_net(net);
> > +             kfree(psp_assoc_dev);
> > +             NL_SET_BAD_ATTR(info->extack, info->attrs[PSP_A_DEV_IFIND=
EX]);
> > +             return -ENODEV;
> > +     }
> > +
> > +     /* Check if device is already associated with a PSP device */
> > +     if (rcu_access_pointer(assoc_dev->psp_dev)) {
> > +             NL_SET_ERR_MSG(info->extack,
> > +                            "Device already associated with a PSP devi=
ce");
> > +             netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
> > +             put_net(net);
> > +             kfree(psp_assoc_dev);
> > +             return -EBUSY;
> > +     }
> > +
> > +     psp_assoc_dev->assoc_dev =3D assoc_dev;
> > +     rsp =3D psp_nl_reply_new(info);
> > +     if (!rsp) {
> > +             netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
> > +             put_net(net);
> > +             kfree(psp_assoc_dev);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     rcu_assign_pointer(assoc_dev->psp_dev, psd);
> > +     list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
>
> Can two concurrent PSP_CMD_DEV_ASSOC operations for the same net_device b=
ut
> different PSP devices both succeed?
>
> The function checks rcu_access_pointer(assoc_dev->psp_dev) to verify the
> target net_device is not already associated with a PSP device, then later
> writes rcu_assign_pointer(assoc_dev->psp_dev, psd) and adds the wrapper t=
o
> psd->assoc_dev_list.
>
> These operations are only serialized by psd->lock, which is a per-PSP-dev=
ice
> mutex acquired by the pre_doit callback psp_device_get_locked(). With
> parallel_ops=3Dtrue in the psp_nl_family (net/psp/psp-nl-gen.c:165), two
> concurrent PSP_CMD_DEV_ASSOC operations targeting different PSP devices
> (each holding their own distinct psd->lock) but specifying the same targe=
t
> ifindex can both pass the rcu_access_pointer() NULL check.
>
> Both then call rcu_assign_pointer(assoc_dev->psp_dev, psd) and
> list_add_tail(), resulting in the same net_device being added to two
> different PSP devices' assoc_dev_list. The second rcu_assign_pointer
> silently overwrites the first.
>
> This leaves the first PSP device's assoc_dev_list containing an entry who=
se
> net_device->psp_dev points to the wrong PSP device:
>
> Thread A (PSP device psd_A)        Thread B (PSP device psd_B)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> mutex_lock(&psd_A->lock)           mutex_lock(&psd_B->lock)
> rcu_access_pointer(dev->psp_dev)
>   -> NULL, proceed                 rcu_access_pointer(dev->psp_dev)
>                                      -> NULL, proceed
> rcu_assign_pointer(dev->psp_dev,   rcu_assign_pointer(dev->psp_dev,
>                    psd_A)                             psd_B)
> list_add_tail(entry_A,             list_add_tail(entry_B,
>               &psd_A->list)                      &psd_B->list)
>
> A subsequent disassociation from the first PSP device would find its stal=
e
> psp_assoc_dev entry, call rcu_assign_pointer(found->assoc_dev->psp_dev,
> NULL), and clear the pointer that now belongs to the second PSP device,
> corrupting cross-device state.
>
> The data path check in psp_validate_xmit
> (rcu_access_pointer(dev->psp_dev) =3D=3D pas->psd) can then fail incorrec=
tly.

Changing to use cmpxchg() on assoc_dev->psp_dev in the next version.

