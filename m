Return-Path: <netdev+bounces-33646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A114679F050
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 19:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC5A282454
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 17:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF981F94C;
	Wed, 13 Sep 2023 17:20:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF7AAD52
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 17:20:52 +0000 (UTC)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ED2A3
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:20:51 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41513d2cca7so22681cf.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694625650; x=1695230450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti//9ZGJhBhtqdddF2tyMMGGzTfmtiN4qSODnmTcIJY=;
        b=AQ61RB+EVpi4vLfQBnaRPWOo6P0gySx6Nq0yqBUHhS2V10e8lyUYGGBFaRPm5pYMgj
         3o4AOxG+Z9k9Mjyq5qY8GN+p0W5ZaSuwvgqUieo/kw6cTiKj7TEGjkRPTs6/d9VY9mMp
         OhJwUah7QOO3pDuwvDpGokyzcGByjTvqNy5AKLrWg3RsAumKaMqFg5Z7WFk3CbGv+euf
         TejLILH0CLEf7XLqfjVFDAqq6i/5Rs8ZNvDxdH0enUtXLW5lP7hbRnJoORokgC6s4XrX
         xQb1m/nDHItYzhcTYifBUAd6fVUIwy3vqfa4Dnd8mXmdUxhZpVeyrj0JLBUTnPMJ713k
         06zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625650; x=1695230450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ti//9ZGJhBhtqdddF2tyMMGGzTfmtiN4qSODnmTcIJY=;
        b=DE5D43+rYCotAKQiZcJR7nANQYvfUE5xeOzXeI5tlo0hJ37pnyfgcPCpDW/32oTpNo
         AL0dWo24rhudsORg0WjGTmuB+Ido7bCIklma1SoBH57Wu24VXaI3E8OuTvz+cnNTaK+x
         PruABrbA1gNqhWrepBkiElJ70vZFeNUyRufdUKBCTIZDsA4GyDQrEJOJYWLudGRinQ8x
         D9zWbfG3SiprXTq8hKQrozUTr71iGL+VJ11nlXMAx1aOqPwbF521dDfqNI1rLFJszJrh
         hji1EmuwvfB5lbhQfvBs1tx1DdMRpDfJPErp4idL0UR+v1gHMss3kfCsrMOGvq3vaLx4
         ygpQ==
X-Gm-Message-State: AOJu0YxpFIqINjLSGFJ2ZJg45n1qW05ePeFP+HBgNmV2oNbfe8ljdbby
	LWQk76zxlZ1o4sOu19qQJ9KKt7Q7E0B3oyT/r088iw==
X-Google-Smtp-Source: AGHT+IGMpPsHaWpqgZzC8xDyQY6H/p0qXXK9IzOlIPZYpke1Ctb5gvJckVo6lye0RED3x1rT4eI0iWb5hyn6SsurqGM=
X-Received: by 2002:ac8:5c09:0:b0:410:8ba3:21c7 with SMTP id
 i9-20020ac85c09000000b004108ba321c7mr332206qti.18.1694625650519; Wed, 13 Sep
 2023 10:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912134425.4083337-1-prohr@google.com> <ZQFu/SXXAhN10jNY@nanopsycho>
 <CAKD1Yr1hzYpAU1jMN964c5U+e2-bGcPBqZsHA7_Lg-rH1iNsow@mail.gmail.com>
In-Reply-To: <CAKD1Yr1hzYpAU1jMN964c5U+e2-bGcPBqZsHA7_Lg-rH1iNsow@mail.gmail.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Wed, 13 Sep 2023 10:20:39 -0700
Message-ID: <CANP3RGc4q5zWLL_=f4-a1kvqxE2JbX+B=Q86SGQ22Xx9s0_XYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: add sysctl to disable rfc4862 5.5.3e
 lifetime handling
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Patrick Rohr <prohr@google.com>, 
	"David S. Miller" <davem@davemloft.net>, 
	Linux Network Development Mailing List <netdev@vger.kernel.org>, Jen Linkova <furry@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2023 at 1:50=E2=80=AFAM Lorenzo Colitti <lorenzo@google.com=
> wrote:
> On Wed, Sep 13, 2023 at 5:12=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wro=
te:
> > >+      - If enabled, RFC4862 section 5.5.3e is used to determine
> > >+        the valid lifetime of the address.
> > >+      - If disabled, the PIO valid lifetime will always be honored.
> >
> > Can't you reverse the logic and call it something like:
> > ra_honor_pio_lifetime
>
> Maybe accept_ra_pinfo_low_lifetime ? Consistent with the existing
> accept_ra_pinfo which controls whether PIOs are accepted.

accept_ra... is about whether to accept or drop/ignore an RA or
portion there-of.
We considered it and decided it was inappropriate here, as this new
sysctl doesn't change drop/ignore.

As such it should be named ra_...

ra_honor_pio_lifetime or ra_honor_pio_lft has the problem of seeming
to be a lifetime (ie. seconds) and not a boolean,
but does look much better...  (maybe using _lifetime instead of _lft
makes it sufficiently different from the existing _lft sysctls that it
being a boolean is ok?)

...or... perhaps we do actually make it an actual number of seconds,

ra_pio_min_valid_lft, and we default it to MIN_VALID_LIFETIME,
then I believe a value of 0 would get the desired behaviour...

