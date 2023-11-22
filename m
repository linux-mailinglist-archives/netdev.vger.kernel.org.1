Return-Path: <netdev+bounces-49951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC827F40B8
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 09:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FAD28177C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213C821A1A;
	Wed, 22 Nov 2023 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h8HLCdFJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575E3F4
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 00:59:32 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-548db776f6cso7173a12.1
        for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 00:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700643571; x=1701248371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+SSbvRNhE8a4auSwwENaH3lU26s4efw+v1c4QvqfF8=;
        b=h8HLCdFJ7jgAxEclogPzt32Y0NpmsBj+6KsNcOm4nuvMD/SG5RqCffrAyVZLkVWe8M
         IyQK4UxWrVzL58jtRZoe8yQHx8lRCmPXJqOC3Rt0x1Cn7hYGRYrVE1yq0a3Tpafr4mHI
         JnopTDknx4/xfvyMtNE9msw+MIydgDGgE86N7HzpJCcefu0v8okH/xljv6doRilz7Lz5
         +IrEHsjoOxZfVXeN4+hsP+ef20hTI6b7t+14t7FGMLFZJgn8ybKFrYzAdYiQdg8J3tQI
         GkLHGxU8rK/DFTol1uenRlyI1x/cIdS494qTmxlb3vU5iL1o2klluWaigrB3ln/CzTu1
         7RWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700643571; x=1701248371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+SSbvRNhE8a4auSwwENaH3lU26s4efw+v1c4QvqfF8=;
        b=GN9GFSTvnFv90qL8XVfZ8nsvP+gfFhNwkq+NckSLn6BQM1E4N2DmnRMFJScnvp9dze
         RFt104C+fD4eOQ9msX5WhhcWgOBwbkpf8gCrxGX/3P6xFj3GPTCgnHIJReBncZTRDElO
         cuk758Cd7/lmcYL5ziErj0sbfoZiPSC0/1oQWBsXUcLjVy6BpSSrN5lYLeBuXg5YxfHt
         NdI/o+qfg0VEfp0LZr31+G79+cIM1TAjvm0g02NwGao5w35npBE5QfloZ9mK+6tatj9j
         uS7I3PoPlk5LujClYjHgFjqoPRyJuQjDI14gNtefXdQ9QKT0KUc3iJT83hzun5qEFiFM
         f5fQ==
X-Gm-Message-State: AOJu0YxOFUEg3x7n8LBnFUcZja63ppShXnWhU0Hj0qyt8kbwr//xDMFv
	NSPvKxsj9y+1TWNqAVuRnr/mim/6JsFnfxtjvEHtJA==
X-Google-Smtp-Source: AGHT+IER5HLrAkuHbMCyatGlR1O8cjW4Mqgts2ZJI42a1bwC+XDgbyVGAHKpqNKufhR+wMy9VylZF2moP40wVUp482M=
X-Received: by 2002:a05:6402:27cd:b0:547:e5b:6e17 with SMTP id
 c13-20020a05640227cd00b005470e5b6e17mr135549ede.2.1700643570626; Wed, 22 Nov
 2023 00:59:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231122034420.1158898-1-kuba@kernel.org> <20231122034420.1158898-6-kuba@kernel.org>
In-Reply-To: <20231122034420.1158898-6-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Nov 2023 09:59:17 +0100
Message-ID: <CANn89iKum0VL+L_iHdncZT7F+ROfrE3zQzeeyi_5XzMoQobVUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 05/13] eth: link netdev to page_pools in drivers
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	almasrymina@google.com, hawk@kernel.org, ilias.apalodimas@linaro.org, 
	dsahern@gmail.com, dtatulea@nvidia.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 4:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Link page pool instances to netdev for the drivers which
> already link to NAPI. Unless the driver is doing something
> very weird per-NAPI should imply per-netdev.
>
> Add netsec as well, Ilias indicates that it fits the mold.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

