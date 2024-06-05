Return-Path: <netdev+bounces-101107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C028FD5F3
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 20:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580BD1F2224E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 18:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B5413A897;
	Wed,  5 Jun 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrwDWjO4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B1C22301
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613056; cv=none; b=ccPH5OwvqDSqhCuTFp3bOA10FNTdilr+hnslTmHjGUFsNfYmRryt1bk1JFUyc/mPPTMuG+f+heqzZPVVcYXe9RYrmCM3aE6vC6Zok9AlGdyCvjByFH3DOeUIEYc1jDQT7bLhXvEDm8BhB0N+d4vCUcDmCBd5vUdYvo9df2WqgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613056; c=relaxed/simple;
	bh=LSftnEmOh5tQ6irLLvFHd23HqbUnT1y92OexGT+bhI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDZmSLT7fh06B1/Wi+2oz5a4L9Y2xUNAsfIcYWoxty/mTqVeja9jXoLZr1nVZRoQuR+WCtt5Ec07jE+RoU4y1MT3zs9NWtGE7FVYArf+jEfWoMyHRDFhN2ttxHxTtX4vZ8j5hs0EFUtIeF6kq0Enpmbq8/gbBsEQQsr8O/33Gvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrwDWjO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491F1C32781;
	Wed,  5 Jun 2024 18:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717613055;
	bh=LSftnEmOh5tQ6irLLvFHd23HqbUnT1y92OexGT+bhI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MrwDWjO4hmM5M4r2XqWHMglG1O8yZm1X/uRr+L/66yyV9t7pAK1EgYMiAjp91nE3o
	 C4UJNypvo+K/JtpmuMkXkDtlSgws8NUlB5xHHWGNovMBNzl+dbLrJVU1RctX58Q4xy
	 S6/zslYxEgBBCcP2e7N0D62XQH3JVaHd7xv0/4Tz2HUchJ07o2ZRxFOGZj8dd0mP8W
	 L2RGatV8/7xBe9Hxg5bwmRcK0W3OSVa/7qZ1X/dPm9YqPBQC2mm9tBR1gmYV0d9fvC
	 hoHvhyHiJAyAz/3S6smlGYLPiomX/W+gXUy6sg4XUtRkZwJ99CdUs9WrbifH22ZFJX
	 MymgXSDgaQrWA==
Date: Wed, 5 Jun 2024 19:44:12 +0100
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com
Subject: Re: [PATCH net-next v4 4/6] net: libwx: Add msg task func
Message-ID: <20240605184412.GS791188@kernel.org>
References: <20240604155850.51983-1-mengyuanlou@net-swift.com>
 <3EC6B1729E82C1C5+20240604155850.51983-5-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EC6B1729E82C1C5+20240604155850.51983-5-mengyuanlou@net-swift.com>

On Tue, Jun 04, 2024 at 11:57:33PM +0800, Mengyuan Lou wrote:
> Implement wx_msg_task which is used to process mailbox
> messages sent by vf.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Hi Mengyuan Lou,

Some minor comments from my side.

...

> +static int wx_set_vf_mac_addr(struct wx *wx, u32 *msgbuf, u16 vf)
> +{
> +	u8 *new_mac = ((u8 *)(&msgbuf[1]));
> +
> +	if (!is_valid_ether_addr(new_mac)) {
> +		wx_err(wx, "VF %d attempted to set invalid mac\n", vf);
> +		return -EINVAL;
> +	}
> +
> +	if (wx->vfinfo[vf].pf_set_mac &&
> +	    memcmp(wx->vfinfo[vf].vf_mac_addr, new_mac, ETH_ALEN)) {
> +		wx_err(wx,
> +		       "VF %d attempted to set a MAC address but it already had a MAC address.",
> +		       vf);
> +		return -EBUSY;
> +	}
> +	return wx_set_vf_mac(wx, vf, new_mac) < 0;

This seems to return a bool - true on error, false otherwise.
But I think it would be more natural to consistently return
a negative error value on error - as is done above, and 0 on success.

So perhaps something like this (completely untested!):

	err = wx_set_vf_mac(wx, vf, index, new_mac);
	if (err)
		return err;

	return 0;

> +}

...

> +static int wx_set_vf_lpe(struct wx *wx, u32 max_frame, u32 vf)
> +{
> +	struct net_device *netdev = wx->netdev;
> +	u32 index, vf_bit, vfre;
> +	u32 max_frs, reg_val;
> +	int pf_max_frame;
> +	int err = 0;
> +
> +	pf_max_frame = netdev->mtu + ETH_HLEN +  ETH_FCS_LEN + VLAN_HLEN;
> +	switch (wx->vfinfo[vf].vf_api) {
> +	case wx_mbox_api_11 ... wx_mbox_api_13:
> +		/* Version 1.1 supports jumbo frames on VFs if PF has
> +		 * jumbo frames enabled which means legacy VFs are
> +		 * disabled
> +		 */
> +		if (pf_max_frame > ETH_FRAME_LEN)
> +			break;
> +		fallthrough;
> +	default:
> +		/* If the PF or VF are running w/ jumbo frames enabled
> +		 * we need to shut down the VF Rx path as we cannot
> +		 * support jumbo frames on legacy VFs
> +		 */
> +		if (pf_max_frame > ETH_FRAME_LEN ||
> +		    (max_frame > (ETH_FRAME_LEN + ETH_FCS_LEN + VLAN_HLEN)))
> +			err = -EINVAL;
> +		break;
> +	}
> +
> +	/* determine VF receive enable location */
> +	vf_bit = vf % 32;
> +	index = vf / 32;
> +
> +	/* enable or disable receive depending on error */
> +	vfre = rd32(wx, WX_RDM_VF_RE(index));
> +	if (err)
> +		vfre &= ~BIT(vf_bit);
> +	else
> +		vfre |= BIT(vf_bit);
> +	wr32(wx, WX_RDM_VF_RE(index), vfre);
> +
> +	if (err) {
> +		wx_err(wx, "VF max_frame %d out of range\n", max_frame);
> +		return err;
> +	}
> +	/* pull current max frame size from hardware */
> +	max_frs = DIV_ROUND_UP(max_frame, 1024);
> +	reg_val = rd32(wx, WX_MAC_WDG_TIMEOUT) & WX_MAC_WDG_TIMEOUT_WTO_MASK;
> +	if (max_frs > (reg_val + WX_MAC_WDG_TIMEOUT_WTO_DELTA))
> +		wr32(wx, WX_MAC_WDG_TIMEOUT, max_frs - WX_MAC_WDG_TIMEOUT_WTO_DELTA);

nit: This could trivially be line wrapped to <= 80 columns wide

		wr32(wx, WX_MAC_WDG_TIMEOUT,
		     max_frs - WX_MAC_WDG_TIMEOUT_WTO_DELTA);

     Flagged by checkpatch.pl --max-line-length=80

> +
> +	return 0;
> +}

...

> +static int wx_set_vf_macvlan_msg(struct wx *wx, u32 *msgbuf, u16 vf)
> +{
> +	int index = (msgbuf[0] & WX_VT_MSGINFO_MASK) >>
> +		    WX_VT_MSGINFO_SHIFT;
> +	u8 *new_mac = ((u8 *)(&msgbuf[1]));
> +	int err;
> +
> +	if (wx->vfinfo[vf].pf_set_mac && index > 0) {
> +		wx_err(wx, "VF %d requested MACVLAN filter but is administratively denied\n", vf);
> +		return -EINVAL;
> +	}
> +
> +	/* An non-zero index indicates the VF is setting a filter */
> +	if (index) {
> +		if (!is_valid_ether_addr(new_mac)) {
> +			wx_err(wx, "VF %d attempted to set invalid mac\n", vf);
> +			return -EINVAL;
> +		}
> +		/* If the VF is allowed to set MAC filters then turn off
> +		 * anti-spoofing to avoid false positives.
> +		 */
> +		if (wx->vfinfo[vf].spoofchk_enabled)
> +			wx_set_vf_spoofchk(wx->netdev, vf, false);
> +	}
> +
> +	err = wx_set_vf_macvlan(wx, vf, index, new_mac);
> +	if (err == -ENOSPC)
> +		wx_err(wx,
> +		       "VF %d has requested a MACVLAN filter but there is no space for it\n",
> +		       vf);
> +
> +	return err < 0;

As per my comment on wx_set_vf_mac_addr(),
this return scheme seems a little unorthodox.

I'd suggest something like this (completely untested!):

	err = wx_set_vf_macvlan(wx, vf, index, new_mac);
	if (err == -ENOSPC)
		wx_err(...)
	if (err)
		return err;

	return 0;

> +}

...

> +static int wx_update_vf_xcast_mode(struct wx *wx, u32 *msgbuf, u32 vf)
> +{
> +	int xcast_mode = msgbuf[1];
> +	u32 vmolr, disable, enable;
> +
> +	/* verify the PF is supporting the correct APIs */
> +	switch (wx->vfinfo[vf].vf_api) {
> +	case wx_mbox_api_12:
> +		/* promisc introduced in 1.3 version */
> +		if (xcast_mode == WXVF_XCAST_MODE_PROMISC)
> +			return -EOPNOTSUPP;
> +		fallthrough;
> +	case wx_mbox_api_13:
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +	if (wx->vfinfo[vf].xcast_mode == xcast_mode)
> +		goto out;
> +
> +	switch (xcast_mode) {
> +	case WXVF_XCAST_MODE_NONE:
> +		disable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE |
> +			  WX_PSR_VM_L2CTL_MPE | WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;

nit: This could also be trivially line-wrapped to less than 80 columns wide.
     Likewise a few times below.

> +		enable = 0;
> +		break;
> +	case WXVF_XCAST_MODE_MULTI:
> +		disable = WX_PSR_VM_L2CTL_MPE | WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
> +		enable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE;
> +		break;
> +	case WXVF_XCAST_MODE_ALLMULTI:
> +		disable = WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
> +		enable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE | WX_PSR_VM_L2CTL_MPE;
> +		break;
> +	case WXVF_XCAST_MODE_PROMISC:
> +		disable = 0;
> +		enable = WX_PSR_VM_L2CTL_BAM | WX_PSR_VM_L2CTL_ROMPE |
> +			 WX_PSR_VM_L2CTL_MPE | WX_PSR_VM_L2CTL_UPE | WX_PSR_VM_L2CTL_VPE;
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	vmolr = rd32(wx, WX_PSR_VM_L2CTL(vf));
> +	vmolr &= ~disable;
> +	vmolr |= enable;
> +	wr32(wx, WX_PSR_VM_L2CTL(vf), vmolr);
> +
> +	wx->vfinfo[vf].xcast_mode = xcast_mode;
> +out:
> +	msgbuf[1] = xcast_mode;
> +
> +	return 0;
> +}

...

