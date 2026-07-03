Return-Path: <netdev+bounces-304482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KZDfMTiMR2q1awAAu9opvQ
	(envelope-from <netdev+bounces-304482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:17:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2077B70118D
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 12:17:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=JDTjjL7C;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304482-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304482-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB9B4300DDFB
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 10:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD8E3B71A6;
	Fri,  3 Jul 2026 10:16:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83F3B47F0
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 10:16:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783073784; cv=none; b=Q2eCm2sBfXyz1mo/WyGYVxpeJTECnhaJS83j6jPi7FdkFdd4H0VvXe1rttApKvCOTu6LFphocVABp8P9yNA2CX1XAef4O3zOnNjXgnmB76YXNeXLP0SD+yJZIp2yiDzVBWIC+bgp/9XJJm+uCOp5gI8fjAjEbElWiFMzPQ/mNnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783073784; c=relaxed/simple;
	bh=3GRubamd8c/lHAxEWGx9EZ3mJAcdA7pvo8/S2YUqvXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifmduIsQS5zbyPot3LAPMs2bN9c6vx7kPaProH26pWAaYckIagw7rPeCaPrb0EwyXJRbadfUJ7SmEgAOuYEkfD82wVs4tcLLMXZfqYvmV8ftzPBvxns0A1H9LISvxFrgk+yPjZTqSOP/44mNTy1gjlErt4PSc9UJBjRtWMeaw/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JDTjjL7C; arc=none smtp.client-ip=209.85.221.43
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-472055b0efaso287740f8f.2
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 03:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783073782; x=1783678582; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TgYxzP4S3yg5Ik0kspfuMX+5NxuodFksLhrI6YPSMK8=;
        b=JDTjjL7Cn4wMv/TZpFWGRryM9C/pOLw7DlwEuzVNZuM+EJL1f/UvGAR0CcYKaBxHyN
         csYl+DIE7lXSLQMd3F98LwCKvFI0DXZqf0h2n2ZdLNc92DfThmf86/7Za2Za5ibW7Y4G
         2v2g4WbqiXHf3Zcc346guWeJG4S7I0pbzU5fdnFJ0xK/dlyQKJvnHsLNdGgQwHG8sHaW
         7XRmCmKSyyH7T0os/cQjUn5o4N9oXJB+t+1fo/pcmD42iCKhu+Uqya/ky44SBtgzJCbI
         XN+LkmuUQJbC08JOWv75UUTzkeHrAvaeQGRKiXNRZ65BkPA97aI5nKVMgKaA7CuYrEiq
         gYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783073782; x=1783678582;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TgYxzP4S3yg5Ik0kspfuMX+5NxuodFksLhrI6YPSMK8=;
        b=Q6sXl45qzhKt7ir5EKI8QYxk785+v+jm1wJRo8/T3o7EkNfARUm2FCoZOiNooN/oRG
         tWWBhsRQs2MYnHhXk6+xLkMpHoVek2w7NLttbYIF9RTIEJNLeDp4AZJzeLb0Gd5e5dPu
         JXnzgpSTSkH6A2fClBLc18fCZ/TsKSzCgH9HTuVw+3rLjSs7HnxbHXjOZhqs4l9epf71
         WamYVcNI/th1srM0J1ogt8ie8z4ruuMdX+08wQZNRIv+XXFZtPPX+rO2yqKZKX8VJm4e
         ZhODSTtgBwx5IhSWHy+7OLZ3oV3uDzNKpkAf/kAaOXIgu2rU2nyd2V5QCHQpxuH+MCPu
         8jcA==
X-Forwarded-Encrypted: i=1; AHgh+Rp3t1/23uaY9ttHyO7MKvgO6ltZVnnd2F7MsOVTIgiGnMPx8H5wLiNyYz1pR/L7NAUe9gPmTLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVQU2QHg/pOAxvkpvDjUKgKScebabYU9cxpyTQQzBe2GOm/JuQ
	jaYAocD3Zl3VQqieXmr3uwec5AgkZgfkmcn1YmwrDQ3rtW6ntcM6proYQPnHPMDfNMp8UT2RJlk
	SKqDj
X-Gm-Gg: AfdE7ckL4DzzspBi0SA5+Zrss1iJOh3toRjixCQtZq2B/FQVauLpel9PKHnerKeY+vj
	CMN3SzBS3Z6dKQOP/kGWKQK8EhcWGXCuzu1xuGr1sGNwjwi/f8EwUuWCAAkXioNtlCBK3DsNBsh
	9CQBR8nJBQIucz2qf19gpKDDvZ3Xlr6HJoORkgjk5IMhNS7infkVyRbESeaS9c5ewBQsUmxU8SD
	jW8NCu0a6aXuUgzZf+2y3OXK9vs0JkBLrZwoCN3kpd+JUuI2BQplK3V5nskrw9h4XGNLhbI3HPh
	NownOH6Gt6zcWR4tOF78H9kRKfDgvDWQHqiheg4j6Ow/h8UO5ZTSAJ2No8epgz9BbENHZSdH2d8
	3Vc+v+UZeCZ4uIGWeuhttzeOaSCLy9CwQPZqidp0taYgpg+WJWfK95Y10cACnUZBCuD5PE96MqZ
	W8gj8omVggR8kMxAl4JpGvHmiwEimHOIh1DFoqV2qMkc+/G/zBOFgPM6dbGmDARtXUXw==
X-Received: by 2002:a05:6000:310a:b0:475:5e4b:588c with SMTP id ffacd0b85a97d-477573b7cdcmr14057641f8f.1.1783073781856;
        Fri, 03 Jul 2026 03:16:21 -0700 (PDT)
Received: from ?IPV6:2001:a61:134e:e801:4abc:8076:7fbf:d0bc? ([2001:a61:134e:e801:4abc:8076:7fbf:d0bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477db3dbc75sm17654391f8f.5.2026.07.03.03.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 03:16:21 -0700 (PDT)
Message-ID: <c3d3c7a0-5d47-4e73-a46b-2fd610f4cd59@suse.com>
Date: Fri, 3 Jul 2026 12:16:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] net: usb: move exported code to usbnet
To: Andrew Lunn <andrew@lunn.ch>, Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shaoxul@foxmail.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260702143142.890654-1-oneukum@suse.com>
 <ea92d680-39f6-4dde-b558-4008ffbee587@lunn.ch>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <ea92d680-39f6-4dde-b558-4008ffbee587@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,foxmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304482-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:oneukum@suse.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shaoxul@foxmail.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oneukum@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,suse.com:from_mime,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2077B70118D

On 02.07.26 20:15, Andrew Lunn wrote:
> On Thu, Jul 02, 2026 at 04:25:29PM +0200, Oliver Neukum wrote:
>> Some drivers are reusing common code originating in other drivers.
>> This means that two drivers need to be loaded for one device.
> 
> Maybe consider using 'framework' or 'library', rather than driver,
> when referring to the shared code?
> 
> I tend to think of a driver as the leaf node which probes based on
> enumeration of a bus. But usbnet.c itself is never probed.

Yes, I also think of a leaf node when a "driver" is referred to.
That is the very point. Currently you need _two_ drivers and
usbnet for some devices.
Should I reformulate? If so, how exactly?

	Regards
		Oliver


