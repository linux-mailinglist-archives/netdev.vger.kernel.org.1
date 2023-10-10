Return-Path: <netdev+bounces-39758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0667C4565
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 01:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65F4281C4E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169B632C91;
	Tue, 10 Oct 2023 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="33pFKAEW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A00354E1
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 23:23:00 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7EC93
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:22:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53d9b94731aso1931384a12.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 16:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696980177; x=1697584977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPvi0L7FMz0a4O2DqWnfcamp8uZvbVMLd2V0ja/dStw=;
        b=33pFKAEWL1e73plTg0/16WYm9+uqGaLYDqP1bOb43wfZiQfK2uaG956ehWtfjaJR3j
         sKwIPvPPuhk7yPJp48qhsG8uLtoDlGfo1AZ9IOrwFFny+hYwdpYpiapZlCUbXwzdviti
         HwFPkn6j375KlQO0jO5ra3vWXsTozqg7DS2UMkkatoEMf5BjDTBru5B7FUGyDrQ6S+Ai
         fBp82rb6kZBpVm1CKF6LR2YbZr1XKVUBWBGWC2+EkH8IfyygMoQH9v/WIAeT6Fk+CFS5
         ZLuwG993oaSJCA1C3uDRA3Dl8K8uGf9MuVZiKOSpL4V3ue4XbpS7byIHtj9c1xXs9YOt
         hydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696980177; x=1697584977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPvi0L7FMz0a4O2DqWnfcamp8uZvbVMLd2V0ja/dStw=;
        b=e1H1eudYUQjnkpAdPUxVxkaaAFbBNT54CrDNjKXapnbFp3fgzBKBBA1xSU8HXHOKr9
         J/DwqF5fCzqnkUifjXiMZ0eVORyHfGZKVgCIruTR3801xp7uo8Aswwzh2dKu6uVh5lw3
         C5InlPpiuWv1t3VGaMUYAt+4qGdWZZzZ9bpYvfF+zlJwtJB1AllZZT9YGSIHxyYDiSA7
         gXWO+3NDdPweQTsoJQYoGMvRXtQLS+7mfNwctU2SAz797gTR8gpUDvuwxevuMZ/Njh71
         BxVP2DgQup08SXKTlmFG+V+URqEfXKoKirzM50OR1EsN8tG/pwibqaRd5npw+f1r0VOP
         Xvgw==
X-Gm-Message-State: AOJu0YxbYnWL/Y9dzJ3c35NFCja99wW/x8aGe/R1xMGud7ThPLXctOKe
	SAegHWcirJE68bqBo2aMkg4gNZi7SxPJn314KrFlsg==
X-Google-Smtp-Source: AGHT+IEJChFsbAup1enHy98cd4OYKs1F1JHVG9lgsLEhDADJM6SkfGrgSjsiomi0yma0H29NDkjf/IVCDKiHB7N/gNw=
X-Received: by 2002:a05:6402:344a:b0:52e:3262:e6c9 with SMTP id
 l10-20020a056402344a00b0052e3262e6c9mr17278593edc.33.1696980176775; Tue, 10
 Oct 2023 16:22:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010-netdev-replace-strncpy-resend-as-series-v1-0-caf9f0f2f021@google.com>
 <d84f2d4d-40d7-af15-0049-f8e1efed1eba@intel.com>
In-Reply-To: <d84f2d4d-40d7-af15-0049-f8e1efed1eba@intel.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 10 Oct 2023 16:22:44 -0700
Message-ID: <CAFhGd8pR4EdjVzHLKwxtH=OHNO1rLsuWAs=ZHX7hWohhE8Kcjg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/7] net: intel: replace deprecated strncpy uses
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 4:19=E2=80=AFPM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> On 10/10/2023 3:26 PM, Justin Stitt wrote:
> > Hi,
> >
> > This series aims to eliminate uses of strncpy() as it is a deprecated
> > interface [1] with many viable replacements available.
> >
> > Predominantly, strscpy() is the go-to replacement as it guarantees
> > NUL-termination on the destination buffer (which strncpy does not). Wit=
h
> > that being said, I did not identify any buffer overread problems as the
> > size arguments were carefully measured to leave room for trailing
> > NUL-bytes. Nonetheless, we should favor more robust and less ambiguous
> > interfaces.
> >
> > Previously, each of these patches was sent individually at:
> > 1) https://lore.kernel.org/all/20231009-strncpy-drivers-net-ethernet-in=
tel-e100-c-v1-1-ca0ff96868a3@google.com/
> > 2) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-in=
tel-e1000-e1000_main-c-v1-1-b1d64581f983@google.com/
> > 3) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-in=
tel-fm10k-fm10k_ethtool-c-v1-1-dbdc4570c5a6@google.com/
> > 4) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-in=
tel-i40e-i40e_ddp-c-v1-1-f01a23394eab@google.com/
> > 5) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-in=
tel-igb-igb_main-c-v1-1-d796234a8abf@google.com/
> > 6) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-in=
tel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com/
> > 7) https://lore.kernel.org/all/20231010-strncpy-drivers-net-ethernet-in=
tel-igc-igc_main-c-v1-1-f1f507ecc476@google.com/
> >
> > Consider these dead as this series is their new home :)
> >
> > I found all these instances with: $ rg "strncpy\("
> >
> > This series may collide in a not-so-nice way with [3]. This series can
> > go in after that one with a rebase. I'll send a v2 if necessary.
> >
> > [3]: https://lore.kernel.org/netdev/20231003183603.3887546-1-jesse.bran=
deburg@intel.com/
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Thanks Justin for fixing all these!
>
> For the series:
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
>
> PS: have you considered adding a script to scripts/coccinelle/api which
> might catch and try to fix future (ab)users of strncpy?

There is a checkpatch routine for it. Also, the docs are littered with
aversions to strncpy. With that being said, I would not be opposed
to adding more checks, though.

Once I'm more caught up on all the outstanding strncpy uses,
I'll look into adding some coccinelle support.

>

Thanks
Justin

