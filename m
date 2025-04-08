Return-Path: <netdev+bounces-180150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F3EA7FC18
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC883BD86B
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4A326772D;
	Tue,  8 Apr 2025 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHbbFkKm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CCD266B49
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107756; cv=none; b=a0VanjYOyJe3PA7BBOPUbQOflg8dAsDg8T7QzOQV8Sz9IbEw/WxffXB/QwyrjeKuZlxUNnEjIZvBj1Lm5pFObNNi9mu0dFS1HKfv7Bjz608VhYOhh8wgvh6UwSHoXOGdg6HGc1I69nRzp8woMQ7Ui6Mzx8hrIXzmknRFmtalUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107756; c=relaxed/simple;
	bh=kCH/a+k7unmddjwKGg0eIquZQgNgRx1HsejQiuThB9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpMCyU0969RVx8U1uVThuKoxHI4ti6j4L890tdnAJpb302uM3+x281CpuPOTATflOkPoZk4io93e1HuJXEFTlRhQIR5saoClyuY/keCjRXqtS4dV72BUvNVfUUG9hk6sDTYWsULMalO/0R6bpcFOSxHabgpniOpA8F0aQI8HaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHbbFkKm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E543AC4CEE5;
	Tue,  8 Apr 2025 10:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744107756;
	bh=kCH/a+k7unmddjwKGg0eIquZQgNgRx1HsejQiuThB9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VHbbFkKmU4IrfTc0UM9nloW8n9jHBwyJNpjxiCOY80oZo3pl/KLO0sZ9vqLzU/j+L
	 llncmF8qxgG1xjXHjTJ11KSLlqg0EybNDOH5TXQwFbm+RTINtVbxKFzQ0XgOVUoO81
	 zv/m1d9Zy8G3cXHyz0HGJvBefMKCycxxiaq++Sa7yI1lpo0bkRkkp6KOVvSgJRv5Rt
	 kjgH7M7Em81EIyq5WVNkjsGnsU3B2r1iV22KwXHi9o4CnJuO1GgLqgvao1qgqmLsi4
	 /7hK3ksjGyvmPd3rAxhTuxTtSxmuZSNKi3sQo7gdZCx0sGrfiFSRChB9nqM+881z7T
	 DSo4a1PMCVrkQ==
Date: Tue, 8 Apr 2025 11:22:32 +0100
From: Simon Horman <horms@kernel.org>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH iwl-net v2] ice: Check VF VSI Pointer Value in
 ice_vc_add_fdir_fltr()
Message-ID: <20250408102232.GW395307@horms.kernel.org>
References: <20250325020149.2041648-1-xuanqiang.luo@linux.dev>
 <20250407140242.GK395307@horms.kernel.org>
 <6c463f96-18e7-4ee9-ba74-524772e008b4@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6c463f96-18e7-4ee9-ba74-524772e008b4@linux.dev>

On Tue, Apr 08, 2025 at 10:19:39AM +0800, luoxuanqiang wrote:
> 
> 在 2025/4/7 22:02, Simon Horman 写道:
> > On Tue, Mar 25, 2025 at 10:01:49AM +0800, Xuanqiang Luo wrote:
> > > From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > > 
> > > As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
> > > pointer values"), we need to perform a null pointer check on the return
> > > value of ice_get_vf_vsi() before using it.
> > > 
> > > v2: Add "iwl-net" to the subject and modify the name format.
> > > 
> > > Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR filters")
> > > Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > 
> > > ---
> > >   drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> > > index 14e3f0f89c78..53bad68e3f38 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
> > > @@ -2092,6 +2092,12 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
> > >   	dev = ice_pf_to_dev(pf);
> > >   	vf_vsi = ice_get_vf_vsi(vf);
> > nit, but not need to repost because of this: it's seems nicer
> > not to have not to have a blank line here. And instead, if one is
> > really wanted, put it above the ice_get_vf_vsi() line.
> > 
> Thank you for the reminder. I will take this into consideration when
> submitting other patches next time. Since vf_vsi and its judgment logic
> are logically adjacent, it's better not to separate them with blank
> lines.

Yes, agreed. Thanks.

