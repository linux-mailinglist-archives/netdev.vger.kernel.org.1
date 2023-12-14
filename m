Return-Path: <netdev+bounces-57586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CBD81385F
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D58E228310D
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17B465EB2;
	Thu, 14 Dec 2023 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PaBoQENB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63BB4CE1C
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 17:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29140C433C7;
	Thu, 14 Dec 2023 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702574498;
	bh=f5OvhBSrVQZ4IhPZugZPqW0iTO3vEY2yzdpTOJuPk+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PaBoQENB6TnK5pYxTGEbuma8YsNkXe8WscgzuleMS1db2sp11N9dsOu46dC8digPR
	 nOGBA0wwkf8b+eqWDO/HKHssQ4ct/3I936qGkUuGNr7S0d7YLjjLWTPlIRJ5pMcn+t
	 xmMFNJV2eGWGTuVp7TJOQsk/wXMqWZXSOhqdIHScRnHSggm2fphs/EjrYMd12sH8dI
	 SLlyvx6OL2ePI8IelVoDB1j8SSOq00erCfCZM9JkXNpbhylb1QWifHhCVgZTgTUPt5
	 Crormtglz/ebQ6OupTs5Pw9Dayuy92Fzoy4MMTGNJqZK0rezaxWlKKX3rsYJsVhhLP
	 YgWkQbU0xF1mQ==
Date: Thu, 14 Dec 2023 17:21:33 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: skbuff: fix spelling errors
Message-ID: <20231214172133.GN5817@kernel.org>
References: <20231213043511.10357-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213043511.10357-1-rdunlap@infradead.org>

On Tue, Dec 12, 2023 at 08:35:11PM -0800, Randy Dunlap wrote:
> Correct spelling as reported by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  include/linux/skbuff.h |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks Randy,

I checked and with this patch applied codespell no
longer reports any spelling errors in skbuff.h.

Reviewed-by: Simon Horman <horms@kernel.org>

