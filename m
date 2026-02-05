Return-Path: <netdev+bounces-257145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDPyHDKGhGl43QMAu9opvQ
	(envelope-from <netdev+bounces-257145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:59:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CBDF224E
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FE01300A3A1
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 11:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2FF3B8D7A;
	Thu,  5 Feb 2026 11:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tWjgK1GY"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3733ACA51
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 11:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292612; cv=none; b=UvaHdjlleTH0b8C0JLLP598uNLc08G6HEnHmPhDCnmJbraUdz0D+WnLcuXKjQ9YKf/dwM7/KDekdufUrTSbV2XA8i6f9RVuV1HvtUxJL1UBpm6Us2+0AQEVoW6nOK+sQmvGwj11/lzIluM/IpNAkp660GeLLgJ8jbXkflU42P/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292612; c=relaxed/simple;
	bh=ybbc+auNCktSq3UPFidjhvKH+YsOZgK6tem0lS+yldA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KNrX+t+/kgQwXWLjwH2yVNF9NRZM3WzUCGmQOivK0WWVO2colqz5NP/VwczHpT7tTa33ZwBxbIDbzZJDqZtJW+aM+NEOhN+sIbLpT0fmb+pJPznbMbtPX8cc2FBdEHSnG8AwGPmaAMt+ZGN6pX2vaeeDD2qSdh/8ehNYyO2aFYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tWjgK1GY; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770292608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWd1t7s8OVCzkHAhm4N5l/L4ZD0CWDELd1TJlLAt68U=;
	b=tWjgK1GYjSewCFxQBoXE6X/4NUyrFwcikDUcmUkvHi15VclE2tLCZgaKnKapRe007LcxlF
	rm4ZcLBv9tiWAxt/q8yJrSc/tXpDJ7+1c6SmxIi2i5CsKS61MjwsAs6V72ZT/x00fGNgWn
	ep18WFCopxHrV2i7BZD7AffQdCzj9to=
Date: Thu, 5 Feb 2026 11:56:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257145-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,intel.com,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,google.com,lists.osuosl.org,kernel.org,redhat.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:url,osuosl.org:email,mpg.de:email,linux.dev:email,linux.dev:dkim,linux.dev:mid,linutronix.de:email,intel.com:email]
X-Rspamd-Queue-Id: B9CBDF224E
X-Rspamd-Action: no action

On 05/02/2026 10:37, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Sent: Thursday, February 5, 2026 11:04 AM
>> To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
>> Cc: Kurt Kanzenbach <kurt@linutronix.de>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Paul Menzel <pmenzel@molgen.mpg.de>;
>> Vadim Fedorenko <vadim.fedorenko@linux.dev>; Gomes, Vinicius
>> <vinicius.gomes@intel.com>; netdev@vger.kernel.org; Richard Cochran
>> <richardcochran@gmail.com>; linux-kernel@vger.kernel.org; Andrew Lunn
>> <andrew+netdev@lunn.ch>; Eric Dumazet <edumazet@google.com>; intel-
>> wired-lan@lists.osuosl.org; Keller, Jacob E
>> <jacob.e.keller@intel.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
>> Abeni <pabeni@redhat.com>; David S. Miller <davem@davemloft.net>
>> Subject: Re: RE: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve
>> Tx timestamp directly from interrupt for i210
>>
>> On 2026-02-05 09:47:14 [+0000], Loktionov, Aleksandr wrote:
>> …
>>>> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
>>>> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
>>>> @@ -796,6 +796,28 @@ static int igb_ptp_verify_pin(struct
>> …
>>>> +	igb_ptp_tx_hwtstamp(adapter); <-Calls existing function
>> designed for work queue!
>>>
>>> skb_tstamp_tx() can sleep
>>> Smells like sleep-in-atomic isn't it?
>>
>> How or where can it sleep?
>>
>> Sebastian
> 
> igb_ptp_tx_hwtstamp() -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/skb_tstamp_tx -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/__skb_complete_tx_timestamp -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/sock_queue_err_skb -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/skb_queue_tail -> https://elixir.bootlin.com/linux/v6.19-rc5/source/net/core/skbuff.c#L4075
> 
> spin_lock_irqsave(&wq_head->lock, flags);  <- RT mutex can sleep

Hmm... that actually means we have some drivers broken for RT kernels if
they are processing TX timestamps within a single irq vector:
- hisilicon/hns3
- intel/i40e (and ice probably)
- marvell/mvpp2

For igb/igc/i40e it's still OK to process TX timestamps directly in
MSI-X configuration, as ring processing has separate vector, right?

But in general skb_tstamp_tx should be moved to BH processing (NAPI poll
callback).

