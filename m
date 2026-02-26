Return-Path: <netdev+bounces-261352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMBaNQVQoGmIiAQAu9opvQ
	(envelope-from <netdev+bounces-261352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:52:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1331A6FE9
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5536C30C687C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518C636BCF7;
	Thu, 26 Feb 2026 13:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ojZFi3P1"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8972DB7AA
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 13:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113370; cv=none; b=SYEYKAweBktj1WOFg3oVNGU8kdXD7++o4HPXNakbIkXTr02vIctKMuvtdF+JgjVtKMP1R0WucuRoagVNEb9Rnz2QWWhdp2t+ddDpYpL3eJ/OC59zddU9rJEQJ1NFJhO3XtF/GVpBcpdEM/3R3JWbegSnvvwhLd/aVREdc4rnMAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113370; c=relaxed/simple;
	bh=OYULylQQzPfYMvJYdd374znMXuwgqG7nLjEVqr1KGa8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGUxtEuqklocKh5OXvMgpuhkq1sft3PD8/VaTZFmvgGRK5iYwd6v3mzO713yGziB0Aur9ogUH713BAZC/dtzo6I+I/KcZM2lIDxgD9Dvy321gv7P1veb4b34ey86J+I9nMD363kAgDCypOnCV1ll7SJWbHNReRvuqz5O8nzEmIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ojZFi3P1; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <02670ff0-36c7-4735-aa90-4cd908cfc46c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772113366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqaMKqBT0frjtR/pijoNCOC4ki0075wYG6QpuxzKYng=;
	b=ojZFi3P1Cd/7vCrMtODXE/bAKt6EF6sZRd3vt2+DkTnTW6xgEzTbcUMozvEZw2iSI/kGpQ
	TH/oeZoc+GvcXz54dwt7h9Xz7y2UbFeUTWJGn0R+3+p9Pt45y2Izt8N7pWeQid3bBv84mv
	saTKu4RzmrZlhsUvn2tnYWFAzof813E=
Date: Thu, 26 Feb 2026 13:42:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] ptp: ocp: Add support for Xilinx-based Adva TimeCard
 variant
To: Simon Horman <horms@kernel.org>, Sagi Maimon <maimon.sagi@gmail.com>
Cc: jonathan.lemon@gmail.com, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260225102938.4131-1-maimon.sagi@gmail.com>
 <aaA6f5xS5yONVlmE@horms.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aaA6f5xS5yONVlmE@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261352-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C1331A6FE9
X-Rspamd-Action: no action

On 26/02/2026 12:20, Simon Horman wrote:
> On Wed, Feb 25, 2026 at 12:29:38PM +0200, Sagi Maimon wrote:
>> Add support for the Adva TimeCard model built on a Xilinx-based design.
>> This patch enables detection and integration of the new hardware within
>> the existing OCP timecard framework.
>>
>> The Xilinx variant relies on the shared driver infrastructure, requiring
>> only small, targeted additions to accommodate its specific
>> characteristics.
>>
>> Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
>> ---
>>   drivers/ptp/ptp_ocp.c | 318 ++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 318 insertions(+)
>>
>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> 
> ...
> 
>> @@ -2926,6 +3168,45 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
>>   	return ptp_ocp_init_clock(bp, r->extra);
>>   }
>>   
>> +/* ADVA specific board X initializers; last "resource" registered. */
>> +static int
>> +ptp_ocp_adva_board_x1_init(struct ptp_ocp *bp, struct ocp_resource *r)
>> +{
>> +	int err;
>> +	u32 version;
>> +
>> +	bp->flash_start = 0x1000000;
>> +	bp->eeprom_map = fb_eeprom_map;
>> +	bp->sma_op = &ocp_adva_x1_sma_op;
>> +	bp->signals_nr = 4;
>> +	bp->freq_in_nr = 4;
>> +
>> +	version = ioread32(&bp->image->version);
>> +	/* if lower 16 bits are empty, this is the fw loader. */
>> +	if ((version & 0xffff) == 0) {
>> +		version = version >> 16;
>> +		bp->fw_loader = true;
>> +	}
>> +	bp->fw_tag = 3;
>> +	bp->fw_version = version & 0xffff;
>> +	bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
>> +
>> +	ptp_ocp_tod_init(bp);
>> +	ptp_ocp_nmea_out_init(bp);
>> +	ptp_ocp_signal_init(bp);
>> +
>> +	err = ptp_ocp_attr_group_add(bp, adva_timecard_x1_groups);
>> +	if (err)
>> +		return err;
>> +
>> +	err = ptp_ocp_set_pins(bp);
>> +	if (err)
>> +		return err;
>> +	ptp_ocp_sma_init(bp);
>> +
>> +	return ptp_ocp_init_clock(bp, r->extra);
>> +}
> 
> Hi Sagi,
> 
> I see similar patterns elsewhere in this driver. So I assume that I'm
> overlooking something obvious. But it strikes me that
> ptp_ocp_attr_group_add() and ptp_ocp_set_pins() allocate memory. Shouldn't
> that be cleaned up if an error subsequently occurs in this function?
> 
> And also, shouldn't ptp_ocp_attr_group_add() relase the memory it
> allocates if an error occurs in that function?

Well, ptp_ocp_attr_group_add() error is not critical for device init, so
I believe it's ok to keep it and free in ptp_ocp_detach(), there is no
leak. But I agree it goes against common code style of kernel. I'll do
cleanup patch once I have some cycles.

Situation with ptp_ocp_set_pins() is a bit different, but still we end
up with calling ptp_ocp_detach() in error path, which cleans up all
allocated memory. Changing *init() code to unroll everything is actually
a code duplication of ptp_ocp_detach() - I don't think we have to spend
time it.

> 
> Lastly, the AI generated code review suggests that there may be
> some scope for sharing code:
> 
>    This isn't a bug, but ptp_ocp_adva_board_x1_init() is nearly identical to
>    ptp_ocp_adva_board_init(), differing only in flash_start (0x1000000 vs
>    0xA00000), sma_op assignment, signals_nr (4 vs 2), freq_in_nr (4 vs 2),
>    and the attr group passed to ptp_ocp_attr_group_add(). The version-reading
>    logic and the entire initialization call sequence are duplicated.

That's what I also asked in my response.

> 
>    Looking at the existing driver convention, each board variant (fb, art,
>    adva) uses this same pattern with separate init functions. Would it be
>    worth parameterizing these differences in a future cleanup?
> 
> ...


