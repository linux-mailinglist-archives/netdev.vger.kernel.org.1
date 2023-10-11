Return-Path: <netdev+bounces-40066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 792557C59C8
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 19:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A977C1C20C85
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8299629CF0;
	Wed, 11 Oct 2023 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="tyr5Zvm2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861F728DA6
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 17:01:58 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054229D
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:01:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5384975e34cso221726a12.0
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 10:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697043715; x=1697648515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7NIXA1ucUCV12pwpfrg8NPXnRgxiDz6QSZEKfTeY2c=;
        b=tyr5Zvm2aJ/vwJPr/b7IEI/oXPTFlvcA4cUQvGnwaVXy9ykUswoY1Wy+LjLqwKUXTM
         tWPKgTQdiBKkMOHENJf1B7shMPFJMqyJnwAQiT0OZ5MZyv3Sx9cratx1UuiYJ1TGT7FU
         nDqG7wJ/iGsSWqmgY3ofRytjZ/vWOXXvqwXwTfayfS28UscGOkb1rTha06/k98DRQHDL
         fao7n3uqYtJUfmxbTmmKK9ovwutZEylSnrq2Ut8fUeNGd4ZgAgiwJpwvMsZFAqgusqhh
         8T+GLyHznmtBRZNiIj5sopBuDuFcSXVFfT/HghD/udeY1la1WOsQ1ihBCtkwzab2ql3i
         bVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697043715; x=1697648515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7NIXA1ucUCV12pwpfrg8NPXnRgxiDz6QSZEKfTeY2c=;
        b=aWszaCJSjKBnuLrByH07pUW/EXzA6xCUjJc0jmXPSteOurXC003+VFkyjHFq+SsEtf
         lytMQ0MC8u03hY8Qx1JhNNPjoL/dfPLb0AUfYqThOVbtJxGP7CKfMjlX/FHvfW9C6iyj
         aULV6dZbmgCWBn/6g1s9VhaMfAzolfQ/ESDW/UdOFSh7ogks5cWntd0vLR2dn2/+uDIN
         wbnBUa1LRafNdbYA9SoOexga1H7mdWAtR/wsFo5dtSMQjQZq2zIW0ou59XvV+24QPvao
         6DA6Nmy7W9rJ9CbfGeuNJKQMW+OCWf0PHdObUOiTAaxUDFr1RIH5+41j11gFI4G+8a1M
         V9fg==
X-Gm-Message-State: AOJu0Yz5lMsJfFIeNB+bQppVioDzsB3AAP2wlLlxbsELRzBV1m4Gihly
	gvj2X59raEx28vyScnk+5EgZOA==
X-Google-Smtp-Source: AGHT+IE7jw2n1i/f1cOAo4Bji95Nno/FDz5iNcGSXMjS9CZB/TD1qEoKAAS1fsRsLT9XTHKRG/iLrA==
X-Received: by 2002:a05:6402:1cb1:b0:53b:3225:93c2 with SMTP id cz17-20020a0564021cb100b0053b322593c2mr12983316edb.8.1697043715458;
        Wed, 11 Oct 2023 10:01:55 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id v6-20020a056402184600b005333922efb0sm9102170edy.78.2023.10.11.10.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 10:01:54 -0700 (PDT)
Date: Wed, 11 Oct 2023 19:01:53 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
	johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org,
	mkubecek@suse.cz, aleksander.lobakin@intel.com
Subject: Re: [RFC] netlink: add variable-length / auto integers
Message-ID: <ZSbVASHPVoNfWwce@nanopsycho>
References: <20231011003313.105315-1-kuba@kernel.org>
 <ZSanRz7kV1rduMBE@nanopsycho>
 <20231011091624.4057e456@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011091624.4057e456@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 11, 2023 at 06:16:24PM CEST, kuba@kernel.org wrote:
>On Wed, 11 Oct 2023 15:46:47 +0200 Jiri Pirko wrote:
>> >Thoughts?  
>> 
>> Hmm, I assume that genetlink.yaml schema should only allow uint and sint
>> to be defined after this, so new genetlink implementations use just uint
>> and sint, correct?
>
>No, fixed types are still allowed, just discouraged.

Why? Is there goint to be warn in ynl gen?

>
>> Than we have genetlink.yaml genetlink-legacy.yaml genetlink-legacy2.yaml
>> ?
>> I guess in the future there might be other changes to require new
>> implemetation not to use legacy things. How does this scale?
>>
>> >This is completely untested. YNL to follow.
>> >---
>> > include/net/netlink.h        | 62 ++++++++++++++++++++++++++++++++++--
>> > include/uapi/linux/netlink.h |  5 +++
>> > lib/nlattr.c                 |  9 ++++++
>> > net/netlink/policy.c         | 14 ++++++--
>> > 4 files changed, 85 insertions(+), 5 deletions(-)
>> >
>> >diff --git a/include/net/netlink.h b/include/net/netlink.h
>> >index 8a7cd1170e1f..523486dfe4f3 100644
>> >--- a/include/net/netlink.h
>> >+++ b/include/net/netlink.h
>> >@@ -183,6 +183,8 @@ enum {
>> > 	NLA_REJECT,
>> > 	NLA_BE16,
>> > 	NLA_BE32,
>> >+	NLA_SINT,  
>> 
>> Why not just NLA_INT?
>
>Coin toss. Signed types are much less common in netlink
>so it shouldn't matter much.
>
>> >+static inline int nla_put_uint(struct sk_buff *skb, int attrtype, u64 value)
>> >+{
>> >+	u64 tmp64 = value;
>> >+	u32 tmp32 = value;
>> >+
>> >+	if (tmp64 == tmp32)
>> >+		return nla_put_u32(skb, attrtype, tmp32);  
>> 
>> It's a bit confusing, perheps better just to use nla_put() here as well?
>
>I want to underscore the equivalency to u32 for smaller types.

