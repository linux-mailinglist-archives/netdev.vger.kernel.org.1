Return-Path: <netdev+bounces-137939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DA59AB2FA
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84E8F2845B4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44A21A2C0B;
	Tue, 22 Oct 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pM1Zhu/1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899B119B5B4;
	Tue, 22 Oct 2024 15:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612769; cv=none; b=sPmh13Qytzfk5aaw1wR2f3W52f8BfMwUKQbzJBfIaWqbvAeOQ5pzTwsUw+qpyNq+Tohr/iSs8gkKshIAdL78z6ZFgGbaHKSY8TxNIKtmiwE1m2723dTFGCgTO5NhJSjbN88lo9UeQ9j9w8ma3WrEhDpcTXUMgqtrgxAssOPad7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612769; c=relaxed/simple;
	bh=EOlJHUam30v6VDMW+gRskJgvCIQfUgIAA3M0vNQykHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiPvVpRh++xkU6uPMn5JOSgyXFvbFDt8g9V9ZwsyAoYv6LYGEt++2R8lMC68jXcEu1ngbePi8z8KWa0H1gfVk72CMwwCTAroByG3w/wtnzM/0PkJoeAsbANLP8VsY1Ospa59aCAsznKkjLnK+0ITmiJ2Ng6PhlSISt8BGTmWa80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pM1Zhu/1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EDDC4CEC3;
	Tue, 22 Oct 2024 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729612769;
	bh=EOlJHUam30v6VDMW+gRskJgvCIQfUgIAA3M0vNQykHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pM1Zhu/16BkG4VUHQVt0iIYfPg8JLDpS09R7wjEQspDyaImc2WnLg0dbZG8Fk0rgu
	 n4pwSrYbaL+J5sphHTmrO5ZUnWnJhcyaf/S6EElWpS5HEt2rVwGmfsKXl2E1/596ly
	 /0GTi3OstLxRnY7HG6iZYoxr248shOqglYp+fxNnul3PfZ4pOLc43DFH5W2XPMK+X8
	 ittXn4YR5h02FOFH5pvrKlpJT5A66Yxw0j1sf1KwqF4fNLfnbSybHfdEY+1s9od71/
	 DOyO5tvqO0Kfz8ZoNGVAVyhAM2XDTJmCjK1mAVTyy5T3tuK6QrpEPbNnORV84zidHE
	 T0k+cn3fxR1Aw==
Date: Tue, 22 Oct 2024 16:59:25 +0100
From: Simon Horman <horms@kernel.org>
To: Yang Li <yang.lee@linux.alibaba.com>
Cc: vburru@marvell.com, sedara@marvell.com, davem@davemloft.net,
	kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] octeon_ep: Remove unneeded semicolon
Message-ID: <20241022155925.GZ402847@kernel.org>
References: <20241022063453.103751-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022063453.103751-1-yang.lee@linux.alibaba.com>

On Tue, Oct 22, 2024 at 02:34:53PM +0800, Yang Li wrote:
> This patch removes an unneeded semicolon after a while statement.
> 
> ./drivers/net/ethernet/marvell/octeon_ep/octep_rx.c:381:2-3: Unneeded semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11430
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Hi Yang Li,

While I agree that this change is correct, and improves the code.
Netdev discourages clean-ups along these lines that are not in
the context of other work [1].

[1] https://docs.kernel.org/process/maintainer-netdev.html#clean-up-patches

-- 
pw-bot: not-applicable

