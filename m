Return-Path: <netdev+bounces-53038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B180D801247
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C09A28162E
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DEF4EB51;
	Fri,  1 Dec 2023 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R29LKEjK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921C2FE
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701454171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CSE51B6oGQ/hDqCz1Sb5J7ty1qTdM7cHpcMNBpbyNmw=;
	b=R29LKEjKJwhqKCT25ImQ7SEthhqtN5xyvf36nTZt0z9vrZetMU7MVqiIzHqXPfxM4HOR+D
	2H3q2kwhDcGJVhUP+eVZQ1gOihfdlFZjqvCx5N+R6/aYGrTkpIAYca6/WTrk/3vtK2L11X
	0vJS4WjSz8GCn65o0DWkKW2cXzKftmw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-XCMcvDk7M0yaFXPD2fGmLA-1; Fri, 01 Dec 2023 13:09:30 -0500
X-MC-Unique: XCMcvDk7M0yaFXPD2fGmLA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-50bd58e2982so1599438e87.3
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701454169; x=1702058969;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CSE51B6oGQ/hDqCz1Sb5J7ty1qTdM7cHpcMNBpbyNmw=;
        b=KnLKFJ4MZu+EDst4YV/m5sSKJ4zN6cZ52BJUhvQakwqCljEUqlelBtiG4ePIg0hSHC
         qUEjG3M0X7rT/y5VZpe0r3c3A6mjPOFvsiLOXry+nsHlM5Eahm3YXXmvfeWiKzwNn9MT
         6GcsQteDNyuovViMdNSQgNha6VNEF5lxyVhj1OqtO+0dJvFnoFVWqxVHBwKrI1JUdBVt
         rIoOEgTsM288HGUR9EbMzM1+c7OKowUbLQn5cfdIZmj3zbYfJFEW/65YLbi4mdybM6JN
         EymDJCBKnZOFAeUW55GM+35zNGiepwl9sLhJsQPXC11d5ATc81ycRXLvgs9N0nZbcwnX
         nlVw==
X-Gm-Message-State: AOJu0YzMis38nhwYZCiT1gr5r/fYulN8e2K0dJZKWBxak4PE6ItsRtUr
	WFwOTjl6X3GV+YMMrmQ6XbaK/eu+y1Z5AZF9ncu/YBnG3mqMq0Q/333TRw2IPslES0sqna9XYGg
	8YoL26XAn9/VdxHRbej3Sy/WQhk6d8uzc
X-Received: by 2002:ac2:5ede:0:b0:50b:e06d:cf06 with SMTP id d30-20020ac25ede000000b0050be06dcf06mr290904lfq.16.1701454168771;
        Fri, 01 Dec 2023 10:09:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqvvSqlqXi2oJyv96uJtimdlReSFI8vOVAKNb2Ru8lAi53uGllBjzrZcTIFrgkPujj95pFb5OGXwFPvnf5SdU=
X-Received: by 2002:ac2:5ede:0:b0:50b:e06d:cf06 with SMTP id
 d30-20020ac25ede000000b0050be06dcf06mr290892lfq.16.1701454168468; Fri, 01 Dec
 2023 10:09:28 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 Dec 2023 10:09:27 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20231201175015.214214-1-pctammela@mojatatu.com> <20231201175015.214214-2-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231201175015.214214-2-pctammela@mojatatu.com>
Date: Fri, 1 Dec 2023 10:09:27 -0800
Message-ID: <CALnP8ZYoDAbuga72M753yLY_-Y3OcdgfJFEGEDeB=JuXj5K7BA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] net/sched: act_api: use tcf_act_for_each_action
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"

On Fri, Dec 01, 2023 at 02:50:12PM -0300, Pedro Tammela wrote:
> Use the auxiliary macro tcf_act_for_each_action in all the
> functions that expect a contiguous action array
>
> Suggested-by: Marcelo Ricardo Leitner <mleitner@redhat.com>

(I should update the email mapping..)

> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>

Acked-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


