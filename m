Return-Path: <netdev+bounces-54033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C761805B0A
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 18:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CE5B21038
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 17:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E284E692B9;
	Tue,  5 Dec 2023 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkJ6uoCv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B50BA
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 09:19:48 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so16317a12.0
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701796787; x=1702401587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umkO62540Aj3zvWzqiFrtAxv4EDQJDPaEch7kzL52w4=;
        b=AkJ6uoCvQX7DtXIJCQrGnGeKVY9v8RjG18PavVxGcstaWTLPD2Yzpco4t6tdyRGGZH
         inYGMWp3QKa6vgcGavuermbtFOHhzmZWD0ltwI6qerF8XAwmLSJdWvNvoG3Sf6cx5Qnx
         IHh/kX/p5Cb7VTNYNBXoCNrnJ6y/jyl4EjjY2uwn5JV5vYseuPqp0gc74INds9fuPKTn
         9XGddgAWNHzfxf5yiQQvu6mTugh/n9YawP+uOBvYXxiWLmznzW691hLlElhIFLsDgBfa
         Lw5b4iJZGyFMS4gEjouaU2HIbBvi2ETAci/lTviXRgV2SeX7u3pVjFY2aTrev6dfUY9P
         yAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701796787; x=1702401587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=umkO62540Aj3zvWzqiFrtAxv4EDQJDPaEch7kzL52w4=;
        b=A1+m4NReLeoIHobJUpCJId9YfUlcJQg6EypYrt5nBENjB1DSmU55WqijbkjDIkHdKT
         YvTtuLi4U9S0A/ZMIUHfEqoLoUDAMjCk76omRa6Fsr0oI1bcPbROSgt5toGzIe8ocSGK
         I2/0Q9DohH6GNw3iuiwZ2pDp61f+yrwxcpN+ZudN0E1M1L4xMota5Rz25vC6BWJF/mKZ
         4ct7bncdDmwDYTtm1Vnr+olj60TLQiR3FoRR6iLZN5DYozGZHb4hDJzSKVUUQj45iJqP
         RgnrYhkKF/ghrace98DRGGd0cdS7G8tOFKQkfZTDjxhg4KiA480TeuvPbmNl5RS3/Jjl
         kCkA==
X-Gm-Message-State: AOJu0YxxK5BSm4xTPzwWMBQ9MPPacRYrBTkP3tcCI2stUhdYqWAyK1ke
	ZOTuPDktsFA8wg5chIeX+/IQXxc1e5zLK9zpWguKCQ==
X-Google-Smtp-Source: AGHT+IHRRjHLrv/6KKrW2+eJAnGeEoquiwctjD4JS5HmVTRkbeMRPHRJNq/mFyACg001jJP017BhLKURRop1k2Gu7gs=
X-Received: by 2002:a05:6402:35d3:b0:54c:9996:7833 with SMTP id
 z19-20020a05640235d300b0054c99967833mr313861edc.7.1701796786643; Tue, 05 Dec
 2023 09:19:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231205161841.2702925-1-edumazet@google.com> <CAK6E8=dCNTuZvyHJYUzv-BmFVkxa=cnDazgLdCtDLvrGmEWT0w@mail.gmail.com>
In-Reply-To: <CAK6E8=dCNTuZvyHJYUzv-BmFVkxa=cnDazgLdCtDLvrGmEWT0w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 5 Dec 2023 18:19:32 +0100
Message-ID: <CANn89iK++qfrGEg=2dxfFLXc_SAOUvjwTgtt55L8yRZbVW8a2Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not accept ACK of bytes we never sent
To: Yuchung Cheng <ycheng@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Yepeng Pan <yepeng.pan@cispa.de>, Christian Rossow <rossow@cispa.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023 at 5:47=E2=80=AFPM Yuchung Cheng <ycheng@google.com> wr=
ote:

> Thank you Eric for the fix. It appears the newer RFC
> https://www.rfc-editor.org/rfc/rfc9293.html also has this issue that
> needs a revision?

I do not think RFC 9293 made any refinement about RFC 5961 guidelines.

Perhaps Yepeng Pan and Christian Rossow have plans to bring this issue to I=
ETF.

