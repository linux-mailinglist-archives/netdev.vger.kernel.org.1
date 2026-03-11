Return-Path: <netdev+bounces-266648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFHcK+JtsWlVvAIAu9opvQ
	(envelope-from <netdev+bounces-266648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:28:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C3330264834
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2B183001F87
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1142031AABC;
	Wed, 11 Mar 2026 13:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wakICEnW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B166F31AAAF
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773235632; cv=pass; b=Kpr5zM0BYIpIflAGJNduUlKmmjO5UFpKZV5tFcjnkKxiElgp+5WiKqakeQwy+KuwgvBlNV41ulOKFrINcL7Ou+joWR7x7vnEN+wZJN6EoclqSddscW7jv7QwJgUa/Vi1aW85xX/cJBP40bW1BCKZTGPdfnL/DKgj2hVNVS66HlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773235632; c=relaxed/simple;
	bh=x1fV68zR50XdjvYdrXqInhAsqBdrON62F0GQ1SojPrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzINC2Nn7iCkNOIxmcJrwhrH21yTMt4f+dAUP06ruvTEfBdX4Wh4ZoLc9aZ8UqIK4HAUZel7+2aWnfo7pyx3GH/zkshKtQFDWaLYkHeCn5nf/jzUm9DmFlREQYKdsDp4+cf8+IK2cZl43gq6iYIIa5FEd6yN2+8QR3PkFWM+7Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wakICEnW; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-509046c5c7fso49082151cf.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 06:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773235629; cv=none;
        d=google.com; s=arc-20240605;
        b=Hmr2kO/db5z8vx8TDycVUpSw6515TEEtN65MtWzaqH2Y9jYslAogsU230G46oKNuSG
         26WBZYBxOCmaJ4zRwwm7PTJ2d0MbpsUxkLTeyvbHLvScnxlKJ1F97NCXG+4L44TvBaJ9
         YfV0OJLYG+B62jQREeRri9/QqTjnH4zFF5gnB35cCuFsGwekx3I/Z87sG/5xA1ce2MeS
         6iHcBxCABUgQ66U53vQdhMS9Nvg4o3cDUdPyb42U+QArRiJ7no9D2h1aNgwa3FAj6PYV
         oRtEXVpdGdloRbSDszaMhComwpf8vdsB8Q77RHf0aINfEVvnbG8kVIIDAhK5RHYycZo7
         NNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hww+gEbPOCsxMsGM/aS3dqcEiGvArOWp4G11eFA+gsg=;
        fh=aew0eDZBRxY+ivziZ1Uwp1GONzZ1iJKFFTqn6zxk85w=;
        b=jxAGU+5rEQ+skR5Wt/Id7HAand+cWLBDDP24exeloqGDPUuAH7/Fta8n129PLtpDSM
         MbAYez8fj0sIycIxbtOrhEPUYqlXYpv3+h6cvLHEgKPUbFM5zj8ISAUWQ2aNRnpXgsja
         dHCWMewsMXRfxuAvkeb2VSht+343eTBOTb/ISHBWxxZNSs4q0fESAIJWfITkDJ4nD20u
         L8wThxVm+4azBmfCaiXyyA0CT42zlu50RoxLnmRaIQR/2K6pKmMIkt9FL9aCbHOhs0cG
         77L8JWTOr2vV9wG5/dMdFxqugnvNZ91TmPYtp9QW5XA8PcXbdi+pwTP/AmQQxK2O/KPC
         CwWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773235629; x=1773840429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hww+gEbPOCsxMsGM/aS3dqcEiGvArOWp4G11eFA+gsg=;
        b=wakICEnW50uAllXmTUvp/Uuuuta5FvYGO0AUw1SOBTEkbVVWkOG0G+TlVEX4s5Cb8T
         lHjLOwQLgfa9XWEJFby6f7WvYM1RvmZ2f2qqAkgeRUA+91hpgbx0lHscRYDl2N48n8Q8
         fTQBXXm524EjqU8pT9piw3g+I+w2nLhdE20YGWfwEVAYVPl6fGwqCV2Zn3BW5Vdce3Q+
         KK/SjjzAP34HT2cT4qecd/0m/7LijD8aMpHmh04T9ftbKOjajYFAFwgGwVnvmY4pfjmd
         sXhVL9pEh95SJRs/wIMXdUvbDIEDdG5mYKSq6YarF7E6Jdr1l7gX5O0WJF6KIIM9LGCE
         WxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773235629; x=1773840429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hww+gEbPOCsxMsGM/aS3dqcEiGvArOWp4G11eFA+gsg=;
        b=rmiDy4rvbdEw2mbalxxxEKEjEyOVM/6tto5TlAlZ2VScw77T+5PeYJp48+YuN0ljfk
         BV2QyyeW9U4k3MTkyImhjW0pFedByhgFIgAgxdYL0aSJTDXpxrStfx3vmMu+RH+nDmEm
         RxDdoNzHyIax+1SpaE76DBSR4NW+UlQU+0Uo9ZxVmgcPmj3KydDlVDPlEvHKENDgd1Nj
         1p1R68norOkyYjK3k5LeSYIbu0qmP6M3MOFssUw3uVTybz8Tl80O6wQkoWF/hYTQveas
         nJdGa7N9ynaE0X/8Eh/UVoqzPkZo0gztuHeEa0GUAYqmsZVjRg36A6Tn793QCAT/GmwU
         DgFQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1blS8WYstycYKVJ47o+X1HxbesauKElvZFtrZ1N+9oy0Mbv+RmELcDw5fmkLCqBSMiklyU08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7Ht7UqMGyUEEznigrcg/4wZ8hvHYv9aQSYkAU4nmRe3rHSaj
	LYn5a/DxlAzsPyr2lk5yaYTW3cDGSterFmZRL36XzkVPecBLFWwGpAL0z4fRJ8hgr9wMRBFpfwI
	cqTApsPiydidtQKKNFW/Fe146GzzlBwAyEcGHoOqz
X-Gm-Gg: ATEYQzwZBNvcDqNKTBYSL/9S86PcoAM550zDcGP3HHJEOX6QwCMO95Cbvrrb4FbHvv9
	oLG/h7NU+6F6Xzu5p7Lmq9vQOCHAcRQesSRFPC1ZJmc9Wu9Ow26c1B6v1fidiPuhvholKIEa8s9
	woZKeX4B2zlFJQbDFZRgqwSuIxRHeAavDjiLSSsVSJFTbzZdIu4BIgRnUMWbcC1lk3JxQ7shfCT
	sbMDsWfxsb4hAgPUoF7ULKXeh39V53z8vw2x08G4B9oc4AYpKsHXa5JkRgZQFb+/H5Baq/ISDfx
	wNkNYaZm
X-Received: by 2002:ac8:5f0e:0:b0:509:1c3e:d765 with SMTP id
 d75a77b69052e-5093a17eb62mr30215071cf.45.1773235628813; Wed, 11 Mar 2026
 06:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310105331.2371-1-lirongqing@baidu.com> <20260311131935.GA2415888@shredder>
In-Reply-To: <20260311131935.GA2415888@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Mar 2026 14:26:57 +0100
X-Gm-Features: AaiRm53mLKyKMmg7vzNWKYn0nRuHheeVWc6FScH0DgBLyXOdwz5ru76AgH_yiD4
Message-ID: <CANn89i+PK6N0VJPQ_NtvHFizpnnrWb9AOPz=M0WyzsQGogsUpQ@mail.gmail.com>
Subject: Re: [PATCH][net-next] net: vrf: switch to synchronize_net() when
 releasing routes
To: Ido Schimmel <idosch@nvidia.com>
Cc: lirongqing <lirongqing@baidu.com>, David Ahern <dsahern@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C3330264834
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266648-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,nvidia.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 2:19=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> On Tue, Mar 10, 2026 at 06:53:31AM -0400, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> >
> > Replace synchronize_rcu() with synchronize_net() in vrf_rtable_release(=
)
> > and vrf_rt6_release().
> >
> > synchronize_net() is RTNL-aware and can use the more efficient
> > synchronize_rcu_expedited() when the RTNL lock is held, avoiding
> > potentially long wait times for a standard RCU grace period.
> >
> > Since these release functions are called during device teardown where
> > the RTNL lock is typically held, this change reduces the time spent
> > in RTNL critical sections and speeds up VRF device deletion.
> >
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> >  drivers/net/vrf.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
> > index 8c009bc..92a0f4b 100644
> > --- a/drivers/net/vrf.c
> > +++ b/drivers/net/vrf.c
> > @@ -755,7 +755,7 @@ static void vrf_rt6_release(struct net_device *dev,=
 struct net_vrf *vrf)
> >       struct dst_entry *dst;
> >
> >       RCU_INIT_POINTER(vrf->rt6, NULL);
> > -     synchronize_rcu();
> > +     synchronize_net();
>
> I might be missing something, but why do we need synchronize_rcu() here?
> The code below calls dst_release() which will only free the dst entry
> after an RCU grace period (assuming we dropped the last reference).

Agreed, this could/should have been removed after

commit 4f04256c983a4f115417d2009b44dcb7d70a6375
Author: David Ahern <dsahern@gmail.com>
Date:   Fri Aug 11 17:11:14 2017 -0700

    net: vrf: Drop local rtable and rt6_info

    The VRF cached rtable and rt6_info for local traffic are no longer
    needed and actually prevent local traffic through enslaved devices.
    Remove them.



>
> Also, I think that instead of using net->loopback_dev the code can be
> converted to use dst_dev_put() before dst_release().
>

Maybe in a separate patch ;)

