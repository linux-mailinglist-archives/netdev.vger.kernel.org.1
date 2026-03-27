Return-Path: <netdev+bounces-272600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCiwGYekxmk4NQUAu9opvQ
	(envelope-from <netdev+bounces-272600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:38:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D291D346E02
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 16:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A15CC30CE31A
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DD725F96D;
	Fri, 27 Mar 2026 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ps9jdWYI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1625B305
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625417; cv=pass; b=i2KbDPmF9EzxQ7uleQyUQhZ6CFj/hVmzEHRpeOCKmz6CvGwEK0NWHRdMJJAi1C/M309OCGXtMZJUtHEgwkTHIDzZRq3o7Bk5gKkiZFrrM8sOQhM5BwQGCh+VskB/qZFjbYW4jjojS+VDFSSRGjZ99SZqrWVRXjw+eDRkklw++LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625417; c=relaxed/simple;
	bh=L0HmzIUlaudmWdLyvPMkc/26ha0e7kfr3vtVyngDVzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dawwKSNXNlnDQTOcTIduCWCilWdJaH9bdSI/GAFoR2xqDKE8EOyusjgAZHK+cnkKvbirKXPUUJR1+zFVO3wNzdE/1RXdHS2fjhGuZvdaKe5H6Feg//gFNPtkasK6SPW+1CIKoDx6kAV2CT7heTlEDHuLqSFzFt9YVeXXKlpkaCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ps9jdWYI; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38a23dd61c1so18322411fa.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 08:30:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774625414; cv=none;
        d=google.com; s=arc-20240605;
        b=hHp941f2+ulbWyQxxTSG7diDu8Whmqint3ZLU9c83PhXtelardJawlzfikxYFmZX9O
         GgzCoFOy2PJa6gIe5RN0HgesjaWlSOGN7w6a6OFSyoA5qmksTfB1C2ZrIL8Jt9XyMsqM
         qtKyuhkyAwy/TXgGc7z3m77ChUNM1QR4yZjRNij54ETwpf6+Ecp68TaeX20p8NhhzQZv
         j9ARMCX3tyP7ywXx/WShnVYTE+QxG0F50ixEbuRMu/TNQelKdX75DnT1igpECPkwK7eP
         vWzmpT7t7iZjQSUgh9xeOGm6Kz+5dQi0rYLecG5I8ZYhS/sYsXuiZWRFMViAhfdlJBBV
         xNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yaOoSa6E5sSbCLI3n15E3wvHkbCmi9sfpUAztDL6XH0=;
        fh=lEO6jXyVVrqaz43l4sGOXoYdHkA+goVV3w1xE7vJV3A=;
        b=Hkd/f2J+1KMLn0BhDCvVpjBY3wH40uxXXQFOrVjV9Z6YxT7xNRqsV6ozdf4HKI/KKu
         BkIHAMFWQHmTHE/5/r8WZkUGbF1vYN6PTv7NjqzUzfk2zZcqk3zbPgfkLrI6TMPkcBJQ
         QqRQ3WNEhv85BULUZ7dYLcCQ9GJilMuUSNtdU2j0bx4XQVkAMGUJ02FqGY3P3ky110+u
         xVR+GBDvuV5LqIMyj1C7T/dEjStiTHpnb900+ya4+IfowlY2o4w7PfHc7y+bhWuR59tf
         UIcCkH9ZZIw2OGnFQ3NANRbra5mbG9h1YXpsqA0R8DzKPSe5d3UNJMJ3hshqVTRWzY8M
         /ZXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774625414; x=1775230214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaOoSa6E5sSbCLI3n15E3wvHkbCmi9sfpUAztDL6XH0=;
        b=Ps9jdWYIxq1hHWwt5bPW0WBkUs/60EBUKLrXule00HEdCLiurEIEQ/V4eHKaatNb24
         +FrlEDKNQa0s8LdgUZ9HbJewT4r7D1sPN1rPf2nZj5aPiGkuN/P3LorRyXqNZ85dNxGL
         6xh1PSF0xs2mFDQ92P2XYCuPduly/M/bSvvHzIKnMdSFbGpVmSqpLRYzrJbinTkEoG2L
         O3Hh/lOWyssg2r7gMcCOn3WOQM8j8zqgHK8QRumnbY4ILHM4iiFA2EakUIA/NYotZh+h
         BTh7bUXpGCaBxe2+SaLbBRlL8tG1CcbwkO87U2R3UwyNgcuQre5Ecs9nuLtaz4wPq4NM
         x9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774625414; x=1775230214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yaOoSa6E5sSbCLI3n15E3wvHkbCmi9sfpUAztDL6XH0=;
        b=c8WqCOhz/j2Dx0j3pl9U+ivwhGW2RTKb3lMzS3xECydQN5gRM467JzmAQbsNHH/Duh
         2yZQrPA1ixzFmCjdNaH5DbLFgJyEo/pEv1KY5j2pB54ehuS86qwUIiyNI6cY3BWfX1WY
         GPFd7p5L2fgFeHp5BExbdckIPwcQ7rO1hcL+NQeeJvjRKjgmSSq+NJMGfrEbnKUvvx6m
         Z4QxBPqAgjKkTkG/SaCLS+eczS0kDzMan9EMare1d2EenOrcWf8DxYY0LEQ28g/5K77m
         WNqhSyPOA+5zPAMJn1J79kc9jN5Kp7Fq9rxeVPykqy/bySTtC8+4b+HVgsj2cU/uV1BZ
         7sqA==
X-Forwarded-Encrypted: i=1; AJvYcCUXD8sPrCD44FS6TqW7tefVXNv0Guzb0fmNs7AS+I4mfTb7NTi1lUwVIW/qpnnIrF+y0RhYpfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFxL9Fj8gUUbdtFdBS59RVYuQbJKPJaMDQ4F4c//CfyoT4+5EY
	BwDrpVN3V2oAR62uVGfdbSwJdftH2ZblzShL9MQ2g3RgPqYs/ZyYGSefhikAGSDcScki/j8FzyU
	uyH2H0iY61CGSt3NnZ06Hhllm5Gv5a3Q=
X-Gm-Gg: ATEYQzz/H2yToTrfW5IPiiSsuXmKnJX7MUQtjCqpuMeYcczzrmBU0/Anwc30jqyqixC
	QQnzIAyUiULfhCpfwowDhe+Na73V/ffH/asON2yG++DhImadp44UTEzugYmCsW89SFifI6QIxQd
	fLKWJXKibBFAQzK5BFb5qa7qtzdXRpPS95/4A2z3pmjNgINuJ2CqtbJY/p55QGcpGqwor6DlSAx
	AUxflUy92u6fA5pDUyYsnX9y00SDIpSLbb5PSZfwcrutZ72UT+jkfEVtzydu/p1ExMpcAVEGLjO
	MqEeUZPQ6z97NkQeNQ==
X-Received: by 2002:a05:6512:12d4:b0:5a2:864a:bebb with SMTP id
 2adb3069b0e04-5a2ab922e80mr1114786e87.20.1774625413560; Fri, 27 Mar 2026
 08:30:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoDZx9j_HuzTge3u11_kz8FmEVfw_DMzMRzRd9hv+gjTdA@mail.gmail.com>
 <20260327144723.3344613-1-kuniyu@google.com>
In-Reply-To: <20260327144723.3344613-1-kuniyu@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 27 Mar 2026 23:29:35 +0800
X-Gm-Features: AQROBzCrbsuxiFllDILIn_OLGX-W3DlwwyOe5gTVlcpSsbEghfJJrmSmyyvThZQ
Message-ID: <CAL+tcoD06x+MRxkR+gg-dDsxUXDNEBcDtozxhtT5g58VmJrigw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: add sysctl to toggle napi_consume_skb()
 alien skb defer
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-272600-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[core.xxx:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D291D346E02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 27, 2026 at 10:47=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> From: Jason Xing <kerneljasonxing@gmail.com>
> Date: Fri, 27 Mar 2026 18:37:19 +0800
> > On Fri, Mar 27, 2026 at 12:21=E2=80=AFAM Jason Xing <kerneljasonxing@gm=
ail.com> wrote:
> > ...
> > > > Seems a copy/paste of proc_do_static_key() ?
> > >
> > > Thanks, Eric. Much simpler right now:
> > > diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> > > index b508618bfc12..a6a1b2c3f8e1 100644
> > > --- a/net/core/sysctl_net_core.c
> > > +++ b/net/core/sysctl_net_core.c
> > > @@ -676,6 +676,16 @@ static struct ctl_table net_core_table[] =3D {
> > >                 .proc_handler   =3D proc_do_skb_defer_max,
> > >                 .extra1         =3D SYSCTL_ZERO,
> > >         },
> > > +       {
> > > +               .procname       =3D "napi_consume_skb_defer",
> > > +               .data           =3D &napi_consume_skb_defer_key.key,
> > > +               .maxlen         =3D sizeof(napi_consume_skb_defer_key=
),
> > > +               .mode           =3D 0644,
> > > +               .proc_handler   =3D proc_do_static_key,
> > > +       },
> > >  };
> >
> > Eric, when I'm investigating the static key feature, I wonder if we
> > can replace some sysctl knob that only carries either 1 or 2 with a
> > corresponding static key? The merits are 1) we can minimize the size
> > of net.core.xxx or net_hotdata which helps put the structure into one
> > cache line, 2) in hot paths, the static key can be more efficient.
> >
> > Here is the list that I've found so far:
> > 1. sysctl_bypass_prot_mem
> > 2. sysctl_tstamp_allow_data
> > 3. net_hotdata.tstamp_prequeue
> > 4. sysctl_tcp_early_demux
> > 5. sysctl_ip_early_demux
> > 6. sysctl_tcp_l3mdev_accept
> > 7. sysctl_tcp_moderate_rcvbuf
> > 8. sysctl_tcp_nometrics_save
> > 9. sysctl_tcp_no_ssthresh_metrics_save
> > 10. sysctl_tcp_dsack
> > 11. sysctl_tcp_abort_on_overflow
> > 12. sysctl_tcp_slow_start_after_idle
> > 13. sysctl_tcp_timestamps
> > ...(some other tcp sysctls)...
> >
> > Some of them can be accessed in multiple places, which means they can
> > be hot. Maybe we can try some relatively hot knobs first, like
> > sysctl_tcp_timestamps, sysctl_tcp_early_demux...? Do you think it's
> > feasible?
>
> Note that a static key is only avaiable for global knobs
> while most knobs you mentioned above are per-netns.

Thanks for the reminder. Let me rethink it then.

Thanks,
Jason

