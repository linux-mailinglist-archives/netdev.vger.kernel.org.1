Return-Path: <netdev+bounces-40018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4145A7C564B
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63C5A1C20E0A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 14:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38237200DD;
	Wed, 11 Oct 2023 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Eauiv2ZW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2DD200D7
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 14:03:38 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017B5129
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:03:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3214cdb4b27so6522725f8f.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 07:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1697033008; x=1697637808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I/feldA9vSD69JZ+Q39K0lJKMvtA75LBDVAoVaS21Qk=;
        b=Eauiv2ZWiDd6y1QaqYQj85UrvHwPtuEedKlSRyfE9orkbsj1L0oRhAmoShJwXHLcDT
         RCt0ZnTGp+SDN1Shae0bT9zPvfcugsOo0niibLSPTqUWBp7ZmVSaBD8rboi3uBmb/ihd
         udYJfNfMs5SpTmb4Jpg+DiNUEqtKllsSFPbFm7iEnLQz507K0lTsWnXq/27P5Z0Hc4Fg
         B8KkjeZ7VMU3ZZGH5bytblZlTnfFaa7/GPaCbI6ozOcHv5aKRA+JNl3TLGMTZq1zqgAe
         +uNgl+f+dTkJ0Dvab4VhmGGDACKczhcaNzyagJcuSLdgEO5biRWXOgIUhx/WRbGJV61k
         t5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697033008; x=1697637808;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I/feldA9vSD69JZ+Q39K0lJKMvtA75LBDVAoVaS21Qk=;
        b=BGin/KjSlHwtpJjV7VSRFcMJY7o/5pwfZD9jQKflMSxzYgI80coDaRr+YyYn4FHrd1
         oAiOC5EPVKgoN4UZPHiKWeR/TWb94j2qlBkWurT5UbSXrFtOVSvmF2aHWEIX7qJ7teAB
         uNDPzU8g9SI8i+xh0XyJxb8P7xI+Ykd3a/TneVw4lPa645kvzRpUgJmOFE5bytJLJ2f5
         mqcO5LQdLINUVM3SlFLWu8jI2lsxG+Uh0/aqISiNCfOE8ivIfdFzIn25nusb7DSBYbNy
         p2KN0nqNy9f4Y0A91Qp5HTu94/BRUoL7H8OL07Mr00tObxol7FyKCB2O4TXAWnoRGxuD
         kfiQ==
X-Gm-Message-State: AOJu0Yy9Y2yv6c9BLm1LXisIlLwiqhSDlW8CfDf1dynV1JpGB7M6Tlwc
	y3DT1pq19FzV2HYaCC4EN8T+nw==
X-Google-Smtp-Source: AGHT+IEkVJMEBsFm2uVLPIDXC4h69rpsrQkUhT4PFf+QqfbAq3d7szT2jcC+xs6E1nAD/mkGyUGKlA==
X-Received: by 2002:a05:6000:4e1:b0:31f:fdd8:7d56 with SMTP id cr1-20020a05600004e100b0031ffdd87d56mr17877519wrb.12.1697033007796;
        Wed, 11 Oct 2023 07:03:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:d4e7:bb80:b09c:f1a7? ([2a01:e0a:b41:c160:d4e7:bb80:b09c:f1a7])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003fee567235bsm19245835wmk.1.2023.10.11.07.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Oct 2023 07:03:27 -0700 (PDT)
Message-ID: <6ec63a78-b0cc-452e-9946-0acef346cac2@6wind.com>
Date: Wed, 11 Oct 2023 16:03:26 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [RFC] netlink: add variable-length / auto integers
To: Johannes Berg <johannes@sipsolutions.net>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc: fw@strlen.de, pablo@netfilter.org, jiri@resnulli.us, mkubecek@suse.cz,
 aleksander.lobakin@intel.com, Thomas Haller <thaller@redhat.com>
References: <20231011003313.105315-1-kuba@kernel.org>
 <f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
Content-Language: en-US
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Le 11/10/2023 à 15:11, Johannes Berg a écrit :
> +Thomas Haller, if you didn't see it yet.
> 
> 
> On Tue, 2023-10-10 at 17:33 -0700, Jakub Kicinski wrote:
>> We currently push everyone to use padding to align 64b values in netlink.
>> I'm not sure what the story behind this is. I found this:
>> https://lore.kernel.org/all/1461339084-3849-1-git-send-email-nicolas.dichtel@6wind.com/#t
There was some attempts before:
https://lore.kernel.org/netdev/20121205.125453.1457654258131828976.davem@davemloft.net/
https://lore.kernel.org/netdev/1355500160.2626.9.camel@bwh-desktop.uk.solarflarecom.com/
https://lore.kernel.org/netdev/1461142655-5067-1-git-send-email-nicolas.dichtel@6wind.com/

>> but it doesn't go into details WRT the motivation.
>> Even for arches which don't have good unaligned access - I'd think
>> that access aligned to 4B *is* pretty efficient, and that's all
>> we need. Plus kernel deals with unaligned input. Why can't user space?
> 
> Hmm. I have a vague recollection that it was related to just not doing
> it - the kernel will do get_unaligned() or similar, but userspace if it
> just accesses it might take a trap on some architectures?
> 
> But I can't find any record of this in public discussions, so ...
If I remember well, at this time, we had some (old) architectures that triggered
traps (in kernel) when a 64-bit field was accessed and unaligned. Maybe a mix
between 64-bit kernel / 32-bit userspace, I don't remember exactly. The goal was
to align u64 fields on 8 bytes.


Regards,
Nicolas

> 
> 
> In any case, I think for _new_ attributes it would be perfectly
> acceptable to do it without padding, as long as userspace is prepared to
> do unaligned accesses for them, so we might need something in libnl (or
> similar) to do it correctly.
> 
>> Padded 64b is quite space-inefficient (64b + pad means at worst 16B
>> per attr vs 32b which takes 8B). It is also more typing:
>>
>>     if (nla_put_u64_pad(rsp, NETDEV_A_SOMETHING_SOMETHING,
>>                         value, NETDEV_A_SOMETHING_PAD))
>>
>> Create a new attribute type which will use 32 bits at netlink
>> level if value is small enough (probably most of the time?),
>> and (4B-aligned) 64 bits otherwise. Kernel API is just:
>>
>>     if (nla_put_uint(rsp, NETDEV_A_SOMETHING_SOMETHING, value))
>>
>> Calling this new type "just" sint / uint with no specific size
>> will hopefully also make people more comfortable with using it.
>> Currently telling people "don't use u8, you may need the space,
>> and netlink will round up to 4B, anyway" is the #1 comment
>> we give to newcomers.
> 
> Yeah :)
> 
>> Thoughts?
> 
> Seems reasonable. I thought about endian variants, but with the variable
> size that doesn't make much sense.
> 
> I do think the documentation in the patch could be clearer about the
> alignment, see below.
> 
>> +++ b/include/net/netlink.h
>> @@ -183,6 +183,8 @@ enum {
>>  	NLA_REJECT,
>>  	NLA_BE16,
>>  	NLA_BE32,
>> +	NLA_SINT,
>> +	NLA_UINT,
> 
> You should also update the policy-related documentation in this file.
> 
>> +++ b/include/uapi/linux/netlink.h
>> @@ -298,6 +298,8 @@ struct nla_bitfield32 {
>>   *	entry has attributes again, the policy for those inner ones
>>   *	and the corresponding maxtype may be specified.
>>   * @NL_ATTR_TYPE_BITFIELD32: &struct nla_bitfield32 attribute
>> + * @NL_ATTR_TYPE_SINT: 32-bit or 64-bit signed attribute, aligned to 4B
>> + * @NL_ATTR_TYPE_UINT: 32-bit or 64-bit unsigned attribute, aligned to 4B
> 
> This is only for exposing the policy (policy description), not sure the
> alignment thing matters here?
> 
> OTOH, there's nothing in this file that ever describes *any* of the
> attributes, yet in pracice all the uapi headers do refer to NLA_U8 and
> similar - so we should probably have a new comment section here in the
> UAPI that describes the various types as used by the documentation of
> other families?
> 
> Anyway, I think some kind of bigger "careful with alignment" here would
> be good, so people do the correct thing and not just "if (big)
> nla_get_u64()" which would get the alignment thing problematic again.
> 
> johannes

