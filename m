Return-Path: <netdev+bounces-179557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777D1A7D97A
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4724E1887074
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C320B23875A;
	Mon,  7 Apr 2025 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="JzV5Q958"
X-Original-To: netdev@vger.kernel.org
Received: from sg-1-21.ptr.blmpb.com (sg-1-21.ptr.blmpb.com [118.26.132.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A3223716B
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 09:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744017558; cv=none; b=qA+1ZQtUC0fwwM3iLRqVdkMUtuGthqOKvoNvcgYoztCir4s+1hfPIkq0HPRwk7aV+4cMWBnP3VilVMl8d2yBC1Qi/NgY0WnYcdbSm+HL7HJakt4fac8xFK3dC+jbioWK1U+HzRzKLNL4P6gXn0f0BpBPFhg+8PLsk6QPYw6oXts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744017558; c=relaxed/simple;
	bh=WZhYQVmEzS37DSYHB8fg82yBli+uIkHpjxt3EmTTNGw=;
	h=Subject:Mime-Version:Content-Type:In-Reply-To:To:Cc:From:Date:
	 Message-Id:References; b=AOp+2yzOM+a/zU7ZtDAmfPiU0uM1huR/fjRsQsqG1X51ye9b5yrh9R/q/BRFLknA2Rh9w5WZewVwKwatj1Rf+5brTApigBmpvovZ4BmzqCH6a69xTFtvqd392TysUMDcuOZJx2d6XzFQKxANwNeOLTDIrcq5/naibSLpxuSB5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=JzV5Q958; arc=none smtp.client-ip=118.26.132.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1744017410; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=V0qnB1MJxRXWqNSZ5w1A1IzePmv/WCb7nczJ3vOV/sU=;
 b=JzV5Q958ZRsAU/klCwRYxKdr3ZY08Z4btI8p1ed/RqND4djHnGXqADk4gWs/TxCAvgWRIO
 h61v9uK8CEwmBLnsb8hvICmLZYMBR0LyO2b4VQ29hMofeoffknYYxVV47xGYou0/Cy7uUz
 b2o1P5eomEOetJjay5mnp5v9nuM8uRBbP29teTUhhnFd5najGBtOlLjpVuxvGQu6PwWgZV
 lYNCgLxGVVGAZxEJc2ybOPS6aldnCcrT1mN+HGkOtm6CvyOJgolO9vQRtLxQsK09MDf7dA
 4fF+3CVVqqadE/TwK8O5nRsge8Sft9dP4AlGvI7rwTfuUwoAXYALdQGvAEqnYw==
Subject: Re: [PATCH net-next v9 09/14] xsc: Init net device
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Received: from [127.0.0.1] ([116.231.163.61]) by smtp.feishu.cn with ESMTPS; Mon, 07 Apr 2025 17:16:48 +0800
In-Reply-To: <20250325051934.002db3cd@kernel.org>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <jacky@yunsilicon.com>, 
	<horms@kernel.org>, <parthiban.veerasooran@microchip.com>, 
	<masahiroy@kernel.org>, <kalesh-anakkur.purayil@broadcom.com>, 
	<geert+renesas@glider.be>, <geert@linux-m68k.org>
From: "Xin Tian" <tianx@yunsilicon.com>
Date: Mon, 7 Apr 2025 17:16:53 +0800
Message-Id: <941d54c4-15d5-43b7-a7af-4eb913448492@yunsilicon.com>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
References: <20250318151449.1376756-1-tianx@yunsilicon.com> <20250318151510.1376756-10-tianx@yunsilicon.com> <20250325051934.002db3cd@kernel.org>
X-Lms-Return-Path: <lba+267f39801+35753b+vger.kernel.org+tianx@yunsilicon.com>

On 2025/3/25 20:19, Jakub Kicinski wrote:
> On Tue, 18 Mar 2025 23:15:11 +0800 Xin Tian wrote:
>> +static int xsc_eth_set_hw_mtu(struct xsc_core_device *xdev,
>> +			      u16 mtu, u16 rx_buf_sz)
>> +{
>> +	struct xsc_set_mtu_mbox_out out;
>> +	struct xsc_set_mtu_mbox_in in;
>> +	int ret;
>> +
>> +	memset(&in, 0, sizeof(struct xsc_set_mtu_mbox_in));
>> +	memset(&out, 0, sizeof(struct xsc_set_mtu_mbox_out));
>> +
>> +	in.hdr.opcode =3D cpu_to_be16(XSC_CMD_OP_SET_MTU);
>> +	in.mtu =3D cpu_to_be16(mtu);
>> +	in.rx_buf_sz_min =3D cpu_to_be16(rx_buf_sz);
>> +	in.mac_port =3D xdev->mac_port;
>> +
>> +	ret =3D xsc_cmd_exec(xdev, &in, sizeof(struct xsc_set_mtu_mbox_in), &o=
ut,
>> +			   sizeof(struct xsc_set_mtu_mbox_out));
>> +	if (ret || out.hdr.status) {
>> +		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
> Please use temporary variable or define a local print macro.
> The cast is too ugly.
OK=EF=BC=8Cwill use temporary variable here
>
>> +			   "failed to set hw_mtu=3D%u rx_buf_sz=3D%u, err=3D%d, status=3D%d\=
n",
>> +			   mtu, rx_buf_sz, ret, out.hdr.status);
>> +		ret =3D -ENOEXEC;
> Why are you overwriting the ret code from xsc_cmd_exec() ?
> And why with such an unusual errno ?


Thanks for pointing this out =E2=80=94 it's a mistake.


In our old implementation, there were two return values:

the return value of xsc_cmd_exec indicated whether the message was=20
properly transmitted through CMDQ,

while out.status reflected the result of the command execution in the=20
firmware.

So we chose -ENOEXEC to cover both types of errors.


But now the return value of xsc_cmd_exec already reflects the result of=20
out.status,

and -ENOEXEC seems not an appropriate return value here.


I'll fix this and return the result of xsc_cmd_exec directly.


>
>> +static int xsc_eth_get_mac(struct xsc_core_device *xdev, char *mac)
>> +{
>> +	struct xsc_query_eth_mac_mbox_out *out;
>> +	struct xsc_query_eth_mac_mbox_in in;
>> +	int err =3D 0;
>> +
>> +	out =3D kzalloc(sizeof(*out), GFP_KERNEL);
>> +	if (!out)
>> +		return -ENOMEM;
>> +
>> +	memset(&in, 0, sizeof(in));
>> +	in.hdr.opcode =3D cpu_to_be16(XSC_CMD_OP_QUERY_ETH_MAC);
>> +
>> +	err =3D xsc_cmd_exec(xdev, &in, sizeof(in), out, sizeof(*out));
>> +	if (err || out->hdr.status) {
>> +		netdev_err(((struct xsc_adapter *)xdev->eth_priv)->netdev,
>> +			   "get mac failed! err=3D%d, out.status=3D%u\n",
>> +			   err, out->hdr.status);
>> +		err =3D -ENOEXEC;
>> +		goto err_free;
>> +	}
>> +
>> +	memcpy(mac, out->mac, 6);
> 6 -> ETH_ALEN or ether_addr_copy()
Ack
>
>> +
>> +err_free:
>> +	kfree(out);
>> +	return err;
>> +}
>> +
>> +static void xsc_eth_l2_addr_init(struct xsc_adapter *adapter)
>> +{
>> +	struct net_device *netdev =3D adapter->netdev;
>> +	char mac[6] =3D {0};
>> +	int ret =3D 0;
>> +
>> +	ret =3D xsc_eth_get_mac(adapter->xdev, mac);
>> +	if (ret) {
>> +		netdev_err(netdev, "get mac failed %d, generate random mac...",
>> +			   ret);
>> +		eth_random_addr(mac);
> eth_hw_addr_random()
OK, no need for set now. Will change.
>
>> +	}
>> +	dev_addr_mod(netdev, 0, mac, 6);
> Why not dev_addr_set() ?!

OK=EF=BC=8Cdev_addr_set() is more suitable

Thanks

