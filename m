Return-Path: <netdev+bounces-216346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E275DB3338C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 03:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43B4172BB5
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 01:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789A313B2A4;
	Mon, 25 Aug 2025 01:31:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68B1CA6F;
	Mon, 25 Aug 2025 01:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756085480; cv=none; b=rxbOaSq5fojt4LbityX7pmO2W6KNUw8brXcl7J8wcmFB40XkE6ruqRyTpsPHuuM/OOmwHs8vf/AvuimVXldoUMFX/oKgFxHpCkJP5kjrOPeoRT+vzZfJfdXT2q0h+gv37kfsTK9++c4iCqtSALewqLRPl0aqbAqBQRV7FrWsIEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756085480; c=relaxed/simple;
	bh=ip4FvYYw88ouWT6itUmL/S531RHQ7rP5ltgGr1KS+qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQB2Z0IjnjURDHzPRCYnN92Xu4mowIUNAXRMXfe1Ga3hjFu6CTwV2myyKZ6sqvnfn/9nlJ9SD3SLfb7mShZ0XNmlK/c4uBxPmuUkYbIObDPR/huz7+0lpEtXd+LYBerDCcWaJ8GV8nPmtfnz/R7eLrtz2FikOckojId6mFj5mWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz10t1756085455t51d7e1a8
X-QQ-Originating-IP: nHucB3JtzMCn34hcRKZD02jofGkp3qyqMaeH0wrqwoo=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 25 Aug 2025 09:30:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11934234295190835703
Date: Mon, 25 Aug 2025 09:30:53 +0800
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
Message-ID: <8989E7A85A9468B0+20250825013053.GA2006401@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <a066746c-2f12-4e70-b63a-7996392a9132@lunn.ch>
 <C2BF8A6A8A79FB29+20250823015824.GB1995939@nic-Precision-5820-Tower>
 <f375e4bf-9b0b-49ca-b83d-addeb49384b8@lunn.ch>
 <424D721323023327+20250824041052.GB2000422@nic-Precision-5820-Tower>
 <809527f7-c838-4582-89cb-6cb9d24963dd@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809527f7-c838-4582-89cb-6cb9d24963dd@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OBUGnm9pFasAiZ6W90wYeKsby/+S0wZ8wiyoTqCKQr2mZNPk/xuvOhnt
	vPAIHQk5tb87rpyR8tBfYmrgCdVLT1kKCtCB/hsps9/XhR/yK1wlC5kFfqXStXS8d5hUHq3
	UgjO1xgNlYbfNTrE/0Irj6zsTut6gGvcxeGp5aNYK5Ml2zdsOhcjYY0uhO4ATMPM5i3mDPP
	RRCc/OcH2vtkfWRsx/T0iOJKTRlfhA+RH5N1JlWDVRRvbkYS+glx7cuFXJM1QOtKFyM+9v/
	NW9axunD9HSRfmndx5E5zmtCyzvxHI7xZCjCOnDENvn//Oku01vlL7Fi62GhHMdtbjTQlUE
	K3YtJLJ47FjbgoEx8fhvAyfyNeIylB7kQcCIuV7WYpy5gCHmAPZVH2QV9Hl5c0jJKA5S5oe
	OzRCHoOpc+f4e+hP3oQ+lE4hOARCrKg4fjxxmQtmouAHfkd1Cb1bmoiTEGKvsyMXuiBMiHq
	do8nkr/O90mZZ7CyKosJlQdmqoKFPpdI++Sqq2X5dLs15tyEXImnO+dnqch0ZP3yn6h+uWT
	enHZ78B0ofJSDCz+D+iz0VJ5GoILj1eilNbEH20kIDamSP2ilJknDst9MkC6eESn19uNweV
	mKaHwYg6OBrtj9uboNgX0S9mr6BLyHM+ZHabZsLBuBmBOsMssCLFAf2owXg7RVO0InrZImK
	8Cu6zKQiKbdf2hVBHjnL0rXWLSpVj8nRryIbVNDgcYh//OGWYAgFkWfRCv6boljH1KMCki5
	tji2SaOwLj/6dX2F0XzgPwUayCVKyHz/+uc+LAbe/qMg87N5Vjlu0auRyajVYY1Dmqd9PNt
	vTu8WyXSZUh/+5ziPT2ACSzMgWhlgDR2tXpf5X6Q4NWzwKV+WyzckmjjUAYBqipM8S9AGI/
	avvy1EZ8fZEXArLXQnz7EPGe4gOd8EuXPxcl30gWDa5wQ5YvMT2Sl7l/ptzwPZscs4Omdjg
	7I25sBT/Ol0dkmkbhppZ5QUgD4O6yvtl3Ys1yROMg+KQQWSnsmJHvL1s7
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

On Sun, Aug 24, 2025 at 05:15:25PM +0200, Andrew Lunn wrote:
> On Sun, Aug 24, 2025 at 12:10:52PM +0800, Yibo Dong wrote:
> > On Sat, Aug 23, 2025 at 05:17:45PM +0200, Andrew Lunn wrote:
> > > On Sat, Aug 23, 2025 at 09:58:24AM +0800, Yibo Dong wrote:
> > > > On Fri, Aug 22, 2025 at 04:43:16PM +0200, Andrew Lunn wrote:
> > > > > > +/**
> > > > > > + * mucse_mbx_get_capability - Get hw abilities from fw
> > > > > > + * @hw: pointer to the HW structure
> > > > > > + *
> > > > > > + * mucse_mbx_get_capability tries to get capabities from
> > > > > > + * hw. Many retrys will do if it is failed.
> > > > > > + *
> > > > > > + * @return: 0 on success, negative on failure
> > > > > > + **/
> > > > > > +int mucse_mbx_get_capability(struct mucse_hw *hw)
> > > > > > +{
> > > > > > +	struct hw_abilities ability = {};
> > > > > > +	int try_cnt = 3;
> > > > > > +	int err = -EIO;
> > > > > > +
> > > > > > +	while (try_cnt--) {
> > > > > > +		err = mucse_fw_get_capability(hw, &ability);
> > > > > > +		if (err)
> > > > > > +			continue;
> > > > > > +		hw->pfvfnum = le16_to_cpu(ability.pfnum) & GENMASK_U16(7, 0);
> > > > > > +		return 0;
> > > > > > +	}
> > > > > > +	return err;
> > > > > > +}
> > > > > 
> > > > > Please could you add an explanation why it would fail? Is this to do
> > > > > with getting the driver and firmware in sync? Maybe you should make
> > > > > this explicit, add a function mucse_mbx_sync() with a comment that
> > > > > this is used once during probe to synchronise communication with the
> > > > > firmware. You can then remove this loop here.
> > > > 
> > > > It is just get some fw capability(or info such as fw version).
> > > > It is failed maybe:
> > > > 1. -EIO: return by mucse_obtain_mbx_lock_pf. The function tries to get
> > > > pf-fw lock(in chip register, not driver), failed when fw hold the lock.
> > > 
> > > If it cannot get the lock, isn't that fatal? You cannot do anything
> > > without the lock.
> > > 
> > > > 2. -ETIMEDOUT: return by mucse_poll_for_xx. Failed when timeout.
> > > > 3. -ETIMEDOUT: return by mucse_fw_send_cmd_wait. Failed when wait
> > > > response timeout.
> > > 
> > > If its dead, its dead. Why would it suddenly start responding?
> > > 
> > > > 4. -EIO: return by mucse_fw_send_cmd_wait. Failed when error_code in
> > > > response.
> > > 
> > > Which should be fatal. No retries necessary.
> > > 
> > > > 5. err return by mutex_lock_interruptible.
> > > 
> > > So you want the user to have to ^C three times?
> > > 
> > > And is mucse_mbx_get_capability() special, or will all interactions
> > > with the firmware have three retries?
> > 
> 
> > It is the first 'cmd with response' from fw when probe. If it failed,
> > return err and nothing else todo (no registe netdev ...). So, we design
> > to give retry for it.
> > fatal with no retry, maybe like this? 
>  
> Quoting myself:
> 
> > > > > Is this to do
> > > > > with getting the driver and firmware in sync? Maybe you should make
> > > > > this explicit, add a function mucse_mbx_sync() with a comment that
> > > > > this is used once during probe to synchronise communication with the
> > > > > firmware. You can then remove this loop here.

'mucse_mbx_get_capability' is used once during probe in fact, and won't be
used anywhere.

> 
> Does the firmware offer a NOP command? Or one to get the firmware
> version?  If you are trying to get the driver and firmware in sync, it
> make sense to use an operation which is low value and won't be used
> anywhere else.
> 
> 	Andrew
> 

No NOP command.. 'mucse_mbx_get_capability' can get the firmware version
and in fact only used in probe, maybe I should rename it to 'mucse_mbx_sync',
and add comment 'only be used once during probe'?
Or keep the name with that comment?

Thanks for your feedback.


