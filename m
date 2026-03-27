Return-Path: <netdev+bounces-272489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFB4IXBZxmkrJAUAu9opvQ
	(envelope-from <netdev+bounces-272489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:18:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 092293425D4
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04DB630C8722
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 10:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BEA39F168;
	Fri, 27 Mar 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiNOaueV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAAA32C942
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606233; cv=none; b=TfFIiPduPZuBOJJh2w3ufDWjihwETYpCRWJ9JBcfG+Ozv7CsXLGQHK6KacxqYOOutjU+TcjjDd5Sjawlax9Vr9wWk3iaA5xn1hQFqlFyPfFRix4irdTIzgyvlKjLGzDU3AdjcehaYI5bKrpJtD8aizhza6JZ0BSO5VGjwF96U0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606233; c=relaxed/simple;
	bh=5qndRQUCI/S9WQE+YEGeO8WuGVF0l+SDDd3ePJMUvaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCh6KTFvpfRNoNdTjKkPErXy/eqK6nkVFcNj4OftzZ+o7S7cnI595mgl1tkz1i1rlOvite3hXSdDEw9nakHI7jiAmmydz1WcHhTFtuo2GtuXLRENLlRNcwt78JsxT7lqaSBOmljU4rUjzA8TF68f7B0L8I8S9C+V2Rl35w+/04U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiNOaueV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23853C19423;
	Fri, 27 Mar 2026 10:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774606233;
	bh=5qndRQUCI/S9WQE+YEGeO8WuGVF0l+SDDd3ePJMUvaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TiNOaueVhRQAZ6rHjt5rniIZci+Y9tuafAn2G7tnO+PH2B0H0y2HnjYJYvnaBMDzk
	 jXNgoxevO/SeLCkmr4h76WC1tsBSorb/MdwX8tsp6lsuQw79VreKhmFwhM7/H/y4oO
	 +ClCibO8ouNO+RhmD1oKItLzAxxnS83qAN4/WYgTHnwfi0Uut0PqsskDnyuKBdXLRz
	 pHKCBACaHdiGXl5uQxlOg0Ryjh/gW6cmnqHWoO2FgUhpVh/ibLtzZGNI8bQ1zPlOjU
	 hgPu6QsJjk9Py/jvkT65Br44yXF3XDSHoitKQpNzr0g71dIvgbtRqWu8TSEppGRGKT
	 BdJ2mnXgh9gsg==
Date: Fri, 27 Mar 2026 10:10:29 +0000
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v1] ixgbe: fix eeprom_id staleness and non-fatal
 EMPR reload failure
Message-ID: <20260327101029.GE111839@horms.kernel.org>
References: <20260320051455.427282-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320051455.427282-1-aleksandr.loktionov@intel.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272489-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 092293425D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:14:54AM +0100, Aleksandr Loktionov wrote:
> Three related bugs around FW version reporting after EMPR reset on E610:
> 
> 1. ixgbe_refresh_fw_version() silently discarded the error return from
>    ixgbe_get_flash_data(), so a failed NVM re-read left adapter->eeprom_id
>    with whatever stale data it held before the reset.  Propagate the error
>    and set eeprom_id to "unknown" on failure so that ethtool -i and
>    devlink dev info never show a version that no longer reflects reality.
> 
> 2. ixgbe_devlink_reload_empr_finish() returned 0 without ever refreshing
>    the FW version after the EMPR completed.  Add the refresh call, but
>    treat it as best-effort: a failure to re-read flash does not mean the
>    EMPR itself failed.  Log a netdev_warn() and return 0 so devlink
>    reports the correct reload outcome.
> 
> 3. ixgbe_reinit_locked() never refreshed the FW version for E610.
>    Because E610 has no FW event that notifies peer PFs when an EMPR
>    triggered by another PF's devlink reload completes, any PF that
>    subsequently goes through reinit would keep stale data in hw->flash
>    and adapter->eeprom_id.  Add the same best-effort refresh here,
>    gated on ixgbe_mac_e610, with a netdev_warn() on failure.
> 
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> index 56aabaa..40d593b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
> @@ -1155,12 +1155,30 @@ static int ixgbe_set_eeprom(struct net_device *netdev,
>  	return ret_val;
>  }
>  
> -void ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter)
> +/**
> + * ixgbe_refresh_fw_version - re-read flash data and update eeprom_id cache
> + * @adapter: board private structure
> + *
> + * Re-reads the NVM/flash and refreshes the cached adapter->eeprom_id string.
> + * On failure the cache is set to "unknown" so that ethtool -i never shows a
> + * stale version string after a failed reset.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int ixgbe_refresh_fw_version(struct ixgbe_adapter *adapter)
>  {
>  	struct ixgbe_hw *hw = &adapter->hw;
> +	int err;
> +
> +	err = ixgbe_get_flash_data(hw);
> +	if (err) {
> +		strscpy(adapter->eeprom_id, "unknown",
> +			sizeof(adapter->eeprom_id));

nit: I think you can omit the size argument to strscpy
     because eeprom_id is an array.

> +		return err;
> +	}
>  
> -	ixgbe_get_flash_data(hw);
>  	ixgbe_set_fw_version_e610(adapter);
> +	return 0;
>  }
>  
>  static void ixgbe_get_drvinfo(struct net_device *netdev,

...

