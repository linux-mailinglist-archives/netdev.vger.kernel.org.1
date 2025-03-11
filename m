Return-Path: <netdev+bounces-173903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C30A5C304
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE31B3A966D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67031D47AD;
	Tue, 11 Mar 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWg4qFbR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C21C245C;
	Tue, 11 Mar 2025 13:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701162; cv=none; b=BSwZ0J+s+y6LZnA0869H9nVqsNdDM4Wj5rfIQAmwxmEiN0yYIc6CH7Bjiwn9836S9igPuXo/gHkW75MIasiwWWwS0RgQSCy/HfeMEjGzuvkqfPVoFB1VNRp7jL94Hy3e9yNePJOSMOFwx2Nji+od0AiZPTCcQ5qEKxVH9Aktgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701162; c=relaxed/simple;
	bh=n45UPAxWADbzGDd4VBZbcmVUcHI4dsPczYexj1kkWEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOAoavALe1cxNuVKrmGQXMk30FDmOV+2EyOTre+fWoP5HT0DFHjK4o7FGL7VUoyHEDnX2fVxaaJMKhdgPWAg6OvUbRq3liXJ5eC5R1ej771koO6cXiAyMSYb8dcqc7KeaCVV0oGEg0Q5d6aYQWNLYhcb3WmnmjwmVn8LsoLCm1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWg4qFbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF739C4CEE9;
	Tue, 11 Mar 2025 13:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741701162;
	bh=n45UPAxWADbzGDd4VBZbcmVUcHI4dsPczYexj1kkWEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWg4qFbRX+MK5lX3pYS8YQg/kViYWdb7cQsXn5bTDT4CfmScsfpNDELBKWBAR6vIC
	 RF6he+8/ejSI/Yt4NttNln+tNp4X2pYPmXHs3owBpmfhmR2c/y56f+5MhXpmBOQBGo
	 qq9M0HX5l7XoR/qqtUiic4dKBb18YwgUU+SUHUNusab675xkWoD7jlz7Bgyzr65IwH
	 xnm6HZUh69Ha2gJvM/X/Y+aXbE3N4LdtpDVmln6HYJ3TF4R5WoeDXrOouMfwGi9c8J
	 nJUZDOXG+xLiFYq9YdV0MLUF7tVPTK1sOyB3pTYCKOkcE+PhhJ+khcuOs0YSoTnzO9
	 KtclIZyqaQfPg==
Date: Tue, 11 Mar 2025 14:52:36 +0100
From: Simon Horman <horms@kernel.org>
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: muhammad.husaini.zulkifli@intel.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, edumazet@google.com, kuba@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] igc: enable HW VLAN insertion/stripping by default
Message-ID: <20250311135236.GO4159220@kernel.org>
References: <20250307110339.13788-1-rsalvaterra@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307110339.13788-1-rsalvaterra@gmail.com>

On Fri, Mar 07, 2025 at 11:02:39AM +0000, Rui Salvaterra wrote:
> This is enabled by default in other Intel drivers I've checked (e1000, e1000e,
> iavf, igb and ice). Fixes an out-of-the-box performance issue when running
> OpenWrt on typical mini-PCs with igc-supported Ethernet controllers and 802.1Q
> VLAN configurations, as ethtool isn't part of the default packages and sane
> defaults are expected.
> 
> In my specific case, with an Intel N100-based machine with four I226-V Ethernet
> controllers, my upload performance increased from under 30 Mb/s to the expected
> ~1 Gb/s.
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
> 
> This patch cost me two afternoons of network debugging, last weekend. Is there
> any plausible reason why VLAN acceleration wasn't enabled by default for this
> driver, specifically?

Having looked over this I am also curious to know the answer to that question.
This does seem to be the default for other Intel drivers (at least).

