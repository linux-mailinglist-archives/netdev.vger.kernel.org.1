Return-Path: <netdev+bounces-304330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U0b4Bv4+R2oZUwAAu9opvQ
	(envelope-from <netdev+bounces-304330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 06:47:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 651EE6FE7C1
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 06:47:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=sGQVrFip;
	dkim=pass header.d=birger-koblitz.de header.s=default header.b=sGQVrFip;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304330-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304330-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A0F23012C72
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 04:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4157C3264EA;
	Fri,  3 Jul 2026 04:47:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74F3233E8;
	Fri,  3 Jul 2026 04:47:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783054063; cv=none; b=CrH1PP7zpExB2Jdpklw1iKrhvnYODArH1OHDb+nRWmfHGtTvMfY5CHJ6VES75HzEacWnJI0+2Kfte8y+uBZoM22vhkZf50PttgaOzOiqYrTpSklfov3ha0JXkvLjpJNbgHrdoQGix6JFWUG/7JTeu15DXUt3bOY0buOlzv1G4Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783054063; c=relaxed/simple;
	bh=kt9LCCk1s44Bp5KJST04IwgwK73sg3CMSHFPJ0xPsxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWXIXXWr9xyZzUvXx72LImi0poaa+Hw8zgdMsgDsFCNPy+PNjEL2WYigOhzItMhIQ36OaoDdIhEZmkTLV5iURPoe7D3K7see7Ydf4RE6i3ixFReOAQcZty+YJKKpcp4Z8z84dQdvNxqj41TCYGCS5s/Vjld6uivKbvDoTq/LpAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=sGQVrFip; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=sGQVrFip; arc=none smtp.client-ip=23.88.97.239
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783054042;
	bh=kt9LCCk1s44Bp5KJST04IwgwK73sg3CMSHFPJ0xPsxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sGQVrFiplneSXUNjWiv94bGAIFOr3uBem1HK7pa47ATqCVIM45q9uI5vDMaqEIcT1
	 +czrG6lWIkTAzBcG2vPKNSoFnQtmoeEixEPBU8ThjgvqH6nyX5K7HkrkZX2+kbUu2e
	 9g23UvoylGIjQtFjCjBECFxFyMCPJOaJ2nGmBkdDeNspGJRAKG7azIsdBsVNXqunLl
	 7uWUWYfDyb6Ta1vFy27nEKk8w71fLwGwr0E4JGEbI+UcAkQ0K/zbwRhYh3n84c38VA
	 4g1g4yyT0Y1MNZKbibVkI50krOmQnrPE8dIZSHwPS1mEelf2Rnx6xqAIu48wqh6H97
	 fRx8Fb45mSPfg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C2B34493C2; Fri,  3 Jul 2026 04:47:22 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1783054042;
	bh=kt9LCCk1s44Bp5KJST04IwgwK73sg3CMSHFPJ0xPsxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sGQVrFiplneSXUNjWiv94bGAIFOr3uBem1HK7pa47ATqCVIM45q9uI5vDMaqEIcT1
	 +czrG6lWIkTAzBcG2vPKNSoFnQtmoeEixEPBU8ThjgvqH6nyX5K7HkrkZX2+kbUu2e
	 9g23UvoylGIjQtFjCjBECFxFyMCPJOaJ2nGmBkdDeNspGJRAKG7azIsdBsVNXqunLl
	 7uWUWYfDyb6Ta1vFy27nEKk8w71fLwGwr0E4JGEbI+UcAkQ0K/zbwRhYh3n84c38VA
	 4g1g4yyT0Y1MNZKbibVkI50krOmQnrPE8dIZSHwPS1mEelf2Rnx6xqAIu48wqh6H97
	 fRx8Fb45mSPfg==
Received: from [IPV6:2003:c6:9f1c:3c00:1327:6f6f:388d:c5cc] (p200300c69f1c3c0013276f6f388dc5cc.dip0.t-ipconnect.de [IPv6:2003:c6:9f1c:3c00:1327:6f6f:388d:c5cc])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 5DF12493B2;
	Fri,  3 Jul 2026 04:47:21 +0000 (UTC)
Message-ID: <b836d445-10b8-46a7-8e95-9af66b6b70c2@birger-koblitz.de>
Date: Fri, 3 Jul 2026 06:47:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RTL8159 firmware
To: Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>
Cc: Jan Hendrik Farr <kernel@jfarr.cc>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, hsu.chih.kai@realtek.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20260505-rtl8159_net_next-v4-3-1a648a9c4d8d@birger-koblitz.de>
 <20260701171327.2916132-1-kernel@jfarr.cc>
 <5dc0e654-0bdb-422c-9049-94ee6d8867e4@birger-koblitz.de>
 <8f349e00-1710-428d-8c70-5d1b1f4d42f3@lunn.ch>
 <6677d82e-2b8c-4173-ba6d-6743a5059bc1@birger-koblitz.de>
 <8c0381cc-3612-4ddf-85ed-df09bd0a9dbe@wp.pl>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <8c0381cc-3612-4ddf-85ed-df09bd0a9dbe@wp.pl>
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
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:olek2@wp.pl,m:andrew@lunn.ch,m:kernel@jfarr.cc,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:hsu.chih.kai@realtek.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[wp.pl,lunn.ch];
	DMARC_NA(0.00)[birger-koblitz.de];
	FORGED_SENDER(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304330-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 651EE6FE7C1

On 01/07/2026 23:06, Aleksander Jan Bajkowski wrote:
> Hi Birger,
> Realtek recently released firmware for the RTL8261C[1]. I expect
> the RTL8159 has an RTL8261x PHY built in. Do you know whether
> the RTL8159 firmware consists only the PHY firmware?
> 
> 1. https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/rtl_nic/rtl8261c.bin
I tried to analyze the FW with my own tool and it is not in the same
format as the one used by the r8152 driver. Dumping strings also
does not show any discernible other type of headers. Also the length
is not right, it is by a factor of 3 too large. So, I do not believe
that this is the solution.

Birger


