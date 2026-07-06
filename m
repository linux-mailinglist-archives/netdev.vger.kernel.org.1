Return-Path: <netdev+bounces-305069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rRbRG365S2r3ZAEAu9opvQ
	(envelope-from <netdev+bounces-305069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:19:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0959711DE2
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:19:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=T5+BuZ2O;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305069-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305069-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8978230D5A02
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50E6348C70;
	Mon,  6 Jul 2026 13:45:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC8826B755
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:45:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345556; cv=pass; b=u8KuMDmJx9Fks1hW9ooxUp1gfIzIT4p8+4qbJufErkoPgpDU3Rpt0T0dHTrUXhaYYDg9r13KVQ2qLlcZSL6SSBylH7EKn64wiUN08xWFb0qPUePGyUfvGnK3RguFcLOXaN25tqVrlqDQbw0xPOzEvIG8GhcoVFEPwLhmt7hedU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345556; c=relaxed/simple;
	bh=gnhdwSxs/2dEIXlbIYVInombO0ZsUEz3/h6snH5BdRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpykh1CmAnEv8lnXN3nYInp0F0DcpCKB//QeDeQSnau7gFYDVi/6f5LDN4ydudn5GPR8v0izTm48Uq90gI7xwLyfaLs50NMpYf36vkU1K6Y7b6NtEbI87RM4wI3f/h1sLeS48A7dm3a1jgwSMDWiS8jyz07ztfnL5Nym7klo4IY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5+BuZ2O; arc=pass smtp.client-ip=209.85.221.46
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47d6c634f45so1087008f8f.3
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:45:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783345553; cv=none;
        d=google.com; s=arc-20260327;
        b=ku0M0FdYFWbAvNzE9IjjC5j03Ydt2Rl5zSnaWX+Rgj3Ylw3OfMUlyhwPi92I1ZCqKs
         kY86im7LY82e36pYtTP2aremjkYWj3fPvkxZ0ji2B/MsaBWlG5Vq2EidgNDTLXykWRFp
         2OPmckZEh1VRaeI8m2FZMkHebM2LQLk0Uzo1zRmO6rtFG0paKbrB9D+fTGHqTHdn1MCt
         UOOuJ0d8m4WQuD26c49KqXP9RYnyg10fzkQ992mFe257aOn0bhbCWm3Wj9HwT9gQhJRU
         kWSOu9t6qzP/As33tb+kF1YbGI5qZOs4lXfcDvXwZM4KucorUTyEYh96JNI/gnUjCjBS
         sYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kcEQsIAK9WaEKSN1vaaZZgykO19KS7IvBARm/eZyWas=;
        fh=xu71Rb8BRB1k4YSZC5gaO5XtNBrlAF0Ro2cobIdSTo0=;
        b=pZ8w/qWoUhZNdPt3K4i9iBKyg9kxIO7JdKB60GyJHXIAg6goig/lg5Ka73A7FkVgd3
         IhBUz14cYSu34cQZO2SdY6/V4WGBbzwIn6gT6N3N4p6ogMKxeFMhSfd6m3PD8yEigE6k
         PVbYC1i8UQb/jVYuNn95OqtIaigwmXKd6qxI9ADHW8OyeZj8Ubamod/JSfvkgb15qWl/
         mVXiyWKh7ZmOSNJmtseR/06aqehVkj67cf8MwxCvmv0UQYU+zzjQFQ/XtrFWG80Nqh4M
         KlsC3Vtz0JEmh1mvsbanKD/gDjDWaxnBpXatRa3lLhXaarMc8JCrKYNmM8hkFHzjK30B
         zS1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783345553; x=1783950353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcEQsIAK9WaEKSN1vaaZZgykO19KS7IvBARm/eZyWas=;
        b=T5+BuZ2OUGykjQkrwU+MwdTf5WS65efsJVqdh4WEqcfBUEpFXR8HuHwZfBUpdwdIsc
         An/QMkj2N0BGJQ8e0hqL57aRAi2jRDYao6+LCZqdl5o3NW0EE1T0x8+tdGRTR4nYvwWt
         gfy+4V+tp57og7N/n2oDFCo4jEQhNR+y08brrsfCGFYwxnbO3nK8Sq/UZ23QZnxwcjY+
         hsuX184I3UyiFUlmszho7Onkbex7ZO71gqOPbS/KbECsQ1nYggw72EvBj0NC36VCkJLA
         h+AkaxQoFrtQ8+6u5pbgNgBNO/0p4LPe6W3OKz7L5Ez6T6VBcFq+90f7q/KtfHOtr6yc
         4B6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345553; x=1783950353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kcEQsIAK9WaEKSN1vaaZZgykO19KS7IvBARm/eZyWas=;
        b=ScFJaikX1/3a3p1Q3P0NUgiqYd2+OtxBixwsEq95BwoMiTmYoA627Kji1Jz3qhj4g/
         A36yp8PmdtJn1YP0Elmlfn8/pynEEIQchCbosCZN76fVsBkkJXy4hGtCnwX9mgfZTU2e
         KVkJB14BptiGONBQK4h0ksdZWGyzZTAvlTc3aHbFDqlBi7om2LPhvmmRNxdEfaWW4vE8
         5+0jPYKknGUf4YGJSPEMTdfUXTkk7IeXitKMq+urboNnpNdfDrncBWmMq6T9fyemjs09
         91eaxjWVnv9gA0vErNFmvvK1m4A1CUhzQFVF5D9R/HBc230AC5G2RcvVq207vbrdqIoD
         brjQ==
X-Forwarded-Encrypted: i=1; AHgh+Rphv7E8qPH5WBZqIaEDycGFXKjyiEJblvMn23fM0r6I/BF+EOpkXuQ1c9avgeOFXlHpHgPIeac=@vger.kernel.org
X-Gm-Message-State: AOJu0YztrpS6lfu/28bklUhrmw6MGtqJ0ZMATh3QAUXZn0yOd8AM+IpZ
	kgFXeciGFg23qc1maf42iM5ZQp0TBPXBy8tFy/V3OGlYbYmOLQmcA/i688IkKsHKemTbkWA8NfB
	gOLW13ZO17PMtBK6G9F3svFa71YaptjDBCxmZVIth
X-Gm-Gg: AfdE7ckIzkUpW9QTBvvqGPbrwIc2xgp3JtVt1q9d2Oz0GcN12BsCmhWLKWnyHfgbaY1
	FAYUokR/jBkINUMs/8zvZYCDTXm/+nT5+fXK4LrBSw8XfBCKy3dELymbRkmE0uQRTWC0+9QyqSD
	ql42qOPBoSxyuoKydJAi1jSBvBKajWvu+23ZEu27FJw6u2FmxzEZNWknnOBbXdW7SuLApFwxrkx
	GxCyDX0gZFl6nJ4lTLjYH3MYHBhwkcl4Qc+IWyOS7UfmIPoMMMkosJ0izsqJkg6pAHgJykpsVm/
	o2rJA8byQQBSg1/ZbvyMIcyJ9zS4TNMyPo8zpNcZlQmfQ4gCUyTI+X0gkCM=
X-Received: by 2002:adf:f590:0:b0:477:6874:542c with SMTP id
 ffacd0b85a97d-47de66a2fe0mr238935f8f.22.1783345552952; Mon, 06 Jul 2026
 06:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705-net-vert-imp-v1-0-95a35ddff411@gurudas.dev>
 <20260705-net-vert-imp-v1-1-95a35ddff411@gurudas.dev> <8376fc86-be9d-4e3a-a51e-4d9ecda1b648@lunn.ch>
In-Reply-To: <8376fc86-be9d-4e3a-a51e-4d9ecda1b648@lunn.ch>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 6 Jul 2026 15:45:40 +0200
X-Gm-Features: AVVi8CcfJ5T4Eksw8-ONpuN0gs2vDftnttVKE4h_kMWH2y7YBxV5vjR4JqCNsAk
Message-ID: <CAH5fLggGdcMr-ARGpg150_ojhBUnNaV0weyfk_M0D3AP_Qhw1Q@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net: phy: ax88796b: Use vertical import style
To: Andrew Lunn <andrew@lunn.ch>
Cc: Guru Das Srinagesh <linux@gurudas.dev>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Trevor Gross <tmgross@umich.edu>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:linux@gurudas.dev,m:fujita.tomonori@gmail.com,m:tmgross@umich.edu,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305069-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aliceryhl@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gurudas.dev,gmail.com,umich.edu,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,gurudas.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D0959711DE2

On Mon, Jul 6, 2026 at 3:17=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Jul 05, 2026 at 10:38:40PM -0700, Guru Das Srinagesh wrote:
> > Convert `use` imports to vertical layout for better readability and
> > maintainability.
> >
> > Signed-off-by: Guru Das Srinagesh <linux@gurudas.dev>
> > ---
> >  drivers/net/phy/ax88796b_rust.rs | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796=
b_rust.rs
> > index 2d24628a4e58..5a21fe09bd62 100644
> > --- a/drivers/net/phy/ax88796b_rust.rs
> > +++ b/drivers/net/phy/ax88796b_rust.rs
> > @@ -5,7 +5,12 @@
> >  //!
> >  //! C version of this driver: [`drivers/net/phy/ax88796b.c`](./ax88796=
b.c)
> >  use kernel::{
> > -    net::phy::{self, reg::C22, DeviceId, Driver},
> > +    net::phy::{
> > +        self,
> > +        reg::C22,
> > +        DeviceId,
> > +        Driver, //
> > +    },
>
> A question from somebody who does not know rust. Does the order of the
> elements in the list matter?
>
> Linux has a pattern of sorting multi line lists, because it reduces
> merge conflicts. Can this list be sorted?

No, the order does not matter. But rustfmt will complain if it's not
sorted. Note that rustfmt prefers ordering lower-case before
upper-case so it is currently sorted in the order preferred by the tool.


Alice

