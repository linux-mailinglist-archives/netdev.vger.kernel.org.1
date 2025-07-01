Return-Path: <netdev+bounces-202940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B870AEFC4D
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3011E7A5FC2
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75241277023;
	Tue,  1 Jul 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoqFlnHs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77C275B09;
	Tue,  1 Jul 2025 14:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380207; cv=none; b=Vnh3LDQBlFkNZLE16ZG+mvqreX5JRn4mZvOrttuvzYdhOaVP6Jvhxrh7YFrrvUIPyqkSjDFaGKQM/zYloF5kBKDqlEX12Qj7iV1fvPy71GLyYYXBfLqtbTU2HKjruEB60gzrIlz7riaLig7evJXmlL/Y/N3NPgb6QrGUElx0MQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380207; c=relaxed/simple;
	bh=PPt418S6/jc1pyv5jNXXSZ+NEt6JYlIvKDNEjI7wl3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A24Gfs7YHCFlLVzrWJLoIZTdcg3vh999USSP/ZP9AXuOS6lxXIk6s/Jnu5efrobwXqcS0oozpsU3ppCVOFjfK25G7NfwLVyz/7/XVi0ydD/8K0IkefGXLMs+ogk79OPfXSQZpe42pr7h0FG0SbuEQAu4U23A6ZZPiuw6VzVxL/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoqFlnHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D4DEC4CEEB;
	Tue,  1 Jul 2025 14:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751380206;
	bh=PPt418S6/jc1pyv5jNXXSZ+NEt6JYlIvKDNEjI7wl3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoqFlnHs7gSXLFFddDQN0mcVID4y7bw3tVnsos+fSJ4/2h2Pr4+xHLcMZUQPAgq3u
	 8iv7EbACEpvNhljhZ/caIfnbsYlkTDWkpKTbRbQKSj/sChFhPR5vi7r2qhl+WYogAc
	 0ws6ROt7w0WGMWjiuf5ykiCE+5+T7cfh4pb1LeJ/EsOsyqWghbJdmObJgcJVhGCQrC
	 mJg3WMumhUb2TDa+pYWgbag+tABRPyRBXLS28VQw23lP9+jjkPMCZx1MAUFGfN19jn
	 XHxnCng7Tb+tTdTv4vYHfXC9Z1aM47IwI5ZvdG6VDmgDYWKr7sW/pREXRVj5A3tqPS
	 PhUQphs3Whx4w==
Date: Tue, 1 Jul 2025 15:30:03 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, kuniyu@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: Cleanup fib6_drop_pcpu_from()
Message-ID: <20250701143003.GY41770@horms.kernel.org>
References: <20250701041235.1333687-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701041235.1333687-1-yuehaibing@huawei.com>

On Tue, Jul 01, 2025 at 12:12:35PM +0800, Yue Haibing wrote:
> Since commit 0e2338749192 ("ipv6: fix races in ip6_dst_destroy()"), 
> 'table' is unused in __fib6_drop_pcpu_from(), no need pass it from
> fib6_drop_pcpu_from().
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


