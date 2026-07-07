Return-Path: <netdev+bounces-305422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TGsBAwfnTGo8rwEAu9opvQ
	(envelope-from <netdev+bounces-305422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:46:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BD271B148
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:46:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gYknfFYt;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305422-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305422-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23315301038E
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 11:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994D33F88AA;
	Tue,  7 Jul 2026 11:40:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDB43F825A
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 11:40:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424434; cv=pass; b=c6kzpLAMQ0pDGmHaI57fYkX7z/aujFPU5nWiibHz2UGdiUeFcbX/4lm6VV/UPOqbyCE8UGIwIDlQHS/EroPTDATjkIjx/wBJ2jjmEV9Y8OQbngzdIK0Oc/f5Ct926djeoFCPSxO3Qdlp6NUlKCKtlI1VHpykRK5g1lNCKnXhwb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424434; c=relaxed/simple;
	bh=qsSIlGvtUa6Ev2OxoN0AWf0GWpIUlJyIzJM+lterdBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UOmBXJJhFAmkNObF19jP2sKNdd6WFRSzGs6IeH8dTEw7G9x9vlLLJqufs0xyQd/g3omKQAvthyYDvsyw7UFcVTCNLON8HOTSYjNgaHpyJQI7A1yAATJ62CmMifvLBDlRnNYGoAXj16Sci3N2+SUIqthGmG8tVuOi5+0r1Kot+/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYknfFYt; arc=pass smtp.client-ip=209.85.128.181
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-80e4455b9a3so59993777b3.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 04:40:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783424432; cv=none;
        d=google.com; s=arc-20260327;
        b=R9FJITBLTvv7NNtfO0LNH0m1xrQ5xN5JiAX0wmDfaHU1E3LVTcL60gSNZzdxKiZ48k
         ylBOS2W3nF+weJJD4r2RvDFrbFf3vERsxOca7fCSF7CsaQMK3R/YolwUJXr7Rg3miML7
         KP7TBeSMYP0MEHuF6hMsze0ntGEE07NRxiBxQQJpt9uzODMQa5CIh8x8s3vN6m5kqc59
         H1AOhwjW/Er7N9O6dsxdBw6/s/rKTZvtjUu5iQYCY8akw7XAwXbYMA0Bhh1pIG+auhZk
         GGkO4gojJY+Ap/UWbhmQBhb/1H55L29kodeAjHHnHIVi8odKsdwV9xBn+OERHAXQlzkt
         xVdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qfE3C/0RnrpbeQ9ijBQ/I8RGoMNTNylngtz6dFwoz+k=;
        fh=qi7DRimEHJBucHaN/nAlsLnUybFy0gbj9AgJfloiLMM=;
        b=ibz7i10Yf7zYJYFWNuCTak2HniyALiizlrucAMJLQKZ7Bg78Y8fVfCBbnXbIxZKmmr
         qZdMLYQ/KJ14/EgIiXln1vxmmfQK0tQXP6f7fdfCUex41PLV51NF5kgIRQeK1zGccnHm
         r+7GdjW55sMxS1q5BgaGHNCWx879p39Wt4svR1w3qWsYgod046NUI0diMJ2M0TzLnvSj
         DV2Ohx4yMF4ilfajQWnAsEpEEeo+2i5uskUWvjnUFFxwdSG3lkhIxLyMD8akTCa9Hq12
         XV/y1kVgGYYmNPe2YPfcKo0OU7okqwSIUrBVACAtt3CLdxpyTnjAhWlnQ4ax1d7sPKwx
         23HQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783424432; x=1784029232; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qfE3C/0RnrpbeQ9ijBQ/I8RGoMNTNylngtz6dFwoz+k=;
        b=gYknfFYtHBq01MEWDKTWOjfwI2HhjlVbNRWLzeUZ3T4VPfz0ivh/348aMkV69AEj2I
         pMKoj3QKu17YOOsFRwQwe7RLmbRKuNh2eA/He4Ef0idz2q+Jya1o0i02K77CY9CGlZRX
         7ZLdHGYW7ugXzelhWxuHCojpJ+tf3DCDibyCNu0dyHD14mm7fNHEwFHcMFerKlKJuoqj
         MVNQ2uwne6mwHH/m0dPtDoejWOZQF91SiY9oHUUYqFEPoZyJPokD5xgatkWRNuCUTtBD
         cpPm3dvJv0RMuBuiYFhjItbmc1nXDXar7ESntchAEDlm5il+PIahBqpaLiHGk6wIBRvy
         w30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783424432; x=1784029232;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qfE3C/0RnrpbeQ9ijBQ/I8RGoMNTNylngtz6dFwoz+k=;
        b=AjjHnbDjQSek56kMV/Ic8BOgpno0H/WFtb02yn1iemBM8/4ihn0TAYM0SoFaMrwFtu
         IdwsHAWIcjQTqVVkcgLOc8PjltRkIi8naVLauc4ujeHck/EHXY7JbFCEhvBKtaquRCkK
         whck2lPGeHVhJCm3M/8Q7aXtyy8Yq299tB5wqhmlXxADBaHYloZ6ZqVjNWz3vOtd/QDV
         1obbeFdw5xqVM2JPOsIqepuedNFaFA/2yvm9x7dc2t5LsempUaMo8GFtSNGfQ2hsGL4R
         ow3TIVexVh7U7Sz7QhCW6cbe5QPcBo5XkZeZCw0+/0J+WW2P8r4A3SEQNYenhBypk3xB
         2sXQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp8Pr3Y0hh2/lRAyRoh8P2iZ0+twDAAXGLUDrJBIqOTHvNGNgDhBcGhA7AOqhzo9iMGf7ynKlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/YYKvqonZKVz5IQe96EWiXEhAd9o0hNMNSLJpQytjnE4wfOM6
	pwrnkSs7F1Cwx/OlkqCZu0DXQH+pwHbkB97NSwOvdBcFukXZivBjuFdfpGm8wQrIHgAHMIbJf80
	OyX00L90pYcjgVGmgVwn2tnTzwV3V9gw=
X-Gm-Gg: AfdE7cmbLhsQVtdMCZzY2EKNdh6rj1GnNfos/ttiLUjSsmDTbsYHeJK/EzIyjPWcMOy
	3VFByp3M/rczQx/WIQ+M1krBAq72zyEL4/OZhil5MVYUh/k4PNafz2Ot6qmjpqlUIrviIYhZw4W
	w7jpz6+TGA58TjKmsVlQx6WRZ/t6L2WLd2SftMG7PT1gj4LUrzfaFF0kNq00wMhH/31ctTMmh1d
	XGFeX3xOHibtV05jmP+42aimvgHripg2sydx6pkpv6XLvyYRY2iHODkTPAmc9S3fUKhmI/9yA==
X-Received: by 2002:a05:690e:1181:b0:664:820a:b6b3 with SMTP id
 956f58d0204a3-6677fbea911mr3608481d50.37.1783424432116; Tue, 07 Jul 2026
 04:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707010622.487333-1-zhangzl2013@126.com> <9e8f5dfe-d66b-47c9-b7d9-e57ed2aa6fef@linux.dev>
In-Reply-To: <9e8f5dfe-d66b-47c9-b7d9-e57ed2aa6fef@linux.dev>
From: Hangbin Liu <liuhangbin@gmail.com>
Date: Tue, 7 Jul 2026 19:40:19 +0800
X-Gm-Features: AVVi8Cf_ZS00DfumTeeWMU5AFkYeKsaxeRvvKUyQoKEmeEYEDwpNpA-4uC-wjxE
Message-ID: <CAPwn2JToXLux-d8gjf_vedUT6KN5k5RW_KjYXXUKWS7grDqy1A@mail.gmail.com>
Subject: Re: [PATCH net] bonding: fix devconf_all NULL dereference when IPv6
 is disabled
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: zhangzl2013@126.com, Jay Vosburgh <jv@jvosburgh.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Qianheng Peng <pengqh1@chinatelecom.cn>, Zhaolong Zhang <zhangzl68@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:zhangzl2013@126.com,m:jv@jvosburgh.net,m:andrew+netdev@lunn.ch,m:kuba@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:pengqh1@chinatelecom.cn,m:zhangzl68@chinatelecom.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305422-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[126.com,jvosburgh.net,lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org,chinatelecom.cn];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,chinatelecom.cn:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 38BD271B148

On Tue, Jul 7, 2026 at 6:35=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 07/07/2026 02:06, zhangzl2013@126.com wrote:
> > From: Zhaolong Zhang <zhangzl68@chinatelecom.cn>
> >
> > When booting with the 'ipv6.disable=3D1' parameter, the devconf_all is
> > never initialized because inet6_init() exits before addrconf_init() is
> > called which initializes it. bond_send_validate(), however, will still
> > call bond_ns_send_all() even ipv6 is indeed disabled. It will lead to
> > NULL derefence of net->ipv6.devconf_all in ip6_pol_route().
> >
> >   BUG: kernel NULL pointer dereference, address: 000000000000000c
> >   [...]
> >   Workqueue: bond0 bond_arp_monitor [bonding]
> >   RIP: 0010:ip6_pol_route+0x69/0x480
> >   [...]
> >   Call Trace:
> >    <TASK>
> >    ? srso_return_thunk+0x5/0x5f
> >    ? __pfx_ip6_pol_route_output+0x10/0x10
> >    fib6_rule_lookup+0xfe/0x260
> >    ? wakeup_preempt+0x8a/0x90
> >    ? srso_return_thunk+0x5/0x5f
> >    ? srso_return_thunk+0x5/0x5f
> >    ? sched_balance_rq+0x369/0x810
> >    ip6_route_output_flags+0xd7/0x170
> >    bond_ns_send_all+0xde/0x280 [bonding]
> >    bond_ab_arp_probe+0x296/0x320 [bonding]
> >    ? srso_return_thunk+0x5/0x5f
> >    bond_activebackup_arp_mon+0xb4/0x2c0 [bonding]
> >    process_one_work+0x196/0x370
> >    worker_thread+0x1af/0x320
> >    ? srso_return_thunk+0x5/0x5f
> >    ? __pfx_worker_thread+0x10/0x10
> >    kthread+0xe3/0x120
> >    ? __pfx_kthread+0x10/0x10
> >    ret_from_fork+0x199/0x260
> >    ? __pfx_kthread+0x10/0x10
> >    ret_from_fork_asm+0x1a/0x30
> >    </TASK>
> >
> > Fix this by adding ipv6_mod_enabled() condition check in the caller.
> >
> > Fixes: 4e24be018eb9 ("bonding: add new parameter ns_targets")
> > Signed-off-by: Qianheng Peng <pengqh1@chinatelecom.cn>
> > Signed-off-by: Zhaolong Zhang <zhangzl68@chinatelecom.cn>
> > ---
> >   drivers/net/bonding/bond_main.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond=
_main.c
> > index e044fc733b8c..522eab060f9e 100644
> > --- a/drivers/net/bonding/bond_main.c
> > +++ b/drivers/net/bonding/bond_main.c
> > @@ -3455,7 +3455,8 @@ static void bond_send_validate(struct bonding *bo=
nd, struct slave *slave)
> >   {
> >       bond_arp_send_all(bond, slave);
> >   #if IS_ENABLED(CONFIG_IPV6)
> > -     bond_ns_send_all(bond, slave);
> > +     if (likely(ipv6_mod_enabled()))
> > +             bond_ns_send_all(bond, slave);
> >   #endif
> >   }
> >
>
> ipv6_mod_enabled() doesn't depend on CONFIG_IPV6, please, remove
> #if IS_ENABLED as well


No, bond_ns_send_all() is static and protected by IS_ENABLED(CONFIG_IPV6).
Remove this IS_ENABLED will cause build error.

Thanks
Hangbin

