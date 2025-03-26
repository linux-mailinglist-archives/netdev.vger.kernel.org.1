Return-Path: <netdev+bounces-177718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F2A71602
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 12:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A6A1896E6C
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8A71DF97C;
	Wed, 26 Mar 2025 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmxnGNa/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E981DDC2C;
	Wed, 26 Mar 2025 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742989509; cv=none; b=CqlTS87KjnzBehcI3T4zaAgJQg1ljcNTJRp99nr3FB5fGcTAMMPN8sCK4QVXn2alFXimsVWhGELtOTWvX/aR0Mwx9PYiJNNaMPZhBUdbLMpxjNdwG5hxKsHNe/NLLMlWuRqO42aHSjbDbmMcCmjuKAU+2RFxS/l/2RGO/LuDn0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742989509; c=relaxed/simple;
	bh=mN2/sZry5ObgSjPvAI0YAPvG+Q/yLfCuYPbOELw04VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIZ1rgiRHOz8mXuLKrDkEhasOdclTP/nlARzJmPqVi0c1EFuEvy797zuZ8yi4E5mBl6YDd0cQsmUOMbyF63RO0rs76T16Rrw8QGdBK6sg8B+h81OGrk/JC0ZgLAgHWoyIbUm1ul+03nbG3sZfJmNsIZJ2nP6HYDaxjDv+bhv6kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmxnGNa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E49C4CEE2;
	Wed, 26 Mar 2025 11:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742989509;
	bh=mN2/sZry5ObgSjPvAI0YAPvG+Q/yLfCuYPbOELw04VQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hmxnGNa/zznFeRBCtXfgYLetZcZ9IhjGT+N/TPCFBPLDepvMNKFeFoxnOKtmxZoyc
	 QgGrl+fcU02e6MbIl0oAztwdeX5eFvNWjTwgCi13A3B7lMnYYLfP6goLjWT5m2MeeD
	 GEMJdtBVu0oCd1ZYD/8oymwH8m6KDCWz652lNTWJ2OjlgHey8sq5yuvKS1ejRGLHwv
	 Y606t7V0VlQb3JuiOWlmU3WTbgOB1pmFPa5JmjeSW1fWAoi/YyNmf4Ed+LMIgMhqti
	 hZ+FAvXldyBPpfyXI92OZwnY+epdG3Vlzk1brFjvAarRl6tTyZkPlAdQX2hcLxzV7X
	 IjrNGUNluQSEw==
Date: Wed, 26 Mar 2025 04:45:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <xie.ludan@zte.com.cn>
Cc: <davem@davemloft.net>, <gerhard@engleder-embedded.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>, <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next v2] net: atm: use
 sysfs_emit()/sysfs_emit_at() instead of scnprintf().
Message-ID: <20250326044508.30a9e5cb@kernel.org>
In-Reply-To: <20250325102805210eUc7-ji7GineR0TUNA9Nn@zte.com.cn>
References: <20250325102805210eUc7-ji7GineR0TUNA9Nn@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 10:28:05 +0800 (CST) xie.ludan@zte.com.cn wrote:
> From: XieLudan <xie.ludan@zte.com.cn>
> 
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.

## Form letter - net-next-closed

The merge window for v6.15 has begun and therefore net-next is closed for
new drivers, features, code refactoring and optimizations. We are currently
accepting bug fixes only.

Please repost when net-next reopens after Apr 7th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

