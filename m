Return-Path: <netdev+bounces-118107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECD995088F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 17:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60DE28189B
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 15:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FA219EED6;
	Tue, 13 Aug 2024 15:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJZIyLvG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B0A19EEA4
	for <netdev@vger.kernel.org>; Tue, 13 Aug 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723561813; cv=none; b=Adm0UTykv18c0OyW/PoflZBViYBoHdhOexH3KNZwyhjwGDbZ5K9Zv7pieljhjxdIzBICIxtZylKhDLzeKjGH1nPlLJqdbwwZko6OXl1iOhxe130F3oyhOodssjL1X+2xik1EqoxfcU2poHii0n58enbXyPIlyimiw1hy8BewOis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723561813; c=relaxed/simple;
	bh=X9WteY5MCq4YehuCh+HYelcA6FD6+zFPhB40n31DI1U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scGscOsxJM07twtSNCOd7KIUJbYeqLjNNsif3Hk2PaoMxyMqFcV581SsfWpOEkuMKv6zgHD9b8QlIgKiVQXMOmF9nb0haOTop4pejgeWvV2QYx0+uPquBfdwZCIN8M00OcZTNpq5x+/c3n1TMTweOt9g3sZLxO3CNAQ2fRoLnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJZIyLvG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E48FC4AF0B;
	Tue, 13 Aug 2024 15:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723561812;
	bh=X9WteY5MCq4YehuCh+HYelcA6FD6+zFPhB40n31DI1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IJZIyLvGNpu9Iri8Xv29k+B11cROuOKA4r/XgTgfzy3UWAfE3EPDfEcKqxGZqNDMD
	 PRp0V20IeBW1QqK7RPtH0E6bPvtyi8Qam24eYcnwgf/n0ER7KYruk0q8RaKvxXPL4a
	 bnJeZHeBKrZx6tRPmz/GIHKP6I5/29J3DDczRfu4Iu37X+vsxdi65ziD8cCnUH3v9H
	 9ZUGNCgxogPKw1lNIgr9T9Nu214YQjQkDWr215MGs2qcZDB8IsCqSIpa5m0vK/UlmM
	 FNxvsfNXIDsELnD20FvukrvoFsUaUiuAOhAwWRVAOQoSRyQDKAbA7uvFUKqMB/XQzR
	 zzXQ/4klmbBfA==
Date: Tue, 13 Aug 2024 08:10:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Arinzon, David" <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, "Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky,
 Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>,
 "Bshara, Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
 "Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea"
 <nafea@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali"
 <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>,
 "Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam"
 <ndagan@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Itzko, Shahar"
 <itzko@amazon.com>, "Abboud, Osama" <osamaabb@amazon.com>, "Ostrovsky,
 Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>,
 "Beider, Ron" <rbeider@amazon.com>, "Chauskin, Igor" <igorch@amazon.com>
Subject: Re: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
Message-ID: <20240813081010.02742f87@kernel.org>
In-Reply-To: <9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
	<20240812185852.46940666@kernel.org>
	<9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 11:29:50 +0000 Arinzon, David wrote:
> I will note that this patch modifies the infrastructure/logic in
> which these stats are retrieved to allow expandability and
> flexibility of the interface between the driver and the device
> (written in the commit message). The top five (0 - 4) are already
> part of the upstream code and the last one (5) is added in this patch.

That's not clear at all from the one sentence in the commit message.
Please don't assume that the reviewers are familiar with your driver.

> The statistics discussed here and are exposed by ENA are not on a
> queue level but on an interface level, therefore, I am not sure that
> the ones pointed out by you would be a good fit for us.

The API in question is queue-capable, but it also supports reporting
the stats for the overall device, without per-queue breakdown (via
the "get_base_stats" callback).

> But in any case, would it be possible from your point of view to
> progress in two paths, one would be this patchset with the addition
> of the new metric and another would be to explore whether there are
> such stats on an interface level that can be exposed?

Adding a callback and filling in two stats is not a large ask.
Just do it, please.

