Return-Path: <netdev+bounces-121274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B4495C80F
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBB41F239CB
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D44143C5B;
	Fri, 23 Aug 2024 08:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaAxMLKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B2140397;
	Fri, 23 Aug 2024 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401712; cv=none; b=RtOM7esUesVjzbQ8u+WbKRZfexFGNhO2L4lWjpdNOf9B5YLSHirlvfuVLULVTUxm/p7KZH/Y1C1G5T+3zuxO1clE57QnvmCmTLlCshIRqp892ebHQO7TCVNzSo5+duYeZB9zqOGxBaIvMDQtfdFPFbkL+dorO1GM521yEJOx7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401712; c=relaxed/simple;
	bh=Th32cuB5eevmkr9+C33ucO995EYDQ3oqEYQBH3SolPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOaonvZ9+8i48CmKbDqpQXqylrdCK+mcGJiGM+Xb9SJGkh3ravA9/UZXP5c054X0aNg1dd/dPPphxGj8v7kYPAP3huuR9iUfNimUpWSBabto3tNKFroEEqg/WDOJboC7QBJlfs5G1pNHzatzRkn3E/VQxBHLnRAtNvAG++ns8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaAxMLKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBF5C4AF0B;
	Fri, 23 Aug 2024 08:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724401711;
	bh=Th32cuB5eevmkr9+C33ucO995EYDQ3oqEYQBH3SolPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaAxMLKJaf4pgvpGwesErDEI79kqgS6eoYBUb4Ne20q9KGJw7h2MVCSVkeI6eZmcC
	 qU/oR2ySfQEzkkd6ecEaGWfM067aEEa3HfFuNpO1Jrn2c8vkshe+fdS673DZJBcSvS
	 yR25anXp5oGlcG0rxtJhimxmRdYoS4N1B+b5b4wiEX8f3Oia8hc47hJodAdRB2xYLg
	 6eCxdEBUGkX/lvtIYcQ9pJp9JqJvnC+LKBE7h9G52wupYvLrg1IGPfmrO3raXowAPX
	 jkiR/ZHyNdL0S3NZGuLMnR7QD5sNzsFSWQhRvPHGQKUSDNgoWsZdbG95AbXEqtl12N
	 1FSxcfNQ9GKVA==
Date: Fri, 23 Aug 2024 09:28:27 +0100
From: Simon Horman <horms@kernel.org>
To: Yuesong Li <liyuesong@vivo.com>
Cc: mark.einon@gmail.com, davem@davemloft.net, dumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH net-next v2] et131x: Remove NULL check of list_entry()
Message-ID: <20240823082827.GT2164@kernel.org>
References: <20240823012737.2995688-1-liyuesong@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823012737.2995688-1-liyuesong@vivo.com>

On Fri, Aug 23, 2024 at 09:27:37AM +0800, Yuesong Li wrote:
> list_entry() will never return a NULL pointer, thus remove the
> check.
> 
> Signed-off-by: Yuesong Li <liyuesong@vivo.com>
> Reviewed-by: Mark Einon <mark.einon@gmail.com>
> ---
> changes v2:
> - update the short log and patch name

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


