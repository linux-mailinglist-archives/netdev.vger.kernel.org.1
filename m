Return-Path: <netdev+bounces-119355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6108E9554E4
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 04:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934021C21CFD
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 02:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5405C621;
	Sat, 17 Aug 2024 02:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCOGraed"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304545579F
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 02:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723861484; cv=none; b=gZ9KeEBKDiW0ZxsEIPFDxUsE4XVhRG1pxkTCQ3xL8UA0V6ViEZv/xDHXaT8mfiUOdMMnI1YGv/87q61qcHrUFj4iC2t4m7w0R9ZxxgyU7KzAIT5cjFHn0lR9wVv/gl5ipl1MlsrBmRkm4msSVu/L0aw1zibvTbb2UF9Y8Xi2jHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723861484; c=relaxed/simple;
	bh=neUB3o5Iyji+QtCud7BT/UKh9A0aY9bPika2vdrRuqk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AsluXeos0t/4OLLkPkfxXere6ycCg356GWm/LABCrcXvAgc6NbuXlfkAYbX6AMi7bX3V+rVZWB+ZAJfjLU+g40M4Xae3gqzdC6qReF19fz81mjuEdrkIVj5kjQ1lI0wzoQLdwNsAMEZf6k7an523BiRV7asliQoDT2zDdUIoobY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCOGraed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F058C32782;
	Sat, 17 Aug 2024 02:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723861483;
	bh=neUB3o5Iyji+QtCud7BT/UKh9A0aY9bPika2vdrRuqk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hCOGraedM4J9INa4Y0QCt6qaaPIp4yShbfXu2/XZQuXxKadJtGcTDvAoq1JhcEtcA
	 fgBLxEkg6gYLtxyDAhqvWwix2lsKBMARbh4re6GzCAZseXIEBhFCeJJa8s9e8xW0YR
	 OChzNkBdgW36vqz8UFcQ5A5WC394WEB06359Xnz/w4FfiGeVkqsl+dJe72X4cPHpRD
	 qTWVWGiKBUjy51g6zcxgCdUTCir+S/Ub4PU6KSzb8bbdIxDgVog2Ekg/hdNoh0ikCy
	 RLN8fgKvDjWO7hHLfEeM8knJAR3Ef3iJJ/9ZaeIV80f2LGa4Qcs5t+23CHx9y0RYU9
	 YxLiLnHBltVdw==
Date: Fri, 16 Aug 2024 19:24:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Jay Vosburgh"
 <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>,
 <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net V4 0/3] Fixes for IPsec over bonding
Message-ID: <20240816192442.221e7182@kernel.org>
In-Reply-To: <20240815142103.2253886-1-tariqt@nvidia.com>
References: <20240815142103.2253886-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 17:21:00 +0300 Tariq Toukan wrote:
> This patchset by Jianbo provides bug fixes for IPsec over bonding
> driver.
> 
> It adds the missing xdo_dev_state_free API, and fixes "scheduling while
> atomic" by using mutex lock instead.

Let's take Nik's patches first.

