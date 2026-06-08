Return-Path: <netdev+bounces-296715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tplBIMUnJ2rmsgIAu9opvQ
	(envelope-from <netdev+bounces-296715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:36:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0102565A7B6
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 22:36:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=cVdgS4eJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296715-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296715-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57253304671E
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 20:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B57239DBC9;
	Mon,  8 Jun 2026 20:36:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E934397339
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 20:36:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950973; cv=pass; b=q+bz3zb0/rGpmzm4eJXwXGwYlDYll3//N8dxHWsLjdSOsm8IJSUkZuP1MAjY8fBr+eMxtBbXHNYhUaHpUQToyXbs1xpe7Z7dzd6s/JaWaF9OMp+gp7S0zZBTXLTacHLXhWxN/uSknNZClW/reSMLlBLFIpVe+xE8H+pCzLkefRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950973; c=relaxed/simple;
	bh=B2tN+Ldk/5pCXIYwJUJf0VGuPcRdSjXr3Cs1XxacmqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2mRjfY9SSjocIRZxMEvhaxtkIJ4Q6CEvn8nIY7p2oKg5ndPanBskArZ+W65nzvDnKBLkEZd9dkZjEq5tMS+yxsukHaiXCL1xBmoKoSbxuygb8Gj9vDNYYhViV3bpWyNHfDChUB00/RTziSZr+U23fA5frLC1qZnxEb/V+uBjTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=cVdgS4eJ; arc=pass smtp.client-ip=209.85.210.169
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-842273a2c4dso3197758b3a.3
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 13:36:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780950970; cv=none;
        d=google.com; s=arc-20240605;
        b=lXivRQ+Sqx6BEetpTnNqoV43ebUKt5mLiOMPW4wh96fN4LXb4P9XLM9GDD7duLi+oX
         rrqgf3E7MAnj0gfSZw17Elr4tT3hpGzZ40Ubw+KH0o6gnunHFVko4g8Q6j/XcL1qF02w
         jLbcmXQfxRwedk+/DE5+uP4EOfnYrmFf7KjRZaMKCfGji690+dK6RgRVuHBdY+4bcxUy
         E5FwpuW5OF0Kz+7CIQKMGKqI5YP9sbdOLFQB4AX82rrtxveTZtdZXj5gPiamhPm0TTnl
         EdDX/kk5+BTsoRhMJZkLuWE8KMbz9LytBpCLSgh7LX9gmW7HSUTQNTZrFt76hK6+gwby
         MHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oVe+ITC2ml8n3gt+xHvgBn+FPMhVSI7g98/qjcMm7ZU=;
        fh=vIhxmJdbWE21aupSL2sM9dRxDFGj9wsLLDPcdzpwzNU=;
        b=f+URsh0ghcr4FgC6dKOLp5KjtWX9je/ATyjhWSDPN2N/RI+053iVqIuuVkTS7iGKaP
         +uzLpIBfcSfW7+SwYrn5bHYAR3pJUGN2uMdr68S9LPYXXhsTbBui4fDxJojJzl8tXM7P
         ylNMXbcWU2TcSaqEtvFhpSuMp9MryrcoINQlYxmeV7dlb1byS7WxLD0COGzl5jmsptwd
         HnEjhvaZPEign8OEYpRvPOAK7jxEAITOQa2l3zpnEGygu41fBKOMAitlUIxBTsgfvVEQ
         8fV1koel5xFFOoIqQBIWTW5QwnzvEmwmhzZMC4eNSVm/je789KwahlkQUAg+P0o24ivJ
         NQAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780950970; x=1781555770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVe+ITC2ml8n3gt+xHvgBn+FPMhVSI7g98/qjcMm7ZU=;
        b=cVdgS4eJeN5HgZl+w4tI8DIit6ZRbVnjIJdVdral+2FhJrH9jMnq0s4E+LSDmDBgbq
         fUY/ezY7NKmPj1/rjBo4ZI1Rw/IEClbaFo2l2nLOavxm6wcsyNuJqGKaMNKIvrBMt+/s
         P+hm39Fwr2/RO11GTlal4Q1glmgKfkNFnwsKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950970; x=1781555770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oVe+ITC2ml8n3gt+xHvgBn+FPMhVSI7g98/qjcMm7ZU=;
        b=AOnFz+OYkys/oYhbozsgZCMROMZfpqtV2dvVI7rMTKQG29mcyt4I5TprwfEglmhSfl
         tF9zpmmjhjkG2olwl5iMhWl6kUBROKRKvxTxOGrbR7obLhlr3I3l+m+jZfLtwd8u686W
         wzSLpF4plwBoeuyd080Gf7I/UaR+ozC0TFAEK/CUHi/fa3e0hjKlPf9QLW8QMVb+mU4N
         RsWYs5RpGX+r5aQevQpxA5NGE/WESpRGV9sc+eFzdl017GqlXWYe7Vj1Br+yeKuAgdwI
         sLwxYaRhIpGIUrlwg/gs/sJgLBjmoiseR4hXEw2ozMQGKfBHMYYRO/LIgQNGx1HrI/C1
         gBFA==
X-Forwarded-Encrypted: i=1; AFNElJ9tiOtKkrIXIJE0r4YbwbPnp6Njeow4xQeCTEjxC0hGf5+rMShiCXcmKVDU2Ney6yApqf8v28c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJjNYQ+MoaJSKSDzVB02FNny9/g23z6WtBaVxnR08K5ISJUpr
	hPXivrBqya1uOUhOZaVBZAe9rF2azS5lG93XtvgbnXKioresX8daFp71YWeLVzKChf3WzfJkNAV
	podRTGt7I4KdHFzUUQ5JfUgc4wGfgCH3yjFpZYDlL
X-Gm-Gg: Acq92OGjXaENvP1YNx5oQvlzRi6aecyJ7G9hHxe7OHKfIsWAu6AeNsLu9ydUPugiE2M
	Y05S/XAyYzuZFn/YeMZ7qHanNkZioTrrD8SvLSWm8QDAS28lQMuSue+JEurahT3cS7M+/pEf1hx
	Hr3qLvan/wg9f+8R5t6pnbKRFzRFf5dp7T0o1DKswVM8SxDF4w7aaq9Ix+nal5wsIeBoa3rwIE+
	j7XivitL+7C4mrLyM2vligf9NDJcJfbGQTXx0cv7L/conYzvuUg6rGB3s42NrAeUyIj5gpMTohS
	ful1m0EBX7TserpoeX0=
X-Received: by 2002:a05:6a00:4b04:b0:83e:d427:9817 with SMTP id
 d2e1a72fcca58-842b0db7dbamr16329172b3a.11.1780950970140; Mon, 08 Jun 2026
 13:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260607095727.647295505@linuxfoundation.org> <20260607173214.92693-1-ojeda@kernel.org>
 <CAM0EoMkszTXv82To=KnEYTgzQSmEdRW9XrAMVtJsUaDn=Akf6A@mail.gmail.com>
 <CANiq72mJNbNzYO37VK7s=ua5v31xBrRp8EnHDvEnKF8Z77jDmA@mail.gmail.com>
 <CAM0EoMmHd10iivCpDoEd3h+eae9fSnoGWAH_AkwFhrnS6PN63g@mail.gmail.com> <CANiq72k6J7FYT89svtX5qbCUWg-MKuhUHaT07cjk8o7PqaF8+A@mail.gmail.com>
In-Reply-To: <CANiq72k6J7FYT89svtX5qbCUWg-MKuhUHaT07cjk8o7PqaF8+A@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 8 Jun 2026 16:35:59 -0400
X-Gm-Features: AVVi8CekC54iinBDQEVgU-dJ9AL5uhMqEzLEARHoPqKy0ZaeCQmHeP3rPtW0Dmw
Message-ID: <CAM0EoMn9EA_TS80QzXsTscBpCgfJHssq0GHtiNbrMU3FAiP2mw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-296715-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,achill.org,linux-foundation.org,gmail.com,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,mojatatu.com,redhat.com,resnulli.us];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0102565A7B6

Hi Miguel,

On Mon, Jun 8, 2026 at 7:16=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jun 8, 2026 at 12:57=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > I believe this bug slipped in during a small window but was fixed very
> > quickly. Probably some fix never trickled to stable.
>
> Yeah, as I mentioned above, I think commit a005fa5d7502 ("net/sched:
> act_mirred: Fix blockcast recursion bypass leading to stack overflow")
> is missing (at least).
>
> I would suggest reviewing the entire chain to see what needs to be backpo=
rted.
>
> > If you can point me to the exact tree where this happens i can take a l=
ook.
>
> This is the 6.12.y -rc tree:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.gi=
t
> linux-6.12.y
>
> The stable kernel team puts the link to the repository at the top of
> the thread too:
>
>   https://lore.kernel.org/stable/20260607095727.647295505@linuxfoundation=
.org/
>
> > Still curious: So only the arm compiler catches this?
>
> It likely gets caught by other arches too, i.e. I just happened to
> catch it in my arm64 build.
>
> This is Clang, not GCC, by the way.
>

I think it was too early AM here when i was looking at this.
The answer was right there all along in what you said: The missing
piece is commit a005fa5d7502

cheers,
jamal
> I hope this helps!
>
> Cheers,
> Miguel

