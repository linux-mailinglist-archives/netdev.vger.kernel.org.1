Return-Path: <netdev+bounces-261914-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0E00JqvEoWkVwQQAu9opvQ
	(envelope-from <netdev+bounces-261914-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:22:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 092191BAC0B
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8AAE3085B92
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E0344BC84;
	Fri, 27 Feb 2026 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYFAxqIc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508044B698
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208925; cv=pass; b=MzVDjVzapcrsEz8UNyiAIvoUtazUvPiGsKWHxijZFNPHLmfOfuhcTGa0wkonrh+fxYkc/igzsqFHNQ0vYkMdbOJTsweWiNDzMHoSo93bifF1M/QNTimA2qo4vwezN80/mu/AANbVX3I/u5ZPppDrdHtfFSmlOVrfo1kmfgqjITk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208925; c=relaxed/simple;
	bh=DH0RH1/fQGJuB0L4meuV0Gdgp9dROoGfpDMRRpPuC94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qN05fsUZn7VemgcS6vEABmtoxHY67jKT+IN2HPQibnggGda+fJxVJG4zZdpGx2QmazEH/E2WXTmNqWJPqZn/Rtk4Tz1GM/oqd69HEcP7GFgXDSI96pz/HkGP4ZTaOTG0WcHdrHq1CYys+vCZ3pwa8Rzgv2CPCw19rLImUDFhTKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYFAxqIc; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48371119eacso25481385e9.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 08:15:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772208922; cv=none;
        d=google.com; s=arc-20240605;
        b=YNOlH232zC46BIVCDXaeG3pMJ44VuwCm9ZBA3EdHiNKREv851ZumZAVqhllT7nBEks
         z3gI8mq86OeUaMnprKgCi6x0s6Y2cIvVynmrGWQcwaJhRnikLx1ldkKrEILMLrF47Dqd
         uyI9bgDpuUMtTsPwC+XBOlwtC91tuddk4OsoOxp7lur/xjH99N/H3gz9uswl+W/pvqhg
         nLDTDzteqtGEEiUnmQAtTMGHLs+6w3V8Oi8y71t/3bVxORge03NkpOpfebtYVyi4nOg6
         vXTlsWX0d/ScFDLGxFxS14ODDN2D5JI/GDApWLLBj/5zA6UZdqmg10SNqjKlgB3MhnZ1
         Slsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cbCNMu2VVMLdqM1PjakDPBcqstbvFMla6YoKy6yIdho=;
        fh=JehbpzUgQJSuoSft4RFAjNtNtp+yTvyYZ0v/fdjqizs=;
        b=euYNflXSiQlU+y2rhR10cW5ajG8GHRzX1+A+XIQWsn8U3zq8CWQmtsjjB6HXhtscdg
         XMDyq6juAJoORduCXD94JCdHJbkGkLXyPxtbGCpajiFRZIVLVcd7kdsoF2msNlrY/Zon
         VOyTqEtikKLAOgv4p4R5al/sZzZNkPXce4X4CLvxQ463gDMfxOEGSNOSImfRpvwIhBHs
         V4pds6O3Q0yvBBUcqLm+T63CmiXcsxfwIKWPNSBNwy/zwBls92ggfCz/ZMjUxYSdZWZM
         jvkioysx5fvmGwSJ0pDPCBnWA8A0QflEos6ZXm/IkbdFTgdEfvL2xq8vgbNo45nCsdWo
         A5Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772208922; x=1772813722; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cbCNMu2VVMLdqM1PjakDPBcqstbvFMla6YoKy6yIdho=;
        b=EYFAxqIccRx/x1/Hs7jvAGXndY2VSk/e/K2ZM7wBOUi4QLp3aItEvpyXeb6ISaO3PP
         qoBnI64rrrx6EqFkbfMJ8AyoqgOHEd/xCdgPapIrAP2+Kl7LgyPU0c3fV6m36bVDoODC
         ZvZrOsWu0/i83SSHxxXvgModYsRirnWAetz6/7BNeubQ4POPqdPjR3HGBBqZARTeH3uw
         5j28uWoplaFmX2NUyerjnGH9RwqQWTOybgPc4FkMyy9ciIi3C63gSsq2UkLpgIXygzzd
         qh72kKWxD3vfNivxZH+uhnR7G0342PHhan0ci1sAaCYNZPwizy3OfnPs1PW4uBEkW7ue
         1bDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208922; x=1772813722;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cbCNMu2VVMLdqM1PjakDPBcqstbvFMla6YoKy6yIdho=;
        b=JPxQ6bJlZeVdV+BQ4GsJ58ySWn48z0QaIJ/2Mx/u48mZKasAxpvasI1EH7cVp5pkmK
         0ky+MF616O83zFPvtmE824oFwiP8K3TW5V+OI20+q3ECBPj/CMTDIQQG5+K4jBmF9+RJ
         29kYUMmfKozvLsIURP3X1m5lWTl6EoLLoev7xHpQ+TAAAdtdkCcjMPceGouDzIJ/u5Oj
         3L4DZ50s46oXZnfIIdOgOx4z9dzQV6AKXwva9uSr0Z3T1mW1GzZBcTVL4LIdSL8vhIea
         IUmTJ3bjhaEy49uOAoeD0pVQ2VQXtnCo1bZDIPyqZoBrJtT1CMrpAaHB5SlWtoLNIqBu
         B4MA==
X-Forwarded-Encrypted: i=1; AJvYcCV84ZgNVvqs1zV7bw5Yuefs+LUX2vEzkY4bK8j5SuFsiBsnZcpL4ynWINdOcAouXZ03+GybSvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzirl4IAWn52B7gmfACjjY41r0de8hfBnEFvD0yu++AT2if5NxR
	vOPWnFukyOqOcs45d3koPYQLgwSWhuGJOE4IbD7O1JexKEO4lOQZf0NybbpJSWPlPIY/58uDwZy
	T61m0dCDBAw6nDRihSP70xZy/1TCxsms=
X-Gm-Gg: ATEYQzzZuhaobOT1bREKTlMZlYhLv3/xpuzgxahyY2XINlO1ITMaPorGk/24kMw3KB+
	DmZ5N3Naje+L1sf8WioOBaV0O/BK+4lVoBr1Y9abHgGm3viJVcR8ZCiV7V8M00zfG+V7XwsjJYq
	jGIMZbNhcBer/b75FKiJTiCo7jSfqWFKqu1Z3ydzISjAZWuDPXzwhxmBFMUVCPvMAbxe7LZIHeU
	RDudDCDAfsLUBxdavhD1Bys1Nv0BdIQQjVVvBRI5BwnAyHdbNjkjUMEuGgmYAK7ODfJNsn6tzzs
	h9nO
X-Received: by 2002:a05:600c:1f95:b0:477:6374:6347 with SMTP id
 5b1f17b1804b1-483c9c0bb23mr54761885e9.22.1772208922022; Fri, 27 Feb 2026
 08:15:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPh3n803k8JcBPV5qEzUB-oKzWkAs-D5CU7z=Vd_nLRCr5ZqQg@mail.gmail.com>
 <95ccf5a6-975b-4543-80a3-595f1ee20543@redhat.com> <CAGRyCJE85fLOahUR3PAUnS_jH4+qpBq37qpged=nvObbg1m+Qw@mail.gmail.com>
 <20260225170155.0ae83ae9@kernel.org> <CAGRyCJGYLemYFDNw8cfcCHoxe8YqfRRgnJXgz03WVssKDYXhUA@mail.gmail.com>
 <a481bb1e-d0a9-4545-bb8b-beb72506478a@redhat.com> <CAGRyCJGc+gxF2AcKapr4NJFWVdwF8CBEp7SuxQ2ZHnEUva6XwQ@mail.gmail.com>
In-Reply-To: <CAGRyCJGc+gxF2AcKapr4NJFWVdwF8CBEp7SuxQ2ZHnEUva6XwQ@mail.gmail.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Fri, 27 Feb 2026 17:15:10 +0100
X-Gm-Features: AaiRm52nyE6XDH9JhGsh0pFZGc0KT-1ReFG7tRPLr1C-j7FAkavWzmkmY58e3Sw
Message-ID: <CAGRyCJFDKv+U4004bPKVGGq292nNiOxuovOc0magetRCJ8vNaQ@mail.gmail.com>
Subject: Re: commit 662dc80a5e86 breaks rmnet over usb
To: Laurent Vivier <lvivier@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Koen Vandeputte <koen.vandeputte@citymesh.com>, oneukum@suse.com, 
	andrew+netdev@lunn.ch, Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, 
	netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261914-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dnlplm@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 092191BAC0B
X-Rspamd-Action: no action

Hello,

Il giorno gio 26 feb 2026 alle ore 19:18 Daniele Palmas
<dnlplm@gmail.com> ha scritto:
>
> Il giorno gio 26 feb 2026 alle ore 10:09 Laurent Vivier
> <lvivier@redhat.com> ha scritto:
> >
> > On 2/26/26 09:26, Daniele Palmas wrote:
> > > Hello Jakub,
> > >
> > > Il giorno gio 26 feb 2026 alle ore 02:01 Jakub Kicinski
> > > <kuba@kernel.org> ha scritto:
> > >>
> > >> On Wed, 25 Feb 2026 08:19:46 +0100 Daniele Palmas wrote:
> > >>>> Could you try something like:
> > >>>>
> > >>>> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> > >>>> index 3a4985b582cb..6b4796fac692 100644
> > >>>> --- a/drivers/net/usb/qmi_wwan.c
> > >>>> +++ b/drivers/net/usb/qmi_wwan.c
> > >>>> @@ -788,6 +788,8 @@ static int qmi_wwan_bind(struct usbnet *dev, struct usb_interface *intf)
> > >>>>                   usbnet_get_ethernet_addr(dev, cdc_ether->iMACAddress);
> > >>>>           }
> > >>>>
> > >>>> +       dev->rx_urb_size = 32768;
> > >>>> +
> > >>>
> > >>> So far userspace tools (e.g. also the most important one which is
> > >>> ModemManager) rely on changing the rx_urb_size by changing the MTU: I
> > >>> know this is ugly, but it is a behavior that has been there since a
> > >>> lot of time, not sure how many tools based on this assumption could
> > >>> break.
> > >>
> > >> What's the policy in ModemManager to change the rx_urb_size?
> > >> Increase it to make sure it can hold some specific cmd / packet?
> > >>
> > >> I wonder if having rx_urb_size max of (mtu, 32k) would break anything.
> > >>
> > >
> > > Typically the host sends a QMI request to the modem for setting the
> > > size of the maximum QMAP aggregated packets block. Then the modem
> > > replies with the maximum size it supports and that one is then set by
> > > the host through changing the MTU of the netdevice. Low-cat modems
> > > usually support 4-8 KB, while 5G 16-32KB.
> > >
> > > On ModemManager side this is currently fixed at 16KB, but one can use
> > > other tools e.g. qmicli to set custom values as far as they are
> > > supported by the modem.
> > >
> > >> Since we're talking about rx buffer config the right API to configure
> > >> it is likely ethtool -G rx-buf-len :(
> > >>
> > >
> > > Thanks for the hint, I'll try to have a look at that to improve qmi_wwan.
> > >
> > >>> There's also the chance that there are modems which require a higher
> > >>> rx_urb_size, so having this fixed could not work well.
> > >>>
> > >>> Unfortunately usbnet serves many drivers, I agree with Koen that a
> > >>> revert is the safest option.
> > >>
> > >> Then again the usbnet driver is brittle enough as is, if it's just qmi
> > >> that needs this workaround we would be making common code less robust
> > >> for a benefit of a single "hack" (for lack of a better term)
> > >
> > > Makes sense, also Laurent proposed a solution to keep his fix in
> > > usbnet and make qmi_wwan the exception.
> >
> > I was thinking to something like that (see below), but I'm not really able to test it. If
> > everyone thinks it's the path to follow, I can send a patch.
>
> I think I can test this by the end of the week and let you know.
>

I've verified that without this patch I'm not able to set mtu > 1500
and ip -d link shows:

3: wwan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
DEFAULT group default qlen 1000
    link/ether 16:7f:28:3c:c4:3e brd ff:ff:ff:ff:ff:ff promiscuity 0
allmulti 0 minmtu 0 maxmtu 1500 addrgenmode eui64 numtxqueues 1
numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536
tso_max_segs 65535 gro_max_size 65536 parentbus usb parentdev 3-8:1.0

while with the patch I'm able to set mtu > 1500 and ip -d link shows:

3: wwan0: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
DEFAULT group default qlen 1000
    link/ether 2e:56:3a:37:75:e2 brd ff:ff:ff:ff:ff:ff promiscuity 0
allmulti 0 minmtu 0 maxmtu 65535 addrgenmode eui64 numtxqueues 1
numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536
tso_max_segs 65535 gro_max_size 65536 parentbus usb parentdev 3-8:1.0

Interesting enough, in the failing kernel ModemManager is still able
to change the MTU of wwan and properly create the QMAP data call with
the correct rx_urb size, resulting in a netdevice like:

3: wwan0: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 16384 qdisc
fq_codel state UNKNOWN mode DEFAULT group default qlen 1000
    link/none  promiscuity 0  allmulti 0 minmtu 0 maxmtu 65535
addrgenmode random numtxqueues 1 numrxqueues 1 gso_max_size 65536
gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size
65536 parentbus usb parentdev 3-8:1.0

Still need to check the reason for this, but it seems to me that your
fix is working properly.

Thanks,
Daniele

> Thanks,
> Daniele
>
> >
> > Thanks,
> > Laurent
> >
> > diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> > index 3a4985b582cb..05acac10cd2b 100644
> > --- a/drivers/net/usb/qmi_wwan.c
> > +++ b/drivers/net/usb/qmi_wwan.c
> > @@ -928,7 +928,7 @@ static int qmi_wwan_resume(struct usb_interface *intf)
> >
> >   static const struct driver_info       qmi_wwan_info = {
> >         .description    = "WWAN/QMI device",
> > -       .flags          = FLAG_WWAN | FLAG_SEND_ZLP,
> > +       .flags          = FLAG_WWAN | FLAG_NOMAXMTU | FLAG_SEND_ZLP,
> >         .bind           = qmi_wwan_bind,
> >         .unbind         = qmi_wwan_unbind,
> >         .manage_power   = qmi_wwan_manage_power,
> > @@ -937,7 +937,7 @@ static const struct driver_info     qmi_wwan_info = {
> >
> >   static const struct driver_info       qmi_wwan_info_quirk_dtr = {
> >         .description    = "WWAN/QMI device",
> > -       .flags          = FLAG_WWAN | FLAG_SEND_ZLP,
> > +       .flags          = FLAG_WWAN | FLAG_NOMAXMTU | FLAG_SEND_ZLP,
> >         .bind           = qmi_wwan_bind,
> >         .unbind         = qmi_wwan_unbind,
> >         .manage_power   = qmi_wwan_manage_power,
> > diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
> > index ed86ba87ca4e..b72ba0803392 100644
> > --- a/drivers/net/usb/usbnet.c
> > +++ b/drivers/net/usb/usbnet.c
> > @@ -1829,11 +1829,12 @@ usbnet_probe(struct usb_interface *udev, const struct
> > usb_device_id *prod)
> >                 if ((dev->driver_info->flags & FLAG_NOARP) != 0)
> >                         net->flags |= IFF_NOARP;
> >
> > -               if (net->max_mtu > (dev->hard_mtu - net->hard_header_len))
> > +               if ((dev->driver_info->flags & FLAG_NOMAXMTU) == 0 &&
> > +                   net->max_mtu > (dev->hard_mtu - net->hard_header_len))
> >                         net->max_mtu = dev->hard_mtu - net->hard_header_len;
> >
> > -               if (net->mtu > net->max_mtu)
> > -                       net->mtu = net->max_mtu;
> > +               if (net->mtu > (dev->hard_mtu - net->hard_header_len))
> > +                       net->mtu = dev->hard_mtu - net->hard_header_len;
> >
> >         } else if (!info->in || !info->out)
> >                 status = usbnet_get_endpoints(dev, udev);
> > diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h
> > index b0e84896e6ac..bbf799ccf3b3 100644
> > --- a/include/linux/usb/usbnet.h
> > +++ b/include/linux/usb/usbnet.h
> > @@ -132,6 +132,7 @@ struct driver_info {
> >   #define FLAG_MULTI_PACKET     0x2000
> >   #define FLAG_RX_ASSEMBLE      0x4000  /* rx packets may span >1 frames */
> >   #define FLAG_NOARP            0x8000  /* device can't do ARP */
> > +#define FLAG_NOMAXMTU          0x10000 /* allow max_mtu above hard_mtu */
> >
> >         /* init device ... can sleep, or cause probe() failure */
> >         int     (*bind)(struct usbnet *, struct usb_interface *);
> >
> >

