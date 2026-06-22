Return-Path: <netdev+bounces-301222-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hr0SOH3GOWo6xQcAu9opvQ
	(envelope-from <netdev+bounces-301222-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:34:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB286B2D57
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 01:34:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=cGfrmY5b;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301222-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301222-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=asu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02ABC301E941
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 23:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550153469FA;
	Mon, 22 Jun 2026 23:34:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B792D63F8
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 23:34:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782171259; cv=pass; b=WzTF7kaPsCFbLPskGZ5mw3/sjyq4fMatY1yn+jy8qMK4IpiN1SF1PgkAcEc5snB2auatDrfjSFBhsfH/R/4czY+rXNyQ6dVJL7OkwvSGS82gocFvu+ejsYb456tfriY5G49XQTBDZIHyqwyQ7LxkDGNBPWFK/D8ssv+tLpZvSek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782171259; c=relaxed/simple;
	bh=/NZH7CUDL0CkBDCC6EjEXPwjJ2ho3pwlwDRg4cLv2SE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UkWXXWCq0vC2mPjEFZD5WoaSgt5YJcS1Fkgnw0p/gk0GFB7TXmx9X4/77W5i82w0SK25Fvk8sptOPrkPaC92R+u52EtuKV0F8yO4gX4yR8I3GDpCnY+g3biosh/vZpd7HGmuvlAwWNjsgJkrBkieW7kyT6zKUP3ITg9kV5smk28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cGfrmY5b; arc=pass smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c88b7c92577so2190874a12.3
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 16:34:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782171257; cv=none;
        d=google.com; s=arc-20240605;
        b=OSObOTjxrhDJOMTr3Tzl77RBvXX6mDcD//ee6zCKIJ1fJBT2g1NaA6tr2QxWigKs9l
         fMGqF7qOuNlrkDIgeC+WsMfWnDN6S26erjRv0o+KlcmxZmR69M956fvlGFd/YyeIQCiP
         0nHJtOiC9pS4F3ZNTjn+mseBZOiRHhOTfieBK/LPiZ4Uy8Oa2BKymeDgPYZd7PN4+xue
         OIVuA+lMe58uhMwlXtDnEm+/uhUSbUZW+z9o0mJRAYgnGVJhTH4U9UanZ5jOQFthA7HY
         tjksUgKDoYLhZyzIYn4usTQkip5d+Uqx82mY0qRRoHkaDIZAgaZDeLF0qpzBesE6Ssp6
         WRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ouzSUEbSx+tH19jrVTA595wI3Lipv4w05V+9kgdiphc=;
        fh=eHAmo/Z5tVmJqw6Rr8p63LyT4saEg6ImGicE/18qtQc=;
        b=doCzuNVJEwxeYfJB6Gwm4zt32jQvUOcsvThSm7lEVPA7KGxhyG2rhfCBF9RNwH70jt
         B5/Mb+FHfxMwNMwACvS6mGgZZgfKG7fxU47R27hzkhJA7yU78GLXTB0izrnERkuRMwNd
         X37YZs9OlqD8DGJc3HBOID1aIfPj6JOdIGsDrJe4Yk+lAXhh7OKSjy07jxJM+NA8uDhy
         e+4Wg44SEq2tY5L4QWhpBw3p18pPGmaluSmxTJtPpPppyJhMxU0XQV7UIR1P02fsct61
         OO5zqvuQd/LrDHMml1F7WhVRC4WuSF3ltRHlmCMZBvB1hYRrBM/q80x+P06Vs1jyDpiF
         LMNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782171257; x=1782776057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouzSUEbSx+tH19jrVTA595wI3Lipv4w05V+9kgdiphc=;
        b=cGfrmY5bzGJ3O/7XR2RBnvLJDf5gGi1fyVeQD1eTvyh1K2WDP72JmXL1JekSiy7uIH
         cwzhJf30WVZn5eYtB3fDD9SmO/t9WtNQoz+4tTix61L969wxYpymyohXHCmuO9fLEIHw
         4wn2b2DNRPykZdN2CZXuOlvlPorRQKKJejIeDxGy14dBwihrLxk6f2jUwXVsWAk8evlk
         +3HFXf63JlVwJzFu88TV0+zZLfYcXaGb5VT09Q6gy8NBzoXTrgX8RGa1QnbSNLj4Owgr
         ogOQIwZZfxH2U/cHlifEYwCYJbkPiIQq/8Xlu5rGPiTzSgqnbMBEdQwBxYwQTmH+dnhv
         Jd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782171257; x=1782776057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ouzSUEbSx+tH19jrVTA595wI3Lipv4w05V+9kgdiphc=;
        b=JW3eiiTFlCw6XPDO8nNeOPf3+hCCEoHsYItwuV7JRBoMSsJ+VWvDlQ6nc9FA55BAk6
         DeMkPZ6qZClLmLxpQ/S5j8rQZJI9tgsFX3MIlONh1KC/y6N28R20z8ha8SxVjiftVCH/
         llmvyCQGCGuK4fDVcZm9+h/Y6+R9ihT5lMBKEU3p/z6KLqYc1kDHLFhWW+wSeC5281y5
         Bhy6U1tfPVB71sP7BEho0QA/LFgydXm8i4Oru8XyXiTIXf2CEScJD35VagORjp4yYnas
         RqI1Y7kBE8CbhIiBrBe/GfyOi1VoBlzpNiYUJHjXO1ZSeQjnYF8a6G5odwnVCUfid1MY
         iNmA==
X-Forwarded-Encrypted: i=1; AFNElJ8iyV6E0WW+bjV4F9Lm0tkcHB1X8XIOGICLQQfqGf5SmaU3cOLqwLu6w6whmI6fP/5+fIfSAd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJBChYYAFC8grj8hmHq/e4lDoHVG3vogy98tIjHFuLbnTC9hPy
	Yv0BnAP5eIbCHmMP4c9PXhhniizFe2DgR2fqvg8Qw1g+QS47FXw8eo0zE/lLqAlNsf8snB6e9ZQ
	SNZGY7w8t3W1PhR3YhNqau4p3r2vz6VE1KeKRIHh+
X-Gm-Gg: AfdE7cnnTUBwzKLrO1DQZ+jO407ww2hCWxFU+JuC56YgbczRTu2q1AYKeitj6Dgw468
	tB2rd3D7FLf1HO3+xDqOuf5iLWhySLVmSquwEuq0IaG+qbO5PvLcQfLgBeb4f8oWKzv2E2CdIE6
	wC4D8YjESpvQJlld5ivE5ABe/mQprZ3sD8GddnEibhIREAl/4RFuBDWzgGAbwkrFbcezhC2U2X5
	z7AfGpEefEhvmUzd10xHFoD5Ix7epUAyEo+BDN9saWRAGy5UB+ww9UEnB6eOn5ByiU9s9OnBq8X
	F5E0+xduR16MnXG4Httfe5MD8+Es
X-Received: by 2002:a05:6a20:4391:b0:3aa:c93b:6266 with SMTP id
 adf61e73a8af0-3bb324241c0mr18478270637.19.1782171257148; Mon, 22 Jun 2026
 16:34:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620201531.180123-1-xmei5@asu.edu> <7791b9cc-86f4-424b-aa1a-d1a869814130@linux.dev>
 <CAPpSM+TRJaqSSUs6tBp_CBSVUJMiDZm01o5BK6aCNak8vuQi+w@mail.gmail.com> <20260622155854.75977aac@kernel.org>
In-Reply-To: <20260622155854.75977aac@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Mon, 22 Jun 2026 16:34:06 -0700
X-Gm-Features: AVVi8Cf3SbUOBGmwse685yVa4RQSSzDqgZs0uYBTQhtoiGuwf8j3_ixHdVFDuc8
Message-ID: <CAPpSM+Q4O704OaUAXqKpL6ffvudTfqzzLzLExziUExgvxQWmxw@mail.gmail.com>
Subject: Re: [PATCH net] net, bpf: check master for NULL in xdp_master_redirect()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, Jussi Maki <joamaki@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Weiming Shi <bestswngs@gmail.com>, 
	Ido Schimmel <idosch@idosch.org>, David Ahern <dsahern@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-301222-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:jiayuan.chen@linux.dev,m:daniel@iogearbox.net,m:martin.lau@linux.dev,m:hawk@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:ast@kernel.org,m:joamaki@gmail.com,m:pabeni@redhat.com,m:bestswngs@gmail.com,m:idosch@idosch.org,m:dsahern@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,kernel.org,vger.kernel.org,gmail.com,fomichev.me,redhat.com,idosch.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qemu.org:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3CB286B2D57

On Mon, Jun 22, 2026 at 3:58=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 21 Jun 2026 18:28:09 -0700 Xiang Mei wrote:
> > > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > > index 40037413dd4e..6037860d5283 100644
> > > > --- a/net/core/filter.c
> > > > +++ b/net/core/filter.c
> > > > @@ -4430,7 +4430,7 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
> > > >       struct net_device *master, *slave;
> > > >
> > > >       master =3D netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
> > > > -     if (unlikely(!(master->flags & IFF_UP)))
> > > > +     if (unlikely(!master || !(master->flags & IFF_UP)))
> > > >               return XDP_ABORTED;
> > >
> > >
> > > I recall that when I previously modified this code, I removed the
> > > !master check
> > >
> > > because this is on the fastpath. However, since this is a triggerable=
 bug,
> > > I think adding it here is fine.
> >
> > Thanks for the review. It's difficult to hit under normal statue, but
> > the bug is real.
> > We have triggered this bug with a PoC plus GDB to pause one thread (no
> > other `cheating').
>
> Can you double-confirm that this triggers on current HEAD
> of linux/master ? I thought commit 2674d603a9e6 ("vrf: Fix a potential
> NPD when removing a port from a VRF") was supposed to prevent all the
> torn master fetches. Adding VRF folks to CC.

Yes.

We have triggered the crash on 56abdaebbf0da304b860bed1f2b5a85f5a6a16a0,
which is the latest for net.git, and 2674d603a9e6 was applied. We can
still trigger the crash:
```
[    0.516445] BUG: kernel NULL pointer dereference, address: 0000000000000=
0b0
[    0.516448] bond1: (slave veth1): Releasing backup interface
[    0.516732] #PF: supervisor read access in kernel mode
[    0.516733] #PF: error_code(0x0000) - not-present page
[    0.516734] PGD 102597067 P4D 102597067 PUD 102598067 PMD 0
[    0.516736] Oops: Oops: 0000 [#1] SMP NOPTI
[    0.517948] CPU: 0 UID: 0 PID: 133 Comm: exploit Not tainted 7.1.0+
#19 PREEMPTLAZY
[    0.518320] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
[    0.518796] RIP: 0010:xdp_master_redirect+0x5f/0xc0
[    0.519019] Code: 00 48 c7 43 10 00 00 00 00 48 c7 43 18 00 00 00
00 c7 43 20 00 00 00 00 89 43 38 48 8b 45 20 48 8b 38 e8 94 a0 fb ff
48 89 c7 0
[    0.519795] RSP: 0018:ffffc90000003b98 EFLAGS: 00010246
[    0.520028] RAX: 0000000000000000 RBX: ffffc90000003ee8 RCX: ffff8881026=
8cd02
[    0.520336] RDX: ffffffffc0000654 RSI: ffffc90000121060 RDI: 00000000000=
00000
[    0.520657] RBP: ffffc90000003c18 R08: 0000000000000040 R09: ffffc900001=
21000
[    0.521003] R10: 0000000000000001 R11: ffffc90000003ff8 R12: 00000000000=
0000e
[    0.521322] R13: 0000000000000008 R14: ffff88810268cd42 R15: 00000000000=
00003
[    0.521617] FS:  00007d34bc6546c0(0000) GS:ffff888197ac5000(0000)
knlGS:0000000000000000
[    0.521964] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.522215] CR2: 00000000000000b0 CR3: 0000000102590003 CR4: 00000000007=
72ef0
[    0.522513] PKRU: 55555554
[    0.522632] Call Trace:
[    0.522747]  <IRQ>
[    0.522841]  bpf_prog_run_generic_xdp+0x39c/0x3b0
[    0.523057]  do_xdp_generic+0x1a0/0x350
[    0.523221]  __netif_receive_skb_core.constprop.0+0x5c6/0xce0
...
```

Thanks,
Xiang

