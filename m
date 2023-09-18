Return-Path: <netdev+bounces-34710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293857A5346
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 21:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 291261C20BEC
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 19:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584BD27EC4;
	Mon, 18 Sep 2023 19:50:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A225273E1
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:50:20 +0000 (UTC)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BE38F
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:50:19 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-41513d2cca7so85251cf.0
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695066618; x=1695671418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rvWtiKFlK82u2LKHKuUKsMb7Ahvcy4qqgwFLIOgqOE=;
        b=tA81WjK8ILUFRFNbyPbw8S26a/oHZSWwqEvMiAksd41ykpCfg8WxQn9FlYNwy/5/c+
         o868sUm0iIMLsb/RIF9R6HBEKiWHaPid1DN3qtDtdnUYQONYkM3QoL0ZgtfQHnwmDUEt
         KHuB96a0u7h9etSKXQaUfXEgv2f83FQ055G4K9N7ziRBfRbieu0fXkkikbBul0dBCJ+3
         N6jmC/ga/pYgbEzC1LW/7wN2ukR4M/SrwsOP5u5etErhHHMS2A83lyg0bNQ3he24OGZK
         XpjuKSpA9Sb2Cn47yZKA6O+HBDtCkrg0ovdygX7Idp5u9GcM2A75baQDlljvzEM+w7Xn
         Vb8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695066618; x=1695671418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rvWtiKFlK82u2LKHKuUKsMb7Ahvcy4qqgwFLIOgqOE=;
        b=Lqty1MczsNdWMTQp26YFAqY51QMph4/gmtUeghqOn9Ys5QltmhxDuyQ03IRf3X538g
         sGFcP3McTsks83tINXJ8iLBJautBxkrgP29BlOhWa5re5dRahNPeiGF93ADDgRzcEVy2
         PgobDc/U/vpSrdtyFpxAVw0O9L1p3sloYVisXOj22bgsXhvLdqmcU1NN/F3lYoiDsO9T
         09l4qldyyf+hUu2JVFF0ksKYKmpjo5H/l8PrLiwWHOzHGtDcuM0Tv4GDFAlzbST+9/KS
         KKY9Ty7VgXbdSgeQ0WoArfy7BEVsC7y7TLmvKyWwaiqG2aufGxpDQfBewXMr/a5K+27P
         NfEg==
X-Gm-Message-State: AOJu0YzvMeY6YJemxyp4Gxr0XOgKeTwKLnIkOKNrtXz0ZINJl0vzmcgs
	LNCUH/YQ/aXzcdWonPoXmC3SjY88qH4pC4gnDo921A==
X-Google-Smtp-Source: AGHT+IFDmk4fUZ7vz5IUOYeqlZ/EevEHVyoljp4NOvoOjiwbxDV1PWynKYaMlFP2MvCbEhwmoTcjhWCuE7wkXyM1cko=
X-Received: by 2002:a05:622a:4292:b0:417:944a:bcb2 with SMTP id
 cr18-20020a05622a429200b00417944abcb2mr30680qtb.13.1695066617843; Mon, 18 Sep
 2023 12:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916010625.2771731-1-lixiaoyan@google.com> <20230916010625.2771731-5-lixiaoyan@google.com>
In-Reply-To: <20230916010625.2771731-5-lixiaoyan@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 18 Sep 2023 21:50:04 +0200
Message-ID: <CANn89iLhckhKv0tF4P_hFy-z1ZNTnHKP+vsb0xGPMfrk2Y=kUQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 4/5] net-device: reorganize net_device fast
 path variables
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Mubashir Adnan Qureshi <mubashirq@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 3:06=E2=80=AFAM Coco Li <lixiaoyan@google.com> wrot=
e:
>
> Reorganize fast path variables on tx-txrx-rx order
> Fastpath variables end after npinfo.
>
> Below data generated with pahole on x86 architecture.
>
> Fast path variables span cache lines before change: 12
> Fast path variables span cache lines after change: 4
>
> Tested:
> Built and installed.

Please remove these two lines.

Of course, patches are built and boot-tested, this should not have to
be stated in the changelog

>
> Signed-off-by: Coco Li <lixiaoyan@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> ---
>

