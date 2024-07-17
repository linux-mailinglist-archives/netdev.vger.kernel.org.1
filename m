Return-Path: <netdev+bounces-111934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642D693434A
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 22:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D241C21097
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 20:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0594E1822F9;
	Wed, 17 Jul 2024 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WO0xxgKP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B891CD3D;
	Wed, 17 Jul 2024 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248718; cv=none; b=OHUAwrlswTAhiUzk5XNjCIp/KvDZnXcDvlbfZecdt810vkIM3jec40wDloqzWvOr6wOxsX7+igIBiOF/tKALqrsHCRc4DzSDpZ3KDLq+a43IWcxA7U+a4VFztRd+mVpHKkN9p4FV3Iv0lwWlreIeLenX3U/RASrrrkwIikI3b4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248718; c=relaxed/simple;
	bh=EovXMZ5rEW5Vy/ltOb0neFhO4PBhwJXVY0P0Kqrtbc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvkAnc7VbyQzWT1iCvbCyNoQqVYZ1e3xK5rRMi1V+W3oV4JaUmFVzIjQ8y8tk+kOqOMpxYMZuvJgfqsnDRyHV4tMIU6Eg1hPTSsNTcTTrR1O2Oac/S64jr+zB9Rs/4lV2rQ7JbD62/8Bn9oo0MbKvzjysSopQbXVijH1kgdP+Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WO0xxgKP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AR4bvvKbgikgr1hNSmWc94sjnbzhhnfkQ6MfYm0zHgg=; b=WO0xxgKP/SivlOIt43TrwECqCb
	ESdhwMe71LdmH2/CJd8gOCaKfNoDMA3ABHAG3eTnL7UZrEzpNkyVTyZ8TOFjXr5cVD4jimsAYEugf
	+bN76HC0uVZOzT3EQYZC8o7Ko9YuSgOIvnJKOsahdyw/rShXsfoTpsnoLZcKtOhEi4lo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sUBPu-002jbm-5g; Wed, 17 Jul 2024 22:38:26 +0200
Date: Wed, 17 Jul 2024 22:38:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	git@amd.com,
	Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
Subject: Re: [PATCH net-next] net: axienet: Fix coding style issues
Message-ID: <518b7c0c-54df-403a-bb06-495526e160a9@lunn.ch>
References: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721242483-3121341-1-git-send-email-radhey.shyam.pandey@amd.com>

On Thu, Jul 18, 2024 at 12:24:43AM +0530, Radhey Shyam Pandey wrote:
> From: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>
> 
> Replace all occurences of (1<<x) by BIT(x) to get rid of checkpatch.pl
> "CHECK" output "Prefer using the BIT macro".
> 
> It also removes unnecessary ftrace-like logging, add missing blank line
> after declaration and remove unnecessary parentheses around 'ndev->mtu
> <= XAE_JUMBO_MTU' and 'ndev->mtu > XAE_MTU'.

Ideally, this should of been multiple patches. In general, we want a
patch to do one thing, which makes it easier to review.

net-next is closed at the moment due to the merge window. Please
repost in two weeks, once it opens again.

	Andrew

