Return-Path: <netdev+bounces-94207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3D8BE9B5
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2EBB1C20B49
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6398182AF;
	Tue,  7 May 2024 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl7lwLBe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9DEE570;
	Tue,  7 May 2024 16:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100548; cv=none; b=Pl+i9TmKC16Vt6I1NPBPqa2RJDKZ42W5TGLw+GGWARyTCUuDqWfVvkOTXrxkFPGaEi+ezFLxvi3DpIEoIyGdTRITZUmbXlIWfW9bJda3b+B2bHBHUeldTh2ho+K4sqF6Gfl2dH2gAIFB7XS4CYItIRDzWu2hpP6XBlQcbz0BVS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100548; c=relaxed/simple;
	bh=qunHGKd171Czz0ZvqapxiFzxvXNHzATrQKVEdENIKtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqhmVjJmMNV5nEglAzwB5J505fNDGiNLAOu+e5zbEAcRWH7LTgrs4RisTXsENyzX+UmPQpEuUpJdnJEBxEO1L1H79tgf0jyePFCnclaCZhIp495ytrCThQWpx2c8YbuNp2/sW0qVGNtzeKmqidqmRJBB3Fh6jbyrsKa9c09eaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl7lwLBe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EE9C2BBFC;
	Tue,  7 May 2024 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715100548;
	bh=qunHGKd171Czz0ZvqapxiFzxvXNHzATrQKVEdENIKtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sl7lwLBeBVh+X49PyKhSSjt+J3Ipp+ZGUjN9+qQZiFmIVFKq9/HUgxO4nPG2RIpdr
	 sms97uoLbeFHufXA+uvh1K7S4iIzgyHm9L4Hcv/djHy2I8CN5OGXg1tCA+dxdZRhLv
	 Jf49MMIZCgZjJs1NEaHvayBwsCN3wZnOwsWMGj/EScqZGipMTAT69Ov4JA38hMr4BE
	 1RRYFzX/27hoOMp/Q7KPnDAYYcPRPpLHl1KE+612igLc7T+6zbiFMTt1kzZHWk1UwD
	 /3f+R8fPAWS1TQHbDycGb+DpHct4sGFcoGGj5Za+VaQTtN7jfJ1vmkreTfG7FXm45a
	 jprW50NSn3YjA==
Date: Tue, 7 May 2024 17:49:04 +0100
From: Simon Horman <horms@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] ptp: clockmatrix: Start comments with '/*'
Message-ID: <20240507164904.GG15955@kernel.org>
References: <20240504-clockmatrix-kernel-doc-v1-1-acb07a33bb17@kernel.org>
 <20240507084336.GX1227636@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507084336.GX1227636@google.com>

On Tue, May 07, 2024 at 09:43:36AM +0100, Lee Jones wrote:
> Subject line should start with:
> 
>   "mfd: idt8a340_reg: "
> 
> On Sat, 04 May 2024, Simon Horman wrote:
> 
> > Several comments in idt8a340_reg.h start with '/**',
> > which denotes the start of a Kernel doc,
> > but are otherwise not Kernel docs.
> 
> Some very odd line breaking here.

Thanks will up date this and the subject in a v2.

...

