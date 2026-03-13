Return-Path: <netdev+bounces-267458-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCmQAY0WtGlkgwAAu9opvQ
	(envelope-from <netdev+bounces-267458-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:52:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7617A284443
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 14:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7075F30B4871
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2574A38F636;
	Fri, 13 Mar 2026 13:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZJFFGOD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034793659FF
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408896; cv=none; b=BEyalX53rKLD+OYKNX+/uiiKtEiMn0mQvVZ00FL5/z2ms8lNcmzZWXi7KfGinPdNaY4BeseCm6Ymp+tJTPdxrVamq7i1llIKKNBLBERvdoht+m5HIlvW8sEhLHutr+gYH23Bl8awVgEkgyH3UYULaoWLqlnMyzQA/R1Y6os+rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408896; c=relaxed/simple;
	bh=90zTevJdzu6deh7sGl/tQMJmAekN5bujMcUwaYFzm0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urr6QsAlCWxJUY5Joor9KZa5Vei/5Lu0xHs9D5+x20VDyLM+tnt93HzMA+M9hQS6mGokwzHDpnyEuTSvrx//iTXqGZ/+72xhE1a+ZFBk12rSbKelUMCMPwTYyyPefUr4pIufTDACdLoXbvKY03WhAwU/mRHi906234wmpJl7Iss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZJFFGOD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F81C19421;
	Fri, 13 Mar 2026 13:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773408895;
	bh=90zTevJdzu6deh7sGl/tQMJmAekN5bujMcUwaYFzm0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZJFFGODrGFjZfTI78cukJYH9nCTl70Nhlfep/6evq0ipXyIcAZsklsedjWx3yVpp
	 Ykch0ynhqDRalKtgLfA8W2acek6+ri/g3/NnrIsFP2VxUEtmkIhamQYdejvcSLYdTA
	 NmYwtzVXg5K7j/843T62Ej/WSbhtg82SKcTh74cTOAAHmCheZjRj/kIVa+JaZwIy9V
	 xw2ohNR236NogKdOJ0uXfZ+hCdIkHUpdkz6/wNUGXRDx7xJmhJudRPBWJ+BwEmmYbf
	 q5/marx+kVbAZi7BAqx1zOsAAZyIItt7STh/1YFMU7MS8oCyvghWdfUMH1ELjdvhD4
	 9M9I4KWRti+wA==
Date: Fri, 13 Mar 2026 13:34:51 +0000
From: Simon Horman <horms@kernel.org>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock_info
Message-ID: <20260313133451.GZ461701@kernel.org>
References: <20260309141220.343224-1-przemyslaw.korba@intel.com>
 <20260310182458.GQ461701@kernel.org>
 <PH0PR11MB49044CA89B5D8780D477561D9447A@PH0PR11MB4904.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB49044CA89B5D8780D477561D9447A@PH0PR11MB4904.namprd11.prod.outlook.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267458-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,osuosl.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7617A284443
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:42:10PM +0000, Korba, Przemyslaw wrote:
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Tuesday, March 10, 2026 7:25 PM
> > To: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>
> > Subject: Re: [PATCH iwl-next] i40e: PTP: set supported flags in ptp_clock_info
> > 
> > + Jacob
> > 
> > On Mon, Mar 09, 2026 at 03:11:51PM +0100, Przemyslaw Korba wrote:
> > > Since upstream commit d9f3e9ecc456 ("net: ptp: introduce
> > > .supported_perout_flags to ptp_clock_info") and commit 7c571ac57d9d ("net:
> > > ptp: introduce .supported_extts_flags to ptp_clock_info"), kernel core
> > > now requires that the driver set the .supported_perout_flags and
> > > .supported_extts_flags fields in PTP clock info. Otherwise, the
> > > additional flags will be rejected by the kernel automatically.
> > >
> > > i40e does not support perout flags, so reject any request with perout
> > > flags.
> > >
> > > Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> > > ---
> > >  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 12 +++++++++++-
> > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > index 7bcea7d9720f..8d7958692235 100644
> > > --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > > @@ -601,10 +601,18 @@ static int i40e_ptp_feature_enable(struct ptp_clock_info *ptp,
> > >  	/* TODO: Implement flags handling for EXTTS and PEROUT */
> > >  	switch (rq->type) {
> > >  	case PTP_CLK_REQ_EXTTS:
> > > +		if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
> > > +					PTP_RISING_EDGE |
> > > +					PTP_FALLING_EDGE |
> > > +					PTP_STRICT_FLAGS))
> > > +			return -EOPNOTSUPP;
> > > +
> > >  		func = PTP_PF_EXTTS;
> > >  		chan = rq->extts.index;
> > >  		break;
> > >  	case PTP_CLK_REQ_PEROUT:
> > > +		if (rq->perout.flags)
> > > +			return -EOPNOTSUPP;
> > >  		func = PTP_PF_PEROUT;
> > >  		chan = rq->perout.index;
> > >  		break;
> > 
> > I am a little confused.
> > 
> > My understanding of the cited patches is that they add checking of flags to the code. So code like the above isn't needed in drivers.
>  
> Hi Simon, thank you very much for the review. My understanding is that the driver needs to set the supported flags field, otherwise requests won't go through kernel. The test I've been doing confirm my theory. Here's also example patch, that adds supported flags to drivers: https://lore.kernel.org/intel-wired-lan/20250414-jk-supported-perout-flags-v2-1-f6b17d15475c@intel.com/

Sorry for the slow response.

My understanding is that the hunk above is not required.
But the hunk below is.

> 
> > > @@ -1340,7 +1348,9 @@ static int i40e_init_pin_config(struct i40e_pf *pf)
> > >  	pf->ptp_caps.n_ext_ts = 2;
> > >  	pf->ptp_caps.pps = 1;
> > >  	pf->ptp_caps.n_per_out = 2;
> > > -
> > > +	pf->ptp_caps.supported_extts_flags = PTP_RISING_EDGE |
> > > +					     PTP_FALLING_EDGE |
> > > +					     PTP_STRICT_FLAGS;
> > >  	pf->ptp_caps.pin_config = kzalloc_objs(*pf->ptp_caps.pin_config,
> > >  					       pf->ptp_caps.n_pins);
> > >  	if (!pf->ptp_caps.pin_config)
> > >
> > > base-commit: d5fbc991435eac7a1ead7cd2ddb5a743528718bb
> > > --
> > > 2.43.0
> > >

