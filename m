Return-Path: <netdev+bounces-57244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF75E812893
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 07:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644F11F21025
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED32D296;
	Thu, 14 Dec 2023 06:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmlWytzq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B2A19AF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 22:51:42 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-551ee7d5214so559491a12.0
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 22:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702536700; x=1703141500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHsxzvl396B9TsbSvTEJt3J2hBdAgjNAT8bOMCH4v2w=;
        b=QmlWytzqVq06JId4vvsAOd+KdSEMS5c/WnxMvozmd9Zc/rUYhH8nxf4/SprTqo/PAa
         FMril3eTCi3P/YNopFkbvrEvvzTmEVc/LTb3Flt3HTnYp4rAMqQZpdWE8/41UgnH91RF
         X/P0hv+qANB63ijvGrWatEI9eOLQvo1NcYunqeaaTHFkm5Cj7IXU0tdS/RKS+TnHNT+j
         92ATNsZ4ep7rG4CifKFxkThBmoou2WoJA6OQ8U8VntHiRJd5RoFUvOkFIluDSiREftNY
         k2/pMlonAvWFk2Y+ADnAA4unKBQ9qZuuns4eDTaOGv17odY/u+Of9a7H+hVaZtA0EKgU
         Wd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702536700; x=1703141500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHsxzvl396B9TsbSvTEJt3J2hBdAgjNAT8bOMCH4v2w=;
        b=v8PoigVrUiYi4qCCWPRVtChDhN5ZyC58J3HqpmM5LVmSzjSDYMvep4GGU9O51na/kL
         ljSkfffaTsEBZ14oVrbeR4/sfiyd/aQSFvlB4Ne5M5HbyrKI0oovSk5P6NeptcfJnvrK
         8CsOODdHYI2/3VSXhKzTUy+h7ijGpaWe2JfL9NSWjfX2IvB2AdSUNVTIiNvBEqzQQu11
         bYQ9V+CQ3xZaEoQipK5aFCuClqAwce5+McEilwdjjOojSlwhbI3bKuIAQYGSE5Z3/8d6
         XTVkodsBwaiFpDrD5xyX3umjId8Ca3TyHTtHocIbzlqbjQo2MIXZcRcIz6hkHUGZbTI4
         KP0w==
X-Gm-Message-State: AOJu0YyXWEbtLrGhN3Lm8YfGHkZC/IjG9SU/yGcoDZIX3xgbGXgG3Kbc
	kX0MOjdBQygJGe9b6CJeiFZakdMA8JvaiyrlRcaSVg==
X-Google-Smtp-Source: AGHT+IFhKjoYARnFGO13ApN7eSk09nSCJTSeKyT66yoX39zQ2bSsEmHScKXeMW+UKEwtUalYt70IEOQCcn29bH3NZ24=
X-Received: by 2002:a17:906:5197:b0:9ee:295:5693 with SMTP id
 y23-20020a170906519700b009ee02955693mr8600960ejk.7.1702536700141; Wed, 13 Dec
 2023 22:51:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <170253482786.28524.10625748175644260187.git-patchwork-notify@kernel.org> <ZXqlWT2JYg0sa7IF@infradead.org>
In-Reply-To: <ZXqlWT2JYg0sa7IF@infradead.org>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 13 Dec 2023 22:51:25 -0800
Message-ID: <CAHS8izNCvxuTsKV73oTu3xS7ZVr0riBdYGbKnsHptVe_e-t5MQ@mail.gmail.com>
Subject: Re: [net-next v1 00/16] Device Memory TCP
To: Christoph Hellwig <hch@infradead.org>
Cc: patchwork-bot+netdevbpf@kernel.org, shailend@google.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	corbet@lwn.net, jeroendb@google.com, pkaligineedi@google.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, arnd@arndb.de, dsahern@kernel.org, 
	willemdebruijn.kernel@gmail.com, shuah@kernel.org, sumit.semwal@linaro.org, 
	christian.koenig@amd.com, linyunsheng@huawei.com, hramamurthy@google.com, 
	shakeelb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 10:49=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Thu, Dec 14, 2023 at 06:20:27AM +0000, patchwork-bot+netdevbpf@kernel.=
org wrote:
> > Hello:
> >
> > This series was applied to netdev/net-next.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
>
> Umm, this is still very broken in intraction with other subsystems.
> Please don't push ahead so quickly.
>

The bot is just a bit optimistic. Only this first patch was applied.
It does not interact with other subsystems.

  - [net-next,v1,01/16] net: page_pool: factor out releasing DMA from
releasing the page

--=20
Thanks,
Mina

