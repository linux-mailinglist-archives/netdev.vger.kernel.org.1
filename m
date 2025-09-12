Return-Path: <netdev+bounces-222372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90901B5400A
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 03:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEDC3A4F36
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 01:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64BE189F20;
	Fri, 12 Sep 2025 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG+9G1Ul"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B191A3D544
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642323; cv=none; b=TGx64NN0DqzgoK22HLR8TYqTRe/WZfw4uFGaRBpLUidCw5NUTS7DPscWzwZt/o34HXoN0jjF6CRv/S4FHgAyLIDnEa4CecI9W8YXnXLEqe2W7nvEmXWDvSwr0QfoCyKevILgVrEDCZ5HNfW/iitz12OcmPBYimgokPLrj4moC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642323; c=relaxed/simple;
	bh=qQF3CGj0m0GnQ26wUNEOmt9d67TnL+Kpgu/EU14BunI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fn8XkesdAaJPQsxs9Aq4pcwiY/WNB1ws+6hKs/sloGWfHtlsGKSk03tG8+BF1xbWtF+3J/8N1BNC+iSFuh89gCeABJoIK9/rRpNprHC6Hk/xJD16006gKzlQ0e/xgkG8nh0IFWn4b0FtMQDJXwlzLMrcfp6Ky/b3gR32pxfdSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LG+9G1Ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ADDC4CEF0;
	Fri, 12 Sep 2025 01:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642323;
	bh=qQF3CGj0m0GnQ26wUNEOmt9d67TnL+Kpgu/EU14BunI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LG+9G1UlCs467hfraUjfZ91Z2bbWppE4W1Upnl64bKgbay6mQ8DxIspuIwUeaXZIe
	 7HWbxJEQXnFgkTWmq+ayLT5KbZCexxDL/GA5dfLQYQhn01g2Yf7tkWFIJ3A6mux6/2
	 Y50z9MgM0W5hxGKH11ucsLNTFGavgL0LMXQhNPX9ps19DuvZ/pfok8lKR/RuIPczAO
	 YHZ0wWDccaEc8Fq8tXgrlmFlmxY3q5iIL9wEP7IDJId7kYDF5//VWsPS3TtLIYslGC
	 J4MzjQERPmiRrSWLIdjowwYV2AcmHTtm3ZDdB0EXItQrWqej0FiDr89sePCzyb0Glc
	 ZJRezoZwATGVw==
Date: Thu, 11 Sep 2025 18:58:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Marcin Wojtas
 <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: mvneta: add support for hardware
 timestamps
Message-ID: <20250911185841.0863ffc0@kernel.org>
In-Reply-To: <20250911185506.6ee85d94@kernel.org>
References: <E1uwKHe-00000004glk-3nkJ@rmk-PC.armlinux.org.uk>
	<20250911185506.6ee85d94@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 18:55:06 -0700 Jakub Kicinski wrote:
> On Wed, 10 Sep 2025 13:50:46 +0100 Russell King wrote:
> > Subject: [PATCH net-next v2] net: mvneta: add support for hardware timestamps
> > Date: Wed, 10 Sep 2025 13:50:46 +0100
> > Sender: Russell King <rmk@armlinux.org.uk>
> > 
> > Add support for hardware timestamps in (e.g.) the PHY by calling  
> 
> These are _software_ timestamps.. (in the subject as well)
> 
> Fixed when applying.

Let me take that back, you may actually mean HW because of the PHY
handling detour. Maybe call out both software and PHY (hardware)?

