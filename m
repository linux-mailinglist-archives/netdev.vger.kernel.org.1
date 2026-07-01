Return-Path: <netdev+bounces-303782-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJo6HLhORWqY+QoAu9opvQ
	(envelope-from <netdev+bounces-303782-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:30:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4A16F05CF
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 19:30:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=mjeL1lQN;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=tCmbkKkw;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303782-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303782-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CC97301BA7D
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 17:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7C9380FC8;
	Wed,  1 Jul 2026 17:24:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB5B74C14;
	Wed,  1 Jul 2026 17:24:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926659; cv=none; b=e8hhmebO3Eh472eN2TN8il+6nJaRAwl6MLXj4tKJjN3OVTcRS4XjZ54nbG3PKYlRnD/LhfW/kQUkWDYmeRvVl68I4iWisP3iMN20rtdv+yckHZ8u5tlDrj73E2QIYLA6XwLEBcWHHqrWIDF2sKCE65T7xse/MscU1bpOdq5/0k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926659; c=relaxed/simple;
	bh=DhT1JH+IuIVMbQ14T8guYcrvq8+OOi61J2iolcWJkms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8NtXambYEY65lFfySJDA1vy3EuhpZ3jUjnw4WqGG9yJqeAxeM/pJey/quEg/Q3fVLhvo8mHqOo3dhNRDTo5/5THj1yXAD+/3VdWHWYQv6fh825Htb11hvUExWnwflyGExo3VPco/O3VwkTCjTa3t1+xaay/uW5ullxiiPmg+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=mjeL1lQN; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=tCmbkKkw; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782926656;
	bh=DhT1JH+IuIVMbQ14T8guYcrvq8+OOi61J2iolcWJkms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mjeL1lQNHwCi2mAdrg2Y92XgwUB/tWcBVXMpSW4o2i3IAVVT1S/kUy1izsMj8HrPG
	 CPz7ADk3pQlFag3XrHIl9hPdIru8o+Cs/7fmoe8ZGeOuKEd9IQUxgGJ2vTvLTNSNgI
	 QRdkrJn47pS0WHqXaP8ubsyTM5T3/zZD4qaHMNacoH30Lxnp7cA+OnSFWEpQ9vu2BI
	 j5tsXiUOJgTiCXCN3wS8uyNrD22pO0DezFJoVvVgb8OflnPsYAb9ChvUPcyQjF11PU
	 jlSM/uWF3yyz0gD7sRMQgDyYOP7bcQ8wPJCNWUZ5Tg5+xUFGF+WI/GWeuFtuBc6wB9
	 7ANBVX04SjE7A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 950F249362; Wed,  1 Jul 2026 17:24:16 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1782926654;
	bh=DhT1JH+IuIVMbQ14T8guYcrvq8+OOi61J2iolcWJkms=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tCmbkKkwxsnJu0Ng7lOM/2eKxFrsUsu2LuOMkj1lcqF63/Jo/Yrv13uTgR1HKPqO2
	 7ngvHNd1VLF15tF/WHf9IHMH8NAIcJIqf6ZGFk7WreYw1S9BLF4BAUjg+4ru8xp1fN
	 m6X4iM05hnEX8TkgsJdfss8kDAlrU62o6WfdX76VaCSessZAXxn4h3p3oOAxbRxmKI
	 G9ve0BRHkCgNEwRh5sgnhs22bz70xHNPaPxyjZw+mUDeVTFD3H8719w2MioMGLjHw6
	 NrmG5Sn0Nx8wrxpNyjnYwQVn7XLs/qtZDKkBQlEqnZL8asWONhTlZMgEm3DccPCCzM
	 pNtxbM2UxvRDg==
Received: from [IPV6:2003:c6:9f1c:3c00::1c8] (p200300c69f1c3c0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 597CD49353;
	Wed,  1 Jul 2026 17:24:14 +0000 (UTC)
Message-ID: <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
Date: Wed, 1 Jul 2026 19:24:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8159 firmware
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hsu.chih.kai@realtek.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org, olek2@wp.pl,
 pabeni@redhat.com
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
 <20260701171327.2916132-1-kernel@jfarr.cc>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260701171327.2916132-1-kernel@jfarr.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,realtek.com,kernel.org,vger.kernel.org,wp.pl,redhat.com];
	TAGGED_FROM(0.00)[bounces-303782-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kernel@jfarr.cc,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:olek2@wp.pl,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB4A16F05CF

Hi Jan,

On 7/1/26 19:13, Jan Hendrik Farr wrote:
> Hi Birger,
> 
> it looks like the firmware file rtl_nic/rtl8159-1.fw isn't in linux-firmware yet.
> Could you send it for people to potentially test?
> 
> Jan
> 
The code to create the binary firmware file is at:
https://gitlab.com/koblitz-rtlnic/rtlnic_fw
But I cannot submit the firmware itself to linux-firmware, as the sourcecode from
which the binary data is extracted is published by Realtek under the GPL.
For linux-firmware, a binary distribution license is necessary, which requires
someone from Realtek to license it under their usual firmware license. I
contacted Realtek, but never heard back.

Cheers,
   Birger



