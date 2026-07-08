Return-Path: <netdev+bounces-305943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BP8VFsCVTmqmPwIAu9opvQ
	(envelope-from <netdev+bounces-305943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:24:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F1472977F
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:23:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=C75rrJ7M;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=C75rrJ7M;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305943-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305943-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C9B7301AD0C
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E961370AD0;
	Wed,  8 Jul 2026 18:23:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2668B2EE611;
	Wed,  8 Jul 2026 18:23:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535036; cv=none; b=aocc07xagnkHBY60jwqjECp4XSnNWtfbHPjIUqMPdr4rx+I5Gx87xrQ38EQWowzXWaM1pGZZlvQ1P6Xdn2fyt8B+6jEVG338RIAGDXQdT6XnIrww304h9m+6pkFfhcZI6ei/LCFVqQq0mC95S5rfhQGmSNzndRMA9wDigh5PIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535036; c=relaxed/simple;
	bh=UjvPnASu5upV/9hhU9RhcqgiAafvLZRAB5sAjfhlb+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBgFt6u7ew0qPjy04rFiY4cvkJtl7fsjXJjpN0CBoR7YaZE7zxriZxJLVo+kSZrS3V/pi0GiGQsCFfSTE/Liy3aRKp+FcsCRxTsOvxxz/HFPPE6nkHH9ZL7hZ/+FmKiKWGs8wXXPrflemOooIk5Q0Ec7BWrHGCH8oAJi8nk3ebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=C75rrJ7M; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=C75rrJ7M; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535026;
	bh=UjvPnASu5upV/9hhU9RhcqgiAafvLZRAB5sAjfhlb+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C75rrJ7Miy16ufKnErVeTb495zAgkEi5t6yfCFWh9mJnCmOK0uvWLK9jLtB1WocDl
	 VY7O5IHqmfvcD0tdDpYJ6ZNsV/09uBZfSCIvGa0zebAnNh2DZz6bo5nkda79UPUFpb
	 CMn4frSbvhr0hpSg30JTGNH3m8z1wzeZKtllXslgaKHfAMtrsstalnnEV2L7EDX9Lm
	 tPIGnVPFYbAPdnrPasNEEcViiMVkiAMPImic7i2Mqru1h5bps5gWjU9GGQbd9ew2Qj
	 FCU1EK0ohndXOi+u5V5aFV26W3uBonZ4Reb3uhYAVDeHx5ZwQmS8pgl7rNamsKYQhj
	 JGuFvSGfB/ISQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id CFC89493F1; Wed,  8 Jul 2026 18:23:46 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783535026;
	bh=UjvPnASu5upV/9hhU9RhcqgiAafvLZRAB5sAjfhlb+w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=C75rrJ7Miy16ufKnErVeTb495zAgkEi5t6yfCFWh9mJnCmOK0uvWLK9jLtB1WocDl
	 VY7O5IHqmfvcD0tdDpYJ6ZNsV/09uBZfSCIvGa0zebAnNh2DZz6bo5nkda79UPUFpb
	 CMn4frSbvhr0hpSg30JTGNH3m8z1wzeZKtllXslgaKHfAMtrsstalnnEV2L7EDX9Lm
	 tPIGnVPFYbAPdnrPasNEEcViiMVkiAMPImic7i2Mqru1h5bps5gWjU9GGQbd9ew2Qj
	 FCU1EK0ohndXOi+u5V5aFV26W3uBonZ4Reb3uhYAVDeHx5ZwQmS8pgl7rNamsKYQhj
	 JGuFvSGfB/ISQ==
Received: from [IPV6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd] (p200300c69f1c3c00b7612fd38ae89dbd.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:b761:2fd3:8ae8:9dbd])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C84C1493D0;
	Wed,  8 Jul 2026 18:23:45 +0000 (UTC)
Message-ID: <1a53dc94-88f9-4ee7-a707-63a6bbb41e5c@birger-koblitz.de>
Date: Wed, 8 Jul 2026 20:23:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] ax88179_178a: Fix endianness of pause watermark
 register
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260701-ax88179a-v1-0-13685df67515@birger-koblitz.de>
 <20260701-ax88179a-v1-1-13685df67515@birger-koblitz.de>
 <b43415e2-9248-4578-a19b-d1766dcc34fa@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <b43415e2-9248-4578-a19b-d1766dcc34fa@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305943-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99F1472977F

Thanks for reviewing this Andrew!

On 7/1/26 16:57, Andrew Lunn wrote:
> On Wed, Jul 01, 2026 at 07:42:47AM +0200, Birger Koblitz wrote:
>> The 16-bit pause watermark register is little endian as
>> described in the ASIX 4.1.0 out-of-tree driver. Correct the
>> register byte sequence but also swap the configuration values
>> used in the code in order to keep the current behaviour.
>>
>> The endianness is relevant for 16-bit writes to the register.
> 
> Is this a Fix which should be back ported in stable?

No. The behaviour of the code does not change, this merely
assigns correct names to registers, which is only interesting
for new code, which will be based on the latest Linux code.

Birger

