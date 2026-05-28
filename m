Return-Path: <netdev+bounces-292622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOrwFE0KGGpBbAgAu9opvQ
	(envelope-from <netdev+bounces-292622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:26:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2BD5EF90C
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2636630FE398
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CF03AC0D9;
	Thu, 28 May 2026 09:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DN6zNdZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DDD3AD50B
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959996; cv=pass; b=kDkJ9v636BF74kihNEn1c6VrVbiiEUrwKfXnMfy/TVN86uEmVkuU4FOzLBvlmksojdSfXktEDFEDlYEz2qs/FQ01Wh1UWVYnabgfxcNeTGYC8DAFm6ubVn/TtfVK4s/axbXKMfP+a8xPcyAO8mQqkurZVSoyfhgFSoWOaXrpUCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959996; c=relaxed/simple;
	bh=YMGDowVIWHUcKCvPkiMbj6S/iscqmJy4WRV1nhlAaYw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGcuAuDB9NWh+2kkqpqJGSJC7/0MwZK/s4tz2E8EuMynARQEJPA1dYLbnl9TC1TaVP80rilKEx5RvkuzpuM/IM0bhvDR1XVDJRyNTeEgepIN+K3ArIwHco27gtA6e5OlRES8GJ/V8mqkO1ixgD4Pl/C6WdyTWl8SsF1l0s7QiKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DN6zNdZO; arc=pass smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-6314a0eefb1so4039434137.2
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 02:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779959991; cv=none;
        d=google.com; s=arc-20240605;
        b=GdLVuFh9KC1BGDgbMhnFHHK6ITPwPD7a7ybt7HnTdkh/iUgQkVD6lJwaBNUHI/41OB
         oX6ka1olTKejBEPGtnoqwtBxE8eiWfMEsqIel0ZreV+yf19KKE6blJR5o8URu8p6Zqg7
         6QXZDNYHR8fhWreFryKvgC+zoOf+nzkoMVztlBERSfwOyOo5pO8sHguIK0YJotAe7Nbr
         MJsusXcjGUwNbD1A5EkxD1WiuR43UYcv7gFqYL7c+AiESXbrDOON0yDqRAtysaQfliBh
         cKBGk2q/7R9d+EwosKpWOZW6pSYPDUayMcnwLRQeu1wzXjTxbuTlVj+DfOE2UnzJhOFd
         W6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=txayVXYCXLT2HBeKEdgWlx8LMQTpX5PP05mpYRQ4FBk=;
        fh=Q7wniOIkwI7lp8IworcY4yZiL9XBNxOJnjC234WyK44=;
        b=Cw72nPxWj3hlYGkAEvP8iUKl1gK5gAYpWtQ/xD2KjYlFt/0C9RWU6TegRuziKpMQX0
         vNlb0ush+NAEdgOinbWG0hbvmf4zKv0Yxw72igH1bl/Nanave3g2t5zs04g8VTlHmWAC
         bRk5cInmPZIUF5mL0xcN+HosvXA4+zgpkODDh1DPsucofy+IG/+sRZwX2mu623p1bTbw
         9UWyFiYP9TIavc96dzts/E1fnAtSOVxmkPk6Rmk8wLUvGcAPuZMp2NiMqodrGWWVP2Gm
         B0/6qNDCW2X+p0KHOqPEbePvAwRx6OKOpZ8/SgdC4lGxNFhKhpR/Iie+FaZAvA6ZSTfd
         0YcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779959991; x=1780564791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txayVXYCXLT2HBeKEdgWlx8LMQTpX5PP05mpYRQ4FBk=;
        b=DN6zNdZOrh/8atzyXU0wcO+IPX+To+9Idll3rQ/r9LXdFggLcWwyJCYYwGALSeXE6I
         sgpkJIHdwrTtzUgBtxD21ngzxFpUhToVYHKU/Qzv3tfGzRWKaNC2f9hbE7BqfbsmXfC4
         xiDqP+zUF77928qZmtgCqH6/qXCXDYaImoCbkBnzD2Le46a8sd2eD/74MHNXFyPy83dj
         mtktOmUCXn2pmTo8wcD6p3nDsCeLO8jtBdaAQIHm+SwMTb1vcJsRniDUfwGslXpkrbiS
         vWEJvHDMIt1aMoIRw4d7dsvy9khhkdcnkxPhcouc+UMC/E73oucFOcfaP9jPr8xVBAGM
         Z9yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779959991; x=1780564791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=txayVXYCXLT2HBeKEdgWlx8LMQTpX5PP05mpYRQ4FBk=;
        b=iLldNX0Qu5LV20Bdc6xT1D6ERG4hhp8WXEaDYtGw1M4eOvHGDbuY/O7I1hbb/Z6R3Y
         cZwHItnLtjblf3DY3akEIy28Io2oAxAHeV+1GMYWz7PqDFBCvEYn7dxqBZSwxYVP3i0P
         Se+OgaAlgtEGhHfcCw1WW46PNWoltX5xV13HMqTwvZSaxbwDffwsne+6j995gQdNEB9b
         oP2Z+wHtPWYbFtTR0Z7dbuxNLpEM58SP2ETTw6sY+UUmpiraS3TpHhqqHxHVWhggiSgu
         WV/fl1b8d3ia74xhh9WgrG87d0QYJ9NCDOQHuiWJV1Z7EXsjJ6e2pi4TV6i4Nn2H424G
         mueg==
X-Forwarded-Encrypted: i=1; AFNElJ8ya1F3TIQtKfSjuvjU4moiFVy/gTAQoB6PZZZR99ctET9hrSk4owGihYTSQWKiZ8Wfsxx3HiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5BPi7Kcc85MIuB/iUJCQ3V+zQkRqaLHAsPujYW6xVvGgQsTw
	rS7ltPu5sBTusUV6D/f/TYmFow/Sq+xMQJwOZ41e3THNOLchX32Qsz4NNd5RuUossaEH0go/oKQ
	vv1dw6inG+B7kJBNNOPOSf27w4sv2ZvD8Jg9aNLM=
X-Gm-Gg: Acq92OFc3BiongzyCx3uusRi8tfTi6npyOV6NgbeABwT4WrXLlYGRyT1qr5V6ZTr/pX
	Qaxonva1d5YfRSVmn7uV2mkoqkHIlNS6vJLulA8VclCCSOLKBjTVM5H+8PiHRRno8R3ODXb08j7
	wxfxd6+qG7kpY5T7ghE0XWoRRI1UR1rPhV93jX/423Hi0K9o5Dtm0BUAVALcGdm6AOyiiBHNpnx
	aRSww0ksHHbLooi1mEqVKGduGXeyWxECYkRL2R+RhLl5WCC7cp4VZ0C7yKeHFHPJlFjH/eVRSXJ
	7EAy7Ka2BggiyzAnMQZIT8VZK3jmtm6bmi+prOaZ0GoX0dDRvnbg
X-Received: by 2002:a05:6102:441d:b0:5f7:240f:bbee with SMTP id
 ada2fe7eead31-67c7490bbe1mr11593956137.1.1779959990982; Thu, 28 May 2026
 02:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-net-next-mv88e6xxx-cbs-v1-0-c87a8e6bcc0c@luminex.be>
 <20260522-net-next-mv88e6xxx-cbs-v1-2-c87a8e6bcc0c@luminex.be> <0FB1CAF0-D30C-4A24-A684-1D1DBEE52FA5@padl.com>
In-Reply-To: <0FB1CAF0-D30C-4A24-A684-1D1DBEE52FA5@padl.com>
From: Cedric Jehasse <cedric.jehasse@gmail.com>
Date: Thu, 28 May 2026 11:19:40 +0200
X-Gm-Features: AVHnY4KNjKsD51cr7mjfRmCqjBjXbz3UNyTtPK6M6AAjTmXyoBLEKJ1e7p1BM_U
Message-ID: <CABvLYuBZ=U96gVpYqHnnhwBZxp8OZzH-W503MsbNd4JPqLbEpQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: mv88e6xxx: add support for credit
 based shaper
To: Luke Howard <lukeh@padl.com>
Cc: cedric.jehasse@luminex.be, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292622-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[luminex.be,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cedricjehasse@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0B2BD5EF90C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 1:52=E2=80=AFAM Luke Howard <lukeh@padl.com> wrote:
> Would also be good to add support for the 6341, which as 4 queues but use=
s the same Qav multipliers as the 6390.
I'll have a look at the 6341

>
> > + if (cbs->enable) {
> > + if (cbs->idleslope <=3D 0 ||
> > +    cbs->idleslope > qav->max_rate ||
> > +    cbs->sendslope >=3D 0 || cbs->hicredit <=3D 0 ||
> > +    cbs->hicredit > qav->hi_limit_mask)
> > + return -ERANGE;
>
> Other drivers (e.g. felix_vsc9959) round up and clamp, rather than valida=
ting. I would consider whether this validation is necessary at all, and/or =
whether it would suffice to omit the idleslope check and check only rate_ma=
sk. The idleslope and sendslope zero validation might be better placed in s=
ch_cbs.c.

I think some of these were the result of running the kernel review
prompts through Claude. Other drivers are probably from before LLM
reviews were introduced.

>
> > + if (!(chip->ports[port].cbs_active_queues & ~queue_bit)) {
> > + err =3D ops->port_set_scheduling_mode(chip, port, 0);
> > + if (err)
> > + goto unlock;
> > + }
> > + chip->ports[port].cbs_active_queues &=3D ~queue_bit;
> > + goto unlock;
> > + }
> > +
> > + hi_limit =3D cbs->hicredit & qav->hi_limit_mask;
> > + err =3D avb_ops->port_qav_write(chip, port, hilimit_reg, hi_limit);
> > + if (err)
> > + goto unlock;
> > +
> > + err =3D avb_ops->port_qav_write(chip, port, rate_reg, rate);
> > + if (err)
> > + goto unlock;
> > +
> > + err =3D ops->port_set_scheduling_mode(chip, port,
> > +    chip->info->num_tx_queues - 1);
> > + if (err) {
> > + avb_ops->port_qav_write(chip, port, rate_reg, 0);
> > + goto unlock;
> > + }
> > + chip->ports[port].cbs_active_queues |=3D queue_bit;
> > +
> > +unlock:
> > + mv88e6xxx_reg_unlock(chip);
> > +
> > + return err;
>
> This may not matter in practice, but SMI errors will leave the register s=
tate in an inconsistent configuration. I would consider having multiple cle=
anup handlers that revert the state to that on function entry.
>
> With respect to cbs_active_queues, my personal opinion is to not cache st=
ate both in the driver and registers where possible (to avoid the possibili=
ty they may get out of sync), but it is true that on a device with many que=
ues, determining the CBS state dynamically would be expensive. I would be i=
nterested in others=E2=80=99 opinion here.

I have a different opinion. The driver is in control, if these get out of s=
ync
you're having bigger problems. Either something else is writing to the devi=
ce,
or the hardware is changing state by itself which means it's unstable.

>
> > +struct mv88e6xxx_qav_info {
> > + u32 max_rate; /* in kbps */
>
> Per above comment, perhaps consider whether max_rate is required. Also, q=
ueue_mask can be determined dynamically from chip->info->num_tx_queues, so =
can be elided.

Eg. for the 6393 the documentation says the maximum supported rate is 4000M=
bps.
It could be this comes from the rate register set to 0xffff,
which is 4193240Kbps, and then rounded to 4000Mbps in the docs.

The 6020 family has 4 queues, but only 2 queues support CBS. That's why the=
re's
a seperate queue mask, even if CBS support wasn't added for 6020.

Cedric

