Return-Path: <netdev+bounces-225774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF508B98185
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 04:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864A816AD92
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 02:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95C8220694;
	Wed, 24 Sep 2025 02:51:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA35B1F91D6;
	Wed, 24 Sep 2025 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758682298; cv=none; b=iBx7VBhesJOOGPLjYD2myJ6RWAkMGkfZhsDM9PWQkajXKcy1IymLPgAPXCLWVEpkGpF/2XwrUabto2TMuyxu1+w5O08nVKTNQUNLYUzAOn55q9IEt8wgkNfnnA/LqUPv3TxToy5bZlbWSN7onmPc31pGgmLr1rruIhEBfLmjPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758682298; c=relaxed/simple;
	bh=3oLB6vCE1DfzkqZf/vAwDz1ydYPw5Afe+K3kLP/dAMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGUQyvF5HmSAem38ABWnX07lR4nTlP5DV5ugG6vfVkGYkxgL+EUYTCqmuHbzmNf6/7WNjw5eYyyhjeh1FKHKdTZczosw9CYKsVwgF4nf7G/FPdKNCOvOb8Igop6uEkNy3nIh3jUaC21HCyZECj8LAA37q2gtL07zrH2KzN2r5j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz16t1758682260t98e3d42d
X-QQ-Originating-IP: AbOZ0NN9SNEvHEDbZxb+4svvgPghtDBuBPNPgeZ/T+s=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Sep 2025 10:50:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13274150697629646599
Date: Wed, 24 Sep 2025 10:50:58 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com, kees@kernel.org,
	gustavoars@kernel.org, rdunlap@infradead.org,
	vadim.fedorenko@linux.dev, joerg@jo-so.de, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v13 5/5] net: rnpgbe: Add register_netdev
Message-ID: <CB1199BE018DD3DE+20250924025058.GB292859@nic-Precision-5820-Tower>
References: <20250922014111.225155-1-dong100@mucse.com>
 <20250922014111.225155-6-dong100@mucse.com>
 <20250923181639.6755cca4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923181639.6755cca4@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MijavZDuOhz7yv5Z4Dt2sQhXQGPZTdV+gAL8akzkl3xjzXPLE2Wy2kSp
	0FVeTaKqOSaY+ZJzuH20boS+NF6eU8UQFVTOWDtuhJ1dwPDfszYEF1/S1Q7cDUZ7WzkYTys
	kdH0y9rLTTl+rlqr5QJiLdKzRxaQBHVVc5eC4y03mOjdyruSwstc0DCxbozwLSVTHeWiIug
	KlSEoPKBbICUCMtIPlL+9o243BmbQwFxJiTx+7h8sL2ZlyWlrY27/RfhNWMYwPXf2eLABcx
	aU12xH/giU/1wWWA9rF3rmPXs8FKW+BQ9hl/PNxjv5EhMyj8Jjzc45FqIasx6XeUGggbKDo
	VbO/8bM5o53x9ZHu1igyQI87YbDkmgyRmXB9lUx0n/bKpK3ge2tmRiBE4S0tDiCTk/ALxPV
	atfZ2PMG0nkCQo8h9nm/v+iT9mz/TlheRWN2+7O6rPrUr4zi0ZyjtC80oJo0tYO4U/J/PIw
	w5RQ1DjpEuk90UHnRy0AVVJWkV8xhNyMidY9mSpNG6DZOTx7s8VrecBTLGfXtzS82/Ey2Jl
	oW9nxga43B6PDps4lYy2Lh9PHj8lm7pJ2AQNcY9x9c+Pjsr2aON/9a7mDfsNRuNc/su7HcJ
	0OqhvLuH0OBjwOF10g4t+pVgvh98VnTiPpwu799Xv1whIpyubRSetkN+vgLCxIoafqjE4uM
	xtcjKZ3/4dspAAqxbGv0YYKkXJ6NZWOM6UFMngnGDKg8AtZJRPl/Sw+VNP48de7NdpmQKJk
	2tT6bXRDbTTJ4Zmhg5GVxgQWAGvRWZLy4PbJMT3Muu8tTuB5pOeXg1LSz8kj5bKy4Zllm/f
	0gAQBkhwuYqu4j7ITo7l4APBgWWW9S36vs7e7tgIkIjsXnZ9mV7TJ4B8OSgOitit5nYrbhd
	wtRwbjuI6hJi8Mbm0pvMYrEJufgy6whJLQw8RNSq4x1H6AX/TsJcnBN1TA9oejHTurXmDQa
	NkRm4HsJoF9sZmPEW8ffXnfH3eqUGm2zXnKa09ccoR3VC1Wcekv3BpytJjFckigHfBDUD2P
	jBg2HcGC243mkvBlSgNfGghfvA2mf5Wdw7GoYnauXq6AZRO49e
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Hi, Jakub:

On Tue, Sep 23, 2025 at 06:16:39PM -0700, Jakub Kicinski wrote:
> On Mon, 22 Sep 2025 09:41:11 +0800 Dong Yibo wrote:
> > +static const struct mucse_hw_operations rnpgbe_hw_ops = {
> > +	.reset_hw = rnpgbe_reset,
> > +	.get_perm_mac = rnpgbe_get_permanent_mac,
> > +	.mbx_send_notify = rnpgbe_mbx_send_notify,
> 
> Please don't add abstraction layers, you only have one set of ops right
> now call them directly. The abstractions layers make the code harder to
> follow.
> 

Ok, remove abstraction layers in this series. I will add abstraction
layers when adding more sets of ops.

> > +static netdev_tx_t rnpgbe_xmit_frame(struct sk_buff *skb,
> > +				     struct net_device *netdev)
> > +{
> > +	dev_kfree_skb_any(skb);
> > +	netdev->stats.tx_dropped++;
> 
> Please add your own stats, the stats in struct net_device
> are deprecated and should not be used by new drivers.
> 

Got it, I will fix this.

> >  	err = rnpgbe_init_hw(hw, board_type);
> >  	if (err) {
> >  		dev_err(&pdev->dev, "Init hw err %d\n", err);
> >  		goto err_free_net;
> >  	}
> > +	/* Step 1: Send power-up notification to firmware (no response expected)
> > +	 * This informs firmware to initialize hardware power state, but
> > +	 * firmware only acknowledges receipt without returning data. Must be
> > +	 * done before synchronization as firmware may be in low-power idle
> > +	 * state initially.
> > +	 */
> > +	err = hw->ops->mbx_send_notify(hw, true, mucse_fw_powerup);
> > +	if (err) {
> 
> Don't you have to power it down on errors later in this function?

I will add an lable err_powerdown to handle errors later in this function.

err_powerdown:
         /* notify powerdown only powerup ok */
         if (!err_notify) {
                 err_notify = rnpgbe_send_notify(hw, false, mucse_fw_powerup);
                 if (err_notify)
                         dev_warn(&pdev->dev, "Send powerdown to hw failed %d\n",
                                  err_notify);
         }

> -- 
> pw-bot: cr
> 

thanks for your feedback.


