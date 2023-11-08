Return-Path: <netdev+bounces-46552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE697E4E99
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 02:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308BF1C20A5F
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 01:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEDA65B;
	Wed,  8 Nov 2023 01:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tAlg/l9M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1537EA
	for <netdev@vger.kernel.org>; Wed,  8 Nov 2023 01:31:37 +0000 (UTC)
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 17:31:37 PST
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [IPv6:2001:41d0:203:375::ad])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0196F197
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 17:31:36 -0800 (PST)
Message-ID: <61cbf731-1592-4b2d-b748-901668fe3610@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1699406671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UnJmeCmGkR8PgzQegyp8K/o1jg7O7yU7ISwAx8Gsk7I=;
	b=tAlg/l9MrokO2KGYcLn9pS32qrcotpyM2Ff9MMaS3JPBEPlEwJXfTb7pubQSe+SW2RX5dX
	/R8fIng8Nd6EFo34KLNoyp9RRpegxy/n3j606iE3n1987O5YG2MQkkCLPkRcDv6r7mO/qI
	UnDnoWezoOPDJ8ten9/aXq6NhKZxj4Q=
Date: Wed, 8 Nov 2023 09:24:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next 3/6] RDMA/rxe: Register IP mcast address
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
 linux-rdma@vger.kernel.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20231103204324.9606-1-rpearsonhpe@gmail.com>
 <20231103204324.9606-4-rpearsonhpe@gmail.com>
 <30513a47-68c6-410f-bbfb-09211f07b082@linux.dev>
 <a0b998f6-7c03-466e-b163-3317f7a5576c@gmail.com>
 <0f190158-d39f-45b0-be07-73977bfb40b7@linux.dev>
 <9759a166-b302-46c0-9277-058152af45ef@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <9759a166-b302-46c0-9277-058152af45ef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2023/11/7 1:31, Bob Pearson 写道:
> 
> 
> On 11/6/23 07:26, Zhu Yanjun wrote:
>>
>> 在 2023/11/6 4:19, Bob Pearson 写道:
>>>
>>>
>>> On 11/4/23 07:42, Zhu Yanjun wrote:
>>>
>>>>
>>>> Using reverse fir tree, a.k.a. reverse Christmas tree or reverse 
>>>> XMAS tree, for
>>>>
>>>> variable declarations isn't strictly required, though it is still 
>>>> preferred.
>>>>
>>>> Zhu Yanjun
>>>>
>>>>
>>> Yeah. I usually follow that style for new code (except if there are
>>> dependencies) but mostly add new variables at the end of the list
>>> together  because it makes the patch simpler to read. At least it
>>> does for me. If you care, I am happy to fix this.
>>
>> Yes. It is good to fix it.
>>
>> And your commits add mcast address supports. And I think you
>>
>> should have the test case in the rdma-core to verify these commits.
>>
>> Can you share the test case in the rdma maillist? ^_^
>>
>> Zhu Yanjun
>>
>>>
>>> Bob
> 
> I could share it but it's not really in a good shape to publish. I
> have to modify the limits in rxe_param.h to test max_etc. And currently
> I need to hand edit the send/recv versions to do node to node. In other
> words just enough to (by hand) work through the use cases enough to
> convince myself it works using ip maddr and wireshark along with the
> program.
> 
> What you are asking for is a bunch of work to make the test program
> more like iperf or ib_send_bw. Ideally it should either reload the
> driver or do something else to let each test case be a clean start.

Got it.
Anyway, a test case in rdma-core is needed to make tests with this feature.

And this feature is related with mcast. So please also send these 
commits to NETDEV maillist. NETDEV people can also give us a lot of good 
advice.

Thanks,
Zhu Yanjun

> 
> In an ideal world there would be a two node version of pyverbs. :-)
> 
> Bob


