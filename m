Return-Path: <netdev+bounces-269715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPMDAP+CvGkyzwIAu9opvQ
	(envelope-from <netdev+bounces-269715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:13:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F612D3FDF
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 00:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629C230E3C7B
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8A83BED01;
	Thu, 19 Mar 2026 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="reV152Po"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680BA35C1AD
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 23:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773961968; cv=none; b=WPladXO4HH9OCg1Nr7UJNX3aivqlCXtsIBsOEP35zf7qUfoGR+f0yrtulxQQznPHrykI2WdFEZDIY2XuN1hYDZJMH3PR0aS3OO78eO6ynFualizTeKQ/KDPQfQfz3IcspUCNzj5Glwao1WF5qA2VtnOLMUdpKDkpuym3UmplKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773961968; c=relaxed/simple;
	bh=m6iYYB8uKqbPiLGC/QiXT6W+LdvKK9YSo9bsmQ2vh2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZdQyJ88VW0eKkKNcwIOFvULXmmmzuXeciVXEeh0KE7OeopZjaU6lU3A58RxrMwdBjFU3yrXDSdksBaRpih+TcloZgdi1uU2r4MCGaITD21ZaE0dPtvFd1bYBydfsQFEwBVreapSigvrMYsZJMcCfsO2stZn6NXsRW3cQU4/rXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=reV152Po; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 46149 invoked from network); 20 Mar 2026 00:12:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1773961961; bh=qfaK6l9J5wfAPUEJLhkZds3IFOFd/5cFiKFRvHIq0Cs=;
          h=Subject:To:Cc:From;
          b=reV152PoSCm/mRlSQK6ej2CjfufmaljTJAQJBcWg0wfXF7XnpzQDygrM2pTdMdRKP
           dkQsO/Y/ymnNypNlm50VYnJO1V2mXX1kFmJK2vo8yDXckLo5WzzSldrmKqBi/EU2Nl
           ob4MYa/A3DTJtl4D2x/+lPKsdEk/2AWp6KlqrhdIuY5zKjSFV5v7118vK3j0QXBaIL
           6Eq7Irj/D7hyPZa7tKuoN/i4CnelcQxezM74DN+BX3QB/f/NEpXWmplBy6gRAjiiUL
           twa6HC9tjyAVIzt0V/Dtff1pepGIdg+s/b/cXIeXb0nH7g1H0IVjf/d+7LhEpaK1Ou
           FKaZ7xLP8Db5Q==
Received: from 83.5.169.164.ipv4.supernova.orange.pl (HELO [192.168.3.203]) (olek2@wp.pl@[83.5.169.164])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 20 Mar 2026 00:12:41 +0100
Message-ID: <1aa4eb41-c027-4a1a-85f1-fb8846742bfa@wp.pl>
Date: Fri, 20 Mar 2026 00:12:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
To: Andrew Lunn <andrew@lunn.ch>
Cc: Birger Koblitz <mail@birger-koblitz.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
 <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
 <2bfede0e-f8d1-472d-80c4-7c3570b5921e@wp.pl>
 <876af50e-320f-4cec-97c0-a7eb438dc838@lunn.ch>
Content-Language: pl
From: Aleksander Jan Bajkowski <olek2@wp.pl>
In-Reply-To: <876af50e-320f-4cec-97c0-a7eb438dc838@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 2da21c68c29a0e2045ba457eebc21ead
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [ofPs]                               
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269715-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.940];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[wp.pl];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lcsc.com:url,wp.pl:dkim,wp.pl:mid]
X-Rspamd-Queue-Id: 59F612D3FDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andrew,

On 19/03/2026 23:46, Andrew Lunn wrote:
>>> @@ -604,6 +604,7 @@ enum spd_duplex {
>>>    	FORCE_100M_FULL,
>>>    	FORCE_1000M_FULL,
>>>    	NWAY_2500M_FULL,
>>> +	NWAY_5000M_FULL,
>>>    };
>>>    /* OCP_ALDPS_CONFIG */
>>> @@ -725,6 +726,7 @@ enum spd_duplex {
>>>    #define BP4_SUPER_ONLY		0x1578	/* RTL_VER_04 only */
>>>    enum rtl_register_content {
>>> +	_5000bps	= BIT(12),
>> Based on other Realtek chips, I guess that BIT(11_ corresponds to 2500 Mbps
>> over two twisted pairs. Realtek calls this 5G Lite. Similarly, there are
>> 2.5G Lite and 1G Lite, offering 1250 Mbps and 500 Mbps, respectively, over
>> two pairs of wires.
> Oh, that is different. Normally for a -T2 link, you double the clock
> frequency, so you keep the normal bandwidth. But you are saying it
> does 500Base-T2, 1250Base-T2, 2500Base-T2?

It works exactly like you describe. It’s described in the RTL8156B
datasheet[1] if your interested. To be honest, I’ve never used Lite Mode.
I think it’s disabled by default in the driver.

1. https://www.lcsc.com/datasheet/C41376388.pdf

>
> Can it select these modes on its own, if the link partner is another
> Realtek device? Many 1G PHYs will detect if a pair is broken and
> downshift to 100Mbps, which only require two working pairs. But this
> device has the option of downshifting to 500M.
>
> 	Andrew


Best regards,
Aleksander


