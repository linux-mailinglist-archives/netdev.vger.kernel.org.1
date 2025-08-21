Return-Path: <netdev+bounces-215484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A6B2EC3F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 05:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 547B17B4E2F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEAC214204;
	Thu, 21 Aug 2025 03:43:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3441805E
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 03:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755747825; cv=none; b=UGsPkDp5iFPi4xwv3Zt5UD0IsUg8YQJ+WRJIZbhlQ6jK8iYLUcKMhDV+Qn8yIBG7qjYe5YeP6ml47atSrjsxrbLPYuUnkUV9WLZt+tYRy/Hia7RhCHa/TzMG2lYt6GoCG6mtISfFNjdQ78+UCqeIY/54UCETwhGfyEyYgxcIDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755747825; c=relaxed/simple;
	bh=RyXJIjGQgBc3po6jjxW8jkV5efFNpfWOL8tbG5Mu6uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELLHSIhDindQ9gru/9uQHoRobUohGykar18WjgXaTOiJn4lISc+JQKu5h423XkGDJF4DjqHyLOBjl8XT71EQhpbc2upRmJtQLMb6aZdNj0qNSt9CZnEODp6D+3o7RzrbxF0drGyh8yYejwBXJMF7cvR9LhlyRDJAjJekolRO+3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1755747812t3cdede6a
X-QQ-Originating-IP: /PIIUZV9tLa4lzulq/S6d4ZgXhpMQyylT/75u3kv3Hs=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 11:43:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17795680503353605927
Date: Thu, 21 Aug 2025 11:43:31 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] net: rnpgbe: Add register_netdev
Message-ID: <7F14A04FE9C40F1A+20250821034331.GB1754449@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-6-dong100@mucse.com>
 <c37ee9e7-53de-4c21-b0cb-4cfb0936bc1e@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37ee9e7-53de-4c21-b0cb-4cfb0936bc1e@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NafZEDyfU/F9wP74Hj5tPw2bLiMFOt7vKaDEqK/IFcV0AmD71niGfRUX
	HClNDDHrRfAp0T4wY7NxoRYP8bgwRuRWG3MLYPcLgr7Ze9iPFE8XCFl9EBD77nydf2T4IHK
	QJOy8Q/Zc6IIXuvgtW3g+vEeCQJmSstIoqK9m2zBDYYGGeNYAKSdzT3IywaxXiGbAMJ0prB
	bCuUQQiWRuqyJdZ7Od/KSYT236ILgvWftqwPz/LiKOJl11EMJvkmkVdbYsn77i99QigFDUI
	JeQpXNu0koM2eR3DYRnuPJQkOzA44yfEytFzDYUSSVTef8dHQOYOS2gUEYMy+M5Kjb1PSou
	oV0I2LGvoqY50m6Pb7ZwSKQTyvfPKOUAzCKUz2mPRG/SB2JltKkW38D+VDlxXlyUQYwesm2
	RFcyijGvskQZ2COkR5JYnzt4QJva2nmlZCDrJn5vnfjPkhFAHDi3z0wzZeZu+jbJGxf8qGL
	yi9QkKGARj2wGVnxyKcl2u5/TClx8JcIydb4MHHxULQ5U89S7thyO54QXkNBrB+p2yBhqpU
	Z6iQbWwtW69K80aVKwWvMatwNFo5mQKc+JHvnd9FKyOX0V0cwKLGMko/71NNxhEXFrKqpjG
	+ng9iNjUe+GwvSirsqVq54BaiGqiHfSzUJngXa/J/6lDEigmR8/hqWwtA1XmLfk8/+Gli7C
	7JwZhIpHHCQXyvY3JIj484aIywmPV1QiUH8adUoc4ewsM3CzGl7ATTIdd11DsWI50Ve4r+o
	IvzpfPdu4uwTrMQeAryTQGPVHWyvphqDV3Bqdb/F7eEjipeollDdMuo4Ubzs5pWZcVrRfTN
	K0Med7uCZflLG6Y8Hd2mR6wZdITpkYqscHXwp29p43XcfQk4EJ5CFgtj0EvJbWP4jvJUsGI
	88i7sdtFFg/uFzfoAJD0VhoZyNzbppQtxvpAFQBa9iYa/ou/gL0z7RzpXOrVKWKGDiMIalv
	xcnqhD7BApiom/iSEvw6caGaNgnpw4oe8QZNIVzEBPZ3u/MfCcpqN+rz1paNlgUCjLmVhOD
	3lDRAfgS6LCsasMeUAyGIIzAXsY7vHcduXkpYntYUQoC9yhxD1
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:42:47PM +0200, Andrew Lunn wrote:
> > +static int rnpgbe_get_permanent_mac(struct mucse_hw *hw,
> > +				    u8 *mac_addr)
> > +{
> > +	struct device *dev = &hw->pdev->dev;
> > +
> > +	if (mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port) ||
> > +	    !is_valid_ether_addr(mac_addr)) {
> > +		dev_err(dev, "Failed to get valid MAC from FW\n");
> > +		return -EINVAL;
> 
> I _think_ mucse_fw_get_macaddr() can return -EINTR, because deep down,
> it has a call to mutex_lock_interruptible(). If that happens, you
> should not return iEINVAL, it is not an invalid value, its just an
> interrupted system call.
> 
> This is what i'm talking about needing careful review...
> 
>     Andrew
> 
> ---
> pw-bot: cr
> 
> 

Ok, Maybe like This?
Just return function return if mucse_fw_get_macaddr failed, and return
-EINVAL if not a valid mac.

static int rnpgbe_get_permanent_mac(struct mucse_hw *hw,
				    u8 *mac_addr)
{
	struct device *dev = &hw->pdev->dev;
	int ret;

	ret = mucse_fw_get_macaddr(hw, hw->pfvfnum, mac_addr, hw->port); 
	if (ret) {
		dev_err(dev, "Failed to get MAC from FW\n");
		return ret;
	}

	if (!is_valid_ether_addr(mac_addr)) {
		dev_err(dev, "MAC from FW is not valid\n");
		return -EINVAL;
	}

	return 0;
}

Thanks for your feedback.


