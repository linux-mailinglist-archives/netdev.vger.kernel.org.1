Return-Path: <netdev+bounces-182499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86924A88E28
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 23:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39B213A9E5B
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796461EF0BA;
	Mon, 14 Apr 2025 21:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9VUPHtZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F5E1E47B0;
	Mon, 14 Apr 2025 21:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667315; cv=none; b=F2iTUYNtbaJ5gjbBYqkGYlL6TOLri0z441zH0psDV1KEEphaLFNsKk/8X4l97QD5YSnDJAUTELF3Lc0li9uU4yjIZ8WzGGfep3xbVKjaOLDHJD73UzLS3E8iICQ84cts2/o7MEkgFDop0uGtbs90Jn7jdkDezKzjXtUz1ipibvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667315; c=relaxed/simple;
	bh=w6PSwBtMwyxQwRU6pbgmBPwhQ23482V1wf2Ekl+BAbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B8JoDdTbizSC6lGMyAKNYev3aPVkNuLUmISnjegipocxKc7qJQ9/wdLRo9jCzNmBUfHeRPn5G3q8J8EROzKcjnQBOnTR7tw89cxv9cpDGigFBkYzkYl5YWi7GbTW3/RkBWXswnJPDzVSKuOFdkxlaLbnm465E4An5ETUmSBiG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9VUPHtZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71728C4CEE2;
	Mon, 14 Apr 2025 21:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744667314;
	bh=w6PSwBtMwyxQwRU6pbgmBPwhQ23482V1wf2Ekl+BAbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u9VUPHtZZc3b3rBTPM1uwEWFXSbDKKNRuHRqKq+5faag+Kd+55nRVIJMTeN6SgNa/
	 XtZ6mYd8y3wVGLkwX3Ny+wS6GxJZHllS1zsOTNyD4l+JtLL5V09x4AVw7p5nuuIjvN
	 st/U0F0NRrwKipDDItD6PcNYztY5MS7m5EJVD7ewbvX89KL/ioPLd4ENIzvwkffHEk
	 wHYfwlhI9bWPQGuNlm5fp3/W7tveXW7920dqAO/7zq9vBILO13P196tPyQh/Oskvsp
	 jKOQS209RsTjbpzT9M4ymmL8PtMlTvEj5Jy8fUlQa/QSv+Lwx7VqXNPCSRyWqRkur7
	 8rUCVcECSeeNA==
Date: Mon, 14 Apr 2025 14:48:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next v1 03/11] net: pktgen: fix code style (ERROR:
 else should follow close brace '}')
Message-ID: <20250414144833.063237ae@kernel.org>
In-Reply-To: <20250410071749.30505-4-ps.report@gmx.net>
References: <20250410071749.30505-1-ps.report@gmx.net>
	<20250410071749.30505-4-ps.report@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 09:17:40 +0200 Peter Seiderer wrote:
> -		}
> -		else
> +		} else
>  			sprintf(pg_result, "ERROR: node not possible");

While you touch this you should add brackets around the else

