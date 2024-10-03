Return-Path: <netdev+bounces-131638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F798F1A2
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E293B22AFE
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CBF19E98A;
	Thu,  3 Oct 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLp8xVDN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D05823C3
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 14:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966379; cv=none; b=YhockOCePTwgkHW+PvLN479Jzgx39RlFsnZXP2PnPDRB2jLbcW9rsQ30SUbfy/ikR3FEsLExo7B5+W5x9MG8fKru3i/TTBDHI56QFiz5QWn2hNrpE3vMsxOklzF7BasdY/MH9zqHXZync2rpXQDfTFR8ejbr3cgL6TY/2hSFZ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966379; c=relaxed/simple;
	bh=7cud/xmpFJRUs1XOTcP5UA9MsRYh5AhLZyVo72p6N7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QUSKfHtA5Bh2TULD3NEIAxXwtViWxI6+OA8O5C2EukUOcu5abOIpijaKpl+lzd2wgOCZHDdEd0T2AdwMj/4FlwQibX0hBN1bGxOS9tvuQId0n8TMBOjYqQbIW6DJkAxNv3ucwmCGSvNKccjGDhE0RnUNgG3AL+INN9gF7hmteRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLp8xVDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D30C4CEC5;
	Thu,  3 Oct 2024 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727966378;
	bh=7cud/xmpFJRUs1XOTcP5UA9MsRYh5AhLZyVo72p6N7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vLp8xVDNFgWyb4lq9pK6dZHvh1nme6qKzGFzhy36jlgOtcgH8etUxJf38a4Udh+xW
	 A3WAy61X1XgZwhs1HHJTQ4QIbCDFm2Mr8t07T3Srqx/d6TAzbetvN4dE7Vi7QvCEtQ
	 sqQonyA7c0J7SCdKCQjuLYuOEeKfZtXatWsxbqPT/adV5L+J81tli/8uHEe+rqjV/G
	 BEmiOJ+9kg+lshiEpwe2egWhElLaKmIZ+tMVvjO9DsaLRdDZKz2Yi76/5pV8LWVdNq
	 Mqz/CGYmREwvldz3ssWiFmDvYofUBisFckjVtGD1Gb9ONBNqjPPx61ju5EkrvaCY3B
	 IDsefu9kuWtuw==
Date: Thu, 3 Oct 2024 15:39:35 +0100
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com
Subject: Re: [PATCH net v2 1/1] ibmvnic: Inspect header requirements before
 using scrq direct
Message-ID: <20241003143935.GR1310185@kernel.org>
References: <20241001163200.1802522-1-nnac123@linux.ibm.com>
 <20241001163200.1802522-2-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001163200.1802522-2-nnac123@linux.ibm.com>

On Tue, Oct 01, 2024 at 11:32:00AM -0500, Nick Child wrote:
> Previously, the TX header requirement for standard frames was ignored.
> This requirement is a bitstring sent from the VIOS which maps to the
> type of header information needed during TX. If no header information,
> is needed then send subcrq direct can be used (which can be more
> performant).
> 
> This bitstring was previously ignored for standard packets (AKA non LSO,
> non CSO) due to the belief that the bitstring was over-cautionary. It
> turns out that there are some configurations where the backing device
> does need header information for transmission of standard packets. If
> the information is not supplied then this causes continuous "Adapter
> error" transport events. Therefore, this bitstring should be respected
> and observed before considering the use of send subcrq direct.
> 
> Fixes: 74839f7a8268 ("ibmvnic: Introduce send sub-crq direct")
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


