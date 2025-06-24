Return-Path: <netdev+bounces-200789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCFCAE6E8E
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A177AFE78
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 18:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E26E2E610B;
	Tue, 24 Jun 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KomAcBEr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B27230278
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750789494; cv=none; b=mftItmOXwD0oxmvDKEnmFeUjhxf5PgqpqVRzJXI8FvSSQKeKMjBjt6WuxYfRtncmVD0+ks8a0L5w5np02ZrZPV3c9icK/Xn5/nrfVKJQATkWJHFEn9s3bn7EByvp5t/zB9d+fTgfBfAIbR9ZhfjMJfKV5UDvnQmtCRPlFqv/4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750789494; c=relaxed/simple;
	bh=qNzBolCW/0TvKofxzonjiIYCSzhbbAmy3dKIcNzAgTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Itqhsf5tc5SsjR229HeKHFXyHGbZdKSkJhFHNQTEjAAZ86tX7455DgxY4JnEuaFEiZZvSedXC9rGVSpemzowhSXlfOLuFriinkvYzz5kPFw7q8BTTWrdDxxJ0k6C0ICuNIHaoRGwyTZXrfoF0mntiX/BlXq8NjiEryyQ4nI4CWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KomAcBEr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AE8C4CEE3;
	Tue, 24 Jun 2025 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750789493;
	bh=qNzBolCW/0TvKofxzonjiIYCSzhbbAmy3dKIcNzAgTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KomAcBErbOUZfvwqOJPLJQvI2j1QdeW93ZEl78I/KDTKwRbnzu51ZytpHdWs6GzNw
	 4kaB+ox690ZSLCjV6D/CJy/qPNqIRdR+v+2SpxIgW54DbdFintkPZ1GFaUIkWbjxCt
	 oUifIM1IDB0ZidfArMbIg2UnD2wUPvJUz3xKcp9IAWbPtmZCRr+v5XRokDuwcg6orC
	 gzpGrbMvf9B+fqzBlehymS//4sHFKNwLZpejOzo4mqj9Ld14y+auqB7lyEWPP8b/hG
	 st5LM5TRvve2ONH9BjKdx2mlcyTK+4rPjmi1vi6ZAWQApNnCLG/ldE1QZfiWRoHm9R
	 iyvB7Nu70Bn8g==
Date: Tue, 24 Jun 2025 19:24:50 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: Re: [PATCH iwl-next] idpf: preserve coalescing settings across resets
Message-ID: <20250624182450.GC1562@horms.kernel.org>
References: <20250620171548.959863-1-ahmed.zaki@intel.com>
 <20250621121346.GD71935@horms.kernel.org>
 <c4164071-60c8-4b06-a710-70d5fbef2b11@intel.com>
 <20250624094029.GA8266@horms.kernel.org>
 <4adc2963-a5f2-459c-9535-301e207f8cb2@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4adc2963-a5f2-459c-9535-301e207f8cb2@intel.com>

On Tue, Jun 24, 2025 at 10:13:38AM -0600, Ahmed Zaki wrote:
> 
> 
> On 2025-06-24 3:40 a.m., Simon Horman wrote:
> > On Mon, Jun 23, 2025 at 09:48:02AM -0600, Ahmed Zaki wrote:
> > > 
> > > 
> > > On 2025-06-21 6:13 a.m., Simon Horman wrote:
> > > > On Fri, Jun 20, 2025 at 11:15:48AM -0600, Ahmed Zaki wrote:
> > > > > The IRQ coalescing config currently reside only inside struct
> > > > > idpf_q_vector. However, all idpf_q_vector structs are de-allocated and
> > > > > re-allocated during resets. This leads to user-set coalesce configuration
> > > > > to be lost.
> > > > > 
> > > > > Add new fields to struct idpf_vport_user_config_data to save the user
> > > > > settings and re-apply them after reset.
> > > > > 
> > > > > Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> > > > > Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> > > > 
> > > > Hi Ahmed,
> > > > 
> > > > I am wondering if this patch also preserves coalescing settings in the case
> > > > where.
> > > > 
> > > > 1. User sets coalescence for n queues
> > > > 2. The number of queues is reduced, say to m (where m < n)
> > > > 3. The user then increases the number of queues, say back to n
> > > > 
> > > > It seems to me that in this scenario it's reasonable to preserve
> > > > the settings for queues 0 to m, bit not queues m + 1 to n.
> > > 
> > > Hi Simon,
> > > 
> > > I just did a quick test and it seems new settings are preserved in the above
> > > scenario: all n queues have the new coalescing settings.
> > 
> > Hi Ahmed,
> > 
> > Thanks for looking into this.
> > 
> > > > But perhaps this point is orthogonal to this change.
> > > > I am unsure.
> > > > 
> > > 
> > > Agreed, but let me know if it is a showstopper.
> > 
> > If preserving the status of all n queues, rather than just the first m
> > queues, in the scenario described above is new behaviour added by this
> > patch then I would lean towards yes. Else no.
> > 
> > 
> 
> I don't believe we can call this new behavior. Actually, the napi IRQ
> affinity pushed to CORE few weeks ago behaves in the same manner; deleting
> queues and re-adding them restores the user-set IRQ affinity.

Right, in that case it's certainly not a showstopper.

Reviewed-by: Simon Horman <horms@kernel.org>


