Return-Path: <netdev+bounces-285743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPRDFfC0/WkXhwAAu9opvQ
	(envelope-from <netdev+bounces-285743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:03:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F3C4F4B27
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 12:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE323305727A
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3468A374E7F;
	Fri,  8 May 2026 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdWPPXrL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B45C3890E5
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 09:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234225; cv=none; b=GTBlUry8ZubOW0uqKkbBdlu8mZxKEIxbIr/YFn9d4IITh8XyZqwxCH1NV14jfo3ArttgiypO3tZoaUi3OSnTH1z08Xs6ujkG5oqDP7Z0KQJW5l/4Pzds4NubDLg2jIlyoo01YclqWgyXq1QHKeZg5tM1DfHbUP/k16uUUd6pqEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234225; c=relaxed/simple;
	bh=+NwiAjp9LkJwoEi3vGKUBZNVBjuSw+dVpFIiee9Ye9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YI8Tb5MCZKm9mXuynRw0Uwn2e/s/pfa8OqYqhUArTUCF9T70dTlSnViOl3H4ZFS3CCNPo3GeDa3lVDutEhUQ3LZizp7vLhECWdnA2nqWZug5aF3225V4LR9iJjPMSuGKwCT+hujxGcZhhmajmiHuG/Bu/S5dWw6M1ULVYV34Wug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdWPPXrL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22CEC2BCB0;
	Fri,  8 May 2026 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778234224;
	bh=+NwiAjp9LkJwoEi3vGKUBZNVBjuSw+dVpFIiee9Ye9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdWPPXrL7pED8iv6835crYgOH6/eyXoe07Tf6JwRZ28D2ddwZu7UNIqV1PGrOwQEv
	 sDc9PKi0mbl8QinlsmIDvy6OF7QRNBsJbUu2vQqCuuSFucKCK4d57Cfc/BU83kMJ3P
	 pCgbiOHejrdtevNMIt1byNhGCmvBmBFjObIWOVl14jq2o/MZgRjQfhHIh/pRHWyPmY
	 byJVgjZ1RVF0hJwEadxPlIhPr3QG+/Pe1VbYE2VIjIqeDTf2BvkazysNqZ6I+/tfLk
	 wnlPdVNTNwKecaFB0zL7jDQlxdNX7auz9lwjJgK3vGOsJ6qpAmQeY6v43Jmo7OF4K9
	 p7bvYpn+GEDUA==
Date: Fri, 8 May 2026 10:56:59 +0100
From: Simon Horman <horms@kernel.org>
To: Felix Moessbauer <felix.moessbauer@siemens.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Yan, Zheng" <zheng.z.yan@intel.com>, netdev@vger.kernel.org,
	vivek.behera@siemens.com,
	"Ertman, David M" <david.m.ertman@intel.com>,
	Sasha Neftin <sasha.neftin@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH net 1/1] igb: Return state in pm_runtime_idle instead of
 power-down
Message-ID: <20260508095659.GM15617@horms.kernel.org>
References: <20260505101141.2657169-1-felix.moessbauer@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505101141.2657169-1-felix.moessbauer@siemens.com>
X-Rspamd-Queue-Id: A0F3C4F4B27
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285743-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.osuosl.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,siemens.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,siemens.com:email,horms.kernel.org:mid]
X-Rspamd-Action: no action

+ David Ertman, Sasha Neftin, Heiner Kallweit

On Tue, May 05, 2026 at 12:11:34PM +0200, Felix Moessbauer wrote:
> The PM runtime_idle API expects to get an indication if the device can
> be powered down. Instead of returning the appropriate state, we
> currently directly power down the device (if not active) and return
> that the device is busy.
> 
> We change this by making the function side-effect free and just return
> the state.
> 
> Fixes: 749ab2cd12704 ("igb: add basic runtime PM support")
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ce91dda00ec0e..e8ab0b506a104 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -9652,7 +9652,7 @@ static int igb_runtime_idle(struct device *dev)
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  
>  	if (!igb_has_link(adapter))
> -		pm_schedule_suspend(dev, MSEC_PER_SEC * 5);
> +		return 0;
>  
>  	return -EBUSY;
>  }

Hi Felix,

I am not sure this is the right approach, are you seeing a behavioural
problem?


This pattern seems to also be present in at least e1000e, igc and r8169.

The igb and e1000e implementations seem to have co-evolved [1][2],
possibly in conjunction with OOT versions of each driver.
The igc implementation came later, perhaps copying e1000e or igb [3].

The git log for r8169 seems to provide a justification for why that
driver users this approach [4].

    - Let the idle notification check whether we can suspend and let it
      schedule the suspend. This way we don't need to have calls to
      pm_schedule_suspend in different places.

While the current e1000e implementation seems to address some reliability
issues [1], although it's not entirely clear to me how that relates to the
issue at hand.

    Fix issues with:
    RuntimePM causing the device to repeatedly flip between suspend and resume
    with the interface administratively downed.
    Having RuntimePM enabled interfering with the functionality of Energy
    Efficient Ethernet.

    Added checks to disallow functions that should not be executed if the
    device is currently runtime suspended

    Make runtime_idle callback to use same deterministic behavior as the igb
    driver.

[1] 63eb48f151b5 ("e1000e Refactor of Runtime Power Management")
    Fri Feb 14 07:16:46 2014 +0000
[2] 749ab2cd1270 ("igb: add basic runtime PM support")
    Wed Jan 4 20:23:37 2012 +0000
[3] 9513d2a5dc7f ("igc: Add legacy power management support")
    Thu Nov 14 09:54:46 2019 +020
[4] a92a08499b1f ("r8169: improve runtime pm in general and suspend unused ports")
    Mon Jan 8 21:39:13 2018 +0100

