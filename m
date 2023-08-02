Return-Path: <netdev+bounces-23762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3BD376D6FE
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 20:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934A81C21051
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 18:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5AD510;
	Wed,  2 Aug 2023 18:42:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E929D2E8
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 18:42:43 +0000 (UTC)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691EFB0
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 11:42:42 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63d30b90197so874606d6.0
        for <netdev@vger.kernel.org>; Wed, 02 Aug 2023 11:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691001761; x=1691606561;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nzLeXC8Q9WpgFXb+0SMofDo/T36r+yohmDuYZSZVbjs=;
        b=qq+xuEImz2phHu+e8qC/QxIaBqg0hvzGcj6vOgwZXfw+wYxzIToRMotWYgYkyTE5cR
         c7uO3tBqE5KPE3KYAu+Q/jT1PCs44JIraLBWTS8NGyStmtZzjkz/+Tbk/Ab1op/6dPBj
         kcyNMJwIEKMwIAaRgbGJtt5kY/f8X2MBz/4HWB/9I2ik4284PyxcYX0U0w8f4k8I+w4F
         tmE0BPZJh1BIUi5V2nurpTzgyGAXtJrr+lJoJ2RQLUrIWde9G4sZBG4cl3ci8B8Lp23F
         8O78/S77ug4TCImCxVBqjtlI0wVRGZzQFBhbfF77Y7VUYU/k1rcd1BiXGlbHmurtTAcR
         3r2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691001761; x=1691606561;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nzLeXC8Q9WpgFXb+0SMofDo/T36r+yohmDuYZSZVbjs=;
        b=kBfi4m2Ka7VpYX6NTUP/+gp2n0WZ3IXOQm1p6nZV4RRpPMTudFZ7ygNJFYux6IvPGa
         Rydzh/6wpyI+rFTE6yTODKAFt6jxrrZpIUoUozaoDMlJXwS2yr5bt6peYh/1RzhGf3F3
         14mrOQVHngHqxfH2R1Jw1gT6rQmsi5NoPuXfw40xBv3/FVCkFSeJRWipWJPyegf4eSFI
         VxWR3G4FqZtB3W+JSTbaHoUhRBCTdidoAZ5LAOKVnct/rOwJ0T8RffntvePLZZ72LbTY
         2mtyEo1fZOEfzWwsX+76Qf5oo5uBj7w4bvF7hIpMzcVOd3+iLBiywIlcCDPejZVrMsty
         CbTA==
X-Gm-Message-State: ABy/qLbbjLbvYTtBwuwDU93g5H94DBfPz82Wt3i6iJaQQiuqmN3cI+w0
	HYpb+tvz+LNcWg6Jd2KMuaBEy//mdOs=
X-Google-Smtp-Source: APBJJlG5iWmGazawWozFzmVAvkG6j1aNu88NcFlbC5CpL3pZ2549xrahHy7pWESfuMumUo6tMFaHOg==
X-Received: by 2002:a0c:e001:0:b0:63c:f730:8d1e with SMTP id j1-20020a0ce001000000b0063cf7308d1emr15142997qvk.40.1691001761168;
        Wed, 02 Aug 2023 11:42:41 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id d27-20020a0caa1b000000b0063d03e59e07sm5754061qvb.130.2023.08.02.11.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 11:42:40 -0700 (PDT)
Date: Wed, 02 Aug 2023 14:42:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 Jakub Kicinski <kuba@kernel.org>, 
 Maxim Krasnyansky <maxk@qti.qualcomm.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowang@redhat.com>
Message-ID: <64caa3a09cbbb_2c6331294a6@willemb.c.googlers.com.notmuch>
In-Reply-To: <20230802182843.4193099-1-kuba@kernel.org>
References: <20230802182843.4193099-1-kuba@kernel.org>
Subject: RE: [PATCH net] MAINTAINERS: update TUN/TAP maintainers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski wrote:
> Willem and Jason have agreed to take over the maintainer
> duties for TUN/TAP, thank you!
> 
> There's an existing entry for TUN/TAP which only covers
> the user mode Linux implementation.
> Since we haven't heard from Maxim on the list for almost
> a decade, extend that entry and take it over, rather than
> adding a new one.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Willem de Bruijn <willemb@google.com>

Happy to do my part. Great to have Jason on board as well!

> ---
> CC: Maxim Krasnyansky <maxk@qti.qualcomm.com>
> CC: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> CC: Jason Wang <jasowang@redhat.com>
> ---
>  MAINTAINERS | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20f6174d9747..39b3c6e66c2e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21673,11 +21673,14 @@ S:	Orphan
>  F:	drivers/net/ethernet/dec/tulip/
>  
>  TUN/TAP driver
> -M:	Maxim Krasnyansky <maxk@qti.qualcomm.com>
> +M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> +M:	Jason Wang <jasowang@redhat.com>
>  S:	Maintained
>  W:	http://vtun.sourceforge.net/tun

Should we drop this URL too?

>  F:	Documentation/networking/tuntap.rst
>  F:	arch/um/os-Linux/drivers/
> +F:	drivers/net/tap.c
> +F:	drivers/net/tun.c
>  
>  TURBOCHANNEL SUBSYSTEM
>  M:	"Maciej W. Rozycki" <macro@orcam.me.uk>
> -- 
> 2.41.0
> 



