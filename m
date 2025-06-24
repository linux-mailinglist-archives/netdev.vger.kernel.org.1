Return-Path: <netdev+bounces-200585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328BEAE62ED
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19EA719253FC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35304284B2E;
	Tue, 24 Jun 2025 10:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFO0926w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF2B223704;
	Tue, 24 Jun 2025 10:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762408; cv=none; b=UockSSy1ucdU9wXo4Bu2uqLRPFChNMS3Ch+e7aQUfCdrvVaUF00GtwAlwivXc2ygL7LBfTuXcd0yF/dZ7IttoeDIYzF2eBGdDUPAz0FDA+lxQnVe428aRTmvYoBZFYPS7v/GocUOAuruW8atpjMIfCZlRYuuBUOB3qNr8eKwVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762408; c=relaxed/simple;
	bh=73q42yl5rlwqjMiCTnbvOie+mL44U29vRg/3vAlmJmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzX5jvPVLJN2OZO1xC3m+rNDe6nwp5AaDnM+lrGH8DJzFBuqpadekRZwPYGe65TwIyf+Lz/84L3jEZy+UJEaIM7K1iwyBPl+092U553PKeYbbnPGwhq0GBB8bHT+FLBocsqP/59CByby3VTVGvEeUKlHpy1DpHpkzVzcugI0RdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFO0926w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23AFC4CEE3;
	Tue, 24 Jun 2025 10:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750762407;
	bh=73q42yl5rlwqjMiCTnbvOie+mL44U29vRg/3vAlmJmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFO0926wuv2oj9jBOywPY/U3uQk1y3J38OLoP1WAyRBCw+rF6rs3JgwEwzqCf5si+
	 fKvBop3U169kcYV/+BSzJP1PRlsoBi0Jp35HTKEu5edAGTLnaLNHBpSp+zB/fKg2q9
	 D9FgPg8a6/pSECJ6H5++p1p94JVtfaPt5AWtC/NoDJpOml4rzkckJDB28Ynln7VsRI
	 V9xy1aBcp+SVoSdPGg59AvHmGOyfAOidogp8dhy9eRuFgV9P2tQVKQvBokCGVH0uCz
	 zqcTi4YFqFojscH1ZzY84oZPuAI82zHoT8RPhhPCe0wO2FzxLjZG4i5h4iZeHhwX0H
	 kuX47JBPUaxag==
Date: Tue, 24 Jun 2025 11:53:22 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/3] net: hibmcge: adjust the burst len
 configuration of the MAC controller to improve TX performance.
Message-ID: <20250624105322.GE8266@horms.kernel.org>
References: <20250623034129.838246-1-shaojijie@huawei.com>
 <20250623034129.838246-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623034129.838246-3-shaojijie@huawei.com>

On Mon, Jun 23, 2025 at 11:41:28AM +0800, Jijie Shao wrote:
> Adjust the burst len configuration of the MAC controller
> to improve TX performance.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


