Return-Path: <netdev+bounces-162614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC84A2762B
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2D97A12EC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283232144BE;
	Tue,  4 Feb 2025 15:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QETjqWaX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCE2144A6
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 15:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683482; cv=none; b=COVmZJcvLVnRIV6h7CxUmm5TbUPE5nKXF/RVj/nZVuvnD5g8KJ36dFxqICJ3Fh+iEBW0Ct9pA5rdzAkEfAkMk20esa7QHZTgPmr3p9kVqYa0yNaQV4ShA63S4LrG9Tjz9KWDu7ZO9g2nCdBUctc7FxL1AG9ps0k5LjY/maxaHaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683482; c=relaxed/simple;
	bh=ELj0jFYoWwL5sfslYQB0IZBs6s55AOGymmsQ7gzepBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aDvCQ57uNORwxb9RRdXFITEZWioqtqgBDKpwAcDf4muy6zC+MN7Zc5Ntr/u+9G+o6OfrgPijOLAl7DU0iwGVd54sqDKtuk/U/89tZ2Nd6lje4j+Jq8AVyMpKmaOSVt56XnrPpFHmU6/Fbg1is0JFKsrNGzQF1D7bKa+fs7MyBqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QETjqWaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15AB6C4CEDF;
	Tue,  4 Feb 2025 15:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738683481;
	bh=ELj0jFYoWwL5sfslYQB0IZBs6s55AOGymmsQ7gzepBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QETjqWaX/cMI4pEve5BnKc0XDo1iRHW9XuYTZrBRmGYqpnCeSsXPznkaTyHX8ad//
	 5DEYT4U77w2g0nccpoUvd3YSgQbd0bXmlzING/cGCyb3eSCtROity374/va3FfcOut
	 4HWKpeYkznAYrDOzOZMKRgETmjt1SqS6VqDLLu8Xg/WgbRxNccUCxzi581Mp9nDjxe
	 W435d7odC2jVs76Il5sOuMLR/X5IC96xcc7dt9Ee6Vme6vQZB4TPBn0srcVIHJ8HbK
	 mXSAlDOsK6sIRuniYvxzqGNVYiVApR6q/Jg3FGez7f54Vjg/dydDQRjNMtiOsTRmat
	 QDmtb/DKWStEw==
Date: Tue, 4 Feb 2025 07:37:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net 2/2] MAINTAINERS: add a sample ethtool section entry
Message-ID: <20250204073759.536531d3@kernel.org>
In-Reply-To: <8ef9275a-b5f9-45e2-a99c-096fb3213ed8@redhat.com>
References: <20250202021155.1019222-1-kuba@kernel.org>
	<20250202021155.1019222-2-kuba@kernel.org>
	<8ef9275a-b5f9-45e2-a99c-096fb3213ed8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Feb 2025 10:26:40 +0100 Paolo Abeni wrote:
> On 2/2/25 3:11 AM, Jakub Kicinski wrote:
> > This patch is a nop from process perspective, since Andrew already
> > is a maintainer and reviews all this code. Let's focus on discussing
> > merits of the "section entries" in abstract?  
> 
> Should the keyword be a little more generic, i.e. just 'cable_test'?
> AFAICS the current one doesn't catch the device drivers,
> 
> I agree encouraging more driver API reviewer would be great, but I
> personally have a slight preference to add/maintain entries only they
> actually affect the process.

You're right, I was going after the op name. Seems like a good default
keyword. But it appears that there are two layers of ops, one called
start_cable_test and the next cable_test_start, so this isn't catching
actual drivers.

> What about tying the creation of the entry to some specific contribution?

Sure. I'm adding this so that we have a commit to point people at 
as an example when they contribute what should be a new section.
Maybe I don't understand the question..

