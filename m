Return-Path: <netdev+bounces-156697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C2FA0783E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 14:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A782165987
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8698C218EA6;
	Thu,  9 Jan 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZxeYu+/R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C4218E8D
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 13:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430899; cv=none; b=S4XgE4hDb58EPmiWQlQlq53I7mCEkyffVlGT1eTIHRlZ89HRyMTJnKS60pxckG0w5FliBbUfOQzxvO22tKfbcVw49AdAO9R/uvMe7fTb5sE7VDCtsXK3kxPtJOHFoTT9mqIdq3H6G6b0fR0w96bY5y7BqGE4ezs7k8Swt6qG0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430899; c=relaxed/simple;
	bh=Qv6KXcKcJoa+LnBgLNOPGtekP+BGFbuWoGbp4/IIIxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ur5RP+VV9dtc6XnCtMxF/r1wg2AeNa6VHfohGNToXVkljB1/FEIERqxmGKjmEOyiZiIwPYDozyvTYS173W/QtPlSsyVRw9m+thJdiAf8a8AWCsYueG1OvV/huMF0/7u07kUXoDAmKtGX3mYNajt2YQ64iKv2SHgueIh1P7SvUbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZxeYu+/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC2DC4CED2;
	Thu,  9 Jan 2025 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736430898;
	bh=Qv6KXcKcJoa+LnBgLNOPGtekP+BGFbuWoGbp4/IIIxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxeYu+/Rbzr4AKO7s2ti0dxo//gKhJN1noZmfNR/2rNbQSWHHXEu2IJPWRcLItZrW
	 XBOZhSq7EXOwundg0/u4Jy6H9ej/w++PzNBV9G7aaOD8IKqJsk1K/gLeKottV+j8a4
	 MW7mSFjviFiYxuFO8l1sxnZ1YQulbbWvuB2i/SUW+qQvtG8YgD6sCz9ypCGq46eyIT
	 hsmcdJN4zhoWAsMFbwvBa35PYUUG+QVI3V4ar55K8XCSoD+sLqNLSC+Hjp9rs6dZ7b
	 K4BfuMs2dwxR7ejXiCVCp/n+GvbWaahvBn7bdoxZziNtfo5zHViPLFw3AmvZyvnmRl
	 qmaEqFUREi3Iw==
Date: Thu, 9 Jan 2025 13:54:55 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Jose.Abreu@synopsys.com
Subject: Re: [PATCH net v2 1/8] MAINTAINERS: mark Synopsys DW XPCS as Orphan
Message-ID: <20250109135455.GE7706@kernel.org>
References: <20250108155242.2575530-1-kuba@kernel.org>
 <20250108155242.2575530-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108155242.2575530-2-kuba@kernel.org>

On Wed, Jan 08, 2025 at 07:52:35AM -0800, Jakub Kicinski wrote:
> There's not much review support from Jose, there is a sharp
> drop in his participation around 4 years ago.
> The DW XPCS IP is very popular and the driver requires active
> maintenance.
> 
> gitdm missingmaints says:
> 
> Subsystem SYNOPSYS DESIGNWARE ETHERNET XPCS DRIVER
>   Changes 33 / 94 (35%)
>   (No activity)
>   Top reviewers:
>     [16]: andrew@lunn.ch
>     [12]: vladimir.oltean@nxp.com
>     [2]: f.fainelli@gmail.com
>   INACTIVE MAINTAINER Jose Abreu <Jose.Abreu@synopsys.com>
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

I concur that there doesn't seem to have been any activity from Jose on
this driver for some time: my searches say since March 2020.

Reviewed-by: Simon Horman <horms@kernel.org>

