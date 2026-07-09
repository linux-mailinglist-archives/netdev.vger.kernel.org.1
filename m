Return-Path: <netdev+bounces-306180-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7pIQKNJ+T2qZiAIAu9opvQ
	(envelope-from <netdev+bounces-306180-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:58:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 990DD72FF71
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:58:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=NPkDu97n;
	dkim=pass header.d=redhat.com header.s=google header.b=ecF1zYb7;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306180-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-306180-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 248553038CD4
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B53E3E92A5;
	Thu,  9 Jul 2026 10:46:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD640B6E9
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 10:46:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593975; cv=none; b=coadAc8oTEkFmwYlLfxjg3iIDxHznB+l1HkVxIHbkhyRFqdgoqqhN3b7332ymjp2AjF04D7CIV2w7209EKzJcf5imb5AY9IgWV9NZIObo8jN4m7n56bQYvwSHAY5MjcYAVv7M/KT2LTGKd56tR1eMhuGUWEWj1R16TWffetkINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593975; c=relaxed/simple;
	bh=ALw1vDHV5L4nvGbJoc+jSU8mWvhkA4JdMp1Q/Jp5JGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nZQLBTUhlMZdBYfKoZmrQA2oBOM/qAP/gGxAqzGgW/+FxAba+vd/4M5CRPdb1AycXiR3qSVXzsbJF9/wxwPdoYw8Wqq+Yefc/WjM8zJ8TA5DWnuh1yhI7LK0U2+x4niK5EBKX4NfaJ+UMPkjqu3UFg+XW7hqBNkRv8MwQtrwOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NPkDu97n; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ecF1zYb7; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783593969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I49PQ9PyUdCuLERxmFaB0ytRW4SbKdB8bINg9r85uDU=;
	b=NPkDu97nwWj9NsH7veYbpDazTADQpgfeXF6EkKNWydRl1vR9ENNO9xj7MuJMY+CYDZU/CF
	1cNhETh+hdQ6Y7hP1cUeNYqnHN8FHBh3D76qdDIv6HvlipssLYtfzxX9Jbvoc+93kIOU+q
	ltHF7EAsCbn0Pgoiij9GIhmWIklxltg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-Z72WNSbtNrOzengjZAchQg-1; Thu, 09 Jul 2026 06:46:08 -0400
X-MC-Unique: Z72WNSbtNrOzengjZAchQg-1
X-Mimecast-MFC-AGG-ID: Z72WNSbtNrOzengjZAchQg_1783593967
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-473f4a48e9aso455635f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 03:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783593967; x=1784198767; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I49PQ9PyUdCuLERxmFaB0ytRW4SbKdB8bINg9r85uDU=;
        b=ecF1zYb7w3M4xqQYWX9RKP8KMzzL4+bUF0n5t9qxP9i1nFdFw9i4d/+QuB3HoFMjB/
         1q9lPrW5ekmrSyEequpx6aNt+Abax7MBnR7o8/34prZ64axx+t5m9r1jj1sWBTEh+Ufz
         0OKqaEpnlQxR2tDTR7mfORPRXAtBz7q2qmWNbXnnDpLZmVvmUdS5Af3Wp4t1g/xVO3Cp
         bjhw/+Lmd2+w2F8F5aqg15aKDMUW3V2uQ9JCRCdukge7RhxEpa1oWsTWpZV534CLp4zq
         ngtRJCEwTbagSM1Blyaj3Pwm6ECQCqZkk0h4grsl65YFckPzKzl9BJV/TalHjrI6zPBA
         pnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783593967; x=1784198767;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I49PQ9PyUdCuLERxmFaB0ytRW4SbKdB8bINg9r85uDU=;
        b=fH43vY4/SmU1UMBh0o8o+qIVvJ/vMKALzkPiN6dXqHLaONbAk/y6KsGxvwhERFxMzD
         qy7HIw8VsoOyUXhT3XCGgIAl8RV5viMopQ8fg0fCZvijS2pm0qHHSYL5XnJbNQDAD1je
         e4GmzUEqkHgOFsKXk8MUgXtlhovAr3b9bpgmis3iGeGC9ScXLKQCnqOHLN90p6UQyt5Y
         ZrAUPfOSkZXcWeyCGg5ne0ZCLj7bOxtR2qjszq6GcxgUbQzWpL/qGiuv99vQwlWGSeL1
         ZHt8pQrjI/q9zsi8Fi3IGjf7j9c3Dh1lbGyOIYMVpt+DOULXf8Z3FKczV3mVDOJ3plpi
         BPaw==
X-Forwarded-Encrypted: i=1; AHgh+RoJ8U1LEbgJQWgMRaJVGMV3CAiYKFq8ttilC1iMAk1OxY82238XGiKRb4WgkE2Epp2KACVWEmY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMiFYJHs4epODqJSlxttNhMu6bczIForkSVwPvtBCe1+yo+9DD
	21LdouWvhu/TkiuKV1KNa7YhBbj6idRy+mXKZMkCC8a7oSl7fkzOj6mwiHNMAZcP2EGddKuMLct
	xs9Mz76IH7yk8QPfg/gruDAXFDBYsqx7pboy1ThLJiTu3IMDs1W+ZtRLhJA==
X-Gm-Gg: AfdE7clAgCfD/rBhFiVl6fe6oqvcRygNxMAa4eCbMcOaBQcxWrtqUPfuNUuoHTUTnc8
	YOxvAWoWjf5p0nl30HRU4FpfEFIgkgLw2HJdu5t1Li8ugUBh7Ru8CrlH+E8KmrlAQ2W/sNgzgoD
	ACSiMQJNadYl6rU77qAP9H4Q2q6co8vETFbK8ojd2sxrGbbWgCb1qpSLvJ9qd/kINFER7KpMvWr
	z7vFONLplsQItN1p8pCAPOyJicgY9LRwiAq2phvJDgk4zBJrp5Qx+cNVeoBauBMOsCXkhRkhJ+l
	JqlHYlDBx5ZM7m4VkTwX9uFhd+4aH0ZMP6wDLwJGr6y5w3nQOG+xPrEzgehqnuiA/YXtPrUgHkH
	CTQ6uIKbfSmwHBskgrdOvt2tWSCXb63iU4NL5ug018LFJytXgHFd6LtRDFGDRkRvEcW+k2NOqi2
	QrB+AetsUMMtmR
X-Received: by 2002:a5d:5f50:0:b0:47b:69a5:7263 with SMTP id ffacd0b85a97d-47df071c18fmr7139206f8f.5.1783593966991;
        Thu, 09 Jul 2026 03:46:06 -0700 (PDT)
X-Received: by 2002:a5d:5f50:0:b0:47b:69a5:7263 with SMTP id ffacd0b85a97d-47df071c18fmr7139165f8f.5.1783593966534;
        Thu, 09 Jul 2026 03:46:06 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm51419282f8f.26.2026.07.09.03.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 03:46:06 -0700 (PDT)
Message-ID: <ca70ed92-087d-4e73-88a9-428172e9cce2@redhat.com>
Date: Thu, 9 Jul 2026 12:46:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dibs: loopback: validate offset and size in
 move_data()
To: Andrew Lunn <andrew@lunn.ch>, Dust Li <dust.li@linux.alibaba.com>
Cc: Alexandra Winter <wintera@linux.ibm.com>,
 Wenjia Zhang <wenjia@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>,
 "D . Wythe" <alibuda@linux.alibaba.com>,
 Sidraya Jayagond <sidraya@linux.ibm.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Federico Kirschbaum <federico.kirschbaum@xbow.com>
References: <20260707074318.1448662-1-dust.li@linux.alibaba.com>
 <ak0NpKUDkvrkuSOm@linux.alibaba.com>
 <c09ac69d-5f69-4634-81a0-5e629cf135ba@lunn.ch>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <c09ac69d-5f69-4634-81a0-5e629cf135ba@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306180-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:dust.li@linux.alibaba.com,m:wintera@linux.ibm.com,m:wenjia@linux.ibm.com,m:guwen@linux.alibaba.com,m:mjambigi@linux.ibm.com,m:alibuda@linux.alibaba.com,m:sidraya@linux.ibm.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:federico.kirschbaum@xbow.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,xbow.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 990DD72FF71

On 7/7/26 8:31 PM, Andrew Lunn wrote:
> On Tue, Jul 07, 2026 at 10:31:00PM +0800, Dust Li wrote:
>> On 2026-07-07 15:43:18, Dust Li wrote:
>>> The loopback move_data() performs a memcpy into the registered DMB
>>> without checking whether offset + size exceeds the DMB length.  Unlike
>>> real ISM hardware, which enforces memory region bounds natively, the
>>> software loopback has no such protection.
>>>
>>> A peer-supplied out-of-bounds offset or oversized write would result in
>>> an OOB write past the allocated kernel buffer.  Add an explicit bounds
>>> check before the memcpy to reject such requests with -EINVAL.
>>>
>>> Fixes: f7a22071dbf3("net/smc: implement DMB-related operations of loopback-ism")
>>> Cc: stable@vger.kernel.org
>>> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
>>
>> Reported-by: Baul Lee <baul.lee@xbow.com>
> 
> Could you provide a link to the report?

Since both reporters belong to the same org, I assume they
co-partecipated at the initial report.

Also there is a problem with the fixes tag that I'll address while
applying the patch.

/P


