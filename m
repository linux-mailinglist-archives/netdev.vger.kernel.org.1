Return-Path: <netdev+bounces-45538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2597DE0AD
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 13:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506C0B21052
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEED711CB2;
	Wed,  1 Nov 2023 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA210965
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 12:19:33 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCC8102
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 05:19:29 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a7e5dc8573so67382547b3.0
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 05:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698841168; x=1699445968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1XPIPR62EPrPe480flDjU5NXSmE2hZoFCqRd80jZgg=;
        b=LYu3+DRSLJaYHEss89b5dAYCjfcFqezSdRw1jEUWbHhP8wsRNWjA+pqyuqyDv0YrMF
         gnzzB25oabPvbWEvYRB2l3LrPLDfCsf9/t9yDDVhM7hv4rFhQYajz3/w3vprF9wG42mf
         7Xlfn6bqZIaS73Vb79D5lwC3ctR+XOU5W0sLdozjiLTpRKo1/jtAswi99B9vaVaUYjZJ
         yCfs6tSqpoqNET4RPW23Y9cB50aQ7Ch9e98mxhkPiRsbnyZv+yMS4PKodhjBFXQghzR4
         d+v+0nxVuWi9qkN6lFsYyOUnTsKU9IOJbzVNkYuJOcflbuLACqKHcZJYhXy2vpgtMCah
         afWg==
X-Gm-Message-State: AOJu0YypP2FGCDDYl3EUn3VUkf85iF9xJqPVf+3/URWAsTw0ko24dqHM
	SkzsoFzF8LJ8lCCO3HhYjAP8RXf8n6OJEQ==
X-Google-Smtp-Source: AGHT+IGDsqorqPnEfyOuMC1570FJpbp3y7P6GePQnjUIssRsEB4UxIzSbJ3ThQo4OE2C/YQuT7FzFQ==
X-Received: by 2002:a0d:e290:0:b0:59b:54b5:7d66 with SMTP id l138-20020a0de290000000b0059b54b57d66mr16699967ywe.34.1698841168159;
        Wed, 01 Nov 2023 05:19:28 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id v62-20020a0dd341000000b005950e1bbf11sm2018683ywd.60.2023.11.01.05.19.27
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 05:19:27 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-5a82f176860so67221537b3.1
        for <netdev@vger.kernel.org>; Wed, 01 Nov 2023 05:19:27 -0700 (PDT)
X-Received: by 2002:a05:690c:f8f:b0:5a8:299b:433c with SMTP id
 df15-20020a05690c0f8f00b005a8299b433cmr17919596ywb.18.1698841167527; Wed, 01
 Nov 2023 05:19:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdWL2TnYmkt2W6=ohBuKmyof8kR3p7ZPzmXmWSGnKj9c3g@mail.gmail.com>
 <594446aaf91b282ff3cbd95953576ffd29f38dab.camel@physik.fu-berlin.de>
In-Reply-To: <594446aaf91b282ff3cbd95953576ffd29f38dab.camel@physik.fu-berlin.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Nov 2023 13:19:14 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWv=A6MiVwUuOp8zOCcf21HxKb8cdrndzdbAZik3VRXiw@mail.gmail.com>
Message-ID: <CAMuHMdWv=A6MiVwUuOp8zOCcf21HxKb8cdrndzdbAZik3VRXiw@mail.gmail.com>
Subject: Re: Does anyone use Appletalk?
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Adrian,

On Wed, Nov 1, 2023 at 11:55=E2=80=AFAM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Wed, 2023-11-01 at 11:23 +0100, Geert Uytterhoeven wrote:
> > Appletalk, cops, and ipdpp are being removed.
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3D1dab47139e6118a420acec8426a860ea4b40c379
> >
> > Please shout if you have any objections.
>
> Isn't that a bit late?

It can always be reverted...

> I'm a bit annoyed that Arnd doesn't announce such removal requests
> on the proper lists? This is something that should be asked among
> the retro community, not on some random Linux mailing list.
>
> And, FWIW, I am against removing AppleTalk because it actually allows
> you to build your own TimeMachine server using Linux [1]. It's really
> useful for backing up macOS machines over the network.

Thanks, good to know!

> > [1] https://dgross.ca/blog/linux-time-machine-server/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

