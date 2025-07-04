Return-Path: <netdev+bounces-204202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD39AF97E7
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 18:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC811CA7C45
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 16:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7B22F8C37;
	Fri,  4 Jul 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY39/0Tu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781682F8C20
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751645927; cv=none; b=BpBClZapWvenDxa58z+GiB5aozjnDr6JBS56xkz7akskFM9P+EZqbwhJKGhiFt5i4pZKHDUgLGjCpm3t028f8WFMLtxPFn59EpYFPIarCZ5tZkUcv2Q+My3Xa3Wh77lUXXqkGkeZn2mTXSDO9r+mP0PBcK8/JIzkBP/V0uFBFDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751645927; c=relaxed/simple;
	bh=uk/Iyrj2ONEFH02ZySNpAdy6t2iWqWlZ4rm/NiFwKJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4Ic2UkBKKXjJzfueJNQyrVta/fxRgAJCzVLt1+rw9s6QjJ7l+/0w+pk8q5ZpkDdt53wZjtHHjoTYpF63+1R8kSQlepSthhurd94j1QThumgkIkCMGig9uTtbRSkRaMPaib6eWIjBT+bMri4m9bCqYB0ZmfcOjQkGFrGmyvZEQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EY39/0Tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87198C4CEEE;
	Fri,  4 Jul 2025 16:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751645927;
	bh=uk/Iyrj2ONEFH02ZySNpAdy6t2iWqWlZ4rm/NiFwKJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EY39/0TuwgKQ4DhqX7yevyHCbXdkh6/5FOVtOaObrKKBnxFI1C0Xi1YkEXXYohRnj
	 X9wwr1xrwMzTMYmzWcHPl86wnTj7tVAyEZWf8e8FDMNgwBpXdVHbpfMA0DqATM6SJ3
	 iUw3SX+4UhmilcKKJTbw6XBjAtfRqb2gYPDqyHVMM7TX3yM1K6yWusmwpbzOa2o4/6
	 0qYBrTOwmYKV+5HMRu4f81N2UU8fRYSOBlXwq2t3gpUQCG0j6ZAu5+KHTOxpnRg8G7
	 6MMdYxeczXlxtARAIx5utMzQtd3DXE0gYbRQaRC+Si88VuHGBl5jmoEErQPYAUj3bp
	 3vJFZGPbfBBbg==
Date: Fri, 4 Jul 2025 17:18:43 +0100
From: Simon Horman <horms@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [net-next] MAINTAINERS: remove myself as netronome maintainer
Message-ID: <20250704161843.GI41770@horms.kernel.org>
References: <20250704160534.32217-1-louis.peens@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704160534.32217-1-louis.peens@corigine.com>

On Fri, Jul 04, 2025 at 06:05:34PM +0200, Louis Peens wrote:
> I am moving on from Corigine to different things, for the moment
> slightly removed from kernel development. Right now there is nobody I
> can in good conscience recommend to take over the maintainer role, so
> also mark the netronome driver as orphaned.
> 
> Signed-off-by: Louis Peens <louis.peens@corigine.com>

Hi Louis,

Thanks for your hard work over the years, I know from our time
as colleagues that there was a lot more than was publicly visible.

I wish you all the best with what comes next.

Reviewed-by: Simon Horman <horms@kernel.org>

