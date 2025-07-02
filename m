Return-Path: <netdev+bounces-203437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F67DAF5F2A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 18:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D072818973F3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB5B28B41A;
	Wed,  2 Jul 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFfrq6pX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C891DEFC5;
	Wed,  2 Jul 2025 16:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751475178; cv=none; b=OShXg5s9eJlP9iZHXnW5ZoqOdbnm7VgYJHj4KnkUgB3/u4bXM3OHX1WBq0ImLyYeCJlnyjBb2O8VtFPElswq6YX/mP++9SrNuIFYfKuErZIcLrTzjugbHxYilD0lFw1jtLTD4GC+/WYtejFkm5D2DXDj9250vulo/+kALHXDVFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751475178; c=relaxed/simple;
	bh=tpLB0ybx++TvSF3YmvMW+PDaMhF4gg85yhBVelJrC9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We2eGnaCKvyQJ3bdqLcpPDaDylZj7RVBQnUpr2uqNzV964v1dC2qIIR6TMRqrsBCCN/aoUhmolnvtB+fgTWuXvHQo8/UJrsLei4C3y4eWCkViYnmDTcy3jXAJQhm2jJZ6wTDtHwSU7SkdybyqU0kxjLzDrurlxwWpRZQz7D/2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFfrq6pX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017D2C4CEE7;
	Wed,  2 Jul 2025 16:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751475177;
	bh=tpLB0ybx++TvSF3YmvMW+PDaMhF4gg85yhBVelJrC9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eFfrq6pXotJmZkTDr7QX5YcEhHPgdPfiJcJBnx9Eck6SxnNn6uU2F4DLFjVJhGReZ
	 f1VZMyzz7EAcwshRTMC3QSQHBUSF9+iWrG/+GYBjX2uyIQSFlRKtF5a6XluuQdIteP
	 7PqLRr8QyoQmMTb5zzCciB+yoPyOElhDyh1mBYnvNXFMFAxfRWIOyQi+UdhuYpZHQu
	 wjI7CGTH5JSVeSNOPVfNATrJG9JcRlamBdSgrWEOhpJJCj3QvKSMaDSBECbybYr2l1
	 0wKK+j1zSt85kE7jLCdA/WXrQaiIC/baAbUUqXO/5teiq5axgvxFg0t4dICUzPbpyQ
	 TPnaOT1s08hHQ==
Date: Wed, 2 Jul 2025 17:52:53 +0100
From: Simon Horman <horms@kernel.org>
To: Chenguang Zhao <zhaochenguang@kylinos.cn>
Cc: Paul Moore <paul@paul-moore.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv6: Fix spelling mistake
Message-ID: <20250702165253.GG41770@horms.kernel.org>
References: <20250702055820.112190-1-zhaochenguang@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702055820.112190-1-zhaochenguang@kylinos.cn>

On Wed, Jul 02, 2025 at 01:58:20PM +0800, Chenguang Zhao wrote:
> change 'Maximium' to 'Maximum'
> 
> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>

Thanks, I see that with this change codespell doesn't flag
any spelling errors in this file.

Reviewed-by: Simon Horman <horms@kernel.org>

