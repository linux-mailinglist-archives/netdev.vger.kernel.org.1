Return-Path: <netdev+bounces-181440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD39EA8502A
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 01:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852444A3B5D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 23:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E0420E037;
	Thu, 10 Apr 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qv0K3Cj+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596F20C49F
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744328350; cv=none; b=AiuvZwiCu0c1vvv5nRORdgjOxfSoTXs5FaqhVw/GJhrCRRcw8hYb0TU96Jgi09e6IT5Pqx5+DdWKfifxpMAU8LwYro8I5HPP3Jd9ffRvHoqCbPr9nblC7xa3A/NNj8XbnoRg4slFy3aMeN2umg2wtaqGiMRUWSdkY155MPI9NN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744328350; c=relaxed/simple;
	bh=Tbak8IBPyMkkvCebM90Qho3nuValo+SC5zQu4r9Rcp0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGz1T9DBw+kead3Ah/xv0oqIbf7u4SnxoPY0mPsXc/mTVjaE0sZ6CH4SKRQcDfswtU+zZIg9jiySdsAAa12SqBRrhJ81PrJARW5jeqR7q5dxlUgRBvWyqiRcHIFJ71Y5L9fywGjeFEJxWrvLNDOarXJGT/SODeTYd0PAtbcZQgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qv0K3Cj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AF1C4CEDD;
	Thu, 10 Apr 2025 23:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744328349;
	bh=Tbak8IBPyMkkvCebM90Qho3nuValo+SC5zQu4r9Rcp0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qv0K3Cj+BQpnmE9lMYxqNlKltwzja+Q+Yc/huG66598Vv5Mwk7sy0UiiVX8v/3U35
	 +nA+q6eY5HDqeOrlDwcuABvClOaHt8Fc3d3L/ff71DQ2ZJPPajCh/xE4qTfqDaPL3u
	 Hy+gsmwNABNKp8zhQTteTkF/Es+gvo/PtcyyhQ/FE99vzeo9kb7wsUVxDuMYtZlpUa
	 QNssSCMQ6pekx/LT1NjSZ7Dyvk+sjB0gV5AA3WGuOV64Xyyl6j+ouO3BjRSQverYt4
	 wGYABYIhRLZ9Mbief3xOfdxos6mvTCefMN9yKKKVNZqiOOMs8dj4Aw1mRm56kOdppa
	 oGC1/UXnA2Myg==
Date: Thu, 10 Apr 2025 16:39:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "Dumazet, Eric" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "horms@kernel.org" <horms@kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>, "hramamurthy@google.com"
 <hramamurthy@google.com>, "kuniyu@amazon.com" <kuniyu@amazon.com>, "Damato,
 Joe" <jdamato@fastly.com>
Subject: Re: [PATCH net-next v2 7/8] docs: netdev: break down the instance
 locking info per ops struct
Message-ID: <20250410163908.07975fa9@kernel.org>
In-Reply-To: <CO1PR11MB508998C288EEE2BFD2D45F44D6B72@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20250408195956.412733-1-kuba@kernel.org>
	<20250408195956.412733-8-kuba@kernel.org>
	<119bf05d-17c6-4327-a79b-31e3e2838abe@intel.com>
	<20250410090802.37207b61@kernel.org>
	<CO1PR11MB508998C288EEE2BFD2D45F44D6B72@CO1PR11MB5089.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 22:35:43 +0000 Keller, Jacob E wrote:
> > > Does this mean we don't allow drivers which support
> > > netdev_queue_mgmt_ops but don't set request_ops_lock? Or does it mean
> > > that supporting netdev_queue_mgmt_ops and/or netdev shapers
> > > automatically implies request_ops_lock? Or is there some other
> > > behavioral difference?
> > >
> > > From the wording this sounds like its enforced via code, and it seems
> > > reasonable to me that we wouldn't allow these without setting
> > > request_ops_lock to true...  
> > 
> > "request" is for drivers to optionally request.
> > If the driver supports queue or shaper APIs it doesn't have a say.  
> 
> Which is to say: if you support either of the new APIs, or you
> automatically get ops locking regardless of what request_ops_lock is,
> so that if you do support one of those interfaces, there is no
> behavioral difference between setting or not setting request_ops_lock.
> 
> Ok, I think that's reasonable.

Right, and FWIW we may one day actually make the request_ops_lock 
bit be _the_ decider and auto-set it based on op presence when netdev
is registered. Purely to simplify the condition in netdev_need_ops_lock().
For now it isn't that. I was worried if I go into too much detail here
we'll then forget to update it and stale docs are worse than no docs :(

