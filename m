Return-Path: <netdev+bounces-67684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A149844921
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 21:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA5911C20FB2
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 20:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DEB20DE0;
	Wed, 31 Jan 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M70PRVcD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D9A5C99
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 20:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733949; cv=none; b=EbuduAM9A7NW/oALPr8Wzd4Ed7l8N9J3r3Ows7j/SHz+3tzT552Xxv/Z/z1qQeQGv0HWRm5epPfHPrhjcLHXlxBnaYXR2jt6Y/jcR/HXg3q/g/MitbQIuG4mj/1MYXxmxy+NKg0XjZbslzxt+ON19xNlZ9V6TD8fCoHHuWWLKKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733949; c=relaxed/simple;
	bh=bi7QeMFwIMj/4tbS189WKNt6b4zW78FVW7YiRJZUGLA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtRAsHzSCSNMZYSgaGc4OUpvgQvN6t7iHoSBNrqzJFNg/Ejb34Lvi8LCZ+5Wt0E3/rFAddNR8csTT/qqRbLxDlaBtCzW5IjCGfpdry+Mv83zwD2jdDPMoII9Ye3cNn+vS6yJGUZaPo/STyMCSJWG0znNpbGt8+YIEU9VfqPu1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M70PRVcD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AB8C43390;
	Wed, 31 Jan 2024 20:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706733949;
	bh=bi7QeMFwIMj/4tbS189WKNt6b4zW78FVW7YiRJZUGLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M70PRVcDr+Ya/rM8Fpm2j3M4oGjKk1LeU/crTL4Ipq4UL3sDW4DogXMTkrj6nMcqT
	 qnSvvZr1nlM8eJ4KNZ/iQkxcyRBlffAF6Zbzx8LGLkI9alKvGA96cvas7jlW+szOJM
	 9ZySFsK9Xtrhkzb63lsCRC3f2v7sDM1s4dCjJztWpixfTlf9Nrw6wUXdHVWLZTZkAC
	 FR0ipbi55kFMA8bSdGb+6ab8+Gn3vm7IaVsFStAESuYtraJYJT+awxQv6PUdP3wtTE
	 SKDY3gQ2MZk9z+aI7Tpfz0MeK7Gl8p25ilxWi7yFt0ekx+TXTdsm4oURh2hRftIMjZ
	 0JUdQ7AxrfSDA==
Date: Wed, 31 Jan 2024 12:45:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: bodong@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org,
 saeedm@nvidia.com
Subject: Re: [RFC PATCH v3 net-next] Documentation: devlink: Add devlink-sd
Message-ID: <20240131124545.2616bdb6@kernel.org>
In-Reply-To: <6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
References: <20240125045624.68689-1-witu@nvidia.com>
	<20240125223617.7298-1-witu@nvidia.com>
	<20240130170702.0d80e432@kernel.org>
	<748d403f-f7ca-4477-82fa-3d0addabab7d@nvidia.com>
	<20240131110649.100bfe98@kernel.org>
	<6fd1620d-d665-40f5-b67b-7a5447a71e1b@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 11:16:58 -0800 William Tu wrote:
> On 1/31/24 11:06 AM, Jakub Kicinski wrote:
> >> Thanks for taking a look. Yes, for our use case we only need this API.  
> > I'm not sure how to interpret that, I think you answered a different
> > question :) To avoid any misunderstandings here - let me rephrase a
> > bit: are you only going to use this API to configure representors?
> > Is any other netdev functionality going to use shared pools (i.e. other
> > than RDMA)?  
> 
> oh, now I understand your question.
> 
> Yes, this API is only to configure representors in switchdev mode.
> 
> No other netdev functionality will use this API.

Hm, interesting. I was asking because I recently heard some academic
talk where the guy mentioned something along the lines of new nVidia
NICs having this amazing feature of reusing free buffer pools while
keeping completions separate. So I was worried this will scope creep 
from something we don't care about all that much (fallback traffic)
to something we care about very much (e.g. container interfaces).
Since you promise this is for representors only, it's a simpler
conversation!

Still, I feel like shared buffer pools / shared queues is how majority
of drivers implement representors. Did you had a look around?

