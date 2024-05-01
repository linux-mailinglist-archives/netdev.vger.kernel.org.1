Return-Path: <netdev+bounces-92827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7018B905A
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 22:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B37B1C2170A
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 20:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBDA16190A;
	Wed,  1 May 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmCwRkwh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA4C17C6A
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 20:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593646; cv=none; b=kUWVjDHQtyuCiXXVj6kKDevfSxg9KoGrKo0lDet2Af31shFmpXRmzuaFDe0itVCU+jbjSDOAyVJ8F9gyOhmTZUEbxdd75cZ+4ZVxblw4rW0FYzR2/D0JjKI6PkVMw8FHPxLqKPp5NtpY1Uy+kSXI/rmM9oZskq/NzqJ9NmcGbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593646; c=relaxed/simple;
	bh=28fACtwGVzPSJbZg8kUIuIg15gXSHBAr2Lcxdby9x3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laoPPCXQVMQVT1nPNKT+lXwYbJ4twtkhOAIAxgVJUq7JMy0OiB279ASFe5n6FIfWnKCYsTL08PNzhF/fSJzsQMsXYqas5udoTg+gCXfa8ry+vPtnToLIqXLW0251AXztFWgXZBVs9FhGEvGIkpTQEHvc29Z4xjS0nR8UycZXAuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmCwRkwh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C689C072AA;
	Wed,  1 May 2024 20:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714593646;
	bh=28fACtwGVzPSJbZg8kUIuIg15gXSHBAr2Lcxdby9x3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lmCwRkwhzxEZnlQF11PGdOw7rtJArwv4xG08ZTtXesYwrogQDTPG2bQpQZOXwa3bR
	 hD635Ft2zTofRHdCg/S9pUQcbJTZ5JWN+L+mhgVqLgvJNEuGefqC3GWeN8vwgFoDG6
	 Chl2YDcwkl0BRhLKpC1fYMGaiIV3Qa7rAEpbQqG4+GuLzaybxqAJ8pELBkuNDu0YHG
	 8osmGhUH/4SZQYFu48XGG53XFdgQ8GOwoVQKwLhKkhS2Fruiw6IiFR3xoZRm6uo6Z3
	 ZvP+341J86StfiotE+93ON0ciIYEMdZII1URCVAnX0iizZq1xYsCRZLAhFbVElQYPN
	 MOJZC8kILu9KA==
Date: Wed, 1 May 2024 20:59:12 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, christopher.lee@cspi.com
Subject: Re: [PATCH net] MAINTAINERS: mark MYRICOM MYRI-10G as Orphan
Message-ID: <20240501195912.GJ516117@kernel.org>
References: <20240430233532.1356982-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430233532.1356982-1-kuba@kernel.org>

On Tue, Apr 30, 2024 at 04:35:32PM -0700, Jakub Kicinski wrote:
> Chris's email address bounces and lore hasn't seen an email
> from anyone with his name for almost a decade.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Hi Jakub,

I checked Lore and agree with your conclusions.

Reviewed-by: Simon Horman <horms@kernel.org>

