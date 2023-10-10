Return-Path: <netdev+bounces-39715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847747C42D1
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 23:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4CAF1C20D35
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 21:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18933C6A0;
	Tue, 10 Oct 2023 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUyb9drG"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A508C225D5
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 21:41:26 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CB194
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:41:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d20548adso5626876f8f.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696974083; x=1697578883; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMDM/r5CYmcxbaZwoDfjx69JmAy+Zf5G5Pi9db/hUXk=;
        b=YUyb9drGUbohAEs31d8RuK3255o7ykpc3qKuv3i52j+WsU89zRSz2bKeKQ/essyhhK
         XEvdG7NTOUmo5spmRybtdQ73Xqtz6b7GjfLyOxMgS+4fS3HT8qzMumAvbZwbOCYURuiv
         GaThz+x5ZaoeRTpqvu6YRxPWJvrDKtfQ2rpbTDqiWE2JXzhYh6Ma3gSUzfn/9nNz5uVJ
         d7YGyQGCYyAATi0XXEUex9rAOyfePWrrp29Rn3xTlrdD/XQ5gFxSxikhskhDG27JyR7v
         dWKfcwaPqEqRyPWOyY81Su0s9Fv47T7Z7hdR85AMH3l/hfmQishQ3Xrmei5tXqxt1YqD
         2gJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696974083; x=1697578883;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMDM/r5CYmcxbaZwoDfjx69JmAy+Zf5G5Pi9db/hUXk=;
        b=E8MlpOfuSVd39mjSTAEkXdPCRxwdIIptdS0ap3j6UJSS4SnnAX4XuZm3VERAJQuLje
         vtjiKdx3PJPgUsfn3HYQsQ55xIXBrJHRZjDAa/Zta/4jhcKCepdPu3giHmiKgRpZy6Mk
         q9lIXTExXL5r3ROjs7XQ2Rto39kzJNiva+SJcahWm8xxWn//PG5Ktm8PVwsZucxWM7Qa
         O+EFIxWNKjbwjACPOXERo9ICSxe9qURxZVafV0ICFWiO90QHQjTMtpuupysXiA0MB8W7
         v9Hkg+yp9ehlo0SZaLGWrnFSzAgnImxRyfsl7tHpovUU7Fap4fQeHxgIDWCWLpqraHtL
         QbYg==
X-Gm-Message-State: AOJu0YwnlqRW61dhhsTAfZ0of1DY3YEWGVj0dn6arhvIn9l7lxGCi/NO
	E4hlqKCArrw3ekRSN8JWU+jzQRavVffwGx8Ku9zSow==
X-Google-Smtp-Source: AGHT+IENzJWLhr1WARu69zZqe9X4Db7XpHhpgy9yuJ3Rb/tvLGQ1CJnMjWOpAsfeaHhE6eZOtekV0/eXaI8rq/Zs46I=
X-Received: by 2002:a5d:4f10:0:b0:316:ee7f:f9bb with SMTP id
 c16-20020a5d4f10000000b00316ee7ff9bbmr17366404wru.65.1696974082824; Tue, 10
 Oct 2023 14:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231010-strncpy-drivers-net-ethernet-intel-igbvf-netdev-c-v1-1-69ccfb2c2aa5@google.com>
 <5dc78e2f-62c1-083a-387f-9afabac02007@intel.com>
In-Reply-To: <5dc78e2f-62c1-083a-387f-9afabac02007@intel.com>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 10 Oct 2023 14:41:10 -0700
Message-ID: <CAFhGd8ppobxMnvrMT4HrRkf0LvHE1P-utErp8Tk22Fb9OO=8Rw@mail.gmail.com>
Subject: Re: [PATCH] igbvf: replace deprecated strncpy with strscpy
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 2:20=E2=80=AFPM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> On 10/10/2023 2:12 PM, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > We expect netdev->name to be NUL-terminated based on its usage with
> > `strlen` and format strings:
> > |       if (strlen(netdev->name) < (IFNAMSIZ - 5)) {
> > |               sprintf(adapter->tx_ring->name, "%s-tx-0", netdev->name=
);
> >
> > Moreover, we do not need NUL-padding as netdev is already
> > zero-allocated:
> > |       netdev =3D alloc_etherdev(sizeof(struct igbvf_adapter));
> > ...
> > alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
> > alloc_netdev_mqs() ...
> > |       p =3D kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAY=
FAIL);
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
> > ---
>
> Thanks Justin for these patches, please make sure you mark the subject
> line as per the netdev rules:
> [PATCH net-next v1] etc etc

Sure, I'll resend!

>
> I'd also prefer they came in as part of one series with a good cover
> letter, at the very least for the Intel drivers, and you probably could
> combine any others (netdev) together up to the 15 patch limit.

Got it :)

>
> Please mention how you found these issues, via automated tool or via
> coccinelle script, manual grepping, etc?

rg "strncpy\(" > pain.txt

>
> Thanks,
> Jesse
>

