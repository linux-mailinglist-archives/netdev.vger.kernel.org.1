Return-Path: <netdev+bounces-257938-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id XKgwA57TiWk5CAAAu9opvQ
	(envelope-from <netdev+bounces-257938-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 13:31:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FDE10EA41
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 13:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 723A93009FA3
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 12:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B48432860E;
	Mon,  9 Feb 2026 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nuiOAqIX"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2ED2459EA
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770639913; cv=none; b=SfVzP9WcRYz0MTqTr6cl7pApHY7Zh+1QOGjtAULRUDAo9WdIMRGMl1w3yDP+UqjKN5NikKgjIVoXF9aXaNOxJ5qWnru6HZk+E7WNm1eTEiZSK+vZO3oLL/a/Nc+LYnty7UPK0dAlTf2aa1bcc5b4UKopAZNG6fA6qRzKeQA6T9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770639913; c=relaxed/simple;
	bh=nUR6EijwT/ofQ88dMDzSCFbCdS+DlhfQ+UySwdNOc1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzUKbdjrUUvSJ6JGn/Sgb13N58kRC5w/k+1oOp5EkmnVrCzqdk/ZLopeRiuqSSqwm3mkTcqS+B2zGxCBlNoHnUe2lex/uYpZOgzzwfDKIaFmzsZM/A+Fg449xV+bAm/QeILCWg16x887KklZ4Fj/GQJOuh7kVs/dB1xkkHm1fh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nuiOAqIX; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770639908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PIrNZzus55bKquXO+5YoeklSWCz4FLC8RX4qxihAbzU=;
	b=nuiOAqIX+K7Wf4ItbxoEm23TvJItgvGTpSmmpMtnOEJuXvBs8FEQeBCay943fS11SNJ6Wl
	W6LDiWmjSsI95PPw5uwxV0QXkBMrY+51CteA7DrAreCf3eRruVme0PHRhST04xG7NBqf8k
	CR+DC27Wv2ZbV5qw6p4Yj4xHcTASCFs=
Date: Mon, 9 Feb 2026 12:24:59 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>
References: <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260209114836.GPU-vnnh@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257938-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.234.253.10:from];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[gmail.com,google.com,kernel.org,redhat.com,davemloft.net,intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,lunn.ch,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	DWL_DNSWL_BLOCKED(0.00)[linux.dev:dkim];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[100.90.174.1:received,91.218.175.173:received];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 67FDE10EA41
X-Rspamd-Action: no action

On 09/02/2026 11:48, Sebastian Andrzej Siewior wrote:
> On 2026-02-09 10:43:55 [+0000], Vadim Fedorenko wrote:
>> On 09/02/2026 09:06, Sebastian Andrzej Siewior wrote:
>>> On 2026-02-08 11:25:40 [-0500], Willem de Bruijn wrote:
>>>>>>> But it's more like a question to maintainers whether it is acceptable
>>>>>>> way of "fixing" drivers or it's no-go solution
>>>>>>
>>>>>> Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.
>>>>>
>>>>> Well, they are kinda broken already. Without OPT_TSONLY and CAP_NET_RAW all TX
>>>>> timestamps are silently dropped.
>>>>
>>>> Are you referring to sysctl_tstamp_allow_data?
>>>>
>>>> That is enabled by default.
>>>
>>> Yes. If so, then we don't need the check below which requires
>>> sk_callback_lock.
>>>
>>> Are SIOCSHWTSTAMP the legacy users or the ones which do not set
>>> OPT_TSONLY?
>>>
>>> I would suggest to move the CAP_NET_RAW check to the point where
>>> timestamping is getting enabled.
>>> Also if ndo_hwtstamp_set is the preferred method of getting things done,
>>> I could check how many old ones are can be easily converted…
>>
>> Looks like you are mixing things. SIOCSHWTSTAMP/ndo_hwtstamp_set are HW
>> configuration calls while OPT_TSONLY is socket option, which is setup via
>> setsockopt, you can find points searching for
>> SOF_TIMESTAMPING_OPT_TSONLY in the sources, basically
>> sock_set_timestamping() is the function to check
> 
> Yeah, but what is the legacy user here? If you enable HW-timestamps but
> never set OPT_TSONLY and the sysctl is also 0 then you reply on the
> CAP_NET_RAW later on. Right?

Legacy users here means users of HW TX timestamps expecting full skb to 
be returned back with the TX timestamp. Legacy here means that skb will 
be returned with headers modified by stack, which is kind of exposure of
data, which requires CAP_NET_RAW...

> I just try to justify the CAP_NET_RAW check and if it is required to
> move it earlier (where HW timestamps are enabled). And if the sysctl
> check is enough then maybe it is not needed.

Capabilities should not change during lifetime of the process, should be
fine to move. On the other, sysctl can be changed system-wide which may 
affect users.

>   
>>>>> To receive these timestamps users have to get
>>>>> CAP_NET_RAW permission, and it will work with the updated logic as well...
> 
> Sebastian


