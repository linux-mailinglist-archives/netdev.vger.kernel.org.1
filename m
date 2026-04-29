Return-Path: <netdev+bounces-282432-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAQOMNQq8mlvogEAu9opvQ
	(envelope-from <netdev+bounces-282432-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:59:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CF44975ED
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 788D530704E0
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 15:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4E7382379;
	Wed, 29 Apr 2026 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="NZdxhF0/";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="XXroV8/z"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D80B37EFF4;
	Wed, 29 Apr 2026 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777478286; cv=none; b=jrYhaHmdWwWddCdG+29/CPgWPud1t298RHmFpdNye5lR0A5QlEf6pZu5ZPOfenKmjfgyn9Xgq6K325UcTFJJwwjrzaz2lWElz8DXXJvJmcdq4b8HFxQkMKpDC37zvMFo+l80e0ec2AXZB2CuqdSLFyKbqinKGoO7NuqvKu956js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777478286; c=relaxed/simple;
	bh=PfNXmVfGxA90BsbyUVfnu94ZdIsgKvjsCofoE+mFm9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FyOdqTrOdPXbHfVo2Rnr48/mFdbtfin1RBCaC5aCinWHe8KxWP91Il/uWqJLRZWBkjDdDDXsIklXwGsmJ8z6q8griWAsQVbHM5pfd9lniM/wfIbzwK7QejHHzbexZVBlFkByg4Sv8V3pAjuU1XOy8GNSKrbgHTOTMjVJjXl/qZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=NZdxhF0/; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=XXroV8/z; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777478283;
	bh=PfNXmVfGxA90BsbyUVfnu94ZdIsgKvjsCofoE+mFm9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NZdxhF0/l3bT8CSLK8k7fRcIuzoqGTrRbKdu9sj/+Glz3X04NT+DuYq/eAWzY7s8G
	 RDit3Gp5wYqwNIYLZvC8SBaO1GIBrJoxLnJiO3A+Gi05taDREvf4Ujst7K4RI1akrj
	 +cMCTy9cD0n361BvrYkYLs2ae9Sh+j5In83riQcFdvRU8OFu8GwJLKzGvNVtkX0XTg
	 6FqRORLGmgYJ64X14uHMh/C1yDoD3Bq+zWlvculd2zWEZij3XKdAQ6gYpzcWk1yTrv
	 A6M/u8xFTfZZFWzPe/0wIbHylgvZxnHSZd6uU3J7RToA+jzH6ErSs//u/YywQv0MuW
	 l96w3LSfuBXQw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 1936048196; Wed, 29 Apr 2026 15:58:03 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777478282;
	bh=PfNXmVfGxA90BsbyUVfnu94ZdIsgKvjsCofoE+mFm9g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XXroV8/zZZ5arbMn2W0U7wGTt8DvPNqTEib1xJcMqDbidxAsGvtKsJJeX9t+1/UsG
	 dbQNECnG+s3fBaBQIHpvKdqcZIh7qW8Wt4K1g6Q6kX6DxuIDj3n0GEjr24qt6xd2Yi
	 wWnuNr9uLfEfdhp0QfpIvZMfmFFtxDtO9QbxDEmTGFZ0+PGUK4N89ISp2CQYDf3iDe
	 0kFxMju6zI35QipDWAHiyPebaml/nRLM8DlwKSnkMefFiux8/7WHIN9e4oJKezPD2w
	 arWKT/vCJMVc3NCeUwTgFF4pCVdVfOTLUDUlNRFJwykECxM9mA+lGFMj6huUckY0/E
	 h3V37WTvZwUGw==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 2802947E37;
	Wed, 29 Apr 2026 15:58:02 +0000 (UTC)
Message-ID: <e1c4bffd-47dd-4097-9ff3-f181d21c6999@birger-koblitz.de>
Date: Wed, 29 Apr 2026 17:58:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] r8152: Add firmware upload capability for
 RTL8157/RTL8159
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>
References: <20260428-rtl8159_net_next-v1-0-52d03927b46f@birger-koblitz.de>
 <20260428-rtl8159_net_next-v1-4-52d03927b46f@birger-koblitz.de>
 <d9d69a5a-be6e-4566-9ec3-e742f745a530@lunn.ch>
 <877f67bd-6bd8-4d61-8f7b-d206b9125eda@birger-koblitz.de>
 <376f2907-55c0-416b-8904-e61888feb3cd@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <376f2907-55c0-416b-8904-e61888feb3cd@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 51CF44975ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-282432-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]

On 29/04/2026 3:01 pm, Andrew Lunn wrote:
> On Wed, Apr 29, 2026 at 06:21:58AM +0200, Birger Koblitz wrote:
>> On 29/04/2026 3:57 am, Andrew Lunn wrote:
>>> On Tue, Apr 28, 2026 at 05:47:24AM +0200, Birger Koblitz wrote:
>>>> The RTL8159 requires firmware for its PHY in order to work at
>>>> connection speeds > 5GBit. Add support for uploading firmware for
>>>> the PHYs using the existing rtl8152_apply_firmware() function
>>>> in r8157_hw_phy_cfg() and set up the correct names for the firmware
>>>> files.
> 
>> No, since the RTL8157 (RTL_VER_16) also works in my experiments as expected
>> without this change, i.e. without any updated firmware, or better the
>> possibility to update the firmware. It is only for the RTL8159 where the
>> firmware is necessary to even get 10GBit performance, at least for the
>> link-partners I use for testing. My understanding of the Realtek "firmware"
>> is that it mainly provides updated calibration constants, possibly better
>> calibration routines for interoperability. Unlike for many other drivers,
>> the firmware is not necessary to make the driver work at all.
> 
> O.K. Please could you expand the commit message. Explain why you are
> adding code for RTL_VER_16 as well as RTL_VER_17.
>I will update the commit message accordingly.

Birger

