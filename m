Return-Path: <netdev+bounces-261812-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPofJu5voWm6swQAu9opvQ
	(envelope-from <netdev+bounces-261812-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:20:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0306C1B5F11
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 11:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA66303B7F1
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 10:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865DA36AB77;
	Fri, 27 Feb 2026 10:20:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0405E361DA2
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187605; cv=none; b=tzzMhxfsCMcW7wupXa6UXUV0W5NnqavU7b/PXBbiPDYGKlGQrSpGvl1Nzy1jnCFT2877zml2p9OLFb5c0b7STZpAACZjLQLo/g268Um23BRpLwxeBj38qHdArBgWywmUC2g7ufCVi2JaxePZHx6xCIRLDTLou3pObSxDzYhRh0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187605; c=relaxed/simple;
	bh=ITQVXtnAJGWcTk03bQX+fo1Y/Pi9H9jbR85KAObBzo8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dAHRgkuuw7J14cVrrQcMiOqyt1Kfsp1Q5H/LFFnbmvDaiMEXTvxaeOFZKiuhdUqCecUoWlMP+WqOYZ337n1CDShyPlUUaJi5P9YJVztrYkJHYBXYRqTFWWeezK4Izr5Id22VF2Ui29hXULhQ0Hsb1Ik8MCcP7nMbl6nepjmPkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48069a48629so20051195e9.0
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 02:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772187602; x=1772792402;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:cc:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LxRr1yF+/PLzdNeV17/c+7Fn12qWB4plmtlga3+FMyw=;
        b=IldHCbys4cuRLP2Ab0fgXyIJWm5YM7HpXLTwdtvAGZB7Z7bpFEwfcjQG47SV7uCS8s
         edlYf2H2VF6nJKIy8/9cqYLWdWVjtya+dbQfllfbvwl7V1m3Lp0MlDyHD0Yn0H6XlQ3M
         OZO8M9yjMpUXu/EjAgReLSGOlX/Gkba1++YrIY6NXkj0p7COolLgHDLzVFXbfd62ZdkJ
         7Wob1Fqz1WpMAR/e26Rl4bD1EGwHx+vcNmHHmj5hYnXBpHAf2EDX/18C91BmbkPuad5A
         RQ2LyTQF2pUALWCmuo1PhilxFSYuAHyXFEY8ZHtlhYwZp11VPKTV1mOXXblC+mTOIjda
         nziQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpKawneI/88zFgcpgMtWfBIwSejLX6tOX0Xoo+1vDNWjgOA3BLlc4FgFcJXgg3wM6MM6iS08s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUag7tp12wyspYLSLATT4yHbSOik0EGqwKj/n/WjStrzCRYTtM
	YplT3OeV8N+zXKBuLlFcFLaKfAzuuQU2ZlyakqmFlXxh80N9uU/YCCaH
X-Gm-Gg: ATEYQzwLsu3E4rE5VooylNRCagcJbMeR/JwXaahkBAMMpiOmP+OgV7Byq9gaQ8o2Uf2
	VTOJv4R2R3tkML/wulAbzHh5EfWHDXNQdfsWDgd5LlFW0/15RcwTFSTTyKuJp8IcF88ObZJgkKL
	TRFFqFr8r44zO6u5YFfTzBKXb3QgrNk3j2MZGKk3CTPBbKbG4jow3QI9Gpn9InZ8ZmWnC/6IX+U
	ePo9IU081ZQ4puEHTjmC9hI/vUlOAZdO80rnWZ9zen61VQIDnMeztq6Vzm7qg5+eGDiersyUf/Y
	rUVkJLyCWSSVT21ubSalXP9XTunm4UjZQ/AQn5t5IZ99TyV8yy/vv34K4dlRKnpDpVdZZcvqbqI
	QSkL8eIw4FL9ClrW9MDeaqW4wTgRJP9Rrmix+QbkcN8xHCD/+F5FNhyMebOyEvHkTb7c1qSqQnr
	2B4xJzJF2uwPV9kX/Mthmb65LMpZdBize81Bem5qsRPlGvwSpscEa2SrZ1Q5U=
X-Received: by 2002:a05:600c:4f8b:b0:483:6f37:1b33 with SMTP id 5b1f17b1804b1-483c9c204a5mr31931745e9.30.1772187601981;
        Fri, 27 Feb 2026 02:20:01 -0800 (PST)
Received: from [192.168.88.241] (89-24-32-126.nat.epc.tmcz.cz. [89.24.32.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c35910f1sm87740525e9.2.2026.02.27.02.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 02:20:01 -0800 (PST)
Message-ID: <34be72ba-c777-439f-b414-a449d8dae3e7@ovn.org>
Date: Fri, 27 Feb 2026 11:20:00 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, Aaron Conole <aconole@redhat.com>,
 Eelco Chaudron <echaudro@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, dev@openvswitch.org
Subject: Re: [PATCH -net] net: openvswitch: clean up some kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org
References: <20260226221054.1041044-1-rdunlap@infradead.org>
 <5708dc9f-2cc7-463c-a9a7-32e82634c94c@ovn.org>
 <10b1d487-1324-4bc5-843d-e8799b036add@infradead.org>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <10b1d487-1324-4bc5-843d-e8799b036add@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_FROM(0.00)[bounces-261812-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 0306C1B5F11
X-Rspamd-Action: no action

On 2/27/26 6:42 AM, Randy Dunlap wrote:
> 
> 
> On 2/26/26 2:57 PM, Ilya Maximets wrote:
>> On 2/26/26 11:10 PM, Randy Dunlap wrote:
>>> Fix some kernel-doc warnings in openvswitch.h:
>>>
>>> Mark enum placeholders that are not used as "private" so that kernel-doc
>>> comments are not needed for them.
>>>
>>> Correct names for 2 enum values:
>>> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>>>  '@OVS_VPORT_UPCALL_SUCCESS' description in 'ovs_vport_upcall_attr'
>>> Warning: include/uapi/linux/openvswitch.h:300 Excess enum value
>>>  '@OVS_VPORT_UPCALL_FAIL' description in 'ovs_vport_upcall_attr'
>>>
>>> Warning: include/uapi/linux/openvswitch.h:638 This comment starts with
>>>  '/**', but isn't a kernel-doc comment.
>>>  * Omit attributes for notifications.
>>>
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> ---
>>
>> Hi, Randy.  Thanks for the fixes!
>>
>> If the private/public is the style to follow, it sounds good to me,
>> though there seem to be an inconsistency in how the kernel-only
>> attributes are marked.  I see the OVS_SAMPLE_ATTR_ARG is in the
>> private section, but OVS_CHECK_PKT_LEN_ATTR_ARG and the
>> OVS_ACTION_ATTR_SET_TO_MASKED are public.  They should either all
>> be public or all private, as they are used for very similar purposes,
>> which is storing extra information about the action to make it easier
>> for the kernel to work with them.  These attributes should never be
>> used in the communication with userspace.  So, maybe private?
> 
> I documented them and made them all public:.

OK.

> 
>>
>> __OVS_CHECK_PKT_LEN_ATTR_MAX is also public for some reason.  I guess,
>> it is because while it has kernel-doc-style comment, it doesn't start
>> with /**, so it's not treated like one.  Maybe we should fix that here
>> just to be consistent?
> 
> I didn't follow the "it doesn't start with /**", but I made it private:.

The point was that the comment for the 'enum ovs_check_pkt_len_attr'
starts with the regular '/*' and not the kernel-doc standard '/**'.
So I assumed that's the reason why it was missed.

Looking more closely, the same applies also to the
'struct ovs_action_push_eth', that documents a filed it doesn't have...

> 
>> note: Some enums and structures do not have kernel-doc comments, so
>> I guess that's the reason to not mark them.  I suppose it's fine,
>> since adding extra docs is not the purpose of this patch.
> 
> I ended up adding comments for several enums, but you might want to correct
> a few of them.

Sure.

> 
>> nit: the subject prefix is a little strange.
> 
> I hope that I fixed that.
> I'll send v2 after 24++ hours.
> 
> thanks.

Best regards, Ilya Maximets.

