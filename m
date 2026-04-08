Return-Path: <netdev+bounces-276332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEV0BQwI1mnbAQgAu9opvQ
	(envelope-from <netdev+bounces-276332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:47:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF533B8869
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 09:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93547300B3F7
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 07:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8946F38F94A;
	Wed,  8 Apr 2026 07:44:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72438F926
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634290; cv=none; b=LC25CylFPFF+OAeY1oTb9L5hzkQKqMl/+f3Esz7TpH2UAbfPRcQo47BVC9JdLN6s1CAoQwTSG9iKstza7szIfDHUerzEGlhxyaxQpPLHv355UopUbq+k3H2HR4me3lVbkRzr4YbJv/f2PQXddMUBzCVY4vZFRnPixrWjkjX+fX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634290; c=relaxed/simple;
	bh=Sedntlj+MRpt/fUUQE+k3MFmNCo9DsPGibGC+cz8uNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCFvXcWXz6V7OjFVIEeHLLeMATxaqaBQoL2ndVv9MK2TEGc7lMAVEi3DXUoesg8W0jwuyfhbTTaMgIX7E1PkQj1ZpEXKa55O2ekXPFbtJ9mJU6QM3W4qp1tWt+XKJ3CmcHMJgVID/GGyoZK6KnlWJxqNHhlXEBD9y893PC2f0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56a9076813bso2770463e0c.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:44:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775634286; x=1776239086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NEDWencaHGoC92/VXbD1rMBTxJckYQ0xVO4rQnCJYhI=;
        b=b5vJKMC6pTUBofTVz/MFXVa0GQKjyW8bdm/875ZfchHgBbvSq0o2ce9cpfWv6qdGxz
         0TB5KkVo8joZS73KemcnqzzFZIkIEdIxRswAu4VbaMbbBIXwrv7m7tVvcxNjKtqFfl3N
         a7wZeq8B+krhH8PAK6/bZBAtfNqilE1rTtxARG7TCPPQPUXL48bXxSPuIampbzpGCztY
         efcjeT5Ny9c0HwoUT8RjRy7OKFVQl5hpsx38inpUZXtTzEJSup+LLZwoELHLkhgYrwT+
         qL2JAK2Y3wV0R1TVlyPO4mIrLq2/k3Glhd6zWSB9m4LNngsOChRLeT30KZl+ZgsGTUWS
         SZgw==
X-Forwarded-Encrypted: i=1; AJvYcCVRF4CESLeBBpRT2i/boxtDpv+R0HlXkuQ4tkVNE1LVDv4ifgwVSh1mbMx52YMDVr6w8wd44xo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+BQw47F/MJa8M9tJcVYmzARe0EWkHFBcGIvnRjNIPoE6kzVXz
	iT4phR0Vx1XU7d1tF/gkDTFgKy8kLqg9KAnOnN5+j/cRkJQa1DugvTWJ9SxHVXGK
X-Gm-Gg: AeBDieuWgg88I9iREHfCB3GRA2v109xN/eKk+UTZOwLPj17bAzNVeHsqVdz+TqO6bSQ
	A9QM68pPKItarmk8yK94aJuC19Bw0bDoZIHYBTdVcPygK/EKy0D3cGOwPfWHP+V7KCmxM6PvYNF
	c08lDeki7yGzhI+uCtE0M+fKdddhz+fjyH9Xk+E5SlZ1/DWnUrsALx47A7sRyhl8L9V11gF1jWy
	/8lsAWMVMETqZJmn6yiR60uvX76sjp0YBvWxW7HSOVBn3ZxXjuvxE/1SR8U6IeKesdQ0z+rgBti
	t1mKTyQc6DlclEvBXvrrzd11MY1pLHPxuqTei4UTs28To9ESm9rwAO6jwc/xw9inpbUT5PRUDBF
	R9M2kDeaY0IV8+KAziYK87U+/q8LJRaMPyU9Pb0u17OZIALKbkwhAdcSISV8CYYxlqVfCvfL10B
	NMLuF7BjVi76evawXvkLVP+M/EURkij2tH4MRZ9YRZX3xjq36yGrBTgiPes9tO83i4
X-Received: by 2002:a05:6122:1817:b0:56e:f262:910f with SMTP id 71dfb90a1353d-56ef26293e6mr5097234e0c.3.1775634286193;
        Wed, 08 Apr 2026 00:44:46 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fba6abbcsm15890533241.9.2026.04.08.00.44.45
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 00:44:45 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56d8d479149so2139717e0c.2
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 00:44:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVP9+fNA7Y1LjXRLMJpQSblFqhlDAP0lD1V9kz6HQZhBW9F5YK94CLF1grtpiLe89uBY2MZk5o=@vger.kernel.org
X-Received: by 2002:a05:6122:d1e:b0:56c:da22:6921 with SMTP id
 71dfb90a1353d-56dab89ee50mr7759922e0c.5.1775634285014; Wed, 08 Apr 2026
 00:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401183608.1852225-1-niklas.soderlund+renesas@ragnatech.se>
 <CAMuHMdWnjV=HGE1o08zLhUfTgOSene5fYx1J5GG10mB+Toq8qg@mail.gmail.com> <20260407185443.GC2551274@ragnatech.se>
In-Reply-To: <20260407185443.GC2551274@ragnatech.se>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 09:44:33 +0200
X-Gmail-Original-Message-ID: <CAMuHMdULBf3fBZU62F3YgBtJGzyTQgM-S-c9rhtX=cUCkqDQbA@mail.gmail.com>
X-Gm-Features: AQROBzBzKJdNv4YGImgP7NuYcmguQh7usD6WewdHOw4ygij9zBJGnfG3HJWNFS4
Message-ID: <CAMuHMdULBf3fBZU62F3YgBtJGzyTQgM-S-c9rhtX=cUCkqDQbA@mail.gmail.com>
Subject: Re: [net-next] net: ethernet: ravb: Suspend and resume the
 transmission flow
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Paul Barker <paul@pbarker.dev>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-276332-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.329];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux-m68k.org:email,renesas.com:email,ragnatech.se:email]
X-Rspamd-Queue-Id: 6DF533B8869
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Niklas,

On Tue, 7 Apr 2026 at 20:54, Niklas S=C3=B6derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> On 2026-04-07 11:03:38 +0200, Geert Uytterhoeven wrote:
> > On Wed, 1 Apr 2026 at 20:39, Niklas S=C3=B6derlund
> > <niklas.soderlund+renesas@ragnatech.se> wrote:
> > >
> > > From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > >
> > > The current driver does not follow the latest datasheet and does not
> > > suspend the flow when stopping DMA and resume it when starting. Updat=
e
> > > the driver to do so.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > [Niklas: Rebase from BSP and reword commit message]
> > > Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnat=
ech.se>
> >
> > Thanks for your patch, which is now commit 353d8e7989b6babe ("net:
> > ethernet: ravb: Suspend and resume the transmission flow") in
> > linux-next/master net-next.
> >
> > > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > > @@ -694,6 +694,9 @@ static int ravb_dmac_init(struct net_device *ndev=
)
> > >         const struct ravb_hw_info *info =3D priv->info;
> > >         int error;
> > >
> > > +       /* Clear transmission suspension */
> > > +       ravb_modify(ndev, CCC, CCC_DTSR, 0);
> > > +
> > >         /* Set CONFIG mode */
> > >         error =3D ravb_set_opmode(ndev, CCC_OPC_CONFIG);
> > >         if (error)
> > > @@ -1103,6 +1106,12 @@ static int ravb_stop_dma(struct net_device *nd=
ev)
> > >         if (error)
> > >                 return error;
> > >
> > > +       /* Request for transmission suspension */
> > > +       ravb_modify(ndev, CCC, CCC_DTSR, CCC_DTSR);
> > > +       error =3D ravb_wait(ndev, CSR, CSR_DTS, CSR_DTS);
> > > +       if (error)
> > > +               netdev_err(ndev, "failed to stop AXI BUS\n");
> >
> > This error message is printed during resume from s2idle or s2ram on
> > e.g. Salvator-XS and Gray Hawk Single.  Ethernet (nfsroot) still works
> > fine, though.
>
> I was not able to reproduce this on M3N (r8a77965-salvator-xs.dts) nor
> Sparrow Hawk (r8a779g3-sparrow-hawk.dts). I'm using the following to
> test, is your test-case different?
>
>   # echo enabled > /sys/class/tty/ttySC0/power/wakeup
>   # echo s2idle > /sys/power/mem_sleep
>   # echo 0 > /sys/module/printk/parameters/console_suspend
>   # echo mem > /sys/power/state

Looks good. Major difference seems to be that I use either Wake-on-LAN
or gpio-keys wake-up, and I always have WoL enabled for ravb.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

