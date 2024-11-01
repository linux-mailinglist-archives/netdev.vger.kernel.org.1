Return-Path: <netdev+bounces-140976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FF09B8F36
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 11:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B91E1283B55
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384A415C158;
	Fri,  1 Nov 2024 10:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fy51toMC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142CC15855D
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 10:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457042; cv=none; b=qU2OZIANeZPwmQb8IPtX9dj6KRIplq9xvKH1Urh6pv5iqjufpYeiyQmcg7btm7DlMFPAzx+REkek8g1C7SLYD/fbwLdDCIUzmuG/9BXIS6zUPhpHU9qI9XlY9fulEylpnUy7cVb3mrfWiQFiOFpnM6V3cCm5eBASkF9olbSY76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457042; c=relaxed/simple;
	bh=fK1mvPxKuCzyRD8eeizEsobaBIxDnSVChFaJ3zbXAxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8WghH7wDSzwxJcP0L+0S9XrMB/O51/491SUTjwWoXQ0nDP0SZHVYvhLhNqMN+XGvTmx6VXFBH25aPhSgq6gd1lPLnPYtiD7Kn1hkc1YhObwDB7vZVZwQbURuvtUmMOIW1gD6H1DBluv1lJuk7oyL/NoY/p11PfxDNwVsAHg9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fy51toMC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2C5C4CECD;
	Fri,  1 Nov 2024 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730457041;
	bh=fK1mvPxKuCzyRD8eeizEsobaBIxDnSVChFaJ3zbXAxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fy51toMChfwdqf8TKX3Y4LinfdMxBYxkO5iWPC95XooxpHWmOOP2jWlBgrC8EFi1P
	 I9RI7NQBDwAQvDMXGzibRpWMg90Cmurb5DYj2yhW2q9SWZeTaM8XWkBgbSORi6q7KR
	 nd1aZOjsnXKwMDwisv/LNHTAtIVlkXATy8DqOHtnYYMr7cR+F7LUNi146pW8of28uh
	 9Xlm4QH0wgYWmImx9NG9RbHjfjSYKpZwztFkpHGBCVkgGhHBWmE4o29Bo+5uBf1xh8
	 7cBu7xncG+LWz/Z6g6K3oNvZJsNyvaMchTTwSJFPFVFlWFhgmb8aGpwon4TwO8EYNP
	 VwrmTBwZBIOew==
Date: Fri, 1 Nov 2024 10:30:38 +0000
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next 2/2] ice: extend dump serdes
 equalizer values feature
Message-ID: <20241101103038.GF1838431@kernel.org>
References: <20241001102605.4526-1-mateusz.polchlopek@intel.com>
 <20241001102605.4526-3-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001102605.4526-3-mateusz.polchlopek@intel.com>

On Tue, Oct 01, 2024 at 06:26:05AM -0400, Mateusz Polchlopek wrote:
> Extend the work done in commit 70838938e89c ("ice: Implement driver
> functionality to dump serdes equalizer values") by adding the new set of
> Rx registers that can be read using command:
>   $ ethtool -d interface_name
> 
> Rx equalization parameters are E810 PHY registers used by end user to
> gather information about configuration and status to debug link and
> connection issues in the field.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


