Return-Path: <netdev+bounces-43911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFA57D54B2
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 17:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3703B20DEC
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D892AB5E;
	Tue, 24 Oct 2023 15:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1WUcBoE5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8760213FED
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 15:08:36 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA42210D4
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 08:08:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so14890a12.0
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698160113; x=1698764913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AN6NTJXQ2pnokdJ55KzUK3vWFKSJONMYwiEEr9XTwTo=;
        b=1WUcBoE5jAg/WuQLxIaaSUMuDWqFijh5KSJJ45vJIyqtDyB07oQ/4NtAU18VhC/p83
         VpOiWXHcOqWWZqo0OuppQNa5PzD+0DxKl5sZHRHHtFTXiNAFfIu9dCMzqNjmoTSS/SWn
         o3IAEuEF6QXneU6odsbyEkZIq9ALN3c8QVdjWhVZzECxYgVfiLvVjQ2JFfDA47kT/mxW
         awtvQNEFcpkNg6OQ1Ughwjvyr5dzB2/IyjQbv7I+ctoSiB9NOIPBGacqMZoupGFsFUWd
         Sklc6tS2O+idM8PPE1gBb7n793FDCfWiaGuSsOvXkMk+n1smRJAUlg5S4aq7hnxt8Y/M
         NpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698160113; x=1698764913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AN6NTJXQ2pnokdJ55KzUK3vWFKSJONMYwiEEr9XTwTo=;
        b=qnjHGT510LQ2BcMOvq1fY4r04EIgTZHW5sneieeT4YyDTCSr6tha01GHKDhbbV81xv
         +I9Ft9pmcsXuXopGkURPsDmV06qfRGv03bWqz/L+kMeliW+rKLSPfHydqh32XEqaXKXM
         URNQn7ZODYuYxVMz6v8z76XqK/bEkFinrJl3Yw7z2WV2amXbgrE4WqVap0r7IJbdCfa9
         ummgYYt+LdKlVZxeVet9VSkXhA4gBXvnXA+q4LWYpj3Dp+VaBTQ74PnTA+8Yr1eRpt9N
         JHCA5XBgEjkHGMcdBYJRqdDG67PEKJWESAhHPbLFPZ149ptLp7+RbhJ93ASe6b9Yhz5y
         roIA==
X-Gm-Message-State: AOJu0YwXsVtsRoGBZ02vZGg7ckc5/X+SXDu9AG9sEeaRfXbvFPi2VIEu
	zssI+HbYgKmUYoChRHs2NVIcnBrUKZTjRCUp4GZ6Fw==
X-Google-Smtp-Source: AGHT+IGDaQwq8PYlqMHnqY7xaD7BvFZBeaYTGKJoUNgOrP7VfmW9tZsV9kzPV1QQiiG7hgxsqnwAs4uvuzS5I3CUNYY=
X-Received: by 2002:a05:6402:241b:b0:540:9fd2:f831 with SMTP id
 t27-20020a056402241b00b005409fd2f831mr126967eda.3.1698160112944; Tue, 24 Oct
 2023 08:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698156966.git.yan@cloudflare.com> <0e1d4599f858e2becff5c4fe0b5f843236bc3fe8.1698156966.git.yan@cloudflare.com>
In-Reply-To: <0e1d4599f858e2becff5c4fe0b5f843236bc3fe8.1698156966.git.yan@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 24 Oct 2023 17:08:18 +0200
Message-ID: <CANn89iK+ektbs1Db=z4+O89HaOLVLK3NbXisWuyLxXQHcpJoNg@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 2/3] ipv6: refactor ip6_finish_output for GSO handling
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Aya Levin <ayal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Florian Westphal <fw@strlen.de>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 4:26=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> Separate GSO and non-GSO packets handling to make the logic cleaner. For
> GSO packets, frag_max_size check can be omitted because it is only
> useful for packets defragmented by netfilter hooks. Both local output
> and GRO logic won't produce GSO packets when defragment is needed. This
> also mirrors what IPv4 side code is doing.
>
> Suggested-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

