Return-Path: <netdev+bounces-77882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D18873591
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A651F27179
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 11:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875D47F7C7;
	Wed,  6 Mar 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="X8cOGGbd"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA157F7C0
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 11:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724410; cv=none; b=RVpnuHwisgOSiyztxfTme889s1MftJM/NX8SD8roPNthfb90XD0iOwe6WNsbA5IFPwtWdcVCGjGjTadgTBiA9vowOBSjzyfrGfiad0Klr8Cx2OQQNvAVMp5LKzxL7iK1l/f6SdR/q5JhsnnZJ5lCwVgUKrnXApbDwucBsc5HJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724410; c=relaxed/simple;
	bh=HMlyMITJFkzMJY77qP0c4A1Fs/35q1XK1MZEzoc/ZtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BQuUW1MhrO7CiIq1c8G79GuFF7Ha4qNsWcBKBpjn848SFhlQ0zBAVKq5ndyisBZrJJptTH+ryQOuI+bdAUq+lhQGj0bq5pJKsDq0PFmPZZnik9uaXKjO0ZhQZDBG5Qps8WffrxAGelIYusLGC2GMQ/En+8InfZdHB4iAVsV0jj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=X8cOGGbd; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20240306112638d3a2cba792c0a96513
        for <netdev@vger.kernel.org>;
        Wed, 06 Mar 2024 12:26:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=OLMbXckz8O/uXhbuiDWRpfyCRS8JcwaLdYWHgg15Tug=;
 b=X8cOGGbdaa8rVj9V+81QGW7uQV8ZLj+VBqUdsLS+dkdyN+jHx4+D7xw4CCwVE1X5FEZvkq
 JXUMQran5pZEg0CwtTLp4J8bdx9dB/QRlf7fmAKaI96v9dWp3CagIWFmsldSn6P9OxP5Y+Vs
 rXrU6NMmjvwDN5/Xu0RipXAcPf+sI=;
Message-ID: <5cdaee2b-bf1d-4528-8578-b58ee3904095@siemens.com>
Date: Wed, 6 Mar 2024 11:26:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 05/10] net: ti: icssg-prueth: Add
 SR1.0-specific description bits
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: danishanwar@ti.com, rogerq@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 jan.kiszka@siemens.com
References: <20240305114045.388893-1-diogo.ivo@siemens.com>
 <20240305114045.388893-6-diogo.ivo@siemens.com>
 <ZecvKo1HDAXD0n7Q@shell.armlinux.org.uk>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <ZecvKo1HDAXD0n7Q@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

On 3/5/24 14:41, Russell King (Oracle) wrote:
> On Tue, Mar 05, 2024 at 11:40:25AM +0000, Diogo Ivo wrote:
>> +struct emac_tx_ts_response_sr1 {
>> +	u32 lo_ts;
>> +	u32 hi_ts;
>> +	u32 reserved;
>> +	u32 cookie;
>> +};
> 
> In patch 10, this comes from skb->data, so seems to be a packet. Is the
> data dependent on the host endian, or is it always little endian?

Since prueth_rx_mgm_rsp_thread() in patch 10 calls le32_to_cpu() on the data
it gets from skb->data it seems likely that here the data is also __le32 and
these calls should also be added so that we can use u32 data types. I will
add these calls for next version unless there is some insight here that I am
missing.

Best regards,
Diogo

