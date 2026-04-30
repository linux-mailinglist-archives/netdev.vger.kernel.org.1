Return-Path: <netdev+bounces-282871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAUbJgRe82lT1wEAu9opvQ
	(envelope-from <netdev+bounces-282871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:49:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 032C64A3A98
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C74083018280
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1508B40FDA1;
	Thu, 30 Apr 2026 13:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wf+pVWnI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995D0428462
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777556653; cv=pass; b=XmC5XgToZSZF/O/7ULLAHL1P+C/2lNC1G6SepzfWx7Oiai/p3bpcIbs/6rxq1rfGqBw5tjycWfuGKMWX6Wv8jPsBLE9PYC2sd6s4ZYOLcIlPVfeP0Z81ltfA25IIRUwxuSnBCv7ZHrVwS5JTElYrGMhnqg3EOJJbiPR+BcKS30g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777556653; c=relaxed/simple;
	bh=TnP9jw3J/tQZ8VNVBpmJIIoxKPuBGjgeD5iQCa5ZU6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P86JEYB8z60pfxfNbc/EGL1CaMIyyQ+sIzm25cH3or5BbrN8/rsiKQ1OquFTCSABVb86IEpiZZyGmVGvzLVcG8MFO9wGUSJ11KONxTxy35CQu1UJMnQ4inFWRvOPMaMss2aINfTOotP4vKOfyQyOO6kvT7VjjK//ceX3N1nUNPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wf+pVWnI; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50fb1932b62so6113771cf.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777556650; cv=none;
        d=google.com; s=arc-20240605;
        b=UU0FliuH4Jz1Omi3mmLFTxQzUIcP2O6RALB5qLmmcIXPG7IPzoEnYly1xpc1g1XFvx
         HxVAUAuSvAQa1swxG6ZduxJZWofHMOlQaHxuzs3OAvEP/RRoCwnlG7wxP4jzZZRrxq9K
         7N4sergML0PKXLVHyeON7kMY52tCVxQ+nF+KWR9AltKFkxyHgfJ9brL7T/rMWwFhylaw
         W77gsvwd9O2b3qm+Ryl3i9TqyoVt8IgWQzbqxmhn9hSRKWEjkKFKRwrSQFktCADxpUZk
         6Zo5B+QIBrzztjjTMeCIzVdG0Uan0Whh67D3p/RDbwScVRIsarbwimmRc9ry0KbBli+D
         Yrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3d3puXtDUADrN9NAWln8DOLDJZhYjr55R03Q795zRcw=;
        fh=XAP/NFhdQKj5EV/4sRjo2gudU1EN2dVwOItQVbby6O0=;
        b=MCSsxGbvCar8jQ+F1Oox9FpM4HRsPEFmMDDDqRtdc99Krk80jgkAV42pPqA2DFLL2R
         /CwynUQKcrxWPbxu/ldsKN1Vw+5we3AlvM1Hb7FEHh5RgyWW8SelrIkUP1ZIZjX+YZ6z
         sFrjKyMaEk5frAgAEHbLzB1coLgNOwIHk5g3TtgbYIIagKdpr73rNfhIOqCCjEhuTQ6h
         ttXzXBGS+CC654VYnqAIwYQbtOKdqhVPHteiUgyOQH2J9A76Ckt3MjzCTUl4Ch8zN0U3
         bnEEitfWuGxojzwGqDHjq6adw2yxNNzZCvajeMQR0d2WCNjWUMcOmUycm+9TsLl+VhcJ
         K4cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777556650; x=1778161450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d3puXtDUADrN9NAWln8DOLDJZhYjr55R03Q795zRcw=;
        b=wf+pVWnIuDgevLTi3ancMey0ky+CTP0f7mMBkXBG4AE0HuWe/A6MbKTvAN1ElwqmCj
         2d1y04oqI3neErE28qqDh0p0rX+ljWXAyiak/FveOR+IjofZLDGlaS9q4KbA60RasoMs
         J+XS5LM5IYrdBP4DpS3CADZ1ulLjdb4EEZQdFdQRpQQbaU41OufUuUD29EZm+eMTukJu
         QA+fHtKRK71r5mIlFYwOAG5dXB7EVmQ1AXQAO9Xl4MFCiU/PyNpJ7jytx6Vt8uslH2u9
         H3j7Gy8cplOe2qb59bWg5pYkOg2zyci+xoZXEOXvYmzdpnrNICJiSXmGfeMAP9rpsK2A
         mFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777556650; x=1778161450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3d3puXtDUADrN9NAWln8DOLDJZhYjr55R03Q795zRcw=;
        b=UwV45sDFVUlTRg6uXtxiuYMRHfoOyXwdMh7hgfM6m+NmyIpkZqE33KqZR8Ok4m4qgw
         bb0qkAMkqvNVfcgM+wrbeqZetn1aa2FK+d5PO74lb5Wj6NrmViWlTZgH5iyODd3ws9vg
         SJCpYZkZworZ4PIknuOgpaga0+mc7ksOYYjAwG2qSRELLuE/shdXkJhQc89Dktbhxoa9
         Ldg/ZnMJUsadd9R8YjjaQaDOX6u8K6FPIq8DUHraiDM36xClk2dxY3sJV47pIXo4B/Oc
         ou1kq3yu3fYaGRhceAM/Pfc/VXN9mcS3VBk8kqkjGlvI1SplssnwYFvyiTHedvWSKbXH
         X0ZQ==
X-Gm-Message-State: AOJu0YxqVpgSWRISk4noQ05corQAju2RLRaTc1nhZ9kKIDRaK9SerV60
	czWHPASdylcGkuTNxiIb265BiA/GtPQjmGUuk2Lujvh8MQwaNmKNrBq617aedLcm7WeMe0on33D
	D0tIabcsJvzmgh+iwEJoGJuMh1kOiEAq/DViIGVRi
X-Gm-Gg: AeBDiesupxDMi72Gu1SQ4r69SeEkdsLM6Nz7WKjZ5PPEEXAE5Go0H/ZI1NZOVtPzcHp
	v8ituJ90A35haE0Wj+JASnT3Q2tH2YieYdJAGD2SaV5NsF8Yc/y54aFPionMmQxRlWyTHuxuD8C
	4bVmWiBvod669ivEgNOHhKuY/jBvZb3axZFnCteTcc7JSE4IL5+Ez//PnZNAZvhThmE3HQ5qJBk
	5e6UI5AiS01nITEKEYH7cLMEX5gnugCO+71S16SCMrHZVNvj1s3dwifn+HIqdZcjZyNrPkzw4vE
	/1oWSm8UhX0hNYTYYY5994OQulw4GpPRfZ1dveAUNxhQIanmaHx3BfusOYKoOWDD8n81R50aRfT
	+1xh+TgcvYaTnNfZQoxIOEZwDVTKylkYkUwe6QyYG
X-Received: by 2002:a05:622a:82:b0:50d:a6a0:8f09 with SMTP id
 d75a77b69052e-5102ae4fd6emr37741691cf.39.1777556649898; Thu, 30 Apr 2026
 06:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429120120.514491-1-antonio@openvpn.net> <20260429120120.514491-3-antonio@openvpn.net>
 <5b281966-c278-46d5-ade0-9dc24175de6e@openvpn.net> <CANn89i+kGAXWEmgSwrUyRhh7kk6r3FjEza9mjDXq4AjwbC5DZA@mail.gmail.com>
 <4930aa65-6d0e-4ff8-8e7b-91feee1ce646@openvpn.net>
In-Reply-To: <4930aa65-6d0e-4ff8-8e7b-91feee1ce646@openvpn.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 30 Apr 2026 06:43:57 -0700
X-Gm-Features: AVHnY4JCUK6121wLzGPyIXP07d-igAqYP1lRcIrIUyh29nqRNsgJArzNCdJ30Cg
Message-ID: <CANn89i+5q8D50sEKUwk1OzGt8tZD2ddSK-kHGq6dFm5QRRpaDQ@mail.gmail.com>
Subject: Re: [PATCH net 2/2] ovpn: ensure gro_cells_receive() is invoked with
 BH disabled
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, ralf@mandelbit.com, 
	Sabrina Dubroca <sd@queasysnail.net>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 032C64A3A98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282871-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:email]

On Thu, Apr 30, 2026 at 6:40=E2=80=AFAM Antonio Quartulli <antonio@openvpn.=
net> wrote:
>
> Hi Eric,
>
> On 30/04/2026 15:37, Eric Dumazet wrote:
> > On Thu, Apr 30, 2026 at 6:28=E2=80=AFAM Antonio Quartulli <antonio@open=
vpn.net> wrote:
> >>
> >> Hi Jakub,
> >>
> >> sashiko came back with an interesting review of the per-cpu stats upda=
te
> >> in the surrounding code.
> >>
> >> As far as I can tell its explanation makes sense, but I am no per-cpu
> >> expert.
> >>
> >> IIUC it basically says that if gro_cells_receive() is invoked with
> >> bottom halves disabled, the following dev_dstats_rx_add() should be to=
o
> >> to avoid deadlocks and corruptions.
> >>
> >> See below:
> >>
> >> On 29/04/2026 14:01, Antonio Quartulli wrote:
> >>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> >>> index d92bb87be2b2..c0fdb9504241 100644
> >>> --- a/drivers/net/ovpn/io.c
> >>> +++ b/drivers/net/ovpn/io.c
> >>> @@ -91,7 +91,13 @@ static void ovpn_netdev_write(struct ovpn_peer *pe=
er, struct sk_buff *skb)
> >>>
> >>>        /* cause packet to be "received" by the interface */
> >>>        pkt_len =3D skb->len;
> >>> +     /* we may get here in process context in case of TCP connection=
s,
> >>> +      * therefore we have to disable BHs to ensure gro_cells_receive=
()
> >>> +      * doesn't enter deadlock
> >>> +      */
> >>> +     local_bh_disable();
> >>>        ret =3D gro_cells_receive(&peer->ovpn->gro_cells, skb);
> >>> +     local_bh_enable();
> >>>        if (likely(ret =3D=3D NET_RX_SUCCESS)) {
> >>>                /* update RX stats with the size of decrypted packet *=
/
> >>>                ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len=
);
> >>   >>             dev_dstats_rx_add(peer->ovpn->dev...) << not visible =
in the diff,
> >> but it's here
> >>
> >> from sashiko:
> >>
> >> Can this lead to seqcount deadlocks and stat corruption since
> >> dev_dstats_rx_add() is executed with preemption and bottom-halves enab=
led?
> >> dev_dstats_rx_add() operates on per-CPU statistics and protects 64-bit
> >> updates with a sequence counter (u64_stats_update_begin()). When calle=
d
> >> from process context with BH enabled, on 64-bit systems, this_cpu_ptr(=
)
> >> is evaluated with preemption enabled. If the task is migrated mid-upda=
te,
> >> it risks cross-CPU stat corruption.
> >> On 32-bit systems, u64_stats_update_begin() disables preemption but no=
t
> >> bottom-halves. If a softirq (e.g., a concurrent UDP packet reception)
> >> interrupts the process context and calls dev_dstats_rx_add() for the s=
ame
> >> interface, it will re-enter the seqcount writer lock on the exact same=
 CPU.
> >> This corrupts the sequence counter, causing readers to see an unlocked
> >> sequence during active writes, leading to torn reads and corrupted sta=
ts.
> >> Should local_bh_enable() be moved after the statistics updates to ensu=
re
> >> the entire per-CPU update is atomic with respect to softirqs?
> >>
> >>
> >> Do you have an opinion?
> >
> > Sashiko suggestion seems good to me.
>
> But am I right saying that this bug existed before and it is not
> introduced by this patch?
>
> A concurrent softirq (UDP RX pkt) could already trigger this problem
> before we introduced the local_bh_disable/enable() calls, right?

I think we are saying the same thing.

Let me rephrase: The bug was introduced in:

Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")

Please respin a V2.

>
>
> Regards,
>
>
> >
> > Proper Fixes: tag would be:
> >
> > Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")
>
> --
> Antonio Quartulli
> OpenVPN Inc.
>

