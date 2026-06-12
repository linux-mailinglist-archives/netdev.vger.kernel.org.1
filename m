Return-Path: <netdev+bounces-298422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N1RsOVRcK2ra7wMAu9opvQ
	(envelope-from <netdev+bounces-298422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:09:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E6B6760CD
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 03:09:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=HoMITiJO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298422-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298422-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E61E031D5C12
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 01:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8707D30C14E;
	Fri, 12 Jun 2026 01:09:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3257306776
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 01:09:36 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226578; cv=pass; b=q+7dDGH5nx1HBjgPgilZo3s2oj/idilKi7kkB3cEAVcUgk+kgRu8iLec92Qg/wfrvYT3/C910J4voUZ7Y66Ui7cbNu1iIwr3LGySy4WaGQdjZq71oUJ7LixSBgzvJTuYeS2Ld9yaPZE1GYKgoaKrrwbXGmqZ4JXrSLc5KSRyOco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226578; c=relaxed/simple;
	bh=9gi2TnyLTtIq3LPG+G/+Ly7DV11ab410M+WEj0lWYhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0BbNmAJVqmuXWbsNvodIUC3im02eB+0XvhI40iY6nXu/0fmGL5bMeyisgPBBgodHKtcq7ZPOKS1DLYB3aSR2o30kKNFNiYqQulyUa21BGFr6GLkIq0KPy3VSyxmBzPrYvwQTb2zhu/Q/0myTqd8IMlIuETDgg36KnZ2y89ndWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoMITiJO; arc=pass smtp.client-ip=209.85.128.196
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-7dbcb505578so4644187b3.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 18:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781226576; cv=none;
        d=google.com; s=arc-20240605;
        b=hIHTLnYA7nLYJf/1U7Jzh5wtI5DN+qsh/TpjSsfSsDBARPFHJEoPu3FYc1Zoz6nEch
         mbtbCzjcX3E6+/P4N0mNUPfseX1oH9SgOopIHajaPW3TCFs9hjTQP9+2mKt3HGuNmy97
         tlaXMR2Fu11/1Q0Yos1v52Bl6idEpJ3AcrNrPJCNMrwr1N7JAvX2GHbVD43bX5GpZYre
         0HKVXptS7ZRhZHD2RTdPACmoxBAyQAj7cXETMS8gzHCrk54/FynsZad894otby/37ZQw
         IYoBnujalM1u23uOZAN4f6dTCOuKvoZQbZaV48Jj8KsgavdXLKU8gJWjs6WRxrYbcC5w
         XSTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2bgbKh1ieMb+0wJeVI6j8Crjj/CHbtDXar3nNWZb+WA=;
        fh=OTTqDeHoS9W+mK8qiaGOjMAWXVTV8tZ/KDGAlLgU3fM=;
        b=elifMZ4txVZF8er4b/VgGwj5nT392zigTdIQ3xbrHO+hCISmwpYP6Zf71TbcqssTLj
         HSa6zjC0GG/q8aUW32MQTwzG/hFlN9M+x58apzFnUNdZtFag2zvJHyuxcI4Wa62ErGDC
         MD18TLD9SWCyPFXP6IuAc3c95xRceITynnBV9TTIWrRnsEAbASEIqHUHJiDsa/WzLgFY
         KGpVaXTP/SD3DrgDc5vgH3+BiI73hQa/2t26i6qMTlTQRhqNm5xmZNLJgrv6sZ4ZrFor
         loETQf4NcIFWNKolJefPmgPG+ADiAfk2JHLhIS+RIAfrOKppTo12rvT1SIUtog2QEGy0
         VDQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226576; x=1781831376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bgbKh1ieMb+0wJeVI6j8Crjj/CHbtDXar3nNWZb+WA=;
        b=HoMITiJOeAjZWLDIRpHf4JkHIMjvzp213v8BBhbfEyog5/dTD3TwNqE9rzn5op+cih
         jMr0LjEOPB11k7ZzAlYjZZgUEHuZMjuhTEV0+TWX/eX3a4lBHWGiqf7XIFi1THBX4m5i
         O2R0U5lStbEXFBKp5JCV8Lm/MMASI7qAr5H4ey/Je6B9xEvjxCXjRSD/dm+BwRZ6VTUH
         wMjJtXFkxD0YXO0wfBqmm7BGMMvGePNll5/d/mfozzMTJanE9LQzBGXFCjRaQ0rGNyEv
         9SaPH+p+A80MF92owNPppm05ngz3CBHwKC/fyJHeZgV0AkKt+hDQWkX7I+6ocTxipkoV
         kprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226576; x=1781831376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2bgbKh1ieMb+0wJeVI6j8Crjj/CHbtDXar3nNWZb+WA=;
        b=lSnTy9d25QyzQ1QgYtJf0Z7zldi6UIXGoe1QpW2aJJN32Fqzg3F3IBhEmamaYkS8b5
         3KY32OPrCGBt1Gu7q62o03r6ao2vTy+CX0sXwzWM14dsPegvH9M8Ht3r+muCP63cdgxr
         yJXKmorJfrJSkrnzcbveL4bmRMkFHK82QQDwWNoqhe/4ULnxiTfChsdjsz6HdTTIrVLk
         c34RfU2UzLmtxsWzp0qRbNvSGb+/JVqkkU3PmrzmHKq50OTnuEVnISusfG/gKmm+uzMj
         8sKmm8/KhZvpQ90WmHKNSOEyKUOYwU10MZQP5El5iC6brruWsrhnXsV3Vj10oUX9IOd+
         q+iA==
X-Forwarded-Encrypted: i=1; AFNElJ9gjwW+WHvwHQor92p4Jjry04ONsy0yzvbIi68kTOmggWXQHZAZAtckk8ujwRynZEgzfUTHfSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYbmps4XSqkBlQDXIqnz4Yklcz+pOYzPSPFqLPaKRsKGBW0A9
	DTAjWZdOkzQRhAExoGTB1be1BB3UVHKTioPEFt27LU9bJsRTnUGc9vIgp7zxtXMY66DnbIveRJ8
	UwxJH5SyiP4i0hcsaGR5TimOwf77mUCk=
X-Gm-Gg: Acq92OFHy8DXXJEP3dZt+XgIccCZSjN40S5IC0W/VerwmeSzDF3llSUa/e1ZduzFMuI
	p9g2HhUybNcG+YK0YKejcJN1oxVGqPMdbTYRVq+CeLjq+BfELwIptYOe5nmn5VaNhCYe39UevlM
	fvqPqgm3HXjdn7OW8+ZVdpWNrfo2N2zc+5dcKfw0uEGdtzvkibrnk67eXdDscH6KXIdOBJ2lU8o
	dM/a5i3+R0qysqWBwU0XOy3Dh1Sc/jFlyAyUr96cJrq7pPhEvuVDTYophcV8JNuXpbCp6oUPxMQ
	PaHfmJnFCQ==
X-Received: by 2002:a05:690c:63c2:b0:7dc:7ccb:33a1 with SMTP id
 00721157ae682-7f7b862ebbbmr7194657b3.23.1781226576049; Thu, 11 Jun 2026
 18:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn> <aisBEUmSJa1vkFYo@boxer>
In-Reply-To: <aisBEUmSJa1vkFYo@boxer>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 12 Jun 2026 09:09:39 +0800
X-Gm-Features: AVVi8Cem7Z_iAE0cAcLpfhNtsEYe4ISMI5m8TQRa6PlH_Zbru4XArHRge9Hviwk
Message-ID: <CADxym3Y_2NPr0ktHxdgh6NKd4xnoq8TrMYG=QRMdhm9g2Q1zwQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] xsk: support tx napi busy_poll
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	magnus.karlsson@intel.com, sdf@fomichev.me, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	bjorn@kernel.org, kerneljasonxing@gmail.com, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298422-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:jasowang@redhat.com,m:mst@redhat.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:magnus.karlsson@intel.com,m:sdf@fomichev.me,m:horms@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:hawk@kernel.org,m:john.fastabend@gmail.com,m:bjorn@kernel.org,m:kerneljasonxing@gmail.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[menglong8dong@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,google.com,kernel.org,intel.com,fomichev.me,iogearbox.net,gmail.com,vger.kernel.org,lists.linux.dev];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 40E6B6760CD

On Fri, Jun 12, 2026 at 2:40=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jun 11, 2026 at 03:12:39PM +0800, menglong8.dong@gmail.com wrote:
> > From: Menglong Dong <dongml2@chinatelecom.cn>
> >
> > For now, we use sk_busy_loop() in __xsk_sendmsg() to send the data in t=
x
> > ring. The sk_busy_loop() will poll on the target NAPI. However, for the
> > nic driver that support the tx napi, such as virtio-net, it can't sched=
ule
> > the tx NAPI, but only the rx NAPI. If we enable the busy_poll for xsk a=
nd
> > use virtio-net, we can't send data, as the rx NAPI in virtio-net doesn'=
t
> > handle the packet sending.
>
> Am I reading this right that you decided to break busy-poll support for
> zero-copy drivers that happen to handle transmit side from Rx NAPI contex=
t
> in favor of supporting virtio-net?

Oh, nop. This series only has an impact for virtio-net. For the other
driver, the logic doesn't change.

I added a "tx_napi" field to struct nap_struct. For now, only virtio-net
will initialize it, as only virtio-net has the "tx napi".

In __napi_busy_loop(), we will use the napi->tx_napi, if it is not NULL
and we are in the tx code path(sk_tx_busy_loop), instead of napi.

Thanks!
Menglong Dong

>
> >
> > Fix this by introduce the sk_tx_busy_loop(), which will poll on the tx
> > NAPI if available. To get the tx NAPI from the napi_id, we add the
> > "tx_napi" field to napi_struct, which is ugly :/
> >
> > Another choice is to call virtnet_xsk_xmit() in virtnet_poll() too. But
> > this a little contradict the design of tx NAPI.
> >
> > Menglong Dong (3):
> >   net: busy-poll: introduce sk_tx_busy_loop()
> >   virtio_net: initialize napi.tx_napi in virtnet_alloc_queues()
> >   xsk: replace sk_busy_loop with sk_tx_busy_loop in __xsk_sendmsg()
> >
> >  drivers/net/virtio_net.c  |  1 +
> >  include/linux/netdevice.h |  1 +
> >  include/net/busy_poll.h   | 41 ++++++++++++++++++++++++++++++++++++---
> >  net/core/dev.c            | 23 +++++-----------------
> >  net/xdp/xsk.c             |  2 +-
> >  5 files changed, 46 insertions(+), 22 deletions(-)
> >
> > --
> > 2.54.0
> >

