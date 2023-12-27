Return-Path: <netdev+bounces-60397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC3D81F0AB
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 18:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307D01C219B3
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 17:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E110645C0B;
	Wed, 27 Dec 2023 17:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="RbgWAKUF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4168945BE5
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 17:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbd029beef4so4843362276.0
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703696581; x=1704301381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGGpmDyCOAVTfPuNyeaql2/nHGZzSIk1f0fzagp9sTE=;
        b=RbgWAKUFmDHOkoAFKurx+OYuL0dcskN7eTAQZ2pfoH15mz2grBFy81e791IqdWOi/d
         XA/mkaDbeMBoPXPywbESXtPvra4p0NGG7istnFBZgHR0zp/+t56Uhhvbf2GwIvH+cx+K
         Hsyq8TqJG9qgWdvVkaOl69OkDIL8SG0GQVSdK3XjUe4mG4lG4ZQLSaj+EcGwi3W1tA7d
         puNNWrFNQD0NUHE7vKFNkdmPgN/8BRxSZHgxn4uhrLtPiesz/iCgi223Q3ngTqCQ2yHz
         yCocBvHbJ5jR8tr2dzxdHwIJ9JKN/N6LUdYz0SmCtrIbyw/ZZnqbCS4fQkINOeQT2PqN
         7u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703696581; x=1704301381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGGpmDyCOAVTfPuNyeaql2/nHGZzSIk1f0fzagp9sTE=;
        b=UNwsdiOR155t3hJyG1ziMHy1rq8SK1aa9KG4rwx4arHTop5X5X+x9nx1qsKryuvEXx
         t34GRAVKnitcjv6P3YWhCTxT2WCdSe5EI1XX6Emoir7AC5F6znhC7Tz0i/JC0R0AdFHA
         aKRAz1OQW7Sx4rNoGYjSzIgjhleR4PvP3QOSbibKB7w5ggW/C2ukmPkwaKS7ZCN/U/AK
         HxwirO3DFYyeuk0lHrD+isqYwbiuqBRfEroPSyIkuzN1e92GC7DrgEacEn6qIpZwBQOQ
         8YfBv9vrvf07Cs84bhO8SLFccTB+wPUPFOYlHPmag228noBYBdGpfYGrcE3tCDWLotWh
         Tnww==
X-Gm-Message-State: AOJu0Yy96YHBaYTuxv932RlKe88iI475U4uv/YHBig97P5vS8oacXtyJ
	KjR0HDopQY4w9N7cHyKreqlJMezQUP2phSCjknrYC30RQo5h
X-Google-Smtp-Source: AGHT+IHTvTD/jP8fxBI/SM3MB9o4zJ5KrqIwobuhiEM5CRa1hOMcDWlEB3sCgezF8eB8Yh4CNzmFkxw8iFwFY/KK4e4=
X-Received: by 2002:a5b:9d1:0:b0:db7:daec:ec5a with SMTP id
 y17-20020a5b09d1000000b00db7daecec5amr6380156ybq.33.1703696581102; Wed, 27
 Dec 2023 09:03:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231224165413.831486-1-linma@zju.edu.cn> <CAM0EoMm8F3UE3N-PBZmJHQpYYjiV23JKf6jGsvzzWs0PBd+AWQ@mail.gmail.com>
 <6aab36aa.56337.18ca3c6af7a.Coremail.linma@zju.edu.cn>
In-Reply-To: <6aab36aa.56337.18ca3c6af7a.Coremail.linma@zju.edu.cn>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 Dec 2023 12:02:49 -0500
Message-ID: <CAM0EoMmBp6SWDGhPkusnx0jh4y=1k9ggS+5UpV+0MtEccDgyXw@mail.gmail.com>
Subject: Re: [PATCH net v1] net/sched: cls_api: complement tcf_tfilter_dump_policy
To: Lin Ma <linma@zju.edu.cn>
Cc: xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 25, 2023 at 8:39=E2=80=AFPM Lin Ma <linma@zju.edu.cn> wrote:
>
> Hello Jamal,
>
> >
> > Can you clarify what "heap data leak" you are referring to?
> > As much as i can see any reference to NLA_TCA_CHAIN is checked for
> > presence before being put to use. So far that reason I  dont see how
> > this patch qualifies as "net". It looks like an enhancement to me
> > which should target net-next, unless i am missing something obvious.
> >
>
> Sure, thanks for your reply, (and merry Christmas :D).
> I didn't mention the detail as I consider the commit message in
> `5e2424708da7` could make a point. In short, the code
>
> ```
> if (tca[TCA_CHAIN] && nla_get_u32(tca[TCA_CHAIN])
> ```
>
> only checks if the attribute TCA_CHAIN exists but never checks about
> the attribute length because that attribute is parsed by the function
> nlmsg_parse_deprecated which will parse an attribute even not described
> in the given policy (here, the tcf_tfilter_dump_policy).
>
> Moreover, the netlink message is allocated via netlink_alloc_large_skb
> (see net/netlink/af_netlink.c) that does not clear out the heap buffer.
> Hence a malicious user could send a malicious TCA_CHAIN attribute here
> without putting any payload and the above `nla_get_u32` could dereference
> a dirty data that is sprayed by the user.
>
> Other place gets TCA_CHAIN with provide policy rtm_tca_policy that has a
> description.
>
> ```
> [TCA_CHAIN]             =3D { .type =3D NLA_U32 },
> ```
>
> and this patch aims to do so.
>
> Unfortunately, I have not opened the exploit for CVE-2023-3773
> (https://access.redhat.com/security/cve/cve-2023-3773) yet but the idea
> is similar and you can take it as an example.
>

Sorry, still trying to follow your reasoning that this is a "net issue":
As you point out, the skb will have enough space to carry the 32 bit
value. Worst case is we read garbage. And the dump, using this garbage
chain index,  will not find the chain or will find some unintended
chain. Am i missing something?

Can you send me a repro (privately) that actually causes the "heap
data leak" if you have one?

cheers,
jamal


> > cheers,
> > jamal
> >
>
> Regards
> Lin

