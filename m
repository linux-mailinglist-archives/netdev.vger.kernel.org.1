Return-Path: <netdev+bounces-162565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A952A27390
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7925C164ABA
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D147C215058;
	Tue,  4 Feb 2025 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3IFFMyU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B00215045;
	Tue,  4 Feb 2025 13:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738676578; cv=none; b=dvuu+WmqNh5vSmITZ8sM0an1ZAOnbqMgG2cc+f6m+APE04I/AaSJf4OeD0PpBpkuHgkJ0VRLBd3cZSPcSEXbnGfC68SOt/vQX02C6lCcU27SxZ8Q+DlxE+xeP02ooABwkotTANSS0ySgxrtoBA7u55O2PPamvvdrBVGBtdfVLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738676578; c=relaxed/simple;
	bh=lQrEUhXHQzlD1oThlVXaIwT5NyT0Y7eL+hQ2kQGzbWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojTY+st/086dmX1Dh+p5lCVySqtyt+0y4rdewpR1EP2uH2dfA1s8bnpbNrOu7gdtVtE4of9mHC0vpXi6GKALh7g3eCe1/zzdDz8Jj0u2H+f0oYLunVX9pHW7HFDAQv+dnzc99JHSXF/m7Y/HQRDK0t7PXcxroXOmPt/ALYsfW/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3IFFMyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EEEC4CEDF;
	Tue,  4 Feb 2025 13:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738676578;
	bh=lQrEUhXHQzlD1oThlVXaIwT5NyT0Y7eL+hQ2kQGzbWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3IFFMyUIvFvbrrzoyV2QuaGzVm9pA69TbUloMTZ7sPHCgFKoU+4/XbkzroyDqBkg
	 gmRFYXDVK75h2JBNxvSiYv2vm3/qMFsFIxHWCYDCDEfIJdwL74znuuv2pd71bBmWIO
	 TQ1ctf+r9OuusHj0AtQW1ZCnElVFnnoh5rCRYjU9efKDYFj39wYsObLtqR/8BHhRDk
	 2P2SKikItNdSIifI21Aw020wbxsTWQTi3FygDmG7BDJPyMAi6nqDnnp4zC9lukAjdm
	 AYwwPHiRAq1va4wKe6VxdtGXs0RuEO8pLYTminJMUwYv9wVI9xDo6YubkIOPOGYKiP
	 w8kmW7N/5Z7Tg==
Date: Tue, 4 Feb 2025 13:42:53 +0000
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] net: atlantic: Avoid
 -Wflex-array-member-not-at-end warnings
Message-ID: <20250204134253.GC234677@kernel.org>
References: <Z6F3KZVfnAZ2FoJm@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6F3KZVfnAZ2FoJm@kspp>

On Tue, Feb 04, 2025 at 12:40:49PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Remove unused flexible-array member `buf` and, with this, fix the following
> warnings:
> drivers/net/ethernet/aquantia/atlantic/aq_hw.h:197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:197:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Suggested-by: Igor Russkikh <irusskikh@marvell.com>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Remove unused flex-array member. (Igor)
> 
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/ZrDwoVKH8d6TdVxn@cute/

Reviewed-by: Simon Horman <horms@kernel.org>


