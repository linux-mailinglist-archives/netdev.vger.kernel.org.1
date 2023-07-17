Return-Path: <netdev+bounces-18356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FD47568F8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 18:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19CE1C20823
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 16:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E137CBA55;
	Mon, 17 Jul 2023 16:20:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D415CBE47
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 16:20:22 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D8130
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:20:21 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4036bd4fff1so592571cf.0
        for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 09:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689610820; x=1692202820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8oxHJ/Asor250CgEELA8bH7W3zRlQMr4L3RKOhkbvQo=;
        b=ytXeC4MWKdnfJG9MCDAnYHj+2Lw2Ah2Wcu3YE8KXGEsDgyp8SJUI9pEXdsD0gfW4xP
         6N3duw/gBKGPtLa9J+TMSBWJOLquuUcFENqVajDt8f7YmwvYVs5EvaWHXBEZUr+UEp3m
         UIEJyymAm3JQG5Wzc+mEIa/DJCrHhbuCYj29WdaDau+I4mZZ+sbmmQubL098r7vmwY6K
         ec5SGZIsL/BAC5zdZBoQ9FiRjYQqHmTck4aPpY7Vf7z0RwyA1Qhxah+7i4LLOVzu+B9J
         EAdufjUfgl74Dzq/jzgOwc1iXV4Tr4ny8vUW1h1Vi6cY2AMwypnR4sfzEQUPxkzU8aWN
         2lhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610820; x=1692202820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8oxHJ/Asor250CgEELA8bH7W3zRlQMr4L3RKOhkbvQo=;
        b=K8XwfagWyo410B0zNdTUNByk2G6psi8ucT6kXcqmd+jKtDRgH+NgPx4qNdQldYbKLb
         /sKOt3xCAw1pV9ltU9JKMmtJoWrHBup+ufA2U3ZcZWwZejkyxCREOOBvjF1UR441euUc
         sKdJmF2i8p/R8Uj4SDdt4P0/p4tKPMbUBvBT4Pc5ucil9tccCMeTyRQE19nMB1f/hiR9
         qfR6Jo3BjDHCXysvhvgkud9lbhVfMCPhmeHBHJobkJ2Xtet3UrlzFTK0fjebgx49RYp8
         BBqiciG6JTBN9sI/X5SccahAJ/usLYto94r1Q7EDl9c0r6dFHb5W4QAjjyiwo7oeZ1jd
         FKSQ==
X-Gm-Message-State: ABy/qLbOS0SrmXfrm80NayiwSLfyWBOhxzJGR+KfkwiPRYQzKvY2lzYg
	2qneTpvYqRiHMM2AF6KvkJSTu76Mikl7jFFikwLuDWtq/DwvpLn24n0=
X-Google-Smtp-Source: APBJJlH3dQQJPGSUtMKAzdcuRFFl1++DIL3KRTcRuGcXY4FKFfVzl/BbP9Q0a8c02rIIVsCLG3WLq7kVPBPmfwJDgjM=
X-Received: by 2002:a05:622a:394:b0:3fa:45ab:22a5 with SMTP id
 j20-20020a05622a039400b003fa45ab22a5mr1363053qtx.27.1689610820241; Mon, 17
 Jul 2023 09:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230715153605.4068066-1-idosch@nvidia.com>
In-Reply-To: <20230715153605.4068066-1-idosch@nvidia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Jul 2023 18:20:06 +0200
Message-ID: <CANn89iJKV1pAdwLQ4p2nbFhHnwLW7BH7rzU75-+sVgky5fUvbQ@mail.gmail.com>
Subject: Re: [PATCH net] vrf: Fix lockdep splat in output path
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, dsahern@kernel.org, naresh.kamboju@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 15, 2023 at 5:37=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> wr=
ote:
>
> Cited commit converted the neighbour code to use the standard RCU
> variant instead of the RCU-bh variant, but the VRF code still uses
> rcu_read_lock_bh() / rcu_read_unlock_bh() around the neighbour lookup
> code in its IPv4 and IPv6 output paths, resulting in lockdep splats
> [1][2]. Can be reproduced using [3].
>
> Fix by switching to rcu_read_lock() / rcu_read_unlock().

We might have other bugs like that.

We should get rid of all rcu_read_lock_bh()

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

