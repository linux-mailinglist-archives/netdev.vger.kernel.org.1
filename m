Return-Path: <netdev+bounces-114769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC4A944068
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B054B2C803
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 01:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FE514EC4A;
	Thu,  1 Aug 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ab3Xuhdk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADDF148FFC;
	Thu,  1 Aug 2024 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722474716; cv=none; b=moFm+O8kPe7WpPbFZiv0fT+ZMzh5i9tX++QoAHd/qjbPCoGMdU5qbYdyckef2acwnklhL5Y8w5GUprDsLdD78nEYJ9A4E4qA9Z50q5WBattqSjxB6cfYwdlKgWT6xVgq/GNFN9ncWxcSr25vQxwc7d8cQxdlZL6bXuONMCAz0+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722474716; c=relaxed/simple;
	bh=mlu0yphlmkGbrtNaAOSv3nheyhJhHXu8hHcxo4Qccgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrVgUJ4FLPxQk4E0ccvS1MF/+fjO52EgFN6BOd6ZOSUkTdZMfuINafqknJ9Z5hVY7/gX3vtYPIh/AWDjKDT5kknyG0uN81bdd3XRBHdBmfCJuUpDsLgmwWaxjYufrA+E1LLlh+0JrHrCKceQB/5mp6f6jvc0u4PH/7Y+aLNXSCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ab3Xuhdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A66C116B1;
	Thu,  1 Aug 2024 01:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722474716;
	bh=mlu0yphlmkGbrtNaAOSv3nheyhJhHXu8hHcxo4Qccgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ab3XuhdkTvvo8pyKJnbVpFvY7OQ0BCIh4ildp4o8SQDK4RL1f+iYg9PCqMn0G5blJ
	 HRwD3f9bQhzURosytwTo8Kr2RVAjxJXL5MBw7n9BINV4wFXZh6Hoz5Ua1OZA6Q0FkV
	 kcl/7p8ighxOF00FaA9YXsRewNUT+5viCCdlLBfIOfcDYCu3JCZj+MM7BmxPsVzJB4
	 5LqPlR5prr0f2zH6IakhqfrAg0f0bRlGyWI5eTZ3Vb6oXlffOMzKd2nUzaEM7J3N1n
	 nU6/+2DYLhlKWvbm+51o/xYdsgPvchJfG3NSsHilv+hjyZXL23V5zDlyppmw+JMX5Y
	 pAnl0hSHfnfPg==
Date: Wed, 31 Jul 2024 18:11:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net/chelsio/libcxgb: Add __percpu annotations to
 libcxgb_ppm.c
Message-ID: <20240731181155.78219465@kernel.org>
In-Reply-To: <CAFULd4aye+mGTV1CJp5Coq0Qr2DvwOezpd5-hxWbF4-xR5aj_Q@mail.gmail.com>
References: <20240730125856.7321-1-ubizjak@gmail.com>
	<20240731093516.GR1967603@kernel.org>
	<CAFULd4aye+mGTV1CJp5Coq0Qr2DvwOezpd5-hxWbF4-xR5aj_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 12:06:18 +0200 Uros Bizjak wrote:
> > Let's keep to less than 80 columns wide, as is still preferred for
> > Networking code. Perhaps in this case:
> >
> > static struct cxgbi_ppm_pool __percpu *
> > ppm_alloc_cpu_pool(unsigned int *total, unsigned int *pcpu_ppmax)  
> 
> Hm, the original is exactly what sparse dumped, IMO code dumps should
> be left as they were dumped.

Unclear to me what you mean by "dumped" here.
Please follow Simon's advice.
-- 
pw-bot: cr

