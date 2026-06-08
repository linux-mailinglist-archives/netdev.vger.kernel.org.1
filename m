Return-Path: <netdev+bounces-296657-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y9pPOI38JmrwpAIAu9opvQ
	(envelope-from <netdev+bounces-296657-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:31:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE2B659439
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 19:31:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XJBbDRFu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296657-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296657-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08C9630EDEB1
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 16:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410E4326928;
	Mon,  8 Jun 2026 16:15:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50D732B110
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 16:15:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780935323; cv=pass; b=t6Wr+e/RHC0l6f6WSEl/EjDTT4NGRuF45Wyxk75ji/HjNBTBhahnvLkEv7YEpKxGUAcSzZCXF23yhO5Zl8AUuxNuL3tuceQkoq7OkfKA9RGIw3ZEmjStk2fPOQF7S7MnWf5cjnfWMu6qE6wUzPPS5VQp1q2RzZvaqHhHRp5Gjyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780935323; c=relaxed/simple;
	bh=klTFQtRkpJ+E0O/hEFPkAzEiyOb/rS0DaqGWrXAVb6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWnBHZBYYpgOG6r80wa+SH3jazCmnU9Y/T5lLiwDEt532U2j2lw7tDjq4I4kSOa/FBYRYlELp2nzy7Y3ZumzUBFDd/xKSvE8QqxaCBUt+s9zkm18se+Rq+Lo8s2hFXNYKQUHxsh/oGKXUFzUzgvvOli34HPjI8C/dyNAC5FsY+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XJBbDRFu; arc=pass smtp.client-ip=209.85.160.172
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-517863a2edfso36008291cf.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 09:15:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780935321; cv=none;
        d=google.com; s=arc-20240605;
        b=hMcTtlzX2F0kTbxpeN/G5ylFk0WxHf+Xs8tEIdO+NY5mTKFZUb4PCBHoaJhI6Vj42p
         9UaFNhgyj08ffY5C1h2jtGyNf0npKc9EcguwGFpYF1cK5F6uwL7jd1DTKPfHY/Gr7wdg
         +xtysHDj4FbZLCRY80uu7vEbyaP1alE614F2ItSZpgl6ck1bkZ0cx2mDkqEHQrkl7rB+
         HktuuEH+X7SygyZb59r6+EK8XonquxqKpCWx1EvR1ox/lM34siwHr9pE8Hl1A0qxL7dE
         IhVpeuHzfTuTNPmriwsU5lxLC+kUzVdiMyBLOLLu62bYzDkq6x1A7MqGxNYSnATY9lfP
         Vbag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DclH9crVDtyAFXpVH31vo+G4TBnQYqDHtlEzLnI+Thc=;
        fh=GfS33/Cydpc35KhnJvKzpi5w7xbaKXkXeNXLyU9uXEE=;
        b=X0SVXb3uGURQgbi2goIzpkxxwxytFuRD7KjRdRPug533XVyfa24CFjvEF0vnl6HtWE
         qJjkAICrcDRyht8KTkadeNI129x4DVcsYjXWGW71InqFF3zJ8h9IwkAiaj/LKNt6EdL9
         MBiU1YXTzFBbyDTjb2GE3gWXzTA/H67tiQjDaHMHo0Bqse8WRh8ajiFJIyvlESI2lrbP
         iZcKjqPK9xu2iAeN5rCSSzPI4QZ8dX6pNmEYyYoEWr0+lYYK1Y9oYOIjwhpzmYqpgO5c
         7VhjOTPqEJIl6AlqrnAoLrncltGeF43Qc5I6RJkruorIOX+KsG4Z77XPxp1pHUCQWle7
         7cxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780935321; x=1781540121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DclH9crVDtyAFXpVH31vo+G4TBnQYqDHtlEzLnI+Thc=;
        b=XJBbDRFu/h9kJA4peUrQ1G+mvSRAjQBWurw57lwUeeShMbZnyIOQ4DYDNMldlC8hhA
         T6xxDz1UA+RUrGZAkkEq7OIDsM6WpMNhp5/Ve2I/6TbfJmPy/HiWAs87yNJV1+VItlcG
         6tSu2WtrrpUwP/VthaJlr2TSIwvK5E1SmW7fwwzmrtb1gs+ma7Sv3z1OikDyJkOtt2zQ
         TQyNZ8LGiuW02MbCuk4MDh90RrqyEf90J2/boNxl6UpC8WoojtoF/AJpxohjhfVYLlX4
         qFZRbt47QLdoIMZQ3He2eNtmTgCQ1zTwqiv1EY++zjKoIg7u6zEP906Ag5Ty3MBAZY/b
         u1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780935321; x=1781540121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DclH9crVDtyAFXpVH31vo+G4TBnQYqDHtlEzLnI+Thc=;
        b=VvnVoXiXXBQ3bzTWFkxJq28X8TufgQRU54UmCjJHnNMtVnyYd5vIqLXsL7pkRme1Lq
         lpbRecQ12x8fU68mJoa/BDt8T/2I+0CxE09u3A8YcVnR0ZTwDfmoIv8IMrkgiZEfbHNg
         6cXloyTcwVZTUbS5GDLRbSjLrt8YnNvp7vZw3ceJ6Fa1EjudMYPuDEBvgL1TzsLliSKi
         HvpA58JP6AzUySCnpc55OzOvDFTsuN11yWTXScBFVaVteehVT0qD21DeDeeRRcB//UUT
         EfSv956XG8o9yAGFDDn8B6hw9n7PAEDV0vgT71Z4ziUZkaf541COuysZa9sIfOns5fML
         IvXg==
X-Forwarded-Encrypted: i=1; AFNElJ+HdVSqlB9v2sIWQM9jRAxktzfWIWqk2seiApsXIQWlrDnQp+IRDioU6c666teZtG9nkS9eejE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKg4whCQF6JF3aM3rzeJRLfFnDE6WBcEcjr+dr13cX0thEtMwT
	r9dyAEU/9gLeKgeIcqfutgiJszlrtBJX/ZoWgRlC3x0f/S5e+2BfYfJ+pr0/A4BvddXBf7C3XIT
	EIuDsBpERbo+AMy8+JJNomTECDAgVRUPAlcFFhvVw
X-Gm-Gg: Acq92OHEHLu0EhLykBPsEeb3cqhvotxSxwlmDWOiVP4LXbb3pdSvqArCPKwazRVFz1Z
	MpYIdTDzdQl5DTgziCi78MW+UuPBGz19+sa1LBSlGML/kphRRv/BX4OSafXzxxW0cNUszwUMjSC
	B1cIsjag+cDWNfU/RhCW+VVl9JKqR9W1uSRx0s5n0sTyZD3vIOF4P2p1SeWdI0/Kkmp30LG+jB1
	OS1l4LUUwgIXWvtRq0bCFMNXX17a9D1Ck0uzV4qRtfEjYDc43gVYNtYjPO2eAQB2N3KHRTZrIkn
	j/SiN0vXbEZsNJXONiieWoIgPb8OI8Lnc0H61HebmemUHMKyQ3OD/7S2vzmzATpJlQK7VsofFH6
	xYExEbV3e73uOoFprsyUg2HTV5/M=
X-Received: by 2002:a05:622a:4818:b0:516:e00e:6868 with SMTP id
 d75a77b69052e-51795c142a9mr236105211cf.46.1780935320264; Mon, 08 Jun 2026
 09:15:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608123935.524879-1-edumazet@google.com> <20260608090101.42b9f43c@kernel.org>
In-Reply-To: <20260608090101.42b9f43c@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 09:15:08 -0700
X-Gm-Features: AVVi8Ccw6nW3WTdU0FfYFjL7hI0EeFcJSUdUw4Du0uJaCsJq4S8CYRlJdtiRg9g
Message-ID: <CANn89iJ46VmFvpY9SYm=JPTvMmNOg2Xkr=PoUfuShEhRwPnbpQ@mail.gmail.com>
Subject: Re: [PATCH net] net: watchdog: fix refcount tracking races
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com, 
	syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296657-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:kuniyu@google.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:syzbot+381d82bbf0253710b35d@syzkaller.appspotmail.com,m:syzbot+3479efbc2821cb2a79f2@syzkaller.appspotmail.com,m:ericdumazet@gmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev,381d82bbf0253710b35d,3479efbc2821cb2a79f2];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3DE2B659439

On Mon, Jun 8, 2026 at 9:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  8 Jun 2026 12:39:35 +0000 Eric Dumazet wrote:
> > Blamed commit converted the untracked dev_hold()/dev_put() calls
> > in the watchdog code to use the tracked dev_hold_track()/dev_put_track(=
)
> > (which were later renamed/interfaced to netdev_hold() and netdev_put())=
.
>
> selftest kernel build says:
>
> net/sched/sch_generic.c: In function =E2=80=98netdev_watchdog_up=E2=80=99=
:
> net/sched/sch_generic.c:594:39: error: incompatible type for argument 1 o=
f =E2=80=98IS_ERR_OR_NULL=E2=80=99
>   594 |                 if (IS_ERR_OR_NULL(dev->watchdog_dev_tracker))
>       |                                    ~~~^~~~~~~~~~~~~~~~~~~~~~
>       |                                       |
>       |                                       netdevice_tracker
>
> config:
> https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/682182/=
config

Oh right, I should have guarded this

#ifdef CONFIG_NET_DEV_REFCNT_TRACKER
           if (IS_ERR_OR_NULL(dev->watchdog_dev_tracker))
#endif
                   netdev_hold(dev, &dev->watchdog_dev_tracker,
                                       GFP_ATOMIC);

