Return-Path: <netdev+bounces-213935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62182B2761C
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E187D1688C0
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BE29A333;
	Fri, 15 Aug 2025 02:38:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8512853ED
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 02:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755225530; cv=none; b=chPbEHEjEcr82gW9l3ng9JWXk0/CaCoN2GYf9qtQ6CtC4kJlOKKE8Vz1T8sPWRjtJc5leI9W+7uGyApbhr91r7Fv2MJJRHe+l97SwzsqV9VFINO8svweszPpAuRPUiDYb+QBxsIENGqbJLZhsRwz2Nzt+326yL10IReXOqn30xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755225530; c=relaxed/simple;
	bh=u8I2X25WR4fgpDkMDlFyC0T3LW3CMF15mu1UZnKTUlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EnqBkXnSc0Eo8esD2dQSJncRr2A/Ezb3zzHzkbVCpDrxiW68ERU6DyvtsB6EIREbaxAGjpELr10wbKGc9kN1WC5a3oSqe0hahKZpshWbcM3GeRt6Dc/mW+MUOqjNJBbCZ23LPo7Bp1iYjyRAE8wyhoSqcmiyI928LOx6NOJ98i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz11t1755225519t45fc5bba
X-QQ-Originating-IP: yq0E6dA0Nd3VzJJptiSQmJVFvn7q1TzIAMReu6KVsPY=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 Aug 2025 10:38:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5342344533602567481
Date: Fri, 15 Aug 2025 10:38:36 +0800
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
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <F74E98A5E4BF5DA4+20250815023836.GB1137415@nic-Precision-5820-Tower>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
 <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NLbMVdkrQWBMtIqEMzgSMus60YNAsMGotI7XM8bDGf4njJ1iiPnS7zus
	o4yVLwntdtEomeil0aQbD0SSQEMlRQT8pfm9y/+l3n5nS79r5KcXBz0wiqU8dSCh5FI7LlI
	iwlvsxqnUO4gvfh+tpAO3cNcGk3MistYKt4GZ3/Ac+9HTsE71UhuQUD1Qb4YA+O123vh+IR
	wV1UOkyQc4K2HZE4PlSsmGEUFNkAOGy2FgcKL/IwguMV9VCrvczP3YxW46quK1rF24hNIh3
	OukP/wqB3pY0cIP8RPfUY3JIjuH4RhGqZts/ohBdpdeXc/AAJJ6nbB6UhLkZWcXuBUTWDT5
	ZNRz3hO+PZ+TGmY3pIHFgeISZ8+/0mwKtBE+E0fi/Uih6s2AzsxiQAKphN4b+cy/9SsHJ+J
	9/RswobULmV0QgejBLmmia3oDhsOIhb+l/TVGDP7Cf6M33uILSZKYAVql42VQxMS8bZ8JLZ
	e9k7HF+lQ2zbtxbLyEH1wKnWs9q08XVtpTx1utv30nO6SWDfio6YsHY+HqGRVkMfJkTsNhs
	fO44Oq3gZlQCDxBSqtrcaoEPcrDTrZtUxRBI2k371UGi1r2gNkwLh/FARpi+zygUi5zI+0R
	zH6J3J1RYwumSavVP43QpsvJuT9W8W3F7CkPSM34HisPpTE6U4j46ZH6RUGzOK7YMXhUSWs
	oDWS456P3grX0JC1gd4xyM45hqqTGg2gCg4rVcQwhNpANfYiOFzeSNJQEZOHI2Xra6/Jrxk
	wLxuMMycTM5WLcCX8eQcH9rOeCDopcZKWg7dd4SXs2fSLGhYXIio2NlUFjqwt5ZhZK2IAay
	bt3powASL7EO/U4LTV5RMSIZsnuGzaZGCGYTd/IQreU4YTw+PpHayolsxA12svxymMcy6lr
	JF77USwgGpLx18cQlbpzNoxxLyHEYKlUruxErYrrfVrYYG70aZ4D2lceoBVIIqCoBAWQycy
	gBoMNBfuLEIl6GuvS0sHAoZk48ccoHVC3zzse9lMc+83e40lH9UXE+u2ENEUndw8/ZlCTNE
	kbx/+hButuZxBJVhwD7VRNegOLS9W3ZlQrD8qLUxR4dQTqpewYq8FgBjtrYz+Z1csfRxd0C
	Tdh7YYLbPQ+bIIvjyshDCDKEA6tyJFPIw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

On Fri, Aug 15, 2025 at 04:05:32AM +0200, Andrew Lunn wrote:
> > +	hw->driver_version = 0x0002040f;
> 
> What does this mean? It is not used anywhere. Such values are usually
> useless, because they never change, where as the kernel around the
> driver changes all the time, and it is the combination of the driver
> and the kernel which matters.
> 
>     Andrew
> 
> ---
> pw-bot: cr
> 

It means driver version 0.2.4.16.
I used it in 'mucse_mbx_ifinsmod'(patch4, I will move this to that patch),
to echo 'driver version' to FW. FW reply different command for different driver.

Thanks for your feedback.



