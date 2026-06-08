Return-Path: <netdev+bounces-296493-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id m43LFNqjJmpkaQIAu9opvQ
	(envelope-from <netdev+bounces-296493-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:13:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A677C6558A8
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 13:13:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=gQ0EGIZ6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296493-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296493-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7EC9310D8D1
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 10:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552C2322B87;
	Mon,  8 Jun 2026 10:57:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D6D2E7395
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 10:57:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916248; cv=pass; b=lOau2pkx8YMfyXYd8hkIjOkVHMKObVV9KoNKuy9yfyTHZD0K9ASSUCkUdVBdWe7O5SLTR/B9pRe9cLzsO5x6cxPvLVJ2JzyYOqLxTVPJVub873rzhi/XYMsDo6QEWfMIyRrdLGjwsm+uJDVqQc07tlxGzL3C5vUDaoaUH1l//fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916248; c=relaxed/simple;
	bh=h5GwtUrO5YjewAia1LKWw8eyP/OHFDrD+FZ3lR6jbPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QWsQBFCbHAccdS7qyzngX1cmPnfKfvaeyc2iRMX6SK8aE6DSeVD0CMivF8lS+d/yGxMXSni5Td5nVAG/yF23jBJ/ZB2PwaShqD6tFQOZRGOa1kNqigKDUx2D21yE3W0yvbPZ8tZMmOZy2DS6tMNoNWN4r8XrK/jEIP0CfzkvR7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=gQ0EGIZ6; arc=pass smtp.client-ip=209.85.215.175
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c858b392697so1940090a12.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 03:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780916246; cv=none;
        d=google.com; s=arc-20240605;
        b=VqIWmbtdF9uX61eJyD/6kJp2FoA+MDxtgqDTRZv6aQZQFHNYURa32g04+qy+cTAct0
         gSFxgmOyhRZTrElqhCJ17kwWAyZOSr+ehJpxd5K9nojoDKpgdWxatZ8wHRE/Q5KRjPGb
         CbuG6Zf3FFDWlHAHjAC1M/Wi5H5jla6HpQDH9QpnKETHTqOCU2B+fgGYrQ3jkQAenHak
         qR/DtLwTIkOjZaiVShRO2K55n3SzO1E/cCGkmQ+o6eKchbCcx6KQEYoh1ZckSXkYAOCw
         Wr+Pd3/xeefKrig7e2GY9IrtZg74bcEeDgp+bsbHuYPm+k8laAW3zmvnFNdP/XfXwKRr
         b67A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ahSludj4wZP/wYjbZjK7tn5JJdzUwAesoF596bb6ciA=;
        fh=gQDgFQUwwu/P5u2tCT8C/3mxPjAXA2Ro0hK2ojP2BxA=;
        b=Z++wzzoGv491wA/DuqJAUZO5ri1akIPTh6PU0nUdmfV6NuAbv14NVN05KTIh/lQYOL
         45QJJnUU4Z5z40uOiwgloj7Py8BxDT4WA7bNEZRhmTJNY8qPIR/DBDR83Kup+clWecun
         URTrZBp+38ore1M9sU4xIkWFO1mHlp9tqiAwOetLcbjsYv/zGPtejRVbuTyObGQug1dR
         rToTv3Lhi29TvQBxG+lf8yRLDMO7/LUBh1dioigM+G20yDrIKrLd6A8VQoh6oy3kPpaS
         ZgigvYfVv7DaRWLh6gmm8k7rxXgeuniOgnFL1/m0FKvNuD8jmVTSht/tu+9x31XZfLxp
         ZSkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780916246; x=1781521046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahSludj4wZP/wYjbZjK7tn5JJdzUwAesoF596bb6ciA=;
        b=gQ0EGIZ69FI0StN90EvGes4izXiy38ewH3nES8oD3xkgoD1whxJRBaKB0UvZQsYMTB
         PxuUQqcw9YK07WcuL8gD8V+Ptxw1q/N5FAEBumX3h6zqktw/+RFMWDy/FkZtiUlvCNe4
         HZjrRDVkOrOb72dIpWs2T6lL4cpJEz4vy+ZR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780916246; x=1781521046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ahSludj4wZP/wYjbZjK7tn5JJdzUwAesoF596bb6ciA=;
        b=IfMq6WveHQ8XE5mdHVHYVlc5tq9qZM7JfZCe/t0RB8ytDtWjDELbvC4MnfmsMttQpU
         GhFnt3GORRzcVqWo3uRZjevwN7PGzLuRK5ey+FLi9kd6psgf5v+OJs3jmAa2y+umYXDv
         opxalk8F+2jqNkPTmi5Rn8lphZrIXfew63u+VB49wXi6V288eUZXunGBtd233OMpbHVw
         N4G5oiRDZGNBXEj3oSx5Rit9p3P78okrH93RMpUgJyNpk/efXdcl9SR/Jj8lIg+nnnqX
         z21PujeIh460QLDryrtIjvD6IaR35icHP4OoAIy85/lW1j22qef4jhYwDWFSGNic4cpa
         xw/g==
X-Forwarded-Encrypted: i=1; AFNElJ9KVDoLbcOp0oq8RHeAEMTbmfumviJywb5bEVK7ew0WqsUiQlZd3Y9jcOZl1wgNdkIwbHKr560=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZ69jqzTBmV4Aq1WpOvLdoVuDZKaYextHA44Z6P4YRnMnDdZA
	l0JpqEOpnusvfbiOz3jLfJUS4DuL1LhUMZy9Juxs1IKM9ACsyvFrHnfwqnVksDiCxaOyq6nR7L0
	fx37vpkTdiJBH3CoAH74fY8g31moIoI+h14edbG8+
X-Gm-Gg: Acq92OGxithCIa58q3FN3aXmtEGeu5jgQgS6BSoygvueUxTFuoJDXly05Q6r9j+EGhU
	CNRxk+K9gZXETzl4vSBZohIhWw6/x4yjKEFXjDT7Cf4SWPyc2p0cxvj1RYggs6SdEKTz2q8b1j3
	3bEPAVmz/DBqYYCtdq4L0zjeEFXjPtwedml7QWFM0iLQ2ZFiMs33Ess2NRN3kPI0tYszhLYMhKy
	PGYODnoDodwb0ZgE/Xia/rB1FgRSyWnNq8oOFOBvtRq2FOBNM5Opv6uh5Lt546OY16G0Y5nmTDW
	inTSDNzMe/AlGgqI5MI=
X-Received: by 2002:a05:6a00:228d:b0:842:6c02:2fa4 with SMTP id
 d2e1a72fcca58-842b0d60127mr14721457b3a.14.1780916246453; Mon, 08 Jun 2026
 03:57:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095727.647295505@linuxfoundation.org> <20260607173214.92693-1-ojeda@kernel.org>
 <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com> <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com>
In-Reply-To: <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 8 Jun 2026 06:57:15 -0400
X-Gm-Features: AVVi8CcZH7gb8WPQEP1bwBGyGn6nbunXL5d0GcMBpIG4fwbjLQQVvr8yXfV8paM
Message-ID: <CAM0EoMmHd10iivCpDoEd3h+eae9fSnoGWAH_AkwFhrnS6PN63g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/307] 6.12.93-rc1 review
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, gregkh@linuxfoundation.org, achill@achill.org, 
	akpm@linux-foundation.org, broonie@kernel.org, conor@kernel.org, 
	f.fainelli@gmail.com, hargar@microsoft.com, jonathanh@nvidia.com, 
	linux-kernel@vger.kernel.org, linux@roeck-us.net, 
	lkft-triage@lists.linaro.org, patches@kernelci.org, patches@lists.linux.dev, 
	pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, sr@sladewatkins.com, 
	stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, "Kito Xu (veritas501)" <hxzene@gmail.com>, 
	Victor Nogueira <victor@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_RECIPIENTS(0.00)[m:miguel.ojeda.sandonis@gmail.com,m:ojeda@kernel.org,m:gregkh@linuxfoundation.org,m:achill@achill.org,m:akpm@linux-foundation.org,m:broonie@kernel.org,m:conor@kernel.org,m:f.fainelli@gmail.com,m:hargar@microsoft.com,m:jonathanh@nvidia.com,m:linux-kernel@vger.kernel.org,m:linux@roeck-us.net,m:lkft-triage@lists.linaro.org,m:patches@kernelci.org,m:patches@lists.linux.dev,m:pavel@nabladev.com,m:rwarsow@gmx.de,m:shuah@kernel.org,m:sr@sladewatkins.com,m:stable@vger.kernel.org,m:sudipm.mukherjee@gmail.com,m:torvalds@linux-foundation.org,m:hxzene@gmail.com,m:victor@mojatatu.com,m:pabeni@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:miguelojedasandonis@gmail.com,m:ffainelli@gmail.com,m:sudipmmukherjee@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296493-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,achill.org,linux-foundation.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,mojatatu.com,redhat.com,resnulli.us];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu.com:dkim,mojatatu.com:from_mime,mojatatu.com:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A677C6558A8

On Mon, Jun 8, 2026 at 6:08=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jun 8, 2026 at 11:55=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > Thanks for reporting this.
>
> You're welcome!
>
> > Unless i am looking at the wrong code version, in the current code i
> > see m_eaction is always initialized before being used.
> > m_eaction =3D READ_ONCE(m->tcfm_eaction);
> > Probably a compiler false positive?
>
> No, it is an actual bug -- you have:
>
>     int i, m_eaction;
>     ...
>     is_redirect =3D tcf_mirred_is_act_redirect(m_eaction);
>     ...
>     m_eaction =3D READ_ONCE(m->tcfm_eaction);
>
> i.e. the assignment goes later.
>
> Maybe you are looking at mainline? Please note that this is a 6.12.y
> -rc thread -- are you looking at the commit hash I mentioned?
>
> Or maybe you are looking at `tcf_blockcast()` instead of `tcf_mirred_act(=
)`?
>

I was certainly looking at the wrong version.
For example what you described as commit a01fbdecc3a2 ("net/sched:
act_mirred: Fix return code in early mirred redirect error paths")
shows up for me as commit e80ad525fc7e

I believe this bug slipped in during a small window but was fixed very
quickly. Probably some fix never trickled to stable.
If you can point me to the exact tree where this happens i can take a look.
Still curious: So only the arm compiler catches this?

cheers,
jamal

