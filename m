Return-Path: <netdev+bounces-297352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SK/5DCGjKGoHHAMAu9opvQ
	(envelope-from <netdev+bounces-297352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:34:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCD4664CF2
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:34:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=FysMfxkl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297352-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297352-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=infradead.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A59143074EC9
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 23:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA763EFD28;
	Tue,  9 Jun 2026 23:34:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218B840D575;
	Tue,  9 Jun 2026 23:34:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781048093; cv=none; b=hlJRHzkGuRXqOzto0wyVey+qxnskgFR2vs4H3ES6txbyVMtnBaDG0ji3mL0ZhJVR4UaBNAEbvULMXNy/rK+wRTN0on/Gm0oqIlnqZpUep4rj0+Mtj1kBD28vn5p9fn7WlX4CgY59qaBmpwdHf5nTxjMBZT0XwbY8d/Z3PWgYR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781048093; c=relaxed/simple;
	bh=k6eBCDmxmDQAncavUpQqOPSqSk1YtXqB+bRLrSnD700=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LchTeXURyKMCUgQyP7KSdpYXVAnQhLCaHG6HFh3sZYJEUcukkNFe2noDvswvxGIblK8rIFC22uXQKnt01vhUZ8Wwrfe/UZCBovm+CWavlY1cgVyJKKC07ujNnJdnke86bhYf/VbbJVMpLJQ9M4lnpFEcVScPQiimvMEznXnvHd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FysMfxkl; arc=none smtp.client-ip=198.137.202.133
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=aGbkLzHaLk+xN8bG59z9ybcOFnLUGrRlxyY5MOGLRjc=; b=FysMfxklQ5Fiwtbv5PBTr4zsOP
	YUsa9rd7d99eLDD3jtFZGrGFEmHABBKgO278R/W3KA/FZPDhZgf9wJqWYVM0wsU0nnTYJChAN41I4
	vuQH+S62SBEJ+RLkEQnSe+szaYaEOxI+Vb165DjeZpNYEck2gQghaz4dIrS8sW1nxCMCWwROGxkRu
	eknsOY++R92d/b53OjoTRGhm1lZVssoNziWjYlSHpF6kz2dRmJxXusW1FDmxte+orDqoWAxEwPxDh
	/8nhSaIgFdXkGsS7vFs07obEDuwFSCqWUuzyUG+tHJEciKmac798vflTY76sXymw8CYzzS9t309Ga
	EPU1MW3w==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX5y6-00000006Vqg-0CsW;
	Tue, 09 Jun 2026 23:34:50 +0000
Message-ID: <6efbb21f-b072-4538-85cf-f7db0c30f677@infradead.org>
Date: Tue, 9 Jun 2026 16:34:49 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] docs: networking: add guidance on what to push
 via extack
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, linux-doc@vger.kernel.org
References: <20260609190919.1139517-1-kuba@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260609190919.1139517-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297352-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-doc@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,infradead.org:dkim,infradead.org:mid,infradead.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9CCD4664CF2



On 6/9/26 12:09 PM, Jakub Kicinski wrote:
> Every now and then someone tries to duplicated extack

                                      duplicate

> messages to dmesg. Document our guidance against this.
> Also indicate that system level faults should continue
> to go to system logs. The high level thinking is to try
> to distinguish between what's important to the user vs
> system admin.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: skhan@linuxfoundation.org
> CC: linux-doc@vger.kernel.org
> ---
>  Documentation/networking/driver.rst | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/networking/driver.rst b/Documentation/networking/driver.rst
> index 195a916dc0de..abd366dd5e43 100644
> --- a/Documentation/networking/driver.rst
> +++ b/Documentation/networking/driver.rst
> @@ -128,3 +128,16 @@ to be freed up.
>  If you return NETDEV_TX_BUSY from the ndo_start_xmit method, you
>  must not keep any reference to that SKB and you must not attempt
>  to free it up.
> +
> +Error message reporting
> +=======================
> +
> +Number of driver configuration interfaces pass a Netlink extended ACK

   A number of ...
(agreeing with Joe)

> +(``extack``) object to the driver (either directly as an argument or
> +as a member of a parameter struct). The drivers should try to report
> +most errors via the ``extack`` object. System level exceptions,
> +indicating that system or device is misbehaving or is in bad state

                                                            bad state,

> +should continue to be reported to system logs.
> +
> +Messages should be passed **either** via ``extack`` **or** to system logs.
> +Drivers should not try to report the same information to both.

-- 
~Randy


