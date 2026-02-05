Return-Path: <netdev+bounces-257255-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEk5Gs3JhGk45QMAu9opvQ
	(envelope-from <netdev+bounces-257255-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:48:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAADAF56E3
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 17:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D7AE4300E254
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 16:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D92423A9D;
	Thu,  5 Feb 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NAqYauyO"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120B342189D
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770310089; cv=none; b=dFY+2fevJZtL66pkiMRoBmdwMcFmWSclDYksr8S7I3WDW/aHz/CaEn0XGs28G4adEFvLHmT0/tgbclKw3DNN48CfguVHxa34zTEBbwfS3k8Qbwg0gqOM/L7cx01mt2kGCE3Vi6y3bIP93rzBhPtG6alQacOiN6I6BDH2PssyWf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770310089; c=relaxed/simple;
	bh=9s6rlN72umPfzcvftwhUbiWHkEa7FIIwy3ERv4yK7EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fgQBb7Kc/pk7Z99nqUEngFHamK7O7azvZXWuw5D9UUmDc0h1K1UIrkjPZEOMlWdTVpu5zdNHj18+X3U5RuYS2qDvFRB1w0C5EtckVdSivdbCIcMTDwjbJsTjdouL8ruRvuEQPAJ1EnS21Pc5CoOUAFM8QPzwPuRrEqAXYYWkAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NAqYauyO; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770310085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vSwoma4O2xrgSZMEnOzQ9SyuZba4dI6P6unZjdIT0ZA=;
	b=NAqYauyOnOdnTPlNxN2yN8J2WrIwnB8RffBEJyunEHPilpcgkGbKlVr6ZuZrNxdvba0nQc
	EBsIkWkdC0ykONGwon5Q1UPmJ9vh7l5KnKOxjyc1kvoydAGGINbY5kN93lunt/XSJWR2P7
	atytxicDFNqOPgQM1rBcSU7eFs3zqxc=
Date: Thu, 5 Feb 2026 16:48:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Willem de Bruijn <willemb@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
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
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260205164341.pJvni8kA@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257255-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: EAADAF56E3
X-Rspamd-Action: no action

On 05/02/2026 16:43, Sebastian Andrzej Siewior wrote:
> On 2026-02-05 16:27:03 [+0000], Vadim Fedorenko wrote:
>>> So the only thing that bothers me is the read_lock_bh() in
>>> skb_may_tx_timestamp() which deadlocks if the socket is write-locked on
>>> the same CPU.
>>
>> Alright. Now you make me think whether we should enforce OPT_TSONLY
>> option on socket which doesn't have CAP_NET_RAW? Then we can get rid of this
>> check, and in case sysctl was flipped off - drop TX timestamps as
>> it's done now?
> 
> This would "fix" this problem for all users which do deliver the
> timestamp from their IRQ handler instead of napi. There are a few of
> those…
> This would be considered stable material, right? (despite the fact that
> we have it for quite some time and nobody complained so far).

cc: Willem as he is the author of the check introduced back in 2015.

But it's more like a question to maintainers whether it is acceptable
way of "fixing" drivers or it's no-go solution

