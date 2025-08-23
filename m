Return-Path: <netdev+bounces-216185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE9FB32657
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 03:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CF43B60163
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 01:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21571EE7B9;
	Sat, 23 Aug 2025 01:58:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850F7191F7E;
	Sat, 23 Aug 2025 01:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755914327; cv=none; b=efibYTva+dOduuyJ/k2Ixe7uKC8pB32NU8ItTH3iQj7yk5sdH3Lqw5SK3UrufcwzpJ6hty9Ju20u0isBDrNxBLYe0JTLmtP+aYRUfwz4dLPmHsxQH1UWNLmN2CYZtMe/r+w/orZ5Ek+oGyiVy6ApBcL8GBFUZ8IGKfu1nxThfKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755914327; c=relaxed/simple;
	bh=DL7lJvSlF2uYNjqhrn7rHxrrv9ZYt7wI4V1rmKzypqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KikkzyCgjpIFaWEdy2fUQAN7oGp6TFVJOJtahMhCQxsZ2LXcaZyVDMWv0BLSRojG/RvxlMqZnX/Hb7DRAX9NJCDHU/EnqXEBth26nWL9dLJ5Nfzw/oKQEkxWyZIrkLzFjoTcRBevP2v7l9PBcgSWAV/bFizEbaXXw0tGVLxElJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz20t1755914306t18ac98e2
X-QQ-Originating-IP: 9m1i3pwX/AtOIuG45fGnU9FcBbfvOkYiHnLZOR3b2Mo=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 23 Aug 2025 09:58:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8408012566057604248
Date: Sat, 23 Aug 2025 09:58:24 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <C2BF8A6A8A79FB29+20250823015824.GB1995939@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <a066746c-2f12-4e70-b63a-7996392a9132@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a066746c-2f12-4e70-b63a-7996392a9132@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N4bqf7uc8PW19XP0trQQ+Rsb3QZc/woXInVpXcYjV9mq0x7aKC3grbok
	nJu2P5DHHsQE4wPSEwK7S4Hq3iXRkE8CTW7EwRir3Skhp8aNYYv0TYF0N2LWiWNUFJF+a/7
	LQ2gZkDYlUXSTtpezb4RS/+KamnaURkPHZf8hWsuNIuY5hNlTamZRDDt8fU+EMovNtxJrb1
	OfsBnDNUcY/Eqt+5XT/f3ojtlUmzAgOk5XpK/OgmGYiPwMQ5/Fzju0UfpP0pUw/5KtnJKm9
	NV03yknEXLUeHMyVKypZHCFm/+ChUYhl7uBgqCmUrKYVlxoaSoe6n5v0La864E4GMVtGWii
	z5Ykg1pyHwYYMaTBZDFFQF+lbf2gOEEfMHGoPty4/ExbLEGSdfBMIR+RWB5C4tPifa1IBUI
	sQMGL149hzPmfSN12ytVKsRfc1QGMnb3OLgLFm/C9oLXW5197HQ0TzS3hNEMi0tf2Y0X03n
	z6rn5UrPCqIA+kB5eSGdEK16XBC8vHjaAZVDRMfiMf+uyUeqJ1R0NqDh4yeg2U3B1kf1ZZW
	KmAe6AOn5bCbBa4LuYNl1f8ycWY0Y7aD1gSECDOA6tcOWECsdH/q6zKuyRLNHOtC13b+4fz
	gEDURwbGRfpaAMzBJ/DQ++fCZdzUkoYrtM/pNZeE7wfsgcazLwOfmLWQwVNDW/hrct3n9VT
	V++1W2YMzrn/lx0xE9/t12AaFIird+BnFFO49FsWZH4CtwSE9uAuXIjkcrU5iz1X4AagKHm
	t9nzDeSFa3ECFun491qYTn90irbTUowuhyS0QluvLqEq49VqYc/h4FK+xQWxqkUH7tSBl/a
	KXMqj8MrTtQjSv0aX/tsMoxmMhR3EI+uRPdL9CrQXY1qG5vbeFEPCePpZd1/XluE26T4Tup
	nHsQaXYULFT80wvGVcOoGftBohNEos7hWbcJLNGXrhV0qlC5VEqDvFwoKId4+xQ9hMDmFHj
	WodB1kV7ZV7zL+DaRalZQUet6E6nGWkTbsI0n0+vST5aQRK/cDoXy3Eip8lGV/XBU+7E=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 04:43:16PM +0200, Andrew Lunn wrote:
> > +/**
> > + * mucse_mbx_get_capability - Get hw abilities from fw
> > + * @hw: pointer to the HW structure
> > + *
> > + * mucse_mbx_get_capability tries to get capabities from
> > + * hw. Many retrys will do if it is failed.
> > + *
> > + * @return: 0 on success, negative on failure
> > + **/
> > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > +{
> > +	struct hw_abilities ability = {};
> > +	int try_cnt = 3;
> > +	int err = -EIO;
> > +
> > +	while (try_cnt--) {
> > +		err = mucse_fw_get_capability(hw, &ability);
> > +		if (err)
> > +			continue;
> > +		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> > +		return 0;
> > +	}
> > +	return err;
> > +}
> 
> Please could you add an explanation why it would fail? Is this to do
> with getting the driver and firmware in sync? Maybe you should make
> this explicit, add a function mucse_mbx_sync() with a comment that
> this is used once during probe to synchronise communication with the
> firmware. You can then remove this loop here.

It is just get some fw capability(or info such as fw version).
It is failed maybe:
1. -EIO: return by mucse_obtain_mbx_lock_pf. The function tries to get
pf-fw lock(in chip register, not driver), failed when fw hold the lock.
2. -ETIMEDOUT: return by mucse_poll_for_xx. Failed when timeout.
3. -ETIMEDOUT: return by mucse_fw_send_cmd_wait. Failed when wait
response timeout.
4. -EIO: return by mucse_fw_send_cmd_wait. Failed when error_code in
response.
5. err return by mutex_lock_interruptible.

> 
> I would also differentiate between different error codes. It is
> pointless to try again with ENOMEM, EINVAL, etc. These are real errors
> which should be reported. However TIMEDOUT might makes sense to
> retry.
> 
> 	Andrew
> 

Yes, I didn't differentiate between different error codes. But it cost
~0 to ask firmware again. And error will be reported after 'try_cnt' times
retry to the function caller.
Maybe can simply handle error codes link this?

Thanks for your feedback.






