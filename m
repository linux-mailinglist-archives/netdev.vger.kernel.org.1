Return-Path: <netdev+bounces-279677-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Pg4K07f5Wk1owEAu9opvQ
	(envelope-from <netdev+bounces-279677-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:09:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51975428056
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 10:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C5DD30089A7
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EAE386426;
	Mon, 20 Apr 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRWduUQg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF18D3845C8
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672588; cv=pass; b=Dl4tTNiE0hdgFi1OlED4MTz4+bqJ8PLgW3E1KA6FI6Wd8pDwzzMOvpzIekLvJV0Q2BVpfuOrSwSMOn9Dvd1BtS/WNqwqE+y8i/xNOHQesvcV/WVcrXKqa+mRwzgdSiD8HoyTP4MYNl9z1qt5XnBZ2M5ZZ6VxPvaTRV00hZ+o6vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672588; c=relaxed/simple;
	bh=LVEP0scsmITC0MJJGvwyPcEMuMmnB92hZivB/DSnqko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfJLIO/NHeSYrjFPGcUjIepF42OX0jSBnatNCyl+KmLl+uAM/hBfutFFZLU/RYPrv7N0spXPww/AJ2RCbpqpaVFzYUChk5OEGenBDM9E1Wa0lZ5MzYsrl44pJ5hYGRyTbSqOI7uEegkgK0GzaQZBZEMNltlPmcscDWnL70OHVZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRWduUQg; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38e68e4389cso28604161fa.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 01:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776672585; cv=none;
        d=google.com; s=arc-20240605;
        b=PxJRWQ4GK0xMAK/pAbbBMVB4MT2VvDX2yjLd3+WNNqh89elCMYdnEzrpw3JlZj/19j
         O4vga3eSlHBZ/YQCgvUtNCR9zhvrU9PsdhL/2wF5SSmoYC5OAUgBYaXc5FJgaDQMKCqA
         VZ2edcT5yTwMl5CjkFdPa5z6zHbbXcWm152vx3bl5pZp/pF57XDX41w7a6MWbz6/C62f
         6z/SPbR2o7eYv249sr6gxioqrVC0amYhDM1zl440KBePHB20BD8LkvTBgVJjuzh6wIts
         qKe1liH/98dyLW3vrklt1nHb1VdlPWpdRbaWiT2sqqYhuKB4NN4euAhPEl8M4dCwRtQN
         6k2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Oby7Bx0gK5ynnasEbalEDWMKwfDNOligTGO8x/b0ik=;
        fh=JFsQ93LvTDSqUZTagbxrytryNzlioAR3ZCFwSOWJKcs=;
        b=kyceMjotW1fnE48W2Lxw3USwnhgieZ2XakUHMgVJTEVAO75VD0Re8XLukdL343ZScm
         PL7dWhj5KXhOiYUzJmzpBvudUriu1eQTUXKPQOa1dBXZBkoLC0oXwJLFXtqs01m1LigC
         Vjz5G5m4AaU7Gs74sH79oa3YX1FThXTvxl1Vq4zGAH62RLRK9UCnLY2+hEW1UdFivfMP
         OFOTx/FwoclvxVOgnMnQgoecstIedW3YxY9gXdZya04ru7SwsQ0c1JnTq9xuUaSg5uCO
         3EDjS7WwC4pMB50XZGUhRTSyNsaYkDdGjNPK4RVs1EVfdWJGCIMAs/EnUR6ohXkUGatZ
         1jgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776672585; x=1777277385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Oby7Bx0gK5ynnasEbalEDWMKwfDNOligTGO8x/b0ik=;
        b=gRWduUQg96VobcTkwI/x7t/xd8INJ1k+DNN7vHnMPaLiJUOx6WQw3eJlFsTY1ni9v/
         n6WXNkxCTwBbJ/N0UOvq4MffNbjA++YviC3WpIbLrvAzCFn6TmrNY3D1dgWbG11WjYg0
         tKCPsgZsA5GC3wdohvsPg02Y2gn951CFFWH62XPTONZItpA4U7W753AFKZgYbch7cxD3
         m3XJ38o63PkSgE+5O2ieNbvnfsO8FoWL6O/GAPolDLSgds53AYGtjzEDB24h8y86MuIv
         TpQTGZA+AQU7n2bRaZ1nZyb+UiV4M6VCzGvtPpLveol/APRcjjSxxbQGeiLt4hae8Z/L
         B3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776672585; x=1777277385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Oby7Bx0gK5ynnasEbalEDWMKwfDNOligTGO8x/b0ik=;
        b=AB31RzbOJUQTwF83jnve1zYIAsqlFM7hxqHjqe7DqXDUZ1ceROj2LH22KGG7S0VH3j
         dutioxTMYcAG+1b22V6S1ZNrdglMcE6llMamXR+cS2CtQO5IPp7s77umZa9IGMHUSy/P
         KNJ7fxqlVcLo3JzajGrcCcZG2cWAVl6ZHGYMQJttYt8rm09EKC0sPj0YhUhGkyCm/ErB
         gXEj0BvYetHWlNj0Z4EyEI3bZ9BFNeW6vKlb58TnnC/6/PMhse6cSdHYERTBY8uC6DTb
         IslcNPlL/jOcCiyFCLRrGxWjlkbi7EvlZjq7oRk3sOADuPYPurTDwfjvxp+v3GXtS8OB
         tX2g==
X-Forwarded-Encrypted: i=1; AFNElJ+qx/dGshsn5tOk44zmOzHVTndct0LVocKIHWNDe9EpAHjRUhvCzLT5ZR6zmNQ5Z3RvbcrDYV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Jx0nPI7aSBVQG20G2risy8pL3kg+8rJnsZynIaFaQuvlc3Oa
	hRWgs2BFFZ9L5pef8rAD+sxNSrKEx57Fsj3bgaZcmVu6XxfQ9gJjmi8KSqRqvRMrdtTSddEPUjD
	Txm/fIPUg3RbwG93hn2HfO9DoT8LQeIU=
X-Gm-Gg: AeBDiesXBi3GL3E289EwwbkjsqXwaXnK6Nttdu7vuCJa8K+rK438sI+1vn+bL17N9oP
	73r+RL1V47ILsLwAf+GsFrDgbnDn+Ky7V+t1OwqZkEFcZe4b4Xk5PMTwFevwrTos6e0tEqOPDPH
	a2szcAGL4pY1nP0K4T8E6+pJ/nTIuRIapSJGnjfN1msE2QhECXWcmGboVbi/x/jXHMX0T/4kwSs
	IrGXrd7YnirFrUCpnsbsS+D4htkz4IUpEuGRBv/nGs6E2mP5e1hJa8VBqn6nvazguxCHohpZmlS
	atp+ce+Bg67ANt9G
X-Received: by 2002:a05:651c:1b97:b0:38e:9eb1:6949 with SMTP id
 38308e7fff4ca-38ec7a4340cmr38995391fa.14.1776672584503; Mon, 20 Apr 2026
 01:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
 <20260408125333.38489-1-xiaoguai0992@gmail.com> <20260412135743.GK469338@kernel.org>
 <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com> <20260414112951.GD469338@kernel.org>
In-Reply-To: <20260414112951.GD469338@kernel.org>
From: Kangzheng Gu <xiaoguai0992@gmail.com>
Date: Mon, 20 Apr 2026 16:09:31 +0800
X-Gm-Features: AQROBzCGapSVEfgxkUaxukutheG4b1zMtlvabc9F8b6CSvfsjnb81jK3l8njad4
Message-ID: <CAKvcANPEa91paujTQjpW2hZhpXEhwfOjjy6CsN=OJ32iXYXdTA@mail.gmail.com>
Subject: Re: [PATCH v5] net: caif: fix stack out-of-bounds write in cfctrl_link_setup()
To: Simon Horman <horms@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, kees@kernel.org, thorsten.blum@linux.dev, arnd@arndb.de, 
	sjur.brandeland@stericsson.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279677-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 51975428056
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for all of your advice, I am preparing a new version of patch now.

Simon Horman <horms@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=8C 19:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 13, 2026 at 11:30:53AM +0200, Paolo Abeni wrote:
> > On 4/12/26 3:57 PM, Simon Horman wrote:
> > > I am wondering if it would be best to follow the pattern for
> > > writing linkparam.u.utility.name elsewhere in this function.
> > > That:
> > > 1. Uses a somewhat more succinct loop control structure
> > > 2. Silently truncates input without updating cmdrsp if overrun would =
occur
> > >
> > > Something like this (compile tested only!):
> > >
> > > diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> > > index c6cc2bfed65d..ba184c11386e 100644
> > > --- a/net/caif/cfctrl.c
> > > +++ b/net/caif/cfctrl.c
> > > @@ -15,6 +15,7 @@
> > >  #include <net/caif/cfctrl.h>
> > >
> > >  #define container_obj(layr) container_of(layr, struct cfctrl, serv.l=
ayer)
> > > +#define RFM_VOLUME_LEN 20
> > >  #define UTILITY_NAME_LENGTH 16
> > >  #define CFPKT_CTRL_PKT_LEN 20
> > >
> > > @@ -414,10 +415,11 @@ static int cfctrl_link_setup(struct cfctrl *cfc=
trl, struct cfpkt *pkt, u8 cmdrsp
> > >              */
> > >             linkparam.u.rfm.connid =3D cfpkt_extr_head_u32(pkt);
> > >             cp =3D (u8 *) linkparam.u.rfm.volume;
> > > -           for (tmp =3D cfpkt_extr_head_u8(pkt);
> > > -                cfpkt_more(pkt) && tmp !=3D '\0';
> > > -                tmp =3D cfpkt_extr_head_u8(pkt))
> > > +           caif_assert(sizeof(linkparam.u.rfm.volume) >=3D RFM_VOLUM=
E_LEN);
> > > +           for(i =3D 0; i < RFM_VOLUME_LEN - 1 && cfpkt_more(pkt); i=
++) {
> > > +                   tmp =3D cfpkt_extr_head_u8(pkt);
> > >                     *cp++ =3D tmp;
> > > +           }
> > >             *cp =3D '\0';
> > >
> > >             if (CFCTRL_ERR_BIT & cmdrsp)
> >
> > I agree that the code suggested by Simon is clearer. Note that AFAICS i=
t
> > lacks an additional `tmp!=3D '\0'` check to break the loop, but even wi=
th
> > that added it should be preferable.
>
> Sorry, I left out the `tmp!=3D '\0' check.
> That was unintentional and I agree it should be there.

