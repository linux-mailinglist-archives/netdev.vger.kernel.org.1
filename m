Return-Path: <netdev+bounces-17036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EF074FDDF
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 05:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775C51C20E6E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 03:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92310138A;
	Wed, 12 Jul 2023 03:37:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AD3639
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 03:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67146C433C8;
	Wed, 12 Jul 2023 03:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689133071;
	bh=lMj91ggsyrOF+R1lMVH6IPX+NT4TZGlOdsBBejVvWho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GaLejy9/80GI66hCSY5GeUHgZyAwbw8jxuBZMGZOxlgYefJ0wwKML69ZM9DIU3uzQ
	 5ytVxDAbYIFav77CJGUpFe5GlRI0maaO1hVanDkdxbUtkqdoCJq87s6OkquLyGTn88
	 vCkzWtJ4EMzgFJZKpMDHRlyiE3IKoj9695+sBPkyJegw/3hR8WZuP/ymxxHMSZuo0u
	 aFWUBUQWhKwgD1UGsAFsssJGFHHb18ZCIHifmHQVFsoCRIMHxfFmMuw73Ad86UqHIW
	 JgaRZvRHCajqncGNcChGAO8fBl7xRWPV6k37mp1AYFGwpruEV9utq0amA26c/73GY2
	 TQukS96SLZsUw==
Date: Tue, 11 Jul 2023 20:37:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Prameela
 Rani Garnepudi <prameela.j04cs@gmail.com>, Siva Rebbagondla
 <siva.rebbagondla@redpinesignals.com>, Amitkumar Karwar
 <amit.karwar@redpinesignals.com>, Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH net 12/12] rsi: remove kernel-doc comment marker
Message-ID: <20230711203750.5192ac53@kernel.org>
In-Reply-To: <20230710230312.31197-13-rdunlap@infradead.org>
References: <20230710230312.31197-1-rdunlap@infradead.org>
	<20230710230312.31197-13-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 16:03:12 -0700 Randy Dunlap wrote:
> -/**
> +/*
>   * Copyright (c) 2017 Redpine Signals Inc.

I guess the obvious ones like this one can stay, especially since Kalle
already acked it.

