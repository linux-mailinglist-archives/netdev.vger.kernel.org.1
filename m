Return-Path: <netdev+bounces-59884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F05CD81C877
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 11:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A41BB24E76
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 10:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF21426C;
	Fri, 22 Dec 2023 10:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="ckngAYBV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5444218038
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 10:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bb69f38855so1193101b6e.1
        for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 02:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703241916; x=1703846716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/a8r6PKuARExnwpyrX3ZOHL8kxbLUNx+rkDy50ZOMao=;
        b=ckngAYBVEuBLwD7JojG4oPr1vvbxCRbUqZZk506LgVF9uDY8yExkt+QkBXaZdzfwh3
         LQBiqserYQQVzieIyQ3RyAR2C6ynhh5FMNDx1N1474cAytQbHhp2itwBjkItfQTwi9DI
         xzOg3MnM3rXBrdj2upB/nOfEY1jBiu5yZTSFzehT/tIFsDzAxkNv0d/tL5GdEQiuD+CQ
         XidDig9yU+lj0qHqOVUOZqPlnD7zKne+w97IfoAqg/R42OttalDvxlLbRTgAJ27ll5kt
         trF1/SeKvIO99010YrM8GmhFKGkddR89vCdVAqA4usgTEaCV11nkLDQzNwKKAQqAwiO5
         aquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703241916; x=1703846716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/a8r6PKuARExnwpyrX3ZOHL8kxbLUNx+rkDy50ZOMao=;
        b=LvqweHwzwH+gDpP1UtaBH42KW3hotr/4DUe2/Stm4PK7jC8gVbexOGSaNdsL/h4Tps
         1JVGd2CLW0vqKO/Q4+5u40WsX8QNGCEJTEIY6VJwjIMRueeYxr5q5TVuJhebkkZWcwZR
         b9ofmgXLe3BAOcI8vux47xsppjMSXCwYTzhT1XSPeB2ljvJkCn57l+LxVYxIo1eFMspv
         A1m+WNigGWnZ3DFCMYda6zDL9KUru4j/l/OZVzvBmB0xgzpfiygksdXo4PSDyv50Qi5y
         mk4ecoAYT2KrU4HYXlFCzgSQHLnfYPD1h1blsFhPe2/YmeOkJpviqnATiVHFhmJASnDR
         NFvw==
X-Gm-Message-State: AOJu0Yw1uuFhLjQbTNzYsTh+gDE3FtFf1eQZKRMJONbkF1iyqaRL7WZW
	SZgA5XfEmJxQtUNLaEphvXjvQX8XaTflrrTawbjbZtYLWDoj
X-Google-Smtp-Source: AGHT+IEixbreqpAQnLItiosMVvdvh4jAsgmlQm70B8VLd9xExoV/uYAXf6Y3GZnED/aEFY+nITu8QKsWkv58QBSwQX0=
X-Received: by 2002:a05:6808:23cc:b0:3b8:b063:664b with SMTP id
 bq12-20020a05680823cc00b003b8b063664bmr1126666oib.66.1703241916252; Fri, 22
 Dec 2023 02:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231221213105.476630-1-jhs@mojatatu.com> <20231221213105.476630-2-jhs@mojatatu.com>
 <6aab67d6-d3cc-42f5-8ec5-dbd439d7886f@mojatatu.com> <20231221171926.31a88e27@hermes.local>
 <e17d5e1e-acd0-4185-ab9d-3efe2833cdd1@gmail.com> <20231221195218.3fc45303@hermes.local>
In-Reply-To: <20231221195218.3fc45303@hermes.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 22 Dec 2023 05:45:04 -0500
Message-ID: <CAM0EoMky-+PTxwMxTMUx0M8e-W4mckjYgqU0Uv3gV9fdjDtO7A@mail.gmail.com>
Subject: Re: [PATCH net-next 1/2] net/sched: Retire ipt action
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>, Pedro Tammela <pctammela@mojatatu.com>, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	fw@strlen.de, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 21, 2023 at 10:52=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Thu, 21 Dec 2023 19:02:40 -0700
> David Ahern <dsahern@gmail.com> wrote:
>
> > On 12/21/23 6:19 PM, Stephen Hemminger wrote:
> > >
> > > Yes, it breaks iproute2 build if tc_ipt.h is removed.
> >
> > iproute2 header sync would need to remove it. It only breaks apps that
> > do not import uapi files from the kernel.
>
> The problem is that when tc_ipt.h is removed, there are defines still use=
d.
> Will need to coordinate removal of ipt support in iproute2 at same time.

And per our discussion at netdevconf, you'll take care of that i.e you
didnt want any patches for the sync.
I didnt didnt delete the uapi for the other qdiscs + classifiers i
removed earlier (which i notice are still in iproute2), so, I am going
to send a bunch more patches to remove the headers from the kernel.

cheers,
jamal

