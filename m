Return-Path: <netdev+bounces-186203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC69A9D70E
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 03:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80814A6FA9
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 01:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98071E9B15;
	Sat, 26 Apr 2025 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="asqp7HBH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35A91898FB
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 01:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745631769; cv=none; b=RVbibBW4TcfqI88FRiamCMyPbefd1XP+qH9YAkSIbJZF3v3Q+QXzxSqH9nOGS+FBXSngBv3uCTyHSL7HsKKWwy1aaAq+MtZTLtwXB6Jaep4V6hp5qNFGjuUWl59RXj1BorsE0oeUzNBQCy8/+dIrH6jDdm5JvvTYQ9tyoCFHwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745631769; c=relaxed/simple;
	bh=uYM1mZVaY7Ux2ye34SeTo+hoFKkKcWehB8OGTlRV4V0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXbrmt/scpOmVBEZrfqavvEWpLFOh60FMTSW641SziRr5OtPTFfG3AhaelUN241gMhcSiEbTNMHhgbeToFo735HyBlycZRLcCx167T72vSxU+dLoA0qrrU+JkxZdVO+cpyRkggLHTRGH+FnBkXKZMYj9nCM88FTLLogmzmmsTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=asqp7HBH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080F3C4CEE4;
	Sat, 26 Apr 2025 01:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745631769;
	bh=uYM1mZVaY7Ux2ye34SeTo+hoFKkKcWehB8OGTlRV4V0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=asqp7HBH5BMRRLmTq4l8SA3AXjxCvfy/O5MkIN9G5b2CUxTdZbHM+gitH3RjxYCtF
	 JIF1mih7tCquseYUwIvxbcwvTcSkwuwyrqOIqOqwrCVn1UD69DzGRoPMaEDvTw/4+n
	 ElGpiR0/OJ26iufU7QVImrioNWAQEmEI5J0tXpGJtLJzGCCIr7Mr479oRk3U1baRjt
	 HnCqcyPEZaM1nTbwXdHS+G3HW7toSeJOGob07aiBXGWR6gLh3O54gOouTs/iq18XW9
	 s/TaMKMT4k+pKJtfIhvpDfJ9ekiehL8RtkRZMu69yeNz/xO/2JTCrXw9hYbU1KV2h0
	 HEZhwAh7B2Kvw==
Date: Fri, 25 Apr 2025 18:42:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 2/3] io_uring/zcrx: selftests: set
 hds_thresh to 0
Message-ID: <20250425184248.226460d3@kernel.org>
In-Reply-To: <e668fa44-15be-4734-9b3f-a7b922c27c00@davidwei.uk>
References: <20250425022049.3474590-1-dw@davidwei.uk>
	<20250425022049.3474590-3-dw@davidwei.uk>
	<aAwRqSj8F--3Dg2O@LQ3V64L9R2>
	<e668fa44-15be-4734-9b3f-a7b922c27c00@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 16:37:26 -0700 David Wei wrote:
> >> -def _get_rx_ring_entries(cfg):
> >> +def _get_current_settings(cfg):
> >>      output = ethtool(f"-g {cfg.ifname}", host=cfg.remote).stdout
> >> -    values = re.findall(r'RX:\s+(\d+)', output)
> >> -    return int(values[1])
> >> +    rx_ring = re.findall(r'RX:\s+(\d+)', output)
> >> +    hds_thresh = re.findall(r'HDS thresh:\s+(\d+)', output)
> >> +    return (int(rx_ring[1]), int(hds_thresh[1]))  
> > 
> > Makes me wonder if both of these values can be parsed from ethtool
> > JSON output instead of regexing the "regular" output. No reason in
> > particular; just vaguely feels like parsing JSON is safer somehow.  
> 
> Yeah I agree. JSON output isn't available for these ethtool commands as
> support for that is quite patchy. If/once there is JSON output I'd be up
> for switching to that.

Joe is right, gor -g JSON is there, IIRC the only one we use often that
doesn't have JSON is -l. You could also switch to YNL directly, fewer
dependencies. But probably not a blocker for this series.


