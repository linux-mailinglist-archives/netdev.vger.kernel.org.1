Return-Path: <netdev+bounces-93910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF54A8BD90B
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 03:38:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E39AB20A8C
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 01:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCD1FA5;
	Tue,  7 May 2024 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx+ywEF+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FA139F
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715045907; cv=none; b=OTqFyQa7Cp/SmUK8+rGbhds2xpPa3tgyFYH1rtdvN+l9t1FAj6a5F8MFEwjdtH3LY6LH35mmDuOBHQrsM8vbD5m6iAG49kHbSQAxYkV/QspORcBQqPwOEUocSyfniySZS48YbQSNHXkocfnys2++cq185KFImJiA79ijFV1z70k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715045907; c=relaxed/simple;
	bh=3UVvf9/MD2DAo4mb8+aMVIRmwQ9YeNRpK/hCEcC33BI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lakxan8YTjy9I1V8fbrGh2tn+CvDLBmYNsL0Tp6jZmKXJiNRJREEyPeEU+GsvJFBInSWl677GpkPWDXvckTSpeqC5sPs4fQDmwjpwxaXe4qfQb5Xtu26zOVvrKx5jLBdmXGChYmjZDo2liTZ4bSvCMbXV+HfmHYhDaxHyCnVcFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx+ywEF+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF14C3277B;
	Tue,  7 May 2024 01:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715045907;
	bh=3UVvf9/MD2DAo4mb8+aMVIRmwQ9YeNRpK/hCEcC33BI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rx+ywEF+J5iOOxP5iV/SWaxjj7Y4ZlCXBS+86eQ7qkZu/m4O5FNxD7w0yJWqcbsXu
	 2T4LfEb5YxGN+jrcYYe808oAXcoqmVTnwPtF56/jvmaqMBPCf3y+PVSDIXVyDNbysu
	 lJ7ncNpSDfSRRBgV6J/iaXB05+NqWLSZJOIcJq+uDTSY/r6v4IJIlHaWt8S0Me2Cha
	 xDQMoG4MKQLhekI1MePeerfkdtBW1eQXNUZ08wDFDHqSvCe7b4XKnoKoG3DQM7t6cM
	 xktu85VTS3dhCle5PkZVEbwihxu+0l5SiJSZzJk4Rw8+kr1KO5GqhfPfjSECzZWeMu
	 XePznq/+2z/ZA==
Date: Mon, 6 May 2024 18:38:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
 horms@kernel.org
Subject: Re: [PATCH net-next v4 1/6] net: tn40xx: add pci driver for Tehuti
 Networks TN40xx chips
Message-ID: <20240506183825.116df362@kernel.org>
In-Reply-To: <20240501230552.53185-2-fujita.tomonori@gmail.com>
References: <20240501230552.53185-1-fujita.tomonori@gmail.com>
	<20240501230552.53185-2-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 May 2024 08:05:47 +0900 FUJITA Tomonori wrote:
> +	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
> +		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));

This fallback is unnecessary, please see commit f0ed939b6a or one of
many similar removals..

