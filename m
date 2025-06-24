Return-Path: <netdev+bounces-200552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1077BAE6106
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 11:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9939416AD27
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098DB27BF84;
	Tue, 24 Jun 2025 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMLlRpW+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B127B51C
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 09:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758033; cv=none; b=Gss/bXBvrgu8ZlZAbaxTx/0k1CIGwmP2db36Jq7N02n/qszlG7vPw23DNTcodnlNH9qgFEM/RzLkjTlQ8mWybUFwEJS0L8O3K/nLywf8j50AYS0wQi1tE5eK3CddC9Rh6wEf8DWqtqCTRZqMFJ7lxuvI10SfogrVsbcoJkfYlGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758033; c=relaxed/simple;
	bh=Cpfcu9O7Ls8RlW8eq9xxiKyHH7JRVWmMSVbstUW5zcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lRO8D4ZoMG5I4iNsekoJo+aVNOIO5DgMONgSZ3YXNFdhuqK2oy/x0d6zXL1cEcCFgupo8kqEM3epUpIUGI+s1XNJc04EbZVVsRLfMCgNJQyXyq5vmn1DvUzBBSye/7nK4dGwi/SVKHFkRg5f2L0ibqvevvrZIuELoySUNVTqYD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMLlRpW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2075BC4CEE3;
	Tue, 24 Jun 2025 09:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750758033;
	bh=Cpfcu9O7Ls8RlW8eq9xxiKyHH7JRVWmMSVbstUW5zcY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VMLlRpW+3fB0tMyUrHPX2cg97003Q17gQWB29Np4BkL9bkcC9C+ufG4csJZjG2dP2
	 EFOHpybbsFuyRIatceYeW9YjmVpVd0nF4+Za+qCZBNrz5xeqDvTHVxCYPBqqL2109o
	 a8wlFnlJIgJpn31Kb2bTzYPiKCScC0dx19M0O9w09FF2rkphRK4k0fE5Nxf84av/An
	 rzu/kxFY9BGcqxRKAxj+IKs5kZQeiOHIBbtJ0otZ0yiDlAWTrV3VH/sHsx52EL7BtN
	 dRI9dpC2ApI6OTVU8wyEDwK0/urYXoFP3u9EDItN4wMmBUWicStCK4UFqPKfVktak9
	 pIQJKvb2qqUKg==
Date: Tue, 24 Jun 2025 10:40:29 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: Re: [PATCH iwl-next] idpf: preserve coalescing settings across resets
Message-ID: <20250624094029.GA8266@horms.kernel.org>
References: <20250620171548.959863-1-ahmed.zaki@intel.com>
 <20250621121346.GD71935@horms.kernel.org>
 <c4164071-60c8-4b06-a710-70d5fbef2b11@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4164071-60c8-4b06-a710-70d5fbef2b11@intel.com>

On Mon, Jun 23, 2025 at 09:48:02AM -0600, Ahmed Zaki wrote:
> 
> 
> On 2025-06-21 6:13 a.m., Simon Horman wrote:
> > On Fri, Jun 20, 2025 at 11:15:48AM -0600, Ahmed Zaki wrote:
> > > The IRQ coalescing config currently reside only inside struct
> > > idpf_q_vector. However, all idpf_q_vector structs are de-allocated and
> > > re-allocated during resets. This leads to user-set coalesce configuration
> > > to be lost.
> > > 
> > > Add new fields to struct idpf_vport_user_config_data to save the user
> > > settings and re-apply them after reset.
> > > 
> > > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > > Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> > 
> > Hi Ahmed,
> > 
> > I am wondering if this patch also preserves coalescing settings in the case
> > where.
> > 
> > 1. User sets coalescence for n queues
> > 2. The number of queues is reduced, say to m (where m < n)
> > 3. The user then increases the number of queues, say back to n
> > 
> > It seems to me that in this scenario it's reasonable to preserve
> > the settings for queues 0 to m, bit not queues m + 1 to n.
> 
> Hi Simon,
> 
> I just did a quick test and it seems new settings are preserved in the above
> scenario: all n queues have the new coalescing settings.

Hi Ahmed,

Thanks for looking into this.

> > But perhaps this point is orthogonal to this change.
> > I am unsure.
> > 
> 
> Agreed, but let me know if it is a showstopper.

If preserving the status of all n queues, rather than just the first m
queues, in the scenario described above is new behaviour added by this
patch then I would lean towards yes. Else no.




