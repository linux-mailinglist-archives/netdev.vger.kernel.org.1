Return-Path: <netdev+bounces-254161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ClVLeTTeWlCzwEAu9opvQ
	(envelope-from <netdev+bounces-254161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:16:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F40DE9EB49
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 10:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2686300C931
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 09:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97364341AC7;
	Wed, 28 Jan 2026 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbtuW43N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728114502A;
	Wed, 28 Jan 2026 09:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591772; cv=none; b=HJq0Hd6MiBL1YnX0DKEVRVAfVS+oV5+/b91f8qntmkN1jzpqFX9WbE8elmagpv3195BZiGE5r0V++AQf4CFXACn6LItEqs3JEqWcEPfLSr24zipu1uQu9EkxEQ/951RA88eqikgVeZuV3zmgnriyF+YEVSR2wWX35cpHXaIQQFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591772; c=relaxed/simple;
	bh=g2RmX6bqLfvTJKb1XBSuNHFWcL34fxltXzbmfoDuBFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFJvvyeFSkyyI/nuMl3YJsKbAlNbijlSCa8/OMx1DPUkzpkvvFJlGAdHJPvPkvj9haucVc/bOwnyQSTv0s/r8IUN2dbGr5owBwks+mPNG9aaUsFsll8HCLIPAlfqPtdKmNWRcje/WcFUMCinWVJ2axNmeemvUMwBDqtlbsFakhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbtuW43N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A4FAC4CEF1;
	Wed, 28 Jan 2026 09:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769591772;
	bh=g2RmX6bqLfvTJKb1XBSuNHFWcL34fxltXzbmfoDuBFk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fbtuW43NBiVucn6TftPq9S2xEQt5TSdheliJ73/4a3UA9t6rMcPi9C1PJssAWjrPm
	 qbZKcFCcIk7k/snSCaKmHopenA2C7NJfowuAgqLbHeErTxVO3/Ne0FJM0DkdGVXFLZ
	 1/GN38pz/K6itRaY523SNNW9td6fm+dS1EhCOaJihPrAiyIshoq5wEephaPJ+UPK4T
	 dRzUQWEEE79vpf/wvtaTBY+rIh/U3IHO86boj7Md05hMWHihhZwLZgk36kYGsDTD/F
	 GRkpr0Kpx82/bTvgF/iT1s0ZOlTHEb803agX5B2ZO4f6GEgE/ogPZsHiyq/R0Fv6yQ
	 KHDGROz8FVDiQ==
Date: Wed, 28 Jan 2026 09:16:06 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "illusion.wang" <illusion.wang@nebula-matrix.com>,
	dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
	sam.chen@nebula-matrix.com, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, corbet@lwn.net, linux-doc@vger.kernel.org,
	lorenzo@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	lukas.bulwahn@redhat.com, hawk@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, sdf@fomichev.me, daniel@iogearbox.net,
	john.fastabend@gmail.com, edumazet@google.com,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 00/15] nbl driver for Nebulamatrix NICs
Message-ID: <aXnT1juyBbMkiykg@horms.kernel.org>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
 <aXj-uam1HodC0851@horms.kernel.org>
 <20260127105304.21279cc2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127105304.21279cc2@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-254161-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nebula-matrix.com,vger.kernel.org,lunn.ch,lwn.net,kernel.org,redhat.com,linux.dev,fomichev.me,iogearbox.net,gmail.com,google.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: F40DE9EB49
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 10:53:04AM -0800, Jakub Kicinski wrote:
> On Tue, 27 Jan 2026 18:06:49 +0000 Simon Horman wrote:
> > As per Jakub's advice in his review of v1 [*],
> > Please try to create a minimal driver in the order of ~5kLoC.
> 
> Perhaps other maintainers will disagree, but for ease of review
> and to avoid the huge reposts perhaps we should consider merging
> something like patches 1 and 3* first, as the initial series.
> And then you can build up the driver from there in reasonable,
> 5kLoC-at-a-time series?
> 
>  * patch 3 currently includes things which do not seem machine
>    generated / like register descriptors like structs added to
>    nbl_def_channel.h and nbl_include.h

Without having looked into the details: yes, I think some
sort of staged approached could help here.

