Return-Path: <netdev+bounces-177366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFDDA6FC04
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F36BE7A72E4
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31CA5257AD7;
	Tue, 25 Mar 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEamIZXM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB54257AD1
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905185; cv=none; b=NnkUjl+KHobTlLd7yGJs5MTri56Cb3XDG0IUjgu7quIyj3V0x/K+a5tLihYlrual0z60bPvu8NLIWq1QZWyqrHYj6lQ6uhlKtL1Pi6eLj0gqkBEE+80zx20vqYp8sGm11Tm3I+XVWN0yz6h5dn+4Ua8FYq0Wwz8I41GUpU083bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905185; c=relaxed/simple;
	bh=AHw3OAeqYEIevLAEuV4OUVZNI/+WQmI7pKAw4wheSto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eUU+c+75AHNEimXNrUjf6OZetHIBu7LlFaF8/zyluZ6bb+f5tH/XuYURfmLDyKVQb4+AMnF6ErTHh8YMkbaQNf+PnawiHRo0gLHfVARTA1ZYJD9OKQ+ktVgJnUsjunG4G/VggCgFfIYvmXmraSW5zcS2qLiJqZbFyT8FE7ofRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEamIZXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88005C4CEEE;
	Tue, 25 Mar 2025 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905184;
	bh=AHw3OAeqYEIevLAEuV4OUVZNI/+WQmI7pKAw4wheSto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HEamIZXM+SrHg1LT/2RLSku05/oFtT4HSKKAUQv7y3QOcfTfTMuVR49w68pbZg0Zb
	 7++qfBPNM4iSQEnPf/1x/hc35JmDF6hNbnx89CehQqBf/Q9+UHcpM6ugst1r7nn8sQ
	 AKNI8hNkLravjsO1Z994u9JaowVUkNMGH9lb1YIVo+4AdJsearhIAzidIJGdyHSFM/
	 4c5y0mprfMKY7fwIiJ4bH9sPTLhleITzy0IBbTCA3+7IFyLGD0+Uja7YjG3BH3b/Ia
	 xl47fyZVo183w7lvvFeGAo9XSCrKmg1ODuXL32hTSMbQeVS6/u1+4ZwuUyPlrCz+TV
	 N8xH6gmfQKTYQ==
Date: Tue, 25 Mar 2025 05:19:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>,
 <horms@kernel.org>, <parthiban.veerasooran@microchip.com>,
 <masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>,
 <geert+renesas@glider.be>, <geert@linux-m68k.org>
Subject: Re: [PATCH net-next v9 09/14] xsc: Init net device
Message-ID: <20250325051934.002db3cd@kernel.org>
In-Reply-To: <20250318151510.1376756-10-tianx@yunsilicon.com>
References: <20250318151449.1376756-1-tianx@yunsilicon.com>
	<20250318151510.1376756-10-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 23:15:11 +0800 Xin Tian wrote:
> +static int xsc_eth_set_hw_mtu(struct xsc_core_device *xdev,
> +			      u16 mtu, u16 rx_buf_sz)
> +{
> +	struct xsc_set_mtu_mbox_out out;
> +	struct xsc_set_mtu_mbox_in in;
> +	int ret;
> +
> +	memset(&in, 0, sizeof(struct xsc_set_mtu_mbox_in));
> +	memset(&out, 0, sizeof(struct xsc_set_mtu_mbox_out));
> +
> +	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_SET_MTU);
> +	in.mtu = cpu_to_be16(mtu);
> +	in.rx_buf_sz_min = cpu_to_be16(rx_buf_sz);
> +	in.mac_port = xdev->mac_port;
> +
> +	ret = xsc_cmd_exec(xdev, &in, sizeof(struct xsc_set_mtu_mbox_in), &out,
> +			   sizeof(struct xsc_set_mtu_mbox_out));
> +	if (ret || out.hdr.status) {
> +		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,

Please use temporary variable or define a local print macro.
The cast is too ugly.

> +			   "failed to set hw_mtu=%u rx_buf_sz=%u, err=%d, status=%d\n",
> +			   mtu, rx_buf_sz, ret, out.hdr.status);
> +		ret = -ENOEXEC;

Why are you overwriting the ret code from xsc_cmd_exec() ?
And why with such an unusual errno ?

> +static int xsc_eth_get_mac(struct xsc_core_device *xdev, char *mac)
> +{
> +	struct xsc_query_eth_mac_mbox_out *out;
> +	struct xsc_query_eth_mac_mbox_in in;
> +	int err = 0;
> +
> +	out = kzalloc(sizeof(*out), GFP_KERNEL);
> +	if (!out)
> +		return -ENOMEM;
> +
> +	memset(&in, 0, sizeof(in));
> +	in.hdr.opcode = cpu_to_be16(XSC_CMD_OP_QUERY_ETH_MAC);
> +
> +	err = xsc_cmd_exec(xdev, &in, sizeof(in), out, sizeof(*out));
> +	if (err || out->hdr.status) {
> +		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
> +			   "get mac failed! err=%d, out.status=%u\n",
> +			   err, out->hdr.status);
> +		err = -ENOEXEC;
> +		goto err_free;
> +	}
> +
> +	memcpy(mac, out->mac, 6);

6 -> ETH_ALEN or ether_addr_copy()

> +
> +err_free:
> +	kfree(out);
> +	return err;
> +}
> +
> +static void xsc_eth_l2_addr_init(struct xsc_adapter *adapter)
> +{
> +	struct net_device *netdev = adapter->netdev;
> +	char mac[6] = {0};
> +	int ret = 0;
> +
> +	ret = xsc_eth_get_mac(adapter->xdev, mac);
> +	if (ret) {
> +		netdev_err(netdev, "get mac failed %d, generate random mac...",
> +			   ret);
> +		eth_random_addr(mac);

eth_hw_addr_random()

> +	}
> +	dev_addr_mod(netdev, 0, mac, 6);

Why not dev_addr_set() ?!

