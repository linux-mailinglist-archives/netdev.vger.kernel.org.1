Return-Path: <netdev+bounces-307542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /e5bBkZ1Vmr95wAAu9opvQ
	(envelope-from <netdev+bounces-307542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:43:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC2757930
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 19:43:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=ajleL+N1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307542-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307542-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FED6303D370
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 17:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9462412C05;
	Tue, 14 Jul 2026 17:43:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEEB37F73A
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 17:43:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784051005; cv=pass; b=OehKsAP3O4GG5lSImY0xeKl+AcILgJib1KlS5Pj3lw9s9KlwnZv0Ut1EbB7foynAYGKFD5dJlhDAN1StSNhRmyoFgbh2mwNR7PbrmoYNhb5CVueBw6CWGaEYWU5S7co2BzqFcwusgfv1IqRaeOK2d19DtgIxarQmCZAq1EqPbN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784051005; c=relaxed/simple;
	bh=IqZIAd0cCcHZ42lAptFGrjVXP4gbXUmtq1AaettDH3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eu4qyKoz+t9U8gPGwh3XS9ORzQE5cEbuUFSQG4SHqy6Cb6+0AOKfnwmn7lpNIj4BEFmBCPDsZCR83Ve/zJX5a4M57zyOWlbBZ0DgzqtdNJRfRa4J1Wz0dA/t3XipXiAbcnyziW5xDb5pBy6TcfAftjY1+xG2+YORAs1somVtez0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=ajleL+N1; arc=pass smtp.client-ip=209.85.214.177
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc6dd436c6so14988145ad.2
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 10:43:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784050998; cv=none;
        d=google.com; s=arc-20260327;
        b=mvHyLe876GjtuusiRpp0OGXF72lViaL5NnTPNR7rLmWfbmZMKVKzuanxfdUcGxmXsl
         FnmAj8axS3JSPk+Fvk2yV8dgrU+6K+cp/OrYuGIrqEm/BbPKd3qcWbhXJ47cK2EC6AXd
         TPOCgSqGUTp33Y6SrjHEFzuOhYJgIC+SYnQLJXp3HnQISNpuDXwkj1Sy/cALR4qIF/U6
         CPxDKPwIFEoo9C8hcBavi07mMOmtSiOeToOiIiqH8dK0RB4TYQGR7Rn7HAbmx7arVVP4
         RYCIqAmvdgqX73WTOuJMgion7n/6fDtS0Hom1kvn4ow2Nftx2rDlRzqRgzlRIUlBXox+
         uUpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1Pz8O2vLYmfUwTbni2IlCcDAPYdfQco2elXmue1upKM=;
        fh=T6bu6vVAEBYjj6at1/sMvSO3/HMw5M3Sha1aIv+c6nk=;
        b=GGFY8vIqG0Y9Ew1f83Hmdh3jsq0j0tYAYV7Ue1JHk/k6rouatFLfmmIdbdbQwMvr33
         obSEKr9O5ZD9mkN9WJXT9ajhysZEwJxSJuSra1lLoPeBjXIBi3sdXi6c8ATmd3R2lMUi
         9LwHBp4NLpeiMFiqMMr95ep9gxEbIH+4pF8UBPaGF5Ccffi7pB5YtLZlCSmzcyX8ejbk
         vsiTDPFKaV7/uHlZ+gvpLcmQl0BwHaXM7i2iHVupyKT/qoq7ix72fGrMi/a10VA4ihxp
         l7QfXmL18YRV3bgNOb5+jiMfJsaoFyVRzplYygyJOsgotP4SxV5ZeWgfE306FIjZYUIm
         9eeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1784050998; x=1784655798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Pz8O2vLYmfUwTbni2IlCcDAPYdfQco2elXmue1upKM=;
        b=ajleL+N16I+vqPssCUl0d78rJzJm07gNZuTqAG8FwDGgi18vvubR8aalcYLoqG8iso
         Yk07zHRSqET3f5mAV1xEfPCY4uB1cIo3rpaC/RIqE3gIMNShrUW+Tf3p6Kl0ZCwnDnHu
         ih3+ureE6o78qX32Pcz10zMB8LP7DLyH76Z48OVl+9mOTcnik+eAqJhINeQfNM8VzESU
         FNPILxUEYjgY7t0gbOtSVMk5Kv50zAG0wm+b0SqUdjm5Q5eDRwJK/Zhhenaul3u9YJDE
         Mikeh8YTWgZcW5NEEEOBBQaGzRsJDSQRiyZzkzTj6sgUD5wm1zkcVlxDRsljDyxxcFNr
         5LRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784050998; x=1784655798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Pz8O2vLYmfUwTbni2IlCcDAPYdfQco2elXmue1upKM=;
        b=LjroNlqaPHrCLfAQ3pL7iWzGSshPpmj+MRj4YXhblzZ8v+RI4F+Xixhp54B92wy2vu
         mSQDlNQOVx5AIvcSlffVSNq4F6T9XM4PW/7OPRqp63oWo9RglVrqv7EuBKFqixLyTMBR
         vmetF7KWRLbOgIwXaU6EGaSUrk9zisUarMOo0tMUu/2ViUdYhFzrx3J+rkfFUzE/y2Dm
         hxvtEsLG4V9ekqbBmr8o9HSox082QnTnTCfp+09woYIscGIKKpJez0kZ7/EVBAzD2/4x
         VKDrkiaZtQpywzkGyg72C3wCPf+xBv0w6EU8rLjuLQsMQc/jgC+YOjNIzSbdFa/rLCgK
         toxw==
X-Forwarded-Encrypted: i=1; AHgh+Rqs6OSPfNCGkMC0/K4KEOSOvrwhom+WWCUlexRGAwpTLfl+K6wW6xZslne+0osOH/cMXArNWlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyok3A48gDTDiFNvbMhaYP+UCCT0C4TU8KqU/zu6OH1ecbqBm4Y
	TQm0AigAcMvTd8Q2EKINHOo+LgMlvpVT/UQq76EH12KZcy7qUA3qwz7EWVOumP1LzKUMUrwTByk
	ujIPOX3V1qwlC9T5n6/EAESzFUcpnP4VCSeblP3NF
X-Gm-Gg: AfdE7ckzzMmGNyBAJ0qFYgDB5a8P3KwFTSvaTKQayPbijOCkeaRTPaRzOOO77GRmje8
	FDyaPk8k62wcQ2ZUgGgvIGhXox0xZ4TTvU1wryufL/l8o+q4HS0jQSltTaMPilOjaV+og7USlUB
	KpYZ6PNliBgI8ZA3Vv3M2AMofDmxiFAEbmYXcX/CftYEjM+fEzUg8uPHVLVlplDfydbPo/6+hNI
	/p9S3KUZz4zW1uXsN5Jj1I0psnSLqQhGH26MeQfBZWtmE+BwMdeFvhuXzaRJIaXYnCfE++B5e1H
	YokEc6wJwc4QjYGTcaACnyq6Ois2593+y7A=
X-Received: by 2002:a17:903:2287:b0:2ca:ce92:6e44 with SMTP id
 d9443c01a7336-2ce9eae2ae8mr145661205ad.8.1784050998398; Tue, 14 Jul 2026
 10:43:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710014109.536177-1-xmei5@asu.edu> <CAMArcTVGfCzcnOrrKFRqD0a6Q2LgC19Yge1Lh2fvKMx2oqwtmw@mail.gmail.com>
In-Reply-To: <CAMArcTVGfCzcnOrrKFRqD0a6Q2LgC19Yge1Lh2fvKMx2oqwtmw@mail.gmail.com>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 14 Jul 2026 10:43:07 -0700
X-Gm-Features: AUfX_mzxZz5-0OHc6Eq88oWLu-8Ky5UYJXDLo69nU9efd4veEXkajBOF9HRXstA
Message-ID: <CAPpSM+RSrDuH4nvM8LYiFLYBR2818hYGaTT3uPHg_ez2W3=WEw@mail.gmail.com>
Subject: Re: [PATCH net] amt: refresh cached IP header pointers after MLD/IGMP checks
To: Taehee Yoo <ap420073@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307542-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ap420073@gmail.com,m:kuba@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[asu.edu:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,asu.edu:from_mime,asu.edu:email,asu.edu:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 75AC2757930

Thanks for the reminder.

Xiang

On Tue, Jul 14, 2026 at 6:16=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> On Fri, Jul 10, 2026 at 10:41=E2=80=AFAM Xiang Mei (Microsoft) <xmei5@asu=
.edu> wrote:
> >
>
> Hi Xiang Mei,
> Sorry for the late reply.
>
> > amt_dev_xmit() and amt_update_handler() cache iph/ip6h before calling
> > ip_mc_check_igmp() / ipv6_mc_check_mld(), which may pskb_may_pull() a
> > non-linear skb and reallocate skb->head. The stale pointers are then
> > read (amt_dev_xmit: group.ip{4,6} =3D iph/ip6h->daddr; amt_update_handl=
er:
> > ip{,v6}_eth_mc_map()), a slab-use-after-free. tx is reachable by an
> > unprivileged user whose amt device has SG enabled; rx by a tunnel peer
> > sending a membership update fragmented across several IP fragments.
> >
> > Reload iph/ip6h after the check returns, like commit f0e42f0c4337
> > ("ipv6: sit: reload inner IPv6 header after GSO offloads").
> >
> > tx path:
> >   BUG: KASAN: slab-use-after-free in amt_dev_xmit (drivers/net/amt.c:12=
38)
> >   Read of size 16 by task exploit
> >    amt_dev_xmit (drivers/net/amt.c:1238)
> >    dev_hard_start_xmit (net/core/dev.c:3905)
> >    __dev_queue_xmit (net/core/dev.c:4872)
> >    packet_sendmsg (net/packet/af_packet.c:3114)
> >
> > rx path:
> >   BUG: KASAN: slab-use-after-free in amt_rcv (drivers/net/amt.c:2530)
> >   Read of size 4 by task exploit
> >    amt_rcv (drivers/net/amt.c:2530)
> >    udp_queue_rcv_one_skb (net/ipv4/udp.c:2388)
> >    ip_local_deliver (net/ipv4/ip_input.c:262)
> >    ip_rcv (net/ipv4/ip_input.c:612)
> >
> > Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
> > Fixes: bc54e49c140b ("amt: add multicast(IGMP) report message handler")
> > Fixes: b75f7095d4d4 ("amt: add mld report message handler")
> > Reported-by: AutonomousCodeSecurity@microsoft.com
> > Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
>
> Thanks a lot for this work.
> However Michael Bommarito is already working on this.
> https://lore.kernel.org/netdev/20260711151934.2955226-2-michael.bommarito=
@gmail.com/
>
> Thanks,
> Taehee Yoo
>
> > ---
> >  drivers/net/amt.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> > index 951dd10e192b..8bc61c539b0a 100644
> > --- a/drivers/net/amt.c
> > +++ b/drivers/net/amt.c
> > @@ -1210,6 +1210,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *s=
kb, struct net_device *dev)
> >                 } else {
> >                         data =3D true;
> >                 }
> > +               iph =3D ip_hdr(skb);
> >                 v6 =3D false;
> >                 group.ip4 =3D iph->daddr;
> >  #if IS_ENABLED(CONFIG_IPV6)
> > @@ -1234,6 +1235,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *s=
kb, struct net_device *dev)
> >                 } else {
> >                         data =3D true;
> >                 }
> > +               ip6h =3D ipv6_hdr(skb);
> >                 v6 =3D true;
> >                 group.ip6 =3D ip6h->daddr;
> >  #endif
> > @@ -2498,6 +2500,7 @@ static bool amt_update_handler(struct amt_dev *am=
t, struct sk_buff *skb)
> >                         netdev_dbg(amt->dev, "Invalid IGMP\n");
> >                         return true;
> >                 }
> > +               iph =3D ip_hdr(skb);
> >
> >                 spin_lock_bh(&tunnel->lock);
> >                 amt_igmp_report_handler(amt, skb, tunnel);
> > @@ -2517,6 +2520,7 @@ static bool amt_update_handler(struct amt_dev *am=
t, struct sk_buff *skb)
> >                         netdev_dbg(amt->dev, "Invalid MLD\n");
> >                         return true;
> >                 }
> > +               ip6h =3D ipv6_hdr(skb);
> >
> >                 spin_lock_bh(&tunnel->lock);
> >                 amt_mld_report_handler(amt, skb, tunnel);
> > --
> > 2.43.0
> >

