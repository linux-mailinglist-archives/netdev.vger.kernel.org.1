Return-Path: <netdev+bounces-212531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75208B211FE
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374A2188D9E6
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A3C311C15;
	Mon, 11 Aug 2025 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCHyhKOO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8A2311C00
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754929303; cv=none; b=oyXp33KUsfTH0ktTGzVRYO+xrd/WbKPBjnxbOj2W5tSvZRzwZdbr0My+3eg90GREQrdCGx30gkbqcByKFPxxGA8zDk2LLvWxPLtwdgT/2RjC+4XuPrwZDEA+7iF2cMsQJhD+kR1fBLsJucxRdSgTl1myvE580iLw/xYgWYgOtyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754929303; c=relaxed/simple;
	bh=TppvVuRqgbxW7gVpzMk+P0ZaW9d9lAQRUKQyT5Z2v1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a+P7xw6KMWkVqV8ON/UYLyT+OVaZhCpcPUCSH4BIB4kDPHfBs28pUafUecgsftXbgmGzcFnNppvPrqg7y//9dbDP1K9MQKcGEQ8dnDrJJHCSTfdvneBLQh6pjqawz+/iXluIgBV45y7HsitCuAbkANczWrALOO1PvqZ9vBiDcPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCHyhKOO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB507C4CEED;
	Mon, 11 Aug 2025 16:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754929303;
	bh=TppvVuRqgbxW7gVpzMk+P0ZaW9d9lAQRUKQyT5Z2v1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tCHyhKOOyF5jfDyd4f7gLKaTRa22khucAuazbs/JJoRwEFEWrpjyovdqZZxgwQPIR
	 NYyrEmK/enM5DSfwlSL453C6X48a2bPq9lNx0e+XhzRP7xveA4HGoNAvXe/155VIHB
	 iUvM63AZRadVkZNstmq2kKfClquu0JESlbmap5wumaVJoKuLiT+JxYq3ZXRw5dm5KC
	 f9sJYxxWUK5ZD916wCc8w8VF5gesTixTx61okipCy4ZbRgwTkT29oM00PfVsLqmJ/F
	 emQDqSAuS1skpGfFTv++fJxJeAWWShI7WlAu2aPmnoC20+tNejIFpYCtbMGgKma7ET
	 CedIGlBjG+IIQ==
Date: Mon, 11 Aug 2025 09:21:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew@lunn.ch>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Tariq Toukan <tariqt@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, intel-wired-lan@lists.osuosl.org, Donald
 Hunter <donald.hunter@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [RFC PATCH v4] ethtool: add FEC bins histogramm report
Message-ID: <20250811092142.5b9288d5@kernel.org>
In-Reply-To: <34da824b-1922-418f-953f-99287443b088@linux.dev>
References: <20250807155924.2272507-1-vadfed@meta.com>
	<20250808131522.0dc26de4@kernel.org>
	<ec9e7da6-30f0-40aa-8cb7-bfa0ff814126@linux.dev>
	<20250811084142.459a9a75@kernel.org>
	<34da824b-1922-418f-953f-99287443b088@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 17:08:34 +0100 Vadim Fedorenko wrote:
> On 11/08/2025 16:41, Jakub Kicinski wrote:
> > On Sun, 10 Aug 2025 11:52:55 +0100 Vadim Fedorenko wrote:  
> >> Well, the current implementation is straight forward. Do you propose to
> >> have drivers fill in the amount of lanes they have histogram for, or
> >> should we always put array of ETHTOOL_MAX_LANES values and let
> >> user-space to figure out what to show?  
> > 
> > Similar logic to what you have, you can move the put outside of the
> > loop, let the loop break or exit, and then @j will tell you how many
> > entries to fill..  
> 
> I see. Fair, I can do it. After this change there will be no need to
> change the code in the reply size calculation, right?

I think you need to split in two, one for the normal val and one for
the array.

