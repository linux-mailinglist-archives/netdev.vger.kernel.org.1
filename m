Return-Path: <netdev+bounces-252435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6O3HAqNacmn5iwAAu9opvQ
	(envelope-from <netdev+bounces-252435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:13:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B886AEDD
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 18:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA3031F7E3F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358733F22CC;
	Thu, 22 Jan 2026 16:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vlHYNMIE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5A14DD6D7
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769098693; cv=pass; b=Jk1f6Nkaas7aswWZYC1fCgjvpMqT6kZoMZfKT4K8dWO+4iFA4zaY7s2mlVF0hCWX/oZAuZJ14gjco9cRaOps64GKS5g68B0yFSgbGhIWVv9Wfxn/KL16n5W/qakaUNYDkygz8ZBOGKOW49Q6xA4+DaTBTuFLZfGp9eFHZ2pQog8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769098693; c=relaxed/simple;
	bh=4EcZlvqIrK25utzKAJDzkzB4IaMwK7OCW1fUm7993K0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=skGKuHLuwnuA+YYlmAzViw55xQ/6AKqSZIA7lPXdOU5bJKj7iR+jgK2s2yoIzzHVb/NbCECTTlNP1RtMvTil+UVm5kMLDo9ma9QBLOsm3eX8mdLx4S5ocvxgYYedVFy1D0tr6P6axuSUIhSRR80wJjyheklzrkWtMSQwJ1hdiN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vlHYNMIE; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5013c1850bdso9213541cf.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 08:18:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769098684; cv=none;
        d=google.com; s=arc-20240605;
        b=iRQKOrYalS8+lFZODR+eXzkLLi4rmumAi7Qv01CCz9qU0DaB32wgCsitiHwno+IZxE
         hhFl9RV52Eh+omu+osRdHsUhD6SC9UYjr+e9N9oXF4bACcqkMLyXnE//YVzCav97c2Gz
         YCyXdPPZdN1BsSN+ieJtGnyinIfZnMua4cX1nFxPfHoh0ix+8C7lLoOXRc3CbxUmbvCD
         uhqRg6HOXNoczjjxQdCDRhP/hwdsKPwgSSCfzYR+WR15NWWajPV5Jw5cR9fk2esPTR0m
         Xe+pGEOuAP9ClQ20wPIAG0Hjjyz3wGzsW7iI49ECdXt6/U1sC4Yh6K4xkCttr07Siy6d
         q3GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8mGUkSnoCMX0c5y8OzCg730s87hzIp9pHV9djN0CtBk=;
        fh=Ub7xhxnCa2NNvOtcA7qbnNDdZejV+2Y2Un60ylSI9Y4=;
        b=jD/YR0Z/PdV8ezMw7G/iE8+I+vaaQcKeNfH4cAiHSUZokITL5vFZd8lHSSpjUZIlyE
         ZWjq0eyTJl3y4CLE+FydgWi0JfPnufpSOVxN6K81bWk0P0rO72YagzfxqGci1EDCv3OA
         9GdPqyQirg26vKnnT1GEtoL0M2n1opUmO5wAUPLPemJhAw5rZvNIAUdAwJlFI9R9ksQC
         mMcgRi8bdVZKkr9YhoLmGHfGhId1YoBV2KCkhpqXeEsd4x5JxM8mjYhSVtMq5AziL/lP
         4NNJuoYzOor7ukkh6VU94+tFGOkIRLnDAVR5qfjSmDfhcmndNM4+BuNSuaoc4QGPsf7P
         OGWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769098684; x=1769703484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mGUkSnoCMX0c5y8OzCg730s87hzIp9pHV9djN0CtBk=;
        b=vlHYNMIExU72BI7bhNfnyVgnxqZvbDXJvXw88XHdko4fy3mtCs9irEy5vpQbdYAICb
         MSbKgAmfebL6tEwflZb5aGAJXwyfF+1E8W7socdKON0l+3ppRz1au2GIze6eN5QSKfrr
         wqxQLwHblqa81wCAZlBluXLRkiWexVhyZG/P7AlN2xwnzoqLVnK1RBOZec3knFpB4IZP
         +78IG/il9qMvuJX5XNLSXbMwswdEMPtrXsdQZY2sL3/89WJrv8diqOGJx9FwNjNzAieO
         NEDKWks5qiif2wIVlDs8rolQmdjLncWnlfFjwUcvJhPAf6Ew9M/nuRzLQfLbqx/RWmyD
         SdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769098684; x=1769703484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8mGUkSnoCMX0c5y8OzCg730s87hzIp9pHV9djN0CtBk=;
        b=uzSBBNHG/G31vSOz737S6kiNkVXiASQBVuS9gEs32qS9sJ9tgY/7F6fh4FA5mOrY7y
         qO9Xhrzygq0UekssTyVOvu9q6mhh6kBZWRM27U23qHqMSincQ4PMqa8MnoGQky997wRJ
         VxkUt8agljLgmwZSVynxL2oLhEGJDHFH2Kfba0S0EyJVl6vcRHIXpTxu86LDf+TsEBl2
         aXqU0h0I+8svJ6tS32l9QXxD1N4EkAUVG3k+QhmPTFRMQF9x9o8yBsvRURS9Fk/Zu6L0
         XqsB8S5VKirDz3JJIKyaFGiXddOPksrFF74mI3tO36KA+NCVESnqd7abKd6OkOwSATcV
         jBlw==
X-Forwarded-Encrypted: i=1; AJvYcCWQUA6OXTbGT6moC6NZz9ZrSo7EMD8IkHtpelxOtwk0Yr5ZO9xgHRil/4T7j0GdQxKyM6Vc1Qw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrI/DLYykTTnBlHN0cAi0LUOiONEibXl754A0ThMfhG42r7tRp
	9gBds8AIcHiHh/B/ejV5QNqWdfMpq0Jsfmi0dg1TnX/NbvuMMx8ok1dIq0vI7Ct9wJFVOeIiBHG
	yXMqBzl9BKGqfDqPVAGmAGN1pRxcQeljyMjX3r02K
X-Gm-Gg: AZuq6aJp787dSY8klBwPRQXX5XnUbfTJHBBIed4mD6/gYM3VQl61nc371BHiAKGygn8
	XVAbOyw0V3sb7ObfIs9sa4Od2HhRFkJaxMwt1s5eJYMKQc6EWFA/vdeFS/musMLtYyZ0AuqmWQs
	7OJOYG5r64IrhMHT0Zl/Z9pmRFeCkiTpeqndYoI255eCzPkELCVSm5220EDAI+5VC+xtZoe+XV/
	nGdM5gf8tHnd0r96knB/cjxzm6SQRAM5WPFH9gjv3nTbR9/4F14xz4EfDfXcI7Ze3DggHnm
X-Received: by 2002:ac8:5fcd:0:b0:4ec:f697:2c00 with SMTP id
 d75a77b69052e-502f779b7acmr687831cf.42.1769098683855; Thu, 22 Jan 2026
 08:18:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122091527.339180-1-schalla@marvell.com> <20260122075206.504ec591@kernel.org>
 <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
In-Reply-To: <CANn89iL5s+egLhothNtnQf0jtAeftezUjNmbuXtUWgfVV3+bzg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 22 Jan 2026 17:17:52 +0100
X-Gm-Features: AZwV_QjFSwZ3BduD3JW5Pi3e6oTuS7B3XfiVwuw9sYCVXAr7yfIwzrmnPKTOoXQ
Message-ID: <CANn89i+e+eawQVvmVuA7jyZ=DCU+wPq3z+q6_PoVVY7ZhX2UGQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Increase RSS max key size to match NETDEV_RSS_KEY_LEN
To: Jakub Kicinski <kuba@kernel.org>
Cc: Srujana Challa <schalla@marvell.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	virtualization@lists.linux.dev, pabeni@redhat.com, mst@redhat.com, 
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, ndabilpuram@marvell.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252435-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[marvell.com,google.com,vger.kernel.org,lists.linux.dev,redhat.com,linux.alibaba.com,lunn.ch,davemloft.net,gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 61B886AEDD
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 5:13=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Thu, Jan 22, 2026 at 4:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 22 Jan 2026 14:45:27 +0530 Srujana Challa wrote:
> > > Increase VIRTIO_NET_RSS_MAX_KEY_SIZE from 40 to 52 bytes to align wit=
h
> > > the kernel's standard RSS key length defined by NETDEV_RSS_KEY_LEN.
> >
> > I've been meaning to bump NETDEV_RSS_KEY_LEN to 128 or some such.
> > Most modern drivers can't use netdev_rss_key_fill() either because
> > core generates a tiny key. And the devices support hashing over two
> > layers of IPv6 for tunnels.
>
> Seems fine to me. Back in 2014, RSS was limited to 52 bytes on all known =
NIC.
>

BTW make it 256 bytes. 128 is already too small.

> >
> > Willem, WDYT? Is there a reason to keep the core key small?
> > Or deprecate netdev_rss_key_fill()?
>
> What do you mean by deprecating it ?
>
> One of the ideas was to make sure multiple NIC would share the same key,
> for some bonding setups.
>
> commit 960fb622f85180f36d3aff82af53e2be3db2f888    net: provide a per
> host RSS key generic infrastructure
>
>
>
> >
> > > The virtio specification requires devices to support at least 40 byte=
s
> > > for the RSS key size. However, devices may support larger key sizes
> > > up to 52 bytes (as reported by the device's rss_max_key_size config
> > > field). This change allows such devices to work properly.
> > > Previously, devices reporting rss_max_key_size > 40 would fail with
> > > an error during initialization.
> > >
> > > The driver already handles variable key sizes dynamically through
> > > vi->rss_key_size, so increasing the maximum limit is safe and
> > > maintains backward compatibility with devices that support smaller
> > > key sizes.
> >
> > > -#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
> > > +#define VIRTIO_NET_RSS_MAX_KEY_SIZE     52

