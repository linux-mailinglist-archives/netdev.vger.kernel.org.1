Return-Path: <netdev+bounces-39056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B215F7BD915
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF6542815D4
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 10:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220D615AF0;
	Mon,  9 Oct 2023 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLCsjFCO"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897208C16;
	Mon,  9 Oct 2023 10:58:34 +0000 (UTC)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9459DB;
	Mon,  9 Oct 2023 03:58:32 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d81f35511e6so3718280276.0;
        Mon, 09 Oct 2023 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696849112; x=1697453912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fCZqkEqB9yiZxZH52DDqEkC9znrQk7QohCAsUSBpcyk=;
        b=HLCsjFCOhkucw6RjD8rIuqvbXbNdQ9gefgBGUMFEwOHArbHNH5r/tZXdqGM+yhx4f1
         eX5WDiW3HFmfkzUhS2KFwhB4cBGm0Y0Lqo3FSl3zh8ZXdno2/4RwlNfokquN2lxZQQWZ
         sRikyMBjIq0yIbFf1Oabw4C0He2qpvszuxUZ9/n4F2B7vogPTOG6JHC/gwNParrY3HIZ
         txfOMsy1pKwHUfX8nr5JhX7YuWxYWxheHO5+Z1he17mN/Q5G8oKzCCCOMQVVm49lCDk9
         nd0PmXVfE8sLY3zu8yXU6h7orVrbmFnmWtORqdCUx1UIYhjQkUCpSkQnfVU0TbMqRfXG
         D5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696849112; x=1697453912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fCZqkEqB9yiZxZH52DDqEkC9znrQk7QohCAsUSBpcyk=;
        b=Q/1zTyvtq8q85i5aaYasr+9SDjc/qBK1y8D1+IpCmXH+0m9WlJpWtrt3y1NdBrzYrp
         J5An+aYNKfuhgGnzwl3k72hAIGZ38Fot0d/aJGQ8QsignvtwtMm/joHY2XLsQ+P8N8Qh
         84/VVecJjMazfCdD4Ym2Bo0PWjNdXpSX1aa5Aza+h6H3byHl/yWat5A23Bq5RP7ueygW
         xA50qHH/Bzr/paaa4/fojBTaOm4uyzXYBkMbuGriYIb96bFpDxRUkLV+p2QkuoH0bdAb
         p8Rn6muFPZZczZ5MIyPW02EiwToWWC5rkuDZn+mL9wAJCxhSWXCgYIF+EnJy73JKmnLc
         646A==
X-Gm-Message-State: AOJu0YyH60WmPgIjN24Mf28xr/4zFndL2Gf5dxGNg0rkp6Nh65mLEtN4
	QGOAHRhGWerRyJ4TjCWBySxslanBuThhje+kf6w=
X-Google-Smtp-Source: AGHT+IE/ixEky9ONZDKTvtjn1K1cSM14VibOGgjg5X5mC83nEvqSHlbwJ3W72XbQF7skMiba48/Av85w34Ia5zfkdMQ=
X-Received: by 2002:a25:ad4a:0:b0:d85:ae0d:20eb with SMTP id
 l10-20020a25ad4a000000b00d85ae0d20ebmr6729478ybe.14.1696849112019; Mon, 09
 Oct 2023 03:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <20231009013912.4048593-4-fujita.tomonori@gmail.com> <ZSOqWMqm/JQOieAd@nanopsycho>
In-Reply-To: <ZSOqWMqm/JQOieAd@nanopsycho>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 12:58:20 +0200
Message-ID: <CANiq72=ud-3VaGbmJcWthH1ADq59PTF0uLC+EduiJNy5U6bxVw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/3] net: phy: add Rust Asix PHY driver
To: Jiri Pirko <jiri@resnulli.us>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, greg@kroah.com, 
	tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 9:23=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Wait. So you just add rust driver as a duplicate of existing c driver?
> What's the point exactly to have 2 drivers for the same thing?

Please see https://lore.kernel.org/ksummit/CANiq72=3D99VFE=3DVe5MNM9ZuSe9M-=
JSH1evk6pABNSEnNjK7aXYA@mail.gmail.com/.

Cheers,
Miguel

