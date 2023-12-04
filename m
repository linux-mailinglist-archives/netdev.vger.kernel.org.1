Return-Path: <netdev+bounces-53530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857B3803945
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 16:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40ABA280DFE
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 15:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FF02D03C;
	Mon,  4 Dec 2023 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w6Z+vEtt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604A0E6
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 07:55:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50bf09be81bso3826e87.1
        for <netdev@vger.kernel.org>; Mon, 04 Dec 2023 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701705336; x=1702310136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBnceUeXqoc4KAsYh0oGp5cKpBSchhPkcUak6VayEv8=;
        b=w6Z+vEtt+bpjlg5+4oRkv936gKZzdDucZtq8IRHYvYi2RihpT6Fq5rZM+ixbUjI9r8
         5vBBQujVG3hZSgz2waH/UgzLmSqQKwIDxDBcdVbEuUGVY4B/LrQAACh7YxRZ3BnAPW+P
         BH9TPsuV1BALkk4lORFSf0G9p9W4D3BEF8UIGz/6NUjSwvJd7CwGNjiCzZhLsUab6qs0
         yWwpjslsA4+ITYYSM7YRuchL7r6DypO2YYTjkEt3uyUDwcVWF73Pm+WXL76aoe6Jbb4O
         SydlpwEL4hfsqhAcqV2tCogFextMtjn4qmbbp3aOmYCFIlnT39vNQQeo+XfXJSJrZHwH
         8CXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701705336; x=1702310136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBnceUeXqoc4KAsYh0oGp5cKpBSchhPkcUak6VayEv8=;
        b=DOqTBLhxv1Jqqi0VyyZL15qCrlUFPIoAzwyjQ9vbzCzc2eO6dYbsKysdqYiGHUfoW3
         32jQRLntgX7n8lj4SeVDz0tSDlebRh7Yfvf1CzHyj2VruZgugHd1yHWPCtTaPriWdJqh
         3C1uQAxDgJxwYyrW43WkMUjPdFpJTNjJw+MiJmArRz/PXwPGqQrq4TfaNy1Od78lmG0Y
         9RYfYWJldY0S5j9pa6La9yNoPAylMjyjSTwrQTgdFfG7N9kVNSWPRaRNvCYbB9oc5SPY
         7x0pwDDp3+K71jbzHpC4MKfA2dCW92+PGA+YZVHJpqWsZ2Gzq2ujNweCqXbPMmRZkREk
         J0JA==
X-Gm-Message-State: AOJu0YwdX7nWPvfU1Jpd3QKsNhal1qKfTFpLd6TuWwJ65ohANgfWG6YJ
	PFos36NfPnzsJLX8pBtyLoNamWBM5AtZLQD7HhHKCg==
X-Google-Smtp-Source: AGHT+IFuKjlGfvmJyy7+xVwL/kDRF40qFgOI72X8CBriksgTyN3qZV5QZt4X+6SaDAxvWQonu5iiV47ARw0geRpl1ok=
X-Received: by 2002:a05:6512:214f:b0:50b:c5b3:6452 with SMTP id
 s15-20020a056512214f00b0050bc5b36452mr198415lfr.6.1701705336239; Mon, 04 Dec
 2023 07:55:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204091911.1326130-1-edumazet@google.com> <20231204091911.1326130-4-edumazet@google.com>
 <695c2152-f7d0-43f0-919b-4df23840907d@kernel.org>
In-Reply-To: <695c2152-f7d0-43f0-919b-4df23840907d@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Dec 2023 16:55:22 +0100
Message-ID: <CANn89iJBZkH9CZ=+aRadPw_2TkUrp-HdiD9aEtoRyoNCjNpJVw@mail.gmail.com>
Subject: Re: [PATCH iproute2 3/5] tc: fq: add TCA_FQ_PRIOMAP handling
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 4:51=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 12/4/23 2:19 AM, Eric Dumazet wrote:
> > @@ -193,6 +196,48 @@ static int fq_parse_opt(struct qdisc_util *qu, int=
 argc, char **argv,
> >                       pacing =3D 1;
> >               } else if (strcmp(*argv, "nopacing") =3D=3D 0) {
> >                       pacing =3D 0;
> > +             } else if (strcmp(*argv, "bands") =3D=3D 0) {
> > +                     int idx;
> > +
> > +                     if (set_priomap) {
> > +                             fprintf(stderr, "Duplicate \"bands\"\n");
> > +                             return -1;
> > +                     }
> > +                     memset(&prio2band, 0, sizeof(prio2band));
> > +                     NEXT_ARG();
> > +                     if (get_integer(&prio2band.bands, *argv, 10)) {
> > +                             fprintf(stderr, "Illegal \"bands\"\n");
> > +                             return -1;
> > +                     }
> > +                     if (prio2band.bands !=3D 3) {
> > +                             fprintf(stderr, "\"bands\" must be 3\n");
> > +                             return -1;
> > +                     }
>
> do you expect number of bands to change in the future? If not, why make
> it an option or just a flag?

We do not know yet if this would in the future (we have not changed it
in the last ~9 years)

I used the same syntax as prio which would allow a future change if needed.

