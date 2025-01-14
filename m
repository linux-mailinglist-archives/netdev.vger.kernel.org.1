Return-Path: <netdev+bounces-158029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED49A10224
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF3316A7AD
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94332500D1;
	Tue, 14 Jan 2025 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G4oD8puY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C902500B4;
	Tue, 14 Jan 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843707; cv=none; b=lUzuCvQvqsS08+9k6+YzZMcDIVjFxx1YDYzpIGLGZKOH3eyCrOtkaA/GFnlUkWvZh/wqRb3GiLHBtjrei1Whc59XJJCB4qU5xXjgQEl1edkIFtw0C7aP4rqNvHzNydHcHfHS7TgTU8782dwjUkYUb9OxeZE0sNhzOjWSSWQ7zNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843707; c=relaxed/simple;
	bh=5Az6JReYG84QRZTtJ9fIk51QZVN4wnnJD/GoPG7m00s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8IhZWlP3ymWVuK8Yg9MoyqMKEyG9rDxMB2WyYelA2nglrZk6QK0dRxezAta/k8QLjZtGa8bIhPb+opyVDEOUQh2B3W1fxHdHiPLk+X2OE48ChZf4SOBnYQDN3J4WW+YOwsnZf3zkZpsDhedFRsSjMkozIM2/hOO3ENktAhFZt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G4oD8puY; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736843707; x=1768379707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Az6JReYG84QRZTtJ9fIk51QZVN4wnnJD/GoPG7m00s=;
  b=G4oD8puYIdElMsZhSYQXRSFtrNaAxMUMYgkCl/g18BnzOR53sxFWekzH
   WulVovV1iKpO8bMRaMDfitQhnldzrKQPgW/f5hzitZmlu5bbbAgNMuNEW
   2qkEsB7YteKTSj0YSlwyqgM8tQAT9eah3ieCNscMsA5hcsxDwpFJeG0vl
   wWVLqgT32wBY5gGLXZyoPL2oQmhLXtWgRupIJ1vSYuXFB+YT91lEPncRc
   YRTPIfzOjhfUbWXse96BZpsz9QvQcoIEniVvQD88/WWV08Vgo9rvi8Ng4
   o3dLrXBOS58axJXkB5Hh7BhYW8BY7ELUj32Q6aUESvS7soVkwAFREiBg2
   Q==;
X-CSE-ConnectionGUID: +sLLUek6TA6zePDJt5wnrQ==
X-CSE-MsgGUID: htjbxNg0SPO30Ie7GIw15A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40809353"
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="40809353"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:35:06 -0800
X-CSE-ConnectionGUID: VmRVBZe7SjioxGa7fnhNTA==
X-CSE-MsgGUID: jhB7wHLxRnmGsw0aM6JVlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,313,1728975600"; 
   d="scan'208";a="104909576"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 00:35:02 -0800
Date: Tue, 14 Jan 2025 09:31:43 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Sanman Pradhan <sanman.p211993@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
	kernel-team@meta.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	kalesh-anakkur.purayil@broadcom.com, linux@roeck-us.net,
	mohsin.bashr@gmail.com, jdelvare@suse.com, horms@kernel.org,
	suhui@nfschina.com, linux-kernel@vger.kernel.org,
	vadim.fedorenko@linux.dev, linux-hwmon@vger.kernel.org,
	sanmanpradhan@meta.com
Subject: Re: [PATCH net-next 2/3] eth: fbnic: hwmon: Add support for reading
 temperature and voltage sensors
Message-ID: <Z4Yg79d4KoBrNGFG@mev-dev.igk.intel.com>
References: <20250114000705.2081288-1-sanman.p211993@gmail.com>
 <20250114000705.2081288-3-sanman.p211993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114000705.2081288-3-sanman.p211993@gmail.com>

On Mon, Jan 13, 2025 at 04:07:04PM -0800, Sanman Pradhan wrote:
> Add support for reading temperature and voltage sensor data from firmware
> by implementing a new TSENE message type and response parsing. This adds
> message handler infrastructure to transmit sensor read requests and parse
> responses. The sensor data will be exposed through the driver's hwmon interface.
> 
> Signed-off-by: Sanman Pradhan <sanman.p211993@gmail.com>
> ---
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.c  | 89 ++++++++++++++++++++-
>  drivers/net/ethernet/meta/fbnic/fbnic_fw.h  | 15 ++++
>  drivers/net/ethernet/meta/fbnic/fbnic_mac.c | 72 +++++++++++++++++
>  drivers/net/ethernet/meta/fbnic/fbnic_mac.h |  7 ++
>  4 files changed, 179 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 320615a122e4..bbc7c1c0c37e 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -228,9 +228,9 @@ static void fbnic_mbx_process_tx_msgs(struct fbnic_dev *fbd)
>  	tx_mbx->head = head;
>  }
> 

[...]

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> --
> 2.43.5

