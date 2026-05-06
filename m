Return-Path: <netdev+bounces-284778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHkvFocT+2lLWQMAu9opvQ
	(envelope-from <netdev+bounces-284778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:10:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B7F4D927F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E012830A0446
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921E34014A4;
	Wed,  6 May 2026 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TdUdDnza"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E4401A02
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 10:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061697; cv=none; b=XT4KoVnJrZ4s0OMWSHewx/R3vHfYno3W1YfeQrnUsiA8bS/JuBb7dURvKwoZWyMKFPRaj3ofUga0sxTgQC96r8JWgo7vgP7g39KR3QJ+NjBqEsuY+SIb17yrGTPyibKRGaq4y8NFcs38k1lBB4ITZ5CCLnttMp814Yjc1pHrJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061697; c=relaxed/simple;
	bh=8hBoxqI9aR8EYiHCrMiCOP/iBuTKw/C8obyd0Pd/l0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+nU4fwoV/6I8n+3XNfOFOVFCYgh0/nXqPSCLmUeBUTManOI/Zz6cQSfLSXFu79uRckN8SwQpr/hPgDdGLO8AS78AQGPLJjcHhg9UH4JKWoH3MOZ54KXYcWkrRZfH4ZfBBMEyEm0MfH+mv6i/bNFGCVH5XJLaQMjOvfn7en4ckM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TdUdDnza; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <45677056-ff03-442f-a7dd-19d34c7b612d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778061674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIgqK6Tm3VIEYqjvLdL7c/fZKYpZg3YkvWrH6wuDQFk=;
	b=TdUdDnzaU11I3h6eTfS7B1iW3rp4A4zvH2EU1U1PbPI7X0lwTxu9rxWcneBppjtmovNfqq
	UilQ7HdjIO9z1t9y7sIhZybWXd9tiBgCFS1oK7EF1oCR5WRyuo9rOM86LyVcpjiScAyHGq
	JVgcc7jkUDhDkg7NojpAl8BM1L5WDa8=
Date: Wed, 6 May 2026 11:00:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 5/5] ionic: Add .get_fec_stats ethtool handler
To: Eric Joyner <eric.joyner@amd.com>, netdev@vger.kernel.org
Cc: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20260501031555.43259-1-eric.joyner@amd.com>
 <20260501031555.43259-6-eric.joyner@amd.com>
 <6eabe3df-08b2-4237-a989-a8e3a9bdf37f@linux.dev>
 <e5d3c314-e6b0-4f18-b17e-752fea4dcb16@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <e5d3c314-e6b0-4f18-b17e-752fea4dcb16@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 60B7F4D927F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284778-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vadim.fedorenko@linux.dev,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,amd.com:email,aka.ms:url]

On 05/05/2026 20:43, Eric Joyner wrote:
> On 5/5/2026 6:54 AM, Vadim Fedorenko wrote:
>> [You don't often get email from vadim.fedorenko@linux.dev. Learn why this is
>> important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 01/05/2026 04:15, Eric Joyner wrote:
>>> Several FEC error statistics being collected can be reported in a
>>> dedicated ethtool callback for FEC errors, so implement the handler that
>>> does so. This includes 802.3ck FEC histogram data that some newer
>>> hardware collects.
>>>
>>> Assisted-by: Claude:claude-4.6-sonnet
>>> Signed-off-by: Eric Joyner <eric.joyner@amd.com>
>>> ---
>>>    .../ethernet/pensando/ionic/ionic_ethtool.c   | 51 +++++++++++++++++++
>>>    1 file changed, 51 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/
>>> net/ethernet/pensando/ionic/ionic_ethtool.c
>>> index 78a802eb159f..fe1f753b6115 100644
>>> --- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>>> +++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
>>> @@ -418,6 +418,56 @@ static int ionic_get_fecparam(struct net_device *netdev,
>>>        return 0;
>>>    }
>>>
>>> +static const struct ethtool_fec_hist_range ionic_fec_ranges[] = {
>>> +     { 0, 0},
>>> +     { 1, 1},
>>> +     { 2, 2},
>>> +     { 3, 3},
>>> +     { 4, 4},
>>> +     { 5, 5},
>>> +     { 6, 6},
>>> +     { 7, 7},
>>> +     { 8, 8},
>>> +     { 9, 9},
>>> +     { 10, 10},
>>> +     { 11, 11},
>>> +     { 12, 12},
>>> +     { 13, 13},
>>> +     { 14, 14},
>>> +     { 15, 15},
>>> +     { 0, 0},
>>> +};
>>> +
>>> +static void
>>> +ionic_fill_fec_hist(const struct ionic_port_extra_stats *extra_stats,
>>> +                 struct ethtool_fec_hist *hist)
>>> +{
>>> +     int i;
>>> +
>>> +     hist->ranges = ionic_fec_ranges;
>>> +     for (i = 0; i < ETHTOOL_FEC_HIST_MAX - 1; i++)
>>> +             hist->values[i].sum = extra_stats->fec_codeword_error_bin[i];
>>> +}
>>
>> ETHTOOL_FEC_HIST_MAX = 17, you defined 16 bins, but iterating over 15 of
>> them. Looks like bin {15, 15} will be lost in stats.
>>
>>
> 
> This looks correct to me -- (ETHTOOL_FEC_HIST_MAX - 1) = 16, so starting with
> i=0, it'll iterate through the 16 bins and ignore the 17th end marker bin. Bin
> 15 does get included and gets its sum set.

Ahh, yeah, you're right, smth was wrong with my math yesterday. btw, how 
does it work for different FEC? RS(528, 514) will not give you 16 bins..



