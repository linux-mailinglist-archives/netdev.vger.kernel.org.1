Return-Path: <netdev+bounces-178541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F0FA777F9
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 11:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59BE47A37E4
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 09:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD7B1EFF82;
	Tue,  1 Apr 2025 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzrC+NPm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757871EF39F
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500570; cv=none; b=JorwfFAeV4fopy8Jgos0We951HpM0+RHeJWkiQSi6M3A/kSY1sRvT1ehfDzm/GfomozPgtFkjVNLJNG/ISJEpfLlKNtACHIOQY+aamVlc5Fz7wRh0iLLJfxjykP/5FwyTrF69FX/5O5p4D8QHoF4Gu80EFZLwBG7ztK1OmvnHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500570; c=relaxed/simple;
	bh=CIdYldIE+r1A+S4ROQNjWmUj+jWkbraKFZiC38rnkpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmTikJ7AhQPy3eCA0103wiLmA/SkPusHXxmKh5pEMdMiWE+I1hX0OJVXPNhXc6/HpAo6g83lzYZ1RHH5s1r5xTm1Y1EzVTb+/Xkndi1Ct3xeFpDXnLjiO5ZyiqSJgoMyH/IiEtKjBbqgs/WbplozZPPQG/A3jo90FVuX+K3xBps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzrC+NPm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5EDC4CEE4;
	Tue,  1 Apr 2025 09:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743500569;
	bh=CIdYldIE+r1A+S4ROQNjWmUj+jWkbraKFZiC38rnkpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uzrC+NPmPgPOMfwiPzYfBTAKt2njyWppHWl3Oag/eZLMS1txKQlIZu1K1NMgi3C70
	 LMzrDeTTmrIxAQ/TYkJ4l4oTlmdShONGY3x2oDXOGrdwQQY9h2CZvO1QkqtEtKlWsH
	 mg+0i/+6hp/UGwPWe8vcgofSb/7nJD5XAu0eDn+VPaLuSDIWTLFkCM+GivdLsz6q6E
	 Z5EN0Muw0qLqDycc5Yi6nxn7PwUIpTh7JFiYLeW4JFQkDm2LI2bSXIO6/+QlURA6HU
	 U4p9WMaAEeoUy2cZJhgbTXB6sqg0xdnIfvOzkeTQPOv456AV2HJLC/U10qNylDcoUa
	 /hKgz7OW5hjng==
Date: Tue, 1 Apr 2025 10:42:46 +0100
From: Simon Horman <horms@kernel.org>
To: Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc: netdev@vger.kernel.org, sowmini.varadhan@oracle.com
Subject: Re: [PATCH net] ipv6: fix omitted netlink attributes when using
 RTEXT_FILTER_SKIP_STATS
Message-ID: <20250401094246.GB214849@horms.kernel.org>
References: <20250331163651.9282-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331163651.9282-1-ffmancera@riseup.net>

On Mon, Mar 31, 2025 at 06:36:51PM +0200, Fernando Fernandez Mancera wrote:
> Using RTEXT_FILTER_SKIP_STATS should not skip non-statistics IPv6
> netlink attributes. Move the filling of IFLA_INET6_STATS and
> IFLA_INET6_ICMP6STATS to a helper function to avoid hitting the same
> situation in the future.
> 
> Fixes: d5566fd72ec1 ("rtnetlink: RTEXT_FILTER_SKIP_STATS support to avoid dumping inet/inet6 stats")
> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>

Hi Fernando,

I think that it would be good to describe what problem the user experiences
without this change - yes, I can see which attributes aren't dumped,
but what problem does that cause? Doubly so as this is marked as a bug fix.

Thanks!

