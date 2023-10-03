Return-Path: <netdev+bounces-37733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC447B6DBF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 18:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id C922EB2078D
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 16:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A483714B;
	Tue,  3 Oct 2023 16:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C17C36B15
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 16:00:22 +0000 (UTC)
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F310AF
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:00:20 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-49d39f07066so493362e0c.0
        for <netdev@vger.kernel.org>; Tue, 03 Oct 2023 09:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696348819; x=1696953619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iiJX06oLsm4i4AZYQRF+M2RUFFnUmihJtl9/RtnuG0k=;
        b=jjcr6W93k1p/ibF9i3jpw+kVlgloQm5BbnHw0Qh1K6k4ea98N60k7pRsJCfRE6Nk5l
         egr5EsSkzfI5tOWaTq23UVYstNNrL505WlcHTdooxlhBEi98yBKvsoi2dfzgcWTZX1Et
         X765n2pekQqY0d9td8qMHOTv85VtsSOHZltHuD92/rVuvMGjJOsiUVJRQS2b4khLaeRE
         0ePqeJQkwV/x3jkb/T1k0Ah9oJN8s9zAMk/z8a/JAR7xA9zgxF4MThz8SYlzq0ul9HpP
         6pXn13ggutSBr5l7KuOqwK9x6g3885lWMNwHRbXRpSEmMFiaa4M3qTyyFs7nBe0eFvYQ
         qC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348819; x=1696953619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iiJX06oLsm4i4AZYQRF+M2RUFFnUmihJtl9/RtnuG0k=;
        b=adL9Rm+BqLT/LZRKbwrl9IRSPGWL4t6PxuDyWixMaEa73GA8hFIfo7767NU4hfFaMz
         skuvDcwYItc0+AAL+UZx/TdzA3bSudr0MbyNA9xxjXXJicTjXoB2umns5mr2Bw0va+JL
         E3ZCV5hA7AdoZ3SLCgYfb0T1EOTSibEraLpku5AbJBQ+HpQUhQFZt5Op4qHptpJEX5WE
         HH652oPnWAu+cYUvzrw/bll2clp8t9oXG1RLYvR4sQu4zBVh/v49jdkGpbLeGEQGUPK9
         uuqaJyjDEvLingtyWVBnxylx1j9h7ztEQhec3ESD24L3P8vBJ2CP2TvAJwtYJDm4k9pH
         jaTQ==
X-Gm-Message-State: AOJu0YzshAfsA8oDl8CYcLlY9R8/ZZIB2DFpfHAUqQ/GSjRRsgzcdtC7
	7gCk4qbrMDt2hi2vIqnPtzwbKxmYpD+4cr/JpV8oNg==
X-Google-Smtp-Source: AGHT+IFJ4jkwrc7VVNrHYuzhQConHVUJzLjo4MJSmT6r3vd/zoioOF9iS95Dh5a4ZFK70apP08t3Z9R3hYTGEOuCXZE=
X-Received: by 2002:a1f:4ac2:0:b0:496:295a:843 with SMTP id
 x185-20020a1f4ac2000000b00496295a0843mr10917341vka.13.1696348818928; Tue, 03
 Oct 2023 09:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231003153416.2479808-1-kuba@kernel.org>
In-Reply-To: <20231003153416.2479808-1-kuba@kernel.org>
From: Stanislav Fomichev <sdf@google.com>
Date: Tue, 3 Oct 2023 09:00:07 -0700
Message-ID: <CAKH8qBvbxbKNn15x2YPoG+KS=bkbB1CSJZ6DAGmUZJ6M1n5TtQ@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] ynl Makefile cleanup
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, lorenzo@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 3, 2023 at 8:34=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> While catching up on recent changes I noticed unexpected
> changes to Makefiles in YNL. Indeed they were not working
> as intended but the fixes put in place were not what I had
> in mind :)

Whoops :-[ Thank you for the cleanup!

Acked-by: Stanislav Fomichev <sdf@google.com>


> Jakub Kicinski (3):
>   ynl: netdev: drop unnecessary enum-as-flags
>   tools: ynl: don't regen on every make
>   tools: ynl: use uAPI include magic for samples
>
>  Documentation/netlink/specs/netdev.yaml | 2 --
>  tools/net/ynl/Makefile                  | 1 -
>  tools/net/ynl/generated/Makefile        | 2 +-
>  tools/net/ynl/samples/Makefile          | 5 ++++-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> --
> 2.41.0
>

