Return-Path: <netdev+bounces-102013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2954A901189
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C1B1F218BC
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DECD178362;
	Sat,  8 Jun 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SyVkMvGS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2965417C68
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851471; cv=none; b=SUNhezWoAmMNUVNX2ZAObAgxs+HGwUGjc5358FNMtZpMEuXTskauf/ssfGwpDmcdGlBM1c0QDb4fHBqc71MboIJ7OVMjyE7fHwnxzSKgXYBYt8Rdvoywbg02ZXcYxNZihbQ6udfHP8UQ5bz71nXi0lNy8x3oqZOdiBy68pThSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851471; c=relaxed/simple;
	bh=udIIL34H/KnoLM4gnyOrsBM8rLUatCzup1YtpQ5MNr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvTRxv0n+Lfkidjo43vwPy5xgGpzt1+I+TLp012wJk6BBVahSLmglKd9zqsjZpgUJM+2vK/VqED1mSYlKsnJIIcKT5vLyDSuNNkNcg2IrWN7KhVJ2QO/Dul7oLDTAohjWFxj4/QJ10NtFP8fZhsc52oToe86iUMTA8f8IBVrxbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SyVkMvGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EA2C2BD11;
	Sat,  8 Jun 2024 12:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851470;
	bh=udIIL34H/KnoLM4gnyOrsBM8rLUatCzup1YtpQ5MNr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SyVkMvGSuZWY2B/9ImWjiLF0Rtc0o6IrVxotRo4yjttEEVlE/NCPjOwVTbrTpjBEj
	 qbUF7Q1duJO+EzzIrCe1P5KcNqarV9VJrA6g38dcZ8URQOc3DRtx8b2o8XSixEzxWL
	 6syLQ6oaZyLIBPLv/ujTPaBM8weMklyKG8jiiC0AdQD9xbwbnA/IeLdNRMwRXcXlmV
	 FttuW//YenNdwyt3PDmhAo+FFx5HIeOx64bupY02ETo6P3gJmROJaMq81JTGqkrOFQ
	 2JdyUVh4L3RQ6adnwTFS2tRyfwYUqZOyrjTfMb3jeeR7yokU2r5DGN8JKXrrNCxPLC
	 3ENJHTJBTsAxA==
Date: Sat, 8 Jun 2024 13:57:47 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 03/12] virtchnl: add
 enumeration for the rxdid format
Message-ID: <20240608125747.GV27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-4-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-4-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:51AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Support for allowing VF to negotiate the descriptor format requires that
> the VF specify which descriptor format to use when requesting Rx queues.
> The VF is supposed to request the set of supported formats via the new
> VIRTCHNL_OP_GET_SUPPORTED_RXDIDS, and then set one of the supported
> formats in the rxdid field of the virtchnl_rxq_info structure.
> 
> The virtchnl.h header does not provide an enumeration of the format
> values. The existing implementations in the PF directly use the values
> from the DDP package.
> 
> Make the formats explicit by defining an enumeration of the RXDIDs.
> Provide an enumeration for the values as well as the bit positions as
> returned by the supported_rxdids data from the
> VIRTCHNL_OP_GET_SUPPORTED_RXDIDS.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


