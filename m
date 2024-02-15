Return-Path: <netdev+bounces-71911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947D78558CF
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF4B28D1CC
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A7717E9;
	Thu, 15 Feb 2024 01:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IP4XpKT5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180415D1
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707961733; cv=none; b=aIWFxt/KdSUZhjYr5IZcfr5A5cH4onqKBMKuWg6iTUtkKAdfOfrNDyDMz3NXGmv9OV25hJGRcUQ1cg2uJKdRJMokpJtGjxqkDVJkMh9kt8iBsx9DBeEzWS++GSVKUcRI/qlxjL36ueF3/VUggqTKJuJBcAte/FStoytw3TcDQK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707961733; c=relaxed/simple;
	bh=xkhSILE+/K7ZL9GISttocyi6q5Ym9WIcNr0RJlFjLbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StaD3tx9XJL4xsR/eA2uzc6IY5coeynaLf1xXDswxTac0lwBhcvB2XOc0c4FrLRUFGV5o3/x/GiheD8dhdMNMks9Wad+RyDOxA4aMubRlh/UNkvujwITo4Zgmpzf3c9dznua1Ba/tSGdwQWZmXcYnoE8E+3ElbTOp/OoaBOvB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IP4XpKT5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BCAC433F1;
	Thu, 15 Feb 2024 01:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707961732;
	bh=xkhSILE+/K7ZL9GISttocyi6q5Ym9WIcNr0RJlFjLbU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IP4XpKT5d4Ecp9D4k0pCVUHy2iz0sB3cFqBoszs9dgmziabRGOQGXFntEQpCsbGvi
	 IJEh5CxIINpiN4C4e/70bmwbXEFZU0n6knvGBCQwiOfKTuugHq1+vQKH85xhyYF2kQ
	 iO7RrvioJIvWZN3YKZ8UM7p5IEciWHm1GwSBxs2oSRmhzVWLr+FntEAtmPYi3nCA+J
	 VrTF0rMqdDAkEUvV3ReKvRPP2A2R/yI8NNhem4ncp0+vmj+CohKvqP4t/voBbf2hA3
	 H49HbYwwqfAC8b9Zrf4oqyLFFx/r9rSS0CslRsCPSx2t3mgga8IcqejAnAEnGBrDsv
	 wOiAKaZEuyYWw==
Date: Wed, 14 Feb 2024 17:48:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/5][pull request] Intel Wired LAN Driver
 Updates 2024-02-12 (ice)
Message-ID: <20240214174850.3dac6f97@kernel.org>
In-Reply-To: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
References: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 13:11:54 -0800 Tony Nguyen wrote:
> This series contains updates to ice driver only.
> 
> Grzegorz adds support for E825-C devices.
> 
> Wojciech reworks devlink reload to fulfill expected conditions (remove
> and readd).

Looks like this got (silently) applied, thanks!

