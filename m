Return-Path: <netdev+bounces-278369-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAdZLGgK3mnRmQkAu9opvQ
	(envelope-from <netdev+bounces-278369-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:35:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997A3F8004
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:35:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA7E7300D0C2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A5B344D8B;
	Tue, 14 Apr 2026 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PV77rM/F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116BD2253FC
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159333; cv=none; b=FROw2vAI5PPjQb/LSH9OaWMBCt4JfB1jkoQzoChq4o9I2BGJaNAG1eLKfqGEBelyrhxdqNsGpgc5qsybJGzZ5JhPvBXI/BqBiSQBSf09xsQO7hFAm0ZcRYlHwRShvzEZxaLS61sz+7lp9Y44qM1TLibMMYQG3PwE9jvobKQhNrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159333; c=relaxed/simple;
	bh=tra6XbY2ZXS84BCeCHJ/jfRvO2OJtZrT+BiKRYt0ooc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKS03ICpiA1NmIFfdXyl1W55r0SG8QkvFqPAGgw1lXWIGyih0jmKlyQwYwgX7EhcXb6uHGh3dhkPX/dnI2sRn5s+yiQ6wa7XcsASfR77LBXrjny/qKhB/5kxHZmNhaXWHbAA3hCoQ9si7N/ghg5S2BEbvFWyLtLV4TWNMQEGiac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PV77rM/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EE2C19425;
	Tue, 14 Apr 2026 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776159332;
	bh=tra6XbY2ZXS84BCeCHJ/jfRvO2OJtZrT+BiKRYt0ooc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PV77rM/F7X6Fmm7xlFaKKHRcuuPm0D3weHM7oCa1AhuovRi62+4lsgQ7uMUGvW2SV
	 eUx8ByvT4Ott3FWTVPd468Hhx00qqHN2lgBVdohnuvOIRG5qUg37doeg5xLGul2kM/
	 v66igD1LiVZ6Oegi2H8ronSXgilZarl0wqZeuO4ZiC31+cVm2XOpQzAAeFX0eODdbo
	 OLM2TuFLXuFce/wgC5UHgMzaGiLjknhPPy58vtz51hsDMTALM4e1p97R3iYbHapLHO
	 lQ1VI+4V/MhPL2LVQyAj3k0LeVzmV4MqmHJOCAz4JKtYJ0yVLGkfAEl/3xPEAWxHJc
	 +G1J9m1vRj3+Q==
Date: Tue, 14 Apr 2026 10:35:29 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, Karen Ostrowska <karen.ostrowska@intel.com>
Subject: Re: [PATCH iwl-next 7/10] ice: emit user-visible info message for
 non-contiguous ETS TC config
Message-ID: <20260414093529.GZ469338@kernel.org>
References: <20260410074921.1254213-1-aleksandr.loktionov@intel.com>
 <20260410074921.1254213-8-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410074921.1254213-8-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278369-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5997A3F8004
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 09:49:18AM +0200, Aleksandr Loktionov wrote:
> When the remote LLDP peer advertises a non-contiguous TC
> mapping the driver silently falls back to a default single-TC
> configuration. This leaves the user without any indication of
> why their DCB configuration was not honoured.
> 
> Print an informational message at the entry of
> ice_dcb_noncontig_cfg() so the user knows ETS with
> non-contiguous TCs is not supported and that the driver
> has fallen back to defaults.
> 
> Suggested-by: Karen Ostrowska <karen.ostrowska@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> index bd77f1c..1c53b09 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
> @@ -712,6 +712,8 @@ static int ice_dcb_noncontig_cfg(struct ice_pf *pf)
>  	struct device *dev = ice_pf_to_dev(pf);
>  	int ret;
>  
> +	dev_info(dev, "Non-contiguous ETS TC config not supported, falling back to default single TC\n");

Sashiko points out that this seems to be controlled by user input.
If so, it should probably be rate limited.

> +
>  	/* Configure SW DCB default with ETS non-willing */
>  	ret = ice_dcb_sw_dflt_cfg(pf, false, true);
>  	if (ret) {
> -- 
> 2.52.0
> 

