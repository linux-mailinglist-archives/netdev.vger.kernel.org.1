Return-Path: <netdev+bounces-306306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /GuPFT/GT2q7oAIAu9opvQ
	(envelope-from <netdev+bounces-306306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:03:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9FF7333DE
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 18:03:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=2sZH6Pr5;
	dmarc=pass (policy=none) header.from=infradead.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306306-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306306-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9A8D9300A48A
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 16:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5C54307B3;
	Thu,  9 Jul 2026 16:03:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FB841930A;
	Thu,  9 Jul 2026 16:02:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612981; cv=none; b=C4zNdiISQv3G/spybxE2d1pyK7nF/ldXRtPYjJ83sB3Gek23nnxpBvyit2OvcOrqTyrfDQaKJ2pcWAV7J3CQKPdEwYSyxYcUS5zv4bTt9qFWIxjh1ufbLK6bEsSAlkEfglKNSLL62ikA86rDPiuiPNECXQdJldgeKJBpL2VRy1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612981; c=relaxed/simple;
	bh=yO9iKAHylHhWE7yssxF0VmcIXI4P+bdqYUVcw3c2FRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Md2bcNztgiVdvUl9dq0IltuGkIzQvac8aLeU/+RJFrouIFG9V+NyVNxl0oPw5rMmvslZKpTK7bPHtRYaYx/T0I+ztpjbnNIdfvHLzOLW3VZ+apHrZ/b8edY53GLsXJu6ne3lsQ+HBMAB1YwxkDIBzg+ToczR+/DiKyJ8gXlOMSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2sZH6Pr5; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=TZ/xManMkD1zLCtWQet0kB0NqWYDW37fUEY390SgfAY=; b=2sZH6Pr5VH5orwGq7DPe1zWxfA
	Aofnv51s6C46cvf2JBCUVTgHVNsVnpVIHR1AE3AYEAGy5X84/xyJfML8FMxwiQWwpTIfiCQyLcBAf
	Ocae+/DWOuGm9Ln/XY9vp+N7BuFwh6hVBhrFGnaH6IxQqsshDnKfIT3huPf895RS0N9wREHw+wchL
	lVODsh8ZM6WvvBCuDKcHqzVooXjIKwBcQtpbxgzPPvzn8tF5cUCAq8DNkh1TKm5WO58ul8KE6pEZv
	y2NLi1nKKpvwMalFtyml8B4DPo1Ekpkk56OSxF2hcTbabyfALTDfI0/c9n5rAVg36tOXWug2//iRy
	zc1U9B/w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whrD0-00000002zQ5-3eed;
	Thu, 09 Jul 2026 16:02:42 +0000
Message-ID: <9db11888-c202-4306-9441-b663eabc0da4@infradead.org>
Date: Thu, 9 Jul 2026 09:02:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: packaging: fix brackets
To: Manuel Ebner <manuelebner@mailbox.org>,
 Vladimir Oltean <olteanv@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260709141012.400011-2-manuelebner@mailbox.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260709141012.400011-2-manuelebner@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-306306-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:manuelebner@mailbox.org,m:olteanv@gmail.com,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:jacob.e.keller@intel.com,m:kuba@kernel.org,m:andrew@lunn.ch,m:vladimir.oltean@nxp.com,m:netdev@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[mailbox.org,gmail.com,lwn.net,linuxfoundation.org,intel.com,kernel.org];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mailbox.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lunn.ch:email,infradead.org:from_mime,infradead.org:email,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7E9FF7333DE



On 7/9/26 7:10 AM, Manuel Ebner wrote:
> Add two ')' to nested functions in code block.
> 
> Fixes: a9ad2a8dfb43 ("lib: packing: document recently added APIs")
> Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Subject is now incorrect; should be packing:

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
> [v2]
>  add Fixes tag.
>  add Reviewed-by.
> [v1]
>  https://lore.kernel.org/all/20260709121427.391749-2-manuelebner@mailbox.org/
> ---
>  Documentation/core-api/packing.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/core-api/packing.rst b/Documentation/core-api/packing.rst
> index f68f1e08fef9..cff1a262efce 100644
> --- a/Documentation/core-api/packing.rst
> +++ b/Documentation/core-api/packing.rst
> @@ -330,7 +330,7 @@ Here is an example of how to use the fields APIs:
>  
>     void unpack_your_data(const packed_buf_t *buf, struct data *unpacked)
>     {
> -           BUILD_BUG_ON(sizeof(*buf) != SIZE;
> +           BUILD_BUG_ON(sizeof(*buf) != SIZE);
>  
>             unpack_fields(buf, sizeof(*buf), unpacked, fields,
>                           QUIRK_LITTLE_ENDIAN);
> @@ -338,7 +338,7 @@ Here is an example of how to use the fields APIs:
>  
>     void pack_your_data(const struct data *unpacked, packed_buf_t *buf)
>     {
> -           BUILD_BUG_ON(sizeof(*buf) != SIZE;
> +           BUILD_BUG_ON(sizeof(*buf) != SIZE);
>  
>             pack_fields(buf, sizeof(*buf), unpacked, fields,
>                         QUIRK_LITTLE_ENDIAN);

-- 
~Randy

