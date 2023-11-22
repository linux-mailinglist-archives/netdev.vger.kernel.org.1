Return-Path: <netdev+bounces-50171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5467F4C35
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416391C2088A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361BA5788D;
	Wed, 22 Nov 2023 16:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X2fIIR+I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BC9A2
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:20:44 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so18094a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700670043; x=1701274843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIZ2EXNG5d1escopf0e3DUzOJWd8CNwt2/MDcWNMT10=;
        b=X2fIIR+IlLEnSGrYyU1rHqZub4RaVgJlxTwizB8wqTS5BkFTji8UrAKv83xYuqHn/a
         xP5Fp9EVwYzcnZ94jKm9jsIqE+shqz2MHt8W8kkLEiNBZJhSfIROf8gAL7Jl5BP1od17
         PZvPV0gUxaNr+QFnH8n+Cn6c4+U77dtntb8FKjo/lmKhwyN6ti9pJ+wbLurlz+ZOgUbT
         pC/UgXXia3Dr/Tir9mL0/2kdnORpR0HlgLyAcf7Ru4RzgsnyOkNquGk8xnc8r6fcSDwC
         dFWuZL8sjkxZSnqVZ2ky69cAErVnfR6KuX0wnfA1xeeEeYMhGT04mBydg8NiAhibda33
         pQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700670043; x=1701274843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uIZ2EXNG5d1escopf0e3DUzOJWd8CNwt2/MDcWNMT10=;
        b=tWHpX6HBWrWBHbvKgLI3sgNjEeLe6MrVnUBInxIAeoi0FE4GUygOHiZXxqVm7Jhy8e
         0/FWl9Ayphtr4ULy0Zvjzy6mQ1c2xz8RKU+RQQrScb3kll/PYfQO0CkFCrCMdnvrlTXU
         tLqgBi+P8rXbxJCzqVYPMGVljUo9zZmGNle/QRWrmbGd4jfGNDdFNnP0HOh6H60ReiaT
         wTiFclKnWGSofBHztOhehsWKoi5QLvWsI8G4AU+h4Qu8QiJfqlKr4KejVbsmjDKDaBHz
         Yyw+lWfHb/cKEX871or4NsjtUGzsMOZErC93EQLibD5DkhDRSLCdKepPAzjqSI+WpZUv
         CrZQ==
X-Gm-Message-State: AOJu0YwqkpU8I5aVfbUm1ExWs9rBn76WudMuXBnqDKBcyMusGJhcoe8k
	lACabpk9t4j86+ExC89nQw+KyjhFC7fTJwEGWHU1YA==
X-Google-Smtp-Source: AGHT+IEYyVWs/N/JqcRBVAVElzD8/qtw1EvniPkV1sZHa74WNtGitXjgZ3WACzLwLNEAYVTymvYjhtRYZRpNUvoGEw0=
X-Received: by 2002:a05:6402:27cd:b0:547:e5b:6e17 with SMTP id
 c13-20020a05640227cd00b005470e5b6e17mr214471ede.2.1700670042618; Wed, 22 Nov
 2023 08:20:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-10-kuba@kernel.org>
 <CANn89i+YXf=Qnjw5HVSwTm3ySj-CK15-k14D2G_uFgmrBD7mXA@mail.gmail.com> <20231122080302.35ec94a0@kernel.org>
In-Reply-To: <20231122080302.35ec94a0@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 17:20:31 +0100
Message-ID: <CANn89i+tKrfZwB_MdY7d44_1yMW7HvNsX=Btwq-MaN9Os0Fphw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 09/13] net: page_pool: report amount of memory
 held by page pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 5:03=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 22 Nov 2023 11:16:48 +0100 Eric Dumazet wrote:
> > > +      -
> > > +        name: inflight-mem
> > > +        type: uint
> >
> > 4GB limit seems small, should not we make this 64bit right away ?
>
> Yes, uint is my magic auto-sized integer which can be either 32b or 64b
> depending on the value. See commit 374d345d9b5e and 7d4caf54d2e.

Ah, nice ;)

