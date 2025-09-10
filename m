Return-Path: <netdev+bounces-221556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DEAB50D96
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 07:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B0E1C217B1
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 05:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655D82DAFBA;
	Wed, 10 Sep 2025 05:57:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7F2D97BE;
	Wed, 10 Sep 2025 05:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757483821; cv=none; b=PGhu8umwcQ2ncOgiyXm+dtN2+ostAlxX9jz8yUHUyMsvwQnkFfYJcX645M7Ys1qbhCbAtGiUh2baQifPbMEGTpwyZWMoTw7t3H1bOB2XvNfZEGNvmNQLgPSFA+zTyA8zLdbw0ttnYHj3q1JKTsz8sOvrzziSu1tNYjwqozLjvQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757483821; c=relaxed/simple;
	bh=fswMvV2JhjoYkNR/3InHtloxIMbtnBVjmtbkTtfCVto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZa5HP698eMp+fmCpXoZAbLqb1SBYh6ihVf/t8YeQGmcA6ivNr5eUYOLpOUUx6GLYCdh9lzf5r/JwNxtyQojeJjwmnJZ1Pv0FVolmrBNpHYcZk0imzMt5dZ9KqXaFZCjtjpyggUXi9hFSqWLAOzTzjpJq5wNccOjHtXP/jv3h6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz8t1757483799t0123b750
X-QQ-Originating-IP: lyem3Oekvl4MxcDQrc9OHBjV390njzAolyA3bLir5BA=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Sep 2025 13:56:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1762630498417445566
Date: Wed, 10 Sep 2025 13:56:36 +0800
From: Yibo Dong <dong100@mucse.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Anwar, Md Danish" <a0501179@ti.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	horms@kernel.org, corbet@lwn.net, gur.stavi@huawei.com,
	maddy@linux.ibm.com, mpe@ellerman.id.au, danishanwar@ti.com,
	lee@trager.us, gongfan1@huawei.com, lorenzo@kernel.org,
	geert+renesas@glider.be, Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	rdunlap@infradead.org, vadim.fedorenko@linux.dev,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v11 3/5] net: rnpgbe: Add basic mbx ops support
Message-ID: <36DC826EE102DC1F+20250910055636.GA1832711@nic-Precision-5820-Tower>
References: <20250909120906.1781444-1-dong100@mucse.com>
 <20250909120906.1781444-4-dong100@mucse.com>
 <54602bba-3ec1-4cae-b068-e9c215b43773@ti.com>
 <20250909135554.5013bcb0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909135554.5013bcb0@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MmIUUz9KGMMd/33id8JVeJq4ygdv4Fb6TngcYuKqsjh14Un+5IekNnpN
	60vYQPXOKoTvUQe6XjU1StrkgCZajfyctyEl0ae3H8rYB614EDqT2lQfKSIsVzXaohpmDZa
	O3LXrBzQuCImWtOhrf7g8Stv4rr1mkUoCQucfZFnngg471y7QqVpxgmOwdBABVgr911jPOP
	QVeEUGek13yKeTSaJrqHT/JSeUtVnDmWwmrXjfOKVEH+SrjDtTFiVj0pXlOvqqlXp4qXfOr
	8j71uXc+86vN7jnPnKvy7DzdEcZl7Y7s89FBe9I9LgEaSnrVquAlJrbCI/tLAgQEITc29fM
	Pnc65A/cI5c9q0K0eSTbLfyZuUhLq7QTgZMvYjBsH5D38ngKQVmZqRSt6jG+2ezVOOyuRiK
	BW8FrY8lRCQPomsBe9YtqSQMiyV8n6URMcIYwAuVJfp4abkCYP9ob9QHXd7Q+wNBHqwfFcM
	AnYizLTz5Fo4MhcrW0okoYryXOekDNu0os+2naYxnEy3I2PAiXxZRkXtg2Iw+4bxTJkdCVr
	JeKpwhXLyLWbc8NI939eAO++CcYEbZ+4O+k67ApYkgkFTPEZzmRv8lWahgmSrP2JMKUM9eo
	iNFovopPqcZ4Oy/FN/y3uhRpT2orBwaep20IsdMFgEOU9gEMpgoKgLpf37di0jPv5cUo8lq
	Lzyf8ctUWBDhX6eYLEKKw0r1zfDfpz2iCIHkOrTzXKUDgR8+IXl/DsoELpr5wJ1Tn/BMOKQ
	xbUNKBAZukdQCG80Yu952TX6/+pmIzQAlgjk1ehVUvi7krE3kY+9vxEeVVnKOYhFaCGOcu6
	ltQ+7WR+wk7r+yqJcRKzw65BL+FxChF9OSKbatx6+sWk9ttGf5Poy5qKWBr07AuebDjAMji
	dX/4u00kXdHPIQdOJka77KcHKyV+o3p8tpq+Cang5iR4WZs5NY33oRrtAorxs+75EToMHQ/
	LakPmTb1SyaDYqOf2LQL0jAPIDGP9vVYxdofQWmMQ+GlgfLiVMTSv6Oob1Ot3z+R5SrM4XA
	4EsoEibglp7/mUl3pgQ6rbnGXimko=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

On Tue, Sep 09, 2025 at 01:55:54PM -0700, Jakub Kicinski wrote:
> On Tue, 9 Sep 2025 19:52:21 +0530 Anwar, Md Danish wrote:
> > > +	for (i = 0; i < size_in_words; i++)
> > > +		msg[i] = mbx_data_rd32(mbx, MUCSE_MBX_FWPF_SHM + 4 * i);  
> > 
> > The array indexing calculation should use multiplication by sizeof(u32)
> > instead of hardcoded 4.
> 
> Not sure this is really necessary, I'd expect C programmers to intuit 
> that 4 is the number of bytes in u32 here. sizeof(u32) is going to
> overflow 80 char line limit and cause more harm than good.
> 

I found similar code in other drivers, ixgbe, it like this:

#define IXGBE_READ_REG_ARRAY(a, reg, offset) \
                 ixgbe_read_reg((a), (reg) + ((offset) << 2))

         for (i = 0; i < size; i++)
                 msg[i] = IXGBE_READ_REG_ARRAY(hw, IXGBE_PFMBMEM(vf_number), i);

Maybe I should follow that style?

Thanks for your feedback.


