Return-Path: <netdev+bounces-43537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B07D3CEC
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 18:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656661C2094A
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05DB1CA8B;
	Mon, 23 Oct 2023 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHKCF/BR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21361C3D
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 16:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADCCC433C8;
	Mon, 23 Oct 2023 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698080146;
	bh=TSFh5dXbZsg+pUIH3pqYtSVgXyqXN7ExOr851vMR6eA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHKCF/BRnnO9E4gw+RKIBBfXVnYmvhInhF4cRX2+70T6bmkSXrqE93+fPDnoFYa7Q
	 FeYPi801KDfH6WZYyidfc9j/NzFT+YRSZ56ZXGyJTWXmngCFresqEeZHJCoxUo1gwc
	 unkzcYHb+rwta+i9JNmGcGXeNzIT1UdEhbGyH9DxKr/CxPFYzX4FuTQouC814ytvQX
	 DkYptIqhp7DLKqa9anBeoZDlGd8sKu0sK97HkccZHinhXoEDv7GrZU7l0etEgwf0vI
	 9sBHPb9JXdngcshOftgmaghvYwYAIZKR0q83SAtYWSmHaYYTS0pbQQ4lNb4CCZWtqW
	 MrMyMjRstBP2A==
Date: Mon, 23 Oct 2023 09:55:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Soltys <msoltyspl@yandex.pl>
Cc: netdev@vger.kernel.org, =?UTF-8?B?UmFmYcWC?= Golcz <rgl@touk.pl>, Piotr
 Przybylski <ppr@touk.pl>
Subject: Re: [QUESTION] potential issue - unusual drops on XL710 (40gbit)
 cards with ksoftirqd hogging one of cpus near 100%
Message-ID: <20231023095545.62feadeb@kernel.org>
In-Reply-To: <e28faa37-549d-4c49-824f-1d0dfbfb9538@yandex.pl>
References: <e28faa37-549d-4c49-824f-1d0dfbfb9538@yandex.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Oct 2023 15:59:09 +0200 Michal Soltys wrote:
> - aggressively reclaimed page cache - up to ~200 GB memory is reclaimed 
> and immediately start filling up again with the data normally served by 
> those servers

I'd start from figuring out why this happens.
It may very well be a change / bug in memory management.

