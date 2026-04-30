Return-Path: <netdev+bounces-282872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sICqLmRe82lT1wEAu9opvQ
	(envelope-from <netdev+bounces-282872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:51:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 372BD4A3AC4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D2A1301AAA7
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 13:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85972580D7;
	Thu, 30 Apr 2026 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abCfbkoz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A549F35958;
	Thu, 30 Apr 2026 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557086; cv=none; b=CenrEIt5CU1OBATXayEMfjy8aCx/onmRuLxicJ+UgcR+4OTcU3ytl4stNSwjUxMNxV3FWG1yzWBvOp9fnxviynzqmxVm0vTpA5MA56WmtIBm1OwB69WgukFrfos9+/B+Y7ReH49bvqawAd+F5x45d/SGi9ln3KsNwLXGgmbY0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557086; c=relaxed/simple;
	bh=sGKecohrPFm0s7IoeAxyxJmKcE8tQ35JCJLbT5iR9m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxptVzgDq0W7auao0v00tH1JDtjUh/d5+PfDNY0z137ZHgxsjDnKVlN8Fyp05lB71nSzL1D0mR/YCAsK8CMaXPm25jX3RQflpxpJtVU+XEoom0Ri84GSlHnWbSzchpKpZ7vYAJZIHBfZAtc21F7v/EYDnZGLlhefaYPzHXfaDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abCfbkoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC959C2BCB3;
	Thu, 30 Apr 2026 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777557085;
	bh=sGKecohrPFm0s7IoeAxyxJmKcE8tQ35JCJLbT5iR9m8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=abCfbkozqqeclATf5iyy8Ha/AMdrHQ3m0RD8bvbJIyrPqg+uVcr4sO2JtNVvAcXQ2
	 FPitsgA0/L+mbeCgryRresXrbPEC1qRrBGA/ldr5+8LT7j0nr9WYTD4O6e93rsn4Ia
	 gTi5g0IXuljAIKwHuhwKn7Sw+Wp2pBdb44W6JpA7p4C/V3aeW0baSLoK9qFj4pMi0k
	 YGTgV7UpUCNw/N31Nd8XjyFY9llWLwEHHSaijxwH+Fe4ft/j/3iRRdvFet4qqm5QK/
	 AR8x/a1MXEQ4hVkqCAwy00DypdxgIsE6AYT5mn60s5UUfs7yCwUfUqp/TUCucbI/DZ
	 T/Wep7zefQqvQ==
From: Simon Horman <horms@kernel.org>
To: khai.wen.tan@linux.intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com,
	khai.wen.tan@intel.com,
	faizal.abdul.rahim@linux.intel.com
Subject: Re: [PATCH iwl-next v4 3/3] igc: add support for forcing link speed without autonegotiation
Date: Thu, 30 Apr 2026 14:50:57 +0100
Message-ID: <20260430135057.1653330-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428060009.311393-4-khai.wen.tan@linux.intel.com>
References: <20260428060009.311393-4-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 372BD4A3AC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-282872-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url]

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
igc: add support for forcing link speed without autonegotiation

This commit allows users to force 10/100 Mb/s link speed and duplex via
ethtool when autonegotiation is disabled. Previously, the driver rejected
these requests.

> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index cfcbf2fdad6e..9997ebbdf778 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
[ ... ]
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

Does this permanently overwrite the user's flow control preference?

If half-duplex is requested, requested_mode is set to igc_fc_none. Because
requested_mode represents the persistent state for the user's flow control
preference, the user might permanently lose their configuration. If they later
switch back to full-duplex, requested_mode remains igc_fc_none, and flow
control stays disabled.

Would it be better to dynamically override hw->fc.current_mode to
igc_fc_none during link configuration instead of mutating requested_mode?

> +}
[ ... ]
> @@ -2071,14 +2126,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>  		}
>  	}
>  
> +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
> +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
> +		netdev_info(dev, "Unsupported speed for forced link\n");
> +		return -EINVAL;
> +	}
> +

Should we also validate cmd->base.duplex here to prevent a fallback to
half-duplex?

If a user runs a command like "ethtool -s eth0 speed 100 autoneg off" while
the link is down, ethtool queries and preserves the current duplex value,
which is DUPLEX_UNKNOWN (0xff).

In igc_handle_autoneg_disabled(), the code checks if duplex == DUPLEX_FULL,
which evaluates to false, and forces the interface to 100 Mbps half-duplex.

Could we explicitly check that cmd->base.duplex is either DUPLEX_HALF or
DUPLEX_FULL and return -EINVAL otherwise?

>  	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>  		usleep_range(1000, 2000);

This isn't a bug introduced by this patch, but does this ad-hoc
synchronization loop reimplement locking without fairness or lockdep support?

According to the Networking Subsystem Guidelines, using bit operations as a
substitute for real locks violates core kernel locking rules and introduces
potential races.

Could this be replaced with a proper concurrency mechanism such as a mutex?

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
>  
>  	/* MDI-X => 2; MDI => 1; Auto => 3 */
>  	if (cmd->base.eth_tp_mdix_ctrl) {

