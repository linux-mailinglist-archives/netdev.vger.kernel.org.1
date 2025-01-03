Return-Path: <netdev+bounces-154885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C6EA0032C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 04:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF7F3A05D2
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9774CA6F;
	Fri,  3 Jan 2025 03:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="HmAmRXAr"
X-Original-To: netdev@vger.kernel.org
Received: from lf-1-18.ptr.blmpb.com (lf-1-18.ptr.blmpb.com [103.149.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D79628E8
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.149.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735875150; cv=none; b=e9TNCNEUoLnKt6F+SzXMlNHaxSSrK3z8p5Q3fH2eKJTNxLNAVeIJkkFS4czpwSbLyiFKaMZlgnqzoSuDIwZoQpj3rutlWJqFJPy0XcCecfn0VYGcK/P7ySakTOQVjNQyeFCxrvvpsWbxeXcRq2R9SEK7bUOBx1LNjG4rb1f6M6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735875150; c=relaxed/simple;
	bh=JWLKs3RSz8JpyNrZ0ONGl40jdYzWydPjuPZqynA84JE=;
	h=Date:Mime-Version:To:Content-Type:In-Reply-To:References:Cc:From:
	 Subject:Message-Id; b=US9R6TeU/YOy5s5PioMQWCwg60zh+neu6OgiLFZWySnPQwywQ3yLW7vYANWpfgaqZpP4ULEFMgKxqL86gQoOlGlQjWvficDa+0/saiJuFGXriD+BDincxpA36EWo9B/Sa/fwXmWIYtaW8ZXxtYfSxOr3dhJAyxJq+HDtGxhEw2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=HmAmRXAr; arc=none smtp.client-ip=103.149.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1735874936; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=D4luzFw9sYOzR8j8I0qxK/xR9+Iqq54y8QVzfX66iJ8=;
 b=HmAmRXArbKodObFEIPsuZ/fxqYwXTgyga3ghESrBhZGpviiuk7dczqwifoG4bOWrUSIS5P
 9eAG3j+z2C3ii8mFHhmlWwsDOB+aAmhIgy81ajB4O63PTUg1yVYDemKmy0pQM9QHCyZ4gR
 uLE4lESP0pDZiVkjqSRjXmc/SRyWd69/q4B+o90hLj7tOVusR2dbmG2r9NrHj8YbJ0w08k
 785kVyPz9p3qf2dQ6uchboN3FyrDLEBKBYccJxpyJwX96aTXPha7FXRFgxXhxHvklmnBwK
 ypvVQ/++LVscgsf/rpq+l4dlrAb/+xGEjYCns5p5hYLOUL5DUW2e5GArjUpGEg==
User-Agent: Mozilla Thunderbird
Received: from [127.0.0.1] ([183.193.167.29]) by smtp.feishu.cn with ESMTPS; Fri, 03 Jan 2025 11:28:52 +0800
Date: Fri, 3 Jan 2025 11:28:50 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: tianx <tianx@yunsilicon.com>
To: "Andrew Lunn" <andrew@lunn.ch>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+267775975+61da30+vger.kernel.org+tianx@yunsilicon.com>
In-Reply-To: <c2df7bd7-ae7f-4080-a4e3-aacdfb5d86c2@lunn.ch>
References: <20241230101513.3836531-1-tianx@yunsilicon.com> <20241230101528.3836531-9-tianx@yunsilicon.com> <9409fd96-6266-4d8a-b8e9-cc274777cd2c@lunn.ch> <98a2deaf-5403-4f85-a353-00bfe12f5b13@yunsilicon.com> <45dfc294-76d8-4482-b857-4e3093ac829d@lunn.ch> <a09b9cda-5961-452b-84cb-844262e5b71a@yunsilicon.com> <c2df7bd7-ae7f-4080-a4e3-aacdfb5d86c2@lunn.ch>
Cc: "weihonggang" <weihg@yunsilicon.com>, <netdev@vger.kernel.org>, 
	<andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<wanry@yunsilicon.com>
From: "tianx" <tianx@yunsilicon.com>
Subject: Re: [PATCH v2 08/14] net-next/yunsilicon: Add ethernet interface
Message-Id: <b9eaa2b5-6166-439c-9612-ab6ef41eb952@yunsilicon.com>
Content-Transfer-Encoding: quoted-printable

On 2024/12/31 23:40, Andrew Lunn wrote:
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
> So you might be rewriting this all in order to get the RDMA code
> merged.... But if not, just drop the void * cast. Make xdev_netdev a
> struct net_device *, etc.
>
> 	Andrew
Understood, I'll use struct net_device *.

