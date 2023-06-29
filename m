Return-Path: <netdev+bounces-14495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70061741F6F
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 07:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD9B280D43
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 05:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A203D7A;
	Thu, 29 Jun 2023 05:01:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EEE19A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 05:01:33 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D605171E;
	Wed, 28 Jun 2023 22:01:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b6c3921c8bso3597141fa.3;
        Wed, 28 Jun 2023 22:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688014890; x=1690606890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBKFq44jqGOdxh6U47zYYsb7gN9jnHSeJzC8D5qBkgE=;
        b=SApxTIr8GoNPoT59+Bjfs0rjXok08C6fm8z8R5hZ1r2Rxi0ZnYQbGv0hhQX2pTSHc3
         ffNDoSIOs98WOHaTurMcw5ns6YVYJ90qVksYsUVAPZyK1cszU6AHoCe7kMsVAF08Ese0
         zzdt6TvGprbfPbfOlH7OzxHI3czMvxbHdYXRBg9JbvuWE8fIjftmL0V6b2YvNPRc4R3E
         DwAbDanu9lnyibeV8ApHhflScq8CPPoRWyGmd5SdITyxfrdEFB8RdLbEld4Gnqh0Ozz0
         Xgq+zWWbI22pdrkpC/S2QH1Y6o2LTeogJnFlfounQ68/ktdzpo7G6us92EJRPKzfoAGf
         3tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688014890; x=1690606890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBKFq44jqGOdxh6U47zYYsb7gN9jnHSeJzC8D5qBkgE=;
        b=VJyq5BzHaoSwjgorlqVyBX8mqXr28MGm86C2TTS4WucG1PzBH1vZfJeSDeKgBC79qc
         ZASiaVuWdaGCduHxe/ilgqkhMlZEPNSP0buSi3yAy9ydWyG6aYEYun49AJgZyFQ3rESW
         lWn4AGa6cA0w5w7IYZs5BSzA3Q6AH9qdJB/qYFKjHX1aqNhkkaEajeZSOTfZC993ICrn
         Vsh0+x5QcR/N3M3P4A3DZUB4JAkIBMyzBIrmr6OGQtuHYNplKDoFj94LBREtVA7RvYVT
         6Lj3DQ4RGs549PZT3qKuHt8bx8EBIZ8UWTEnYoLlKieopFdWBLGbHLhcw1efkhYp9yg5
         3hpA==
X-Gm-Message-State: AC+VfDxuatma7Bw5Kqaxz185ioP6F9XoNdGh7/5yBaPhdYUJG7We5W5S
	Vv3ClIfFCF+lKZroOCUy6eBmkKraMv3bCPetsyLKQxUs6S8=
X-Google-Smtp-Source: ACHHUZ4XrkcJTsYLEcKpSPkUIrDNVjAuVFs6SJ6ehXLxXdfkGxitABJfRAYGA+zaaBUaNlaa+1z6avt0Ute2EeWknJU=
X-Received: by 2002:a2e:9917:0:b0:2b6:b65d:471d with SMTP id
 v23-20020a2e9917000000b002b6b65d471dmr4392608lji.43.1688014890017; Wed, 28
 Jun 2023 22:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230627191004.2586540-1-luiz.dentz@gmail.com> <20230628193854.6fabbf6d@kernel.org>
In-Reply-To: <20230628193854.6fabbf6d@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Jun 2023 22:01:05 -0700
Message-ID: <CABBYNZLBAr72WCysVEFS9hdycYu4JRH2=SiP_SVBh08vukhh4Q@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2023-06-27
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jakub,

On Wed, Jun 28, 2023 at 7:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 27 Jun 2023 12:10:04 -0700 Luiz Augusto von Dentz wrote:
> > bluetooth-next pull request for net-next:
> >
> >  - Add Reialtek devcoredump support
> >  - Add support for device 6655:8771
> >  - Add extended monitor tracking by address filter
> >  - Add support for connecting multiple BISes
> >  - Add support to reset via ACPI DSM for Intel controllers
> >  - Add support for MT7922 used in Asus Ally
> >  - Add support Mediatek MT7925
> >  - Fixes for use-after-free in L2CAP
>
> As you probably realized these came in a little late for our main pull
> request for this merge window. Can we cut this down a little bit?
> Stick to the fixes and changes which you have the most confidence in
> and try to keep the new lines under 1k LoC?

Yeah, sorry about that I had a business trip which sort of messed up
the pull request.

> I had a look thru and these changes look like stuff we can definitely
> pull:
>
>  a8d0b0440b7f ("Bluetooth: btrtl: Add missing MODULE_FIRMWARE declaration=
s")
>  349cae7e8d84 ("Bluetooth: btusb: Add device 6655:8771 to device tables")
>  afdbe6303877 ("Bluetooth: btqca: use le32_to_cpu for ver.soc_id")
>  d1b10da77355 ("Bluetooth: L2CAP: Fix use-after-free")
>  c1121a116d5f ("Bluetooth: fix invalid-bdaddr quirk for non-persistent se=
tup")
>  2f8b38e5eba4 ("Bluetooth: fix use-bdaddr-property quirk")
>  317af9ba6fff ("Bluetooth: L2CAP: Fix use-after-free in l2cap_sock_ready_=
cb")
>  a6cfe4261f5e ("Bluetooth: hci_bcm: do not mark valid bd_addr as invalid"=
)
>  20b3370a6bfb ("Bluetooth: ISO: use hci_sync for setting CIG parameters")
>  29a3b409a3f2 ("Bluetooth: hci_event: fix Set CIG Parameters error status=
 handling")
>  48d15256595b ("Bluetooth: MGMT: Fix marking SCAN_RSP as not connectable"=
)
>  f145eeb779c3 ("Bluetooth: ISO: Rework sync_interval to be sync_factor")
>  0d39e82e1a7b ("Bluetooth: hci_sysfs: make bt_class a static const struct=
ure")
>  8649851b1945 ("Bluetooth: hci_event: Fix parsing of CIS Established Even=
t")
>  5b611951e075 ("Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Al=
ly")
>  00b51ce9f603 ("Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + m=
emcpy")
>
> You can throw in a few more things you think are important and are
> unlikely to cause regressions.

Yeah, those seem to be the most important ones, do you want me to redo
the pull-request or perhaps you can just cherry-pick them?

--=20
Luiz Augusto von Dentz

