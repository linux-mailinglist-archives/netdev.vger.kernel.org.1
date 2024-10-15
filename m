Return-Path: <netdev+bounces-135747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5E99F0D5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87C4CB21A63
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 15:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ABD1CBA11;
	Tue, 15 Oct 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDCp2BvC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11DE1CB9F2;
	Tue, 15 Oct 2024 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005382; cv=none; b=F36vpuIZWf7YbDh5jBgorP7oHkbTpm5H+gn/kllYg3cwTXpttfioOjhSLE/MCMtQdKpiuo7i945UMhqurW8LnJ0aPp0VcV7kriOAFecLK75PvkVbTPDhrUcfw0Zeyvj/lPnsnO+18QYbqn4WBT4fkbo3t1B8+4UC8yMtHNJ6Ikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005382; c=relaxed/simple;
	bh=UrHKn0YlrR8Wl1Xg0bjUNAEqlqnNCKzAKjg7iocFKqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cpXQvTKCqticcl47iUwWSHR5cTktx4W++IBDTc1/aFxnbvKBrYcucWlIMknNXCkebFbvskW1Xk473rx8kWawRh8sd5YtCe0qaMB9V07kAPV3F0OXURCd6uS8LI0CIyN+wl+JTyeICqXYMS9mdDJYVyFe1hdznUFQOgAYBcyFBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDCp2BvC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F807C4CEC6;
	Tue, 15 Oct 2024 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729005382;
	bh=UrHKn0YlrR8Wl1Xg0bjUNAEqlqnNCKzAKjg7iocFKqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DDCp2BvC4EydV50evYqf/fjXD+e/LfUvXb/RxsvyGkkaEKPnERjHz6ldO1cr6oqBW
	 G2Xp8A1e2cMXPIo/vC3br36h8twLsfDxx23wd92qVie/e6PxomIz4DlTbxOuogknWo
	 yajmCFJQmBeft3Knt/qDVdOpaNGLL5HycLxFfctOjNVRKso2fvTP7DGwpBWD/JywmA
	 YLNjAy4otjVpVAjhmVZWPzxar/uBXxQEqQO2QgR2xBMGbSbGAKGWe242WR9BbUI4tv
	 bLe3+BEOz5Q7+o/O7LhjaL4GQDdXUCmtPmXU/QdD4kUImBy+m9cC8eUwl5kWxV7rJn
	 Kc7NZSJ3eWcKw==
Date: Tue, 15 Oct 2024 08:16:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Michael Chan <mchan@broadcom.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] tg3: Increase buffer size for IRQ label
Message-ID: <20241015081621.7bea8cd7@kernel.org>
In-Reply-To: <20241014103810.4015718-1-andriy.shevchenko@linux.intel.com>
References: <20241014103810.4015718-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Oct 2024 13:38:10 +0300 Andy Shevchenko wrote:
> While at it, move the respective buffer out from the structure as
> it's used only in one caller. This also improves memory footprint
> of struct tg3_napi.

It's passed to request_irq(), I thought request_irq() dups the string
but I can't see it now. So please include in the commit message a
reference to the function where the strdup (or such) of name happens 
in the request_irq() internals.
-- 
pw-bot: cr

