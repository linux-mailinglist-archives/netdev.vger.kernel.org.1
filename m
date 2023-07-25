Return-Path: <netdev+bounces-21045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A81C7623E8
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 22:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8710D1C20FE9
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131D26B3A;
	Tue, 25 Jul 2023 20:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9921F188
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 20:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B22CC433C8
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690318198;
	bh=RBpYhLccW2CefnBFJ+wTiN+uaRL2kn7HYe76Xth/w7s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EinfN0VIbnRrVW9L5GZgkALHzVTOKLuaRPdqUnXjgYscLbxOpCsptg0nL/oGls03i
	 cajaAHbVBaW1aZJYKSBWaAfTLQixGoUKyQAdu0QoOP1QoKhEalWSn9/oUf1CddnrgL
	 c2S6TMIPd9q2A00ShMrTAQoacpk4udDy1vR5661kIMVthn0IRjTvvrDgkL5cQHbpvz
	 UjI1/FilWljrD37WM0Dt/T3Q4UGsdkZ5iS0esbabMAxjwvm39kqktWicVNHSa2+g0m
	 pWWNEpcvvD1OexfJiHHSvszq9qkpjIOCpXruGVROK7sjyolF2wiSWeoVNs0u8VyXo2
	 3qQQSEBTULyVQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-9936b3d0286so1028151366b.0
        for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 13:49:58 -0700 (PDT)
X-Gm-Message-State: ABy/qLYEcMKnrNtPsT9eFpEeMGnB0g3GSXCq7FWsjbDXDw/gd14MaM3U
	M06v0MSEVRamEj1NeqDi/AA6QvPaNz2jbqSSYcE=
X-Google-Smtp-Source: APBJJlH/mOB7hHxCNFtB4CJ8vvH7X0jetEFYgsHh+wn2l9dURNz+rh8bjDLkl4wUxR1y44VaUbuPggJG239nRMaiJXI=
X-Received: by 2002:a17:906:11a:b0:991:fef4:bb9 with SMTP id
 26-20020a170906011a00b00991fef40bb9mr13847968eje.58.1690318196724; Tue, 25
 Jul 2023 13:49:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230717144621.22870-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230717144621.22870-1-ruc_gongyuanjun@163.com>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 25 Jul 2023 15:49:16 -0500
X-Gmail-Original-Message-ID: <CAOZdJXWi1aaVWY=R5pg_CTNujir-beEM_jXE+mKOfxNTaFCSMA@mail.gmail.com>
Message-ID: <CAOZdJXWi1aaVWY=R5pg_CTNujir-beEM_jXE+mKOfxNTaFCSMA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drivers: net: fix return value check in emac_tso_csum()
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Timur Tabi <timur@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 17, 2023 at 10:02=E2=80=AFAM Yuanjun Gong <ruc_gongyuanjun@163.=
com> wrote:
>
> in emac_tso_csum(), return an error code if an unexpected value
> is returned by pskb_trim().
>
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>

Acked-by: Timur Tabi <timur@kernel.org>

