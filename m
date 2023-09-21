Return-Path: <netdev+bounces-35568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7E7A9C12
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:06:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20E511C214ED
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF6C41757;
	Thu, 21 Sep 2023 18:59:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003312B96
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:59:18 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0932F1B15C
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:59:17 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53074ee0c2aso3689a12.1
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695322755; x=1695927555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJV2mqqSprXSlM87WQkx2XPFyvLFRft18WJ1B6UsVOQ=;
        b=nmqpbbYw2mHC3Xn9JAcabZFiYhUapWbXKhiKxW0a891XlFst918MiG5tUDzlbhS5NL
         w1qo7E1el+I/m/N5nFFgyO9M7sXAh0qJzeXsppiOBiCVxLOLe9jlc01xLmjVsmdzeyIm
         aUSMNbP8p5QRV6YxhZrUs9ODliJ72kcnfuDgaVALQCZge8xiRU4GgBIfU92gAxvkYOmG
         wQXBPi/Za1mvgaMT0krd5ArimVavT/9AHeuujwVWZ558hTNlimtoT6iK7osrf50s3nJd
         D/IkB/3XMysA/ok2zdyu0/gAhkfjh/VmiyM4DMYjroKRU2d7G0R4h7ecB77jcJnTTHky
         nMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322755; x=1695927555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJV2mqqSprXSlM87WQkx2XPFyvLFRft18WJ1B6UsVOQ=;
        b=ejkRA+oPcFkeDFSknpOUFfyfpkOZamwXB/LwnUitbYsE6R7fwcYlz2kWwd1S9lQ9Ce
         utpOymlBj4vT1abd5S1ZR/PtvBjstfZn8gdAsZNDHSxtCdCpNHJ4wj2QbsncVehJ0WwI
         PgzrQk/VTkgBkiszje1jiHRPyFb0m2cLyBs5eYqmxuPo4OLxuqFRCwJLb1pfpeZ1RSFE
         5tOdne+tMXU4hS2Z7orYa7n5Krpm9jr6zv17zbZn93rtC5MXZcfSKMhDmoP1cpBf4rva
         eXmC5rsde3e517v1MCmijLjXx+Suckqd7mPBSVZ/e6+T5w8Q543H5X6jZPa2j3dAIcDU
         SH8g==
X-Gm-Message-State: AOJu0YyA6Hdna96jF0ptbbh+iO7HdQDxI6sOFU8q09UjkHtYpuZk5hAM
	4gkskHf4zPr2MLhkvSwmUvdk8Mmsn0P8uMzXqiBGyOVA/hvFXWzxXLs=
X-Google-Smtp-Source: AGHT+IGTGIuL37pTAr1CP4rxL5KVyHYrnsTABHVu9UTLIPsivfUISf+7tm4EwX665pbAm9tA2COYZ6PI/LwGJFXB8tY=
X-Received: by 2002:ac2:46cb:0:b0:502:cdb6:f316 with SMTP id
 p11-20020ac246cb000000b00502cdb6f316mr19784lfo.3.1695277913764; Wed, 20 Sep
 2023 23:31:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <20230916010625.2771731-4-lixiaoyan@google.com> <56d32e37-afdd-342c-947d-dec329a504e5@linux.dev>
In-Reply-To: <56d32e37-afdd-342c-947d-dec329a504e5@linux.dev>
From: Coco Li <lixiaoyan@google.com>
Date: Wed, 20 Sep 2023 23:31:42 -0700
Message-ID: <CADjXwjj8ntkj=A_oY3om=QKJRts1zqihZSRV0iaVEXodQRQ64g@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 3/5] netns-ipv4: reorganize netns_ipv4 fast
 path variables
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Mubashir Adnan Qureshi <mubashirq@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Chao Wu <wwchao@google.com>, 
	Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 17, 2023 at 10:10=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 16/09/2023 02:06, Coco Li wrote:
> > Reorganize fast path variables on tx-txrx-rx order.
> > Fastpath cacheline ends after sysctl_tcp_rmem.
> > There are only read-only variables here. (write is on the control path
> > and not considered in this case)
>
> I believe udp sysctls can be aligned the same way. With HTTP/3 adoption
> we should think about UDP traffic too, and looks like we do have some
> space in hot-path cache lines for udp_early_demux and rmem/wmem.
>
> And have you thought about cache-line boundary alignment for these values=
?
>

Thank you for the suggestion!

The patch set was created and tested with TCP traffic in mind, and it
is really with the entire series that with TCP traffic we can see the
cpu per ops improvement, whereas it is difficult to measure
performance improvements of the individual patches including this one.

As you pointed out, there is still space in the hot cache line to fit
UDP traffic sysctls. We encourage folks to use this series and its
documentation as a template to add fast path network stack protocol
variables that are important to them :)

