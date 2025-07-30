Return-Path: <netdev+bounces-210916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE079B15724
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 03:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B3418A6DF0
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 01:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD11B423D;
	Wed, 30 Jul 2025 01:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzykC+XO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D551518C933
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 01:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753840307; cv=none; b=eqJzGUsmXgcMiBMRdSS6c2xDNYAHjIf/xbp9pQiUfU+VpSVUHk3Q1isUpg0oHHtKcmu/gAummzfGepWqWrDswR52QdZz/5KK8SvmR6dwktLocfkbIG2gjMZM5oOufpivaGeMhtpHm3C3++OYjdZbAWnCRGQBTCPhmgv0q8Q7FDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753840307; c=relaxed/simple;
	bh=9HtHkWm6oII2ugGm/Moxtwt6YQVO4r1lJgDoKI68LxA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILZMOmzTaPkgKcx5B7qi13dAdGfk1oQX5yahuUojAZXE984TSN5+BzqM8Xq9jtAl43ICA6y6EP19jMuAwnFzZGYY+frKfKczYBPjQDXa6cItRB3j1nM1vwL4u+uFmCQZycBztHu6Bmtzf9l1NAMomhRKFpBMojnAIlp5zJ8GfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzykC+XO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA632C4CEF4;
	Wed, 30 Jul 2025 01:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753840307;
	bh=9HtHkWm6oII2ugGm/Moxtwt6YQVO4r1lJgDoKI68LxA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzykC+XOO5rqiwCzELyqP3kpawzzt+5KH8oHFAKznqjQ9uQSBrotKDMYiQzIppRtP
	 W0J+OcPwxOc+7CMaqz8AytXq2JegaBJopxNWYjAQpQOu6S9T0pqEYzl5r7z+FPlEpQ
	 DYz5ZSHLe46xjJ6zdv/Tkte/rFJ/0AyevkLAxOVOBtOn7YJ5n6uxLMiyftGAh0hiUT
	 1KcB7Z8Lf8dyYiDvfudSorOPe/EfK6z49kNu8T44ZuVIoDfmtGYRWVAboKLPuk2dWW
	 exgQrNgld0QW/pwhIrl1uV3SFmkieyV+tP2bpwR5F5BxqFahpdSoWxB4lL5c3D1za6
	 CxFXd7yZ0Z33A==
Date: Tue, 29 Jul 2025 18:51:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald
 Hunter <donald.hunter@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, netdev@vger.kernel.org
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
Message-ID: <20250729185146.513504e0@kernel.org>
In-Reply-To: <424e38be-127d-49d8-98bf-1b4a2075d710@linux.dev>
References: <20250729102354.771859-1-vadfed@meta.com>
	<982c780a-1ff1-4d79-9104-c61605c7e802@lunn.ch>
	<1a7f0aa0-47ae-4936-9e55-576cdf71f4cc@linux.dev>
	<9c1c8db9-b283-4097-bb3f-db4a295de2a5@lunn.ch>
	<4270ff14-06cd-4a78-afe7-1aa5f254ebb6@linux.dev>
	<c52af63b-1350-4574-874e-7d6c41bc615d@lunn.ch>
	<424e38be-127d-49d8-98bf-1b4a2075d710@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 19:07:59 +0100 Vadim Fedorenko wrote:
> On 29/07/2025 18:31, Andrew Lunn wrote:
> >> The only one bin will have negative value is the one to signal the end
> >> of the list of the bins, which is not actually put into netlink message.
> >> It actually better to change spec to have unsigned values, I believe.  
> > 
> > Can any of these NICs send runt packets? Can any send packets without
> > an ethernet header and FCS?
> > 
> > Seems to me, the bin (0,0) is meaningless, so can could be considered
> > the end marker. You then have unsigned everywhere, keeping it KISS.  
> 
> I had to revisit the 802.3df-2024, and it looks like you are right:
> "FEC_codeword_error_bin_i, where i=1 to 15, are optional 32-bit
> counters. While align_status is true, for each codeword received with
> exactly i correctable 10-bit symbols"
> 
> That means bin (0,0) doesn't exist according to standard, so we can use
> it as a marker even though some vendors provide this bin as part of
> histogram.

IDK, 0,0 means all symbols were completely correct.
It may be useful for calculating bit error rate?

A workaround for having the {-1, -1} sentinel could also be to skip 
the first entry:

	if (i && !ranges[i].low && !ranges[i].high)
		break;

