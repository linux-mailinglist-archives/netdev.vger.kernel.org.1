Return-Path: <netdev+bounces-117134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD794CD24
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 11:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0CA1C20DF4
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17F4191494;
	Fri,  9 Aug 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ag7j9zcN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2BB19148A
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195061; cv=none; b=VroxXNZsVOUqc9li7I9bb+teaHwMPrNxa32AheKqRRdfCn8VyLxFUrBkZjzdslz5liTHGFJu+zl+ekKkIl9JJ+sUWE/ddnAOzqPlxnfBt/kx2B5vF+9OImUKQxpcvoGnjOw8jkH+xZbejJtGTeZSe5LIE849JCNLFmB3I2HKHOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195061; c=relaxed/simple;
	bh=puT1umiBVLbQqjvrFTMZGBsN/x3Fqn8iVmTpXnRvjfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAmU/gv5RtWR9gUclFz1ZEc3FrYY7JFqQ2huADlE6KcPgtsOju8x8BQ2o8zRaqbVXD/7oYoqgvfwGVY5elDH8WbljrWsomPND8DHHtctN63COHTwfdTTPTnQa+lBABcGBKCLsY3voBI15+2zBeYbhwI6uUNToJ8MoEf6VYZRDzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag7j9zcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C93EC32782;
	Fri,  9 Aug 2024 09:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723195061;
	bh=puT1umiBVLbQqjvrFTMZGBsN/x3Fqn8iVmTpXnRvjfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ag7j9zcNhVlUiCzlsTqm2KKBwmtVnhFgnscdqcgs9KYQKHTQT9TH/mgBkTSTEPckP
	 V8JU7w7/nqCGACB1k7Ji0A9bJ1kweuKY2OL9hUFFAJLAnzA5xFucajXsX+v4LwiMk7
	 SmfGbFfvmJGWYpoXDtDDzWjY8Php326ZnKEUA77BekYpMO8Y/xRrY1+sNGVsS2hi0r
	 mQfgJWzl2tokSDKwJoQnPpAg1DzfI1DerSwCBhWe1LGSutFSz6KYEYoTq0FnTnTUDw
	 GYTPX6dyu1p2yvxSn42/aPzV7KgnCNMHt7w4lo48YAuwAwY2m+E0ZKbZFVSoklo3p5
	 +QfvMZQhML5tw==
Date: Fri, 9 Aug 2024 10:17:38 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: potential patchwork accuracy problems..
Message-ID: <20240809091738.GG3075665@kernel.org>
References: <20240808085415.427b26d7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808085415.427b26d7@kernel.org>

On Thu, Aug 08, 2024 at 08:54:15AM -0700, Jakub Kicinski wrote:
> Hi!
> 
> Minor heads up that updating state in patchwork is agony, lately.
> I think people are building more and more CI systems, and patchwork
> can't handle the write load. So I get timeouts trying to update patch
> state 2 of of 3 times. NIPA is struggling, too, but at least it has
> auto-retry built in..
> 
> So long story short if something seems out of whack in patchwork,
> sorry, I'm doing my best :(

Do you know if someone who can address the problem is aware of it?
My anecdotal experiences is that access has been degraded, on and off,
for a few months.

