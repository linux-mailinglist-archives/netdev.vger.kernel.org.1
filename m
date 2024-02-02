Return-Path: <netdev+bounces-68604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 343118475F2
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCEE91F261BF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCAB148FEC;
	Fri,  2 Feb 2024 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofEWPwwt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C31C45BF3
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706894292; cv=none; b=qWD6isLypOH8+IZ1UCMHhMosaGIO9OSCJK4yYL9x9KUWkB7rdxnl3FyU4uFAOoYajdaPZY7JUUi3fxTVaMzRWgBkIJS3ehD1/ndOZZujBs8VWazp1OTik6WmvpCmb1Hhuk/+7obRektAl/yfcDGjz6lMa5UHcL8wYMKWF4JHn9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706894292; c=relaxed/simple;
	bh=mTQpAVj7Ewz7qRcOhpB8XMamGD5kDsPz+5ZWXExfk9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YF4MUY7sL4qX7aO26OlaXCX+1Ac944bALWesMhXQJbR/bQd6UinMZ44sY0HjzxnhuVY8RhW2/d1Lac6vI7wdL+UrgWzCUx/rGCBCLC64Ll2T+PkvaYLqS7KUwLig5PDLg3pqS0hyowZOM7tEK1Tv4FE3oXnJO9huCmYJ/sdNYHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofEWPwwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AAEC433F1;
	Fri,  2 Feb 2024 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706894291;
	bh=mTQpAVj7Ewz7qRcOhpB8XMamGD5kDsPz+5ZWXExfk9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ofEWPwwtqDkSqZIOv2vLm45rJ/UEXBWf2MUUNgpMkSPDt8EakRtXkBob4QnyVg6gq
	 cYPZHriD97iFyR1hvqV4BI23G382E8+YOnrHptmNz1BURXZcwmYo2hnj9p36hfHX9i
	 k2MYM2fkLAu5QmHMCdYVynjO6TqVD/6qqnQDs460lkfL0Df0tXyJ9P4KIa9PXgq8m4
	 SgtgAc5GrWD4O9PMqX97LeS74LEFrS/yVNNlcgnfKjxt/ChgBmh0ue+t8jTP7SHljZ
	 et0oqbXD+Uyy3JJGHB1NOBrFUr+gi6z/eIU089C2C58e1cXrTHgMyXb0DAECssXPhj
	 +a0xg3MJ0bL4A==
Date: Fri, 2 Feb 2024 18:18:05 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@intel.com, wojciech.drewek@intel.com,
	sridhar.samudrala@intel.com, przemyslaw.kitszel@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [iwl-next v1 4/8] ice: control default Tx rule in lag
Message-ID: <20240202171805.GS530335@kernel.org>
References: <20240125125314.852914-1-michal.swiatkowski@linux.intel.com>
 <20240125125314.852914-5-michal.swiatkowski@linux.intel.com>
 <20240129105541.GH401354@kernel.org>
 <ZbtCom/grznFpesc@mev-dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbtCom/grznFpesc@mev-dev>

On Thu, Feb 01, 2024 at 08:05:06AM +0100, Michal Swiatkowski wrote:
> On Mon, Jan 29, 2024 at 10:55:41AM +0000, Simon Horman wrote:
> > On Thu, Jan 25, 2024 at 01:53:10PM +0100, Michal Swiatkowski wrote:
> > > Tx rule in switchdev was changed to use PF instead of additional control
> > > plane VSI. Because of that during lag we should control it. Control
> > > means to add and remove the default Tx rule during lag active/inactive
> > > switching.
> > > 
> > > It can be done the same way as default Rx rule.
> > 
> > Hi Michal,
> > 
> > Can I confirm that LAG TX/RX works both before and after this patch?
> > 
> 
> Hi Simon,
> 
> This part of LAG code is related to the LAG + switchdev feature (it
> isn't chaning LAG core code). Hope that normal LAG also works well. This
> is the scenario when you have PF in switchdev, bond created of two PFs
> connected to the bridge with representors. Switching between interfaces
> from bond needs to add default Rx rule, and after my changes also
> default Tx rule.
> 
> Do you think I should add this description to commit message?

Thanks Michal,

I think that might be a good idea.

But my question was a bit different: I'm asking if this patch addresses
a regression introduced earlier in the series. Sorry for not being clearer
the first time around.

