Return-Path: <netdev+bounces-305905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QcolKWOETmpqOQIAu9opvQ
	(envelope-from <netdev+bounces-305905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:09:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF89729083
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 19:09:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Xc/saRi2";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305905-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305905-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F3273034A00
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 17:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC4137C11C;
	Wed,  8 Jul 2026 17:02:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F692C11F1
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 17:02:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783530153; cv=none; b=d7y7037gJT34Ybhhd2hKr4clHNgq/8EPGZzyS+cNEbKdTYQK/XNPgiEr7lnygbCdMhLO97GaqWZLX0yNM/dFAJFTl2tDjcUIbYqQV2N9ltovEuOriNeN3vxuU2a5Rs1cSSolGAtTM21n545h1Ik327GAIfjYAhbfZsTW3N15iz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783530153; c=relaxed/simple;
	bh=rEq/w3Kq+1cAa93xllgErpyuVV8kd1rscyPbLTgQ8RU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKoyw2LoWP56ddJpyFIG6dCT+vQyF1rBHka2/TnQ7ATz6sIn3kPQW4dbvNLhEjuwc5dJOdgqYi+Hemi0xiupMJmR9Ujt0CMXt7S3qiQxMByRzJOzRDyuGM1UOzhv10wYicwelQ5OA2mgI+dzzAUvwrTaZ6b2pWeM4E/ePWY48og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xc/saRi2; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C52801F000E9;
	Wed,  8 Jul 2026 17:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783530149;
	bh=I8ZAtrbZQvwcCX1OkHecGbAQ5C3cMTcV0197m4NRpts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xc/saRi2ogyisimHWsI05bALVRlI54j4YfQwgShXOjA0LCZrHMNaoEjHXqvcJbyAx
	 eTX88XMUzmpgbGJ/7y24/Ybc1U7SnRJMkTlArsdKmHGotYCxbi5r8dxpQ1V2kE5AP0
	 RCz9e7g3s1cmtk5Esmq5uAZ8MsVi/mmwxGOJyjE+72bCi4d8as4voW9qVtJgiB8Iz9
	 SAglrf6NdLgPcum8FfaipPJDlCNeX9RKONn63Nie2Nv2h21HahIxC0lS9VXvavT0YY
	 24VZID+AqT0V1XkPyKIWKRZjlLz/pdEwGGxPLdtp/mhL93ayf3yIKME+/2owKRLsgU
	 HseWb2T5fmZjg==
From: Simon Horman <horms@kernel.org>
To: jedrzej.jagielski@intel.com
Cc: Simon Horman <horms@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 5/6] ixgbe: E610: add MAC address runtime refresh
Date: Wed,  8 Jul 2026 18:02:15 +0100
Message-ID: <20260708170223.1514429-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260702091553.57112-6-jedrzej.jagielski@intel.com>
References: <20260702091553.57112-6-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jedrzej.jagielski@intel.com,m:horms@kernel.org,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-305905-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EF89729083

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
ixgbe: E610: add MAC address runtime refresh

This change polls RAR0 each service-task cycle on E610 and updates
netdev->dev_addr, hw->mac.addr and mac_table[0].addr when firmware has
altered the MAC.  A refresh is also invoked from ixgbe_reset() so the
address survives RAR0 clearing during init_hw().

> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index df698ddd08be..eb05c2f982e8 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -6464,6 +6464,36 @@ void ixgbe_disable_tx(struct ixgbe_adapter *adapter)
>  	}
>  }
>
> +static void ixgbe_mac_addr_refresh(struct ixgbe_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	struct ixgbe_hw *hw = &adapter->hw;
> +	int err;
> +
> +	if (hw->mac.type != ixgbe_mac_e610)
> +		return;
> +
> +	/* fetch address stored currently in RAR0 in case the addr has been
> +	 * altered by FW; if so, use it as the default one
> +	 */
> +	err = hw->mac.ops.get_mac_addr(hw, hw->mac.addr);
> +	if (err) {
> +		e_dev_warn("Cannot get MAC address\n");
> +		return;
> +	}

[High]
Can this overwrite hw->mac.addr with transient/garbage RAR0 contents
before validation?  ixgbe_get_mac_addr_generic() unconditionally copies
the raw IXGBE_RAH(0)/IXGBE_RAL(0) values into the buffer passed by the
caller and always returns 0.  Here the caller passes hw->mac.addr
itself as the destination:

    err = hw->mac.ops.get_mac_addr(hw, hw->mac.addr);

so any transient RAR0 value (all zeros while firmware is rewriting the
register, garbage during the PCI slot-reset/resume window, a
multicast/zero pattern in flight) silently clobbers hw->mac.addr.

The is_valid_ether_addr() check below prevents publishing to netdev,
but it does not restore the previous hw->mac.addr.

Consider reading into a local u8 buf[ETH_ALEN], validating that, and
only then copying into hw->mac.addr.

Compounding that, ixgbe_get_mac_addr_generic()'s own comment states "A
reset of the adapter must be performed prior to calling this function
in order for the MAC address to have been loaded from the EEPROM into
RAR0", but in ixgbe_reset() the refresh runs before init_hw().  Can
this ordering yield a stale/invalid RAR0 read on the reset path?

The corruption is then observable: after the refresh returns,
ixgbe_reset() proceeds through init_hw() and ixgbe_mac_set_default_filter()
memcpy()s hw->mac.addr into mac_table[0].addr and programs it via
set_rar() — a corrupted hw->mac.addr can therefore end up written to
hardware.

> +
> +	if (ether_addr_equal(netdev->dev_addr, hw->mac.addr) ||
> +	    !is_valid_ether_addr(hw->mac.addr))
> +		return;
> +
> +	ASSERT_RTNL();
> +
> +	eth_hw_addr_set(netdev, hw->mac.addr);
> +	ether_addr_copy(adapter->mac_table[0].addr, hw->mac.addr);
> +
> +	call_netdevice_notifiers(NETDEV_CHANGEADDR, netdev);
> +}

[Medium]
Does this leave hw->mac.perm_addr, netdev->perm_addr and
netdev->addr_assign_type inconsistent with the newly published
address?  Every other MAC-handling site in ixgbe (probe,
ixgbe_reset_hw_e610, and the equivalent flows on 82598/82599/X540/X550)
writes RAR0 into hw->mac.perm_addr.  After firmware alters the MAC at
runtime, perm_addr will keep reporting the pre-change value, so
consumers such as ethtool -P, bonding and netlink perm-address
attributes will report the stale address while NET_ADDR_PERM is still
advertised for what is now effectively a runtime-assigned MAC.

[Medium]
This unconditionally treats RAR0 (owned by firmware/MGMT) as
authoritative and, on the next service-task tick, silently overwrites
any MAC previously configured via "ip link set dev X address ...":

    eth_hw_addr_set(netdev, hw->mac.addr);
    ether_addr_copy(adapter->mac_table[0].addr, hw->mac.addr);
    call_netdevice_notifiers(NETDEV_CHANGEADDR, netdev);

No log line, no arbitration with an admin-set address, no opt-out.
NETDEV_CHANGEADDR is also emitted from a polling context, which means
userspace (udev, NetworkManager, bridging, bonding) can receive
spontaneous address-change events on E610 with no correlating
administrative action.  Should the commit message describe this uAPI
behavior change ("ip link" no longer produces a persistent MAC on
E610), and should there be some form of arbitration or logging when
firmware overrides an admin-configured address?

> +
>  void ixgbe_reset(struct ixgbe_adapter *adapter)
>  {
>  	struct ixgbe_hw *hw = &adapter->hw;
> @@ -6481,6 +6511,8 @@ void ixgbe_reset(struct ixgbe_adapter *adapter)
>  			     IXGBE_FLAG2_SFP_NEEDS_RESET);
>  	adapter->flags &= ~IXGBE_FLAG_NEED_LINK_CONFIG;
>
> +	ixgbe_mac_addr_refresh(adapter);
> +

[High]
Is ixgbe_reset() always called with RTNL held?  ixgbe_mac_addr_refresh()
uses ASSERT_RTNL() and then dispatches eth_hw_addr_set() and
call_netdevice_notifiers(NETDEV_CHANGEADDR, netdev), both of which
require RTNL.

The follow-up commit "ixgbe: take rtnl lock before ixgbe_reset() is
called" only converts the ixgbe_resume() path.  The PCI error-recovery
callback ixgbe_io_slot_reset() still calls ixgbe_reset() without
acquiring rtnl_lock(), and .slot_reset callbacks are not guaranteed to
run under RTNL.

On that path, if RAR0 differs from netdev->dev_addr on an E610,
ASSERT_RTNL() will WARN and the subsequent netdev address publication
and notifier-chain traversal race with concurrent RTNL-protected
users (SIOCSIFHWADDR, notifier chain (un)registration, etc).  Should
ixgbe_io_slot_reset() also take rtnl_lock() around ixgbe_reset(), or
should the refresh be moved to a caller-side location that guarantees
RTNL?

>  	err = hw->mac.ops.init_hw(hw);
>  	switch (err) {
>  	case 0:
> @@ -8651,6 +8683,11 @@ static void ixgbe_service_task(struct work_struct *work)
>  			ixgbe_handle_fw_event(adapter);
>  		ixgbe_check_media_subtask(adapter);
>  	}
> +
> +	rtnl_lock();
> +	ixgbe_mac_addr_refresh(adapter);
> +	rtnl_unlock();
> +

[Medium]
Would it make sense to hoist the E610 gating out of
ixgbe_mac_addr_refresh() and skip the rtnl_lock()/rtnl_unlock()
entirely for non-E610 devices?

The type check lives inside the helper:

    static void ixgbe_mac_addr_refresh(struct ixgbe_adapter *adapter)
    {
        ...
        if (hw->mac.type != ixgbe_mac_e610)
            return;
        ...
    }

so 82598, 82599, X540 and X550 adapters (which comprise most of the
ixgbe device family) acquire the global rtnl_mutex every service-task
cycle only to return immediately.  Something like:

    if (adapter->hw.mac.type == ixgbe_mac_e610) {
        rtnl_lock();
        ixgbe_mac_addr_refresh(adapter);
        rtnl_unlock();
    }

would avoid the rtnl_mutex contention on non-E610 hardware.

>  	ixgbe_reset_subtask(adapter);
>  	ixgbe_phy_interrupt_subtask(adapter);
>  	ixgbe_sfp_detection_subtask(adapter);

