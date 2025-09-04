Return-Path: <netdev+bounces-219848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D4B436DA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 11:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 683E95A0DA8
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 09:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DDE2EE61D;
	Thu,  4 Sep 2025 09:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZVtgZfu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420072EE60B
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 09:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756977517; cv=none; b=ShZ7/eLKleJC2Nx7nGDZs5CUzdWsXWV3Uft18dIp2RmO+u41KpF/LfY5PDmaPVhcDIaQlO3zHxHT87lmfZ4+I3/KJTuho8t5z1Zr3UmXks28thJSV3+U8SNzWWNzQWTGmalcj5vhNdewOKxLpQCSTkkz95KqAOvx+xnx+w70kUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756977517; c=relaxed/simple;
	bh=GgTHUyOU8d7/PESNdj0Gx7SrO5R0MXBvqvTKhGCMWLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XspY98M27D3kQXr36XQd3AYxriitrbv+mplM3U0OiF33YTFtReiLBEvsDey6IZJmZyq2jU6ZSRVJczPwobYZahpwp/4a0euwHlzTYZwV5BxaNCAMA1Py8376EQHlTS9ltlSDBWf31WV/Bz3EOzt6gRG12WuSreqLJdqs3pQ0tvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZVtgZfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ADADC4CEF0;
	Thu,  4 Sep 2025 09:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756977516;
	bh=GgTHUyOU8d7/PESNdj0Gx7SrO5R0MXBvqvTKhGCMWLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CZVtgZfu+eWNy7V55vJIOfhSfQoCgqJnslwp2yKfSg3IBanxra7Tq+dJ/PGJZuXuR
	 XT729vNqNQvKcQ8zUZP+hfsTjYzz17wQSNyfpicOOkftxPiumI4rr8OEgFFMt2YQvI
	 hX8or+Vf6hhzHKSF9ffgk5bRRzPxi8GjR7QaQg3Ip7dBRlJYCp5GF7yHOkrQU81dwM
	 lfDg/V391KODZ+a8dRD8fq/r5X0MPRtaEkRlFYwpwHKMjU6iqVVwjLssdUPjeLDOGy
	 gax84ITRCPCB0FxHRoZ3P49T/jWWUqIM5DeFUzXcHilI3CxZPQBZdikqbVbZMKrvVD
	 pJlhhSuBG6V0g==
Date: Thu, 4 Sep 2025 10:18:32 +0100
From: Simon Horman <horms@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] udp_tunnel: Fix typo using netdev_WARN instead
 of netdev_warn
Message-ID: <20250904091832.GC372207@horms.kernel.org>
References: <20250903195717.2614214-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903195717.2614214-1-alok.a.tiwari@oracle.com>

On Wed, Sep 03, 2025 at 12:57:12PM -0700, Alok Tiwari wrote:
> There is no condition being tested, so it should be netdev_warn,
> not netdev_WARN. Using netdev_WARN here is a typo or misuse.

Hi Alok,

I agree that using netdev_warn() seems more appropriate.

But doesn't the difference between netdev_warn() and netdev_WARN()
lie in the output they produce rather than testing of a condition
(or not)?

> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

...

