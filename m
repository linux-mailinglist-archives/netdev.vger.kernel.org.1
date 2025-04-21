Return-Path: <netdev+bounces-184356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA99A94F99
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 12:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2CD3B2180
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 10:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3DE261389;
	Mon, 21 Apr 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFcxcSFR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394128FF;
	Mon, 21 Apr 2025 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745232855; cv=none; b=bjK7WheGWSuhlHW9f7tmhZ/0fTnVTOVgMDF3qaJKlxjGKMIprqX/URU+9uOhm+sXO8xvOLw2AAYIMkEs1YVNT0QCwyHu+4ed8SrOCnns+GGaXADFZHUbt76eKPWTCFh8eBs7Z9kzMlDLhIVF59JRugYV7wD1r/11AEv24NZiGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745232855; c=relaxed/simple;
	bh=DRdORugKIeR6R5bRkD4gd9xWB16nV73i7zTiNWA2mVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCV8RlFjMs1596I1L+wQG7Uu6ekQ1tvVkyIvV44EXmEctIS/L5ZiArMkmr8mp0MrMUYfeiY7boaAWYlThzrzT+ASmp1upRzInA2rbsp2xwht8rz8JjUrnz4ZqitpxpciYMc8LxNFFHbcndBNxhQy8TJMa37ullomgiT73UZzUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFcxcSFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC324C4CEE4;
	Mon, 21 Apr 2025 10:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745232854;
	bh=DRdORugKIeR6R5bRkD4gd9xWB16nV73i7zTiNWA2mVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SFcxcSFRHjVmgrqOnY7jfUVIBntaY6aBuS+T/UCQElPAwemJG9DiDgEmzko0TiWbo
	 3pcwz6iNS5PdG+Mm/nhJ4yroL23TL626iPMpdsBYzKh68qf9rAd5hwhGF2KZrsXlAk
	 6fTt9HC1vSndFdUrC5Ck4uH/zO84fRiD/ZqLdnI1E++/38mLg5TP3xCx5fToxNbGpG
	 yrQVd5mparxlGWrZlRK+vsK2FcuYS92O7dVoritlsBffaBPDeB7V4W7pEBIotOVhDp
	 meqppGf4jSnJm1+dyaGeAg8QBWyupy+WeGV9OgDRBybu/y2VlZtY97Lf8GkYTj0iFD
	 sGvDVkP7jOWCg==
Date: Mon, 21 Apr 2025 11:54:10 +0100
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, brett.creeley@amd.com
Subject: Re: [PATCH v2 net-next 1/3] ionic: extend the QSFP module sprom for
 more pages
Message-ID: <20250421105410.GA2789685@horms.kernel.org>
References: <20250415231317.40616-1-shannon.nelson@amd.com>
 <20250415231317.40616-2-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415231317.40616-2-shannon.nelson@amd.com>

On Tue, Apr 15, 2025 at 04:13:14PM -0700, Shannon Nelson wrote:
> Some QSFP modules have more eeprom to be read by ethtool than
> the initial high and low page 0 that is currently available
> in the DSC's ionic sprom[] buffer.  Since the current sprom[]
> is baked into the middle of an existing API struct, to make
> the high end of page 1 and page 2 available a block is carved
> from a reserved space of the existing port_info struct and the
> ionic_get_module_eeprom() service is taught how to get there.
> 
> Newer firmware writes the additional QSFP page info here,
> yet this remains backward compatible because older firmware
> sets this space to all 0 and older ionic drivers do not use
> the reserved space.
> 
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


