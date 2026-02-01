Return-Path: <netdev+bounces-255550-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NnD4E9KXfmlSbQIAu9opvQ
	(envelope-from <netdev+bounces-255550-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:01:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98559C46BA
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6470E3016283
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 00:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B40F191;
	Sun,  1 Feb 2026 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h501Bb3n"
X-Original-To: netdev@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6864B3A1B5;
	Sun,  1 Feb 2026 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769904078; cv=none; b=GRUEkh/D+c2e+28hwnsJvBcWGbaXRtCwW8b1mFEMF6ZxyxtbGs+TSnZc6C5uoZCxR1Tcmfv96uQeyhpJrziJbTRyamDIev2aXkfxYSh78czB/c3LeQ8H2f+O/exdmaXBy1buXza2FlB0BDlDHKAc203wwrHSUd0VZWG4hINGGfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769904078; c=relaxed/simple;
	bh=pFUH64fTAkeU9bkrBC97ZI46DOQturvErPYQ3kgqYhY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LdFp407zSeM8IovpGLqiJbkEyu5cjaFZTi8hSVHX+7uwsyeTdDKInbU7gf6ID1f+xAJ28WzAXRzf4Ka0QC1txWU/pHqkp8JKYp94RuRsCJu27R6jayjHoxbpfH7+lPjJ7rsSnYdpNm15ooDGj7g4/cP4NLCznqU8x005eIXLGCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h501Bb3n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CnBY/5KwliOTevCAoDnrILa84iIB602z10HXwkVWJos=; b=h501Bb3nkWZobsUNe8wmhMv6Vg
	/o35AUYsk05S/EdD289nzfsvt4O6biYimbgQFH+PpmpZ9TIdxwMGnUdjF1t+fqWgKbZw8Nnbs8gPF
	s5YiBugK/fkFo0Z0GzonvtF3pyJqlJUgibrAyIpv20lHakaEWyxkUh2IDLye1pBl6vI6brBGXlN7C
	3E2VLAaMI1VHrLnFuFaOvLuY4lmx+v23h4iKGaFi2Dq4pNbTf3E814PINyrMIapPFE9q4eBQKQHdx
	NmTq6F8tzJzB2bb1u0p90spB6YXB2uQ0tdsCYqAZ1JwnxCRZKmxWVTpG2vaiD0/JWv9MJjh8RorG9
	8F8zhwrg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vmKtm-000000036eq-1MM2;
	Sun, 01 Feb 2026 00:01:06 +0000
Message-ID: <16c2528a-85be-4f7b-a60a-923613ecc8fb@infradead.org>
Date: Sat, 31 Jan 2026 16:01:04 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net/iucv: clean up iucv kernel-doc warnings
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
References: <20260130054759.1301608-1-rdunlap@infradead.org>
 <20260131131131.0d854805@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260131131131.0d854805@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255550-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rdunlap@infradead.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:mid,infradead.org:dkim]
X-Rspamd-Queue-Id: 98559C46BA
X-Rspamd-Action: no action



On 1/31/26 1:11 PM, Jakub Kicinski wrote:
> On Thu, 29 Jan 2026 21:47:59 -0800 Randy Dunlap wrote:
>>  /**
>> - * __iucv_message_receive
>> + * __iucv_message_receive - Terminates an IUCV path.
> 
> AI code review complains this is odd wording since the main body
> describes reception not termination.
> 
>>   * @path: address of iucv path structure
>>   * @msg: address of iucv msg structure
>>   * @flags: flags that affect how the message is received (IUCV_IPBUFLST)
>> @@ -374,7 +363,7 @@ int __iucv_message_receive(struct iucv_p
>>  			   size_t *residual);
>>  
>>  /**
>> - * iucv_message_reject
>> + * iucv_message_reject - Refuses a specified message
>>   * @path: address of iucv path structure
>>   * @msg: address of iucv msg structure
>>   *
>> @@ -387,7 +376,7 @@ int __iucv_message_receive(struct iucv_p
>>  int iucv_message_reject(struct iucv_path *path, struct iucv_message *msg);
>>  
>>  /**
>> - * iucv_message_reply
>> + * iucv_message_reply - Refuses a specified message
> 
> Same here, refuses or replies?
> 
>>   * @path: address of iucv path structure
>>   * @msg: address of iucv msg structure
>>   * @flags: how the reply is sent (IUCV_IPRMDATA, IUCV_IPPRTY, IUCV_IPBUFLST)
> 
> In general -- Could we possibly delete the duplicated kdocs in 
> the header. As clearly shown by this patch it's double the work
> and kernel-doc will be able to find the definition wherever it is.
> Kernel coding guide recommends kdoc next to definition.

Thanks. I'll check all of that.

-- 
~Randy


