Return-Path: <netdev+bounces-167377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C9BA3A05D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00DF03BBCA4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C426B959;
	Tue, 18 Feb 2025 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzbPVeL9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006EB26BD9C;
	Tue, 18 Feb 2025 14:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739889611; cv=none; b=eWSQRvOD7VpnZRaAEgmaO8Oe919DUrXJMQwF8+YiAHYjR6uL+o+jAWWgpVi5oYwW9coOE9MBzCZ80hnqJaGsd9c+M+wHHFYedYBB8pzwXEv0tQT1y7TYKOtNcKU+ydAtv5itra6Qkt5DhJaVeKBmVPQ0xHGIaXKWZYsa66VDiiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739889611; c=relaxed/simple;
	bh=YR9rSw0eu3MHVUUgxBCbni+Nva8WP3z74sHAVNGJ4uE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bk1Hy8D7h+qDJ1VcVf9tNZ8ITXdkgkWvvsaslPutgINvJAo5WMDiPtVyBRYsYHfthqDlLNjwmjAR0iWaQbPnydj8kQLLhEYI6wjIuegZxgnZJ2px+eDhX/mNXbBI1g7kwbhMrTTCnjfkHj15K/BVP6oH/S6ZwP3YRZGZ9O8ESTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzbPVeL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7521CC4CEE6;
	Tue, 18 Feb 2025 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739889610;
	bh=YR9rSw0eu3MHVUUgxBCbni+Nva8WP3z74sHAVNGJ4uE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzbPVeL9NZslDcCM2y1sjYmXPxgSopR14z46QVjjrNzvbEHB5+WPnFQRRTHlKISMp
	 elixWnJEzcRwytaUb6gea/LyyTRRuwENsCzaHq2/Ekrr9ihJ3+yCEALsOdI9KCzsR2
	 PWNuVAgF693CQ3VKdYRyO6UftU9PQLPbr7eUMVk35Fv3Hg0uIc4nBL7Y+a1KP3Qxbx
	 wRFVMhux4nj1DaWDiSBdDylC2chqVu4Rt9cZQKfZ95oj+B177msOHcrtOLpLftHi4N
	 WOzUo3yt1LKjb5WFnvgnOeLuooMzEyk7JokubFm+R2BYrs6+zhsrcHEr/qzku47Wt9
	 eo2mH4SwSkZPQ==
Date: Tue, 18 Feb 2025 06:40:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parvathi Pudi <parvathi@couthit.com>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
 richardcochran@gmail.com, basharath <basharath@couthit.com>,
 schnelle@linux.ibm.com, diogo ivo <diogo.ivo@siemens.com>,
 m-karicheri2@ti.com, horms@kernel.org, jacob e keller
 <jacob.e.keller@intel.com>, m-malladi@ti.com, javier carrasco cruz
 <javier.carrasco.cruz@gmail.com>, afd@ti.com, s-anna@ti.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, pratheesh
 <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, praneeth@ti.com, srk@ti.com, rogerq@ti.com, krishna
 <krishna@couthit.com>, pmohan <pmohan@couthit.com>, mohan
 <mohan@couthit.com>
Subject: Re: [PATCH net-next v3 00/10] PRU-ICSSM Ethernet Driver
Message-ID: <20250218064008.762e9b94@kernel.org>
In-Reply-To: <1348929889.600853.1739873180072.JavaMail.zimbra@couthit.local>
References: <20250214054702.1073139-1-parvathi@couthit.com>
	<20250214170219.22730c3b@kernel.org>
	<1348929889.600853.1739873180072.JavaMail.zimbra@couthit.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Feb 2025 15:36:20 +0530 (IST) Parvathi Pudi wrote:
> > On Fri, 14 Feb 2025 11:16:52 +0530 parvathi wrote:  
> >> The Programmable Real-Time Unit Industrial Communication Sub-system (PRU-ICSS)
> >> is available on the TI SOCs in two flavors: Gigabit ICSS (ICSSG) and the older
> >> Megabit ICSS (ICSSM).  
> > 
> > Every individual patch must build cleanly with W=1.
> > Otherwise doing git bisections is a miserable experience.
> > --  
> 
> As we mentioned in cover letter we have dependency with SOC patch.
> 
> "These patches have a dependency on an SOC patch, which we are including at the
> end of this series for reference. The SOC patch has been submitted in a separate
> thread [2] and we are awaiting for it to be merged."
> 
> SOC patch need to be applied prior applying the "net" patches. We have changed the 
> order and appended the SOC patch at the end, because SOC changes need to go into 
> linux-next but not into net-next. 
> 
> We have make sure every individual patch has compiled successfully with W=1 if we 
> apply SOC patch prior to the "net" patches.

Please resubmit after the merge window.

