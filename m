Return-Path: <netdev+bounces-280997-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KEVFGh362kQNAAAu9opvQ
	(envelope-from <netdev+bounces-280997-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 16:00:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF8D45FE88
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE70F30022C3
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2233DA5BE;
	Fri, 24 Apr 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nsfc9I4A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9740F3DA5A2;
	Fri, 24 Apr 2026 14:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777039204; cv=none; b=aK436DzGKWVtm8Rd587Ekk9lTWM1lSODqy/BGYVTqF3/NVJHkso1drcBYbTrxHtUOsYtezZHkdV+kiWUaQUfjEsN9hm5kJcj0jKyuhUe7masU14rk8yKzvl93mpoUeyX/8H4QjuyQ/POvtECWwJAVThHwR67KbrvEago+cHKu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777039204; c=relaxed/simple;
	bh=RjPXRwAeTtKHltjAE51ItOPdDhf9jKLVKaPyYVF/kmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSSY3jr9DGCLPL5kZ+4fFO8Dz1NyKT5NAcuxRTcOh/L1hkTt+utEEJzkOMxpnp3h2tjoHE499/PaAdKyFPMjLAzMweh3elM3mqgblWl+oAXpaYFw5FtsMsBRrN/DzYmRGrwCM+V+2IZgRVyF3p4JMuogutJ/yQ711OPw9eJDHJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nsfc9I4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79FE5C19425;
	Fri, 24 Apr 2026 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777039204;
	bh=RjPXRwAeTtKHltjAE51ItOPdDhf9jKLVKaPyYVF/kmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nsfc9I4AdaKxHCRy2KFb+Y9+EwjnpX/Y3Yee7SewGiwoqUS87ru385v9QS+AC9Tlu
	 Ev3ri/Dr7iQBhFV+L87rM+SimKLIGXXiM6UYXxJXYsmB/Vp/QaHyqvL4mZkRFAkFxQ
	 9rCN98ZbQK56Q+a87wdUSZ1mrSU1olCyLjOmPqGFQt+KtgeG0fLKk/zyMepzkf/02g
	 QZnfzl65gmd34GvAzunuH8Yuc/JYGIcQSKSaAfFPrFgkUImH1kZjq0LkSeyj9r6J4P
	 P1CnBYb9FuNWtgSbosp6yrG30e0rB5gR6m5tPWIVQdMiLJ9kvAERwJuo140yk0GKsK
	 DMleeFOSEzqGw==
Date: Fri, 24 Apr 2026 14:59:58 +0100
From: Simon Horman <horms@kernel.org>
To: KhaiWenTan <khai.wen.tan@linux.intel.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com,
	khai.wen.tan@intel.com,
	Faizal Rahim <faizal.abdul.rahim@linux.intel.com>,
	Looi@web.codeaurora.org
Subject: Re: [PATCH iwl-next v3 3/3] igc: add support for forcing link speed
 without autonegotiation
Message-ID: <20260424135958.GL900403@horms.kernel.org>
References: <20260422155701.7420-1-khai.wen.tan@linux.intel.com>
 <20260422155701.7420-4-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422155701.7420-4-khai.wen.tan@linux.intel.com>
X-Rspamd-Queue-Id: DAF8D45FE88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_REJECT(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-280997-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:-];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,horms.kernel.org:mid]

On Wed, Apr 22, 2026 at 11:57:01PM +0800, KhaiWenTan wrote:
> From: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> 
> Allow users to force 10/100 Mb/s link speed and duplex via ethtool
> when autonegotiation is disabled. Previously, the driver rejected
> these requests with "Force mode currently not supported.".
> 
> Forcing at 1000 Mb/s and 2500 Mb/s is not supported.
> 
> Reviewed-by: Looi, Hong Aun <hong.aun.looi@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>

...

> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c

...

> @@ -2000,6 +2013,41 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>  	return 0;
>  }
>  
> +/**
> + * igc_handle_autoneg_disabled - Configure forced speed/duplex settings
> + * @adapter: private driver structure
> + * @speed: requested speed (must be SPEED_10 or SPEED_100)
> + * @duplex: requested duplex
> + *
> + * Records forced speed/duplex when autoneg is disabled.
> + * Caller must validate speed before calling this function.
> + */
> +static void igc_handle_autoneg_disabled(struct igc_adapter *adapter, u32 speed,
> +					u8 duplex)
> +{
> +	struct igc_mac_info *mac = &adapter->hw.mac;
> +
> +	switch (speed) {
> +	case SPEED_10:
> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
> +			IGC_FORCED_10F : IGC_FORCED_10H;
> +		break;
> +	case SPEED_100:
> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
> +			IGC_FORCED_100F : IGC_FORCED_100H;
> +		break;
> +	default:
> +		WARN_ONCE(1, "Unsupported speed %u\n", speed);
> +		return;
> +	}
> +
> +	mac->autoneg_enabled = false;
> +
> +	/* Half-duplex cannot support flow control per IEEE 802.3 */
> +	if (duplex != DUPLEX_FULL)
> +		adapter->hw.fc.requested_mode = igc_fc_none;
> +}
> +
>  /**
>   * igc_handle_autoneg_enabled - Configure autonegotiation advertisement
>   * @adapter: private driver structure
> @@ -2038,6 +2086,7 @@ static void igc_handle_autoneg_enabled(struct igc_adapter *adapter,
>  						  10baseT_Half))
>  		advertised |= ADVERTISE_10_HALF;
>  
> +	hw->mac.autoneg_enabled = true;
>  	hw->phy.autoneg_advertised = advertised;
>  	if (adapter->fc_autoneg)
>  		hw->fc.requested_mode = igc_fc_default;
> @@ -2071,14 +2120,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>  		}
>  	}
>  
> +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
> +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
> +		netdev_info(dev, "Unsupported speed for forced link\n");
> +		return -EINVAL;
> +	}

The condition above verifies speed only if autoneg is AUTONEG_DISABLE.

> +
>  	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>  		usleep_range(1000, 2000);
>  
> -	if (cmd->base.autoneg == AUTONEG_ENABLE) {
> +	if (cmd->base.autoneg == AUTONEG_ENABLE)
>  		igc_handle_autoneg_enabled(adapter, cmd);
> -	} else {
> -		netdev_info(dev, "Force mode currently not supported\n");
> -	}
> +	else
> +		igc_handle_autoneg_disabled(adapter, cmd->base.speed,
> +					    cmd->base.duplex);

But here igc_handle_autoneg_disabled, which relies on speed having been
verified, is called if autoneg is not AUTONEG_ENABLE.

If autoneg is AUTONEG_DISABLE here, then all is good.
But if it is neither AUTONEG_DISABLE nor AUTONEG_ENABLE then we
are in trouble.

I suggest verifying autoneg is either AUTONEG_ENABLE or AUTONEG_DISABLE
earlier in this function.

The above is based on my analysis of review AI generated review from Sashiko.
I believe that addressing autoneg verification address the review by
Sashiko that is relevant to the progress of this patch.

...

