Return-Path: <netdev+bounces-52232-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 269697FDF16
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 19:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586D81C20AA1
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C72E5C3C4;
	Wed, 29 Nov 2023 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="04b8Q81K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21228B9
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:09:28 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so466a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 10:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701281366; x=1701886166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YPZxso0QzNj3gqcGGnNvHk0pzKPfOYD5SPW1T+A/ws=;
        b=04b8Q81KSvsKQJIr2Te+mfZoEcAHDHyHsjycrRAolZzPGhXM25XYFF1Uqs9MjADf/t
         dyZ4Xdv4ryaQE6/ar2C5pnG96McgeQwyODgjbzxOTmpkHf+V4EZNM4OhQL9HBnqVmJ69
         hGeAjtpmrCHm24SZU1qmm4euTEsMkYN3qEs0rGVJ81wrkS0Nlso5vFmFNa0SBoiUKs8Y
         IQxib3K+ZZ6e5BSzkL7C3jFOfL57KyB/oODB/pkcGoPXejC1h2mzuwtFGlH5fEKJd7Px
         0R6xmQcNWqTyIjK8gsbZumazpyZwpG9NV2Yckrq3mHN253isf7XN1yPZpM5xWRb0Vlv2
         NYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701281366; x=1701886166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YPZxso0QzNj3gqcGGnNvHk0pzKPfOYD5SPW1T+A/ws=;
        b=SvKi1ibmqOM12o5Ug//iuUt9Q6Mw23LfIgqQeGjouJ5aYNQgd3SpPzjCOTEwixfmEd
         iD4m4jc6Xy75k4CN22pYr7DNjnpeWh09fP9WsJGBg4bVLWWraQHZpCPkoS49mCpn3NZU
         6GuzQac3Cf7w4ACqZPaV/AAtuaIW4qKpAo0pDoWwj/+1HZ/ddS/HCeUEgcx7eBusIL9e
         fHzcqPK6Y3REOi3ByU7wt6+D0VJeBao0eCWZgF6RezqGZx+3xiNclOg4HWofu1mZdYQ0
         EG1F32MNGR/uzaFXSF0vVwE9uyRgtJGBsLtppTtdEbWe6jJbKIbFn6FfSmmh2TsUwITM
         ZAeA==
X-Gm-Message-State: AOJu0Yxaql4L0eTIpGEhdPELLBk2dvcR2/PrS9FLYL7EiaD4ZGLqDKYl
	cTThcwKdK6Iqz2URQs9toSTPUYXtlrR7WXNHfcvu5Q==
X-Google-Smtp-Source: AGHT+IGiyVfo0h1STetqMMeNh8jBnd+AcgPt9CyQh2xWsa4CcDK38D7CVSk+TcXDS8kdKV2WvAN1e4fYH4EH4oFMgT4=
X-Received: by 2002:a05:6402:430e:b0:54b:67da:b2f with SMTP id
 m14-20020a056402430e00b0054b67da0b2fmr635103edc.7.1701281366310; Wed, 29 Nov
 2023 10:09:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-7-dima@arista.com>
In-Reply-To: <20231129165721.337302-7-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 19:09:15 +0100
Message-ID: <CANn89iJcfn0yEM7Pe4RGY3P0LmOsppXO7c=eVqpwVNdOY2v3zA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] net/tcp: Store SNEs + SEQs on ao_info
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> RFC 5925 (6.2):
> > TCP-AO emulates a 64-bit sequence number space by inferring when to
> > increment the high-order 32-bit portion (the SNE) based on
> > transitions in the low-order portion (the TCP sequence number).
>
> snd_sne and rcv_sne are the upper 4 bytes of extended SEQ number.
> Unfortunately, reading two 4-bytes pointers can't be performed
> atomically (without synchronization).
>
> In order to avoid locks on TCP fastpath, let's just double-account for
> SEQ changes: snd_una/rcv_nxt will be lower 4 bytes of snd_sne/rcv_sne.
>

This will not work on 32bit kernels ?

Unless ao->snd_sne and ao->rcv_sneare only read/written under the
socket lock (and in this case no READ_ONCE()/WRITE_ONCE() should be
necessary)

