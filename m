Return-Path: <netdev+bounces-47063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B077E7B2E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 11:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7CE71C20AA2
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 10:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572E0134D9;
	Fri, 10 Nov 2023 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="z5qahyMF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0F4134A3
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 10:13:05 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC2D2707B
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:13:03 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso3005281a12.3
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 02:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1699611182; x=1700215982; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+mxjtMW/dfKr4kgC+G+KtOl9HaxfFELBQo/XvtL6sA=;
        b=z5qahyMFb+DiX7qHPyR2BpT2MQbDb8d9GWzT4dx+KUW4d8ex/lip61VN/mrWTWwWJw
         +ZgTPfPGyHzDcMpqAbLtwnqEFY6RxCtVGVr/8z8LSB+GATrGgQ6yEou4dt69ik+FVGgJ
         uRHLrNQttFXzXwL327NrZ+KhUf/fcCaVgtJMEWaJpm4uUaB/FdNlTsEcwmdtSn1a20mN
         1mNQAFk0gnZbhEDltVA54EiUP9Ga+sOzBcsqT43TCVS0WzOmgrGy5pHpWw3ZbdbJzm7n
         WA2GkAGTWhNotynsxkI0smkobGnengSV3wtzreYiqNS4uw0tYlqz6zleh/KNi7385M90
         O64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699611182; x=1700215982;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+mxjtMW/dfKr4kgC+G+KtOl9HaxfFELBQo/XvtL6sA=;
        b=ftfMAygsGfQS25H0j7A+emRpxVz7OS0yNbv5Pz1OIzG9ACw0z8LqzdoDOE0jPerxuw
         ByFnl8ughqx+BoIRqP3jjXA3UVuv3OwC/CQqglOZCrgeCBKrNjPA8nsw+MlkQiCM86Ck
         3sfz00D2naN3rGsRS8gAJ7WgPodN6x/QLaVj0R/+AEL32KiyT/i5wVfbLYeTCpIYBx4G
         ByW5WuH3OhVp3oSpjHwO90xR40VRbOLZGCUoB2UryDDfueBfUodeqM+ItkHNMsHkGIA0
         taNdlzXeIlQjnA/ywp0W+5g8wZob9Wzh1SXGaOP98WmyF3UR8H9tfwWGPLq6W0rvrVrV
         ecnQ==
X-Gm-Message-State: AOJu0YwSjbtKncJ6HgqoHEVgtKV6QiJjdLMhze8ZhFeeF3aczwtgzYQZ
	MR7O+NG4xYSHcZ+ugx6ekV6cMg==
X-Google-Smtp-Source: AGHT+IEAuph3Sgu08/3NXxqkoU7KWFD18CdByptzoZMtFL6u0eCZP2+mIrfwdGlFmLCqhtqDF59obg==
X-Received: by 2002:a50:8e1b:0:b0:544:a213:a6fc with SMTP id 27-20020a508e1b000000b00544a213a6fcmr6912240edw.2.1699611181778;
        Fri, 10 Nov 2023 02:13:01 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v25-20020a50d599000000b0054353639161sm946774edi.89.2023.11.10.02.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 02:13:01 -0800 (PST)
Date: Fri, 10 Nov 2023 11:13:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Eric Dumazet <edumazet@google.com>
Cc: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Weongyo Jeong <weongyo.linux@gmail.com>,
	Ivan Babrou <ivan@cloudflare.com>, David Ahern <dsahern@kernel.org>,
	Jesper Brouer <jesper@cloudflare.com>, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH net-next] packet: add a generic drop reason for receive
Message-ID: <ZU4CLCk1APrD3Yzi@nanopsycho>
References: <ZU3EZKQ3dyLE6T8z@debian.debian>
 <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKZYsWGT1weXZ6W7_z28dqJwTZeg+2_Lw+x+6spUHp8Eg@mail.gmail.com>

Fri, Nov 10, 2023 at 10:30:49AM CET, edumazet@google.com wrote:
>On Fri, Nov 10, 2023 at 6:49 AM Yan Zhai <yan@cloudflare.com> wrote:

[..]

>1) Note that net-next is currently closed.

I wonder, can't some bot be easily set up to warn about
this automatically?


