Return-Path: <netdev+bounces-275232-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBKXHYU10Gnm4gYAu9opvQ
	(envelope-from <netdev+bounces-275232-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:47:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C74163988C9
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 23:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B4D03013259
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 21:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D082D322E;
	Fri,  3 Apr 2026 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s7Ba2YpI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AFB239099
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 21:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252866; cv=pass; b=u7Ak+8u3VX2fp8KW46ZaksRWBVy/D16gksp5oXUWdpfg8qzvPFTwa3LGJsG1p5t+kNrpWoO4t6nNAtxmbWaVQvGFoJE/h7oNgpsvKpZeT5L4EjvgERESJPwN5B70bWbMHGE9kkWZzFAVNzZnEukFwrD6aWlyAVMiglciKC7Qic4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252866; c=relaxed/simple;
	bh=rrfs/YL5TsgXi7oI4zIr4HzAlSvSh4fPIAM1Yns8oVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxMD26osUgo22V0lzuYh9rj96HTepSAahbmoKiHcAFt0j6jYry1r6blj5MgeW9oHN7xCUXE5EOIHnD/AB25MaTZFdQMiHwaWi96TZiVN2mA+kkJ7uYi/u/DUm5TGqOYCHwihNt+WHeoGnl58/ZjDLWXzu4dapVMLdMzN7dfjwk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s7Ba2YpI; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8a210c813f8so20060496d6.0
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 14:47:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775252864; cv=none;
        d=google.com; s=arc-20240605;
        b=DWbLk6Qluh/Y5nbImpRwVg+aE8BIGzkWXCPck0BGC7+fgvLrDxxvL9oSvbZDJRTCG6
         dodWI8dOXuGpVO8fkl9OmNMqVCDMuGpECEoSCNnDjV70jO2esXqCJjjfEdmwM58lLVi6
         f/VtRxgZIdsCwJRWzRJTOnpWA/shs6Nrzw58wNtfrVxf++tuFq+ZVHmQCOZNO5u4kVyM
         Pjj0/kUF3pxDZGsNCSuBSMKLMT612xg++G9+fBJYbh/F4D+cl57K9+hXuPBbMXV0WsIq
         X2hH4V65y89kDbrwSa/7xuatkQyfAoFkSpNFUzbrPyjJ3N4qFvNLXBj0pGeIDwGqmjGa
         ZyJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CxR/Cuugf+0OPArzP9HHfAZgj9CKiGDx9/bQF9V9BZc=;
        fh=G9tevLwhIKPct4euo3vesEAowsmwmy2l57HCRSBRN2g=;
        b=hgfJCKBpJ6LhNROpspuVyNC5s57scsRBXUmbWdvjnVy/mCGIzngV7lfXtD3BXPH8Wd
         MKrlDcS2JYZOSO8vfmiKcz29qKwRwshibxt4YvPwuqp3KOwDvJIK53zIYPiE4fkcUh0e
         0kCCVlDaehmvr4vxDt9nSRPexDpPRW4MKATjiV3EZLbAUvI4oAacMpe26iaLXpa14o0n
         lPct9u1/ZWzwG2GY+v90TUSCmv8RrbvjFdQEEOfxavfWemcQTsw+pn6OSsGtBRGl4YXx
         5acEb5GHAY8xytpM/78u7td3ZPnsFRhEYH9SyKVfcQXYZJ5/NrcNaU6lbOaXWnxIfCTf
         Hz6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775252864; x=1775857664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxR/Cuugf+0OPArzP9HHfAZgj9CKiGDx9/bQF9V9BZc=;
        b=s7Ba2YpIEjRVHGmToy1FUIu3IFp6tCwrPJrIhNeDWu8WG55lSlnqfDTZerI1eZYipL
         oROrfOMIT7FNj7FoubvljqaFszcWWt/SJhm9AQOPL00Ea/UKqFLLnx9L4tUgi21upEye
         E1H5VRFjfGswOk8wjGj/BobTXgrWNmzzgj3Y5O1b6w3oL/fPYTeJQQu/g8Kt1YSzV917
         g+9JDnPGIw2M4IKTs7/ZZmZgsAz0rts+IGENDOYN/7z4FPJ/DZ2p/kJ/h/gEcEt0oJuc
         rrvMBG1wDo8jTzu6DE1VdqHVraVNa3z/HCykS998oH1q5zEmF041buN1ySL66MFMXqvP
         Qf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775252864; x=1775857664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CxR/Cuugf+0OPArzP9HHfAZgj9CKiGDx9/bQF9V9BZc=;
        b=O3H7yfU2iIJojXuyTg+Ddf3Azt74CEs/++YN91Et9gQLmcf+2Y/w0zFmtkJDdq49iD
         Fs0LuY8hcEbVwHdFAOeq3g3KezgO5qOfzK3I8KRnAsfUKfYncuaxtWffyws2ZaE/twtP
         pGHi8i/zOxews5d96SSzwKhrY7jN5oQK2uuGSQ1XsgnZtBX3++xI+OS4GyCNntOeL2pL
         H7c6hMqidXVubRd2alyZy/aRl39Go1YkuH9xr+qs/fyJ+v3n0bViSo8k8YJnwiWLlepp
         7OhAqD+9q8vUYxxdiXSt332xdykoZCCl7LIXOV2nwCULdVNb8QxS/J1ANa4ExFqaDiYc
         dI6A==
X-Forwarded-Encrypted: i=1; AJvYcCWFWSVl81bS3Mi0ZKd1JbJ4BwVWihWcEiORaeIk9SGBJFPKa/Ii1F8O3zozaTWo+pPfTeBbNrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqIVDmcIDtzHemK34YR3pOIMCx+OzP2efqmkI4/S04b/CSIpL+
	C4VY0cuXUw5MCrgatxQBhUzS/9FTKn8haVFcN5OJYbzCnevxMNgnA/95yKcv66Xro26QfkXRTd1
	saOaWXbu37vV2TRvJikxrOKhNIjXYrdCm3qytf95K
X-Gm-Gg: ATEYQzzUisawMbHM5GNYWhuNZpY9AOs8W6++Tvy0M07OUJzwT70Yn7RUkgYssSJVMVx
	h3qGlXpVr+bYMq5QHP7aSW1ZNMLVblS0MU983o4OFYRsy0OALpnDqFU1o1APOmqss1MAJRcmDVq
	yYwxXpVVn3w/y2K7B2P92N0ii1V+ydWV0vJc/9LipZVcmXIEkjI6CLHNzB9EYRYzvQQmctr3HDC
	DwUkBJOL9OzKe8Tt/MR+6eVdTVkjK2ZO0aE/mz0xGDemKdaiQhHHdTKKtMTz0r2G4m46hL3lpKQ
	LoxL
X-Received: by 2002:a05:622a:5c89:b0:50b:1e5d:992b with SMTP id
 d75a77b69052e-50d62b53accmr68316241cf.54.1775252863604; Fri, 03 Apr 2026
 14:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402101732.1188059-1-edumazet@google.com> <20260403214418.2233266-2-kuba@kernel.org>
In-Reply-To: <20260403214418.2233266-2-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 3 Apr 2026 14:47:32 -0700
X-Gm-Features: AQROBzBP7pKx_JuXRO1Euo16qN8dIocVVT3g1PpR3EVfF03ayC6XDdQlwOiXLcA
Message-ID: <CANn89iKUKTYZ7NVNidtdssZXUAa95LmRpTYUQ29uGE99jLmLOw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	yimingqian591@gmail.com, justin.iurman@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-275232-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C74163988C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 3, 2026 at 2:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email says "more bugs to fix.."
> ---
> ipv6: ioam: fix potential NULL dereferences in __ioam6_fill_trace_data()
>
> This commit fixes potential NULL pointer dereferences in
> __ioam6_fill_trace_data() by checking __in6_dev_get() and using
> skb_dst_dev_rcu(). It also adds missing READ_ONCE() annotations.
>
> > diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
> > index 3978773bec42..05a0b7d7e2aa 100644
> > --- a/net/ipv6/ioam6.c
> > +++ b/net/ipv6/ioam6.c
> > @@ -710,7 +710,9 @@ static void __ioam6_fill_trace_data(struct sk_buff =
*skb,
> >                                   struct ioam6_schema *sc,
> >                                   unsigned int sclen, bool is_input)
> >  {
> > -     struct net_device *dev =3D skb_dst_dev(skb);
> > +     /* Note: skb_dst_dev_rcu() can't be NULL at this point. */
> > +     struct net_device *dev =3D skb_dst_dev_rcu(skb);
>
> Could this code lead to an out-of-bounds access of the dev->_tx[] array
> further down in this function?
>
> While reviewing this patch, a pre-existing regression was noticed when
> trace->type.bit6 is set:
>
>     if (trace->type.bit6) {
>         ...
>         queue =3D skb_get_tx_queue(dev, skb);
>         qdisc =3D rcu_dereference(queue->qdisc);
>
> When is_input is true, the packet is on the RX path and skb->queue_mappin=
g
> contains the RX queue index of the ingress device.
>
> If the ingress device has more RX queues than the egress device (dev) has
> TX queues, skb_get_queue_mapping(skb) will exceed dev->num_tx_queues.
>
> Since skb_get_tx_queue() does not clamp the index, will it return an
> out-of-bounds pointer into the egress device's dev->_tx array, causing
> dereferencing queue->qdisc to read invalid memory?

This seems a different bug ?

I mean, do we need to fix all bug in a single patch ?

