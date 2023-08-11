Return-Path: <netdev+bounces-26670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D83D1778871
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158A51C20E96
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABAF53A2;
	Fri, 11 Aug 2023 07:38:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3011F1FBA
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 07:38:10 +0000 (UTC)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D992727
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:38:09 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34985c13235so55205ab.1
        for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 00:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691739488; x=1692344288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mp7kRCSlIfvikEK7695n48g+cGVq8QsJ7Chmr7K+nNA=;
        b=kE35fRwUh/sKrRPEjUubS/LD5WEXLJYraLNI2dbAfKCxO/WnfjZGPrZAIuIHguHmmU
         63fjE9cItjYGzrYYDxrmyibLaK0nXmK/ORma3t8RnFMz74nxSg/aH5bT4fKHOamow8Wa
         X7LYE4LitIZyvndjsH0MM6jAel8uH+0rWSQsHz4TVd4pQjn36RuCEBd9fahXtVof96HH
         +fJMX/nDI7ILQqrZB2ZhHqbRHj2ujedXR/GmqUWZ5Z71J/esXSSBgdN+MmL15ZTOCuUv
         rdcnStayg8lH+2u2Tit5rQsr+IJGAkQ4yGdWYyg4AFPnoRS5V0cqMwczUTyT6OXx/QAK
         Oo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691739488; x=1692344288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mp7kRCSlIfvikEK7695n48g+cGVq8QsJ7Chmr7K+nNA=;
        b=M+ZdRfmh4wFmP05vdmQMHzBzz1utM4vr4703C2IXyQnvLCqrwrAr0R1C1OWl1vU29G
         yrxFs8zYPT3MHSI6KHtr6Yfvzix38MwAdcBCk8wEK0Ab5Gp/ZTWc5RWSmoWtwZw5Nu0F
         4w3ZLqaiI7LBBqW54dNrvmEvqVMw6tMU9iz4uHfj0wGeR0SqnbUpPhD6z5INAIm8w9uj
         DM9eOR9SifSOZ9qGFdDlOYX0Pq2vX3FhqbfQgSI0z9KFYgDSN66QcngkSlDaWiA4FMxD
         MzYb5mGEW73iTm1DOfvKILHdu7C3oseFwcRPkn4E/aT6l6kfaYMXGZp4mDFuxI88X3hP
         frdA==
X-Gm-Message-State: AOJu0Yw3pxicoRJ4g8oG7qX92vV8giJlzuMdQNRrFdSYN7FobQgU5/vi
	FV+5J2yZ2FKq6dpe0lZRA3kKnvW99JsWCDL/+QEJ4A==
X-Google-Smtp-Source: AGHT+IH6cWpVxUvS/TQH2xvZpOPgIVeaOVMW5AG5Emna53aIOtl2qGpFEfloNijflVCVOSMAUmwtvaa2X1iIuan2NdI=
X-Received: by 2002:a05:6e02:1609:b0:340:502b:1487 with SMTP id
 t9-20020a056e02160900b00340502b1487mr201180ilu.12.1691739488354; Fri, 11 Aug
 2023 00:38:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811025530.3510703-1-imagedong@tencent.com> <20230811025530.3510703-3-imagedong@tencent.com>
In-Reply-To: <20230811025530.3510703-3-imagedong@tencent.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Aug 2023 09:37:56 +0200
Message-ID: <CANn89iL_ajkpP3AX26Eieevp4ZwVUCfbVX8Xge-Bc9G3SfBdcA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 2/4] net: tcp: allow zero-window ACK update
 the window
To: menglong8.dong@gmail.com
Cc: ncardwell@google.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, flyingpeng@tencent.com, 
	Menglong Dong <imagedong@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 5:01=E2=80=AFAM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> Fow now, an ACK can update the window in following case, according to
> the tcp_may_update_window():
>
> 1. the ACK acknowledged new data
> 2. the ACK has new data
> 3. the ACK expand the window and the seq of it is valid
>
> Now, we allow the ACK update the window if the window is 0, and the
> seq/ack of it is valid. This is for the case that the receiver replies
> an zero-window ACK when it is under memory stress and can't queue the new
> data.
>
> Signed-off-by: Menglong Dong <imagedong@tencent.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

