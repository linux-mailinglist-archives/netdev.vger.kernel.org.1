Return-Path: <netdev+bounces-306399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OQoXNms9UGrzvQIAu9opvQ
	(envelope-from <netdev+bounces-306399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:31:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68696736620
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 02:31:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=UQc0SMPZ;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306399-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306399-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16F9F302FA24
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474701A6825;
	Fri, 10 Jul 2026 00:29:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C126257C9F
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 00:29:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783643359; cv=pass; b=tw7Z1pibR4qwykhnPqEYe2+9S3J0SyzfEgY+NRtg4+sSzHBzcj6cNJHf7Avp3Ub5LgsQMijLeA1HpjoKxDn0R9zMzEPxj5DP09YPY3v3ZLBbiDXtzaURFcL5ShJLO3DDZCPOl6WhCWNqYDl+zT5dcMAecNsEqZVA2AVNfMfdN80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783643359; c=relaxed/simple;
	bh=YP5VsurfK1eGz6I+enqpru1HuYNU8V4+Dhd27WIC3fw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ocelFvSheab9yvnqqqKQiUOQzz3gbbfgxjj63hMwuQ1dBAVBypef63GsgSUa16gfJ8SDdiH53XkALZc9vDOwMhk3uyy2ynewKLTZBl3nzk9N3nozXe97e4vDSifAgkJIFaEkfm2SXlR+Vu7ZAMHmUtSVcDOZNxKpjvOhARWj1IM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UQc0SMPZ; arc=pass smtp.client-ip=209.85.160.173
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-51c10e86e52so78521cf.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 17:29:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783643357; cv=none;
        d=google.com; s=arc-20260327;
        b=hxrCzgNnZ25rq6nCefk6F0SEGw8/Rks9pKR5F9SINvDl3/y8mjyvsGpCZRaArnny59
         EBu97zAa3WKHEGiN0ytXRFLwYL/ChVQXuFJxbLp7ILaRlMVYxjPa3gqM/CCRNqfAxU3G
         PUdqQz7a5wcIZOlXgjTT2y8Zf1K5Jtrfj4/Cc4/eJBpF6mf3hOqUxpe7Bv+3BbaHvbG/
         ARCsg8+d8AEjoOYA0B5C/BClhDDvyVXibNSCRXl4f2UxYfpFqIOYK7Xi9LzV/b6rja5/
         C8IzuWMcYpoSinQjiTZ+wLcZ596AhbOXnA81y8PfWBsI+yssa9/lbUr3icn/wgCpkzBT
         Ip6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WROE5PFVoWMfSGv+/anRXgqnlQ9yYPFqpu9lqinJJGY=;
        fh=JeOdY1bsFfL+4Y1hJYTM1DRjGslVy5ZTi4kc2hOiAYg=;
        b=SqTS/DavThVo1RKma/z5RnmwHnRb742snuCN43XfsBpSGWIajRgXcBLOqjwGH7yxwC
         iIkxv3ejb+I9uDiUZqBhdo0ADXePRsyrVGJuYbGICUVeITDS+r6n2hBkyfsASr+vUtwP
         RgTdLpqImXb/kko/qL2HdTLlQ/7EZSHLiJBKxsHSKXoYbP91lGKc5pV71UL9wF6teNZx
         jEhMLtX0EjuCmvG7t66BvpKTIBL+3j0PC01YuJZoRduK7QYjLY15qFF2klgUh7+DBWeS
         tbwhskaXIkQyu1/6Knv8MXiO5xz3ZzuzTbzQYhmg89pcQtzmpL2l0x/sdDaw5LMfnzxW
         WorQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783643357; x=1784248157; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WROE5PFVoWMfSGv+/anRXgqnlQ9yYPFqpu9lqinJJGY=;
        b=UQc0SMPZqguD7VPdYGLlrdAh6BhAAfR6whYUaumKUUltlBNfm0VZ6tz/nQqr+aFVrY
         GB8lQDcGEI8Ga8wGKLLKPD1P/61zn4peLYXr733Nea6vYvTiUxgwGBIiznDgwVrqM2Y/
         d0sBwNM/nW9edoipK4AgYn2T5B2CwXByu9t5x/5VnkfNRjEmGorm+5iqfrY6PAOnbsPz
         WmJ1zXXNrdbWGe6fUiRei13JAItptPtjY8t1aHiopahDtO0jMLZ57o3mJY9UOVu3T2cu
         eNa5080CImpfooFjZ08Pnr8flObzMo2pIuCf2I/mV1mXrt7NzHV5rBqIzlEJ2hNvTNqG
         PO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783643357; x=1784248157;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WROE5PFVoWMfSGv+/anRXgqnlQ9yYPFqpu9lqinJJGY=;
        b=kkzr3H/Uc0CZoIxEuRJ9SRJUc7+rQvjwUIa0m8D+4MRiQKMIFZ3+BWksQvs6cmZVIX
         Woqwbs4+12JrdSBA4tN5Qm4Kxxezn1ueqe89sawaRsnriKKJlLL66q7U/4Jm3WnKWuSu
         hSysnQ5uxGe/B5SOt453cB49HD9hQiCt1MYWm+/aV2U33j8kOeyBFO6uppmqfZSt1hrs
         OAv/VYzpDirZYE9c3GNp6ExwwV2+U07ZbZVLH1yaheDCv5NuEcm2n9x370beeh0y4Nlv
         rQr7x1mz3wjReqvVTHp6Y2RLEN3QGnawHKbZusSojjBbHmD9iKAtqu8Mc7AV9vxZQzHP
         tKxw==
X-Forwarded-Encrypted: i=1; AHgh+RrXQy2AR37nX3sSThbyr6nqxC9ZXtR89NNUs0DyNHPbL70U5ji1HWh78ZEjCX8wibX1jjUvTNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRXdsrLXwGNEepgGcE4MMfZmBw6SVnuco95Z1dRyFPc4N2ROVr
	TGZt8XDNDek2d8G0LhMR/ETdBtp5DS10YO6RHoIS67DvUrzE01EWKfXuh/0MDf8XRaBg0ri2Hks
	VeeikBP4wG7ulJP5p7uu2AIYPVsObsLvGLCjbpRU4
X-Gm-Gg: AfdE7cmIH8NddALt+BdcZAyFwVwxFZr2cQl/ovSlhwo4b/SANuFcRRDkQ7lVZy+qg2L
	I7smQeIiFLebJ0JzjYEyBwsHRz37kZjZiuXEnsXvWpuf1/rszXuXvSBU8yAL7HhKiD4imCvV6fV
	Ld517l27P7wP0b8BxkOuzT6aGePIMfYiycRCdbJ8dW7WdmB4gv4rdJvOuVK252hAGGkg8P/yJLT
	ZNV8/NdCLduKUAaFbTj7GHp4U3GcYQTRqHenMqIGuhpx6MdHJkdQuEGqUhEJfHnxZ+eD73/tRiK
	PeNTyI9r/l5qB4jppTTte5IokwUsqTySjAAPMpiqKVhMYjESfQJXZiK5hk0=
X-Received: by 2002:a05:622a:5ca:b0:519:b82d:fe62 with SMTP id
 d75a77b69052e-51cac51df7cmr2398281cf.7.1783643355883; Thu, 09 Jul 2026
 17:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707043039.101983-1-yuyanghuang@google.com> <20260709171709.GA1749979@shredder>
In-Reply-To: <20260709171709.GA1749979@shredder>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 10 Jul 2026 09:28:39 +0900
X-Gm-Features: AVVi8CfU_jK1iWSjXYkP4M_4lK6XxEw_GVPK6u5nbbJotoBAd51iMLb_UwJlC50
Message-ID: <CADXeF1Hp7x5sRHr8uBO5TF8BKNqK8869j-kEdP4WqEz02oYV-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ipv4: clear dev->ip_ptr before destroying inetdev
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306399-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:kuniyu@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyanghuang@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68696736620

On Fri, Jul 10, 2026 at 2:17=E2=80=AFAM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Tue, Jul 07, 2026 at 01:30:39PM +0900, Yuyang Huang wrote:
> > To prevent RCU readers from accessing a partially destroyed in_device,
> > clear dev->ip_ptr early in inetdev_destroy() before freeing the
> > multicast list and individual IP addresses. This aligns the IPv4 teardo=
wn
> > sequence with the IPv6 implementation.
> >
> > Cc: Ido Schimmel <idosch@nvidia.com>
> > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
>
> I believe that sashiko-gemini [1] is right and you need to teach
> prestera to ignore NETDEV_DOWN notifications in the inetaddr chain when
> a RIF doesn't exist. Something like [2].
>
> Regarding ieee80211_ifa_changed(), the net device is being tore down, so
> failing to update the firmware ARP filter probably doesn't matter, but
> you can do something like [3] to avoid it completely.
>
> So, three patches where the last one aligns IPv4 with IPv6. Please check
> if other listeners need to be adjusted (mlxsw is OK).
>
> Thanks
>
> [1] https://sashiko.dev/#/patchset/20260707043039.101983-1-yuyanghuang%40=
google.com
>
> [2]
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_router.c b/dr=
ivers/net/ethernet/marvell/prestera/prestera_router.c
> index b036b173a308..0c4f462baa6e 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_router.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_router.c
> @@ -1302,10 +1302,8 @@ static int __prestera_inetaddr_port_event(struct n=
et_device *port_dev,
>                 dev_hold(port_dev);
>                 break;
>         case NETDEV_DOWN:
> -               if (!re) {
> -                       NL_SET_ERR_MSG_MOD(extack, "Can't find RIF");
> -                       return -EEXIST;
> -               }
> +               if (!re)
> +                       return 0;
>                 prestera_rif_entry_destroy(port->sw, re);
>                 dev_put(port_dev);
>                 break;
>
> [3]
> diff --git a/net/mac80211/main.c b/net/mac80211/main.c
> index 90d295cc364f..0e7a60dd1d8d 100644
> --- a/net/mac80211/main.c
> +++ b/net/mac80211/main.c
> @@ -588,9 +588,7 @@ static int ieee80211_ifa_changed(struct notifier_bloc=
k *nb,
>         if (sdata->vif.type !=3D NL80211_IFTYPE_STATION)
>                 return NOTIFY_DONE;
>
> -       idev =3D __in_dev_get_rtnl(sdata->dev);
> -       if (!idev)
> -               return NOTIFY_DONE;
> +       idev =3D ifa->ifa_dev;
>
>         ifmgd =3D &sdata->u.mgd;

Thanks for the review comments; I will update prestera and ieee80211,
as well as go through other listeners to confirm the sequence and send
out stacked patches as suggested.

Thanks,

Yuyang

