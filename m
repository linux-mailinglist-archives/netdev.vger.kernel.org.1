Return-Path: <netdev+bounces-60110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4388681D696
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 22:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF78928283F
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 21:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D7E15EB9;
	Sat, 23 Dec 2023 21:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mKbOxKU2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7115EBD
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-67f47b15fa3so22490186d6.1
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 13:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703366131; x=1703970931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0tx7ponhtijbPfBnjEESDwBexmRUFkV7kALNo39kR8=;
        b=mKbOxKU2rZ2ivHkJP5icfQdKcZk1Srd1fBdiZGdJ1BbWccumKvPBQlNxeWzFgH7/9Z
         lwV57/9iGNEPY07nQuiqmITdbADsMBG4/W5scWreY93cipq6OwtH3KDsxEc5C+0h+Zci
         ER80kamWCwRZgYuy3bWLu+Kw5CTK8yIiZE4dC3eEN47vnvxR3Irw/SFEnW4aBcXxXSdJ
         b+xx1v3vamWrn6+dXzuy1CsecApPpX9QBGmsS8+ODYoI3ZXVmXXktKL+AAEx4YFRG9Wk
         XrcMHeGRAB9hdQd9aKssY4AkEG0bHS1vl518LRHzZ2cM9DlCoiyiwwsGAlek3vJJ/ZVT
         zR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703366131; x=1703970931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0tx7ponhtijbPfBnjEESDwBexmRUFkV7kALNo39kR8=;
        b=RDaPktLg2LF8oYWQfOtOptQvqnPI+Ff2+7EUrnKhWCdUmpPdf0aZeMzNEjFnmt73bR
         DDhKlyXgRKKwNddcb06XtN/fts23NsOEu6tMMvUva0O1APoNz3AZEBCd11arxg39Iqkw
         3U9xumgXKjXTOqewVgWvA2dl5GH9dvzrOxinxT1Z8YfWrxBdzPmmxVFuTYHk3+aoWxqX
         DdHOIJemSr2MoeNC70OmTlxg81hiW7sRaNxQDKuaMjO3v/+nizx382cDJksJx5gW9Alx
         ya1gx4/kVfKGYFJFBRFA4D3I/Vt3bt9tFM1tX7AgPjFpPALfPn77B3Xy/mLLQh+z9q8k
         Mv2A==
X-Gm-Message-State: AOJu0YwbyiKwT9+DBefqPSsdUn0OSZHSEBE4IqLXVqvxv8MkSI+XovYa
	MCtvmZujInRPxMfEZZPTKVSt3RQoxte1vyqgSD+khYPYEh+q
X-Google-Smtp-Source: AGHT+IEZYfRnemrpu19ZtwEl31xok0ECLtEzOlHF+ZgdUq4ZGNCcJvMmxfntmj3a8Cqh9lKlt+CCqE7u1YBNe4tTgiw=
X-Received: by 2002:ad4:58b0:0:b0:67f:9d80:bc5e with SMTP id
 ea16-20020ad458b0000000b0067f9d80bc5emr3443149qvb.54.1703366130743; Sat, 23
 Dec 2023 13:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223140154.1319084-1-jhs@mojatatu.com> <20231223140154.1319084-2-jhs@mojatatu.com>
 <20231223091657.498a1595@hermes.local>
In-Reply-To: <20231223091657.498a1595@hermes.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 23 Dec 2023 16:15:19 -0500
Message-ID: <CAM0EoMnxkH0s4O+txBQKXdMq3-Wr-jYa7N8qWuw+OF18FAFDzw@mail.gmail.com>
Subject: Re: [PATCH net-next 1/5] net/sched: Remove uapi support for rsvp classifier
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	netdev@vger.kernel.org, dsahern@gmail.com, pctammela@mojatatu.com, 
	victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 23, 2023 at 12:17=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sat, 23 Dec 2023 09:01:50 -0500
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> > diff --git a/tools/include/uapi/linux/pkt_cls.h b/tools/include/uapi/li=
nux/pkt_cls.h
> > index 3faee0199a9b..82eccb6a4994 100644
> > --- a/tools/include/uapi/linux/pkt_cls.h
> > +++ b/tools/include/uapi/linux/pkt_cls.h
> > @@ -204,37 +204,6 @@ struct tc_u32_pcnt {
> >
>
> Seems like a mistake for kernel source tree to include two copies of same=
 file.
> Shouldn't there be an automated make rule to update?

Probably there is - but if you pull a fresh net-next those files are
present in both those two dirs, so it seemed rational to patch both.

cheers,
jamal

