Return-Path: <netdev+bounces-140975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A729B8F34
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A692B23120
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62F156861;
	Fri,  1 Nov 2024 10:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP2eRis4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A903839F4
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 10:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457021; cv=none; b=e3nv2ofO2xS7CX2L/T8CdEb/bHArlFHfgQTLZA5KYA0RpyM0zOIMPEJtqn5ZEYIu1Ss6+GqUTkxmmGOfQR5767cGs106UvfljhsrGG1pp2OqpyIM2xkrfJj0aK64fUk+PmvdMKbMAmx9O3kFORWrVPzdk7dXF4YOWnY3eXdzRPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457021; c=relaxed/simple;
	bh=sJEGBgvc3zgavo2T6T7nENSVwv1AiZk/aBUCUyw5FE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BlsG/9llKEYsFkuWMqMM/Zk9j+oPC1LPRY0ud132KMix/HOE1Wuq+ZvC3VhC+zu8HjZ6JhCB+0TRcJEepkCX6II81jQbfoCWKDNx3FXIyT6t4KsENBNTQIcEruipi26vEHf32yp94DkqXyGKUWWxV1iOGUGGgvvpIQVr6MUAf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP2eRis4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E95CC4CECD;
	Fri,  1 Nov 2024 10:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730457018;
	bh=sJEGBgvc3zgavo2T6T7nENSVwv1AiZk/aBUCUyw5FE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FP2eRis4QvOPHBR3Gt5+FhgcTKImDHDtrGZkDSYmRZ1KOSstCMiI1bv3YcyOXEQZc
	 +AqakWn7aOswGUwtQD0b9cJTU8TAdS7mk9PRShXky6tbcmr4cAoUFOCYcQ5WkY4BZE
	 RN1NY+uiZ5/f3W+v9pruQIIXAZyxfTRwpiySDc/bb2vAF8RsDvmW3ZyPmKsvFR6Q0d
	 WuPpW0ZWusWKkP9wXA0W/IEIdfoY2wf/Y3GRtS8n+0eK3Qb4yBAqscKKRtdBxqLFWv
	 qvfl/oqezuvQSU8cEYrVeLuN81forDenKU2b6BJGpsPXe+vHjVLBFEI+kINqJZTAFq
	 kiUFqnIc+xPJw==
Date: Fri, 1 Nov 2024 10:30:15 +0000
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 1/2] ice: rework of dump
 serdes equalizer values feature
Message-ID: <20241101103015.GE1838431@kernel.org>
References: <20241001102605.4526-1-mateusz.polchlopek@intel.com>
 <20241001102605.4526-2-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001102605.4526-2-mateusz.polchlopek@intel.com>

On Tue, Oct 01, 2024 at 06:26:04AM -0400, Mateusz Polchlopek wrote:
> Refactor function ice_get_tx_rx_equa() to iterate over new table of
> params instead of multiple calls to ice_aq_get_phy_equalization().
> 
> Subsequent commit will extend that function by add more serdes equalizer
> values to dump.
> 
> Shorten the fields of struct ice_serdes_equalization_to_ethtool for
> readability purposes.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


