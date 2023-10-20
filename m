Return-Path: <netdev+bounces-43034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0297D1113
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 15:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089E31C20D6B
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86631CF9E;
	Fri, 20 Oct 2023 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WQ7bkNPN"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED601CF9B
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:57:24 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FD8D53
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:57:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so1161262a12.2
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1697810241; x=1698415041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VBEOcHttaIcP/pxR3LNkSah4DuVLoNv+g8kB+GAwIHU=;
        b=WQ7bkNPN4sMRlqOT+c7seM+fMuJFPrXJfz53yTT//0ci+WEV64RGQAzNWwMf/2Lsqb
         eCRvHDUjMAqV0DGcSoWawXwm22MgRDb+wom6TIbsBq/HbzV6Om4CBQogyjS7jclGPKLr
         Gdjx9A7r+posdNQR9M5DVR9C8qeV8ANp75DmW8plEHecuf+BSp6MyMvIRlVuTmzlWxa/
         tyV6+Ye9/iWXa3kfn7sTx2LOEGKhzBWl76knDaQ2w019FnP/k+aanKpffROOxMA9Zg0m
         KpRLrkE1IAa8i0KwTNvPNa6LmO2tdiwrMUZaESo/PXFfK3KvY9XQKg5NGErH5qV0w28M
         7C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697810241; x=1698415041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VBEOcHttaIcP/pxR3LNkSah4DuVLoNv+g8kB+GAwIHU=;
        b=HYnjGcRAOEB1UqfMKkizRo+v01sMLtGnUEYqhZnVkC2OwxQiXa3f15l+gQ9/UlDq3+
         ZFVJggaQCTJkCfnC6sp9feWfIxxcxxR2h1G+HNZ3nTeNdhg3nYvnKhdRNxVauif2WKe4
         i5yu4aq6g9+kr0faGSmNBOmxuQBkJFMh+zq5U1tEzTv8EpVbf4//c14r8HOj2OjjWsgT
         qlpigoJ5Gts+YMEgUw9ehzut/Fma4kD7tqFv1SUpn833vO0P97qLZdgxjLhR9dC9LTKz
         oas1DYwHPVesNFOOJVetgDrfDXhbUoWsB4upbxyUusjYtNdaWgWFAIJwFJ/e4nBu81cM
         /nDw==
X-Gm-Message-State: AOJu0YwrGL4ig3pQqd3R4osloguoP8f+q6/NVY8blRWHlKLJ3gaCo8Ba
	WQHRKsXSP7KiTaz0X1xPqPettLcttQi8jp8+flnrIA==
X-Google-Smtp-Source: AGHT+IGP32Vs6LhSO5Q+dFeyM+jo7MvJ9Do6f3Utqc/r3xR+RomnORAiVakOBNSyJSpezxCesfkyCNRViMFSh/IfRdQ=
X-Received: by 2002:a50:d795:0:b0:53e:467c:33f1 with SMTP id
 w21-20020a50d795000000b0053e467c33f1mr1740179edi.8.1697810241480; Fri, 20 Oct
 2023 06:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1697779681.git.yan@cloudflare.com> <e721c615e22fc4d3d53bfa230d5d71462ae9c9a8.1697779681.git.yan@cloudflare.com>
 <CANn89iKU6-htPJh3YwvDEDhnVtkXgPOE+2rvzWCbKCpU25kbDw@mail.gmail.com>
 <CAO3-PbqtEPQro4wsQbaD-UbF-2RpxsVKVvs3M0X10-oE7K1LXA@mail.gmail.com>
 <CANn89iK6WE1MUdHKfNcEf=uhKXustwQ-mtC5_toVAkz=VFctgQ@mail.gmail.com> <20231020100055.GC9493@breakpoint.cc>
In-Reply-To: <20231020100055.GC9493@breakpoint.cc>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 20 Oct 2023 08:57:10 -0500
Message-ID: <CAO3-Pbo0N75vWNb0dtCS_47B+yM_y=m1_wjY3xS4cu_GRCw-=Q@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 1/3] ipv6: remove dst_allfrag test on ipv6 output
To: Florian Westphal <fw@strlen.de>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 5:01=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Eric Dumazet <edumazet@google.com> wrote:
> > I also noticed that iproute2 was not supporting RTAX_FEATURE_ALLFRAG,
> > so we might kill it completely ?
>
> Yes, I intentionally did not expose it in iproute2.
>
> Lets remove ALLFRAG.

I will do that in V4 later today to completely clean it up then.
Always cheerful to delete code!

Yan

