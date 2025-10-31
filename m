Return-Path: <netdev+bounces-234554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF4C22E7A
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 02:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 979B734D668
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 01:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F51425784E;
	Fri, 31 Oct 2025 01:44:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C957B5695;
	Fri, 31 Oct 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761875074; cv=none; b=J8UEDSzU0b66+B45KybxLDo+AArSHnViZ9v2LY00zWBJvRFN6onJEFAi0P/SGo6kaE/pOT/DLztH+TMIqxmZFaFmrcS+YbjteP1e08dcOm4SxWDKjUnfB0xBV+GqGQjSR8OCWnzNtblvYQThXOh2fSCNlHpyXs0pZI78aknlb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761875074; c=relaxed/simple;
	bh=pYavPt+x5GL8WEpoic8WMunz/FCXubi2hLr1KjAsyPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esv3GZholPkZTQYn5E8rH1olu/vwG18ZjEvPTeJR5WBkzo3Bz74gkAo8dnauCCd4h8ADwIykwIncu9ZCwJvb+lfZwn3uLZmsgNLi4LDg/O8F/VjzzvKK1eDGWxUiWVx+8/oQsedjCRnOlgmOSFRjUGupIoMALxsfqvNqJtD6dno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1761875052tbb4b434d
X-QQ-Originating-IP: AmvPrvrWiZ8aJRh3CzAKUCEO3ZTeqcP/97IasElbISM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Oct 2025 09:44:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8086489590054913680
Date: Fri, 31 Oct 2025 09:44:10 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch,
	danishanwar@ti.com, vadim.fedorenko@linux.dev,
	geert+renesas@glider.be, mpe@ellerman.id.au, lorenzo@kernel.org,
	lukas.bulwahn@redhat.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v16 5/5] net: rnpgbe: Add register_netdev
Message-ID: <7D45894046CE41CC+20251031014410.GA49419@nic-Precision-5820-Tower>
References: <20251027032905.94147-1-dong100@mucse.com>
 <20251027032905.94147-6-dong100@mucse.com>
 <20251029192135.0bada779@kernel.org>
 <24FCCB72DBB477C9+20251030023838.GA2730@nic-Precision-5820-Tower>
 <20251030081640.694aff44@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030081640.694aff44@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NwIS3Zdzte8wjKFJMFA0f9Isi6DjkHtC5oOp5rX8aArbGCGn7TA0PTab
	l1Ljjvr74YSAoZCGPO3FXhzsqt/BR93Zd2YzcnMuG82ziaS30L/piB2kHHugjz2AMpYAwEe
	zWcCSPOYn1nGtjjYNm8Iby6XCrOBwFLD8YUXgw5HKqgzr38zNVCFOUYZfixClUKnuuEybQy
	Pha4UbDuhnOTeaw8d5JilhiZbaZPBwZoWQubEtfmAlBnwWgkC4aBD0DRFupFrd0WtwKZ/K/
	BLPDs1q4U3ZFYjpdtBxKtw4z27zwmqbLQxCVZPk/z9pZDJjDf4I1uhmmwoAMvMhi57ala7H
	i+6Azlp+UkQgzc78o4ZHBaRktU3sHt19MvziYRjlI33hh1GQAQHp3iIkTMe9Wrh3y4xG8FQ
	LWd5kM9fI0U9o+J1obuy17qGfz0uh9q9L/RRRjfg8zAGBuveRMKOQ+Tbzjh5c9Q9ei3/vkO
	yJFq8YrwS2FCMqbM59FvMN9VyTUVYj1zgSFoWljAkMZarZL3L1u2zSqC0RZhnlYJ4l1K6BC
	ikqFi0Lq+WTcawCLZLCGR5DEXtISINcYj9msEud5kFOveW/qH1J2RHLQcnmI9s4UrDmlB+T
	Ki54CbmeE/AUfGzffZkNxmP7X2/39ridYSLiIAsOe9uoGWdOAnTu4rl0oV//ZkS6PwIkjTV
	BDr56pBPoxqeq6/7JExePr6ha9882BE+7gghjOwnjbQci5b1yXAUK/Ymb5OlABJVWYJxVTi
	ivw82515lTSFoQ2oSHH5kB1SGd4W4N4iX8+Ky1nuEf2yN0RY4/OllvfD7Yf+NkT5Dajxv8A
	Y8Eru51dw/fQbq7VtTXdU2gpc+xslqJlxY7BjIbG66vYA097iAyWvwUtzIhPxLMt5/eUhCu
	Y5G2JyVIER92HsVKTqGQfoYek0RIpoy9q9eyJW/1zX3IHA2vfalB/MxfX0nURXeUkliNyAP
	erKBjxsNsnIyh1hPftZMRAbhSNoYDt2KjHCohFsLY5OAyWaGcVKLQF7+J
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Thu, Oct 30, 2025 at 08:16:40AM -0700, Jakub Kicinski wrote:
> On Thu, 30 Oct 2025 10:38:38 +0800 Yibo Dong wrote:
> > > >  #include <linux/types.h>
> > > >  #include <linux/mutex.h>
> > > > +#include <linux/netdevice.h>  
> > > 
> > > Why do you need to include netdevice.h here now?
> > > This patch doesn't add anything that'd need it to the header.
> > >   
> > 
> > It is for 'u8 perm_addr[ETH_ALEN];'
> > Maybe I should just "#include <linux/if_ether.h>" for this patch. 
> 
> I see, that's fine. Then again, I'm not sure why you store the perm
> addr in the struct in the first place. It's already stored in netdevice.
> 

I get 'mac_addr' from fw, and store it to hw->perm_addr 'before'
registe netdev (rnpgbe_get_permanent_mac in rnpgbe_chip.c).
You mean I can use a local variable to store mac_addr from fw,
and then use it to registe netdev?

Maybe like this?
int rnpgbe_get_permanent_mac(struct mucse_hw *hw, u8 *perm_addr)
...
	u8 perm_addr[ETH_ALEN]
...
	err = rnpgbe_get_permanent_mac(hw, perm_addr);
	if (!err) {
		eth_hw_addr_set(netdev, perm_addr);
	} else if (err == -EINVAL) {
		dev_warn(&pdev->dev, "Using random MAC\n");
		eth_hw_addr_random(netdev);
	} else if (err) {
		dev_err(&pdev->dev, "get perm_addr failed %d\n", err);
		goto err_powerdown;
	}
...

Thanks for you feedback.

