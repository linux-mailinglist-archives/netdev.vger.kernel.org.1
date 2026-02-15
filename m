Return-Path: <netdev+bounces-258762-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5pn9LdiQkWn9jwEAu9opvQ
	(envelope-from <netdev+bounces-258762-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:24:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F27A13E635
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 10:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A3C33011C7B
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 09:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60AF2BE630;
	Sun, 15 Feb 2026 09:24:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.si6networks.com (mail.si6networks.com [207.180.232.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7D627B327
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 09:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.180.232.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771147477; cv=none; b=ehBG6bvF0xLd/Ojw6I0dYxdySdysgHkctcMxABkHWVQmt//Nkn2NtMZ0sOXVfAw86nxMf3+fqgRqZeQQ4GDvHbNc5EHfTA9Nv0FuZs9TtptreRzFHICCwCfSwHC+R70jjorAO+gc5ZqDMjGvuM+Fy2KVThRQ3WpsrBimv8TV5e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771147477; c=relaxed/simple;
	bh=5+8phqEb67eBjI5T33ffAnbdYjUsCkT9nFW6WiYuhQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOul00WqNAuRX5u4uhts5lOdc0/SLU1VZyQllDGoBbZtQL/9X3xq/50/K+Y9zjU7CZRHOeAwx/WdkmKTAwJYQvwN+NYTsrBG36ajGSr9uYNUNw27mVe1G0eN5Kq71/TiXpWz/irMwpiei+rzy1Ddu97VbZ8cDPdX7soL+AEJr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=si6networks.com; spf=pass smtp.mailfrom=si6networks.com; arc=none smtp.client-ip=207.180.232.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=si6networks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=si6networks.com
Received: from [192.168.100.100] (186-247-231-117.user3p.vtal.net.br [186.247.231.117])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.si6networks.com (Postfix) with ESMTPSA id 68B4C48F7A1;
	Sun, 15 Feb 2026 10:16:04 +0100 (CET)
Message-ID: <a5f63bcf-195e-45ff-875a-f2aa8dbae70b@si6networks.com>
Date: Sun, 15 Feb 2026 06:16:00 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: addrconf: reduce default temp_valid_lft to 2
 days
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 Eric Dumazet <edumazet@google.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net
References: <20260211202003.4550-1-fmancera@suse.de>
 <aY8uYmy1adhPqqbm@horms.kernel.org>
 <CANn89iL4zCq6gXNj7Yc_gXOrvtUhN+Zcdw5pbrUqZDgYez0ujw@mail.gmail.com>
 <8c9727bc-a1d5-4ea3-8318-f3fa7e558c85@suse.de>
 <89d03f27-2e08-4619-b556-772da4c38462@suse.de>
 <CANn89i+fNkeMJbNBJjqv15Rih1tUdC8ZwGqxjMZaxovcSt=hgQ@mail.gmail.com>
 <4398e57a-343b-431c-a5cc-0aae65676023@suse.de>
Content-Language: en-US
From: Fernando Gont <fgont@si6networks.com>
Autocrypt: addr=fgont@si6networks.com; keydata=
 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 /Q==
Organization: SI6 Networks
In-Reply-To: <4398e57a-343b-431c-a5cc-0aae65676023@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-258762-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[si6networks.com];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fgont@si6networks.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0F27A13E635
X-Rspamd-Action: no action



On 14/2/26 10:43, Fernando Fernandez Mancera wrote:
> On 2/14/26 2:37 PM, Eric Dumazet wrote:
>> On Sat, Feb 14, 2026 at 2:28 PM Fernando Fernandez Mancera
>> <fmancera@suse.de> wrote:
>>
>>> I noticed the patch is marked as "Changes Requested", is there some
>>> action pending from me?
>>
>> Quite confusing. The blamed commit mentioned RFC 4941
>>
>> commit 969c54646af0d7d94a5f0f37adbbfe024e85466e
>> Author: Fernando Gont <fgont@si6networks.com>
>> Date:   Fri May 1 00:51:47 2020 -0300
>>
>>      ipv6: Implement draft-ietf-6man-rfc4941bis
>>
>> So please add a comment like this one ?
>>
>> /* TEMP_VALID_LIFETIME default value as specified in RFC 8981 3.8 */
>>
> 
> Sure, I will. FWIW, the blamed commit mentioned the draft revision for 
> RFC 4941, but at that time, being a draft, it did not have an 
> appropriate RFC number assigned to it.

Note: the commit referenced the right filename: IETF draft 
draft-ietf-6man-rfc4941bis. -- IETF drafts that are meant to revise an 
existing RFC codify such RFC number in the filename (e.g., this draft 
had "rfc4941bis" in the filename because, when published as an RFC, it 
would formally revise RFC4941).

Thanks,
-- 
Fernando Gont
SI6 Networks
e-mail: fgont@si6networks.com
PGP Fingerprint: F242 FF0E A804 AF81 EB10 2F07 7CA1 321D 663B B494

