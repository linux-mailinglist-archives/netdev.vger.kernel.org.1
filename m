Return-Path: <netdev+bounces-241480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0DC84695
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 71D76344EFA
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DD4185B48;
	Tue, 25 Nov 2025 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxiMyivb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E851CA4E
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065782; cv=none; b=XeZw2ot5dALhacBaVTEFHbavnCApol4sB/zH0506N8xVeuFd0j9WqKXLTyzrcIFx4TxZvUW/Pjb8kcnI1/zZJ61tt86hzg6iGa127WLuPkbsRQ+0Rl+mLbEc7bRRAXfkJvlM8bT+cMVakNa+TcjQTP//Z859SO0sVhn72+EPrf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065782; c=relaxed/simple;
	bh=kUniJafciv27Xvx3LLc76+RtUt+Q5LB696ZK63CIuBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKzIcLiBJPgjWtj8rxIe8vyhdWLxt5vy4gh0YHvBuYyrbkgmr40DAv7twA6IuwAqcvSQviUi6qM10TcalPXX6tkxEok/B/FV4+7caysqoLPWt+4BO8NpZxPDk6oqUrL/Iun8DmyU/JC4r2u+wvxI8ox/BfrI/sOYRfmJcYvWOrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxiMyivb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB26C4CEF1;
	Tue, 25 Nov 2025 10:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764065781;
	bh=kUniJafciv27Xvx3LLc76+RtUt+Q5LB696ZK63CIuBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxiMyivbYMU3Zko+9SnrDqE8PTPwt0wQ65N6xKMonvXm3aCfi3hO3/Gx7KhmvrbJs
	 Mls7iEZ7PdcOrexJTKyU+OuamKLbsl5xtAudQVXN2tpy7JTVYgk/c40eIHUEUsTuMe
	 ut5dtx9QXbEspGZEreIEv4phPKSUvyBAuxFErupzQPgQf6TOPQd4O0X0smKsbHe60+
	 Uvl8bnGZUTkSDcwDA/4IcM/hN6IUd3/nUgjGIYrnHzru5t/IsxvEzUE4LOUIXQQA+A
	 cocHyUOxjc9O8hDDQTioomwFQvLZT7HNt+95VZeXQ9k6C+ynKrZTA1c/MogNNn1uBY
	 /yZ/wysZDFyqg==
Date: Tue, 25 Nov 2025 10:16:18 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 2/6] ice: pass pointer to
 ice_fetch_u64_stats_per_ring
Message-ID: <aSWB8tuqClJGBqrg@horms.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-2-6e8b0cea75cc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-jk-refactor-queue-stats-v4-2-6e8b0cea75cc@intel.com>

On Thu, Nov 20, 2025 at 12:20:42PM -0800, Jacob Keller wrote:
> The ice_fetch_u64_stats_per_ring function takes a pointer to the syncp from
> the ring stats to synchronize reading of the packet stats. It also takes a
> *copy* of the ice_q_stats fields instead of a pointer to the stats. This
> completely defeats the point of using the u64_stats API. We pass the stats
> by value, so they are static at the point of reading within the
> u64_stats_fetch_retry loop.
> 
> Simplify the function to take a pointer to the ice_ring_stats instead of
> two separate parameters. Additionally, since we never call this outside of
> ice_main.c, make it a static function.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

The *copy* was certainly working against us here.
But TBH, C syntax led me to read the code more than
once before seeing it.

Reviewed-by: Simon Horman <horms@kernel.org>

