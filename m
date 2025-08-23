Return-Path: <netdev+bounces-216187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820D9B3265E
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 04:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C223AC0CE3
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 02:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007051F0E25;
	Sat, 23 Aug 2025 02:03:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FD32C190;
	Sat, 23 Aug 2025 02:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755914602; cv=none; b=lghXfRUJ0LPfrrxTjPwrc/XdGrn3HQJo78GfPShKkohP1DE6ns7f8Si0nCT/Dk6guWvfdtPcsSezSttHOI5u0+DpK5q98dCqB2vhD60F8boWhRf7aYiBloYxDixyKKAxxse/O9qj4wiRrasj/VvXZQ7cSPvVhm1N3w1yXZs6/J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755914602; c=relaxed/simple;
	bh=bBbzWA/lXi8mRYNfOXPInP3IDahU4cbSMWnmG/NhFP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUE53bHuk/UWI1TKedbGwGjlki09UBz/zjVQvdJTHFn2bSCfVS1GeDo8Egx0zNWd2z6NgMhiEI0AfCLfFMKa6Ras+CB5tqoJFGnpguZpSVNxxqMmgJDC11DJoU4AeS7znfQH3lAXRpRXMVORYove6Io0FFNTcjNXMmMaPMsRRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz6t1755914584taf0414ac
X-QQ-Originating-IP: XQMkFPTld5aopUszAMtCZgJqYkOo5w3DSNONEnbYVFI=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 23 Aug 2025 10:03:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18037205199112697214
Date: Sat, 23 Aug 2025 10:03:02 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Parthiban.Veerasooran@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
	gur.stavi@huawei.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
	danishanwar@ti.com, lee@trager.us, gongfan1@huawei.com,
	lorenzo@kernel.org, geert+renesas@glider.be,
	lukas.bulwahn@redhat.com, alexanderduyck@fb.com,
	richardcochran@gmail.com, kees@kernel.org, gustavoars@kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v7 4/5] net: rnpgbe: Add basic mbx_fw support
Message-ID: <1F30CBDD95FCBE06+20250823020302.GC1995939@nic-Precision-5820-Tower>
References: <20250822023453.1910972-1-dong100@mucse.com>
 <20250822023453.1910972-5-dong100@mucse.com>
 <9fc58eb7-e3d8-4593-9d62-82ec40d4c7d2@microchip.com>
 <7D780BA46B65623F+20250822053740.GC1931582@nic-Precision-5820-Tower>
 <8fc334ac-cef8-447b-8a5b-9aa899e0d457@microchip.com>
 <A1F3F9E0764A4308+20250822065132.GA1942990@nic-Precision-5820-Tower>
 <b488b893-389f-4c20-b2c3-23071279272c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b488b893-389f-4c20-b2c3-23071279272c@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M4B45z97fsbxfp6War9HhAiOAlD1ajijGbjCp4iYKrkcelqILvtBpOsv
	F7+KA3a0ajs4JULHGlQSRrwbkOed5Txpe2KhwbiVeJF9YZvqtF21tf+KEc/ePfn7PVhciLY
	qAaTaSB22ffC3i+B8DUm+OCKTGLMaMonnv6uXOHvGgtYjTvCpYRx/tUFonmqj1IQSU1lLfC
	zZaF2BP7Ibu6zpOhXj67PZY++0LvHAHeRmDDq9FyFhSJphROhYpPw2PvVSSRWr4nYbEvLPX
	Teok7gB/WzozPHHNJsH2xNviLG+xXn64INL5XPNfSkvyMBLGcKDqQ/5w4wkCq97AimDM3Yk
	xpWC0tbx9cK02zdLVDbKnFWNpqCDtXbYHa2QWIwmCc+paITq011YOL64+PA9mphwPufr2dI
	2g+Q68uXwI5CtnKoZBjDRW/sk+4pih8/+uhIHkjZszBaxqGFtp7i62FdmdN9Mznzp1QqrMS
	6dw0Ofj3AuJwjQY314T3RBein8koroF7EcDkc7s/n92BylgE+YipMziqwrzoJCPMLZhPzjw
	RspHcDWdm6dBBtJnz3PgbRTHl6mndUbBP5FGL2BiAubSWfsnsVw5gXZK/KPZ48eKTisOp/z
	D1oMthpXhRCZ60SPdtoiP5LIQT3L+jDs6bfe0qPjoowZkH/MbG+pcAR+IQIjcGugcUjeGFn
	GcX9aXTLY3h7950fW1EjyRJj89afHmNmvv/frEGCvh/EpdUJet8h2viQfKQGK4E9fdkLJsZ
	Z8laryYTC761e6dCDuIDT8EwXOzUvDJw3TAcW8RSZZU5A09eojkCvcidmKzK/7t64oDDOf6
	KJX2ysjgVKp7pJwfc4OPGJER+6VZ3EfgK6FeiY0PgmR1sucw3U/DaBYBroeinKqv2UmBHks
	0tMccszajTVqQp4Eay7DJcBvj6xAnV6a+TdmnGnVaatb8CjLrJvwzOvhdLZKuj9LnRkmpV9
	DyQfNBAqOY/ixQGJVP4uh0LBjyD1VjLbyyWybB8OP9OIlDn3uXcJeWyvypvXZDLdvWyBhJj
	3z5lNhxTXQaZt6F7g6mOKqMTRrSuyNGGSkARR4gtWZQv8I/rcstMi6Z+/D0+P7EBofSktfQ
	Sy8BS23LJdsBRBN9z7fRKo=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Aug 22, 2025 at 04:33:54PM +0200, Andrew Lunn wrote:
> > /* Initialized as a defensive measure to handle edge cases
> >  * where try_cnt might be modified
> >  */
> >  int err = -EIO;
> 
> We don't use defensive code in the kernel. Defensive code suggests you
> don't actually know what your driver is doing and you are guessing
> this might happen. You should convince yourself it is
> possible/impossible and write the code as needed.
> 
> 	Andrew
> 

Ok, I will change 'while' to 'do...while" and remove '= -EIO'.
That can guarantee 'mucse_fw_get_capability' run at least once to init
err.

Thanks for your feedback.


