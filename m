Return-Path: <netdev+bounces-276205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMjcKQCV1WkK7wcAu9opvQ
	(envelope-from <netdev+bounces-276205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 01:36:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BBB3B57BC
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 01:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287EB3006B47
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 23:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA434C98C;
	Tue,  7 Apr 2026 23:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoyuWUB9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017D535A927
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604981; cv=pass; b=NKtvTcDYLN04H8zLeHNlf/u2pSEADg3VXPQRMtD8nsAcQ5toqCu+y5J86llTK6CHkrMwpnpQ2RcXow5w1HqKxdkwlI5SbDJ5gHmXRtx94m89VTJiAhzDdUGxZPYME/Airb+bzyav3JWBAqg6q6/Pe1YmU7uo1rUCScCVWUxaYB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604981; c=relaxed/simple;
	bh=YCye8xG5072CTmIGiC8DMPnsU4bcU4DP18iIN16+PL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCBPFvAeN8AEmwZn62OV0ZGsLz5nd/8UZX9NgYFVOHvng/W7kv3JOfBX44Z1obRSXQ5wsIvX8JHcgknKdjfBioq2asvjAAT074Ii3ukPZPCZmuHIqmgwqPZBZnGch9yD5JPdENQRhf8JU/yeHDd8X2hB7TroWUsGdoirIoJ7eds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoyuWUB9; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbcde0ba20so317870a34.3
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 16:36:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775604979; cv=none;
        d=google.com; s=arc-20240605;
        b=JU29FKLzcgvmDVow8OWDLHIv5mZxY4tBqlUQSMx6Eqs3gYPTqyq0d2Ns/+YIYk5FF9
         K2vG4gjYIm4x9hitA+4dEdSIDcY571d6FAP91gex6aoHcz7eG/lNrM51tnAk8PBVj+8z
         ZU9XHwBm18ubgdyKkEuESdGUFg3ImSzA7PGGsvryWQuM2ge2EEWzZKcIkLtDBUCXXLnt
         iIe9iRsJLi2zJC897h7N6TqXZOi/1sMZMMMzSftx/meahE1LeKR0Yjb9rjZGRfgFRXzC
         BLX5Nishjr6lVeRAHO/0+PznHAeFq2wTPh2PREXD/fvG454VKp+Ude5FUNbPpK0ZV0yM
         h6Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ARCJwKUF0GjV15ZoWAw1j0i6t/ylIJh3QFU4Xmk/xSQ=;
        fh=H8c9WxbJiTCOeqRsgzc/2tlfc6S4phJdV26sywHRpr8=;
        b=GrXMJSIuCT46nSPBfhF4QM/lOXsX4TWlAslAv9FEe1ByeGge2R173dyuGVNjbNUjya
         /rcBx20mPH4xM7X286ZfpEqPkrouCMlPq3r1he5eDkHOSQGAvFpXeT5ewVEoDGW8hcZ6
         z4hksfJfbqjU2Rxw1oeDM5eN+Ry0d/7MngbKOFjW0innSXcou+y1VumfR3B4zbdcfBj4
         gTOqptIZTjaoIvpJweHjIPcrnp3kiJ66a83XlyZ6kc4e3HuDtgZqZ/sjF5ox9xY7Q2BV
         zzNUGEKbjGx8VmzXh96hgiXCVtB1txmJRjcZAd6yK+yn+OypFUIuWvA22PfZtgmLaZGT
         xQsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775604979; x=1776209779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARCJwKUF0GjV15ZoWAw1j0i6t/ylIJh3QFU4Xmk/xSQ=;
        b=qoyuWUB9r9BQYBJ+rx1XsoT68EM1UBXwumvG1ZmQL0SsXfdj8pruQH7q5xB7nbNcam
         YPPx3ca6nHCHS9UKFTDsWLLsCvzs17yu+/snyZJ4CImRvEd87IaM1R3wIyLJLzS3Om57
         MR2bkLiytcLwquVjfDxunWzjVzdMH+A8MvsxvBncPx4F0+9J/3n5zUofRxTMmC06MIgO
         g4WlQNZ2wOaYarV7220QOBF2CrVLhOfKZKnFLWVZXVlC4DuS05PcILN3dYamiFoX9SNz
         giSMcPDDGFUjP2aTaI7F1U2XusQQPrG4IOrdckCC04tSx+UbA4SpK5vkcFuj76+piX7t
         U/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775604979; x=1776209779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ARCJwKUF0GjV15ZoWAw1j0i6t/ylIJh3QFU4Xmk/xSQ=;
        b=bbEmuhMEzMJM61u77yMBcVOifAKb4esttWbwL7JlDX/NDKN15pOuU34y9ISOal1MwU
         KcWM1CdSe4dtuGl6nijVukaxwtk4PWJGmnAsSWW+qVwhcCE245JgT9hhVse+czRrjDf/
         tXm+JXrQkpqY8WDgko6bG/m76V36oM19zaT673111/kBuL//PmBKw5dWUlhDqmvbqrhv
         dINfgsnjdo5JsKAPcXAQ6RzFOVJxDg17lpplpngKj6TT90WkGgPcP1CVv/VaBcTfvj0J
         LpmxzZKN+dJaOx4dJI0J7Cl+NHRJ4IRBenZVQVNBCGxZ6yU0leIPyXCo+IQfxGzRDHsa
         fOKw==
X-Gm-Message-State: AOJu0YxWBgR4X7pvngvLEXcBMCRJpgYAv1Rs7iIAGoy6KnZpjUJlD+EQ
	URv0kVVlYUzw6r2adBJhstGGZq8GIsIOQ9rXmyrvzBYEp8hd6ZaZo5Ila81/csXuHLK5HE/NTV2
	Id75O8vjlD884eHmy33/NzsWRfdJpfEs=
X-Gm-Gg: AeBDieuRN5a9ey5UAjny7qse2S0h5jKKhxrM2WOmCt1I3X6Cf2HheqAC7k8YUMc+coF
	ao9gKmR5E2JW35Bl6/riPs1uyQ1av46h6zcD+8UHVBzln2ZWB6FUbwA/kDssgA4gd9Gnuu0dxCh
	nt/97BJo0yiD8Brvo0DO7q809HJbgCSkyBt/zqPAd/rVIPC4GccPFwT1uvrrlwRWQ+5y0Xn3a+m
	j0CEsJO0W64Ic6/j8krayh7fa0Pi3FUfCrlVrAX4CXLwdYi1Mux155ysns5v1PlL/GSMr5sWByu
	NuFynKWSbKQs6jFNdglr
X-Received: by 2002:a05:6808:4f08:b0:467:2509:c1bd with SMTP id
 5614622812f47-46ef821cb8cmr6030149b6e.2.1775604978862; Tue, 07 Apr 2026
 16:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260405055853.3285534-1-weibunny.kernel@gmail.com>
 <20260405055853.3285534-3-weibunny.kernel@gmail.com> <2758ac3a-50dc-451a-990a-93e4db9d4bd6@gmail.com>
In-Reply-To: <2758ac3a-50dc-451a-990a-93e4db9d4bd6@gmail.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 7 Apr 2026 16:36:08 -0700
X-Gm-Features: AQROBzBLAEd2xP3aYW7xTaO48-vSzmqQY1uRELiMn3icVX3Go6BzenWLNxMHL4w
Message-ID: <CAGqc4nXqnGNi2YgRXO50Crif-1B4S1SAj7yiB0iVP3gE2oCVyA@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276205-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 09BBB3B57BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 6:27=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.com=
> wrote:
>
>
> On 4/5/26 1:58 AM, Wei Wang wrote:
> > From: Wei Wang <weibunny@fb.com>
> >
> > The main purpose of this cmd is to be able to associate a
> > non-psp-capable device (e.g. veth or netkit) with a psp device.
> > One use case is if we create a pair of veth/netkit, and assign 1 end
> > inside a netns, while leaving the other end within the default netns,
> > with a real PSP device, e.g. netdevsim or a physical PSP-capable NIC.
> > With this command, we could associate the veth/netkit inside the netns
> > with PSP device, so the virtual device could act as PSP-capable device
> > to initiate PSP connections, and performs PSP encryption/decryption on
> > the real PSP device.
> >
> > Signed-off-by: Wei Wang <weibunny@fb.com>
> > ---
> >   Documentation/netlink/specs/psp.yaml |  67 +++++-
> >   include/net/psp/types.h              |  15 ++
> >   include/uapi/linux/psp.h             |  13 ++
> >   net/psp/psp-nl-gen.c                 |  32 +++
> >   net/psp/psp-nl-gen.h                 |   2 +
> >   net/psp/psp_main.c                   |  20 ++
> >   net/psp/psp_nl.c                     | 319 ++++++++++++++++++++++++++=
-
> >   7 files changed, 457 insertions(+), 11 deletions(-)
> >
> ...
> >
> > +/**
> > + * Admin version of psp_device_get_locked() where it returns psd only =
if
> > + * current netns is the same as psd->main_netdev's netns.
> > + */
> >   int psp_device_get_locked_admin(const struct genl_split_ops *ops,
> >                               struct sk_buff *skb, struct genl_info *in=
fo)
> >   {
> >       return __psp_device_get_locked(ops, skb, info, true);
> >   }
> >
> > +/**
> > + * Non-admin version of psp_device_get_locked() where it returns psd i=
n netns
> > + * for not only psd->main_netdev but all netdevs in psd->assoc_dev_lis=
t.
> > + */
> >   int psp_device_get_locked(const struct genl_split_ops *ops,
> >                         struct sk_buff *skb, struct genl_info *info)
> >   {
> > @@ -103,11 +179,74 @@ psp_device_unlock(const struct genl_split_ops *op=
s, struct sk_buff *skb,
> >               sockfd_put(socket);
> >   }
>
>
> There's a warning that these comments have the kdoc open sequence, but
> are not proper kdoc comments.
>
> > +
> >   static int
> >   psp_nl_dev_fill(struct psp_dev *psd, struct sk_buff *rsp,
> >               const struct genl_info *info)
> >   {
> > +     struct net *cur_net;
> >       void *hdr;
> > +     int err;
> > +
> > +     cur_net =3D genl_info_net(info);
> > +
> > +     /* Skip this device if we're in an associated netns but have no
> > +      * associated devices in cur_net
> > +      */
> > +     if (cur_net !=3D dev_net(psd->main_netdev) &&
> > +         !psp_has_assoc_dev_in_ns(psd, cur_net))
> > +             return 0;
> >
>
>
> Is this branch dead code given we either arrived here via
> psp_dev_check_access(), or psp_nl_build_dev_ntf() which should only use
> associated netns's?
>

Yes. But should we keep this check to prevent future usage of this
function to misbehave?

> >
> > +int psp_nl_dev_assoc_doit(struct sk_buff *skb, struct genl_info *info)
> > +{
> > +     struct psp_dev *psd =3D info->user_ptr[0];
> > +     struct psp_assoc_dev *psp_assoc_dev;
> > +     struct net_device *assoc_dev;
> > +     struct sk_buff *rsp;
> > +     u32 assoc_ifindex;
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
> > +     if (cmpxchg(&assoc_dev->psp_dev, NULL, RCU_INITIALIZER(psd))) {
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
> > +             rcu_assign_pointer(assoc_dev->psp_dev, NULL);
> > +             netdev_put(assoc_dev, &psp_assoc_dev->dev_tracker);
> > +             put_net(net);
> > +             kfree(psp_assoc_dev);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     list_add_tail(&psp_assoc_dev->dev_list, &psd->assoc_dev_list);
> > +
> > +     put_net(net);
> > +
> > +     psp_nl_notify_dev(psd, PSP_CMD_DEV_CHANGE_NTF);
> > +
> > +     return psp_nl_reply_send(rsp, info);
> > +}
> > +
>
>
> This function could probably benefit from a goto style cleanup chain,
> given the overlapping set of actions to unwind at each error.
>
Ack. Updating in the new version.

> >
> >   int psp_assoc_device_get_locked(const struct genl_split_ops *ops,
> > @@ -320,7 +617,9 @@ int psp_assoc_device_get_locked(const struct genl_s=
plit_ops *ops,
> >
> >       psd =3D psp_dev_get_for_sock(socket->sk);
> >       if (psd) {
> > +             mutex_lock(&psd->lock);
> >               err =3D psp_dev_check_access(psd, genl_info_net(info), fa=
lse);
> > +             mutex_unlock(&psd->lock);
>
>
> This looks like a "TOCTOU" issue on the mutable assoc_dev_list, but I
> think it ends up being a benign race.

Yea. Will address in the next version.

>
>
> >               if (err) {
> >                       psp_dev_put(psd);
> >                       psd =3D NULL;
>
>
> Some minor comments, but otherwise:
>
> Reviewed-by: Daniel Zahka <daniel.zahka@gmail.com>
>
>

