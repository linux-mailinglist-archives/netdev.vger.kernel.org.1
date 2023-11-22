Return-Path: <netdev+bounces-49952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2107F40C0
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB5428176A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF551CF91;
	Wed, 22 Nov 2023 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2USlBd7e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8486E12A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:01:00 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so10467a12.0
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 01:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700643659; x=1701248459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABV1J4yixoaN0GqjjkN8Tqn3Z/fTq8yc53hqxgSMBI4=;
        b=2USlBd7eFfttCbF9EfYY9RVH1jJ6jlQULqGnZjL6gXIbc5Ssok9vOsAd94zG0GdtcP
         afYWmKPcT3mbKwP3gL/VpP9fZTeh3H1xdqDdmVvb40sBOb/Y38rhNRkLOUi9kaOcM4BP
         ADnYUgMU1q9+HiM9H2NPTJwSYexolFCe71jc0psIn59Zyo9RrgfC39Gqg1ukZuqKLP34
         kTAReZlbpOwK1jkUMgCqYoSeRuNK2hThj3g3gs/xo4BDJp0BE6JHJUF1xaQgHK6GaQks
         j9egRkhUJ5Hs5n9R8k+5YWml++sLJBahfRMUdYB9IYlLfxA3whHpURQ6/edP0V4RPfFj
         wQLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700643659; x=1701248459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ABV1J4yixoaN0GqjjkN8Tqn3Z/fTq8yc53hqxgSMBI4=;
        b=g+2vKJtqAIkFV04JN3ZDEFgstr+U1VdU8exQFlQTAIAJuhmXZWAjBB+z2ccWidkGs8
         FJ3zxIFsUr9wdfcyMJdS12UOlSHHp+rBTYXHe5diobxx/ndGEtnzSMNKlvZ2HLf/rAln
         S+GGDwfcrmpFEDvzNFXV0EEnj97V+R0jRIf9cQfdZcJ8klVw2Sp7cwDdpJ/b+b4jNj5I
         Ydlf69v2NsVNCb00F1q9yRWoUS2dKzJwhJUHuafNzslxCY8aCyrek12XP0PXrK0xfZuY
         mKT52o7rkLLt4XsRwUA0pwjL8M74r4Xpz3iE/wc9koTIIpUAeaUxNMMggTi/iS3QJIhl
         eMAw==
X-Gm-Message-State: AOJu0YycZBJvpxzijcub0U27/IsnB9LxEzcbsCKDmTvmGWn8Kf802+8o
	JO2IJJVa4TOthHQaZdMQU0v5GnRg8nWgTtU9NZ8Uuw==
X-Google-Smtp-Source: AGHT+IFMErANbc8PS/r+60jgzBuPXGfOs3HJFa0nz3iP4Hu94MhiuwmcrfezJbkExV30ghmdo8A2mA0cyJfhkD4+tWA=
X-Received: by 2002:a05:6402:3222:b0:548:b26f:9980 with SMTP id
 g34-20020a056402322200b00548b26f9980mr79592eda.5.1700643658748; Wed, 22 Nov
 2023 01:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-7-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-7-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 10:00:44 +0100
Message-ID: <CANn89iLpTsZP1KAb_7iD03KSynFu=03CYF=2-YeNb+AjnrMXWA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 06/13] net: page_pool: add nlspec for basic
 access to page pools
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Add a Netlink spec in YAML for getting very basic information
> about page pools.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

