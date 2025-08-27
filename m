Return-Path: <netdev+bounces-217405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A48AB3895B
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 20:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468A41B2431E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099022D8789;
	Wed, 27 Aug 2025 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j999Rflx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71DD2798FB;
	Wed, 27 Aug 2025 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318613; cv=none; b=gjZuLnYfFSwggCowk0XpGFH/sWpWVqTARzn29qC2i4EKOeG5xVJYKIrZybru6n9NOFA4I5jB6hKlwTdr0aDtWOndY9eqirozHuSByoHwPIOWV//J9lmCza5r/NSvamGBAh/4K5yIB31zhfUjfVVliZONp2oIO7HUh8AV029laiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318613; c=relaxed/simple;
	bh=tZYQGAhNSp8+YB6v2kG/8xFnCfWMXDbO7lN7RYNrlm8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3aBo4HDc+ql7m1QqPaMjI6jO14KFllczp+14ukG8f3MBIXD3OxLDvn545kPoaiLvkdlAYe126RatVklwlwiJVvfVpenkyiiOvSGurR0qXAEnC9Vfs7SvMPuGtsmxWzNC/iBIKK4p6HnYn+5vgfqnQIQf5nNIs/BVgqkF5ODAhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j999Rflx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9B6C4CEEB;
	Wed, 27 Aug 2025 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756318613;
	bh=tZYQGAhNSp8+YB6v2kG/8xFnCfWMXDbO7lN7RYNrlm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j999Rflxi7w5R7tVzCQHs4bPSgFvUnumbiY6DTM/jWC/T17eF4KC1wdJNsrOTNr/H
	 KZIyYiOFtw8xiQzAVBOhGAE5NOIBEolrpV3vlddbZT7jUSy7646Wd9bW9ei9ZXcOXE
	 dAoxlC3yo3sb60t7DBbJcCLiInMv136DCt7RBLX9PWDavGNSzFNbZkUw+svZ/lrOMT
	 bKqSDVcVMIa5zAldh9d8QkO2IXCrEhgrYLbbBmlEHV5Z8+XH04QKU4ryOVmkvfhGgF
	 dHMO7P0Tzhtj+XT9cj6g7uE3YOSfqXy7Wj1W5Z5X6cTtmvPsFn4EBBf6kvo6/rtDaW
	 aOBZkZ8RJdGlg==
Date: Wed, 27 Aug 2025 11:16:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukasz Majewski <lukasz.majewski@mailbox.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, Stefan Wahren
 <wahrenst@gmx.net>, Simon Horman <horms@kernel.org>
Subject: Re: [net-next v19 4/7] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20250827111651.022305f9@kernel.org>
In-Reply-To: <20250824220736.1760482-5-lukasz.majewski@mailbox.org>
References: <20250824220736.1760482-1-lukasz.majewski@mailbox.org>
	<20250824220736.1760482-5-lukasz.majewski@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Aug 2025 00:07:33 +0200 Lukasz Majewski wrote:
> +
> +	/* On some FEC implementations data must be aligned on
> +	 * 4-byte boundaries. Use bounce buffers to copy data
> +	 * and get it aligned.spin
> +	 */

Almost forgot, the word "spin" appears here rather out of place.

