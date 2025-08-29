Return-Path: <netdev+bounces-218091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F8BB3B10A
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 04:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3AEA5E1228
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 02:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E6A1FCF41;
	Fri, 29 Aug 2025 02:37:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAAE6FC5;
	Fri, 29 Aug 2025 02:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756435044; cv=none; b=jkqudftboiNcqWvJeBrfShtIwfIaMk35Nwyw+6gFEhMKgN/816CS7fM9RX0/Bath+325/GFosKjCr+QuSd+RjMpK0QL3Z5Vy/MOvo/XLHCEV42TbvAKUBv9KBzZ7ZeKlIOd+CVNMFJXPclJ0iQ7G+T3rsrK8CZs0V7bRvaVzRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756435044; c=relaxed/simple;
	bh=PJ+tY7pi3xt3j+eLneIBuSVZx0ciuyKBM2ylX7x8b6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhMHYIdtrbJ0TbQnqM/agWrnI5keK08qMMnew5GWf/CqVBVJ2vgqCnLq6Pf2Gw09IXCxbXtkRa1zvOEjDVRUFI8xfG6TZEnyJbsJCxu12YGasbrXCGFx1+ujhcr2JJ0PtFqyHeI4Zw/oRUY2EE2hsGqTD6Sk11JOWEM8ppYCvzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz10t1756435010tf4b84854
X-QQ-Originating-IP: g/Fgw+DgN7+02PgKaJ5YVFbo4h7+NoaFcU2OyWk3tBk=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 29 Aug 2025 10:36:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7550459696108476182
Date: Fri, 29 Aug 2025 10:36:48 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v9 5/5] net: rnpgbe: Add register_netdev
Message-ID: <A5B215AE5EB4FE9D+20250829023648.GB904254@nic-Precision-5820-Tower>
References: <20250828025547.568563-1-dong100@mucse.com>
 <20250828025547.568563-6-dong100@mucse.com>
 <e0f71a7d-1288-4971-804d-123e3e8a153f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f71a7d-1288-4971-804d-123e3e8a153f@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NyPaQtJYQgeoV1Z1Je0uGcuGrVaPxCqf2JhJcaHqlchXvjLgiXUdw83j
	ZEExgqTFv8aVrCilH53F4PWh37w38aRDYbirdsU/KKbgpENJvjXjooKIk/TBMK7OTt/kG7l
	IL91vXm8m/3MsWkkz7IoaZuCND+FMcQ0oP2Yi92U5k4dnm2Va4ymo635tkAJugA9gH9GgUq
	dzv5R0qWi1UGDBCjSWuwhXjAgqjsmd1zfmPRr4u1cKABB/QKk3UKDWZul1FK+JfuQanhArT
	0E1b4H9x3osyo4w3cSLkXO87oT+Y/WSV50HDxysH5FxXLDDPOJ7dptjWqNw9z/FXlg9HN0u
	fQfJfMCFPNxNdYbivrQYiubyhT/QU+8BNIZ87j2fD32cK7N/ykYxYbFL9r03wH5ApyY3ng9
	8RtlkBtTu4efsQs2Ag3bA4Zfi/OVngQaOCJ3cnUhBJA3zNsAmb775hZyem5/PmihoI4741p
	3lINldyvi0FJjYCmMa+y5lSbQHvWVoRfeupRcEqBw97wvHO0tbK57MxP8DwFHUIFzfqDzjN
	TNbbkE6IKZKdvACeL0SXoVqQIy3baqEzg0pradGhodSgOYMQUo31e1x0AVaNdNRdKe1EgaJ
	kxsb3TeuGwTFaNRaMj3hvURyNWU222YagozcXMRw0eP3l3ANyd2jRtOpmfvb8iUfzdutaQ1
	PVrGop+WtJ8ryzFtw7vgMHTJ3N5C3WeDP9kmYx2k2DYKfR+RIIW5KLCEANffoFHlwGyOC5K
	SHuRz9ipMvuPpU7ANBYMF88E+Kj2GjNHURz5M7s3e83HWQPATFPFbE/dB24JKa99up1hj/Z
	TL5y/NCvZvLFGOEOrmuHtPLhqzM9iQArA5muZYwZGf/pgY/AF8MvEoqeU1TQsl/LDj5bUwH
	DPn2S5RI7GfRBzCMjVaQPsgXuWi+3BHFigP+Xfv+NHdlTTKOnP558L3xHbhY6O++R3bZx2H
	Sta6eWKIaH5KEgbdCEknDLDD0mER2gN6zEtbkiBGAEEFX1N7UxA/BS4UxKAom0G+R2pQ=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Thu, Aug 28, 2025 at 03:20:04PM +0200, Andrew Lunn wrote:
> > +/**
> > + * rnpgbe_reset_hw_ops - Do a hardware reset
> > + * @hw: hw information structure
> > + *
> > + * rnpgbe_reset_hw_ops calls fw to do a hardware
> > + * reset, and cleans some regs to default.
> > + *
> > + * Return: 0 on success, negative errno on failure
> > + **/
> > +static int rnpgbe_reset_hw_ops(struct mucse_hw *hw)
> > +{
> > +	struct mucse_dma_info *dma = &hw->dma;
> > +	int err;
> > +
> > +	rnpgbe_dma_wr32(dma, RNPGBE_DMA_AXI_EN, 0);
> > +	err = mucse_mbx_fw_reset_phy(hw);
> > +	if (err)
> > +		return err;
> > +	return rnpgbe_get_permanent_mac(hw, hw->perm_addr);
> 
> Why is a function named rnpgbe_reset_hw_ops() getting the permanent
> MAC address? Reset should not have anything to do with MAC address.
> 
> If the MAC address is not valid, you normally use a random MAC
> address. But you cannot easily differentiate between the reset failed,
> the reset got ^C, and the MAC address was not valid.
> 

Ok, I will remove call 'rnpgbe_get_permanent_mac' in function
'rnpgbe_reset_hw_ops'. And call it in probe.

> > +/**
> > + * rnpgbe_driver_status_hw_ops - Echo driver status to hw
> > + * @hw: hw information structure
> > + * @enable: true or false status
> > + * @mode: status mode
> > + **/
> > +static void rnpgbe_driver_status_hw_ops(struct mucse_hw *hw,
> > +					bool enable,
> > +					int mode)
> > +{
> > +	switch (mode) {
> > +	case mucse_driver_insmod:
> > +		mucse_mbx_ifinsmod(hw, enable);
> 
> Back to the ^C handling. This could be interrupted before the firmware
> is told the driver is loaded. That EINTR is thrown away here, so the
> driver thinks everything is O.K, but the firmware still thinks there
> is no MAC driver. What happens then?
> 

The performance will be very poor since low working frequency,
that is not we want.

> And this is the same problem i pointed out before, you ignore EINTR in
> a void function. Rather than fix one instance, you should of reviewed
> the whole driver and fixed them all. You cannot expect the Reviewers
> to do this for you.

I see, I will change 'void' to 'int' in order to handle err, and try to check
other functions.

> 
>     Andrew
> 
> ---
> pw-bot: cr
> 

Thanks for your feedback.


