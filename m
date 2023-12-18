Return-Path: <netdev+bounces-58596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74CF817733
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 17:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F6E1C25135
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55EDE57C;
	Mon, 18 Dec 2023 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ocsu6Bd+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571743D54B
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-679dd3055faso21109326d6.0
        for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 08:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702916212; x=1703521012; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=39osfUB05y2x+GqHUsZEdUtckVTaGnfyEgf6uxp1vDA=;
        b=Ocsu6Bd+iEub86k40IpAjUtUUTQbmZvfbw0dldzuYEjfIXOWkO3TgF7jHb8sYslOg0
         d0mXmKFpjvNYE8Mj2V/6OfRM11AlGNQOZDa6X9IQUm6rxXoFdE6aJWq5zP7j/d9CkN4N
         B+EOxtFuffmZ9Cot0jiedb3Nw75JXqRSGvjudhnlE6YMzyZs5x/T4/P1hKP8PStGaCy3
         9QXb2Vcsdtly7nJaYhhfmexsaThelx/HNrsxki77m2fMKWHvRCqwaePrlzBi5q8KORft
         JPc986YWTj99OJkT/GM737qi3QVx0j1uvHZjayZBHqKXqSTt6GQQ1oa7yS3P+a1nvTU8
         aFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702916212; x=1703521012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=39osfUB05y2x+GqHUsZEdUtckVTaGnfyEgf6uxp1vDA=;
        b=flVjiha52IgGjtjoMkdAx46uQXIVDvVowDvNp9p0V8k2kL/tQy+/Lq0zyetlWx6KIu
         MJjf8F13BJ3LvQwafEJ93pT2WwCDVI6xn/si6PcqnFZCa/OE8iLNiThEKdM2TWshDewK
         Dj3/XhT4qI1tuIoI2NNLnDMGP42x01IgHc7AidyvW52Vz1MfB/qmtliM69PEYIq9i/HJ
         bXOpm7XPiu59W/MTO1yE4HCd2rkkzg3v90ArpcPn/9aXrEdp2Y0DZ4H9TqvBrV6JYxWR
         UJgALv4sXH4l9muTkNQeMFe80qep4bL7PfT2r2BkTUlfeXsOyVeLAMBsy6JXfGbsWA81
         WgIA==
X-Gm-Message-State: AOJu0YzGt5fg4o6fV+7dD5DpxWsO9M58BHP2O3pVNcJqtKZNLr43vP+T
	h3FgJ9JNaBb3sJSx7N8GLLewRlGNc/z32mVY1o8MOw==
X-Google-Smtp-Source: AGHT+IErf6Qgr+QCsASbwBcqCK2t5RR1+hnZ6pOfeuPnrxShsz1icshjaLwXhkrR0jogLXDeEbasEqQ24od3qLSodSs=
X-Received: by 2002:a05:6214:226a:b0:67f:225b:f346 with SMTP id
 gs10-20020a056214226a00b0067f225bf346mr7714147qvb.70.1702916211971; Mon, 18
 Dec 2023 08:16:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207164911.14330-1-marcin.szycik@linux.intel.com>
 <b3e5ec09-d01b-0cea-69ea-c7406ea3f8b5@intel.com> <13f7d3b4-214c-4987-9adc-1c14ae686946@intel.com>
 <aeb76f91-ab1d-b951-f895-d618622b137b@intel.com> <539ae7a3-c769-4cf6-b82f-74e05b01f619@linux.intel.com>
 <67e287f5-b126-4049-9f3b-f05bf216c8b9@intel.com> <20231215084924.40b47a7e@kernel.org>
 <ff8cfb1e-8a03-4a82-a651-3424bf9787a6@linux.intel.com> <1eb475bb-d2ba-4cf3-a2ce-36263b61b5ff@intel.com>
 <ZYBr98sd+XzSfy9v@yury-ThinkPad>
In-Reply-To: <ZYBr98sd+XzSfy9v@yury-ThinkPad>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 18 Dec 2023 17:16:09 +0100
Message-ID: <CAG_fn=XOguL_++vJk2kFQoxu1msLzFBB5sJiD8Jxr4oUZ7qZ7g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v4 0/7] Add PFCP filter support
To: Yury Norov <yury.norov@gmail.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Marcin Szycik <marcin.szycik@linux.intel.com>, Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, michal.swiatkowski@linux.intel.com, 
	wojciech.drewek@intel.com, idosch@nvidia.com, jesse.brandeburg@intel.com, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 4:57=E2=80=AFPM Yury Norov <yury.norov@gmail.com> w=
rote:
>
> + Alexander Potapenko
>
> On Mon, Dec 18, 2023 at 01:47:01PM +0100, Alexander Lobakin wrote:
> > From: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Date: Mon, 18 Dec 2023 11:04:01 +0100
> >
> > >
> > >
> > > On 15.12.2023 17:49, Jakub Kicinski wrote:
> > >> On Fri, 15 Dec 2023 11:11:23 +0100 Alexander Lobakin wrote:
> > >>> Ping? :s
> > >>> Or should we resubmit?
> > >>
> > >> Can you wait for next merge window instead?
> > >> We're getting flooded with patches as everyone seemingly tries to ge=
t
> > >> their own (i.e. the most important!) work merged before the end of
> > >> the year. The set of PRs from the bitmap tree which Linus decided
> > >> not to pull is not empty. So we'd have to go figure out what's exact=
ly
> > >> is in that branch we're supposed to pull, and whether it's fine.
> > >> It probably is, but you see, this is a problem which can be solved b=
y
> > >> waiting, and letting Linus pull it himself. While the 150 patches we=
're
> > >> getting a day now have to be looked at.
> > >
> > > Let's wait to the next window then.
> >
> > Hey Yury,
> >
> > Given that PFCP will be resent in the next window...
> >
> > Your "boys" tree is in fact self-contained -- those are mostly
> > optimizations and cleanups, and for the new API -- bitmap_{read,write}(=
)
> > -- it has internal users (after "bitmap: make bitmap_{get,set}_value8()
> > use bitmap_{read,write}()"). IOW, I don't see a reason for not merging
> > it into your main for-next tree (this week :p).
> > What do you think?
>
> I think that there's already enough mess with this patch. Alexander
> submitted new version of his MTE series together with the patch.

Yeah, sorry about that. Because the MTE part of the patches was still
awaiting review, I thought it would be better to land the bitmap API
separately, but as you pointed out there should be at least one user
for it, which it wouldn't have in that case.

I don't have a strong preference about whether to submit the patches
before or after the end of year - in fact I don't think they are
urgent enough, and we'd better postpone them till January.

So unless Alexander has urgent fixes depending on my bitmap patches,
I'd suggest waiting till they are taken via the arm64 tree.

> https://lore.kernel.org/lkml/ZXtciaxTKFBiui%2FX@yury-ThinkPad/T/
>
> Now you're asking me to merge it separately. I don't want to undercut
> arm64 folks.
>
> Can you guys decide what you want? If you want to move
> bitmap_read/write() with my branch, I need to send it in -next for
> testing ASAP. And for that, as I already said, I need at least one
> active user in current kernel tree. (Yes, bitmap_get_value8() counts.)
>
> If you want to move it this way, please resend all the patches
> together.
>
> Thanks,
> Yury



--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Liana Sebastian
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg

