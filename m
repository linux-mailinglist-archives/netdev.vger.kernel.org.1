Return-Path: <netdev+bounces-213936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5176B2764A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276FF3A5CDE
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A962229AB1E;
	Fri, 15 Aug 2025 02:43:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEB8299944
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 02:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225804; cv=none; b=BSDwx+U2GqiqFGQl8W4l7QZT+jKm5r16maFv7K0CFVf3tl6bP7R70Ok6FYJxVOdWwDlmLT3ndYZaZ8s+n+f9p196aEiwE8AWxZ2P4WgfJXKuRasrBtXuwnHZyNgnY+OmJR03dZMnvrTPraFCgTE4kjTdaLYXuPMT1TMBQas1Dkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225804; c=relaxed/simple;
	bh=C+nv8PjvjRT5VVseg8mFqHqLGLycXA0mcxiRZuNVllA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ob1nULuq/R3MgCloTbp1Kz8aQN042jV35t4Lt3JhWLmWp1ZDEoDcafBGyc+HbkTk3Ec4BuoU+b33AurauilHioATqMyYgSrDg1dMZh7Yt6XP3kgkkKIuwWaNK4VqLX8NEIr4x1pk38VNQ96qgHCjBaQ8fDosScaMSW3+SE4VO2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz9t1755225785t18a98fe0
X-QQ-Originating-IP: qZWec32v0f2IQWBPzJqvPtOzV3dv+pEGwUf5SLtvS68=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 10:43:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2926667803765780674
Date: Fri, 15 Aug 2025 10:43:02 +0800
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
Subject: Re: [PATCH v4 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <497996B7269F1229+20250815024302.GC1137415@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-4-dong100@mucse.com>
 <fa273889-f96e-4ca8-9d19-ff3b226e2e29@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa273889-f96e-4ca8-9d19-ff3b226e2e29@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mw97+KgkkI5qEhTOw7rFeoYvZe7/A2m63i6iVLBblPSJ5Ycv2L/8PP/4
	0hQPGinUJRToPaUKcBsGcPC6NlajsFDaF4n7BftuCluw30+5nO21+SqxXZ8oacPhOO3HL/P
	rAtz+wCkxziBs6xTUw03JkDui8XaT7YRETTh+u+R+wvZ4f9rRMewxyIEcW9QWQ1AtBOKagD
	czdCv8hKIgassb8eS3Q7EPrVEcVZoVZBMK7wNvOmzWPqxIx9VQ4pk8V0nCdyHYtLATTTZ+e
	ax4KdIQfyOzGGMPuzIrV+KS2wqE2pcD14WBy1Tdj3Rjdhd9Ew+VZmcA3dWDIgnY1MHEcvDa
	p1YPysAAopOxaKc43oxdUeUvXGsO508wGIXE1U8H1y46Li2pX4HjIBD2EJ9Hnpd8J7hVSCC
	jaT5uMGonuM4oUgkTC9lF/y7o181M+rMMWO6Yv55jnXTngsnsaLYzvrTYD+LssKbBbJd/hQ
	SXmj/UAhKFzwyZNVBZPy1mQjJILc3QyOrJH4fZQ8uSK+wVypQRpSozXSrB6o3eqwoG94c4E
	ytWBqsRj4VdwlwP3L171k7a1QkvhkC1XbEhCCUkrsIPmfVqiawmXCzqNdaKLZgQna39LDc+
	JDj+WlIbmbpH4+UkWuyGjABGVQYh0ZDKuSal2OQFZIHB+aZNvV3DAELffZEzEDUEkItyhXf
	I7UAN6PZtZJRlXA7Iu7tLIqHHb7QbLyGI3yGa6JITGJv8svBIjhU3zu4NNl5wJq6oowCixK
	Gbl9mSWAQlV1IAuvf2hrhMBFbvO442NNUDqXchgVLsNu93ZL6pmDxf1/m7UCwOu0zHmPR/Z
	b91BMfT1krNJD6wS+okLwo9xUE4ZAUR4OgbtabEshiOhW4SdS+Szap7W5N0VLKqBLaMa2WR
	kuif8DmHL0OsloA75ZIvppOp/nFr/fDWG9Bqw1ppQDTbmJbDEQonC4b94hpeLOIkYLz3w18
	wuFMZMoK3mW0FO4k5ReFD+vqqQJdJa3q+SXz5qA+Wuxs1Ly5NKPyAu1BDVp6F5a9Gog06p2
	mUaQ9HuXjiPuXhi7DBMw7gIGzeoNCALq/Gvwdg4E57zQj0jcq34lWUk+cS1I3gKAkY6JAZQ
	oOIMlPB+9l2p4fO0bayJjY=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 04:13:52AM +0200, Andrew Lunn wrote:
> > +const struct mucse_mbx_operations mucse_mbx_ops_generic = {
> > +	.init_params = mucse_init_mbx_params_pf,
> > +	.read = mucse_read_mbx_pf,
> > +	.write = mucse_write_mbx_pf,
> > +	.read_posted = mucse_read_posted_mbx,
> > +	.write_posted = mucse_write_posted_mbx,
> > +	.check_for_msg = mucse_check_for_msg_pf,
> > +	.check_for_ack = mucse_check_for_ack_pf,
> > +	.configure = mucse_mbx_configure_pf,
> > +};
> 
> As far as i can see, this is the only instance of
> mucse_mbx_operations. Will there be other instances of this structure?
> 
> 	Andrew
> 

Yes, It is the only instance. Not other instances at all.
Is there any improvement?

Thanks for your feedback.


