Return-Path: <netdev+bounces-61600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCDE8245F7
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 17:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BB01F25506
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9936D24A13;
	Thu,  4 Jan 2024 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="UicNYoke"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE8424A1F
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5f07f9d57b9so6627057b3.1
        for <netdev@vger.kernel.org>; Thu, 04 Jan 2024 08:15:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1704384954; x=1704989754; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iDUc2FmEIy9+VkvFb9DFPlM6A0kVZW+vy7X8sS6Vq4=;
        b=UicNYokeFvjA0XO1VrC7xFais8QHRBItbteCfDmSyA3RieBzZDB5qsddAfB7ydYSMI
         Q8ev3bwDbPHVDoX7qCnu1SgJ18Yy197c10N8jF5j0HGh9M0mpzT7RWT1GevkB7i6+Y43
         RRx0O6QxTuDmVw3pDfzszgjebGWpDTnnU0MG0wPaJ7GK6IGPWcRSx6lInkqOLCppGNnL
         daR6kR4scdlAQgLJd6KTBeCHbwVVZ+8U44wQk/L6lczmnKkcfAlra+XPQwpd6XQqp4B6
         HbJESM0Brrx63PVZfctbGKpZqUnz34i9TDmvqOP3NNKpuEjfer0G2yLdWD34uoFAcqyu
         cYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704384954; x=1704989754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iDUc2FmEIy9+VkvFb9DFPlM6A0kVZW+vy7X8sS6Vq4=;
        b=reII/6bNwum8lBCjUa7ZTVDWqxk6rlYc1dFdcW8+Idc9qO0lENUZ8EW4N1A0nG+KQU
         wv/z1bbO4iuYi8AI6P99XcsGAmETfPrfhrQPd8qU9aBHxQEmGKS1CQJH9KKfsA80Kg7r
         ynpDtTW7kshqjQBZDNkx7QQWkGr8TmXpDvMN/Mo007MP4WklK/N4fLVlPqxSpxESn+bG
         Tg+pDhmeQip0xUf8hFdfPXDIU49RWzpMFNPLJYqaEvt2ZOLdIoquHh3I5k/AYq+7OQKu
         i23C9V/K99UIjZTxClOmsIMdOTmdY0XXEtlj9vFWD5GCtIai24ZL+5Xwuo0xuI4l6+n9
         ut7w==
X-Gm-Message-State: AOJu0Ywj1xyO9wldXdB7D9VL/qsWt+eZ44tJlDqPcdKlRuGEUdB1BqVG
	P20BDXPufGiVyp05j9JjAIKjuHUl1snXQzRanJImBT1ERRHIsq90kxARUpA=
X-Google-Smtp-Source: AGHT+IFDbwg8NO07qZuTsaxZwio2lJhLEbLw0zJ+9hJ5lrIAxUd/nLhegxycUI5nO2zKYu3W0F52qtM6OKRBhUXFI9E=
X-Received: by 2002:a81:d54f:0:b0:5d7:1941:2c26 with SMTP id
 l15-20020a81d54f000000b005d719412c26mr796347ywj.83.1704384953833; Thu, 04 Jan
 2024 08:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226182531.34717-1-stephen@networkplumber.org>
 <CAM0EoMmH-5Afhe1DvhSJzMhsyx=y7AW+FnhR8p3YbveP3UigXA@mail.gmail.com> <20240104072552.1de9338f@kernel.org>
In-Reply-To: <20240104072552.1de9338f@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 4 Jan 2024 11:15:42 -0500
Message-ID: <CAM0EoMkP18tbOuFyWgr=BaCODcRTJR=rU6hitcQSY_HD9gD87g@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2] remove support for iptables action
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eyal Birger <eyal.birger@gmail.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 10:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 27 Dec 2023 12:25:24 -0500 Jamal Hadi Salim wrote:
> > On Tue, Dec 26, 2023 at 1:25=E2=80=AFPM Stephen Hemminger
> > <stephen@networkplumber.org> wrote:
> > >
> > > There is an open upstream kernel patch to remove ipt action from
> > > kernel. This is corresponding iproute2 change.
> > >
> > >  - Remove support fot ipt and xt in tc.
> > >  - Remove no longer used header files.
> > >  - Update man pages.
> > >
> > > Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> >
> > Does em_ipt need the m_xt*.c? Florian/Eyal can comment. Otherwise,
> > Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> Damn, I was waiting for Eyal to comment but you didn't CC
> either him or Florian =F0=9F=98=86=EF=B8=8F
>
> Eyal, would it be possible for you to test if the latest
> net-next and iproute2 with this patch works for you?

Sorry bout that. Also Florian (who wrote the code).

cheers,
jamal

