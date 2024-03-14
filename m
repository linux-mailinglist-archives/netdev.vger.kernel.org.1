Return-Path: <netdev+bounces-79785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 222A387B5DF
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 01:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49541F23461
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 00:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BA57FD;
	Thu, 14 Mar 2024 00:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnEEKw1o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5A4A08;
	Thu, 14 Mar 2024 00:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710376870; cv=none; b=GdOLhsQDujcdObkVXuWeSrJeP55YKwoH7UMzXPZgoZqEwl2Yh1O0SXwzbwA6P7D7exBBZNliFzBOn6eN/D9lfm/SvC/rRMiPnbkhiQ/Ijmr+9cws+epTsr2yZfTUrgewOu3YiN7LBRC95QGTCIQzPRcJknvygiWyQVMGTrEa13g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710376870; c=relaxed/simple;
	bh=eD+uotCFe+35IjxBkN0TPFuBJ75DEOy9AK7U4bDL9KQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tL8mvWRtw5oAGrhH3qPqr82Ar7OE5dB2EJBCNykBy11tNsQYzKfFQZxA6A3H3j9IEzDcEyqK1tiYX9mBq9H2GPxuqqVJuwsvy1zxiO3Alko3IeGdy8iXik0ZM/h7XTqBnFWmCAyUITm9FNGriuSQl7P6D6392FztTlOVhaeDUCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnEEKw1o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56803C433C7;
	Thu, 14 Mar 2024 00:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710376869;
	bh=eD+uotCFe+35IjxBkN0TPFuBJ75DEOy9AK7U4bDL9KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HnEEKw1ofgcQuImzio4YMUoAbvAsSLA28uj0/RANc7uFKUueu+UwXVmwEeLIAFsjc
	 gH30p/LnFW+ftu4ZR1v6S5FbiBGt8AYX3f8HyQPyksP4MfbsnfAKZCdrfn4xIEgtYI
	 niupOrfSSBRbOzZBUku9sPrfx1TYLa2cd7+rRPP7qLeiBSNImZ+Pp/aQIwlengePjU
	 28u53O+amb7T8stJs6/rAxV6DqNGdqaxpOpA9o3I+KMdVR+0yCtyyAmpjusg13sNAg
	 p4QWoa8kpkXHNe6d3MxW0a2+yecEHQetiMIIsAkr99dw4yXhxQLc2l5SiODa2Nbfea
	 ynCdwDr4Gcfkw==
Date: Wed, 13 Mar 2024 17:41:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: ahmed.zaki@intel.com, aleksander.lobakin@intel.com,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, corbet@lwn.net,
 davem@davemloft.net, dtatulea@nvidia.com, edumazet@google.com,
 gal@nvidia.com, hkallweit1@gmail.com, jacob.e.keller@intel.com,
 jiri@resnulli.us, joabreu@synopsys.com, justinstitt@google.com,
 kory.maincent@bootlin.com, leon@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org, pabeni@redhat.com,
 paul.greenwalt@intel.com, przemyslaw.kitszel@intel.com,
 rdunlap@infradead.org, richardcochran@gmail.com, saeed@kernel.org,
 tariqt@nvidia.com, vadim.fedorenko@linux.dev, vladimir.oltean@nxp.com,
 wojciech.drewek@intel.com
Subject: Re: [PATCH RFC v2 1/6] ethtool: add interface to read Tx hardware
 timestamping statistics
Message-ID: <20240313174107.68ca4ff1@kernel.org>
In-Reply-To: <87le6lbqsa.fsf@nvidia.com>
References: <20240223192658.45893-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-1-rrameshbabu@nvidia.com>
	<20240309084440.299358-2-rrameshbabu@nvidia.com>
	<20240312165346.14ec1941@kernel.org>
	<87le6lbqsa.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 17:26:11 -0700 Rahul Rameshbabu wrote:
> Makes sense given that these are stale and should have been changed
> between my v1 and v2. Here is my new attempt at this.
> 
>  /**
>   * struct ethtool_ts_stats - HW timestamping statistics
>   * @tx_stats: struct group for TX HW timestamping
>   *	@pkts: Number of packets successfully timestamped by the hardware.
>   *	@lost: Number of hardware timestamping requests where the timestamping
>   *            information from the hardware never arrived for submission with
>   *            the skb.

Should we give some guidance to drivers which "ignore" time stamping
requests if they used up all the "slots"? Even if just temporary until
they are fixed? Maybe we can add after all the fields something like:

  For drivers which ignore further timestamping requests when there are
  too many in flight, the ignored requests are currently not counted by
  any of the statistics.

Adjust as needed, I basing this on the vague memory that this was 
the conclusion in the last discussion :)

>   *	@err: Number of arbitrary timestamp generation error events that the
>   *           hardware encountered.
>   */

Just to be crystal clear let's also call out that @lost is not included
in @err.

