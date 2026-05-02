Return-Path: <netdev+bounces-283367-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKwJCX6A9WmRLwIAu9opvQ
	(envelope-from <netdev+bounces-283367-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:41:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A9E4B0ECA
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 06:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 036E830074E1
	for <lists+netdev@lfdr.de>; Sat,  2 May 2026 04:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DDC2D7DC4;
	Sat,  2 May 2026 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="AOwmxjnM";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="vAT+0pOc"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4692D5C83;
	Sat,  2 May 2026 04:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696887; cv=none; b=bzPFyWxRlJH1D0B9NFJxZsVUNCgGL7f8R53CZLEHJGRcdTHB8mbTU+kuoGTvrBeGMV7KLKHbHvg7+qjvLs0JP0HcMItjjc3TDypAkySJYjsdt3zGPDsbqCm4P/3J8YnwgeB8/QwJ29EePN1gwIb/c1lezTiTcCBK0swfNRZrlQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696887; c=relaxed/simple;
	bh=/tniwKF+wLA6PfpCL7yMr41giTcZ4oDYqT+9D6T5ZeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B0gUdLfmX6zCGUtmwOAOlAs2lHdYJ/sQcfHndGTxYkbgS2LpBuEtfwwbC07HzIDxg4ylUOwxN3pUG/O7X9J2DDSVUJNM7CjRKr2xc/HnEcsJCvUBqKldKmV4efgoSwzGxMSHt0wLqGZ6j2vH+aAMCa6aGphyEY9E+vakz+p6s0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=AOwmxjnM; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=vAT+0pOc; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777696884;
	bh=/tniwKF+wLA6PfpCL7yMr41giTcZ4oDYqT+9D6T5ZeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AOwmxjnMh9hs/jtJ9N2V2RuYwsH7b5NJnmXevyFQHX2hEYibS13wFcBoaR+8rzOi0
	 MXCX8Oo/5Nn8nJS9Q9w0GVwL14u/c+VXFVrKmK9UPfehdcWkD8IOm2waAOw2svNGpe
	 eZ4J8GUxcN8Rct/QjK0cfdB73RnPbchjFy+vwGAxezvbcYCKA5SI/jw/Sgyel4vpNx
	 TVqnNUHgxx3eYkvssiFL6WE/rQpTm4phsna71F8uoP2s1P8HBKX56cae2gqlhPp3jZ
	 TfKITjZIL79qm43Y7H03/oN+UymrYWXiLGuFkBm1Zgl0mL71oEXsVCOKHFZaLUpw8a
	 LVTEvoqpfqUDQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 7E3B8482AC; Sat,  2 May 2026 04:41:24 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777696883;
	bh=/tniwKF+wLA6PfpCL7yMr41giTcZ4oDYqT+9D6T5ZeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vAT+0pOcEn/PMx0MBmJVpG9ftNJ4Gm50MJVAKOBuO8yiR/zX7p9UCQl220J95Ewkp
	 ouH4XeKxmJY2pqsOq0JCXmpQIJe3xmVZT35FYqmuZ+X8eE7DldceKZLv4oX+bNqNOa
	 1Nr/KYbPTrS3yX+Iuj2QAe0RwesnzMTJOwJyjuD6GCw55uQmOYpv7PqnMfQkq8pKvu
	 pB3FvuO3zcehxPGGTmS2Nx2/tGSWOQXkLZstHMMpB5LaTXotghrE1uib7+VUqPFiij
	 NvW14CAuh6KjnFUQbQliDXldvOjSbRV74iJ9Gw2K7Mzr8JB1eV2wokprHuxMeoHUmB
	 6Vqo+8JHiqouw==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8BC88412CF;
	Sat,  2 May 2026 04:41:23 +0000 (UTC)
Message-ID: <38fde5fd-7bd9-459b-9ee9-d8a9a8de028e@birger-koblitz.de>
Date: Sat, 2 May 2026 06:41:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] r8152: Add irq mitigation for RTL8157/9
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, hsu.chih.kai@realtek.com,
 Michal Pecio <michal.pecio@gmail.com>
References: <20260429-rtl8159_net_next-v2-3-bab3cd4e4c66@birger-koblitz.de>
 <20260501011600.3154202-1-kuba@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260501011600.3154202-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 50A9E4B0ECA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,realtek.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283367-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]



On 01/05/2026 3:16 am, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> r8152: Add irq mitigation for RTL8157/9
> 
> This commit clears bits 0, 1, 2, and 7 of USB register 0xcf04 in
> r8156_init() for RTL_VER_16 and later, with the stated intent of avoiding
> intr URB completions with urb->status == -ESHUTDOWN on RTL8157 and
> RTL8159.
Based on the discussion in the parallel thread with Andrew and Michal,
I will drop this part of the series, as the issue this patch tries to
address is harmless, better solved differently, and it affects 
performance. I will submit a separate patch as bug-fix to remove the 
same register settings done in rtl8153_unload(), as this also applies to 
the RTL8157.


