Return-Path: <netdev+bounces-176101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72060A68C98
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B96D3B1015
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F1520767A;
	Wed, 19 Mar 2025 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dSSWe1Nr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52322372
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 12:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386668; cv=none; b=Rt+J/spxT2ibt2gJVdb76f6PhfYa8/Qyh32udsV+qVGTtZIjhUZQDnM/6fZIL26Oc1uLjFTQGSZKV+3ygzWU9dOrvabZaTiUY0XnYUtcVsbADtCbPNZHL52yXcmREfSXhJqSjo9lbfm/NoC+1dRTzFlxtT8HM7MLZqlrTSZRyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386668; c=relaxed/simple;
	bh=5RqF4Hm4RWUNVCNQ6JIF/q+to7IRt3EfK0w5Bt5JVag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVCbXW/fQVCSUdA/j8OrcpbZCt4wsmYW3OxvUu0RdAegyp0vXj2fFkBc0mMtpuWGg5zoNPa+s6TmqbBTPRXn8WHysO63LFJtySNhftXMlGV95Q4NxpgKHPdzUWxvlDnoQg32h98QUID4ZdPrFw6IhDsYpXKhblB9kp/bR/5zgYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dSSWe1Nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C854FC4CEE9;
	Wed, 19 Mar 2025 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742386666;
	bh=5RqF4Hm4RWUNVCNQ6JIF/q+to7IRt3EfK0w5Bt5JVag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dSSWe1NrwVIM+7AzVz1cKCWi7jlwMO68r49neFA1O2Ccl9sngJ5SMbH/U/tnowX0H
	 oTwGsTCY+AssN9ybybmaixwEZ8/TXQr1ECReaCBF+cucg2YC28PZ0fcw50nTy901+s
	 llCy5g8TXRMzo2kLjGbAxUzbToI0WNC9s0OFsLsfDDfJEdOVG49QgyoDalokf8wXEr
	 6ocSXhPSrL4PbnQBEqsDFjsgkj4NT9i9iwoWmA4InOqH2F+MuR54fpWOdqrZGMFT0v
	 7n68r2Qa2SYiui7PGmNcBVBdBtxQfhDOaY9EaW08UW3AG8N9RX+WDD/YrBxIDg1fLU
	 FgTZlhfIR4aZw==
Date: Wed, 19 Mar 2025 12:17:43 +0000
From: Simon Horman <horms@kernel.org>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-next] ice: improve error message for insufficient
 filter space
Message-ID: <20250319121743.GB280585@kernel.org>
References: <20250314081110.34694-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314081110.34694-2-martyna.szapar-mudlaw@linux.intel.com>

On Fri, Mar 14, 2025 at 09:11:11AM +0100, Martyna Szapar-Mudlaw wrote:
> When adding a rule to switch through tc, if the operation fails
> due to not enough free recipes (-ENOSPC), provide a clearer
> error message: "Unable to add filter: insufficient space available."
> 
> This improves user feedback by distinguishing space limitations from
> other generic failures.
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


