Return-Path: <netdev+bounces-296100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LT23JRUIJGoa2AEAu9opvQ
	(envelope-from <netdev+bounces-296100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 13:44:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92DD64D46B
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 13:44:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ixit.cz header.s=dkim header.b=Veg2tLJE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296100-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296100-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=ixit.cz;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1BE03007CB9
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EBA3947AE;
	Sat,  6 Jun 2026 11:41:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ixit.cz (ixit.cz [185.100.197.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30EB396579;
	Sat,  6 Jun 2026 11:41:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780746108; cv=none; b=qudDj6zYW1SUMv5ess3IPq6nhJ2p2g3QR8q7VDYqbGZZY9fgYsb2tvWgfy09vrtpUu5sjp21FiEKKN9lo6CavyLtUlJlkE2/xD7YHG7ysYS4tPlb6q6hWErL1CB1lHa6xA0h//CyB4ADrT08RrnA2WGof+ICXFwpKIkoj1j+0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780746108; c=relaxed/simple;
	bh=zw2glpFdA1lD9wMPcc22+6IMDUUnEXdMBd3sKC9WHtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANfUwHzGt0IxwDx69EbqVhT8KwWoGp2qwn1svBSpmSPErm3EzpRcmwxUFZwtwP+oQ8A6xNIzdoTkQB/oekiTQz++kkzJg7FvdNnYAWOGs3QTVwKIoau99ljDXoViWkM1t4bMwWFeJWT/CmlPhzON/5GDi6RQRPV4AQXEZLmO9Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ixit.cz; spf=pass smtp.mailfrom=ixit.cz; dkim=pass (1024-bit key) header.d=ixit.cz header.i=@ixit.cz header.b=Veg2tLJE; arc=none smtp.client-ip=185.100.197.86
Received: from [10.0.0.200] (unknown [10.88.125.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ixit.cz (Postfix) with ESMTPSA id 2EBFB5340566;
	Sat, 06 Jun 2026 13:41:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
	t=1780746097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=z62Y0TVQrxkOKCGLKNMsdDrIj+m+ACZwqeRRQqSIvoU=;
	b=Veg2tLJEs2iBQRxsKS0iqUNBQFxlnaDe3gc2ctSpVwCwNBVuwHejUxtCS6ANSFNLiPDALb
	p7t+Q4EdnGyxaNlsfvHdoMNoLTD4uc9NT/RxTkLrTfyqskv3lJVVtZEi6+XYw5+Y8zwjs0
	jlubx5po8RKkwV/tXZBQ/aWGEUqDJSQ=
Message-ID: <a43d590f-64a2-4b78-acd6-550df135ea35@ixit.cz>
Date: Sat, 6 Jun 2026 13:41:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] nfc: llcp: bound SNL TLV parsing to the skb and
 add length checks
To: Doruk Tan Ozturk <doruk@0sec.ai>, oe-linux-nfc@lists.linux.dev
Cc: david.laight.linux@gmail.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260604152240.14162-1-doruk@0sec.ai>
Content-Language: en-US
From: David Heidelberg <david@ixit.cz>
Autocrypt: addr=david@ixit.cz; keydata=
 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
In-Reply-To: <20260604152240.14162-1-doruk@0sec.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ixit.cz,quarantine];
	R_DKIM_ALLOW(-0.20)[ixit.cz:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296100-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[david@ixit.cz,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:doruk@0sec.ai,m:oe-linux-nfc@lists.linux.dev,m:david.laight.linux@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@ixit.cz,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ixit.cz:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ixit.cz:mid,ixit.cz:from_mime,ixit.cz:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E92DD64D46B

On 04/06/2026 17:22, Doruk Tan Ozturk wrote:
> nfc_llcp_recv_snl() walked the SNL TLV list using a u16 offset/length
> pair derived from skb->len, without bounding reads to the actual skb
> data. Three problems followed:
> 
>    - For a short frame (skb->len < LLCP_HEADER_SIZE), tlv_len underflowed.
>    - The per-TLV header (type, length) was read without checking that two
>      bytes remained.
>    - A declared TLV length could run past the end of the buffer, and an
>      SDREQ with length == 0 made "service_name_len = length - 1" underflow
>      (size_t), driving an out-of-bounds read in the following strncmp() /
>      nfc_llcp_sock_from_sn(). The SDRES case likewise read tlv[2]/tlv[3]
>      without a length check.
> 
> A nearby NFC device can reach this without authentication; LLCP link
> activation happens automatically after NFC-DEP.
> 
> Walk the TLV list by pointer, bounded by skb_tail_pointer() over the
> linear skb data, and validate each TLV declared length before use. Add
> explicit length checks for SDREQ (>= 1) and SDRES (exactly 2).
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).

This version looks much better!

Since you fixing existing issue, adding Fixes tag and relevant commit which 
introduced the problem would be good too.

Thank you for working on it.
David

> 
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
> ---
> v3 (review cleanups, no functional change to the fix):
>   - Comment that only the linear part of the skb is parsed (David Laight).
>   - Use int for service_name_len and print the bounded service name
>     directly with %.*s; drop the min_t()/cast (David Laight).
>   - Require SDRES length to be exactly 2, not just >= 2 (David Laight).
> 
> v2: https://lore.kernel.org/netdev/20260603135935.62647-1-doruk@0sec.ai/
>   - Walk by pointer bounded on skb_tail_pointer(); drop the 16-bit
>     offset/tlv_len math and fix the short-frame underflow (David Laight).
>   - Add an SDRES length check alongside SDREQ length >= 1 (David Laight).
>   - Bound the SDREQ service-name pr_debug to the field length.
>   - Rebased onto linux-nfc for-next (David Heidelberg).
> 
>   net/nfc/llcp_core.c | 29 +++++++++++++++++++++--------
>   1 file changed, 21 insertions(+), 8 deletions(-)
> 

[...]

