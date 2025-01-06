Return-Path: <netdev+bounces-155469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C974CA02676
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:24:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1134164A37
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6041D86F1;
	Mon,  6 Jan 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BbWB128w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2175482EF;
	Mon,  6 Jan 2025 13:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736169816; cv=none; b=WYeVGhrDtAII8J5fbt7DApxs74IP0e4gY9dv4tvJfnBs0ApzSw7T0ZSbChAyqMhljYfiNzIPES9A06j4hQcaJCqM5QlVNAtH0GozU6QFgWQcuaQfeMMWVP90H6bs6lp1ZlwwvcqUGGuPeGFRLjYEq7G8oP+MQpJ6Dz8g9Nmvk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736169816; c=relaxed/simple;
	bh=L4OA+feQosfJTkawacRl0+DS1U+OYOOVlzLoU/75aEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVh2gKkMUaqc/o+EvB9TnF5LquOoyeHRhcqoG+lmZm9Th1rwC7yHazNikp+SNRpWJNaUFwPdNR5CbqzSaBkpPe5kSualSYKmWJAiznmqCNOyBrKIzITbHiUgNaO7EvO3S+6+8EpsToHrLv1NGDd5R2eMZgiFykhEUtRpzqfYUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BbWB128w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B1CC4CED2;
	Mon,  6 Jan 2025 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736169816;
	bh=L4OA+feQosfJTkawacRl0+DS1U+OYOOVlzLoU/75aEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BbWB128wg42ils3gP/xsomnuOTXKWmOjJarqqghzUseyWUNEYAjyNiw8EiKE/7GIo
	 QW95awNRMDAJjYjbxAzGkQWptp7qi6U+sn6sIknIBlplFIcZgzlHbTtSIcAbtuD1LC
	 WiJF2erZmD8liQ4RMtalfpHo4Sv2XANn/dCFzzFSWNKRFchjwe5F2R+y6vet2HN/t8
	 8TMOtuxhTZjhvdicj5CgENtGscbeQ4DmkrnzePQ2+SwsLaOCfoZQn2oEPSFLmykhVg
	 f8jvgVa8OMIIvjWxdBIYYkmkq+pUCEz/k8RbOvs1Civrwy+goKQ4xPTDc3wUBb2cAQ
	 2uF5c6pVTpKdQ==
Date: Mon, 6 Jan 2025 13:23:32 +0000
From: Simon Horman <horms@kernel.org>
To: linux@treblig.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 3/3] igc: Remove unused igc_read/write_pcie_cap_reg
Message-ID: <20250106132332.GM4068@kernel.org>
References: <20241226165215.105092-1-linux@treblig.org>
 <20241226165215.105092-4-linux@treblig.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226165215.105092-4-linux@treblig.org>

On Thu, Dec 26, 2024 at 04:52:15PM +0000, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> The last uses of igc_read_pcie_cap_reg() and igc_write_pcie_cap_reg()
> were removed in 2019 by
> commit 16ecd8d9af26 ("igc: Remove the obsolete workaround")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Simon Horman <horms@kernel.org>


