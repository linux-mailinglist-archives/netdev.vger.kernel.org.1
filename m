Return-Path: <netdev+bounces-46850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F27D7E6ACE
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 13:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A09871C208A8
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 12:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E09883D;
	Thu,  9 Nov 2023 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QS8W2bQ6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1612918E0A
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 12:47:03 +0000 (UTC)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAEE1BDF
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 04:47:03 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a82f176860so9829877b3.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 04:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699534022; x=1700138822; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUEgb8MmlHVZ+GQXOXSn2Ul5aehNovNEy7sZi4Nbf5I=;
        b=QS8W2bQ6RWOMpXDZI0lfXbuVwJHtSPvoF9BSWjtE4dL2DeJXynplYZofdYVsN6p3or
         kxR4ibpEFoTVbFvixXnGmKGxQFUKMDkqhdcHb8OdNKyVDzuuF8rduCihH11dexXQ0fdU
         NbM5x+xWiBk6YohvjI7NWUHLNXFeIgvPEleiNzDbpHSkKMB8yjfV+cR24ySmEv85VWQX
         FONpN2HNkcSO2nVimS1aIm1rmn3ddkyhWHuzWEprJ+3AgfLfonLe5xByR57PCoWNPpfY
         POt/MLNvHa9itMjsGP35omYD0ThW6tICLFPDF7kddaZOdQsz744eI7Xeftki1u2WCAM8
         mg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699534022; x=1700138822;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUEgb8MmlHVZ+GQXOXSn2Ul5aehNovNEy7sZi4Nbf5I=;
        b=c3Qf5XgsrkWI4DmCHA2GTfwWDX3yGfjv+2GUBUDLAGR98lzvNi2pXumZ/mhMJ/DKyF
         xrDfsebD7sh26ti/5ZH8iEtWrCRa5HzlWvCpcC5zm5U4OdfySPy3Fa1GIud1n/orVi9h
         VmIrn3HSLZp73tNDrGkSCcKTsFlYDYoi6WldvfJ0WShbmkk4HLkT4DSthmYQJdYfl5/p
         67d7C4bxMnHFVJ0kqibTjvaoiC8PUF91iGCSd8pzRHBxs01zTgOR3Fkt/99PhgnN3Kvf
         WX1Z/Rlno9wz5jRpkDp79NVuZN2dkBLYFGGC785/ND+THMuRf6FRgvjn6bp0UYl83GK0
         Ba2A==
X-Gm-Message-State: AOJu0YxwL6M+F3ZJw9MLmuwjkjGckKFUq//00wrQ4RSlPZNk8MQ7Y0PJ
	NAnkEpOtAo3S37SV0s3/olxXKykc7zW8pwYISlZkVw==
X-Google-Smtp-Source: AGHT+IGb5+7qEAUXDqtbvGisdFDBkO6/VjsCdjKUSsKXrN9GVIF//NY9TBAeKGJwTSJpgHcDzpBuTaoA05z3h00RGuk=
X-Received: by 2002:a0d:d597:0:b0:5a1:e4bf:ee5a with SMTP id
 x145-20020a0dd597000000b005a1e4bfee5amr5088917ywd.41.1699534022641; Thu, 09
 Nov 2023 04:47:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109-gemini-largeframe-fix-v4-0-6e611528db08@linaro.org> <20231109105037.zppxrr3bptd7a7i6@skbuf>
In-Reply-To: <20231109105037.zppxrr3bptd7a7i6@skbuf>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 9 Nov 2023 13:46:49 +0100
Message-ID: <CACRpkdaNLjnLtGNQtcsH4xC8FQusj510cQvOYXLHw=Q1Y-hoNw@mail.gmail.com>
Subject: Re: [PATCH net v4 0/3] Fix large frames in the Gemini ethernet driver
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 11:50=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:

> Thanks for being persistent with this! I hope we didn't miss today's
> "net" pull request :)

Hey thanks for one of the best review cycles I've ever had, really
really appreciated.

It's more important to be correct than to be fast so I don't worry
much about when the patch goes in.

Yours,
Linus Walleij

