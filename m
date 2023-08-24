Return-Path: <netdev+bounces-30215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A0B786733
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 07:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1B91C20AEF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 05:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ECB24538;
	Thu, 24 Aug 2023 05:37:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C6E17E1
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 05:37:54 +0000 (UTC)
Received: from out-20.mta0.migadu.com (out-20.mta0.migadu.com [IPv6:2001:41d0:1004:224b::14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FFBE5A
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 22:37:53 -0700 (PDT)
Message-ID: <63e7a517-7918-d05a-c116-75395de5cdee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692855471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZ+n19irUN7daogCEBIYqOy7pOsHyUi/9RwMQ4IXucE=;
	b=OV8bJm7cG5saEbWv5a/mu+PjwnKolinGUxC40ez8cSMVoGVMGjsZoKh9HVP7NQ3ilOTwqb
	mFBQ5qcbpcBBWxK1pXjniLplBm5iSWKhHCGqCoBJ9kyljXdMZmZrR20avgNpBtiw/N8DGq
	NiufPVkcyv/Vh3yIvOyCwdCM4nhe+s4=
Date: Wed, 23 Aug 2023 22:37:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ss: support for BPF sk local storage
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>
References: <95161136-5834-4176-9faf-8531268705dc@naccy.de>
 <08d0b5ee-fb78-b1ad-2b18-f9fe6fd6c48b@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org,
 stephen@networkplumber.org, Martin KaFai Lau <kafai@fb.com>
In-Reply-To: <08d0b5ee-fb78-b1ad-2b18-f9fe6fd6c48b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/23/23 8:33 PM, David Ahern wrote:
> On 8/23/23 6:55 AM, Quentin Deslandes wrote:
>> Hi,
>>
>> Could it be possible to print BPF sk local storage data from ss?
>> Reading the original patch [1], it appears to have been thought
>> out this way, and it seems (to me) that it would fit ss' purpose.
>>
>> Please correct me if my assumptions are wrong.
>>
>> 1. https://lore.kernel.org/netdev/20190426233938.1330361-1-kafai@fb.com/
>>
>> Regards,
>> Quentin Deslandes
> 
> Adding Martin, author of the patches.
> 
> I have not looked into the details, but if the intent is ss style
> monitoring then please send a patch.

It will be great if ss can print out the bpf sk local storage data of a socket. 
It requires some libbpf API (like pretty printing data with btf), so this 
storage printing probably should only be supported when a more recent libbpf 
with those API is available.


