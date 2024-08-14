Return-Path: <netdev+bounces-118543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1E8951F3D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED4B81C203DE
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB71B5831;
	Wed, 14 Aug 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvF4QKBg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E69628DC3
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723651050; cv=none; b=kKO4a0wN9GMTuPg0pNBL8d6Lv17loJpFjKpjjKqk5bkYjijv7yH0bpzCH58a/6m0gxujo7TAWSG6VViIo3UZLruWx3x7HD1NGnxyvAVVg7FEWkjDZnjIqxhQ2Jv6EIJIUZKdDLDwhE+gtlqDxUeBc+m+Z+TzmCjcXPG6QCH+Dmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723651050; c=relaxed/simple;
	bh=PPkcnFipThLZVV3kpNfG89I/qf0O7PfR3YjwXcqV4HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ctf62/GtwcvC8v/ebvuhUJ6dNbmGb6FdCSuQgKGbfT9vFjR576mIbsebKubEHmSBIZo0zTtP8xTxN0r3cpoz2SeFaCdtnzhKFNf8T4OQMQFV5tSjDf0CMWsMv8wsSEij6DCTIF5uCuMbjsqTJvjoaYU6uv2KYunN2VMxKHa+hM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvF4QKBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6E5C4AF09;
	Wed, 14 Aug 2024 15:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723651050;
	bh=PPkcnFipThLZVV3kpNfG89I/qf0O7PfR3YjwXcqV4HU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RvF4QKBg3+Ixp5OpbSw7FZUBD+e16BgP4Hjk/17naWk4WgFtNkyi91aBEw1/YV36P
	 Wn0af4mtz4zpeBW0NORWqK4VvsapEV15S0ghLPJ7fEQlFshnxBwobhgYjuEceCVZEw
	 w1oHPI2fLnoaNfVX345fXuVYOut3rLcCmvnpY7eeYOWfKxh3FauCI2NKHm8svQ74Ui
	 yhk+sSblLlIR1J/NCVeONpe1dl6wToKUcdlHzDcvoHbHUZ2nPiZOw2N7NU5RbO0Q8j
	 m36onE4sNtVGAN6d5+mvtDAXqn5teDWhuE24SqIBZNnDQzK2sGEHX1yHTYDWw7hiRD
	 yoU62bMb+cf4w==
Date: Wed, 14 Aug 2024 16:56:56 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net] MAINTAINERS: add selftests to network drivers
Message-ID: <20240814155656.GC322002@kernel.org>
References: <20240814142832.3473685-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814142832.3473685-1-kuba@kernel.org>

On Wed, Aug 14, 2024 at 07:28:32AM -0700, Jakub Kicinski wrote:
> tools/testing/selftests/drivers/net/ is not listed under
> networking entries. Add it to NETWORKING DRIVERS.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks Jakub,

I have a patch in my queue to do exactly the same thing.

Reviewed-by: Simon Horman <horms@kernel.org>

