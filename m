Return-Path: <netdev+bounces-265358-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKRpA1owrmlrAQIAu9opvQ
	(envelope-from <netdev+bounces-265358-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:28:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E6F233441
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 03:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 20AF430069A8
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 02:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95755248867;
	Mon,  9 Mar 2026 02:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NlYjlLJF"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B5322D7B5;
	Mon,  9 Mar 2026 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773023316; cv=none; b=q/6p4E9jEpChqj8O4UDut13nTpej+Q3GVGU28tJpHEaMYG9YEFXDqK5abzDlxPAmLkdnilvQ6ptX15TKyO8/b8unR9dcSyuP4vBokwW5Ssn41d2hiNOcXcoZZRmtkS91/2nEQ9aKqfAmzpp2yyZoMe9sfUsgyVoW5H8PLsLdDKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773023316; c=relaxed/simple;
	bh=9+7Gl9tuAZ1Q0VSNcuAVDQMPoA6ngxLTTu1pfkwf7ig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WQvoPgj0cvsTRqEh9b6Hp2+ElfVIxGwogrGTUoScm1r2gdbXfthV6KVgLrOdBxiUvP0yaoBfcJ4DsfzAX6E7JeLPXXev6Ug45eBzX/MKtNCA3C2/9bAk1Q9cP5dYLfBHLgLCSghTCjnDHkpppoJuCBiikLLmlqV20mmPgP4tSKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NlYjlLJF; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773023305; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qmhKuTU3gUKJMAVU5dtpO7oqXqxZXnfftl1UL5iMYm0=;
	b=NlYjlLJF0JPS2GiOOG6nAIb9XEeGmj3Pugsd95TgqKbjWsnwPKJh6jZrzSoMJVujyUcHEMg1mwb8CF6LsUyWmzI+imktExapM6byzCFlNfMcAsxHsrHXaQ3HUqnXTYcCdC7B0+mqAkbhIFuk57RcjXpAF3I95g0d05wqHHcF9EI=
Received: from 30.221.130.175(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X-TA9qB_1773023302 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Mar 2026 10:28:23 +0800
Message-ID: <6397594f-eb3f-4207-9c20-b0f7e409054c@linux.alibaba.com>
Date: Mon, 9 Mar 2026 10:28:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/2] ptp: Move non-NIC PHC drivers from netdev to
 clock/timekeeping maintainership
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Woodhouse <dwmw2@infradead.org>, tglx@kernel.org,
 tglx@linutronix.de, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mani@kernel.org,
 imran.shaik@oss.qualcomm.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 xiaoning.wang@nxp.com, jonathan.lemon@gmail.com, vadim.fedorenko@linux.dev,
 yangbo.lu@nxp.com, svens@linux.ibm.com, nick.shi@broadcom.com,
 ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, linux-fpga@vger.kernel.org,
 imx@lists.linux.dev, linux-s390@vger.kernel.org, dust.li@linux.alibaba.com,
 xuanzhuo@linux.alibaba.com, taniya.das@oss.qualcomm.com
References: <20260227081934.96865-1-guwen@linux.alibaba.com>
 <be4c63a8dc43be15576565b4bd4567b3cf433d58.camel@infradead.org>
 <4a9af4b1-6820-4173-8daf-4201bb1bcca5@linux.alibaba.com>
 <20260305184110.13e79837@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20260305184110.13e79837@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 12E6F233441
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265358-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,linutronix.de,gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,oss.qualcomm.com,nxp.com,linux.dev,linux.ibm.com,broadcom.com,lists.linux.dev,linux.alibaba.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guwen@linux.alibaba.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 2026/3/6 10:41, Jakub Kicinski wrote:
> On Fri, 27 Feb 2026 20:25:11 +0800 Wen Gu wrote:
>> As mentioned in RFC v1, the use cases for drivers in the emulated PHC category
>> are expected to be quite diverse, and not limited to the virtualization/guest
>> time sync use case. For example, existing drivers such as ptp_ocp [1] and
>> upcoming ones such as mhi_phc [2] are not related to virtualization use cases.
> 
> ptp_ocp is a real PCIe device with an atomic clock. mhi_phc is some
> qualcomm fw-defined thing, so more closely mapping what you're doing.
> ptp_ocp should probably stay under netdev, we maintain DPLL drivers,
> too. Main thing we/I don't want to deal with is all the corporate NIH
> virtualization excreta.

OK. ptp_ocp will be kept under netdev in the next version.

