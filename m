Return-Path: <netdev+bounces-285230-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gALwLT5q/Gn0PgAAu9opvQ
	(envelope-from <netdev+bounces-285230-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:32:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 574274E6CF0
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 12:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CF2E300C0EA
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 10:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB5E3DA5BE;
	Thu,  7 May 2026 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/1dKtL6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1F062809;
	Thu,  7 May 2026 10:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778149946; cv=none; b=YwYKN2x0soMXIobgrWVM0THfrWDJU5mBqb/C7whdWJLfBnGNi21+xc8IgmSHvr2VNQ2f/zf2eotjn5EviDEGGkcwvBNorIKPqyMDaaxZTLEKuSIy9whm0h97OE6XTFkF8JTG+1Wz9vAtosfeo9ZsBFv7xIJpBCCNsdEexqdlF/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778149946; c=relaxed/simple;
	bh=in0biBZ5KRChoMmc9KgpTQGWMkI7BtYNg69sNv8gMbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+qM8JAmC8jbEpIQ2023WZalgF9rR/Z8/6avsKUJs7x3UInSqk+0tY+rkcsBY484cSidKYA+OdzVbFrVktS7WYr7yJQL8H1T0nzcMEHF5H1lRvN8ZxLduo5rfhQ+/n3m2Ax3hmVNCRv0mWk3/sPyBrfDosTmGBIsGkX5Emxs0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/1dKtL6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57C8C2BCB2;
	Thu,  7 May 2026 10:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778149946;
	bh=in0biBZ5KRChoMmc9KgpTQGWMkI7BtYNg69sNv8gMbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/1dKtL6ySpO2w2Lvwj17bD1ZI8PA1dnyseT03SJBkRPtKo/mrJY1kRM4HcJiO03V
	 wjjfiquumMnB2b3CC+aOCIXRSyHayGreDdpKcj1kjIYzfZPqqRyKl6nW4VBi3Yoss5
	 h063FuRFRDHVsfHhYTp8j5u8qwf+7FvOfYAyXlLrrLbPNKCIq9oDn1dGgnEndd2qKn
	 rhohUhUZ/G3zWvy+jn4Ac0izYHMXJ5/4VP2uUfJu8al9Lunc0mmxL4P/gYo9ZH80LU
	 d0Amo3Beeg57poW1W8S/zo3m1JnHeLC1zNKv0SPltuxX7biTckHAmyAkrKyEtdc/3B
	 wD+V+0XcpFa7A==
Date: Thu, 7 May 2026 11:32:21 +0100
From: Simon Horman <horms@kernel.org>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: khai.wen.tan@linux.intel.com, anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, faizal.abdul.rahim@intel.com,
	hong.aun.looi@intel.com, khai.wen.tan@intel.com
Subject: Re: [PATCH iwl-next v4 3/3] igc: add support for forcing link speed
 without autonegotiation
Message-ID: <20260507103221.GJ15617@horms.kernel.org>
References: <20260428060009.311393-4-khai.wen.tan@linux.intel.com>
 <20260430135057.1653330-1-horms@kernel.org>
 <16b18088-8fe3-4a38-9eb9-d39842e6b94f@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b18088-8fe3-4a38-9eb9-d39842e6b94f@linux.intel.com>
X-Rspamd-Queue-Id: 574274E6CF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285230-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid]
X-Rspamd-Action: no action

On Wed, May 06, 2026 at 02:25:23PM +0800, Abdul Rahim, Faizal wrote:
> 
> 
> On 30/4/2026 9:50 pm, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > igc: add support for forcing link speed without autonegotiation
> > 
> > This commit allows users to force 10/100 Mb/s link speed and duplex via
> > ethtool when autonegotiation is disabled. Previously, the driver rejected
> > these requests.
> > 
> >> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> >> index cfcbf2fdad6e..9997ebbdf778 100644
> >> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> >> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > [ ... ]
> >> @@ -2000,6 +2013,41 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
> >>  	return 0;
> >>  }
> >>  
> >> +/**
> >> + * igc_handle_autoneg_disabled - Configure forced speed/duplex settings
> >> + * @adapter: private driver structure
> >> + * @speed: requested speed (must be SPEED_10 or SPEED_100)
> >> + * @duplex: requested duplex
> >> + *
> >> + * Records forced speed/duplex when autoneg is disabled.
> >> + * Caller must validate speed before calling this function.
> >> + */
> >> +static void igc_handle_autoneg_disabled(struct igc_adapter *adapter, u32 speed,
> >> +					u8 duplex)
> >> +{
> >> +	struct igc_mac_info *mac = &adapter->hw.mac;
> >> +
> >> +	switch (speed) {
> >> +	case SPEED_10:
> >> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
> >> +			IGC_FORCED_10F : IGC_FORCED_10H;
> >> +		break;
> >> +	case SPEED_100:
> >> +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
> >> +			IGC_FORCED_100F : IGC_FORCED_100H;
> >> +		break;
> >> +	default:
> >> +		WARN_ONCE(1, "Unsupported speed %u\n", speed);
> >> +		return;
> >> +	}
> >> +
> >> +	mac->autoneg_enabled = false;
> >> +
> >> +	/* Half-duplex cannot support flow control per IEEE 802.3 */
> >> +	if (duplex != DUPLEX_FULL)
> >> +		adapter->hw.fc.requested_mode = igc_fc_none;
> > 
> > Does this permanently overwrite the user's flow control preference?
> > 
> > If half-duplex is requested, requested_mode is set to igc_fc_none. Because
> > requested_mode represents the persistent state for the user's flow control
> > preference, the user might permanently lose their configuration. If they later
> > switch back to full-duplex, requested_mode remains igc_fc_none, and flow
> > control stays disabled.
> > 
> > Would it be better to dynamically override hw->fc.current_mode to
> > igc_fc_none during link configuration instead of mutating requested_mode?
> > 
> 
> Yes you're right, thanks, will update.
> 
> >> +}
> > [ ... ]
> >> @@ -2071,14 +2126,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
> >>  		}
> >>  	}
> >>  
> >> +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
> >> +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
> >> +		netdev_info(dev, "Unsupported speed for forced link\n");
> >> +		return -EINVAL;
> >> +	}
> >> +
> > 
> > Should we also validate cmd->base.duplex here to prevent a fallback to
> > half-duplex?
> > 
> > If a user runs a command like "ethtool -s eth0 speed 100 autoneg off" while
> > the link is down, ethtool queries and preserves the current duplex value,
> > which is DUPLEX_UNKNOWN (0xff).
> > 
> > In igc_handle_autoneg_disabled(), the code checks if duplex == DUPLEX_FULL,
> > which evaluates to false, and forces the interface to 100 Mbps half-duplex.
> > 
> > Could we explicitly check that cmd->base.duplex is either DUPLEX_HALF or
> > DUPLEX_FULL and return -EINVAL otherwise?
> 
> Will update.
> 
> > 
> >>  	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
> >>  		usleep_range(1000, 2000);
> > 
> > This isn't a bug introduced by this patch, but does this ad-hoc
> > synchronization loop reimplement locking without fairness or lockdep support?
> > 
> > According to the Networking Subsystem Guidelines, using bit operations as a
> > substitute for real locks violates core kernel locking rules and introduces
> > potential races.
> > 
> > Could this be replaced with a proper concurrency mechanism such as a mutex?
> > 
> 
> Hi Simon, you've raised this issue in v2, and after discussion, you've
> agreed that this change doesn't belong in this patch series.
> 
> Not sure if I missed anything?

Sorry, my bad. I missed that we'd already covered this one.

