Return-Path: <netdev+bounces-47048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AAB7E7B01
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C851C20C4F
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7713B12B8A;
	Fri, 10 Nov 2023 09:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="feXU+wn2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF7E12B70
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:42:15 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2D624C2B
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 01:42:14 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-545557de8e6so21933a12.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 01:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699609333; x=1700214133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmxVCAwdLZFwIuLS2I/EoyhaF6HjD4jvqku72VUlqzc=;
        b=feXU+wn2x+gdZQzbi+Lg2KLq3ogeGXn93/zJvQL+nDAZ7uEks8k5IdCZUMRS0Kn+Mg
         fGK2K/95mWmATm9hyMJHP8ruaPvQsMr09FqYt9MHyrd6mjNOjSPTAVKxwfyiZJWCVOSj
         GAuJxhvqATPpWji3gSCOryfvCQCxaOzv9xdGxw+sNOSxNdkSOMjBp6zX6xRdQvyPdr5M
         g9Rfyjyz98hejCPaY6fDs0B7ZNcFCHw/vG83ma0muER0XQlPISO7DLO79lVAaq9Y0sy1
         ifSs+IOwVdqJ3vib0jEl8xIq/S6FoGad7kMOwo+tzEfEKjBK0S0SxF2eYdCURbTXt+CF
         7Bqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699609333; x=1700214133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mmxVCAwdLZFwIuLS2I/EoyhaF6HjD4jvqku72VUlqzc=;
        b=bMSb26ExRP0aQ6W7zEwgDg4I7sXcWOAFIUtrF6YvFLviRGS70EPHb73EdPgoLmiWkv
         xnIBEBtyGEXhI2Z/4s3Ikir9TphOja6hzGGfLz/XuHZgw1VXVVPKV7PuHKHT5HMy9hht
         ZYtRVsTvWkX9ZEiuPavyDGMmuX1mORYfNT5hsvfKAmVtvGeZ5tGRP92kq5hq3JOuZHVb
         K6mdPVmrssshYot1PMU1TMYmu0W0ym1tju06cOrSoDbp+r0Uk6r6qcV//i9wGkcrdWpY
         E271AnjqvFEg9if3IiRiZdbDMRKfCrHXUNndbUwZPSunJL5yzRi6rS/6bI7W1OYyHOD8
         R0Dw==
X-Gm-Message-State: AOJu0YxE4IvnSbaacsdsL7DsrOEpu5EGp3zkvsv4AdeQigeyEoFjXdru
	nd59mL9JzAF+uQk7BZQG3JjxEiXWO+lgjbBUxnKd3g==
X-Google-Smtp-Source: AGHT+IHDZ/W3wralis11OF2Z20K+EJ5HLeNXlezUU6GiSEeujqAMbUN7+Kg7t4DoYI/gz6SgOZVe1WVg+rkDOnOKy8c=
X-Received: by 2002:a05:6402:1484:b0:544:466b:3b20 with SMTP id
 e4-20020a056402148400b00544466b3b20mr300607edv.5.1699609332822; Fri, 10 Nov
 2023 01:42:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109174859.3995880-1-edumazet@google.com> <ZU2wRnF_w-cEIUK2@hoboy.vegasvil.org>
In-Reply-To: <ZU2wRnF_w-cEIUK2@hoboy.vegasvil.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 10 Nov 2023 10:42:01 +0100
Message-ID: <CANn89iL5NC4-auwBRAitOiGMEk1Ewo9LOu2TitYHnU3ekzAaeA@mail.gmail.com>
Subject: Re: [PATCH net] ptp: annotate data-race around q->head and q->tail
To: Richard Cochran <richardcochran@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 5:23=E2=80=AFAM Richard Cochran
<richardcochran@gmail.com> wrote:
>
> On Thu, Nov 09, 2023 at 05:48:59PM +0000, Eric Dumazet wrote:
> > As I was working on a syzbot report, I found that KCSAN would
> > probably complain that reading q->head or q->tail without
> > barriers could lead to invalid results.
> >
> > Add corresponding READ_ONCE() and WRITE_ONCE() to avoid
> > load-store tearing.
>
> Acked-by: Richard Cochran <richardcochran@gmail.com>

Note the syzbot report I am looking at point to bugs added in

commit 8f5de6fb245326704f37d91780b9a10253a8a100    ptp: support
multiple timestamp event readers

For instance ptp_poll() can crash.

I saw the following patch being merged (without me being CC ?)

commit 8a4f030dbced6fc255cbe67b2d0a129947e18493
Author: Yuran Pereira <yuran.pereira@hotmail.com>
Date:   Wed Nov 8 02:18:36 2023 +0530

    ptp: Fixes a null pointer dereference in ptp_ioctl

I do not see how races are solved... Shouldn't
pccontext->private_clkdata be protected by RCU ?

