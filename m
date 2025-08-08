Return-Path: <netdev+bounces-212169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E21B1E8D2
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9331189BF4E
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7C3231826;
	Fri,  8 Aug 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJtljxQA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF54191F89
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658082; cv=none; b=KTnILARCr/AgcffTOmpova3Kev6lfEnR7+p8F+umJmybssKtD4kLp063F26hEmgjmoy6rQ7Rquuw+UEu6YsVVCKsFpluUDjdhhbE9JhKZJGJQwcjpwO0e0WXEt//27GRLZdrJ3qIDpV/gCFQP/evWznD/Pa9FJbaqTus82B9FgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658082; c=relaxed/simple;
	bh=mCvFHrFyJWO2+jrJtQ/mvBcIsRC8Fhl+HDQIdbeMsbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDO9233zWJx40LSI+ffGgNQZI78TGSd/HrA4Pc/6frggo0V1wNuRb/mvfyQ8HKwtIpCjXVr1vJ/456QMI11Gwno7O2AqOiQayIic8jghbtydqA4z3xM3zx/sCZaEOzrRJKNPbvyw5hVKl0VkXckE+Y7c/4ZPMCf1kAMJQuoUx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJtljxQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A370BC4CEED;
	Fri,  8 Aug 2025 13:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754658079;
	bh=mCvFHrFyJWO2+jrJtQ/mvBcIsRC8Fhl+HDQIdbeMsbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJtljxQATSiYNqziX+MlhVeMb/NGDhPgBxOwZ9jNAZMKAvmzNxmPMOmaUFpiCgOZQ
	 riGxFZYLtu2Adnb5IhxDOB4WSVqkAoir8qduoOrpn8vLlbQix18GSsPiSB5pF+SEd3
	 dkJiS0G/PNxKXl7d7h+Nyx8fmt8G8rnVKUEtvYiGtTCKQS14AnQZ213CQpPiobjK/S
	 l0sz/XaSieFef4ror2ug506XN0xym5wMrtIykR0q2MbrdBnurjEsO5XjZK7+JcjpUC
	 d4h5j+tF3VooqutoAqW0XxqB5VcP1H5v6lh+BmJr85XNQCpGbqUNOwx+vpwqIDA2Dv
	 1b6LxUAwKYzeQ==
Date: Fri, 8 Aug 2025 14:01:15 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: David Hill <dhill@redhat.com>, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH 2/2] PATCH: i40e Add module option to disable max VF limit
Message-ID: <20250808130115.GA1705@horms.kernel.org>
References: <20250805134042.2604897-1-dhill@redhat.com>
 <20250805134042.2604897-2-dhill@redhat.com>
 <20250805195249.GB61519@horms.kernel.org>
 <6133c0c5-8a1a-48c3-9083-8cd307293120@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6133c0c5-8a1a-48c3-9083-8cd307293120@intel.com>

On Thu, Aug 07, 2025 at 09:17:30AM -0700, Jacob Keller wrote:
> 
> 
> On 8/5/2025 12:52 PM, Simon Horman wrote:
> > On Tue, Aug 05, 2025 at 09:40:42AM -0400, David Hill wrote:
> >> When a VF reaches the limit introduced in this commit [1], the driver
> >> refuses to add any more MACs to the filter which changes the behavior
> >> from previous releases and might break some NFVs which sometimes add
> >> more VFs than the hardcoded limit of 18 and variable limit depending
> >> on the number of VFs created on a given PF.   Disabling limit_mac_per_vf
> >> would revert to previous behavior.
> >>
> >> [1] commit cfb1d572c986 ("i40e: Add ensurance of MacVlan resources for every
> >> trusted VF")
> >>
> >> Signed-off-by: David Hill <dhill@redhat.com>
> > 
> > Hi David,
> > 
> > Unfortunately adding new module parameters to Ethernet drivers is discouraged.
> > I would suggest that devlink is an appropriate mechanism.
> > 
> 
> At a glance, my initial suggestion would be modeling this with devlink
> resources?
> 
> If each VF has a devlink port in the host, we could create a resource
> that is the number of allowed filters for each VF, and the host could
> control this through the resource...
> 
> I think this might even let us nest a resource so we have one for the
> parent which is the total amount available and each VF port could have
> its amount available.
> 
> A devlink parameter could work but is a bit less flexible and doesn't
> show you the hierarchy with the total available filters within the PF vs
> what each VF is consuming.

Thanks Jacob,

For some reason I had not thought of modelling filters as a resource.
But I do agree that is is a promising approach.


