Return-Path: <netdev+bounces-242349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B45C8F876
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13BA63A88FD
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146DF2D7D42;
	Thu, 27 Nov 2025 16:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io8nDiQu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7272D59FA;
	Thu, 27 Nov 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764261373; cv=none; b=dImqQt3yOzfCCmNtX+HV5OOrf+4lACMH8VSwzSsMGBOiefnj7+NSxDfnqNcLlOILzf2khiwzfXjd6raojUc3knKy4is5wQYj2inowTk/7R+nI9Okl/72goxsuuvP6pE3THQ5YhK4EO1OefFKyJ43f+dwfrFM/NAYIjBFlb/6Iyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764261373; c=relaxed/simple;
	bh=dZgly/QvXBcvTt9A7U2ETopGrOtteqXu/kH5ijOmo0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a9S0YtvUR4YgUto29L6scrueCtS3rpFuate+JXKkWpBG/SREqVYNvTcs3yE0GzxPcmd0jNqL9ZY2YMxn3a/8/RQ1vvWZPKlMacqeIG+UGLwRUDM06V/RISLPRnAaAVBMFmCLW5710guHBpkXqwcjEn7iVItKBD/APFFm51BEG90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io8nDiQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025CDC4CEF8;
	Thu, 27 Nov 2025 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764261372;
	bh=dZgly/QvXBcvTt9A7U2ETopGrOtteqXu/kH5ijOmo0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Io8nDiQuqfvsnmPqIz4wC9inH1FeMCUmqKoSkd1vA4Lbc2ai5iUxS7UhdlxLsjK42
	 kENQWgapc4PNuMV3x0/8deQR2QDVOQY0+vd1IR+z4jniEqbQyoX5fT9lN2F+/whF4R
	 Lgbq75ScCIWXvfyj3Q1YShESZUYm3cMkbHS1ykSM/0JApWyFaqjOPHX2RG1zbq2VUN
	 p7mv9ElETcIfYVamCORWxika3V9w6TiJ4S6vM1biGL1HmVwsdr87sbaeq/n7o8eiQQ
	 R7NiT3jji7qw9FCP3V2tenZEd4Id9LoZgtLrExLnPoETsBauUycyAIuBAHhAI1+ui1
	 ZRnDIg3NmNcjw==
Date: Thu, 27 Nov 2025 08:36:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
Message-ID: <20251127083610.6b66a728@kernel.org>
In-Reply-To: <34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
	<20251030121314.56729-2-guwen@linux.alibaba.com>
	<20251031165820.70353b68@kernel.org>
	<8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
	<20251105162429.37127978@kernel.org>
	<34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Nov 2025 13:48:47 +0800 Wen Gu wrote:
> > We can't delete existing drivers. It used to be far less annoying
> > until every cloud vendor under the sun decided to hack up their own
> > implementation of something as simple as the clock.
> 
> So what kind of drivers do you think are qualified to be placed in the
> drivers/ptp? I checked some docs, e.g.[1], and codes in drivers/ptp,
> but I am not sure what the deciding factor is, assuming that exposing
> a PTP character device is not sufficient.
> 
> [1] https://docs.kernel.org/driver-api/ptp.html

Networking ones? I don't have a great answer. My point is basically
that we are networking maintainers. I have a good understanding of PTP
(the actual protocol) and TSN as these are networking technologies.
But I don't feel qualified to review purely time / clock related code.
I don't even know the UNIX/Linux clock API very well.

Sorry to put you in this position but the VM clocks should have some
other tree. Or at the very least some clock expert needs to review them.

Could you go complain to clock people? Or virtualization people?

