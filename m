Return-Path: <netdev+bounces-220066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB438B445BF
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85F3EA04870
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B16B25785B;
	Thu,  4 Sep 2025 18:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl7dKQVw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250BD244670
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 18:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011685; cv=none; b=Suq+xGDJtmyvr8tRXfZri3D3+u0yrq7AHkpi68907XW1PqQQaG2mXri/YYdHlqxBk1GmxVI+G59gNOeEYF8439dVKmoo0+MTuQTrAw9Gh5NJ1fY2t9PuChbdr8U+QKqTW1SosTnOd5+yEBtICcmy5zQkqus2yLtoDmkAoCyBSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011685; c=relaxed/simple;
	bh=K0EwR2Q8b2HPYG6V81JkmtQzM2PavrmZJwd8vq4Tx9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPaBw71p0lFGNa6MFXXZ3rBJ1dciyMfD1sdrmHgBxagAt5wNVJBdbnVHP0VPStLF5YI0ioBH5uG7sLRVkLCiuuaWSGc/VcBhjdS8wHYF6fm5/UNKhvR+uJNe1ypR6tgCL8nuldkCl0Ue5mxuZQI97hV94cuy9oOounNK+hWYf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl7dKQVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24EF1C4CEF0;
	Thu,  4 Sep 2025 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757011684;
	bh=K0EwR2Q8b2HPYG6V81JkmtQzM2PavrmZJwd8vq4Tx9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nl7dKQVwMhqy9BLj8D7u7291x3b0Run959uMnVuXi8jxOo74UpMbuO3ENnknGYSyY
	 aa62N5wNuSI0OiaIVYMeNksazIRK/4r7kumxc0C8zZbAwVCwpCG2CKUKFJQykoqSvs
	 HbUweAleYfg/IZFb59N4jWayXGgGqbMDfjzdWKM1fxYvA5NnuSBbhMCk0/XYaiQ3ID
	 cL+O/YVKVTGrr7Iu1x4Clnh7q9AWngXoitSYG+b6Zl49xOejdK+luuZJV9iT84hRE+
	 Pk/H1BLNZqRII//wVmuYJ7M/hKRCPyHiXOTfCt3cxyeUESmQ29wnk2ez3g73FLKSNV
	 /Hi5bLbFIp2EA==
Date: Thu, 4 Sep 2025 19:48:01 +0100
From: Simon Horman <horms@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [External] : Re: [PATCH net-next] udp_tunnel: Fix typo using
 netdev_WARN instead of netdev_warn
Message-ID: <20250904184801.GL372207@horms.kernel.org>
References: <20250903195717.2614214-1-alok.a.tiwari@oracle.com>
 <20250904091832.GC372207@horms.kernel.org>
 <e022df33-8759-4fa5-a694-d0d16c51d575@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e022df33-8759-4fa5-a694-d0d16c51d575@oracle.com>

On Thu, Sep 04, 2025 at 07:15:57PM +0530, ALOK TIWARI wrote:
> 
> 
> On 9/4/2025 2:48 PM, Simon Horman wrote:
> > On Wed, Sep 03, 2025 at 12:57:12PM -0700, Alok Tiwari wrote:
> > > There is no condition being tested, so it should be netdev_warn,
> > > not netdev_WARN. Using netdev_WARN here is a typo or misuse.
> > 
> > Hi Alok,
> > 
> > I agree that using netdev_warn() seems more appropriate.
> > 
> > But doesn't the difference between netdev_warn() and netdev_WARN()
> > lie in the output they produce rather than testing of a condition
> > (or not)?
> > 
> > > 
> > > Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> > 
> > ...
> 
> Thanks Simon, agreed, I understand your point.
> 
> since WARN() triggers backtrace and dumps the file name
> it is not require here. The failure in udp_tunnel_nic_register()
> should just be treated as an expected operation failure, not as a kernel bug
> 
> Should I send a v2 with an updated commit message
> (remove "condition being tested"), or drop these changes?”
> 
> 
> Thanks for your review.

Thanks Alok,

I think the change itself is good.
And I'd resubmit with an updated commit message.

