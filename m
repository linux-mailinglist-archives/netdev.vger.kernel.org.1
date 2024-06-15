Return-Path: <netdev+bounces-103758-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2985909580
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 04:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881EE283DD6
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 02:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF320173;
	Sat, 15 Jun 2024 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi2P9ohi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB691FB4
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718416994; cv=none; b=thVBEhg3L2jR2eJqM60lY1S9v9M4+T+bt4Qhp39bfSib6VBlVgpYsins1ftyYHKsgCUydwpVetwTolJLZLA6IpETGfHlDyWnM2zvBsio+BJyW0LYqfODDhkSDtmsKezehsnDvoJZvN2LsEOdTzwH8FeaeaMVj3nnbP0RgxaY3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718416994; c=relaxed/simple;
	bh=IVlG8JsvYX0rSA3/+rx1uuRiTXclv219zl1d6jltyoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HT2MrCbDWdca2tpreTaTduSBGnGqud6A73G26CtC24ZZz7hXLKh5lfeDuAXE2ZGdidSwDry2sUWzbw079YvQ2puZUA/c3iqpTMRsrxt7UMvKkWL8toowTb/ll9wrMLuWOzysqoRLEe68GAonyFV02tcUhkfpY+apcJUhQzhrLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi2P9ohi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC19AC2BD10;
	Sat, 15 Jun 2024 02:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718416994;
	bh=IVlG8JsvYX0rSA3/+rx1uuRiTXclv219zl1d6jltyoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bi2P9ohir6MLOtSEDxa0pe+IFFVuDpe/GKbr002GTtDXsveJpI9ZZqc2vPr4+uZwg
	 2yzJ8pSfigKCaG+hQ9+/tmaEsYCYW0Rjg4moGYLZFBaObR7t2X1pvQtjbI4n4Nf0fD
	 /bzBiBmj7ECag7TT0ofDvb1Q+5Px3litoUb1UP/dyIGZu6hBPYS1sGBHTMEV2pTuBn
	 PMD7+peVi7q0Vmv99onFwQsw1KFnMxCaxaROAaa6tQ+PHGcakcxvXh6a6wuYPETjWp
	 UyHOIBdt51dCcvSUDcIBgtn6/9e1gmey5KKQ48DTqjnDhuel23rq4V52atgt45KPYL
	 iANl/vdJ6oxYg==
Date: Fri, 14 Jun 2024 19:03:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <maze@google.com>
Cc: "Maciej =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?=" <zenczykowski@gmail.com>,
 Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] neighbour: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to
 RTM_GETNEIGH
Message-ID: <20240614190312.3dd8a941@kernel.org>
In-Reply-To: <20240613141215.2122412-1-maze@google.com>
References: <20240613141215.2122412-1-maze@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Jun 2024 07:12:15 -0700 Maciej =C5=BBenczykowski wrote:
> Fixes: 3e41af90767d ("rtnetlink: use xarray iterator to implement rtnl_du=
mp_ifinfo()")
> Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_=
ifaddr()")

Did you just copy / paste those from the fix I pointed at?

I really think it should be:

Fixes: 7e4975f7e7fb ("neighbour: fix neigh_dump_info() return value")

Please double check that, correct, and resend. Same story for the other
patch.

