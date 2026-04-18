Return-Path: <netdev+bounces-279525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIrVLLe242mVKAEAu9opvQ
	(envelope-from <netdev+bounces-279525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:52:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AB8421B22
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 18:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC83830131E5
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 16:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6DC30BF69;
	Sat, 18 Apr 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKzdxscK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F3A282F30;
	Sat, 18 Apr 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776531124; cv=none; b=tICtZv/Z379VA24uekwfEaP0FU/YlIzKJimmNjq3tAZ7HDvsoMzympib6nIvXlAgKpOCbQAlu0j9RrRDMmpIoDABSy4TyCS/1i7dyP3O4QYbgbuJhCiV0BhAmptHATJr+KfTZjQa1skm5qXNyHNUEgCElOut9D+k78TXIThzm3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776531124; c=relaxed/simple;
	bh=XMTZj1YxPkY22L6vssswSQjk4oTxVG3RPZgGbSOfif8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teJToStFOHRKNTVDs98M9V3nK7RuzxHK32kQapbneVSqTY9G8apJnj2s3Ji5sBAMBqWh5p9ik6MME2MPi1M6uENhf4yL/A5lP7nt5uZ8v7U4dwCCJCJR6JgLCCjYEZF9IF3yXs0AVZpqNGA68akefKbPf6Vf7mCNLQSQ0rSX55I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKzdxscK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB15C19424;
	Sat, 18 Apr 2026 16:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776531124;
	bh=XMTZj1YxPkY22L6vssswSQjk4oTxVG3RPZgGbSOfif8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rKzdxscKKp1giWSsuSCO3jKQUC4b8sL/u/GsH00AIPnDBiOFJoqb+6gaZ64Cr6ODv
	 K4N1QExtkRpDDRwGOlvYHPsn+kQOOUeOFYwtQza7gw7DCyUCcQQltn08GGsU8FNvX9
	 XFH4j7PYOg+Mg4sCJDgKFHcgbadra4WCrK94J4fAkuf8JCj0ow8UCP1ehX1OCtAgT/
	 dSf1NBAr93ssqP8u0Z7P8dOZ1mFG3FAivCr/GSgm2zRV8CJE4MpIsnM1ATPPng9N68
	 xtinbU1VIwcPW6/o2Jqq708tUrlauGyQ7aipfDdgZ4LnQrCcJG7lco/Bhk63vOq04c
	 TZ5P6Z7j6yNsg==
From: Simon Horman <horms@kernel.org>
To: khai.wen.tan@linux.intel.com
Cc: 'Simon Horman' <horms@kernel.org>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
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
Subject: Re: [PATCH iwl-next v2 3/3] igc: add support for forcing link speed without autonegotiation
Date: Sat, 18 Apr 2026 17:48:38 +0100
Message-ID: <20260418164837.380985-2-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416015520.6090-4-khai.wen.tan@linux.intel.com>
References: <20260416015520.6090-4-khai.wen.tan@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-279525-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 14AB8421B22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
igc: add support for forcing link speed without autonegotiation

This commit adds support to allow users to force 10/100 Mb/s link speed
and duplex via ethtool when autonegotiation is disabled.

> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index cfcbf2fdad6ea..5bd37d1be1688 100644
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
> +	if (duplex == DUPLEX_HALF)
> +		adapter->hw.fc.requested_mode = igc_fc_none;
> +}

If userspace issues an ethtool command without specifying duplex, the duplex
value can be DUPLEX_UNKNOWN. In this case, forced_speed_duplex correctly
defaults to half-duplex since duplex == DUPLEX_FULL evaluates to false. 

However, since DUPLEX_UNKNOWN is not equal to DUPLEX_HALF, the check above
fails, and the requested flow control mode remains unchanged. Could this leave
flow control enabled on a forced half-duplex link, violating IEEE 802.3?
Should this check be based on the resolved mac->forced_speed_duplex state
instead?

[ ... ]

> @@ -2071,14 +2120,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
>  		}
>  	}
>  
> +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
> +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
> +		netdev_info(dev, "Unsupported speed for forced link\n");
> +		return -EINVAL;
> +	}
> +
>  	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
>  		usleep_range(1000, 2000);

This isn't a bug introduced by this patch, but does this ad-hoc
synchronization using bit flags circumvent proper locking guarantees? The
networking subsystem guidelines forbid using bit flags as ad-hoc locks. 

Using a bit flag in a polling loop bypasses lockdep analysis, fairness, and
strict memory ordering. Could this be replaced with a real synchronization
mechanism like a mutex?

