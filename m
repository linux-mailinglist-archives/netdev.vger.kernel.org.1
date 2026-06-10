Return-Path: <netdev+bounces-297562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Et9jHgktKWr8RwMAu9opvQ
	(envelope-from <netdev+bounces-297562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:23:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDCF667CA0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:23:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pk441WcU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297562-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297562-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54856302297F
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 09:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8743D9674;
	Wed, 10 Jun 2026 09:15:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F094F3C1082
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:15:50 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781082954; cv=pass; b=M/thYjHfgptECNCnHleQHtzI+AvXZjpJkIbGpHdZd3gH9nnC8MQijbo2orXud7xXxk3W8Q3AG58ITOG/IAtF+0uhZzrY3LGApnEYw/H8oDkwUJ2WAdTUqbgUU2Wval0wsdaUgs5luznysbX9pXeA8qvzC20bKuxcFVoLLPHZJaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781082954; c=relaxed/simple;
	bh=dkWTevOEzDTMmxDai2XZ5/ake5l927UeEL0MaDVmHek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lgB0c7+ivOP/RfDjqAlIVRFhiVRNPyVsG7z9b9p18lbakUuj6WemKenbOzZVPAONuGp6nq+KL/8XJjbjdYp5TOh3uP/PK7fpZVHCDPMcgYym7icuy7qk289iXdxE07M/2j1uE5UFX4FeVVEj9iR7NR7O8bwCvQWjAUs/SwJQ6lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pk441WcU; arc=pass smtp.client-ip=209.85.128.193
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-7de68222e96so60636447b3.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 02:15:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781082950; cv=none;
        d=google.com; s=arc-20240605;
        b=Seijla8KYaC8N24U1K/b8IIBZZnrHWlJItXRR/mysV6uHK6HgEZhnQFbtmaldxvSrh
         fgiwO+nTKLcJ5wuaNEjeJDYqwzlBSNuCjuXhNRTz9B9zYLRN2ung0qCct8+GwtBqtXic
         q6xsgRM+LuK7Kt5MoDJYWYyD2MUCgJEFxcww6MvHhO58VOfuTgY008tLEMFkIVzYfhV1
         rM4Sok8RxOL6mWir0eRryq5LWrzJUaA0opH/WaZB6IBcYK1anVXeyZkBpL3f/9A+Fz84
         VcbgzX2u8TwobK5aGLdgi7S+lC+WpqNrnh4Y0KIG9Zy8vuF833ifYAFJol7/XgDZht7I
         sXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Vr1lvCHUXqA8wl46L5q/dYr6UTfHd+/3UQsnP1BtFs=;
        fh=473ofnK6QaZrjJJKdjzE3qWFq015jpZK5tyPcVTxS+E=;
        b=D+O0lri1keS3hQcgRZ0Siun9+Ghf8vtDZVtVpp2z4Ock2AY9MFbhkovC6QAO7mqJz5
         UFJfv7YASd0I2S8IFsE6KHc+aKojQL0vboIbCzg6AHLbbl0L7Z1Yq/q44PoNNut+GIAT
         krLixjPpASqOXwJrrCmDzHFx2mRAfEg4VQ+xHr1G2mycPWYwzdIBJr/uC8QrfbC0rXoQ
         7jJM3j9IUnhRpj4TLHt097dd5C+hqstjh2WEdLapG2DXub78TMHZCyiYPtuI9Nvr2d6f
         tkQrvV1Sj9cKpG6U9RdX7J4gQIvPhx8LqHF/58umbyh0yF5pr3Kmvpn/tRgpzmM6RicL
         dNug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781082950; x=1781687750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Vr1lvCHUXqA8wl46L5q/dYr6UTfHd+/3UQsnP1BtFs=;
        b=pk441WcUPLA3ma3sVTWTu/7YhEpgLBNtx+7/GOBko+KyABEYzLZY/H3foF2ZYji0gg
         NbxuokUIf3qbHUkCe5gUrHJZ/64NyNpblhbQr7bZwxWcWCrzcfGEs2lrbtacxYpu5N4G
         GzUzCTIaKMIvM+vlXPURZ1G4KbIi7pvhRVFn26fi47o22CW2FPAqetFdND3bc1R0KFCJ
         xm88q8U0FHcEADMSYvoMZB1MKm4rM32a+OriS2t9PMGK081yqqvK4sA9kxEBPfhgm9Pf
         nCbW6D5q3oiGqhb7PuOOvXyWQdKimDnMN5GIkbZRUi6VVawulEWR41cqdEOK+dUnUaFD
         6CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781082950; x=1781687750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Vr1lvCHUXqA8wl46L5q/dYr6UTfHd+/3UQsnP1BtFs=;
        b=U42hQ8gedQVvw5xSOSmneCP7xLrfyfohDs8hP3Xp0pQU/MJAtdU2pQ4hXYvKwjVtPy
         9Z1CM5ZYmvlJQcEUT6XWwaYQAtgZ8RixdOIffuS2Sky7BS8FC38uAMATZKuJceXFFBWF
         altcYrbINvI+2846N/KwojZlpDUrkKQmDdr21Q/KWKARf2Wq3AvZDGNRyMkzign1MhxP
         VRAx/TCGzwqNiGOnxSAc+JMeLdb2mAqj5uHhs7CIWtT/5pzqq5KA/Kna8NntZ+J6gQF0
         szSzP4kEahcl9z2IaHC4TmRfJSxW+kizSiRGGeXNqwHtyuL4UQaUcNJlcqcmj9k4AD94
         J5Ag==
X-Forwarded-Encrypted: i=1; AFNElJ9JlA+gTEGcowLQOP3jwDwwEx6Y5QGsT+p6fFRJMPTdWLEpfPAa1RPv/0ESKO2kfQoLGQVBcng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlO+j8SVJbZOF0DM2SxHebahj2mU4jvAiChGGTd8UI9UPtR0al
	Wkp6G+nWxHaFJwQwoZhSnRhrMZNKqOBkEXM9ibB6RUtyB/azvfOPHJLdOaM3i4+QVDiaqK/Cb1o
	wmxv/32uDcMnOkGJc/Elkdji+9exrl4Q=
X-Gm-Gg: Acq92OFmfNKiqFbdS8Q12mvT4EBrInNHWMjxraTwa0+0qpT9GIyNevxbOBJITTzycT+
	6IbT+vkO/ngfC8qne0U/Cv5Mn1m6kqmC6BNY0qyWnQkugukbWXCNuTiHCPoYiwCBZFdyobPqX6p
	I4FvPzRFrv1kHmfnVyE8OdCHKMk++JCq2NHcInDvDJ+ebM2px7QXLWXken3uddqCbN69fUrZou+
	QTcF8CPj3TBbwrc0xtdEvkLvMc8i5dXfZhGMvf5GiSExvQBMItb/D7c2V2qB7Xza6tmt7TDERa5
	otaA8Msirz+mh15LHePb
X-Received: by 2002:a05:690c:6088:b0:7b4:1ffe:f9f9 with SMTP id
 00721157ae682-7ed0d5c0168mr228901987b3.16.1781082949719; Wed, 10 Jun 2026
 02:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610081648.2205711-1-dongml2@chinatelecom.cn> <CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com>
In-Reply-To: <CAJaqyWeYiruNosJsMTh2jQ=XCEcPg7956aqeRRpDSyynfpjNZA@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 10 Jun 2026 17:15:54 +0800
X-Gm-Features: AVVi8CeKeNx-GTsiC8xsIcnA6meI4tsNjbFnxar3BDX9_eDtXkvFWK2nbkQsqV8
Message-ID: <CADxym3ZVfwg7t96Ct20pnZdm9tTvpCypg_dp3f+3aj1TL2argQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio-net: support xsk wake up
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, jasowang@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:eperezma@redhat.com,m:xuanzhuo@linux.alibaba.com,m:mst@redhat.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,chinatelecom.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BFDCF667CA0

On Wed, Jun 10, 2026 at 4:28=E2=80=AFPM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Wed, Jun 10, 2026 at 10:17=E2=80=AFAM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> >
> > For now, XDP_RING_NEED_WAKEUP is not supported properly by the virtio-n=
et.
> > Take the tx path for example, we set xsk_set_tx_need_wakeup() in
> > virtnet_xsk_xmit(), but we didn't call xsk_clear_tx_need_wakeup()
> > anywhere, which means the user will call send() for every packet.
> >
> > For the tx path, we will call xsk_set_tx_need_wakeup() after
> > virtnet_xsk_xmit_batch() if sq->vq is empty, as we can't be wakeup by t=
he
> > skb_xmit_done() in this case. Otherwise, we will clear the wakeup flag.
> >
> > For the rx path, we will call xsk_set_rx_need_wakeup() if we have free
> > buffers in rq->vq.
> >
> > Race condition is considered for both rx and tx path.
> >
>
> I didn't review the code itself, but the patch message lacks a Fixes:

Yeah, you are right, it's better to use the Fix tag here, and I'll
add it in the next version.

> tag. And the From and Signed-off-by emails don't match, which I'm not
> sure is valid.

Sorry about that. I use my company email in the SOB. I used
my company email for the From too. However, my company
email system can trigger "Delivery failure" messages sometimes,
and Alexei said it is annoying. So I didn't use it for the From
and removed it from the CC since then :/

Thanks!
Menglong Dong

>
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  drivers/net/virtio_net.c | 52 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 45 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 9b3da9f9786c..25e895b849a6 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
[...]
> >
> > --
> > 2.54.0
> >
>

