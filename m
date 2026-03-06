Return-Path: <netdev+bounces-264814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMEuG+vjqmkTYAEAu9opvQ
	(envelope-from <netdev+bounces-264814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:25:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C18712229F6
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 15:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9D77314FC8E
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 14:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185F3932CE;
	Fri,  6 Mar 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTTnofvF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F000292B44
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772806709; cv=none; b=fxeuYF9PK9eXuSoFXSs7fZVzjBiVB+OkhhwDf3WZgUhMTfdWkcWHwepCZB1HxQZUucotHELq4y/eaXxzoZXETYGaJcYGU4EwvMH0A6kjsUUnOqQ0QmnGYrjktgXCagnKzCVDtqsPj7AmjGHLzmXb08PQgEU9Nqiq5QfJLZH/rQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772806709; c=relaxed/simple;
	bh=7KPGysg3KbSJoPMO+usCcbFIqEq5hjvPWe2DjAfY36Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzDKQZfXPKU9LyiqMWSCz5lA7lbONfOp4ghSQTaPpP6If1Vbwovm75QZtpbZl6+XvDq4Cy6O52tKuwWYRxmD8WIqj0k5KqRwIrhf6qGHvALRBrrV0j+cCDdwl0WIC6sHKSZYI+FSskrHKiRYPyWuO9jLZrh1+GyrQt69Wfapf6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTTnofvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CE7C4CEF7;
	Fri,  6 Mar 2026 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772806708;
	bh=7KPGysg3KbSJoPMO+usCcbFIqEq5hjvPWe2DjAfY36Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTTnofvF3Nlzkug39QioKWgTvBz5RnIQ7wT0lbNOK/y7sWwBt0luvjWYsPFyBw/5J
	 0VzpNZDxqvvvfByjlO6zL5CIc5+nO62LqEwo5TRq4qzuQjdGiA0sGVs6BeW0Ux/HsM
	 XhbZD3VIF1Hmpm+rWaYIgwGKiu/PGytjAxesGrjGgNzVSuBgiLpHxKYAPCF2PUF+i0
	 TQBwAsKOniXVa0gjtmmd4Y6Icciwk2Hdmd+chALllnL875BPW/jr9P/zndBqqSMlyb
	 3a/7REVlpTQICm6CQhE/YKfmbHr74Uq6tFgZBaVChELDPdtQcSNqgjeeRf0h/JVzjE
	 O6xc7SQKC6Qaw==
Date: Fri, 6 Mar 2026 14:18:25 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: Re: [PATCH iwl-net v1] ixgbe: stop re-reading flash on every
 get_drvinfo for e610
Message-ID: <20260306141825.GE461701@kernel.org>
References: <20260304084232.2937498-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304084232.2937498-1-aleksandr.loktionov@intel.com>
X-Rspamd-Queue-Id: C18712229F6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264814-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 09:42:32AM +0100, Aleksandr Loktionov wrote:
> ixgbe_get_drvinfo() calls ixgbe_refresh_fw_version() on every ethtool
> query for e610 adapters.  That ends up in ixgbe_discover_flash_size(),
> which bisects the full 16 MB NVM space issuing one ACI command per
> step (~20 ms each, ~24 steps total = ~500 ms).
> 
> Profiling on an idle E610-XAT2 system with telegraf scraping ethtool
> stats every 10 seconds:
> 
>   kretprobe:ixgbe_get_drvinfo took 527603 us
>   kretprobe:ixgbe_get_drvinfo took 523978 us
>   kretprobe:ixgbe_get_drvinfo took 552975 us
>   kretprobe:ice_get_drvinfo   took       3 us
>   kretprobe:igb_get_drvinfo   took       2 us
>   kretprobe:i40e_get_drvinfo  took       5 us
> 
> The half-second stall happens under the RTNL lock, causing visible
> latency on ip-link and friends.
> 
> The FW version can only change after an EMPR reset.  All flash data is
> already populated at probe time and the cached adapter->eeprom_id is
> what get_drvinfo should be returning.  The only place that needs to
> trigger a re-read is ixgbe_devlink_reload_empr_finish(), right after
> the EMPR completes and new firmware is running.  Additionally, refresh
> the FW version in ixgbe_reinit_locked() so that any PF that undergoes a
> reinit after an EMPR (e.g. triggered by another PF's devlink reload)
> also picks up the new version in adapter->eeprom_id.
> 
> ixgbe_devlink_info_get() keeps its refresh call for explicit
> "devlink dev info" queries, which is fine given those are user-initiated.
> 
> Fixes: c9e563cae19e ("ixgbe: add support for devlink reload")
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


