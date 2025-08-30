Return-Path: <netdev+bounces-218428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95694B3C6CE
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF2A1CC277C
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F2F1DB125;
	Sat, 30 Aug 2025 00:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMKCzPhq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BE1A2387;
	Sat, 30 Aug 2025 00:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515144; cv=none; b=oqg4CLWGNFbu3DqEs3tUQvo0dkKuQAJspdXmDdj2Mc+dKCsxWFOPSXH6U7Y/YCnOsYaDQm01FwHJdTO+UbvUb0NHF9ObtJ1xryDAHbZ8l3Cfw/6GFA9QsM/Y8gLt3KclFZbDa3EtoB/JI+FKYRzbZLaiZ95RB5meWlRpDDgwkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515144; c=relaxed/simple;
	bh=vaE/eEvTq8QuZ7ICruT356FPZUXLmbt9wtJWA7COzzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzW/Tv8c8bhgdBSnqpQTzpLWj8B6E29B4z6UCZ6aMWxKWfJE+0A0Vb3OMhldhjySZUMLXjQnlr5NDHNsN6dRRRNVeOVoO96HJxQQzaw44uVWi1ZwbLidNa9B8FJ4MEFjDylpjkmNdscyG3HSmwr07eE7GPrH2UkMRQ5y8mj37bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMKCzPhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92500C4CEF0;
	Sat, 30 Aug 2025 00:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756515143;
	bh=vaE/eEvTq8QuZ7ICruT356FPZUXLmbt9wtJWA7COzzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oMKCzPhq0lgvBvWYcMRY15IIUN8RFqCCqsB0skhe2X1CAzBhvPnjTwG4F1xtt4dBp
	 whJFfPHX0nCmatZaKYEJgKgir88i75nhjFbec+8TKmpdfVwfmv05Lw7Sw7ac+JHAl5
	 GU++HIuNljQlqAlZOPVPftpAH4Pa53a5hcZwqh9sy5dJvuaXFaaLOELYTbinhfQFx4
	 SKgdxEm3HH0fYpyWqb9XE8OlQjfeXAceUlP0q3E4+pD2e2vkzz1St7HS436WK24Ki6
	 zGgZa3LHb7aw3yrZNuZT02ZuwX+j9Znelf1wFLMJ3Fn6I1hvXteSq9Fb2oi9vFphg7
	 OhU+bZDl6+FiA==
Date: Fri, 29 Aug 2025 17:52:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>
Subject: Re: [PATCH net-next v1] net: devmem: NULL check
 netdev_nl_get_dma_dev return value
Message-ID: <20250829175222.32d500ca@kernel.org>
In-Reply-To: <20250829220003.3310242-1-almasrymina@google.com>
References: <20250829220003.3310242-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 21:59:38 +0000 Mina Almasry wrote:
> netdev_nl_get_dma_dev can return NULL. This happens in the unlikely
> scenario that netdev->dev.parent is NULL, or all the calls to the
> ndo_queue_get_dma_dev return NULL from the driver.

I probably have Friday brain but I don't see what you mean..
In net-next net_devmem_bind_dmabuf() gets a dma_dev and returns
-EOPNOTSUPP PTR if its NULL.

> Current code doesn't NULL check the return value, so it may be passed to
> net_devmem_bind_dmabuf, which AFAICT will eventually hit
> WARN_ON(!dmabuf || !dev) in dma_buf_dynamic_attach and do a kernel
> splat. Avoid this scenario by using IS_ERR_OR_NULL in place of IS_ERR.
> 
> Found by code inspection.
> 
> Note that this was a problem even before the fixes patch, since we
> passed netdev->dev.parent to net_devmem_bind_dmabuf before NULL checking
> it anyway :( But that code got removed in the fixes patch (and retained
> the bug).

If the bug exists in net please send a fix for net, and ignore net-next.
Maintainers will cope with the merge.

