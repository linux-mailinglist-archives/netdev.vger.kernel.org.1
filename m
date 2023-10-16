Return-Path: <netdev+bounces-41264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3907CA682
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 13:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E606B20CC2
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 11:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93BBD22F12;
	Mon, 16 Oct 2023 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2SD20US"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECA1F92C
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:18:06 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E3FB4
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:18:04 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4053f24c900so79105e9.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 04:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697455083; x=1698059883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zEzqOAnHowGsjMpEL5Pr+4XdRbzCGcjus9Yy0YrlFjw=;
        b=U2SD20USIjLq0qUi/lIDDX5yH4kYuGxYN2eHWs43ECjBYBsunNM+YAj0DW3xMwUszD
         N7aGBvf5DbxRcLHEniLgpiNHRF5X2e2x1ws4HQRL3gyt9ZKZx+XpkOYBmTA67X0Q9gA2
         jKNEcAkK3Mud+BRpyoWkoEidoRfxsrBo3b8/4RkcKVIM5GLTnwNgeOhQ6xwD4lMSogqX
         oXXHgmvjIHeuEdx3aND5JqDjzvrFkb5C+QGanyvI9yDvq4McksmNN8KUw85MV48/kNey
         MHD3HdUjUouly+2UbomKidktIQrWUjjWlGPJ7lyr/hzngDHbkBSg7CK3hCsFxs4s/lG3
         M2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697455083; x=1698059883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zEzqOAnHowGsjMpEL5Pr+4XdRbzCGcjus9Yy0YrlFjw=;
        b=dDOsyIeRz8sCRNx1+8cqRvSYFk7raNfXTK/cNbPvS14URDjvXsOHlhLr7IJmzBmlxw
         RNk12oPljglIN9G97xpLRaFof3ZBxI7PsNIQq609YvfbbQSNURLJbtt3w2/4R/NFQH5b
         /fjNpRDR1BNXr/6Mrh/vfH+iEn4TtVgXpgNMUQGGnm2I2BV70k74WY2Y1l1SJiO60guA
         ZX3V2zf4/8UcMnPervHRkQupTxKvffbIML7wkcPix0TP5th93/5kmqtE3CnXiuVHwOOa
         bg2sVJSMwnkbqh3i/QKOO+dFc3cw+A5zc1vHwNw2vGgim/XFI3Kh4JWVqDqZncHPMXyy
         be6A==
X-Gm-Message-State: AOJu0YyyzwLDVUmCEEezWoTICj32CNMOJfOvI47GDqz+eDGtNJodMhUi
	6bO03W5hQz2I5agrYhlnvyuBQFyPqTOvg1JhEGWqzg==
X-Google-Smtp-Source: AGHT+IEoeEfLloxSqvDgxPW+ED1hVnXSOpw3g4DMwzycznkMWNPcUE3fSiJBxe9OnEwzU49S8D4XLdySXe+XV4AScbA=
X-Received: by 2002:a05:600c:1551:b0:400:c6de:6a20 with SMTP id
 f17-20020a05600c155100b00400c6de6a20mr141048wmg.3.1697455082526; Mon, 16 Oct
 2023 04:18:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAvCjhhxBHL63O4s4ufhU7-rptJgX1LM7zEDGeQ9zGP+9Am2kA@mail.gmail.com>
 <20231011205428.81550-1-kuniyu@amazon.com> <CAAvCjhhEPd4MHNT9x5h_gpyphp3jB9MAnzbCDogiuRVGcqtdkQ@mail.gmail.com>
 <CAAvCjhjOmDDbDCF9xAVifHEsQqJOFJ1whtzzKu-0+Um=Odm=NQ@mail.gmail.com>
 <CAAvCjhj+c14o1EN77gtU_EsPM3_TzY5riQ3zH=AmaU2pUjMoXQ@mail.gmail.com> <CANn89iJALZHwJCgpL3vz6_S-drXTQCtny2fxgMX2zY_DXuyCWQ@mail.gmail.com>
In-Reply-To: <CANn89iJALZHwJCgpL3vz6_S-drXTQCtny2fxgMX2zY_DXuyCWQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 16 Oct 2023 13:17:51 +0200
Message-ID: <CANn89iLSdYZq27nr5hKj88un7R_cyc2Nz6CYyaZRQJJv4qWHew@mail.gmail.com>
Subject: Re: kernel BUG at net/ipv4/tcp_output.c:2642 with kernel 5.19.0-rc2
 and newer
To: Dmitry Kravkov <dmitryk@qwilt.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org, slavas@qwilt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 1:13=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Oct 16, 2023 at 1:10=E2=80=AFPM Dmitry Kravkov <dmitryk@qwilt.com=
> wrote:
>
> > Hi Eric, do you think we can try something to avoid the crash?
> > Decreasing tcp_wmem[0] did not help
> > # cat /proc/sys/net/ipv4/tcp_wmem
> > 4096 1048576 629145
> >
> >
>
> Honestly I have no idea, it seems strange that you are the only one to
> hit such a bug.

Please tell us which Congestion Control module and qdisc you use.

If you use BBR and/or SO_MAX_PACING_RATE, I would recommend switching to sc=
h_fq

