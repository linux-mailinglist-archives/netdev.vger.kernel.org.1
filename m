Return-Path: <netdev+bounces-280059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOZ/AB0+52no5QEAu9opvQ
	(envelope-from <netdev+bounces-280059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:06:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB434389EB
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 11:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A67AF306A42A
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 09:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C6D3A1A48;
	Tue, 21 Apr 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnewWg7W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32653A3827;
	Tue, 21 Apr 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776762182; cv=none; b=e/xGY3pj+enBewu913Az/KYXHfMOmaEO0wBB3RXDpMBhLxqm1G79YJT9J68wsb6V7M8uThOk6MR9EvB0q/1KAO5V6mvMqbk/gOI24sNrx6/RG7PKwdrF29Ut6XX1tpHh1GyByg82YeHpg6HuOc0o96AxzMEpKBSUUE/QaoFt4hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776762182; c=relaxed/simple;
	bh=IEJ6LJnEjNWGmodZMyE/CMbkC0WeFWjPZXCMP+gk6s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXzWO0ZwPHDO243dwbjKCzQbdR5lTHJTjS0HzFV8Ymq/2SQVGDTuzUV8gZfYU40DfEqspUfZzva+I5eZrABf3CpDozP50usvVFCjdEWmvfZ4mKruPGBHfLOCoijMaSt+Q4VrHd+Z2coIABQv5YyjlgFuIIUDNWgdGw3USof+ySw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnewWg7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765E9C2BCB0;
	Tue, 21 Apr 2026 09:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776762182;
	bh=IEJ6LJnEjNWGmodZMyE/CMbkC0WeFWjPZXCMP+gk6s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bnewWg7W3/r/Kjb34Nql+lE28RpJVx1afI7U0D99UBjTN1wp2NN30jql1O0453c0D
	 NFoVBA6S7RvR9pGxh/77ExoEs9T1sLUBbMxLW+MPc36qXBw31iC1waBnKSAWgyDViQ
	 HtEByGWAc+9Aen/GA5IkIZkcXc39d+M4QALGaDyyTf4Rynqhj7/ycvzjbYliZWhWZL
	 zGiEiICZt8crX+5PUdCd4qp4N2tPvAYdT1MY59PcVJyPmtpUHWAhfx0Gq4fG4SurWD
	 yUPSIaQimQ0io9qZkpvYxqYa1dQ+SpcqGe5O5vIyNzdPvjRJYPRvM4HmmH9Jdc8uYY
	 Iqu6m77CV2iug==
Date: Tue, 21 Apr 2026 10:02:54 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Aaron Brown <aaron.f.brown@intel.com>,
	Przemyslaw Patynowski <przemyslawx.patynowski@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com
Subject: Re: [PATCH iwl-net v2 0/4] iavf: fix VLAN filter state machine races
Message-ID: <20260421090254.GW280379@horms.kernel.org>
References: <cover.1776426683.git.poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776426683.git.poros@redhat.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280059-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9BB434389EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 04:29:41PM +0200, Petr Oros wrote:
> The iavf VLAN filter state machine has several design issues that lead
> to race conditions between userspace add/del calls and the watchdog
> task's virtchnl processing.  Filters can get lost or leak HW resources,
> especially during interface down/up cycles and namespace moves.

...

Hi Petr,

Sashiko has a bit to say about this patch.
I'd appreciate it if you could look over that.

In particular, the feedback on patches 2 and 3 may warrant
some updates to this patchset, while I think 4 is more
in the realm of possible future work.

