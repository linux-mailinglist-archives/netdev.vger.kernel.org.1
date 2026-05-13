Return-Path: <netdev+bounces-287688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8C//HKuvBGrENAIAu9opvQ
	(envelope-from <netdev+bounces-287688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:06:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79084537AF0
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B12393059ADD
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABFA44CF4A;
	Wed, 13 May 2026 16:56:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EC44A1384
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691364; cv=none; b=fQEg2ApIMnspp+mEY6Hu4NC0EQuPDl8Ca2MDVy/Oqg+WLOHAjHHiHrtX8mxQsYzFUFPRmW7F/hxdJFpJ//ZPZzFtWrvjMtE13/3PZxkwl7YuKggdYQU1qHIlZmtWrgdgY/q1Zhy6PNX++VHvM5/lmhcMgOK+iJQUxLkeh1aBo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691364; c=relaxed/simple;
	bh=HrkFGrBInTcXULZqscIQ9UXxwnJVIz+HxxMBcCCFRMI=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rUPsBJr+SSLi/SHIdimgiYwyP4eU0LJKPYXpKU4lcxVBXKjG6h/LkhWBSBEJrKP6gu565Q7OnICuD3dRWTVVDBDWq9eVl9gAvs6AqdB1JiGvv795d2bL3OIxuZfKmUx3I48ByxFHP9QODZef58kS0pADMsZoql9k52Cl2TnFjGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48d146705b4so84577575e9.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 09:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778691361; x=1779296161;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/oWwbMUe8Wxr7v3phxXvZ4G3SsHYeSlk75eQVB1Z1eE=;
        b=BRqNBt1FPIplox0eZyYRih3zN4ycSgkf/hKav6X05zbJ4/bP8/CQEcy+hNlgylU1CW
         0QwUpZHky+7tstCtHjgkxDslBzjYG5oyrKDn+GeoOEzZqrrncQ+Zrz5sQiF1JUPnAnuK
         bV/W9cj9McHxj66cQhM7VXtpZChZLKMfzJdM1sjFiJX+iRrAs6tQZcr1jvvhWiIE0iAq
         ONeJkMXBnWBRkA2wLIT1JjqgUL8IQ164jrQ3WdjORbFejSxVkH04mHcHkCo+gY6jrjwM
         0I5MxMAu9Ytpk6e+rdRwCpn6+TxwlvUl/fIRvYlxtAvgpYbMCYgMTCRrj52RNo7cAJn7
         JquQ==
X-Forwarded-Encrypted: i=1; AFNElJ9P2SAQ8CiXOYrBpAriPt4BDRIs8O1pAao9cOMSborSjl49ym66shNrd94nuv23eUZXWdkqdZs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5OzmiqsRYQNFAeAR5TZztux31V4C12iZ/8mm5jVt5zyu/1lTV
	hnhsd2meAIcv0lGIwBFp7hBEWNPTJjlJIcGgvRD5eWclTdZWFy03MRbe2VKyY0i4
X-Gm-Gg: Acq92OFogonKqeXlwmUiUs1Qv24YDEfAuJ0pOkpaIVKwanLP3botLmcdechnHRSJdeZ
	6a4RDH1qty3qySQ8BaILv7902Vox53RwMCe8IO7ET6xwSvGo36cD679FkaEaM2wEjNDyzrSK+Iy
	2sZHykhTqth04x7qUaljTatFHrq08x1BwFvXvSdlCl2hNgVzlYxWpxGH1XGMxi0SQV0JpL2FsHE
	Ekbcbzd7TvG30oR02m0qpsgkfDWZPbdN0PqX+Q2VZiHqNeNK+7Apcl6wKWD74Gfo/zh95qDuG6V
	c9ftK4GzF0EDk30YETGrMcwf6sYfYOC9f5C+pylXEKerjXqEW5yB73r1akGJ2yXkSUpRknN5GTE
	+gLYG/ySscqAooY3ck2TYtw5hWV/NLUZdy2oDqDp0vFXy8QYGl9urp8PcDxsG6WRe8TrHk2xjG3
	HqFyK/rD66xBGGeSSysNgu7en5/6kM5D4zu8e5FxDZfAaPLNYdcepS0PUVfDfFJnZ86A==
X-Received: by 2002:a05:600c:b95:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48fc9a2b8c9mr64410795e9.17.1778691360927;
        Wed, 13 May 2026 09:56:00 -0700 (PDT)
Received: from [192.168.88.241] (37-48-40-237.nat.epc.tmcz.cz. [37.48.40.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6498a7esm3406065e9.4.2026.05.13.09.55.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 09:56:00 -0700 (PDT)
Message-ID: <41104c02-efb9-4f23-8e11-95afa6eef442@ovn.org>
Date: Wed, 13 May 2026 18:55:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, netdev@vger.kernel.org,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] openvswitch: vport: fix race between linking and the
 device notifier
To: Aaron Conole <aconole@redhat.com>
References: <20260513095541.2010516-1-i.maximets@ovn.org>
 <f7tse7vo6v6.fsf@redhat.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <f7tse7vo6v6.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 79084537AF0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-287688-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ovn.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[i.maximets@ovn.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/13/26 2:02 PM, Aaron Conole wrote:
> Hi Ilya,
> 
> Ilya Maximets <i.maximets@ovn.org> writes:
> 
>> Sashiko reports that it is technically possible that we got the device
>> reference, but by the time we're linking it to the OVS datapath, it
>> may be already in the process of being deleted.  In this case if the
>> notifier wins the race for RTNL, it will see that the device is not
>> yet in the OVS datapath (ovs_netdev_get_vport() will fail in the
>> dp_device_event()) and will do nothing.  Then the ovs_netdev_link()
>> will take the RTNL and link the unregistering device to OVS datapath.
>>
>> Eventually, netdev_wait_allrefs_any() will re-broadcast the event and
>> the device will be properly detached, but it will take at least a
>> second before that happens, so it's not something we should rely on.
>>
>> Let's avoid linking the non-registered device in the first place.
>>
>> Note: As per documentation, RTNL doesn't protect the reg_state, but
>> it actually does for all the state transitions we care about here,
>> so it should not be necessary to use READ_ONCE or taking the instance
>> lock.  We can still do that, but we have a few more places even in
>> this file where the reg_state is accessed without those while under
>> RTNL, and many more places like this across the kernel code, so it
>> might make more sense to change all of them in a more centralized
>> fashion in the future, if necessary.
>>
>> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
>> ---
>>  net/openvswitch/vport-netdev.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
>> index c42642075685d..de90d0541e172 100644
>> --- a/net/openvswitch/vport-netdev.c
>> +++ b/net/openvswitch/vport-netdev.c
>> @@ -83,6 +83,11 @@ struct vport *ovs_netdev_link(struct vport *vport, bool tunnel)
>>  	}
>>  
>>  	rtnl_lock();
> 
> As noted in your commit, this shouldn't cause any kind of issues, since
> the next netdev_wait_allrefs_any() will make sure things look correct to
> the users again.
> 
> That said, I agree this is good to do to prevent some confusion going to
> the users.  I wonder if it makes sense to add a comment here noting
> that.  Otherwise, if I were just freshly reading through the code it
> wouldn't follow (all the places where ovs_netdev_link get called are in
> the 'create' path).
> 
> WDYT?

I'm not sure if the comment is necessary.  We're not creating a device here
and it seems clear enough that we shouldn't be linking devices that are not
registered, even if there are no races.  But I could add something like:

/* Do not link devices that are not registered to avoid a potential
 * race with the NETDEV_UNREGISTER notification in dp_device_event().
 */

WDYT?

Best regards, Ilya Maximets.

