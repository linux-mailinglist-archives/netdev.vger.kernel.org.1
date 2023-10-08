Return-Path: <netdev+bounces-38861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6EC7BCC8D
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 08:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D11E1C20899
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 06:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13E538B;
	Sun,  8 Oct 2023 06:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="lm3THBdd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6F5384
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 06:19:59 +0000 (UTC)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF50CC6
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 23:19:58 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-59e88a28b98so30505617b3.1
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 23:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696745998; x=1697350798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NvlqHDu80lYPaqYg7RRMJBt2NvdYUJ9P9W8msMbILT4=;
        b=lm3THBddP1lEZ0ea9cOiLpL8HiMHSHz7Yo/uU5XDK0J+36m4eSW0QaKUFRAIXekhtB
         p6Xc2dxMmp35n+JX3E7umbZ18MmYApNz7rqSjaCqmk9rF20GxdRKC5w07xDz2Q7+YlDM
         NETEfEfAXa2JHD+yZmmrcRH/gskr6F6OSdCzmCoVBgaZAW0ndV2NgatuZr4Rwn2gwTon
         cyVt6WYgOJCWqqCfbx4MMYew7WOqtBpdXn3UlTsy7HscbpnwQRuNWCEkzDk/LjsWy7VD
         JVisG3qGdc9v0PmB4WRsRMi8YHH2UQ42khDGcZXIvhM2PpizVdQUyk7vCMaAcdzIfgX5
         hLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696745998; x=1697350798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NvlqHDu80lYPaqYg7RRMJBt2NvdYUJ9P9W8msMbILT4=;
        b=N3Oz07+V8Wajx9iOGhhVSxB5bjTTQvAcN4yTb+MCSMNRMv5f1SecV8JSZhfWB4PEyP
         /BWZx8DIw1xCFEPsw3qdituYCdDgwPZ2qJiC6Ko/0kQCBCZSelrAdIftzsYPt4yrBAEA
         QkPDcX759PgmyaXpcFb8GsSf65cNWNoiqbz5tPuNWO77CpKAzNmWz4PLtaxj+E+blrEH
         BhH2SvL26BXrQPPcO11JvEV0CXJHbSBsNsggbCpb8CgSdJtwIxqr/PfDvQ48j2GJp1/K
         2T39+9OQ/ppsq/eCtBsF3Xx46J4tQeTqVO+M+VW4NHuaemyx8Cc8OgdM52zmizu7/7hQ
         2xUA==
X-Gm-Message-State: AOJu0Yy8OPBKePPrDge6jtL77FbYAbA4CLcz1FbofVvSnJN7L5Gq/cwU
	82lLDOJ7oECaRSDzn8QxTVmwtYnXp9bmVvXUAk7BXLEhUR7lOzPLO1iA4A==
X-Google-Smtp-Source: AGHT+IFG51UcHG144D2idULHDOshuEadd39hB2S6kNE6K6rp/AqFkZRUtld1jc5U81tbV7JzAEMl4DHayOGVvgWR+vI=
X-Received: by 2002:a0d:d4d5:0:b0:59f:5293:9936 with SMTP id
 w204-20020a0dd4d5000000b0059f52939936mr5023323ywd.16.1696745998114; Sat, 07
 Oct 2023 23:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006094911.3305152-2-fujita.tomonori@gmail.com>
 <CALNs47sdj2onJS3wFUVoONYL_nEgT+PTLTVuMLcmE6W6JgZAXA@mail.gmail.com>
 <20231007.195857.292080693191739384.fujita.tomonori@gmail.com> <20231008.073343.1435734022238977973.fujita.tomonori@gmail.com>
In-Reply-To: <20231008.073343.1435734022238977973.fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 8 Oct 2023 02:19:46 -0400
Message-ID: <CALNs47v3cE-_LiJBTg0_Zkh_cinktHHP3xJ3tL3PAHn5+NBNCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 7, 2023 at 6:33=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
> To create an internal type based on `name`, we need to unstringify
> `name`? I can't find a easy way to do it.

I think you should just be able to do it with `paste!`

    macro_rules! module_phy_driver {
        (name: $name:expr) =3D> {
            paste::paste! {
                #[allow(non_camel_case_types)]
                struct [<$name _ty>];
            }
        }
    }

    // creates struct `demo_driver_ty`
    module_phy_driver! {
        name: "demo_driver"
    }

