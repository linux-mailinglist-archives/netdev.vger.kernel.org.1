Return-Path: <netdev+bounces-137200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5091A9A4C70
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 10:57:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CEE1F23BAC
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E8B1DE8B8;
	Sat, 19 Oct 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnKMz2fR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDCE1DE8A1;
	Sat, 19 Oct 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729328241; cv=none; b=emuk8vF2NWiTQXej9GVLEcWmYVbcxduxb61ZlX/0kuodyGIVyATUhx6hSgzNFVfQT5R9wdC3xKkCUeLY7tNgAGEtL6GGYZ4cV6D9i0GYKLzqRGnCgGrFjKbEFhMKwATNW0FJ52tCJVoNZKlVDQtFxowDe+P6Cu2u2WaQWJSrT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729328241; c=relaxed/simple;
	bh=DQI1BZ82X1qvkfe8/9xAeqxLhRhAUAQM/tO3lG8ZXVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJDkANHSyePqoy0aaSdf1Vw2SEShTIAJb4Pw0mf/EzfYXp+D/KelxhXezbn6yrzozxOyWoEU/F6RD64qlbgGlFjz30F3e7RYzVgUHCSKAb5X3cllY4ymnnpXBW9+Nw5RaDK7QsiwkWBWz9vTqtJFwxwBfNrebEXeCtwActc+Ouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnKMz2fR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E91C4CEC5;
	Sat, 19 Oct 2024 08:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729328240;
	bh=DQI1BZ82X1qvkfe8/9xAeqxLhRhAUAQM/tO3lG8ZXVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gnKMz2fRZF1YMptvv7pZHMSCki6tAm9A0gdGsDwjTgJ/Uwfe/Um27LUKK7dK5qRVQ
	 NtwqKZ43xsVJ/gycsV+7otkLp2pSgoDHT1vsWbuxKAP6yNyefRGeW1mDpJydQbK32v
	 md6kMsVcwY0jattMmiUU3iDnAa57u9uORBbgaegcKyPDQvnUY33js8SMsiAaydx34b
	 jc+BTyu9IacQRuLdCA5FufTbYAOdRn3DI7IdgHGCgEAeC+1mWR5I+4bWuGFq4YEk4o
	 9d0JsBv7j5epK7Yg37ms5saETKfdtjWNPlIT5TT52qHlCfzG+1WZ8uqTEDL804Axd/
	 3iFRtL1eowJrw==
Date: Sat, 19 Oct 2024 09:57:16 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenz Brun <lorenz@brun.one>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3] net: atlantic: support reading SFP module
 info
Message-ID: <20241019085716.GP1697@kernel.org>
References: <20241018171721.2577386-1-lorenz@brun.one>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018171721.2577386-1-lorenz@brun.one>

On Fri, Oct 18, 2024 at 07:17:18PM +0200, Lorenz Brun wrote:
> Add support for reading SFP module info and digital diagnostic
> monitoring data if supported by the module. The only Aquantia
> controller without an integrated PHY is the AQC100 which belongs to
> the B0 revision, that's why it's only implemented there.
> 
> The register information was extracted from a diagnostic tool made
> publicly available by Dell, but all code was written from scratch by me.
> 
> This has been tested to work with a variety of both optical and direct
> attach modules I had lying around and seems to work fine with all of
> them, including the diagnostics if supported by an optical module.
> All tests have been done with an AQC100 on an TL-NT521F card on firmware
> version 3.1.121 (current at the time of this patch).
> 
> Signed-off-by: Lorenz Brun <lorenz@brun.one>
> ---
> No content changes, thus resent as v3 with just the target tree changed.

Reviewed-by: Simon Horman <horms@kernel.org>


