Return-Path: <netdev+bounces-37546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 047E57B5E2D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 02:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 55BA9B20957
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 00:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE8719E;
	Tue,  3 Oct 2023 00:25:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E02E182
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 00:25:11 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF3CC9
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 17:25:10 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-65af75a0209so2122916d6.3
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696292709; x=1696897509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rh/oxoD92H1kiVOKUBO0S5GEjMsZkflJV2yuTcOo5N8=;
        b=Z21ctcqcbn7indUeHN4PBnci7y/5Fk/pua7VJBc1LmcgPIfdwncQyKN7gKsgOwrQsh
         NEfsHdQcc9mSemNdhXySQUyZQF9j2H17jxJ/TFenJK37PykbvzGKU/JgNq1vJKvrx1ib
         1lJoDtaBHYB529rZN9836rVpv+r7/b/yBJ3aQG13rd9Kkaeg3xC3o/A/dbHWC5Yz74fP
         xIpThMXuExHv2GKUC9WvpIx67emjL9+VKNARktcsmj4h8gSetLNvX5CvrM1db283UdGJ
         cIK3aaGLzS3mDXQ1mraNKlmesgLtvsNb6Q+FMqYHCdGnUWVVdmaDTmZSenfHrqib7RUu
         2RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292709; x=1696897509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rh/oxoD92H1kiVOKUBO0S5GEjMsZkflJV2yuTcOo5N8=;
        b=MPOw/fmfXfDRlDlgfKrEEUR+8BQ0h440W6aFnwR/lOSlYWJirn/P24o0w59J1Y+mx1
         8m8tt95M2BKUotJesVxSru5J/kkemIjuiuZMv6WEkc66flkfhu/6JvRs/A79oH9GorIM
         SBjHP/ZP3LlsZfAPgB5u6VSp9sqwgige8bxMdgT1PlT/s6IhcgmakjIoE5F+L3hr7u+E
         X3kCkV5fwjLAnyN+T/Q+pXF0pb1Xd8OS5YA7/tRakInSqa2F0cTaVadLythizM4XrGAC
         sr2sXgjCXg+l/rvM16IJMft13/kHVYiuumIRAZneZlG8N3E+RpO52+o+hxGjLZ7V3Eqh
         FQnw==
X-Gm-Message-State: AOJu0YzAJH0V0OZm78LZoXNhVHRKyksOheLgvgyW3okqWyw1VUL0UHVv
	aJOJIcjUl7mFdGv3hd+sDAsTUIFCIDaHGK/0xdhr6Q==
X-Google-Smtp-Source: AGHT+IHb1/dimsEF/amBatrEHtKMQJThYkcDNmFcwv+eDoLhBq5FmQ86t7uGcpK84si2gXDwiQxCjrgiZwt9P4z1hQM=
X-Received: by 2002:a0c:e1d2:0:b0:65b:1594:264e with SMTP id
 v18-20020a0ce1d2000000b0065b1594264emr10894257qvl.51.1696292709241; Mon, 02
 Oct 2023 17:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230929023740.1611161-1-maheshb@google.com> <ZRiQqLYpzJGbiqYX@hoboy.vegasvil.org>
In-Reply-To: <ZRiQqLYpzJGbiqYX@hoboy.vegasvil.org>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Mon, 2 Oct 2023 17:24:43 -0700
Message-ID: <CAF2d9jj4m4i278PN3F91VVudEG4nLFU8PJqk9Dnkqf=QOXTX0A@mail.gmail.com>
Subject: Re: [PATCH 2/4] ptp: add ptp_gettimex64any() support
To: Richard Cochran <richardcochran@gmail.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 30, 2023 at 2:18=E2=80=AFPM Richard Cochran
<richardcochran@gmail.com> wrote:
>
> On Thu, Sep 28, 2023 at 07:37:40PM -0700, Mahesh Bandewar wrote:
>
> > diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_cl=
ock.h
> > index 05cc35fc94ac..1f1e98966cff 100644
> > --- a/include/uapi/linux/ptp_clock.h
> > +++ b/include/uapi/linux/ptp_clock.h
> > @@ -69,6 +69,14 @@
> >   */
> >  #define PTP_PEROUT_V1_VALID_FLAGS    (0)
> >
> > +enum ptp_ts_types {
> > +     PTP_TS_CYCLES =3D 0,
> > +     PTP_TS_REAL,
> > +     PTP_TS_MONO,
> > +     PTP_TS_RAW,
> > +     PTP_TS_MAX,
> > +};
>
> There is no need for a new set of enumerated values.  Why not use the
> existing clockid_t ?
>
I'm not sure which one you are referring to. These defs need to be
UAPI and the one defined in time.h are not all relevant in this case
(we just need only a few of those) hence the definition. However, if I
missed something, please point me to it.

> Thanks,
> Richard

