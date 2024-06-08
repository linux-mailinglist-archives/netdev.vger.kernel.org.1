Return-Path: <netdev+bounces-102016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9E7901190
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB281C20C37
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FB517836C;
	Sat,  8 Jun 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4LzFsPp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9374C17C68
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851523; cv=none; b=BxU5QhLzr6epB9r8Gp2+8wttbNS/2LD9R5plfPMP7NnzCYc+3+VdjvIaM8g9/Nlpz5bms16ARM9b1WkVgAszVZiearYdQyG4ZVmBY5pSRXD4h8L0U8yzKMDCSSYPBKTjNmXXlwKmiblcjcp9aRTK8jp9xDLRBnMMA4gL9ztH7Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851523; c=relaxed/simple;
	bh=8h7iVKPU4zLmsDfT69C7Raz8WD0w2TDfKWzcdLn9Pq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu84vBQKnefVMYc4inba6PtsHthLFiwwqUPHGedGZyikBEEu8i6Wm34XGgjmupjsfpOmCl1/AqTv9rkVrHE3MvetbM0RwKAAy8Bazx/ACob9cs+yIK2rMhZs5cCkr/8CscudFyUZgFM5BVMTM72Hz+KCX//p9TagLyaJx9Vthhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4LzFsPp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4F6C2BD11;
	Sat,  8 Jun 2024 12:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851523;
	bh=8h7iVKPU4zLmsDfT69C7Raz8WD0w2TDfKWzcdLn9Pq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4LzFsPpACQdCLgYrKa/nQLxExi29Xw9BKOrw/kBHsU4tqXKRcbLw21z9hxdZXypg
	 FURcNTxtkGtj/pQ1Bynrv9zk5VXIrhxuNewDbmq6VcLfhxC9NykqQlIe3N464/HXCC
	 dnCnp8Fny7xqg8undiagjsssgUSaJPtTIXPs/JYlOXM2dTCi8Z2V4p2lWQlQuUyJ6X
	 b1ubb15dr/LxJUrK2PeubsEWDiDcbk2JaBHrDnJ8ajlvUR+f7LyJMfW8776Ae1ksal
	 /mOl5Dw8LDBx4TOJ0tvEBu9OCidsF+w12izpWBRArrbadrfETTuFj9ud2KzVyH/Yxd
	 /3EiYuveFmSEQ==
Date: Sat, 8 Jun 2024 13:58:39 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Sai Krishna <saikrishnag@marvell.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 06/12] iavf: add initial
 framework for registering PTP clock
Message-ID: <20240608125839.GY27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-7-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-7-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:54AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Add the iavf_ptp.c file and fill it in with a skeleton framework to
> allow registering the PTP clock device.
> Add implementation of helper functions to check if a PTP capability
> is supported and handle change in PTP capabilities.
> Enabling virtual clock would be possible, though it would probably
> perform poorly due to the lack of direct time access.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Sai Krishna <saikrishnag@marvell.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


