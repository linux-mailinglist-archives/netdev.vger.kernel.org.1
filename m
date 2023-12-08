Return-Path: <netdev+bounces-55277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4B580A170
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 11:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90FCCB20A3C
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3812B70;
	Fri,  8 Dec 2023 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oHdHL+Ec"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8644E9
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 02:49:55 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so9053a12.0
        for <netdev@vger.kernel.org>; Fri, 08 Dec 2023 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702032594; x=1702637394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3ICmYU4vtByBj+ZOAeC38kXJDhlJqpO3Ji47gj7LUU=;
        b=oHdHL+EcaALLHM9gAbj3yE1JWxJMVYcqZI80gPo2PqtCWrWeRcgDpt9knkF7OcUq8y
         B0/MfEONtWFD3cqHSLbdm7RqqNcG6czi82Wxd8wmSn/XeD3sya4AvoaucdJ/dMngmduG
         Lr3SpHNJSyfDeuqfs3FQoTP8dHknDCM26LhlEUSqVjc12qMfiJnzQbwHvucawX8AKlTb
         S0XPzLrchJ/+pDs0rVyeQKKOeEfhwLLNBrtLQPpHJ+HBitdaKej5Ssx3Ed4zM5AJGrS+
         Nj/UEBBKoYoplgcA6JxJqoEd/LOVhH0hAZeaPKnpNvrKTCahFtrxGdpRzFli7eB+gJ3S
         iWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702032594; x=1702637394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a3ICmYU4vtByBj+ZOAeC38kXJDhlJqpO3Ji47gj7LUU=;
        b=Pl34d6uq8foCrk7DQCIkagKCSKMaWRj+Yku8sWd2rwh7/L/2z5LYTrKq+yfe13WIJU
         AhSEDRCdiNrzrPhZbG/UvHvKmUMazbhIw1NuH3wofbpOlwU5/5pkktTY/24daNdwRkuj
         9ZsDnIES7rLZpaTA9HM8AqHyIUISefXjDkAwRQdoclHrHs8YwbkrQr8XFNyNgVe32fYZ
         nZfApJAOU8pF69QP3Kxs0iJxsvp5vaFdbAzGTeFvKn9OHRq+56Y/HqMCudsFlPK8y2ln
         DQ4UpWhxFWBxfvuzplj5F/CDMQsFikWgF6j9Rk0buHCnYXJ3neF9/4ikfzTLMC145lL9
         RU4A==
X-Gm-Message-State: AOJu0YyUN/kqsYS5EiHH9kH+qJAankbKP1x8Yr4X0E8nGVbf6pDEndy1
	zs3JfbFnW2w/UZUi8+5r+s/fTcEsgU5oLliVQG5ASg==
X-Google-Smtp-Source: AGHT+IFJgvPxeKl+froO/n1xOLoH9c4jeQ7frZ9rnypL/gsx3xc0licEqthQwCs4B2IITcdsRQfKl5Yh550YZOykElg=
X-Received: by 2002:a50:d7ca:0:b0:54a:ee8b:7a8c with SMTP id
 m10-20020a50d7ca000000b0054aee8b7a8cmr45593edj.0.1702032594082; Fri, 08 Dec
 2023 02:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MN2PR12MB44863139E562A59329E89DBEB982A@MN2PR12MB4486.namprd12.prod.outlook.com>
 <CANn89iKvG5cTNROyBF32958BzATfXysh4zLk5nRR6fgi08vumA@mail.gmail.com> <MN2PR12MB4486457FC77205D246FC834AB98BA@MN2PR12MB4486.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4486457FC77205D246FC834AB98BA@MN2PR12MB4486.namprd12.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 8 Dec 2023 11:49:40 +0100
Message-ID: <CANn89i+e2TcvSU1EgrVZRUoEmZ5NDauXd3=kEkjpsGjmaypHOw@mail.gmail.com>
Subject: Re: Bug report connect to VM with Vagrant
To: Shachar Kagan <skagan@nvidia.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>, Ido Kalir <idok@nvidia.com>, 
	Topaz Uliel <topazu@nvidia.com>, Shirly Ohnona <shirlyo@nvidia.com>, 
	Ziyad Atiyyeh <ziyadat@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 2:03=E2=80=AFPM Shachar Kagan <skagan@nvidia.com> wr=
ote:
>
>
> >> On Thu, Nov 30, 2023 at 2:55=E2=80=AFPM Shachar Kagan <skagan@nvidia.c=
om> wrote:
> >>
> >> Hi Eric,
> >>
> >> I have an issue that bisection pointed at this patch:
> >> commit 0a8de364ff7a14558e9676f424283148110384d6
> >> tcp: no longer abort SYN_SENT when receiving some ICMP
> >>
> >
> > Please provide tcpdump/pcap captures.
> >
> >  It is hard to say what is going on just by looking at some application=
 logs.
> >
>
> I managed to capture the tcpdump of =E2=80=98Vagrant up=E2=80=99 step ove=
r old kernel and new kernel where this step fails. Both captures are attach=
ed.
> The tcpdump is filtered by given IP of the nested VM.

Hi Shachar

I do not see any ICMP messages in these files, can you get them ?

Feel free to continue this exchange privately, no need to send MB
email to various lists.

Thanks.

