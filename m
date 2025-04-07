Return-Path: <netdev+bounces-179767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99756A7E7C9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547603A5E29
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 17:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359BB2144A1;
	Mon,  7 Apr 2025 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXXDKqG7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1137013B2A4
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045300; cv=none; b=S+FtuB2N4x/TzkGEM2GGvgq0hAAA8HKeiUMHASIt98SuHSMENizflBoIqWDne6Bct3bnun1koUyvdlTpjKdFKzisLejdWYEDkFwA7NcAbsKQp2vllXC5bwW8DUv7KziKDgKDwvlD6kGRwgCN3jJ/+fqNgzdymtMAAb+pXlWaNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045300; c=relaxed/simple;
	bh=TcYVVMKz+9KUG5j/KFF2VWP+iXlophYUojrRrbk8stM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kp7reF5+2pvzhqMkmSIQKEwo9NcudDKPI7qmHBbbMdbe/lYRNRlRPL3hT/10qRxC9hqDqRp/MyKg45PgYCA76fFaxvI3ouPp7YPfmt5Z3cUBkwJwSc1L0H6KYKLY8QgH/gm+FSOI/Xilh5GKW/vnzd1SfZzs/Hv9FB6N8Sfsrd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXXDKqG7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468B4C4CEDD;
	Mon,  7 Apr 2025 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744045299;
	bh=TcYVVMKz+9KUG5j/KFF2VWP+iXlophYUojrRrbk8stM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VXXDKqG7Wh+Kq3ubkSM1i7O2GXSuM5ZEKhn+lL1XAI7YaVMvrPP/lX8lcjmz56hhn
	 e/Sa2CHIJRFwFu276k9xpaFgISqng9mYc+v7oh4WmGJIHKNVyg16DM6ZfoyhaEae7P
	 yxB1oCDLwnb8SK1RiYChHun3/xqov/XQLmT88Srm+aeJn4mdRewZF3W2XQ3U5z/dTd
	 S6YemgamKEDpxo+BmoQUJ+wFNpRgywBC45Vh7vvsGZhgPPA7LzYopvdDvTILTb6OGg
	 4DtMXdT1d3tWwIM1VMNCqtZGKwzbodK8yeh2M0wybGpLZkbfn0yvISBEbXIfIAB1vA
	 Y4ZHkUxsmIG1Q==
Date: Mon, 7 Apr 2025 10:01:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Andrew Lunn
 <andrew@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>,
 netdev@vger.kernel.org, hkallweit1@gmail.com, davem@davemloft.net,
 pabeni@redhat.com
Subject: Re: [net PATCH 1/2] net: phy: Cleanup handling of recent changes to
 phy_lookup_setting
Message-ID: <20250407100138.160f5cb7@kernel.org>
In-Reply-To: <CAKgT0UeJvSSCybrqUwgfXxva6oBq0n9rxM=-97DQZQR1kbL8SQ@mail.gmail.com>
References: <174354264451.26800.7305550288043017625.stgit@ahduyck-xeon-server.home.arpa>
	<174354300640.26800.16674542763242575337.stgit@ahduyck-xeon-server.home.arpa>
	<Z-6hcQGI8tgshtMP@shell.armlinux.org.uk>
	<20250403172953.5da50762@fedora.home>
	<de19e9f1-4ae3-4193-981c-e366c243352d@lunn.ch>
	<CAKgT0UdhTT=g+ODpzR5uoTEOkC8u+cfCp7H-8718Zphd=24buw@mail.gmail.com>
	<Z-8ZFzlAl1zys63e@shell.armlinux.org.uk>
	<8acfd058-5baf-4a34-9868-a698f877ea08@lunn.ch>
	<Z--HZCOqBvyQcmd9@shell.armlinux.org.uk>
	<CAKgT0UeJvSSCybrqUwgfXxva6oBq0n9rxM=-97DQZQR1kbL8SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 4 Apr 2025 09:18:30 -0700 Alexander Duyck wrote:
> > > Yep, this is pretty typical of SOHO switches, you use strapping to set
> > > the port, and it never changes, at least not without a soldering iron
> > > to take off/add resistors. There are also some SOHO switches which
> > > have a dedicated 'cpu port' and there is no configuration options at
> > > all. The CPU MAC must conform to what the switch MAC is doing.  
> 
> I don't think you guys understand my case well either. You seem to
> think I am more flexible than I actually am in this setup. While I do
> have the firmware I can ask about settings all it provides me with is
> fixed link info. I can't talk to the link partner on the other end as
> it is just configured for whatever the one mode is it has and there is
> no changing it. Now yes, it isn't physically locked down. However most
> of the silicon in the "fixed-link" configs likely aren't either until
> they are put in their embedded setups.

I understand this code the least of all of you, obviously, but FWIW
in my mind the datacenter use case is more like trying to feed
set_link_ksettings() from the EEPROM. Rather than a OS config script.
Maybe call it "stored link" ? Not sure how fruitful arguing whether 
the term "fixed-link" can be extended to cover this is going to be :S

