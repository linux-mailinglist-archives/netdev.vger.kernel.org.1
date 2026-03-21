Return-Path: <netdev+bounces-270191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNdKIYhivmnDOAMAu9opvQ
	(envelope-from <netdev+bounces-270191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:19:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3FD2E457C
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D039300952D
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E5531714F;
	Sat, 21 Mar 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olTX/Wol"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB42FD675
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 09:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774084741; cv=none; b=QGy1TStIeNJrbEWB4WTw9wpVi/6v8yT3uwGH+dG3ymekMJHm1Ba1ThEqwRJozPn7PQFLArqhQlCR33tubIMMh5iqvVGapX2jgyvT7UilDJ2x7Z6/SjaqPPdx1N0SZRySdCJNR63kE8n/yn/LrYvfypu4ccFoy+fByqsz3gBD2wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774084741; c=relaxed/simple;
	bh=+PT2Ef3M/EjliKhKgDJD4Sx3IT5CPfpBTznnG/+7vHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPQTCDUXbCAklZj3r9WxzkiSEzGnexUcMEWtUx/f6GAM4/rlgoEYSyvt7a/0W2NcI+OPPYQI+oQOU4SQY25rIp/4V8FaV4tyo5fpt6eArDa7JyACKMOrpB44nFQ+fq95w2pU1IgZyK6Ks921MJOnW23CtP6od18j5ky6dgikoFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olTX/Wol; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E2DC19421;
	Sat, 21 Mar 2026 09:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774084741;
	bh=+PT2Ef3M/EjliKhKgDJD4Sx3IT5CPfpBTznnG/+7vHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=olTX/WolFzZ4TWAxYX/Rb+2iYgz/gE4jTXBWYe6j7SgwGPgFLNax5HcBUSGZpomzT
	 U6VVJtcA7GqvwZ3sg8HUhsBy802+46Rs15UqsMbtnOv+hg013HiFtydbFbqQg+l4xD
	 pt1ILCGuFxkNdyGlGl8RL4Qq5lTMYasJECGq4OqCEYzWy9mVP0Exax9T49zR+xJ4VE
	 p8lYCFnBzzLJM5xvnJ8pDeVpeyW55qmmIDCXXGWgAbylPm5y+nFZFbzxV8JFpoVjYQ
	 W+zFc6xqVvPxTqZ3u6gvJDKmbEHNzRhcTv4+z8NqnCqk5dS98IKB0e9SOezNsjI5cg
	 HVjb6B5K+zp1g==
Date: Sat, 21 Mar 2026 09:18:57 +0000
From: Simon Horman <horms@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: aleksandr.loktionov@intel.com, netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH iwl-next] ice: do not carry link status over to link
 event data
Message-ID: <20260321091857.GU74886@horms.kernel.org>
References: <20260320050525.422403-1-aleksandr.loktionov@intel.com>
 <20260320193314.171338-1-horms@kernel.org>
 <c1731a39-bcb1-408a-9630-f8878c270d05@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1731a39-bcb1-408a-9630-f8878c270d05@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270191-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,horms.kernel.org:mid]
X-Rspamd-Queue-Id: CF3FD2E457C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 03:05:24PM -0700, Tony Nguyen wrote:
> 
> 
> On 3/20/2026 12:33 PM, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> > For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> > ---
> > ice: do not carry link status over to link event data
> > 
> > This patch removes code that updated the link_up parameter with the
> > current firmware state after calling ice_update_link_info().
> > 
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> > > index e7308e381e2f..348c86b7328d 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_main.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> > > @@ -1127,12 +1127,6 @@ ice_link_event(struct ice_pf *pf, struct ice_port_info *pi, bool link_up,
> > > 
> > >   	ice_check_link_cfg_err(pf, pi->phy.link_info.link_cfg_err);
> > > 
> > > -	/* Check if the link state is up after updating link info, and treat
> > > -	 * this event as an UP event since the link is actually UP now.
> > > -	 */
> > > -	if (phy_info->link_info.link_info & ICE_AQ_LINK_UP)
> > > -		link_up = true;
> > > -
> > 
> > Could removing this check create a race condition with stale link events?
> 
> This was a part of other changes that allows this to happen. By itself, as
> evidenced here, it does not.

Thanks for the clarification, much appreciated.

