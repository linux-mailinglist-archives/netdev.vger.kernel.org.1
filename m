Return-Path: <netdev+bounces-39208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C600B7BE526
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FAD281839
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD91374CC;
	Mon,  9 Oct 2023 15:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEJdpZtd"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09491358BF;
	Mon,  9 Oct 2023 15:39:40 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F35A6;
	Mon,  9 Oct 2023 08:39:39 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a200028437so58201267b3.1;
        Mon, 09 Oct 2023 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696865978; x=1697470778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIrZZ5xskHIRXAYoS59oyB3yKN0uOXhp3znwgdcK4V4=;
        b=OEJdpZtdhyTWEqJKnuCNUxyU3lRPDpEuXloAZxvhj1xjnf9dLIyZCGyM0CGJWlp82t
         X2Iy1ZP2X8VjGkoyMaYZJfpMVFHlRaMpTjwZ3iEN2A3EoqPV7gR69gVurly/mMouDUTn
         nubcJo3zz42n9TPfhfIZY728DGAf3cLoRt4YuvSRN/aRpFRhNm+utZTwnk+D6600fX3V
         yyw/NKDf93vGry7oiwdP+7gTzWdD9vSkQ5NlghlRMN0xPWfwssjtzGxIfwNHbnZD/Yhv
         halZqhyDPrI5PnweGrvZr/uQRZ5BS+f/B3ZBX5hutQJUWPtC/Mc6R4Q0Xl9Wq3KNCtez
         KaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696865978; x=1697470778;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIrZZ5xskHIRXAYoS59oyB3yKN0uOXhp3znwgdcK4V4=;
        b=Lu4bn5ChNNLG8+1UeGx0fRh6fZXbTCtsCvjcyrhwXXBeHjo+7+vLySe9FKgc/CS44m
         XIfX+Y6Z1xdmyOWqn1hsgM+btO0Xz1NJnz7tbu7EsDNocVvVx1aBi6DL5ylRTa0JxXG6
         +BE9ZibZZpjgEDda93CGVM01C40Uk/Gdz9UitYJgwFQGvN2uofLD1Pzw3dv15eNk6pzY
         6Ysju8wn5kyV9A8bxlH5bO611ab2CJr8XZLRqXtaM2RKqavH6VMb9iYuTAPsBp3ettGr
         vMP/xzUg97vEp66ksIgEX5zUhFAFDLBgPFDuzP/FLpOHlBy/MiSuHFhICLD73ObQKknZ
         LGnw==
X-Gm-Message-State: AOJu0YxEN9MfbnrxZ7ZN/h/7pwjchB9TME7JjKorzCg5LSiTYSZ/GYL+
	15p903fs2KbNgRVPeSu+82QRFxY5U6WKxwLJ/T0=
X-Google-Smtp-Source: AGHT+IG+hNAxB41K6zt2iBZ+P7RjCi3ZaCke4t0MD5yK/4gxwRuPXrkrfCSNCpCJmfTE/ePBe194WQVg3NFfuZV4btI=
X-Received: by 2002:a81:47c4:0:b0:5a0:ae01:803c with SMTP id
 u187-20020a8147c4000000b005a0ae01803cmr16012564ywa.38.1696865978432; Mon, 09
 Oct 2023 08:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72nBSyQw+vFayPco5b_-DDAKNqmhE7xiXSVbg920_ttAeQ@mail.gmail.com>
 <20231009.224907.206866439495105936.fujita.tomonori@gmail.com>
 <2023100926-ambulance-mammal-8354@gregkh> <20231010.002413.435110311325344494.fujita.tomonori@gmail.com>
In-Reply-To: <20231010.002413.435110311325344494.fujita.tomonori@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 9 Oct 2023 17:39:27 +0200
Message-ID: <CANiq72nj_04U82Kb4DfMx72NPgHzDCd-xbosc83xgF19nCqSfQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/3] rust: core abstractions for network PHY drivers
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gregkh@linuxfoundation.org, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, andrew@lunn.ch, tmgross@umich.edu, 
	wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 5:24=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Trevor gave Reviewed-by. Not perfect but reasonable shape, IMHO. Seems
> that we have been discussing the same topics like locking, naming, etc
> again and again.

Well, there was other feedback too, which isn't addressed so far. So
merging this in 2 weeks does seem a bit rushed to me.

And, yes, the discussion on this has been going around for a while,
but that is precisely why we recommended to iterate more on our side
first, because it was not ready.

Cheers,
Miguel

