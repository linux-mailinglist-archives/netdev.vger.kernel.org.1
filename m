Return-Path: <netdev+bounces-40163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577317C6056
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CC01C209D6
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF7F249FE;
	Wed, 11 Oct 2023 22:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vk/CYjVR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2B249F5
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 22:25:44 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923F7A9
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:25:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53da72739c3so602177a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697063141; x=1697667941; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zNZbeMMG66zQaffulwZBSRVTQq7xegGVzsE2aBNQYM=;
        b=Vk/CYjVRmA34OY+cWbPCRDyipcQMzmvE274FhS1JKNS7qXEDNQCfkR6gNwl/dE5tDp
         8MEkMZUYsKWt5LARKCwqd7jGWhaSVohomXmAWgjXc2TjBsvZHLy45m3IW1jAbPQNmXe9
         KrxqDKnv+5hedt45/0i1elPvPUD82nDWJwOn9mheHyXBowaOfT0McQqHUcBmRXoBqlD1
         Ih0evblLZSAJNkvwxxRqkm7CE89EeVc6euI21eVVQ/yuFO9+/NltplYmM1wsejtlMA2a
         gm1kuU0JDdUVxSSxPsU9L+M65R93YQTlqSeGeKf8dO5ByvmTyW4g2VcuTbx3j72Hs+5X
         QI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697063141; x=1697667941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zNZbeMMG66zQaffulwZBSRVTQq7xegGVzsE2aBNQYM=;
        b=Pn6uYdcMQolK8tYkKvVRZ0w4OfIYlBwLeSwi6D2DfhnYSPHl1V8VTTSq25WR1EpHax
         lZvxmGlHS1uh6OuzF/rVB231VotoJSQqMRPgkQnCo8HP8jzZiLoOsaO6O+RVrgmfhFBS
         8WEe7SenvEdswsDSczU6xKymFYBb9xVzt6SadCDwmGKcEUpVggyIuRvRDqeskBcUl/O4
         IuJ/s/0EZS0F6ZVphozQP7hrAccqCGqu9hpDW7bJm0FEq+fCc36ecW7cRzCx6+OyRWt8
         2/EyDrRE7WxqFBg/vqTYq6XqlPXsq3NavtME+p+DuKKzOQeCxe10hILmaogeulTCuFUc
         6kBg==
X-Gm-Message-State: AOJu0YwsFv536sfG5sy3Bx+Cr/yrA1Zix+W6JIwo91Hwf/pq08WowQew
	pz7L8JLA36E8A6cqufFa94L3FUG/cRUOMqTPt9kJoCaKMX1Uc02Abxg=
X-Google-Smtp-Source: AGHT+IH82POX7rEVI8+B5B5Y6q0ivHvbcCUnUMV5joor+RIQWbQw8OHBFlxjr3E9HWXtTSFfxwUwfy6oVuwv/HSjUd4=
X-Received: by 2002:aa7:d297:0:b0:533:1acb:7134 with SMTP id
 w23-20020aa7d297000000b005331acb7134mr21589053edq.23.1697063141000; Wed, 11
 Oct 2023 15:25:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
 <cadf72fc-2c0b-428a-b445-0f6a34c18d9b@amd.com>
In-Reply-To: <cadf72fc-2c0b-428a-b445-0f6a34c18d9b@amd.com>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 11 Oct 2023 15:25:29 -0700
Message-ID: <CAFhGd8q-q+DfQz_a_NKLmP_CG_fgYz29jZdoqT3qDMBm46VWHw@mail.gmail.com>
Subject: Re: [PATCH] ionic: replace deprecated strncpy with strscpy
To: "Nelson, Shannon" <shannon.nelson@amd.com>
Cc: Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Oct 11, 2023 at 3:17=E2=80=AFPM Nelson, Shannon <shannon.nelson@amd=
.com> wrote:
>
> On 10/11/2023 2:53 PM, 'Justin Stitt' via Pensando Drivers wrote:
> >
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > NUL-padding is not needed due to `ident` being memset'd to 0 just befor=
e
> > the copy.
> >
> > Considering the above, a suitable replacement is `strscpy` [2] due to
> > the fact that it guarantees NUL-termination on the destination buffer
> > without unnecessarily NUL-padding.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>
> Thanks, I suspected this was coming soon :-)
>
> Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

Thanks Shannon!

>
>
> > ---
> > Note: build-tested only.
> >
> > Found with: $ rg "strncpy\("
> > ---
> >   drivers/net/ethernet/pensando/ionic/ionic_main.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers=
/net/ethernet/pensando/ionic/ionic_main.c
> > index 1dc79cecc5cc..835577392178 100644
> > --- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
> > +++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
> > @@ -554,8 +554,8 @@ int ionic_identify(struct ionic *ionic)
> >          memset(ident, 0, sizeof(*ident));
> >
> >          ident->drv.os_type =3D cpu_to_le32(IONIC_OS_TYPE_LINUX);
> > -       strncpy(ident->drv.driver_ver_str, UTS_RELEASE,
> > -               sizeof(ident->drv.driver_ver_str) - 1);
> > +       strscpy(ident->drv.driver_ver_str, UTS_RELEASE,
> > +               sizeof(ident->drv.driver_ver_str));
> >
> >          mutex_lock(&ionic->dev_cmd_lock);
> >
> >
> > ---
> > base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> > change-id: 20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_m=
ain-c-709f8f1ea312
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >

