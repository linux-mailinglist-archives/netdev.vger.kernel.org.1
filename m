Return-Path: <netdev+bounces-39158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD957BE3FB
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9F952817D2
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68217358A6;
	Mon,  9 Oct 2023 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLcOIB/A"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C1C3589F;
	Mon,  9 Oct 2023 15:10:36 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A92B7;
	Mon,  9 Oct 2023 08:10:34 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-59f57ad6126so53889647b3.3;
        Mon, 09 Oct 2023 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696864233; x=1697469033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMC88S0qrfafC1vEN5gaaHAmtL09HThTcq7GEvuJAPE=;
        b=YLcOIB/Az+5L/+/0oXXLXDy9Knje3UqxIzmTz8jv78vciL0nUegBeWB4r7/D6jPesW
         U4kbxK6q80QGgfxBMFIwXFPSp0ONcy87lSqLOeMyJNMv74iHJ1yRMmhLHIhLEg76OUd+
         6A689bKyEYrQ8be/tbEDDDKd33WteKJA/EtdxWg76InOEtUFSMpYI7OdnKcw7ryrYOVq
         HCt0g/L92/vIY+IdzRFZt7UgsrCWlX0tK5W5uBlDvCJnYRlhrwECO+1oJqMncNNT7oTK
         L7M3kxUOu9mtZFaQveY6+dcS7N1vYOVTrqSCkslPqqjOH8NtB4DGVdjQKkWAt1engBTu
         W6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864233; x=1697469033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMC88S0qrfafC1vEN5gaaHAmtL09HThTcq7GEvuJAPE=;
        b=fN6GsOL5wZx+AG0FCkBZ+ymqjywg0byTDv88AjpUXufeJ4nL8qlIWJ+HtpXPDLYOTZ
         RGRlqGL6E2ubkPylESrb9iO5SMMQkctQokU5ztzHL4kHG7fIpT8MZYxGrUe06+i/zfka
         hiS+2R1N8YohI9OwwshMFaRW/h9It1o0Uq9pex7zfq8+0n5HS+trY0hxL1XURN8YyTBw
         AJnaw8cfgoCv/eBGmy6h8VtYxq1GGsY8GXyxp5dnO67Im+rHOxXUNVaSYFR+nCHgw3nZ
         sBi+KZFfhIzQx74PFM6lQN471gVB/azvryPLSLsmPrYJ/zHnrHFQC0GSnCCPpVd+4NQ1
         ZAMg==
X-Gm-Message-State: AOJu0YxglY4fZtsFusHscMKGA9Fetn0xlojcwsofxPDkfRADwmoJQlBS
	J1clMV3lagMwI48n1Y/KSIbmnnol+UBuFxbEVKs=
X-Google-Smtp-Source: AGHT+IEdEuB7xC+WUjlCyKLk9t5Ed59FyH/tK2PMhwif/tn2St2Ody7LWF8HzSES0hkEi1+Cwe2D4TfJNE8mGR+PsC8=
X-Received: by 2002:a0d:c787:0:b0:583:b186:d817 with SMTP id
 j129-20020a0dc787000000b00583b186d817mr15342503ywd.27.1696864233434; Mon, 09
 Oct 2023 08:10:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009013912.4048593-1-fujita.tomonori@gmail.com>
 <5334dc69-1604-4408-9cce-3c89bc5d7688@lunn.ch> <CANiq72n6DMeXQrgOzS_+3VdgNYAmpcnneAHJnZERUQhMExg+0A@mail.gmail.com>
 <ZSQMVc19Tq6MyXJT@gpd> <a3412fbc-0b32-4402-a3c8-6ccaf42a2ee4@lunn.ch> <2023100902-tactful-april-559f@gregkh>
In-Reply-To: <2023100902-tactful-april-559f@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 17:10:21 +0200
Message-ID: <CANiq72mDKVKv805n7zQ6SOLhtrp_P2Gi_C89Kis8SGgT1JhT6w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] Rust abstractions for network PHY drivers
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Andrea Righi <andrea.righi@canonical.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 5:04=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> Is MIPS a proper target for rust yet?

The compiler has support for it
(https://github.com/Rust-for-Linux/linux/issues/107), but I didn't do
mips pre-merge.

The ones I tried (and that we had in the CI back then pre-merge) were:
arm, arm64, ppc64le, riscv64 and x86_64.

Cheers,
Miguel

