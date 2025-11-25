Return-Path: <netdev+bounces-241483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23095C846AB
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 11:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E37464E4E93
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 10:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967A125A2DE;
	Tue, 25 Nov 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tm5nc7to"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A83221FA0
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065861; cv=none; b=IdzKBNjQMtOmRsLwuVjAJrooVgVYVJtkw3wPmpgvgs5MHQw4huX9EWMUoUcCTu1f6444EU5H5oIkrfN7USzJfgoNpVlVzZD9l40efSVU2d6WJTUFUtr60NuGvny9fEfv2Z45Nj7GdM3LmnYJLIYkstyG+SZ7mU1vZTDfHJtMtEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065861; c=relaxed/simple;
	bh=Y2I04+W2Tzn1zji+1k8DLZxgVIOQtEmlCmG5JzwSYjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVVcTtpvbfTDqPQikiRlVsSspgsbi+5cuAq9yIVIcvTS5uZJEvFsOeQX7bINuxDIAgCQp5dELg4YT3r70UspK0dCoGeUapulD8NxJ13927hJbGZPxT8nEUUWFW6zgqxlj53grQWC7+66DLTt0mmKFYayVKEKxTwgvGLEy0tk1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tm5nc7to; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7C8C4CEF1;
	Tue, 25 Nov 2025 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764065861;
	bh=Y2I04+W2Tzn1zji+1k8DLZxgVIOQtEmlCmG5JzwSYjI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tm5nc7toIVNAGyC/LPx+6MCWPiY1uTwEHDLYAyNEFPwL5HqG/sODTw8G9xZwCPbqa
	 5UMvuyh0+kbbpe7vlVVUEg6Pl3dLgWzTzIOWh4ZxO3vgtP4FIusiOID6DOJvMVUel9
	 MaykBaUTn5UN2dPCaucYv5f4e9Tva1clvJ5gMhe1hruuohMhs7BbI1Z880NaAucg5m
	 LBIzuUYZYKn4e0OI38cyZKZZgPcPAVgLOm9fz/F5fWzjC1PXCi7XhN2PqaikBjVgPa
	 twBXZiqzse9OLTI1HOhWlj4AsXZDPgwbejpPLK3OhOXSent0FcEQSFMq7MvbF8KYmK
	 TGtsvJTm/qSAQ==
Date: Tue, 25 Nov 2025 10:17:37 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v4 5/6] ice: shorten ring stat names and add
 accessors
Message-ID: <aSWCQQsd-_cIKucF@horms.kernel.org>
References: <20251120-jk-refactor-queue-stats-v4-0-6e8b0cea75cc@intel.com>
 <20251120-jk-refactor-queue-stats-v4-5-6e8b0cea75cc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120-jk-refactor-queue-stats-v4-5-6e8b0cea75cc@intel.com>

On Thu, Nov 20, 2025 at 12:20:45PM -0800, Jacob Keller wrote:
> The ice Tx/Rx hotpath has a few statistics counters for tracking unexpected
> events. These values are stored as u64 but are not accumulated using the
> u64_stats API. This could result in load/tear stores on some architectures.
> Even some 64-bit architectures could have issues since the fields are not
> read or written using ACCESS_ONCE or READ_ONCE.
> 
> A following change is going to refactor the stats accumulator code to use
> the u64_stats API for all of these stats, and to use u64_stats_read and
> u64_stats_inc properly to prevent load/store tears on all architectures.
> 
> Using u64_stats_inc and the syncp pointer is slightly verbose and would be
> duplicated in a number of places in the Tx and Rx hot path. Add accessor
> macros for the cases where only a single stat value is touched at once. To
> keep lines short, also shorten the stats names and convert ice_txq_stats
> and ice_rxq_stats to struct_group.
> 
> This will ease the transition to properly using the u64_stats API in the
> following change.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

I had to read this and the next patch a few times to understand what was
going on. In the end, the key for me understanding this patch is "...
accessor macros for the cases where only a single stat value is touched at
once.". Especially the "once" bit.

In the context of the following patch I think this change makes sense.
And I appreciate that keeping lines short also makes sense. So no
objections to the direction you've taken here. But I might not have
thought to use struct_group for this myself.

Reviewed-by: Simon Horman <horms@kernel.org>

