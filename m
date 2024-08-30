Return-Path: <netdev+bounces-123838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3176966A3D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF89128126E
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964361BBBD8;
	Fri, 30 Aug 2024 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEjCKHe7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF3FEEC3;
	Fri, 30 Aug 2024 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725048676; cv=none; b=IDg6aCCC/b43BfWfyhv00Z1BGRsK24WQEl7tnkjtl6Ev4+HWcL/BuAx4S4CBo8lB7NrPPH9fsw6kcGn8EDWJiCd6wb+P3f8NBfSJMbZYHTIjIn93qPaefGHKqJM/K5yJRGSxCf/rv2gf3IM0WK9TslTc0FMAB3LCqBAAyto3jqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725048676; c=relaxed/simple;
	bh=IQ/fCby4wtedNLiRXiC+Utba3e2AiBRZy3nW4CKCXtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dn5mmXodyN4/rSu2uiK62Dwd5xot41/TeiiHek8lKHQWhPufK8/zolVI1Ur6r8mMDWIxIZmpWSKd4/R7kXwvlp42+/7CzBF2uhXbLJOjym/ANA5gyFonLtpXaKPj6OJ1shRC3Ej/DvGekONaoariQwmJuRxpkOygEikRGplkJzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEjCKHe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDD8C4CEC2;
	Fri, 30 Aug 2024 20:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725048675;
	bh=IQ/fCby4wtedNLiRXiC+Utba3e2AiBRZy3nW4CKCXtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEjCKHe7WTkXudZt3NpaH0kNrS3zku//iTCSvKVHpz2utSQLiu2+x7rcCCO5/JaHs
	 jqs0ZVlwLmEIcsxZrh7M++dUEGFkfd+zCWwyNd0G53R6e1YaA+sod52ZrIiomBkGkA
	 7/+rj3pwy88r++2yryP+C+Lmtii0PrBWJNskbchXA8dOABA2s2MSXaubsHb8/gfIxD
	 SnX6FGRQwRwwaUqbQGP6oJpbEAUZKq9EPeVQzNMeGZ/j7ccDhiKVAPB8Bbmzz8rchx
	 8FdddYOLmxEQ2RffIcO5xF+13HSUMlHgL0qIL4i9LescTl0NuoHNSrHo6mkZJXYR8o
	 UIwZ+TXqMouug==
Date: Fri, 30 Aug 2024 21:11:12 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: bharat@chelsio.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/3] cxgb: Remove unused declarations
Message-ID: <20240830201112.GA4063074@kernel.org>
References: <20240830093338.3742315-1-yuehaibing@huawei.com>
 <20240830093338.3742315-4-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830093338.3742315-4-yuehaibing@huawei.com>

On Fri, Aug 30, 2024 at 05:33:38PM +0800, Yue Haibing wrote:
> These functions were never implenmented since introduction in
> commit 8199d3a79c22 ("[PATCH] A new 10GB Ethernet Driver by Chelsio
> Communications")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


