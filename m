Return-Path: <netdev+bounces-215468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D459B2EB66
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12DB587613
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7EB170A37;
	Thu, 21 Aug 2025 02:49:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375631C27
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755744578; cv=none; b=VKuMVL8WJRgj3pOuPJ978gckqO/WC9uyLX+/Zp/BlWpckXhEWAeOJunX7rvTORpOOGtllkBUKCnQxsB+uEHZtPq+uGfInKOEV8yI+6gwY11oufjKQ2kEgeEGEH6rqiS6SO0HTsjFSEw/lfUpaFQArcHTSOgl19/OCyEFuS7eKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755744578; c=relaxed/simple;
	bh=PxgeMwMuKv1sf/Jw8hoEPPd+SqpGsYOFkotxhNq7MrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1B73ZIv/Ugwmc/IsNmITzADd9VFEw5Pj98W3T2l2mYPgiPQRj4VLtAgelGG7a5K+K/ld7RVCCdruVJ+xz7MK+Sb6NfDDUi6AScapzTVPtpA7B2hsJ9J803QqGz1fQ1tam1QFRBAjOWhZDvrYOrh8xJnaf56BpuO9QRvy2xNRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz13t1755744557ta3696645
X-QQ-Originating-IP: IRI4JVT8dnqpFasF7EfI29Fv/GrSs4XUrjhwgvGABck=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 10:49:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16182991720817672807
Date: Thu, 21 Aug 2025 10:49:16 +0800
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
Subject: Re: [PATCH v5 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <458C8E59A94CE79B+20250821024916.GF1742451@nic-Precision-5820-Tower>
References: <20250818112856.1446278-1-dong100@mucse.com>
 <20250818112856.1446278-5-dong100@mucse.com>
 <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39262c11-b14f-462f-b9c0-4e7bd1f32f0d@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NwIS3Zdzte8wEYyJNX2vD1t/fxub0ququAGPTwYFt7WAigvIQlMAZbMQ
	Wa7pYUFpB1H+Lk9uF7LmRH2Bvd25vrk3itrBqISHf5IeUQqNgmWdNFsuVfe5v+wXeALV+oM
	ApdJYMDWP17xIVrVw/Z/3yTlhzTrleqbSkNrO1kJ1gU6jfTEs5o4Txe0Mo9LFmQwI1Tq2jb
	eOffFfNmtdVXJhdAA0q4+SrxmTHRh/hcze2C/BySpR8s9RvrKfesa+3DpDcfOEe+w16E+T4
	c184MFjYaK/k0dHPENwYrpzp6h7s1BGmUXO5oJS4RLd1G2s9tjTVpzwKrgDT0iLc9siOeM9
	QNClgvbquv4Pdab/04KMbdmka75W2ecEpOPemOortxlHI6IQXoW+pIexHC1xYZClbCGWJmP
	YgIVN8w2IddH5ho2psQ9V/jZC5XEL8thHb4gi9SEMAn1UZHNC7NwuinJf3AXdBvXroKkHgG
	bVyaxhCalIXxE8tthtzdVtVz94HqeCFUzqNgj09fyIT6u+U1xo5wgFky+PwCPXzFTnSW2dp
	O+43XxrV3Y0ih/6CqTwdw16XHH25UptOOrcJ+K9yb2RGK003ZzjaxmqFGAdSuNvgJGGjWSw
	0N4YGj894XTiKKwSkdV/xNigORygUKpar45w6CFG3dj2lNDBujOv95uDxN71TAsSy4ASk8t
	OdqOTNUott8uQVAR0FFGQ0gu10kJkOD25oomUWKjFtO2cD3o8eMzCKhF8cR40HGFqAj2qfk
	PspplJM95nrivMyZA8+XVmKQ8FQfNIb7R/j/h2bbk5GnEWFL0oFxqiGNHODmNPfYJ8R5dId
	KO7uY9FGocE8O9toB/5D3B8AJud+MoJsw7zvJqJM0guYD+KtMOkcG/02RtnIAfajpys6DZk
	G611Sd72QUDCjs8eZDOkV0p5XObhuZ7uw0DFGtK5+ICmOTBxklUcaN/reGdOHBxNoUs06ie
	UYVULYI4hq/cFnWhOJZq5LRy9ahTeCa+zY17UtwTmbM1JpxCCM1wPHWNi1MtWUCH/+FkJkw
	411PsgsB5Qwr3ChoTAZkFEpyV6fH0=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Wed, Aug 20, 2025 at 10:37:01PM +0200, Andrew Lunn wrote:
> > +static int mucse_mbx_fw_post_req(struct mucse_hw *hw,
> > +				 struct mbx_fw_cmd_req *req,
> > +				 struct mbx_req_cookie *cookie)
> > +{
> > +	int len = le16_to_cpu(req->datalen);
> > +	int err;
> > +
> > +	cookie->errcode = 0;
> > +	cookie->done = 0;
> > +	init_waitqueue_head(&cookie->wait);
> > +	err = mutex_lock_interruptible(&hw->mbx.lock);
> > +	if (err)
> > +		return err;
> > +	err = mucse_write_mbx(hw, (u32 *)req, len);
> > +	if (err)
> > +		goto out;
> > +	err = wait_event_timeout(cookie->wait,
> > +				 cookie->done == 1,
> > +				 cookie->timeout_jiffies);
> > +
> > +	if (!err)
> > +		err = -ETIMEDOUT;
> > +	else
> > +		err = 0;
> > +	if (!err && cookie->errcode)
> > +		err = cookie->errcode;
> > +out:
> > +	mutex_unlock(&hw->mbx.lock);
> > +	return err;
> 
> What is your design with respect to mutex_lock_interruptible() and
> then calling wait_event_timeout() which will ignore signals?
> 
> Is your intention that you can always ^C the driver, and it will clean
> up whatever it was doing and return -EINTR? Such unwinding can be
> tricky and needs careful review. Before i do that, i just want to make
> sure this is your intention, and you yourself have carefully reviewed
> the code.
> 
>    Andrew
> 
> 

'mucse_mbx_fw_post_req' is designed can be called by 'cat /sys/xxx', So I used
xx_interruptible() before.
The design sequence is:
write_mbx with cookie ------> fw ----> dirver_irq_handler(call wake_up)
			|                |
			V                V
	   wait_event_xxxx  ------------------->  free(cookie)

But if ^C just after 'wait_event_interruptible_timeout', cookie will
be free before fw really response, a crash will happen.
cookie pointer is in mbx.req, and fw response with no change.

write_mbx with cookie ------> fw ---------> dirver_irq_handler(call wake_up)
			|                          |
			V                          V
	   wait_event_xxxx  --->  free(cookie)   crash with freed cookie
			     |
			     v
			    ^C

So I use goto retry if -ERESTARTSYS with wait_event_interruptible_timeout.
And it is the same with wait_event_timeout.
If ^C in mutex_lock_interruptible, it is safe return since no write to
fw and no response from fw.

