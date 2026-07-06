Return-Path: <netdev+bounces-305149-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3vCjE8/eS2ohbwEAu9opvQ
	(envelope-from <netdev+bounces-305149-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:58:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD82F7139B5
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 18:58:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ZRL2yyMO;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305149-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305149-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6646305FF04
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA241DEF1;
	Mon,  6 Jul 2026 16:44:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340736B076
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 16:44:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783356248; cv=pass; b=Lx/3eFcCIkREMBT1bh1XYGkJF5PM4Op9EZkgTUCZQcMztbLeGeDZG8iujkSMO4acsHv3OAi/VFxeHmVzywVdhawL/BGuhYS73lBu2c3SIhb9BJ4tOcdPm16EC2uWvLpfzH2eRmiUpA809dt/EG5CFSZ6/mJzHnR60NJp4L+/BaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783356248; c=relaxed/simple;
	bh=f1cTRPDXrlXxt4mMgoIONkuKgGwr+hbfRilAL7nUegE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dK3SCQpQB/Vg1gAa5VX7g/qSVqUmwi9f9V2blL2tuYh3ll1DcM7w44hrPOpqlHuWAa7wpftLXWx5pJvulXqSh2x6CpWu2Xgr1CrjqKokMGPb6rdBP9BiDsh3UM/2l0DPTtEQuT9EJ/WkIutQtwVP7R3xzlMEkgje+cXn/pD4U4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRL2yyMO; arc=pass smtp.client-ip=209.85.215.172
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1632124a12.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 09:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783356247; cv=none;
        d=google.com; s=arc-20260327;
        b=FjE7QsAZdW0LFENAMZ5xruoZBlY8cKUga1Lt8K3DEDKiIT4WrUaPCFm3PwlWBKyaPG
         RINo3dg2QovPi8OPJBZn80DLg+Ii7jDvUUNphUlqPEecaCKmpNFP8lddIPVfa7I6zucz
         E8QQKwZgreZ4zsqXpEbHluotp43OoS9kVCMB4URDTOnBL05TeAee8/gUN9+xd+F6ToEV
         t/b4z9sAGDny3OITDJ1Rkt56xtnKDkAw457UGqVdjA7oUhzT84R17uj9LwPY1HeynqOH
         hbe11QqLdS0VimPB1K2kQ0Qstt9QLZgzr1ehRqaNYHyOaMvQ6N62cHyPh20UsH1n9H+6
         iEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HHookk8ffpYVCb/FWfnrW294xs9Ci52IkQD9J1vWqvk=;
        fh=YBuMc+Am9tQG3e/WYgZiqv30Qc2kVKgWoHVAPj+7Zlo=;
        b=Zrriou28ec9zbYgRvynAojM+f8HIoXIT71izcwHRKOnhTwInX+gnEeNeBmjvNwkEgg
         EOtzeLO8IJcFzt6yXpODUZJT3mEpRhcAqERTl6q68c+JBKYSgXiDTNMae2NMcJLov9dO
         bao3OGjPssrshWJBrRw4h13D8spk608ur5p9qFws2QcDv0bP/AZENC9sKzBrSKKhwgzC
         1YD1LEyynO+id+uK+lndBCuk+MmYgQcwUb9IrP/uri2oPmitl+XfzLPxxSG5qTxfLJtH
         NvTyZNZeBKYGseub0wVMliI82DdThimbs6q6oXgxlz4QEMZ2VtoSfJGb6iWC5t1yr2iu
         61Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783356247; x=1783961047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHookk8ffpYVCb/FWfnrW294xs9Ci52IkQD9J1vWqvk=;
        b=ZRL2yyMOK9LS46IT4/6xFnr6yLJbqrKHxz2oB6BIddDFS5d0SBcx3jRhWpshGa2IAn
         dUmFLOa65KU2mwNpw0pGUnVZGNI6TcpslUt8maYxfMQP8qNUR8K9jg0ECIKwAkw0NMLE
         n+3OfAZDmD6mavpqfN+3gRMjdVLcsFDEWOCTcm3C7FYYLWUHUjf5FKE3+njCOZx/waX9
         ib9X+aso0/DJ+74OJAnnHv7tVPRqaQ47iMHTipr0d66q6xrlQ+J/FHk6Q2BWoFRDVKHT
         7A2fFNye0lDj9pKZRnS+QlSUvd/VQyTsvuxQWfvJ5yDbgRexwbOUc/DDHpykvxTp8K8T
         0vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783356247; x=1783961047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHookk8ffpYVCb/FWfnrW294xs9Ci52IkQD9J1vWqvk=;
        b=ERq33aZDae6WXRsdneIYqBznZ0hMTYIS/sbr2p4k6ty9SUu8pFUZzf2WvGl7d4kC+X
         yR6FaaEMg92fzBAaitH1bCd5jirkDb/HSawb0myD6WmFNYSIiRxTLJcPj6NnuMHNRCZI
         h6sGjxx294iQ33mdlgeOXvEBByvIBK0tJ7WDelwD5ksnh+0/RhnCu+NCkUvJ4ryNy8E0
         CC6tkzcRClOUPeeAVS12qYCoa+wEnTgZylfHXJ0H5chmdnO5sFCiSbO4WJ9/IzNZGuRU
         ATBXQnJUpuJr5H9Y0EVkStnZvTFIRQJGgllkth8bvlJjwkWpKkv3fN7KuhO0VYwDCVlV
         1igQ==
X-Forwarded-Encrypted: i=1; AHgh+RooVOonjbIs2BW8nFPM3cYzMQB+o4qSDqbLg+fRc9B/RFFHBA58cpraYBegC5PG7v5efSJY7yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjJhxoO/vMP1b0i5L/6v8c5Aj/mRZDs+K8T01yslSb05ARNjIE
	J6ycU7XulxyOffj9C+CzAakt1zvTlbbQ30XyH7gLuvvWHNKiV4gjVYjlGSP0jP42K3lyRP/DmTq
	VT+0fbB7pUS30EWOEqSPx5EumQm4Jzlirfd4haMPH
X-Gm-Gg: AfdE7ckpDVGc+hvJ6cxyVCR3RNpiD8UwH/TEqxckfTvWcUhY7BdkwKBquPh59xtZVLR
	DIziFpBKMxNKtSESjp45UJwU61F8/giOcdQRAC9n3mYDDp8OVkipDEpVgyUgkIKLn86Ca4YIZep
	WWs2u4QziTDlUxXQazZ4YI9jVZw5yjFfL/rzSNWqEBzp/CN/dJ4QchCaox2xitvvld5v58viQR/
	Bu26eVQUHrK+ip35l/WkP/YTsYtscm5+nfEREgBVRJOCDymFpxvQehn71Ko9W6KppGI75XGO5OG
	yeLUuAkq3LRiyF85C5blRvoFX8YSdDGlFOAX4La+bMAfOMRxp5Bf4BysSIze/uVbykY2wXKCd2o
	jnWt1gLi4198gur6ArJAicGk403f4iQZ2DTP+4fY=
X-Received: by 2002:a05:6a20:6a28:b0:3b4:b6d7:a992 with SMTP id
 adf61e73a8af0-3c08ec8fb76mr1679048637.8.1783356246054; Mon, 06 Jul 2026
 09:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703001009.1572444-1-kuniyu@google.com> <20260703001009.1572444-9-kuniyu@google.com>
In-Reply-To: <20260703001009.1572444-9-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 6 Jul 2026 09:43:54 -0700
X-Gm-Features: AVVi8Ce4GimsgdD3VXvRqjcvcW6-TtfgzHTxJCTw3-MI3RMVw5SOtQe3I6tBClk
Message-ID: <CAAVpQUB5NwkZGETmWCH_RMoaideKFCPNW9OyWz4C5Kc=j2t2Dw@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 08/14] veth: Support per-netns device unregistration.
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305149-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD82F7139B5

Replying to Sashiko review,

On Thu, Jul 2, 2026 at 5:10=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
[...]
> @@ -1901,15 +1902,17 @@ static int veth_newlink(struct net_device *dev,
>
>         priv =3D netdev_priv(dev);
>         rcu_assign_pointer(priv->peer, peer);
> +       netdev_hold(peer, &priv->peer_tracker, GFP_KERNEL);

---8<---
Because the devices are already registered and visible to the system at thi=
s
point, could a concurrent ip link del trigger veth_dellink() right after
rcu_assign_pointer() publishes priv->peer, but before netdev_hold() is
called?
---8<---

No, ->newlink() and ->dellink() are serialised with the same rtnl_net_lock(=
).


>         err =3D veth_init_queues(dev, tb);
>         if (err)
>                 goto err_queues;
>
>         priv =3D netdev_priv(peer);
>         rcu_assign_pointer(priv->peer, dev);
> +       netdev_hold(dev, &priv->peer_tracker, GFP_KERNEL);
>         err =3D veth_init_queues(peer, tb);
>         if (err)
> -               goto err_queues;
> +               goto err_peer_queues;
>
>         veth_disable_gro(dev);
>         /* update XDP supported features */
> @@ -1918,7 +1921,11 @@ static int veth_newlink(struct net_device *dev,
>
>         return 0;
>
> +err_peer_queues:
> +       netdev_put(dev, &priv->peer_tracker);
> +       priv =3D netdev_priv(dev);
>  err_queues:
> +       netdev_put(peer, &priv->peer_tracker);
>         unregister_netdevice(dev);

---8<---
If veth_init_queues() fails, does this error path safely handle a concurren=
t
veth_dellink()?
---8<---

This depends on the same wrong assumption, so no, ->newlink() holds
multiple rtnl_net_lock() so that the concurrent ->dellink() never occurs.


>  err_register_dev:
>         /* nothing to do */
> @@ -1933,24 +1940,25 @@ static int veth_newlink(struct net_device *dev,
>
>  static void veth_dellink(struct net_device *dev, struct list_head *head)
>  {
> -       struct veth_priv *priv;
> +       netdevice_tracker *peer_tracker;
>         struct net_device *peer;
> +       struct veth_priv *priv;
>
>         priv =3D netdev_priv(dev);
> -       peer =3D rtnl_dereference(priv->peer);
> +       peer_tracker =3D &priv->peer_tracker;
> +       peer =3D unrcu_pointer(xchg(&priv->peer, NULL));

---8<---
Does changing this to use xchg() introduce a data race with read paths?
Functions like veth_set_xdp_features() still use rtnl_dereference(),
...
Might this need READ_ONCE() or rcu_dereference() to safely handle the
concurrent xchg() writes?
---8<---

Yes, but with another series before removing RTNL.

As mentioned in the cover letter, the device unreg path is the only target
of this series, and we need more changes in other paths.

