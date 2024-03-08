Return-Path: <netdev+bounces-78845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A20876C14
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 21:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3068B21145
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 20:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783025B20C;
	Fri,  8 Mar 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZstDeij"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AD55E08E
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709931471; cv=none; b=TFixDh+Stk38ZK92enulIr/BuuMtLrWcQ4/LM/fgdeWCLqwrNtmXMmMiwYFGMR+ROGZrJZAKkJmSwjNBXp3rvz1bLqC7rO9L8b0EVA3gvZklu1OUgcoXjfGmmNg4Z1XXhK8R8WYJB4gPmLrZQwhD+zgGG6DpvLqqLnS7tslIgSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709931471; c=relaxed/simple;
	bh=F+XTdVl5mzu3MWyCMrgVGLg5O59Ywnw/692Fn0yPAs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA7Gxw1cmkwrazRo6zXEy9rozkbNatNhhX4w0xxTBA07FW/muUQGqOZx5sc1m8YZicVbZZVTrqbUXL0iGzLOQievQgZ7r2jMiYXRtMD/FuPjAb4Au0p5z2KfnlEgHhqHkabkePMd3ErqVSBoKeB+El1Ds/Y1eb0nf6n+aQmmbcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZstDeij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03373C433C7;
	Fri,  8 Mar 2024 20:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709931470;
	bh=F+XTdVl5mzu3MWyCMrgVGLg5O59Ywnw/692Fn0yPAs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AZstDeijH+gHTuEFm1SvokjpPMdF/fBmZxiVpdyC+cQ0Vr+SrIdT8ddQb+IH0hraU
	 cnRkjDa3IBJofMvYTiHy21ujqww4O/JlgMj98BBEmVf5MMpgdRx/6vp58CEp5LSGxg
	 ADcH72Ycw/AbXJMQUqmzbZ4hb+87IFmVbP5KQIPkIAJGzH3MmPLB/ZvRZTUf40JnG4
	 UZuQRvKLM67qrNE2eATDAAu+uJpdXJsP9JO4/pxvi0dNcluyKjEAjAu1zrv3trqasn
	 AowdvMcOCnIxp9MLSnnQOCjradlzos5+QpzIvkdd/UbqSRN6DHt4tWpj+X+I/uZ34o
	 lKxUji5TUdctg==
Date: Fri, 8 Mar 2024 20:56:17 +0000
From: Simon Horman <horms@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com
Subject: Re: [PATCH net-next 3/5] net: libwx: Add msg task api
Message-ID: <20240308205617.GD603911@kernel.org>
References: <20240307095755.7130-1-mengyuanlou@net-swift.com>
 <74A88D8060E77248+20240307095755.7130-4-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74A88D8060E77248+20240307095755.7130-4-mengyuanlou@net-swift.com>

On Thu, Mar 07, 2024 at 05:54:58PM +0800, Mengyuan Lou wrote:
> Implement ndo_set_vf_spoofchk and ndo_set_vf_link_state
> interfaces.
> Implement wx_msg_task which is used to process mailbox
> messages sent by vf.
> Reallocate queue and int resources when sriov is enabled.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>

Hi Mengyuan Lou,

some minor feedback from my side.

...

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_hw.c b/drivers/net/ethernet/wangxun/libwx/wx_hw.c

...

> +void wx_configure_virtualization(struct wx *wx)
> +{
> +	u16 pool = wx->num_rx_pools;
> +	u32 reg_offset, vf_shift;
> +	u32 i;
> +
> +	if (!test_bit(WX_FLAG_SRIOV_ENABLED, wx->flags))
> +		return;
> +
> +	wr32m(wx, WX_PSR_VM_CTL,
> +	      WX_PSR_VM_CTL_POOL_MASK | WX_PSR_VM_CTL_REPLEN,
> +	      FIELD_PREP(WX_PSR_VM_CTL_POOL_MASK, VMDQ_P(0)) |
> +	      WX_PSR_VM_CTL_REPLEN);
> +	while (pool--)
> +		wr32m(wx, WX_PSR_VM_L2CTL(i), WX_PSR_VM_L2CTL_AUPE, WX_PSR_VM_L2CTL_AUPE);

i is not initialised here.

Flagged by clang-17 W=1 build, and Smatch.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_sriov.c b/drivers/net/ethernet/wangxun/libwx/wx_sriov.c

...

> +static int wx_vf_reset_msg(struct wx *wx, u16 vf)
> +{
> +	unsigned char *vf_mac = wx->vfinfo[vf].vf_mac_addr;
> +	struct net_device *dev = wx->netdev;
> +	u32 msgbuf[5] = {0, 0, 0, 0, 0};
> +	u8 *addr = (u8 *)(&msgbuf[1]);
> +	u32 reg, index, vf_bit;
> +	int pf_max_frame;
> +
> +	/* reset the filters for the device */
> +	wx_vf_reset_event(wx, vf);
> +
> +	/* set vf mac address */
> +	if (!is_zero_ether_addr(vf_mac))
> +		wx_set_vf_mac(wx, vf, vf_mac);
> +
> +	vf_bit = vf % 32;
> +	index = vf / 32;
> +
> +	/* force drop enable for all VF Rx queues */
> +	wx_write_qde(wx, vf, 1);
> +
> +	/* set transmit and receive for vf */
> +	wx_set_vf_rx_tx(wx, vf);
> +
> +	pf_max_frame = dev->mtu + ETH_HLEN;
> +
> +	if (pf_max_frame > ETH_FRAME_LEN)
> +		reg = BIT(vf_bit);

If the condition above is false then reg is used uninitialised below.

> +	wr32(wx, WX_RDM_VFRE_CLR(index), reg);
> +
> +	/* enable VF mailbox for further messages */
> +	wx->vfinfo[vf].clear_to_send = true;
> +
> +	/* reply to reset with ack and vf mac address */
> +	msgbuf[0] = WX_VF_RESET;
> +	if (!is_zero_ether_addr(vf_mac)) {
> +		msgbuf[0] |= WX_VT_MSGTYPE_ACK;
> +		memcpy(addr, vf_mac, ETH_ALEN);
> +	} else {
> +		msgbuf[0] |= WX_VT_MSGTYPE_NACK;
> +		wx_err(wx, "VF %d has no MAC address assigned", vf);
> +	}
> +
> +	/* Piggyback the multicast filter type so VF can compute the
> +	 * correct vectors
> +	 */
> +	msgbuf[3] = wx->mac.mc_filter_type;
> +	wx_write_mbx_pf(wx, msgbuf, WX_VF_PERMADDR_MSG_LEN, vf);
> +
> +	return 0;
> +}

...

> +static int wx_rcv_msg_from_vf(struct wx *wx, u16 vf)
> +{
> +	u16 mbx_size = WX_VXMAILBOX_SIZE;
> +	u32 msgbuf[WX_VXMAILBOX_SIZE];
> +	int retval;
> +
> +	retval = wx_read_mbx_pf(wx, msgbuf, mbx_size, vf);
> +	if (retval) {
> +		wx_err(wx, "Error receiving message from VF\n");
> +		return retval;
> +	}
> +
> +	/* this is a message we already processed, do nothing */
> +	if (msgbuf[0] & (WX_VT_MSGTYPE_ACK | WX_VT_MSGTYPE_NACK))

retval is 0 here. Should a negative error value be returned instead?

> +		return retval;
> +
> +	if (msgbuf[0] == WX_VF_RESET)
> +		return wx_vf_reset_msg(wx, vf);
> +
> +	/* until the vf completes a virtual function reset it should not be
> +	 * allowed to start any configuration.
> +	 */
> +	if (!wx->vfinfo[vf].clear_to_send) {
> +		msgbuf[0] |= WX_VT_MSGTYPE_NACK;
> +		wx_write_mbx_pf(wx, msgbuf, 1, vf);

Here too.

> +		return retval;
> +	}
> +
> +	switch ((msgbuf[0] & U16_MAX)) {
> +	case WX_VF_SET_MAC_ADDR:
> +		retval = wx_set_vf_mac_addr(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_SET_MULTICAST:
> +		retval = wx_set_vf_multicasts(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_SET_VLAN:
> +		retval = wx_set_vf_vlan_msg(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_SET_LPE:
> +		if (msgbuf[1] > WX_MAX_JUMBO_FRAME_SIZE) {
> +			wx_err(wx, "VF max_frame %d out of range\n", msgbuf[1]);
> +			return -EINVAL;
> +		}
> +		retval = wx_set_vf_lpe(wx, msgbuf[1], vf);
> +		break;
> +	case WX_VF_SET_MACVLAN:
> +		retval = wx_set_vf_macvlan_msg(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_API_NEGOTIATE:
> +		retval = wx_negotiate_vf_api(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_GET_QUEUES:
> +		retval = wx_get_vf_queues(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_GET_LINK_STATE:
> +		retval = wx_get_vf_link_state(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_GET_FW_VERSION:
> +		retval = wx_get_fw_version(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_UPDATE_XCAST_MODE:
> +		retval = wx_update_vf_xcast_mode(wx, msgbuf, vf);
> +		break;
> +	case WX_VF_BACKUP:
> +		break;
> +	default:
> +		wx_err(wx, "Unhandled Msg %8.8x\n", msgbuf[0]);
> +		retval = -EBUSY;
> +		break;
> +	}
> +
> +	/* notify the VF of the results of what it sent us */
> +	if (retval)
> +		msgbuf[0] |= WX_VT_MSGTYPE_NACK;
> +	else
> +		msgbuf[0] |= WX_VT_MSGTYPE_ACK;
> +
> +	msgbuf[0] |= WX_VT_MSGTYPE_CTS;
> +
> +	wx_write_mbx_pf(wx, msgbuf, mbx_size, vf);
> +
> +	return retval;
> +}

...

