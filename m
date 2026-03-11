Return-Path: <netdev+bounces-266599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC7OJJpGsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:40:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F018262647
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287E1302AD10
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0383AF650;
	Wed, 11 Mar 2026 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omvXq9dU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6757F35F8A8;
	Wed, 11 Mar 2026 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773224096; cv=none; b=jktWi2TcFshHPe/yCkFZpLeCmCn5SiNvT4a2/ZesGk7RAyB4kpHFb77YX+iC6w+BvHl0bK7egpHnUh972JW8AvxWuulFmS+z6BCcNjRAc0UfengBpuXvhjsUwlU5xVVE+G8qFtbGOj8DE47pEG7Me8QUZHfifPjTSYt93I2U9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773224096; c=relaxed/simple;
	bh=8NzBTafHxFIIYzj/NK+6B25hapn0+IoGoAIp8GSAk2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8q1uHWpAvYSHMlrD3y3ZpIVj/2SrDGrgtYuaIVzyyX3Q4s37WHxI86f5+Vjt+riDapmDGKzDRR7f6Ho2Qc+VUbQajJdJJE01M+q8UvGThph6rdzdA8H/7gbI0QzXimBUv6N1UaSA2AIaT1zTiRH5NVNd7bs2m2uLFGPP8p40Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omvXq9dU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EDCC2BC86;
	Wed, 11 Mar 2026 10:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773224096;
	bh=8NzBTafHxFIIYzj/NK+6B25hapn0+IoGoAIp8GSAk2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=omvXq9dUVQ+8IEM4NP4nwWQTatXPPeZdmycSZhv/Qow9WNXIG6PXAxerxp3XY2UxY
	 83entbEZw2AX1bg5/HQXnlgPYg08Q/BBtCeauWK3wfhbUcDe9VcUwO4jYncYAkDEZN
	 lEjReDZHF65LF34/dZUwINs1eT9qZih1Z7GqhgbNmf3XPBchzgubdhXH6XOz/HCbk7
	 sj/tmK4gljCTt189DfGMWlOHx3vSyCwQ1ddLG55Ca+PBMlmcXMEBBPFNxRYjxLs0v3
	 wa7Mm+wSUiZ+Sac0HNu3TU2zBlSQRcOyQEovsSESMFzyCsFLLvl9a1Yj/h23Ib8wCL
	 SMqtIflOJ1Rlw==
Date: Wed, 11 Mar 2026 10:14:50 +0000
From: Simon Horman <horms@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: cjubran@nvidia.com, matttbe@kernel.org, chuck.lever@oracle.com,
	shshitrit@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, sgoutham@marvell.com, jiri@resnulli.us,
	davem@davemloft.net, saeedm@nvidia.com, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, donald.hunter@gmail.com
Subject: Re: [v3,net-next,5/5] octeontx2-af: Add support for loading custom
 KPU profile from filesystem
Message-ID: <20260311101450.GR461701@kernel.org>
References: <20260309024619.898211-6-rkannoth@marvell.com>
 <20260310172100.890161-1-horms@kernel.org>
 <abDeXLpMMxp7G1v3@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abDeXLpMMxp7G1v3@rkannoth-OptiPlex-7090>
X-Rspamd-Queue-Id: 3F018262647
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266599-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,oracle.com,vger.kernel.org,marvell.com,resnulli.us,davemloft.net,google.com,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 08:45:40AM +0530, Ratheesh Kannoth wrote:
> On 2026-03-10 at 22:51:00, Simon Horman (horms@kernel.org) wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> >
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> > ---
> > octeontx2-af: Add support for loading custom KPU profile from filesystem
> >
> > This commit adds functionality to load custom KPU (Key Parse Unit)
> > profiles from the filesystem at module load time, providing an
> > alternative to flashing updated firmware on deployed devices.
> >
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/npc.h b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> > > index cefc5d70f3e4..5928c4d3cc8b 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/npc.h
> >
> > [ ... ]
> >
> > > @@ -290,6 +303,7 @@ struct npc_kpu_profile {
> > >  	int action_entries;
> > >  	struct npc_kpu_profile_cam *cam;
> > >  	struct npc_kpu_profile_action *action;
> > > +	struct npc_kpu_profile_cam2 *cam2;
> > >  };
> >
> > [ ... ]
> >
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > > index a466181cf908..1efc53b63b67 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
> >
> > [ ... ]
> >
> > > @@ -553,8 +553,8 @@ struct npc_kpu_profile_adapter {
> > >  	const char			*name;
> > >  	u64				version;
> > >  	const struct npc_lt_def_cfg	*lt_def;
> > > -	const struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
> > > -	const struct npc_kpu_profile	*kpu; /* array[kpus] */
> > > +	struct npc_kpu_profile_action	*ikpu; /* array[pkinds] */
> > > +	struct npc_kpu_profile	*kpu; /* array[kpus] */
> >
> > [ ... ]
> >
> > > @@ -564,6 +564,7 @@ struct npc_kpu_profile_adapter {
> > >  	bool				custom;
> > >  	size_t				pkinds;
> > >  	size_t				kpus;
> > > +	bool				from_fs;
> > >  };
> >
> > [ ... ]
> >
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > > index 352dc5f1d5b9..05aabe26f030 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc.c
> >
> > [ ... ]
> >
> > > @@ -1610,6 +1622,7 @@ u64 npc_enable_mask(int count)
> > >  static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
> > >  				    const struct npc_kpu_profile *profile)
> > >  {
> > > +	struct npc_kpu_profile_adapter *adapter = &rvu->kpu;
> > >  	int entry, num_entries, max_entries;
> > >  	u64 entry_mask;
> > >
> > > @@ -1621,10 +1634,15 @@ static void npc_program_kpu_profile(struct rvu *rvu, int blkaddr, int kpu,
> > >
> > >  	max_entries = rvu->hw->npc_kpu_entries;
> > >
> > > +	WARN(profile->cam_entries > max_entries,
> > > +	     "KPU%u: err: hw max entries=%u, input entries=%u\n",
> > > +	     kpu,  rvu->hw->npc_kpu_entries, profile->cam_entries);
> > > +
> > >  	/* Program CAM match entries for previous KPU extracted data */
> > >  	num_entries = min_t(int, profile->cam_entries, max_entries);
> > >  	for (entry = 0; entry < num_entries; entry++)
> > >  		npc_config_kpucam(rvu, blkaddr,
> > > +				  adapter->from_fs ? (void *)&profile->cam2[entry] :
> > >  				  &profile->cam[entry], kpu, entry);
> >
> > Can this dereference NULL when from_fs is true for KPUs not covered by
> > the filesystem firmware?
> >
> > Looking at the filesystem loading path in npc_apply_custom_kpu:
> >
> >     for (kpu = 0; kpu < fw->kpus; kpu++) {
> >         ...
> >         ret = npc_alloc_kpu_cam2_n_action(rvu, kpu, entries);
> >         ...
> >         for (entry = 0; entry < entries; entry++) {
> >             profile->kpu[kpu].cam2[entry] = cam2[entry];
> >             ...
> >         }
> >     }
> >
> > The code allocates cam2 and populates entries only for the first
> > fw->kpus KPUs found in the firmware blob.
> >
> > However, npc_program_kpu_profile is later called for all KPUs in
> > npc_parser_profile_init:
> >
> >     for (idx = 0; idx < num_kpus; idx++)
> >         npc_program_kpu_profile(rvu, blkaddr, idx, &rvu->kpu.kpu[idx]);
> >
> > Since adapter->from_fs is a global flag (not per-KPU), when idx >=
> > fw->kpus, profile->cam2 remains NULL (the default npc_kpu_profiles[]
> > static initializer doesn't include cam2), causing &profile->cam2[entry]
> > to compute an invalid pointer.
> >
> > Shouldn't there be a check to verify cam2 is non-NULL before
> > dereferencing it, or allocate cam2 for all KPUs when from_fs is true?
> 
> The filsystem binary contains entries for all KPUs. So we can ignore this
> case.

Maybe it is just me. But I don't think it is entirely satisfactory for
the kernel to rely on data supplied from the filesystem being well formed.
E.g. what if it is corrupted?

I think all the points in the AI generated review hinge on this.
So let's try and agree on the basic principles and move on from there.

...

