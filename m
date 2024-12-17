Return-Path: <netdev+bounces-152560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D20519F4936
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 11:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2468E16396B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 10:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB231E0B7D;
	Tue, 17 Dec 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSMh8/UJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3236E2E628;
	Tue, 17 Dec 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734432667; cv=none; b=VCWRKg5HGObwkln9FLk0741w8sPSmao9uYpDRp28XMaFCqxyqfc0VtrImqCGD++Oxr/M1xKawW9oXJmozTPyKQhMJqGrvfLJ3C2GC2Du+WaphX4E5S0tJrdtdYPquSAVmwymGDshnghH3rPSu78ZXdi60QDaih1HXmxPmdKN/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734432667; c=relaxed/simple;
	bh=4mbpskmtOwRuwpa9v+SeXv4dB9RUJYOJS1ztdmHlJs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIIADXyMzGYFGep62hyd8jrPKm8br/4WjxtgnTuOUmwtNEOtdwbP1jo2jokjpc0fQahyaP9ROlYeNJ+xrwIXeFPz2Ar9KcfUKaJ8WnLimDnu/Yh3rHECzXkT6vezFVdkA2n5wWuxhv2bp3Wk2qxyfe5KKNI6gNOyvekvP42eUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSMh8/UJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F6CC4CED3;
	Tue, 17 Dec 2024 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734432666;
	bh=4mbpskmtOwRuwpa9v+SeXv4dB9RUJYOJS1ztdmHlJs8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSMh8/UJKTpeXZq7KvSFkUX4pVTbJfWV0D6n4Aq9psdWioIpXTMdx8KkbA8K2IzkE
	 pVw/GBVNzdGlCfblSmcgl0ezV8eTND3/ItyMrabXun0rccxosmn7ArnE2MBov9TFsB
	 EHmS+f7bwLkhV7ur5ohFMtmZK000pVZM1h55o1z4Fh88bW7UY0TzRsQJzEmAc5/iaY
	 QOTF98jjGoUxbYJFFddgg2+pbT1i98Y20lwCJjT2eXrAB3VKiz2q0fFpKJYlJGzdyO
	 dOkyR4h+IddlidOCVXr2md5YpiSXR2Xn1NBizKmBAWW8gTYZFPxPIaFmkRObKQsAg1
	 1WS+guibpYrLQ==
Date: Tue, 17 Dec 2024 10:51:02 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: jes@trained-monkey.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: Remove bouncing hippi list
Message-ID: <20241217105102.GR780307@kernel.org>
References: <20241216165605.63700-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216165605.63700-1-linux@treblig.org>

On Mon, Dec 16, 2024 at 04:56:05PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> linux-hippi is bouncing with:
> 
>  <linux-hippi@sunsite.dk>:
>  Sorry, no mailbox here by that name. (#5.1.1)
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Thanks David,

I have no insight regarding how long this might have been the case.
But this seems entirely reasonable to me.

Reviewed-by: Simon Horman <horms@kernel.org>

