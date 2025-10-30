Return-Path: <netdev+bounces-234253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A6FC1E252
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE05D1898FCF
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790D12D8799;
	Thu, 30 Oct 2025 02:39:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13C2312831;
	Thu, 30 Oct 2025 02:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761791947; cv=none; b=cdhSHu0EX/VtJxIjQXaYEI/+asaNDTexuPBlaKUaYY5b/so6E7HiT2A+puTdUNGU7vZJRjFUh/usjgJQ7mDoWRTfDLgttzPJEyMAkBrzj5Aak+/Igt6ujzBM23UWZU3SIlYGNtL11vDvK+pQc2SE66QERAUWP6OVAA7B+h039ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761791947; c=relaxed/simple;
	bh=oVuDDtd2axgUAxAvrFHqDWkmcssDCdZXA7wQLCd59Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJUuUe0nxMI73mmfiFqtgp599w0JVkHTVJjSiB5pyafEuQSj/tWHAHPwsUcZuIjaMSnViWIKppoBPF6AUbtu44Dr2vZR2DhftiLyd7XNc25rT+mOKAHg9H5zbjqJA8REtuOhmwhUzSoyHJQ0nyolNzPntAQRsDotwZMJw60Y9Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz9t1761791920t005c51d5
X-QQ-Originating-IP: T/SMG0nGFujjspmfsnQihJ7vhqT5qQQsRFsuL9HLjaE=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 30 Oct 2025 10:38:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12961766081760271054
Date: Thu, 30 Oct 2025 10:38:38 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch,
	danishanwar@ti.com, vadim.fedorenko@linux.dev,
	geert+renesas@glider.be, mpe@ellerman.id.au, lorenzo@kernel.org,
	lukas.bulwahn@redhat.com, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v16 5/5] net: rnpgbe: Add register_netdev
Message-ID: <24FCCB72DBB477C9+20251030023838.GA2730@nic-Precision-5820-Tower>
References: <20251027032905.94147-1-dong100@mucse.com>
 <20251027032905.94147-6-dong100@mucse.com>
 <20251029192135.0bada779@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029192135.0bada779@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: N4K5tpF4eYNGoRPrZZmogRHETnCl6d+ahF3h3K0uKRVzDtfguNLztKLF
	1f+0Bbah+dBjmkpGKdhUszw+HPyzkRlUJZ6CixIxW+ceapun62rt8XQ0P9w+RDG1T0Jd3Ir
	xBd4mgPEH2CxY0jrt/rZJENSE2AYPJLCkWczfCmvSpP/5MSbbEU2A+lz50JD7jCLMV3P6Jf
	jvsunXOwZW6K1KBRYIP+3QZmUhvLnIfzxSQYtopow9CBt/9dfAfUVMBwMITGcQfZuFU2o/M
	uptsMv6bEfjFR5yQKeEL7NJ6HTb6cxTlSyHRl7TYvTCkEtlvh2qn+vuHndUuigRb6SKJZy5
	hEeXA9gtTipxQ2BXTR8Uad2LfBKCQ9LmwGBA3FPQ/k1rrKHquK9lpYmnEXb9JcDap0KVHqO
	2mlzzRyXXNsNhO0jsBS3/CXPWwjVJNejc76DsyeP2AQwQAbQD5wM5vCWEPJtdixS+GHVcvj
	2vKEgyhGNrsnbqCtaC5qbieegPwjM8U1jb5/jmmxVpWbKfKyN0MpCtyc1u0Yx6me5/V3IUq
	d8fPJJvaOtrB2lXX1nGeS3xTZewsUzgXfYuu3/4Kvrm5GHsowfe3O5uEAthMFkvkImnIkVq
	6lnSyZA0SRJHMabrf+myiy9mhdPNHYFkl9LYpJKJ3c7KlPJhWh0wqgJfTU5ZC8XdrSDVwp8
	OiBltDLTd8JCkptpZFo3W3eQYUwvGUP437VZ0slEOD4YwPxObsQ4d1VwKuZOrfinPkeGHZ7
	W9gwZZ4e47aTpunoVRsOgJC1NyYamZ/qvmRI2PT9yuJ9Bie/5L6OyPTIeZaOTvGqm8Ki9Tj
	5EaOERpuY4wfNYBYlkzQcsWx5efQHyQoEEh0/Rf7qyYOUgSUB4xcvQLiV3UUo2FBMVFMB3v
	hLOhvAN5o0J/aOUhpEP28t2+C7/aDqxbCGhC8dfD7hZRfFU+hUg//8q8ouw55KZe6uYkbCM
	+TgtNUbcJgFFPKk39S7zPy2wpvE5JxkjNMljNBcoRK2yEGePZtjZiJ0tUhitbvxAMqJl2O3
	0qLUlHFMTp5LHvh2mO1dfKYMvXb4z8HKdGiadG/g==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Wed, Oct 29, 2025 at 07:21:35PM -0700, Jakub Kicinski wrote:
> On Mon, 27 Oct 2025 11:29:05 +0800 Dong Yibo wrote:
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > index 37bd9278beaa..27fb080c0e37 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
> > @@ -6,6 +6,7 @@
> >  
> >  #include <linux/types.h>
> >  #include <linux/mutex.h>
> > +#include <linux/netdevice.h>
> 
> Why do you need to include netdevice.h here now?
> This patch doesn't add anything that'd need it to the header.
> 

It is for 'u8 perm_addr[ETH_ALEN];'
Maybe I should just "#include <linux/if_ether.h>" for this patch. 

> >  enum rnpgbe_boards {
> >  	board_n500,
> > @@ -26,18 +27,38 @@ struct mucse_mbx_info {
> >  	u32 fwpf_ctrl_base;
> >  };
> >  
> > +/* Enum for firmware notification modes,
> > + * more modes (e.g., portup, link_report) will be added in future
> > + **/
> > +enum {
> > +	mucse_fw_powerup,
> > +};
> 
> > +	err = rnpgbe_get_permanent_mac(hw);
> > +	if (err == -EINVAL) {
> > +		dev_warn(&pdev->dev, "Using random MAC\n");
> > +		eth_random_addr(hw->perm_addr);
> > +	} else if (err) {
> > +		dev_err(&pdev->dev, "get perm_addr failed %d\n", err);
> > +		goto err_powerdown;
> > +	}
> > +
> > +	eth_hw_addr_set(netdev, hw->perm_addr);
> 
> This is wrong, you may have gotten random address. This will make it
> look like a real permanent address. Should be:
> 
> 	err = rnpgbe_get_permanent_mac(hw);
> 	if (!err) {
> 		eth_hw_addr_set(netdev, hw->perm_addr);
> 	} else if (err == -EINVAL) {
> 		dev_warn(&pdev->dev, "Using random MAC\n");
> 		eth_hw_addr_random(netdev);
> 		ether_addr_copy(hw->perm_addr, dev->dev_addr);
> 	} else if (err) {
> 		dev_err(&pdev->dev, "get perm_addr failed %d\n", err);
> 		goto err_powerdown;
> 	}
> 

You are right. I will fix this in next version, thanks.


