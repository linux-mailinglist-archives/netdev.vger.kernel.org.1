Return-Path: <netdev+bounces-259238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAr7FtSFlWm/SAIAu9opvQ
	(envelope-from <netdev+bounces-259238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:26:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B958D154B76
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21B5130078DC
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 09:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7C933A71F;
	Wed, 18 Feb 2026 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd25Sy6B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889AF2C11EE
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406767; cv=none; b=enRso0H5W6cOuFl9HPs9XzxwRnIj2cnvzgM7qlZSQyG88c/+oSsrvWG06e2vsXLAsMacsF1Hs2uYyxrrCMyzK2UROoyn+ZAZrayQegoTo+/fUxRgq646D2VsM/leKCe2+pLJbeb6y1dgOYvIgj4MyiB6VfA7uWshTpQgTUc3p7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406767; c=relaxed/simple;
	bh=TLfKk2qADOrbfEuoBvhVTAIQXEmEQg3OyhClYssyi+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zh33xL88Yb+Kq1ohTedpkuZvUKYHpjiN5HWc/f/wUA+ucQ5rXENvNlmXxnGfqXUrboeebdpG71qdUjitN3uE99azZ+ptxu077Jkko/gDjy+J3uTKmvUXHIqcRmZzfz398xB5M/L3Q0LmapDQlZgKvmgQkf4LbAlZh2YOGKCypMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd25Sy6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F13C19421;
	Wed, 18 Feb 2026 09:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771406767;
	bh=TLfKk2qADOrbfEuoBvhVTAIQXEmEQg3OyhClYssyi+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rd25Sy6BoRHD4/ffww6s9HAOxt1aJRcGlZVuLkXC1340br/EyvtvtNKzn9cq6Y9YB
	 rzGXypO7d1nPBiW4mAg2gp80FS5nXuVmTZlboU5bwELH8GJTdcvgjSUd5Pqyk5qLxS
	 Xak01NvEqNjC48nRlLUCFonz22EHPoujXM6XrnLBfRyMi12T3or+sfLvpZqsc0pYeo
	 p2PgXOt8uSFvV2RnebrsWw2HcD0DbWtc5sPlQ0bKmy+A3j6BDC46J46/9ZgNbCxxu3
	 FIALwvy3I+YmiNcOIwVu4QQQl1C1PWG81fdfr87VnsfVT8xIg1yg3LY9kr8gnn2WuC
	 KBNRph9BdlNug==
Date: Wed, 18 Feb 2026 09:26:04 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] ice: implement symmetric RSS hash
 configuration
Message-ID: <aZWFrEqPvAKxQB3z@horms.kernel.org>
References: <20260217130039.1802805-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217130039.1802805-1-aleksandr.loktionov@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259238-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: B958D154B76
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 02:00:39PM +0100, Aleksandr Loktionov wrote:
> The driver advertises symmetric RSS support via supported_input_xfrm
> but ice_set_rxfh() ignored the input_xfrm parameter, making it
> impossible to configure symmetric hashing.
> 
> Fix ice_set_rxfh() to check rxfh->input_xfrm and call
> ice_set_rss_hfunc() with ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ when
> RXH_XFRM_SYM_XOR is requested.
> 
> Modify ice_set_rss_vsi_ctx() to use vsi->rss_hfunc instead of
> hardcoding ICE_AQ_VSI_Q_OPT_RSS_HASH_TPLZ, and export it for
> use by ice_set_rxfh().
> 
> The kernel requires get_rxfh_fields() to report symmetric hash
> configurations when symmetric transforms are supported. Update
> ice_get_rxfh_fields() to return symmetric field configuration
> (src+dst IP and ports) for all flow types.
> 
> Tested with tools/testing/selftests/drivers/net/hw/rss_input_xfrm.py
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
> v1 -> v2 preserve valid symmetric RSS fields.

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

