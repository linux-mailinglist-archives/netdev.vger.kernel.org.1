Return-Path: <netdev+bounces-278354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGJiBmQD3mkRmAkAu9opvQ
	(envelope-from <netdev+bounces-278354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:05:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 846443F7A53
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E5AA301DD96
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBEC29A9C3;
	Tue, 14 Apr 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISLbYqQm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91F9382F00
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157489; cv=none; b=Ynnld0jU2mG6kK0EdN+O5vmti1lihXTQmUFSwe2aIogUqJjM7UkNK3Uc3euBo86EdFKUzoqAbRJRJlJUlVmcI2opz9LXpk4HNqFJvP9sIMqke+5QHeVPyabUmZzKNOd54GOhiZSoIzp64ohkhw8MEnQhPCqV0n4wynRZrIQiwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157489; c=relaxed/simple;
	bh=JJHgXdaywcrs/YUTvzPh7LAar39SbrQoipL1n9cetjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTIWtbuZ5KM3B+IbSicG+am9vjB8GNTiSpZ9/MmGqHS30cjncUzAC3xCvTMpJ4qsjTHsJZZCMrEJ6+eK5PREvwV7TRAfNAggznfrO1E8JcivF+xsMTNy7cafAwb1adHVon4atqQiM17BS35gUxzN7LddnjkmjcRYJiv6eRTUfmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISLbYqQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE33C19425;
	Tue, 14 Apr 2026 09:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776157489;
	bh=JJHgXdaywcrs/YUTvzPh7LAar39SbrQoipL1n9cetjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ISLbYqQm8+XFSWvqFF8bJsv2FSvLP7lQqJ6pE7KBhmhTkL/xe+Mx/hZzBrzdEQqMm
	 09rhHRYQlzhJq3rs86UPMOGC85ZZmkvakQgyfceyD7vrhbdmSQ7EaQvCCNvQhXMWos
	 Cgyt+ASyoSH6yTOt2V1UHbPN0qUrX0LPu79F6q8YL0QUydIqZNeW3CBoHnQ7wB5k59
	 9deCVr3nXEYtOJ6XEPPR2CghU6WuAQ9zqCPlH0P4qX4jY4vW3h+S7B06M902PThK7w
	 DAFBAwwlW+VTCGteclFLUz07R1CjRtdK3KGxV2lZ7u7q+G8dCkInnRWmBFuy8y1R98
	 I2hvgEwm+uYHg==
From: Simon Horman <horms@kernel.org>
To: aleksandr.loktionov@intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	jacob.e.keller@intel.com
Subject: Re: [PATCH iwl-next 2/10] ice: allow setting advertised speed and duplex for all media types
Date: Tue, 14 Apr 2026 10:04:29 +0100
Message-ID: <20260414090429.740296-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410074921.1254213-3-aleksandr.loktionov@intel.com>
References: <20260410074921.1254213-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278354-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 846443F7A53
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
ice: allow setting advertised speed and duplex for all media types

This commit allows setting advertised speed and duplex for all media types by
only refusing media types NONE or UNKNOWN in strict mode. It adds AUI and NONE
to the ice_media_type enum.

> diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> index e6a20af6f63de..62d214c5582ad 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
> @@ -2634,10 +2635,14 @@ ice_set_link_ksettings(struct net_device *netdev,
>  	if (!pi)
>  		return -EIO;
>  
> -	if (pi->phy.media_type != ICE_MEDIA_BASET &&
> -	    pi->phy.media_type != ICE_MEDIA_FIBER &&
> -	    pi->phy.media_type != ICE_MEDIA_BACKPLANE &&
> -	    pi->phy.media_type != ICE_MEDIA_DA &&
> +	lenient_mode = test_bit(ICE_FLAG_LINK_LENIENT_MODE_ENA, pf->flags);
> +
> +	/* Setting the speed and duplex advertised by autonegotiation is
> +	 * supported for all media types, so only return unsupported for media
> +	 * type none or unknown in strict mode.
> +	 */
> +	if ((pi->phy.media_type == ICE_MEDIA_NONE ||
> +	     (pi->phy.media_type == ICE_MEDIA_UNKNOWN && !lenient_mode)) &&
>  	    pi->phy.link_info.link_info & ICE_AQ_LINK_UP)
>  		return -EOPNOTSUPP;

Will AUI media types still be rejected here in strict mode?

The patch adds ICE_MEDIA_AUI and ICE_MEDIA_NONE to enum ice_media_type, but
doesn't appear to update ice_get_media_type() to actually return these new
values. 

If AUI media continues to fall through to ICE_MEDIA_UNKNOWN, wouldn't the new
logic still reject it when lenient mode is disabled, defeating the intent of
the patch?

[ ... ]
> @@ -2667,7 +2672,7 @@ ice_set_link_ksettings(struct net_device *netdev,
>  	if (!bitmap_subset(copy_ks.link_modes.advertising,
>  			   safe_ks.link_modes.supported,
>  			   __ETHTOOL_LINK_MODE_MASK_NBITS)) {
> -		if (!test_bit(ICE_FLAG_LINK_LENIENT_MODE_ENA, pf->flags))
> +		if (!lenient_mode)
>  			netdev_info(netdev, "The selected speed is not supported by the current media. Please select a link speed that is supported by the current media.\n");
>  		err = -EOPNOTSUPP;
>  		goto done;

This isn't a bug introduced by this patch, but does taking this error path
accidentally release another thread's lock?

The ICE_CFG_BUSY flag is used as an ad-hoc lock later in this function:

	while (test_and_set_bit(ICE_CFG_BUSY, pf->state)) {
		timeout--;
		if (!timeout) {
			err = -EBUSY;
			goto done;
		}
		usleep_range(TEST_SET_BITS_SLEEP_MIN, TEST_SET_BITS_SLEEP_MAX);
	}

If the bitmap_subset() check fails, or if the while loop times out, it jumps to
the done label:

done:
	kfree(phy_caps);
	clear_bit(ICE_CFG_BUSY, pf->state);

Since the bitmap_subset() check happens before test_and_set_bit() has acquired
the lock, wouldn't this unconditionally clear the ICE_CFG_BUSY flag even if
another thread currently holds it? Could this synchronization be replaced with a
standard lock to avoid these issues?

