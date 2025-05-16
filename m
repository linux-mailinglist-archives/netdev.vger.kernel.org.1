Return-Path: <netdev+bounces-190962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA34EAB9821
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE641791D7
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:54:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D048922D4EB;
	Fri, 16 May 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwP23tBv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA540282E1
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385662; cv=none; b=H5FC+pQnByuzAkqs3F7MrfiZ06ThEu5nvu8cejzc9osSu3WblrlZwvqWNlVeayUgDSjxrDSM9z1y7dXFn9y4zdHeWTXD2VSyQb3E5p8b2LT6WG6GQssy6wn357LnwFGWSdQs3jl6DfQdPvL6olCxsMYAiucW/uFq/yIcLDJn1ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385662; c=relaxed/simple;
	bh=kqNfuqIpJP2D+shmIHhSZCXWQ2xZC26II6h6gPhLJzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVjOJRF6op6OeyjJWruOrqyxL5apTq13IhhN9fgUnieBbJvvP/0uNtXapb3i8RSn8Fe89xK4g0kgVi7jRuMMZvxpEYh+/XX95OcPLkl3QhPd6fokjRC9kxQW+ibRSAzAYO0iwgUnQsz0VARmn7ykVO1BoNrBCsq6n6G1xmCyT5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwP23tBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC13C4CEE4;
	Fri, 16 May 2025 08:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747385662;
	bh=kqNfuqIpJP2D+shmIHhSZCXWQ2xZC26II6h6gPhLJzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwP23tBvlMnD2x31qkzoP8rQmmeqnh1VU1W7Vp3bW5Bh4NyKMwAijzkUiyDn8m6fI
	 KedmjSRjrFFZEAWhCVQio3vV4W1t3NGqa26elPKclXuxDDbortFZj38vb1CcJpHl/A
	 Sk/4zhgyvUPBqsJ1y6Dm2zDCAMJFwl+NrCO+QTsS13s5AOWbPKT9ny9ICzefliDbA8
	 m/k4S2JjODEIVtyKoVy3cKR7cSo3OCROxSMffMKyRNhf16IeyNcEC89sXKamOKKdws
	 wTf2/1dm903g4T4aX/xJuf1NGL2wzE5hVmnx8K0mNq3TlAfPl4uDA+Zl7is9q2+1J9
	 jXwj9FD7LTPNQ==
Date: Fri, 16 May 2025 09:54:16 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	sridhar.samudrala@intel.com, aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com, dinesh.kumar@intel.com,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, almasrymina@google.com,
	willemb@google.com, pmenzel@molgen.mpg.de
Subject: Re: [PATCH iwl-next v5 1/3] virtchnl2: rename enum virtchnl2_cap_rss
Message-ID: <20250516085416.GC1898636@horms.kernel.org>
References: <20250423192705.1648119-1-ahmed.zaki@intel.com>
 <20250423192705.1648119-2-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423192705.1648119-2-ahmed.zaki@intel.com>

On Wed, Apr 23, 2025 at 01:27:03PM -0600, Ahmed Zaki wrote:
> The "enum virtchnl2_cap_rss" will be used for negotiating flow
> steering capabilities. Instead of adding a new enum, rename
> virtchnl2_cap_rss to virtchnl2_flow_types. Also rename the enum's
> constants.
> 
> Flow steering will use this enum in the next patches.
> 
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


