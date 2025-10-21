Return-Path: <netdev+bounces-231147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 17097BF5B4B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 12:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 078AA4E594E
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 10:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190B2EA17D;
	Tue, 21 Oct 2025 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozjL/Lwq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210E028CF4A;
	Tue, 21 Oct 2025 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041418; cv=none; b=PnsoS72N7EAEACc/gWCst9Ej0DOVK9VObenx+9R8pmwvRUjQ/xKnvvgr3klqigYVqkJHK1iwONqhW1wk7HeIkTn8nVkYRXgxZAhg7cAqwnIdrIgDoNDaK3fpWyXp7SY/T+90f0Xu89MGkkX+M2+s9WbI9022/7n++MJRGpCKYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041418; c=relaxed/simple;
	bh=wdMdYaYJd6Zc7ZYjyTWJDWk+yKu5stMt22kNukGBRfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZNwi6Me2/nyT8mNneKXzHWAAzh3cGfZ2Tgxf4i3by8dbh/j8DzK4p2qN+NXqELVPU9S5ub5+LFUOwT5OxsznDuQ2u9UmPteZ73KCJp5/WMCTmssFBsLm8hm1WEjGUHshg3CZd/2W4QpdrNJSfmAKFJHBBUOmAsxdH34NXA+/+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozjL/Lwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D04C4CEF1;
	Tue, 21 Oct 2025 10:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761041417;
	bh=wdMdYaYJd6Zc7ZYjyTWJDWk+yKu5stMt22kNukGBRfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ozjL/LwqC1sm98ttTiCqeq3GcZ7L9g0wIrkhd+b/Sae5JLIlQxQ9ilakyDXUE2czh
	 4ZRSp3plFPVLFhydnZDKA2UWSf27ZbP5zHzWsIaG09PdQPfwSw5/aiS7MmSfThb28A
	 soanLs3+kgyJ+OhunoPNgGSm7c3T1jbzeiQmQsQi2ZrdCA8MkWD7GlIGkR5M7wzDkl
	 asdhvGrz0+/8dVaf8HS9oMIl2hv5NbhsESeymn682pLcgu49LuA5RRXkjzGtTHQ6CG
	 F3LNr3oUkFetRauS3eAVcr6Vgv1hqg1UxZ9uEZfMlTJYNlRGjyYxm0TYBNjWzaVfNj
	 2Z5AtOTU0IYNQ==
Date: Tue, 21 Oct 2025 11:10:13 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next] net: rmnet: Use section heading for packet
 format subsections
Message-ID: <aPdcBV6-4BQdCWz5@horms.kernel.org>
References: <20251016092552.27053-1-bagasdotme@gmail.com>
 <20251020171629.0c2c5f5e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020171629.0c2c5f5e@kernel.org>

On Mon, Oct 20, 2025 at 05:16:29PM -0700, Jakub Kicinski wrote:
> On Thu, 16 Oct 2025 16:25:52 +0700 Bagas Sanjaya wrote:
> > -a. MAP packet v1 (data / control)
> > +A. MAP packet v1 (data / control)
> > +---------------------------------
> 
> Why capitalize the "A" here? it could have stayed the way it was, IMO
> lowercase is actually more common and (at least my) Sphinx doesn't seem
> to detect this leading letter as in any way special.

It was a style choice on my part.
Which seemed to make sense to me at the time.
No other reason.
And no objections from my side to sticking to lower case.

