Return-Path: <netdev+bounces-154883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C8BA00315
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 04:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03344188394E
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C62C155322;
	Fri,  3 Jan 2025 03:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="ji+iu5D7"
X-Original-To: netdev@vger.kernel.org
Received: from lf-2-37.ptr.blmpb.com (lf-2-37.ptr.blmpb.com [101.36.218.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61019475
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735874305; cv=none; b=OmPEAj+E0i5hbdknkiFFPXzC9hGhGMwujPui/F2nD5konoio0S1pb03eoWSwv4jPYO1B7nV+LWjIEKET7vgzFf/edhB+V6phUj4daJ6na68L7kcsHTVng5I2lF4sQfLWeP4956gcSMAh4VeY3tQb8jkYaC1E7adM8oARGWOQcTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735874305; c=relaxed/simple;
	bh=bboKaq5Q4NdJaTzde3DOJiF6pWQU5tusVze6Rg0p6qQ=;
	h=In-Reply-To:Mime-Version:References:Message-Id:To:Cc:Date:From:
	 Subject:Content-Type; b=t3zGTxahCAksXkrBiFs7odXv7dmw6Ymj4QboBGGXONWZ/tlk5XUne0VHNxvcCE/7v3EZXgLmMUs5891XFZ88EHxzQ2tca44GcCS03wqOeBfYn5y/7UthOqXYSzYPuWaYnWSM5BDA8rrK4gnc2brT9DS+ti9NpuI6aDY+d6pkJno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=ji+iu5D7; arc=none smtp.client-ip=101.36.218.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1735874221; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=uvlTnCo136ajNvWSe5dp3aXxhXuBCIVbBqZQneZ0u8E=;
 b=ji+iu5D78mReLMOIWBieHJADc2WYWCxixh9w1CdF3TWf+lopEIuY0oVb+ilAekoaIeXZ6z
 yQzvzzFzvKxA459ZeT4/kf4XrevwRVsb3Oa1OCFS8rBRWrLOl6O9nh+wPYghVPbfPCKC1c
 8r5sQ6X1tGl/kkcN76cDgYlfKbHtYysmBuuvL7k9GJRnYy6ATeG9cCijj/JIUO9+W94QzI
 PUd3+bC0zf75FWaNWgx/OsYBPhAUgSDq2hDtHCDkmYnKwJSLbKYc/JxWyp/26IXuOUQkhf
 csmkFXFvGhk3g4aXiidoSoa4qmY6P/IPpz8VME5NOagD98M66oJuQMakLfy8nA==
In-Reply-To: <20241231113412.GC81460@unreal>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241230101513.3836531-1-tianx@yunsilicon.com> <20241230101528.3836531-9-tianx@yunsilicon.com> <9409fd96-6266-4d8a-b8e9-cc274777cd2c@lunn.ch> <98a2deaf-5403-4f85-a353-00bfe12f5b13@yunsilicon.com> <45dfc294-76d8-4482-b857-4e3093ac829d@lunn.ch> <a09b9cda-5961-452b-84cb-844262e5b71a@yunsilicon.com> <20241231113412.GC81460@unreal>
Message-Id: <0b8611ca-e14b-44e1-b8e1-46222594aa3a@yunsilicon.com>
X-Lms-Return-Path: <lba+2677756ab+a54f94+vger.kernel.org+tianx@yunsilicon.com>
User-Agent: Mozilla Thunderbird
To: "Leon Romanovsky" <leon@kernel.org>
Cc: "Andrew Lunn" <andrew@lunn.ch>, "weihonggang" <weihg@yunsilicon.com>, 
	<netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<wanry@yunsilicon.com>
Date: Fri, 3 Jan 2025 11:16:56 +0800
X-Original-From: tianx <tianx@yunsilicon.com>
Received: from [127.0.0.1] ([183.193.167.29]) by smtp.feishu.cn with ESMTPS; Fri, 03 Jan 2025 11:16:58 +0800
From: "tianx" <tianx@yunsilicon.com>
Subject: Re: [PATCH v2 08/14] net-next/yunsilicon: Add ethernet interface
Content-Type: text/plain; charset=UTF-8

On 2024/12/31 19:34, Leon Romanovsky wrote:
> On Tue, Dec 31, 2024 at 05:40:15PM +0800, tianx wrote:
>> On 2024/12/31 13:12, Andrew Lunn wrote:
>>> On Tue, Dec 31, 2024 at 12:13:23AM +0800, weihonggang wrote:
>>>> Andrew, In another module(xsc_pci), we check xdev_netdev is NULL or no=
t
>>>> to see whether network module(xsc_eth) is loaded. we do not care about
>>>> the real type,and we do not want to include the related header files i=
n
>>>> other modules. so we use the void type.
>>> Please don't top post.
>>>
>>> If all you care about is if the module is loaded, turn it into a bool,
>>> and set it true.
>>>
>>> 	Andrew
>>   =C2=A0Hi, Andrew
>>
>> Not only the PCI module, but our later RDMA module also needs the netdev
>> structure in xsc_core_device to access network information. To simplify
>> the review, we haven't submitted the RDMA module, but keeping the netdev
>> helps avoid repeated changes when submitting later.
> Don't worry about RDMA at this point, your driver structure doesn't fit
> current multi-subsystem design.
>
> You will need to completely rewrite your "net-next/yunsilicon: Device and
> interface management" patch anyway when you will send us RDMA part.
>
> Please use auxiliary bus infrastructure to split your driver to separate
> it separate modules, instead of reinventing it.
>
> Thanks
>
Thank you, Leon. Auxiliary bus is really a good fit for our driver, and=20
we will modify in the next version.

