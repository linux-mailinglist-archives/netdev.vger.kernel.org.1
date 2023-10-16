Return-Path: <netdev+bounces-41420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4B57CAE34
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C0328115A
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452662E62C;
	Mon, 16 Oct 2023 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/1x9O/Y"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E405D2C87F
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 15:51:41 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2FBAB
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 08:51:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9c496c114so300045ad.0
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 08:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697471500; x=1698076300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFeXmQZfEkNQkEz1U5GC4L95YIPIbK2MUFvggu/UIEk=;
        b=p/1x9O/YlsD0FLMxDWPgXcot6xiK2+thKKgxFClxTLnaM7PFDb6N6Oy3FU4Uhw3fZp
         z/HgNPrOyic3n0BvBOrAtHpGSvHEI7SgX6lw2bejeMHisnsP/O1q8T2KuCvgKyMXr6bc
         zLX5R6T75rzriEs9wkFa/a9CTWRI1rPwe+D9JsdtCb1rVbkQGmCjsO9xWFHfSIX82H21
         yo4FmVsoBP7iSJ9cvhUSX9DI0CrpnGG/arUy88jOFznalYKZ9uGiF3EStsWflLgDVnU5
         iVPIP/9ysDdM89rNF//+iQPqborWA4dRpQf7GgpktZZv8DuG5GTpmhpYejS7a8xKL7vf
         aFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697471500; x=1698076300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFeXmQZfEkNQkEz1U5GC4L95YIPIbK2MUFvggu/UIEk=;
        b=Ca2L9tpUD6GSGPerZxKicemANXAILK/9Z4eSPAWmWmdAQfLA4+64xmze13miWe8HeH
         g2y14nkxrdcngdgM7s7za+Z4vdb1MwfF1/4aqVajwU7v8lQV523PUY8igAa+/YUSkHOe
         oOpKSUXOGQZb74KxzY0lv0JHOBa+5bk5Qf626ZYvnZXvlry+Et29FOyhonBVSycTuNNO
         K/E/HUZLD8QNJPcmRbQwwB7tlD+wcGPAbjZTz1s5AQmjJ9bBJz1heAvK6Iqjm2APQbLt
         oxMpfkcCQ0t4oywV/DYCESm9fbN425tnVQwq1mrqfjk7U1JtIV4jmxCopcA8r7G85I1e
         /bkg==
X-Gm-Message-State: AOJu0YzNV9o7+UHZ2e956npuhsWkOrf73RYw3ZWTJURgpe5KJ5ALj/jK
	zNThclwWqqYDByG7SzPpBCK9ynp3Cxv0MUhUccX4lA==
X-Google-Smtp-Source: AGHT+IEmvWfb9yBVNL5GED+BdBq0lbt0TdRkDME7jWGP5D5U9iMQ+561vIu2zwSpQG5s6plvxRrcIBLJ8Ij9QA/YrAU=
X-Received: by 2002:a17:903:40c1:b0:1b8:9551:de55 with SMTP id
 t1-20020a17090340c100b001b89551de55mr321115pld.26.1697471499608; Mon, 16 Oct
 2023 08:51:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016132812.63703-1-wuyun.abel@bytedance.com> <20231016132812.63703-2-wuyun.abel@bytedance.com>
In-Reply-To: <20231016132812.63703-2-wuyun.abel@bytedance.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Mon, 16 Oct 2023 08:51:28 -0700
Message-ID: <CALvZod5uy476CBNoxcUUsH4W9Yc7Oqg4yUM9gNK=fKRs_bqidA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] sock: Doc behaviors for pressure heurisitics
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 6:28=E2=80=AFAM Abel Wu <wuyun.abel@bytedance.com> =
wrote:
>
> There are now two accounting infrastructures for skmem, while the
> heuristics in __sk_mem_raise_allocated() were actually introduced
> before memcg was born.
>
> Add some comments to clarify whether they can be applied to both
> infrastructures or not.
>
> Suggested-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>

Acked-by: Shakeel Butt <shakeelb@google.com>

