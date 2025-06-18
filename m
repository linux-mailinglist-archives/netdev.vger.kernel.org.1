Return-Path: <netdev+bounces-199204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADEFADF68B
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C99176CCC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F432FCE25;
	Wed, 18 Jun 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwjKnCm+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983DB2FCE1B;
	Wed, 18 Jun 2025 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750273020; cv=none; b=FP6TCaGtT988q/9PxdPMRotWgM915IuOk1YXc8hLbSaSzxqZ+N5kx7TYp+zoI8Yj/S0nuy+UGJrS8ZKZTHapFJHGTJKQE5Xr+/OksYtED/S6wxgH4bNIqhOQ2O6Wi1ltOdYjJg6puV+oypEnuS/l/7b7zXSSfO1PDIsMw8/jkTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750273020; c=relaxed/simple;
	bh=J1oaDCl0btmib2TF2x64Gp/aTFdcwOsZmN0AYQsV/aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CbMPA098H3yDuN+vp7A9lVM7pCHw/yJvuB6EQ9r/viCEKdsZIyQA4RsGpyr0Dwo1yA6txvyvzBm0fCezgXA74e2ovvQH2q0hC1wX8Td9b+DTUYP0owISP6TbJPh13hgE6HJI6s5QDmqwy1z8+VoaoVcrXf9Pf9i4DFd57fSn0jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwjKnCm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BCEC4CEE7;
	Wed, 18 Jun 2025 18:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750273020;
	bh=J1oaDCl0btmib2TF2x64Gp/aTFdcwOsZmN0AYQsV/aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwjKnCm+IEuYL9+7rJDCrbBlbOWtuzx82HjCb9oODKRV8t2NoQ1ZU08JftBj6MEOJ
	 JlXHEJopBynPhzGjNQq80f46e7lSPfNtAwvZqYL+IQMKYcekQ2dds9p+6RdE9lHvlr
	 CFWwqWNuHYJvZxLBxfoNoxXzz+Exq+AHIQzXhSFxJoKk14/ZTCTnjNyMgwNJM5Ob4g
	 GfLp6oD3H/OL66MI5rWb795gZ1vC1lGUOyWbbAmPfAcDR1+CxkbljeCZoNs/onhHx+
	 sWm4LCWVwZH1jHikm5SSSwoDhhLjZzK4kY4tJfIQRv0xTwqikN5pnIaE7Vd8SNvs4O
	 oK7dB3JlBCWVQ==
Date: Wed, 18 Jun 2025 19:56:56 +0100
From: Simon Horman <horms@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: gianfar: Use
 device_get_named_child_node_count()
Message-ID: <20250618185656.GZ1699@horms.kernel.org>
References: <3a33988fc042588cb00a0bfc5ad64e749cb0eb1f.1750248902.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a33988fc042588cb00a0bfc5ad64e749cb0eb1f.1750248902.git.mazziesaccount@gmail.com>

On Wed, Jun 18, 2025 at 03:22:02PM +0300, Matti Vaittinen wrote:
> We can avoid open-coding the loop construct which counts firmware child
> nodes with a specific name by using the newly added
> device_get_named_child_node_count().
> 
> The gianfar driver has such open-coded loop. Replace it with the
> device_get_child_node_count_named().
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> Previously sent as part of the BD79124 ADC series:
> https://lore.kernel.org/all/95b6015cd5f6fcce535982118543d47504ed609f.1742225817.git.mazziesaccount@gmail.com/
> 
> All dependencies should be in net-next now.
> 
> Compile tested only!

Thanks for resending.

Reviewed-by: Simon Horman <horms@kernel.org>



