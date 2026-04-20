Return-Path: <netdev+bounces-279854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCKIBstf5mkqvgEAu9opvQ
	(envelope-from <netdev+bounces-279854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:18:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA732430F18
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 19:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15630305D1EE
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4064632E151;
	Mon, 20 Apr 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwYpiejq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBF417A31C;
	Mon, 20 Apr 2026 15:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776699327; cv=none; b=sTdWr1AjxV35+ePQkd9K1V41wejuAbHt2t3NsoUoaY7AL55NqMARTCTMnbREBU9IY18gzFGLcuXGTXfuH7Y3b5VjsMnm17JGGeHN7RRrgays9xIf949aF6H0LcIdMCycy2HB+L0FJcoMMcOH1Bmq/kWqZ11l3A+M4X7KmIIciCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776699327; c=relaxed/simple;
	bh=IGDlVa4/d0HT3rb4xC7h1M2d+XyUMQQkRyNMsH9Y984=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uIW4eL+Hpx83l3HUfldh4C/L4cIoQ/WTCuicIqtacBozYCRRXIJV5yB2k4S+dRpv0vrm6SY0MHxTm+16QddfH0dZ2g425pWyURhqx3tHJ1wDYXRGI1w1g045R+L1CoRFeWAcyLlEf16jl/Y1l4RJFGF+IxxYYcBOLCDwCnnemN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwYpiejq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF54C2BCB4;
	Mon, 20 Apr 2026 15:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776699326;
	bh=IGDlVa4/d0HT3rb4xC7h1M2d+XyUMQQkRyNMsH9Y984=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KwYpiejqS9shzOnNgUMfR3fw6CPxszOp5vtWLAMWNP7WGEJRiI9ooz/L3XCqmKmFV
	 OHPbGvr5/3C0evuskGsuj1B3HnfhjNtLfQtnORK3/y9dSj1mvfovc90KbkFNZ4Y6R8
	 CjiPQANuKe50YJ0TaqZgSkvHWiP2HuOk4xWrpld3qMHpwe174zh3Ia/YSY3MzkL+G1
	 syTcSRc0MAytBXGwsDMoDp04FLN4wCTI+y9d4XBI20Q4VFk58/KIiQxYhzIQ7PjfED
	 wJWgWE1jJLGdp0BnsUsr8URNYL0JbAaKYyKHz6dRJnxiVSM2WHah4lufe9f7Qgn2fn
	 9XfahCH1sDWLA==
Date: Mon, 20 Apr 2026 16:35:20 +0100
From: Simon Horman <horms@kernel.org>
To: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
Cc: khai.wen.tan@linux.intel.com, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	faizal.abdul.rahim@intel.com, hong.aun.looi@intel.com,
	khai.wen.tan@intel.com
Subject: Re: [PATCH iwl-next v2 3/3] igc: add support for forcing link speed
 without autonegotiation
Message-ID: <20260420153520.GR280379@horms.kernel.org>
References: <20260416015520.6090-4-khai.wen.tan@linux.intel.com>
 <20260418164837.380985-2-horms@kernel.org>
 <3481ae84-5c36-4591-94c1-78b70fff4d7b@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3481ae84-5c36-4591-94c1-78b70fff4d7b@linux.intel.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279854-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AA732430F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:20:07AM +0800, Abdul Rahim, Faizal wrote:
> 
> 
> On 19/4/2026 12:48 am, Simon Horman wrote:
> > From: 'Simon Horman' <horms@kernel.org>
> > 
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://sashiko.dev
> > ---
> > igc: add support for forcing link speed without autonegotiation
> > 
> > This commit adds support to allow users to force 10/100 Mb/s link speed
> > and duplex via ethtool when autonegotiation is disabled.
> > 
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > > index cfcbf2fdad6ea..5bd37d1be1688 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > 
> > [ ... ]
> > 
> > > @@ -2000,6 +2013,41 @@ static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
> > >   	return 0;
> > >   }
> > > +/**
> > > + * igc_handle_autoneg_disabled - Configure forced speed/duplex settings
> > > + * @adapter: private driver structure
> > > + * @speed: requested speed (must be SPEED_10 or SPEED_100)
> > > + * @duplex: requested duplex
> > > + *
> > > + * Records forced speed/duplex when autoneg is disabled.
> > > + * Caller must validate speed before calling this function.
> > > + */
> > > +static void igc_handle_autoneg_disabled(struct igc_adapter *adapter, u32 speed,
> > > +					u8 duplex)
> > > +{
> > > +	struct igc_mac_info *mac = &adapter->hw.mac;
> > > +
> > > +	switch (speed) {
> > > +	case SPEED_10:
> > > +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
> > > +			IGC_FORCED_10F : IGC_FORCED_10H;
> > > +		break;
> > > +	case SPEED_100:
> > > +		mac->forced_speed_duplex = (duplex == DUPLEX_FULL) ?
> > > +			IGC_FORCED_100F : IGC_FORCED_100H;
> > > +		break;
> > > +	default:
> > > +		WARN_ONCE(1, "Unsupported speed %u\n", speed);
> > > +		return;
> > > +	}
> > > +
> > > +	mac->autoneg_enabled = false;
> > > +
> > > +	/* Half-duplex cannot support flow control per IEEE 802.3 */
> > > +	if (duplex == DUPLEX_HALF)
> > > +		adapter->hw.fc.requested_mode = igc_fc_none;
> > > +}
> > 
> > If userspace issues an ethtool command without specifying duplex, the duplex
> > value can be DUPLEX_UNKNOWN. In this case, forced_speed_duplex correctly
> > defaults to half-duplex since duplex == DUPLEX_FULL evaluates to false.
> > 
> > However, since DUPLEX_UNKNOWN is not equal to DUPLEX_HALF, the check above
> > fails, and the requested flow control mode remains unchanged. Could this leave
> > flow control enabled on a forced half-duplex link, violating IEEE 802.3?
> > Should this check be based on the resolved mac->forced_speed_duplex state
> > instead?
> > 
> 
> You're right, thanks for pointing that out.
> 
> That said, it feels simpler to address it with [1]:
> if (duplex != DUPLEX_FULL)
>     adapter->hw.fc.requested_mode = igc_fc_none;
> 
> Rather than [2]:
>  if (mac->forced_speed_duplex == IGC_FORCED_10H ||
>         mac->forced_speed_duplex == IGC_FORCED_100H)
>         adapter->hw.fc.requested_mode = igc_fc_none;
> 
> Are you okay with [1] ?

Yes, [1] sounds sensible to me.

> 
> > [ ... ]
> > 
> > > @@ -2071,14 +2120,20 @@ igc_ethtool_set_link_ksettings(struct net_device *netdev,
> > >   		}
> > >   	}
> > > +	if (cmd->base.autoneg == AUTONEG_DISABLE &&
> > > +	    cmd->base.speed != SPEED_10 && cmd->base.speed != SPEED_100) {
> > > +		netdev_info(dev, "Unsupported speed for forced link\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > >   	while (test_and_set_bit(__IGC_RESETTING, &adapter->state))
> > >   		usleep_range(1000, 2000);
> > 
> > This isn't a bug introduced by this patch, but does this ad-hoc
> > synchronization using bit flags circumvent proper locking guarantees? The
> > networking subsystem guidelines forbid using bit flags as ad-hoc locks.
> > 
> > Using a bit flag in a polling loop bypasses lockdep analysis, fairness, and
> > strict memory ordering. Could this be replaced with a real synchronization
> > mechanism like a mutex?
> 
> It looks like a worthwhile cleanup. However, it likely doesn’t belong in
> this series, since the synchronization pattern predates these patches and is
> used throughout the igc driver (set_ringparam, set_pauseparam, set_channels,
> etc.). We could address it in different patch series and align the other
> code paths at the same time ?

Yes, agreed.

