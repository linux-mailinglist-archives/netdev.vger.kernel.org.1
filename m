Return-Path: <netdev+bounces-155509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0420A02939
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 16:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF1253A4DA4
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E9014F12D;
	Mon,  6 Jan 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtfpiFM4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C44378F49
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 15:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176850; cv=none; b=miIX35C5KSzywuPXiBrOJOSP0YLjfpPhU2zeSDRQexQMb2QtnyQG1vEI2jvloAhQbaJ0AE6eqQ/M6gCteK6661yU0C9UX8f2gUz9fHKYp8aalT7hqQkMArh9goGdDvYuVYOmAetPyEvyCRqOwrCDUo76EUgtij/WSMWPCvCW8Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176850; c=relaxed/simple;
	bh=PWxM0oKNhPzNmzBjTmUiv9KMH/Me+XEwXM1l+x57quk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lcOPG/LW6oYhPL4iiAyR+wTSr7FnRLprghPo3b8bRAAPDf/zWBWYUWQixpTvUieMq9hIB1A5ILGRaJTiiPwiEOTwx57VWffBUyGP2+PQEmNuJhXUqNqXvq2zKhQEtfW1SyuWFuX4cws6PqmGFzZlEh8H9BvgNT/kav/D5RCbr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtfpiFM4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F754C4CED2;
	Mon,  6 Jan 2025 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736176850;
	bh=PWxM0oKNhPzNmzBjTmUiv9KMH/Me+XEwXM1l+x57quk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtfpiFM4JA8NTtzhXk4mTw9/+/Fl8sAJQwtdC052Z8jhWLkS0MGgaBAZK/+nsiAem
	 KNAC+9Zajn/rFoTFhc8+8tnIDYybuOu0oxc7pRmwm4Mad2vJh2uvzcfxqqygD/aBrR
	 a+UpAP9qkEVz5+wRKIahgTmhBfcM3kEUV09WkfNC4yg5HmxHXIljfp/dVWomgRXYaB
	 z5OSmTzUcXq94AS50qCp4YvCzZIh5gEP45cqxZTIygPx6WXz7MMip1hxz2JGeXNBDx
	 AlhhIcATMGosam30BxmTS/dnm24SrglQYjli7xfPrnO1AuOQdT7XV4+NPhkHICeNWD
	 vkuZ/oPFFU+kg==
Date: Mon, 6 Jan 2025 15:20:46 +0000
From: Simon Horman <horms@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
	jacob.e.keller@intel.com, brett.creeley@amd.com
Subject: Re: [PATCH net] pds_core: limit loop over fw name list
Message-ID: <20250106152046.GC33144@kernel.org>
References: <20250103195147.7408-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103195147.7408-1-shannon.nelson@amd.com>

On Fri, Jan 03, 2025 at 11:51:47AM -0800, Shannon Nelson wrote:
> Add an array size limit to the for-loop to be sure we don't try
> to reference a fw_version string off the end of the fw info names
> array.  We know that our firmware only has a limited number
> of firmware slot names, but we shouldn't leave this unchecked.
> 
> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Simon Horman <horms@kernel.org>


