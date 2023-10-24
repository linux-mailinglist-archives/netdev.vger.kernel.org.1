Return-Path: <netdev+bounces-43903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17967D5407
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 16:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E5CB20F32
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E522E621;
	Tue, 24 Oct 2023 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UhOO9upf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B8C11732
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 14:29:09 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A52118
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:29:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507ac66a969so6115952e87.3
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698157746; x=1698762546; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VF7d4jMMf4MfKI2w84pu3BWkSz+khKl3I43eAdPZFH8=;
        b=UhOO9upf6IAiAOqwTt0PZlCNflI6+1EIhpxFEmTr4ZJCUxAljvIKouDj0GVqyUUELG
         WzLznNZ353OvKc5GSC8ZuP1VQmdZedx+QagiPGqKlNC0ognqirbuoeTgW/X40xZ8eOoG
         1l4Ahv/EAGIbi2RArCMSsHFRkUF/Mw2H5NqJxDkTJDC1K3oDxcmYQtF1OVVqQ5BNCNCN
         P3F7Zyzd4F1UPHpW8+zLHkuucOygd/4oG4XY8epIVMU9gxhq1y8mK8ZLHBFPTFSyZFK9
         ABYu0aUEb1RroAHgw3W5l3oMnFIzpPxQRiZwG5ivuIeLm+lKkqoKZbUshttmTRcR+Ur0
         hnIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698157746; x=1698762546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VF7d4jMMf4MfKI2w84pu3BWkSz+khKl3I43eAdPZFH8=;
        b=MJ6O8hb67tVzhvu5I+q9UpztoUdGSs6ZAOr6D3jIydb5qu7x8NKUe/vod8Jm5poUO3
         eRM8YV5rDOGgjYf1ohsgRmw5k/Dwu+iWnP3J9qLGZ31HOFXITRcEW8F5Zt3viPIltyjy
         8vGxGl6wgF53ppLLH93VWeaF0i4i5aYo/97bpg53uIC4XTx2gECssVl4f92lcExYSGyL
         QMQJ/62BAD0m3xQH4xRiKX6YikFvWdeYK7GEpAkNMiHwGC2vz1jrtDX7rImfGsUuHkgp
         CreAfiZsN3A75UTY7NI8q49Mj3TAAvrCjoMNB3nM1slppqLa+7M/vUly6doKTa661cnZ
         rgKw==
X-Gm-Message-State: AOJu0YyFP1WCEYB3ZHr9xqoYS+XI8yvIYeKKdNwGQT6Obis8RPKKI4u6
	84WsZlA/dh5HNBSom/RN2SpjsVdhRxhrQzUHRBZeOA==
X-Google-Smtp-Source: AGHT+IEaUVpLjkEPg1Gwxq89Vzp9eDheQ49NKLnoKGe7P731lBXW4hmUVsVuOnscqMEw9jdFOmoebDwqlNbVvsERRQY=
X-Received: by 2002:a19:2d5d:0:b0:507:9e6c:e165 with SMTP id
 t29-20020a192d5d000000b005079e6ce165mr7320188lft.50.1698157745751; Tue, 24
 Oct 2023 07:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698114636.git.yan@cloudflare.com> <a79fe77d7308f7e6de7a019f23a509b84cbacd79.1698114636.git.yan@cloudflare.com>
 <20231024102201.GB2255@breakpoint.cc> <CANn89iL8LfGJF2xJP0JhW7sMUXiMdJGAe7jhL0XW3pVMG7cmkw@mail.gmail.com>
In-Reply-To: <CANn89iL8LfGJF2xJP0JhW7sMUXiMdJGAe7jhL0XW3pVMG7cmkw@mail.gmail.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Tue, 24 Oct 2023 09:28:54 -0500
Message-ID: <CAO3-Pbohogh1q=20ycPimoPaeAskcAGABvEW=YdZRg3ppRsJ3Q@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/3] ipv6: drop feature RTAX_FEATURE_ALLFRAG
To: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Alexander H Duyck <alexander.duyck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 5:30=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Oct 24, 2023 at 12:22=E2=80=AFPM Florian Westphal <fw@strlen.de> =
wrote:
> >
> > Yan Zhai <yan@cloudflare.com> wrote:
> > >  #define IPCORK_OPT   1       /* ip-options has been held in ipcork.o=
pt */
> > > -#define IPCORK_ALLFRAG       2       /* always fragment (for ipv6 fo=
r now) */
> > > +#define IPCORK_ALLFRAG       2       /* (unused) always fragment (fo=
r ipv6 for now) */
> >
> > Nit: Why not remove the ALLFRAG define as well?
>
> I agree, this is not exposed to user space and should be deleted.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> >
> > Otherwise the series looks good to me, thanks!
> >
> > Reviewed-by: Florian Westphal <fw@strlen.de>
> >

I thought there was some convention of not deleting macros. I sent a
V5 to fix this up (not sure if it is the right approach to go) and
carried your review-by tags over since it's just a small change.
Appreciate if there are any more suggestions there.

thanks
Yan

