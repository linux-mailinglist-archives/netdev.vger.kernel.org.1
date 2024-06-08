Return-Path: <netdev+bounces-102018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF03901194
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 14:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150FD282882
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CC86178379;
	Sat,  8 Jun 2024 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxjKpeXo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19786178370
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717851564; cv=none; b=q+ms1YJ+ssXQTZLSBSgOLlAgNpdJ81OU43mGlsMo6alGdfhaukyQTVhF/yZ9oI9gC5GtMIbLbHfrRb1DBLdJxwEegwgd0VTAM2pb5MWwha5P7vs0rScEnTEFXjaMOkrpDnFNtsgU1vUQlB3r/7swSxHT3kqfDI/yppZoqw63GtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717851564; c=relaxed/simple;
	bh=10knmIN+vc6J0ik2c8OvOO/lcoOvNsnUuSif0SnI0TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTrvf9PwaLMxi2UDufO+UI0yfC/zCoaxo9oLBZ5UdwA5+2UtyHQATkmPlePQb8LxuRLkWCsfWyl03g2qcOL1c0zHMtOhlEYF4tq/hVtRrswKxtaMB/xhjVSyE4cWfTF7hEuSUgajn5C61X+SdKiAOol8vnSZIsUIA10p7LNDwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxjKpeXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B865C2BD11;
	Sat,  8 Jun 2024 12:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717851563;
	bh=10knmIN+vc6J0ik2c8OvOO/lcoOvNsnUuSif0SnI0TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rxjKpeXoGXc1H79J95KMGtOb7f48lbDc+ThjYEcs3Si4q2vc7FQjv4zoq8oMB8MlG
	 O+270mGvY2VqpvxpUoSjgJ1TfQvHDx+UoRWC2hA/ReJxjFwc7lzzDJ7vxldaWyjQwi
	 NsN8ZMKfuN1Uw0j9Qlh/L/4ibJQ3sb/BhE5yCDda7Okmbc/okGmMJBop/zcyc1CDmf
	 E5AuyoxrBaVi2jxzdNSd+0YmZx1nLsQUJtbLgF7X6tFP4lJuwao4bdD7HaboAKCKMd
	 vqLyQ6A+CU3xwPCDOgfO+f4PYGsPRyallotIQBddKrzmtFMRTMSaQmCURG81f9bbqx
	 pkKrlK6uvXTUw==
Date: Sat, 8 Jun 2024 13:59:20 +0100
From: Simon Horman <horms@kernel.org>
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v7 08/12] iavf: periodically
 cache PHC time
Message-ID: <20240608125920.GA27689@kernel.org>
References: <20240604131400.13655-1-mateusz.polchlopek@intel.com>
 <20240604131400.13655-9-mateusz.polchlopek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604131400.13655-9-mateusz.polchlopek@intel.com>

On Tue, Jun 04, 2024 at 09:13:56AM -0400, Mateusz Polchlopek wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The Rx timestamps reported by hardware may only have 32 bits of storage
> for nanosecond time. These timestamps cannot be directly reported to the
> Linux stack, as it expects 64bits of time.
> 
> To handle this, the timestamps must be extended using an algorithm that
> calculates the corrected 64bit timestamp by comparison between the PHC
> time and the timestamp. This algorithm requires the PHC time to be
> captured within ~2 seconds of when the timestamp was captured.
> 
> Instead of trying to read the PHC time in the Rx hotpath, the algorithm
> relies on a cached value that is periodically updated.
> 
> Keep this cached time up to date by using the PTP .do_aux_work kthread
> function.
> 
> The iavf_ptp_do_aux_work will reschedule itself about twice a second,
> and will check whether or not the cached PTP time needs to be updated.
> If so, it issues a VIRTCHNL_OP_1588_PTP_GET_TIME to request the time
> from the PF. The jitter and latency involved with this command aren't
> important, because the cached time just needs to be kept up to date
> within about ~2 seconds.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Co-developed-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


