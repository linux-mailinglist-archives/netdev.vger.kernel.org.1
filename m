Return-Path: <netdev+bounces-65122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED1E83949A
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10421C2384D
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68136351E;
	Tue, 23 Jan 2024 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bU9Xh37s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C2C5FBBA
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 16:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027207; cv=none; b=LTxI9FKRfyDZWE0RISB0q8+uqc9kyCishwflNGEVu6JPV+L7NZIsDYXybRPfmS7Y8qNhn+uDkevlJ0oDrqoN00lq4o/BAEhncgn9wqwjZlcn2sl4jEMoDuhru5WeBr6gax3BW8EqdDVaxRFTNbQxAhZEute2dwmV02n2Qj1C4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027207; c=relaxed/simple;
	bh=+XmGopUWw31L+toIuJrVnAarzvYIhCWHbclLDHSRXKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AkabcYUWP04DcWfGaKjwkC0Lb7Ir0gWWOt/RHqgnpHI0cb97MPpFsZ5ZNC817eORglgKRdeJVTOlRVuox7wspL2xOn5Euaga5yib4SkDHLxCHCmYnRo0QQiubTzE9l9AVK+ZUpz9pL7nsfXOyOVopQSHMSycRrW3K75XEz6YwvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bU9Xh37s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BD6CC433F1;
	Tue, 23 Jan 2024 16:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027207;
	bh=+XmGopUWw31L+toIuJrVnAarzvYIhCWHbclLDHSRXKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bU9Xh37speKn39369R6ZkYTvEcoWb12ivBJf1EAF/kG7+S/7lEa+b8ShdyT4Hw3pt
	 jRxpmaVTBezn63kkMbSpyKAftskIuAljNiWurqk5wpJ4Stev/tZYPCg3ek+4kfqTiA
	 siMLrgEhksmw6Iy3xFlZ0EHnSwHnfGSQ0Pbwxp+HPxChd7PtF6EY23/nTF57L7reNE
	 0Sa3JD9/qLwlsAyRLsc2r8XXEzqjW2r+yKV8a3hACajO0TUT+LBZ/onKCob2tbggkx
	 nKlll7hacsIv3NRRM7STc191i/87K+okV+7wwQVmhQozNTXgF8Kt97zllR6hqsBHmY
	 fu+R0DYtEMRtg==
Date: Tue, 23 Jan 2024 16:26:42 +0000
From: Simon Horman <horms@kernel.org>
To: Shailend Chand <shailend@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jeroen de Borst <jeroendb@google.com>
Subject: Re: [PATCH net-next 1/6] gve: Define config structs for queue
 allocation
Message-ID: <20240123162642.GB254773@kernel.org>
References: <20240122182632.1102721-1-shailend@google.com>
 <20240122182632.1102721-2-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122182632.1102721-2-shailend@google.com>

On Mon, Jan 22, 2024 at 06:26:27PM +0000, Shailend Chand wrote:
> Queue allocation functions currently can only allocate into priv and
> free memory in priv. These new structs would be passed into the queue
> functions in a subsequent change to make them capable of returning newly
> allocated resources and not just writing them into priv. They also make
> it possible to allocate resources for queues with a different config
> than that of the currently active queues.
> 
> Signed-off-by: Shailend Chand <shailend@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jeroen de Borst <jeroendb@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>

