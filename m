Return-Path: <netdev+bounces-266595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACExK3hFsWlCtAIAu9opvQ
	(envelope-from <netdev+bounces-266595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:35:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 404602624DB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 11:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CF4330F2E9C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 10:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E383C4546;
	Wed, 11 Mar 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iLNGMAdC"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057C3C345D;
	Wed, 11 Mar 2026 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223367; cv=none; b=S/OQ25MowwFNX4DrAp4bk1xCOm1eNLBkpWgEAMaQ5S2SOmsXDihxZmszyRMsVthG4WQ+sAULUtovxYGMaFlXU+lcyWfUTd/e5jNSyFS/2M2Jp7kCMg6Zg5/+YNea7EkLWJL2IhOS1akaloMiwnKvKy6LvoQ6AL5WoutbFAK3psk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223367; c=relaxed/simple;
	bh=4PclmZAtnhelpk3sk6vMtb1x3hYbhe6F3O2W0njUaBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TDxrHHZDGjGoX5sTwyIzNoohusGECfd4IrwMbGNnikeR280NJpmEAPBu20C4Zlh4dNmsaD+LQrs74K0Y5R6PDIfxqN7nPUeMDBoiD+Sf69sHprbV2+tI3HTqId4hV2WJjuBXO+MJPksEpTKvEumb0XE3qlO5HcE2EWWsJdMUzxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iLNGMAdC; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 58917C41585;
	Wed, 11 Mar 2026 10:03:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 00A7960004;
	Wed, 11 Mar 2026 10:02:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CC8610369CB1;
	Wed, 11 Mar 2026 11:02:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773223361; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=oFf5eXi8gUeRnoKjyNYI3Rchn6mvdThTlPK5FSibK9U=;
	b=iLNGMAdCnbbSqAnYsM84Qd/iAfFI3GUkN6qGhMqjGng8YqUCdBcfrKW14Gu1NK2wovEliY
	whh9motVkSTDIm7QnLHr9gWLCBZeYA5vh0rg9RlaTQl3kG8xyoXMujnqXbVPfmZLCEBd5C
	XyBkpJSzpfHokTXUI2anpPs4D/0qEvJFAny/c5FoyGbYqh3NJr1miup+Z2lM5EFh1OMRDx
	9FzwGBWH5LuV3ceOlTfvwYejvGJE1b2ZHWumqpJmBHzrrWj7ULFIzxaqKRerBm8nktTsRO
	3knrqKTEGl6Bt9Fa1YF8p0Kz10Zh+uMRBdHMTD//ewdwSFgXJR+iQYYDt0Mslw==
Message-ID: <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
Date: Wed, 11 Mar 2026 11:02:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 Tristram.Ha@microchip.com
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
 <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
 <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260309205401.bk5fpw6kqnmlktbu@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 404602624DB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266595-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Action: no action

On 3/9/26 9:54 PM, Vladimir Oltean wrote:
> On Mon, Mar 09, 2026 at 01:54:28PM +0100, Bastien Curutchet wrote:
>> I have a new iteration ready. It uses only the high byte of the interrupt
>> registers for the KSZ8463, which keeps unchanged the current 8-bit accesses
>> logic.
>>
>> Shall I send it ? Or would you like more time to think/discuss about whether
>> we should split ksz_common into several drivers ?
> 
> "Send it", you mean on Thursday after the weekly 'net' -> 'net-next'
> merge so it doesn't conflict with your "net: dsa: microchip: Fix error
> path in PTP IRQ setup" change, right?
> 
> I don't know. I have to say that I may be partly responsible for guiding
> Arun Ramadoss a few years ago towards unifying all ksz_switch drivers
> under a single dsa_switch_ops, and that doesn't seem to have been a
> great move, given their amount of differences.
> 
> Prior to Arun Ramadoss' refactoring such that lan937x could come in and
> make use of ksz9477 code, we had two distinct core drivers: ksz8795.c
> and ksz9477.c.  Having checked out an old kernel before his changes,
> I'm not sure why I was so blinded by all the false code sharing hidden
> behind dev_ops that was already there.  If you factor out the MIB worker
> thread and other inconsequential small driver things like that, they're
> perfectly separate hardware architectures which could use perfectly
> isolated drivers with only minimal duplication, and we possibly wouldn't
> even need the 8/16/32 regmap tables.
> 
> "Resources global in one family and per-port in another" is a recurring
> theme, and the inability to have clearly distinct code paths that handle
> these clearly distinct hardware architectures is a problem. I'm not sure
> of the extent to which I was aware of it when making those suggestions
> to Arun. I can recall this thread that indicates a still unsolved, to
> this day, problem which was caused by the desire to have a unified driver:
> https://patchwork.kernel.org/project/netdevbpf/patch/20230316161250.3286055-3-vladimir.oltean@nxp.com/
> > I don't have a good plan, but the current state of affairs is not your
> fault, and I don't want it to stop you from making progress with the
> KSZ8463 PTP support. Maybe we can continue discussing a clean line for a
> KSZ8 (and maybe even KSZ8463) split where the code duplication would be
> minimal, with further input from Tristram.

I, more or less, managed to fit this PTP support in the current 
framework, but the next series I prepared to add periodic output support 
is full of is_ksz8463() branches. So I think that I'll go with what you 
suggested and try to move the KSZ8463 support in the ksz8995.c driver. 
It will probably be cleaner this way.

TBH I'm a bit lost with all these KSZ variants but IIUC KSZ8463 and 
KSZ8995 both belong to the 'old generation' of the hardware. Maybe a 
good split would be to have these old switches in the ksz8995.c driver 
and keep the rest under ksz_common infra.


Best regards,
BAstein



