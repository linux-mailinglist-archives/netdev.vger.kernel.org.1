Return-Path: <netdev+bounces-41503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 962227CB21F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 20:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BA3BB20E1F
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 18:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF28233981;
	Mon, 16 Oct 2023 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhLgjgLZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F5B328A7
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 18:14:45 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D8EE8
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:14:43 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so8216228a12.3
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 11:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697480081; x=1698084881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRL/6VX7HAEyDPGl2HTyivOlN20wjAMOil4U+8Zf2+k=;
        b=AhLgjgLZl67P4j/YjKLQIhP8byxtkC3GAroqeIuYOLU+9dshhBBbkZl8/eo9bwt4/D
         7LJatgprrWqA5mH8Vwwnv1AbWv/hCau2SiSIuhlOQVhvzGEBbJLH4l8UHA/xd0SvkSR1
         OAEx6jFJMi5ZrPkjksqbk8xykprcoqxDSCGqBIsmxowFQsiWlzCkCfjeeAb04C6+9Xp6
         84fGRXnGmdQCFLNU3Myp6QmQpg47lWwzvQEAp31tlL+Qbh90Ia95HZ9dAbOT6yMTSqYy
         WhVn5GQV3A8y9Hi451da10evusKZ2BY3HHSP3Dn4mgdEJ28kJCllEIHN6xcAuRxu3D+A
         +Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697480081; x=1698084881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qRL/6VX7HAEyDPGl2HTyivOlN20wjAMOil4U+8Zf2+k=;
        b=J5J2kXSx9dmhgKx63Ia3a3bizq0qefmq4mJXHyZvfGtkno6+wfsUQVDb+x9wsOGZ2K
         udEcUXgT1h5VKh9F58dxuNDNLohEFJFuqEQbphVqmG43ZjNU23T6DBeeNLKpzUzirURa
         6OJhyckM4C5m5U++LfJg5ZArOb7GdNsZdAaVzUhF8H5WGHNtqtSA8BB7u1GyouL26pcR
         ahsopx3NlK2VBLq7pY5KBu6GLMTFgnc7Qj7oCR8vkXBXyj/d6l/rNfsuL2l1P0qgBpCi
         f84TUCa++xMwBFs5Fp+IP/ktcp81UQn0BT7MYWMrCDzXd4LxnQtsL7fskUqMG/vspFIt
         UOUA==
X-Gm-Message-State: AOJu0Yxf7OpDT2By6Y7EUUs5t6HhRF604zjXafvf9TLQ3aG/q/UjJuOB
	aaQf62rH5YC1Qffsj0QDkXQZ2UuFk64JpGd7ToBDVg==
X-Google-Smtp-Source: AGHT+IHWE+5Rhq2pCOMoR8bDSaQb/FjDy2AMJAB/4FZZkaJ3R2ZA5dlO1ZAXGzdrzGkzocSaigLv2m8YWy8QwPOXlIA=
X-Received: by 2002:aa7:d1c7:0:b0:53e:1815:ed0f with SMTP id
 g7-20020aa7d1c7000000b0053e1815ed0fmr8825edp.31.1697480081468; Mon, 16 Oct
 2023 11:14:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-ethernet-qlogic-qlcnic-qlcnic_83xx_init-c-v1-1-f0008d5e43be@google.com>
 <202310141944.08A1FF6D9@keescook>
In-Reply-To: <202310141944.08A1FF6D9@keescook>
From: Justin Stitt <justinstitt@google.com>
Date: Mon, 16 Oct 2023 11:14:29 -0700
Message-ID: <CAFhGd8qqVAfSL6__Z0tC4r29FE31a4uHzhUAakKs8DURFnM_8A@mail.gmail.com>
Subject: Re: [PATCH] qlcnic: replace deprecated strncpy with strscpy
To: Kees Cook <keescook@chromium.org>
Cc: Shahed Shaikh <shshaikh@marvell.com>, Manish Chopra <manishc@marvell.com>, 
	GR-Linux-NIC-Dev@marvell.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 7:47=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Oct 12, 2023 at 07:44:29PM +0000, Justin Stitt wrote:
> > strncpy() is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > We expect fw_info->fw_file_name to be NUL-terminated based on its use
> > within _request_firmware_prepare() wherein `name` refers to it:
> > |       if (firmware_request_builtin_buf(firmware, name, dbuf, size)) {
> > |               dev_dbg(device, "using built-in %s\n", name);
> > |               return 0; /* assigned */
> > |       }
> > ... and with firmware_request_builtin() also via `name`:
> > |       if (strcmp(name, b_fw->name) =3D=3D 0) {
> >
> > There is no evidence that NUL-padding is required.
> >
> > Considering the above, a suitable replacement is `strscpy` [2] due to
> > the fact that it guarantees NUL-termination on the destination buffer
> > without unnecessarily NUL-padding.
>
> When doing the hard-coded value to sizeof(), can you include in the
> commit log the rationale for it? For example:
>
>   Additionally replace size macro (QLC_FW_FILE_NAME_LEN) with
>   sizeof(fw_info->fw_file_name) to more directly tie the maximum buffer
>   size to the destination buffer:
>
>   struct qlc_83xx_fw_info {
>           ...
>           char    fw_file_name[QLC_FW_FILE_NAME_LEN];
>   };
>

Sure, I'll be doing this from now on to make the change more clear!

>
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> >
> > Found with: $ rg "strncpy\("
> > ---
> >  drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 12 ++++++-----=
-
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/dr=
ivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> > index c95d56e56c59..b733374b4dc5 100644
> > --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> > +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> > @@ -2092,8 +2092,8 @@ static int qlcnic_83xx_run_post(struct qlcnic_ada=
pter *adapter)
> >               return -EINVAL;
> >       }
> >
> > -     strncpy(fw_info->fw_file_name, QLC_83XX_POST_FW_FILE_NAME,
> > -             QLC_FW_FILE_NAME_LEN);
> > +     strscpy(fw_info->fw_file_name, QLC_83XX_POST_FW_FILE_NAME,
> > +             sizeof(fw_info->fw_file_name));
> >
> >       ret =3D request_firmware(&fw_info->fw, fw_info->fw_file_name, dev=
);
> >       if (ret) {
> > @@ -2396,12 +2396,12 @@ static int qlcnic_83xx_get_fw_info(struct qlcni=
c_adapter *adapter)
> >               switch (pdev->device) {
> >               case PCI_DEVICE_ID_QLOGIC_QLE834X:
> >               case PCI_DEVICE_ID_QLOGIC_QLE8830:
> > -                     strncpy(fw_info->fw_file_name, QLC_83XX_FW_FILE_N=
AME,
> > -                             QLC_FW_FILE_NAME_LEN);
> > +                     strscpy(fw_info->fw_file_name, QLC_83XX_FW_FILE_N=
AME,
> > +                             sizeof(fw_info->fw_file_name));
> >                       break;
> >               case PCI_DEVICE_ID_QLOGIC_QLE844X:
> > -                     strncpy(fw_info->fw_file_name, QLC_84XX_FW_FILE_N=
AME,
> > -                             QLC_FW_FILE_NAME_LEN);
> > +                     strscpy(fw_info->fw_file_name, QLC_84XX_FW_FILE_N=
AME,
> > +                             sizeof(fw_info->fw_file_name));
> >                       break;
> >               default:
> >                       dev_err(&pdev->dev, "%s: Invalid device id\n",
>
> But yes, this all looks right to me.
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

Thanks
Justin

