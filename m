Return-Path: <netdev+bounces-261301-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBgPA/swoGmLgAQAu9opvQ
	(envelope-from <netdev+bounces-261301-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:39:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C7B1A536B
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 12:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C3DE30068DE
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 11:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626383382DB;
	Thu, 26 Feb 2026 11:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HfzPlAGo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3608A932
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105976; cv=pass; b=eLrfTMJ99uIMR5StZRUc+qmvTZTcp8y3Ly2wqjlna86jNx7RF+rBNrOJY/2lkeZcSRdd895zKg1UQXe7i51BmuzdKQ2O7Vgd1M2xRAHq3F/oUj5CsqSUbhUJLuNVvO6Tt4qYZF0Fi600U8HyE2IkxcGANsksAXsNiAI5J4tHkq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105976; c=relaxed/simple;
	bh=euSTzPq2F1klfGutM2tOKaO76fvZ7WdYUpBMkfRWduM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omMvFbPFOBbWYMSEpr2oZ78tHnq9IMG6bhpqgiDWnVL848BT10oiBVg2F93IF+pnD0AQmDbnGo7F9kjChbPd7jCFQv7eX4zf/f7dQ4dI8hkSSDVkUZyJEXlhKHNLOX0vH7WrNjv9mHFSw8eF7Fc+sypkNy2SwZVB0MJkRLzbBBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HfzPlAGo; arc=pass smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-2adec255754so4719535ad.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772105974; x=1772710774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDgQfZEqeYjIqNd6BT6EySh1xk9DorRuGMHGS2SIX1Y=;
        b=G/yUrxsvnz0TY9Y4yBe2cm+t34xbklu4ZNBVaw02rxBUZBjNHZNoACHDufRW3kSv+h
         sYI3NIjr67FNmVwo0RtMmoqXpdKG8X5vif9M2IiwPPIrktMgG8mNqXajZ5Lgwhpvz6xu
         j3mcPQ+oubFSXr2RqnpSm6vEIRGiBJMesBG+0waLpnpZPmjvcmxqIgK7PPF3XS7Fv6ip
         vkHLVM3XpSxzGbT33tEiivqFXMY5q/vYPCSNaD2h5ferFPfNlADZQpOIlsaA4jQ0UzZ/
         /tQ2UDtFTr1ezCkv7ayPfjcP8O+COUhpGqJIAClLyrzwG3SlJPme/gJ+t5dm0Zp4epP9
         h4fA==
X-Forwarded-Encrypted: i=2; AJvYcCVKY75Y6Z0lK+Hle5bjo71vpH1pE4l73+pHM5Pw7imi+NpJ0A0bSuHx8iLImm3/+Yw7/7+sSiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2+8tmxZxEKxGx9IkjT4U4wEjyii5br4ObhtC4YLEsu24HWMX
	9AW34d97QOwr5xch3DNWp5XD8+Ckm91mbIZftS+UgzHxpmV4x4TIqgJkN43OrFwnhWOjpVrdUJd
	53268L7ELtDG3JDwrihWTRotXCyN7ONZbdEQfeWb6LE6/83RqtugMMRpUe8Ql2ZqOd83hEVLbZg
	zYQXeTnXX7imFEQynh7VJaX9k/kpNi3sVCaMWS3dx16npqeMWTUsag2rpZ5MxQfN/h9WfC9IYMd
	ypn+L/YHw==
X-Gm-Gg: ATEYQzywjTrJuU7qbMm4h2Xne3xbiXKn001VtEVgNCGVOxNjqYEjIPThCN4zi5ltYhO
	DgtS6Q84Z5JvJTG1gotGSKBMI/ENQXN7lNQX5+LpUKuqcMJarrqzi8kAPMR2VeqnML788pOKlSN
	aqzsNVZisUhFw7KOfjMVnla6G+DFgnQ1Sm+HKcTgDiOItAOSVCKCsKpqkpwM5F1qPyQb47UWZd7
	K7WDL2rok6YAgFBqoTVKdd2/QgDPBywGsV2hb1kn3JiMUns9M2CzuEVOwAKFCcHvBZYHfJa9XJ1
	aqMA4lxXle6x/yzt1sl+dcl5TceQYx+Q+dTVsi4/2JGCzGRchBhUYKvt6kee+CahuKQd8D5guX1
	P6PvZ/rxwM0023ueOf4mSP7oOhj/FwzMAfjE1hX5Ne78GMgPkuWw7VmNstuLKFrUbbfUCAOVI3S
	0g1sf3vNU3luDMWEcNyBlGPe5UgqI2ZvF2IOUOCcI2GzNg2ls+yy3G9ZkAMw==
X-Received: by 2002:a17:903:3bcb:b0:2a9:327f:aa2f with SMTP id d9443c01a7336-2ad7451256amr180573485ad.26.1772105974192;
        Thu, 26 Feb 2026 03:39:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb5fe78csm2207585ad.51.2026.02.26.03.39.33
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Feb 2026 03:39:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358e425c261so586259a91.3
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 03:39:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772105973; cv=none;
        d=google.com; s=arc-20240605;
        b=cFL//1WZYBxc77wUbjiSaEOKEu69rECpfPnWk9PvzWwKIufDNbWlJhc2FVVtzSoVX1
         4dm3ln/dszqCQ35kOad8wywqlxELFPEZwYwlJEJTObH3Wh9JN6vSg5TJ4WtdF1qJCqXJ
         Tc2SlshAdh7baIyOdCwLV8ZBFL2+E7YWdX4Rw0r0X3EqG2mSyZm+LBAct8R1nCu3OFfQ
         FazBXWaewdcxJ8efrGFUj9/v2BvBdTxVIeh2wsjZ6vhRSwwja//H1MzXjPBG6oc6OPoF
         r0JM5b90LNuZjOUs8C488ngbQCWHA8Ul84ubXOn+PjkPnrgxER+QNQ+XXcewA0a8FprM
         D5Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uDgQfZEqeYjIqNd6BT6EySh1xk9DorRuGMHGS2SIX1Y=;
        fh=jMikdkROxe1ToBNRLlXGLW2V1UD71xzLeJBmgHlkCJU=;
        b=bGefHgcRqxLKBaDb1/wwgEBHy/GNhvS7TrpHZ7mLWNG4hRQOMl6LAsxQasnNw98YwS
         HxtHX3T3WJ4mKDRjXmTtVIw48gAmzX9qkPzR52uT+nau4QaZCVuYkMwqYtJsIkcneQoO
         CVcK0k1/f2qtGvILwmNLJk7Oh3wRwcIiF74aT1eyGlGMdtzz/LHn1jxr3+yM3YCH9re3
         /LgVk3Ftq3q8iymNpu+3RZE0GaT+7NNs/2KIaC7lYej/gRcLzPLJx7CuEmeodJCYMUa8
         oc57Nf1OwgqJdKGjvNJUav2LJn2UF1sUYiE7Kn554uC03tzfuUe86gcbafBvM1n6ooWB
         rO6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772105973; x=1772710773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDgQfZEqeYjIqNd6BT6EySh1xk9DorRuGMHGS2SIX1Y=;
        b=HfzPlAGoh4xi0qsOW+KPV0rIKESXE5/yHJMc1TjpUvDy0RGYU1pWaln2QlQZWRg+M+
         cgP0iF9d23tLQYDgPu4buMNLYaQxz7Kg177ADSRaCfKPFb837zAUvWkA5cr+FAZwf1Mi
         wXpLO9cMQQW7XRp/EOxs70nFkNWKo86NNfjzk=
X-Forwarded-Encrypted: i=1; AJvYcCVIi1ZI4DQM1NgIM8kYcb+izIT8HYdi+zlGKDfq1NtGYLmowUtSXow++0PIwZlyErzf6VXoB/Q=@vger.kernel.org
X-Received: by 2002:a17:90b:2790:b0:359:dd9:3de5 with SMTP id 98e67ed59e1d1-3590dd9400cmr5915355a91.4.1772105972608;
        Thu, 26 Feb 2026 03:39:32 -0800 (PST)
X-Received: by 2002:a17:90b:2790:b0:359:dd9:3de5 with SMTP id
 98e67ed59e1d1-3590dd9400cmr5915339a91.4.1772105972150; Thu, 26 Feb 2026
 03:39:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223191154.2800616-1-kiran.kella@broadcom.com>
 <20260223191154.2800616-2-kiran.kella@broadcom.com> <0a850f65-be67-4a66-941f-17d8440e987b@gmail.com>
In-Reply-To: <0a850f65-be67-4a66-941f-17d8440e987b@gmail.com>
From: Kiran Kella <kiran.kella@broadcom.com>
Date: Thu, 26 Feb 2026 17:08:55 +0530
X-Gm-Features: AaiRm51fvZXtG87k8kiHTKTwmAI2AXhTCNRUtXxjEQRLMY4MchHiNYxYx6GpU40
Message-ID: <CAPHeo3cdmxKEipoyWfBiSCwP19pLf0eO24p5NBNBXeNY04G63w@mail.gmail.com>
Subject: Re: [net-next, v2 1/2] psp: Support for transmit on logical device
 when the underlying transport device supports PSP.
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	willemb@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com, 
	akhilesh.samineni@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261301-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiran.kella@broadcom.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Queue-Id: 49C7B1A536B
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 2:28=E2=80=AFAM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
>
>
> On 2/23/26 2:11 PM, Kiran Kella wrote:
> > This is achieved by propagating the psp_dev from the lower device
> > to the upper devices in the device stack via a netdevice notifier.
> > The lowest device owns the psp_dev pointer while the upper devices
> > just borrow the pointer. When the lower device is unlinked, the
> > borrowed pointer is cleared in the upper device.
> > Assumption being that psp_dev is set on the lowest device before
> > any upper devices are stacked on that lowest device.
> >
> > Signed-off-by: Kiran Kella <kiran.kella@broadcom.com>
> > Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
> > Reviewed-by: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
> > ---
> >   net/psp/psp_main.c | 109 ++++++++++++++++++++++++++++++++++++++++++++=
-
> >   1 file changed, 108 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> > index a8534124f626..fac785dcfa0f 100644
> > --- a/net/psp/psp_main.c
> > +++ b/net/psp/psp_main.c
> > @@ -3,6 +3,7 @@
> >   #include <linux/bitfield.h>
> >   #include <linux/list.h>
> >   #include <linux/netdevice.h>
> > +#include <linux/rtnetlink.h>
> >   #include <linux/xarray.h>
> >   #include <net/net_namespace.h>
> >   #include <net/psp.h>
> > @@ -110,13 +111,45 @@ void psp_dev_free(struct psp_dev *psd)
> >       kfree_rcu(psd, rcu);
> >   }
> >
> > +/**
> > + * psp_clear_upper_dev_psp_dev() - Clear borrowed psp_dev pointer on u=
pper
> > + *                              device
> > + * @upper_dev:       Upper device that may have borrowed psp_dev point=
er
> > + * @priv:    netdev_nested_priv containing the psp_dev being unregiste=
red
> > + *
> > + * Callback for netdev_walk_all_upper_dev_rcu() to clear borrowed psp_=
dev
> > + * pointers on upper devices when the underlying psp_dev is being unre=
gistered.
> > + *
> > + * Return: 0 to continue walking, non-zero to stop.
> > + */
> > +static int psp_clear_upper_dev_psp_dev(struct net_device *upper_dev,
> > +                                    struct netdev_nested_priv *priv)
> > +{
> > +     struct psp_dev *psd =3D priv->data;
> > +     struct psp_dev *upper_psd;
> > +
> > +     upper_psd =3D rcu_dereference(upper_dev->psp_dev);
> > +     if (upper_psd =3D=3D psd)
> > +             rcu_assign_pointer(upper_dev->psp_dev, NULL);
> > +
> > +     return 0;
> > +}
> > +
> >   /**
> >    * psp_dev_unregister() - unregister PSP device
> >    * @psd:    PSP device structure
> > + *
> > + * Unregisters a PSP device and clears all borrowed psp_dev pointers o=
n
> > + * upper devices (e.g., VLAN subinterfaces) that reference this device=
.
> > + * This prevents use-after-free if upper devices still have borrowed
> > + * pointers when the psp_dev structure is freed.
> >    */
> >   void psp_dev_unregister(struct psp_dev *psd)
> >   {
> >       struct psp_assoc *pas, *next;
> > +     struct netdev_nested_priv priv =3D {
> > +             .data =3D psd,
> > +     };
> >
> >       mutex_lock(&psp_devs_lock);
> >       mutex_lock(&psd->lock);
> > @@ -137,6 +170,12 @@ void psp_dev_unregister(struct psp_dev *psd)
> >
> >       rcu_assign_pointer(psd->main_netdev->psp_dev, NULL);
> >
> > +     /* Clear borrowed psp_dev pointers on all upper devices */
> > +     rcu_read_lock();
> > +     netdev_walk_all_upper_dev_rcu(psd->main_netdev,
> > +                                   psp_clear_upper_dev_psp_dev, &priv)=
;
> > +     rcu_read_unlock();
> > +
> >       psd->ops =3D NULL;
> >       psd->drv_priv =3D NULL;
> >
> > @@ -313,11 +352,79 @@ int psp_dev_rcv(struct sk_buff *skb, u16 dev_id, =
u8 generation, bool strip_icv)
> >   }
> >   EXPORT_SYMBOL(psp_dev_rcv);
> >
> > +/**
> > + * psp_netdevice_event() - Handle netdevice events for PSP device prop=
agation
> > + * @nb:              notifier block
> > + * @event:   netdevice event
> > + * @ptr:     netdevice notifier info
> > + *
> > + * Propagates psp_dev pointer from lower devices to upper devices when
> > + * upper devices are created (e.g., VLAN subinterfaces).
> > + * Excluding from this logic, the upper devices that have multiple low=
er
> > + * devices eg., bond devices.
> > + *
> > + * Return: NOTIFY_DONE
> > + */
> > +static int psp_netdevice_event(struct notifier_block *nb,
> > +                            unsigned long event, void *ptr)
> > +{
> > +     struct netdev_notifier_changeupper_info *info;
> > +     struct net_device *dev, *upper_dev;
> > +     struct psp_dev *psd;
> > +
> > +     if (event !=3D NETDEV_CHANGEUPPER)
> > +             return NOTIFY_DONE;
> > +
> > +     info =3D ptr;
> > +     dev =3D netdev_notifier_info_to_dev(ptr);
> > +     upper_dev =3D info->upper_dev;
> > +
> > +     if (netif_is_lag_master(upper_dev))
> > +             return NOTIFY_DONE;
> > +
> > +     if (info->linking) {
> > +             /* Lower device is being linked to an upper device.
> > +              * Propagate psp_dev from the immediate lower device to t=
he
> > +              * upper device. The immediate lower device would have al=
ready
> > +              * got the psp_dev pointer set in a previous notification=
 (or
> > +              * owns it if it's the lowest device).
> > +              * Upper devices just borrow the pointer.
> > +              */
> > +             psd =3D rtnl_dereference(dev->psp_dev);
> > +             if (psd)
> > +                     rcu_assign_pointer(upper_dev->psp_dev, psd);
> > +     } else {
> > +             /* Lower device is being unlinked from an upper device.
> > +              * Clear the borrowed psp_dev pointer.
> > +              */
> > +             psd =3D rtnl_dereference(upper_dev->psp_dev);
> > +             if (psd)
> > +                     rcu_assign_pointer(upper_dev->psp_dev, NULL);
> > +     }
> > +
> > +     return NOTIFY_DONE;
> > +}
> > +
> > +static struct notifier_block psp_netdevice_notifier =3D {
> > +     .notifier_call =3D psp_netdevice_event,
> > +};
> > +
> >   static int __init psp_init(void)
> >   {
> > +     int err;
> > +
> >       mutex_init(&psp_devs_lock);
> >
> > -     return genl_register_family(&psp_nl_family);
> > +     err =3D register_netdevice_notifier(&psp_netdevice_notifier);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D genl_register_family(&psp_nl_family);
> > +     if (err) {
> > +             unregister_netdevice_notifier(&psp_netdevice_notifier);
> > +             return err;
> > +     }
> > +     return 0;
> >   }
> >
> >   subsys_initcall(psp_init);
>
> The lack of support for netns is a bit of a gap for this feature. It may
> make sense to see if what was posted in
> https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.com/
> is sufficient for your use case, as it handles cases where upper devices
> are in a different netns from psd->main_netdev.

Thanks. Went through the changes in
https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.com/
It is sufficient for my use case too, although it specifically
addresses the cross-netns virtual devices use case.
But the same net-ns stacked devices like VLANs can be handled with
this patch implicitly, without user intervention through dev-assoc.
I think both approaches can co-exist without conflict.
However, I am ok with using a single approach to use the dev-assoc for
the same net-ns use case too.

Thanks,
Kiran

