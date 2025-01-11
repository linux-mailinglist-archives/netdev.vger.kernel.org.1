Return-Path: <netdev+bounces-157414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3D5A0A40E
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F0A169591
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17191AB6FF;
	Sat, 11 Jan 2025 14:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="st1HNpK1"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8958C197A9F
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 14:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736604690; cv=none; b=QPME3FSGyo/wcJB2QB6i744gjtrekIaeRCvGJtwYbU51T8YIMm1gMjyofN1pX417BK2q1ivFUjzTj1NNhXwW+EbiifnjXX2Q1KXufcBUG1sUE0r5CLiTu0kik1C8rwEKyARVLfPToKA+uPHN0cJBtmUMhU4NsIKr1BUEMMUA2Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736604690; c=relaxed/simple;
	bh=9h4ZD1IDqP9E/vf/akoSSEC99OqdL708QpurCSiFMQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHaM+frqejeFy6G2Eba0GYZlZoeIdz/2SpBXchMjOXmxIU1zlG6A4p8cFQ/9k/YLfd7HUeqICZy9tS8u6sUpC2qHi0kqG7s9DQKKGzg7V0jDKp+zwEN+XDZYVTT18PQQvwmWaI6BOEb3Xai/RL6YlP1P4IBDC0iWsguAdaR8CMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=st1HNpK1; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <679e160b-6cab-43d6-990c-d1df0e243995@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736604685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9h4ZD1IDqP9E/vf/akoSSEC99OqdL708QpurCSiFMQQ=;
	b=st1HNpK1lKF5h6iJNdadlg66JAbDi/8O40sNUwm5za/QvR50AsnS6PVXYhHmUKDbhl3N0M
	vOTx5Wqg3omXbJjmBep69VUssRt5hKyaNflItMX8/H3r2Q8RZ5cZMXab1kxSxcfxFP+yGm
	dMdenXoutdJgzE4pP7lIr5Q1n0/OPyc=
Date: Sat, 11 Jan 2025 22:10:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] MAINTAINERS: Become the stmmac maintainer
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Huacai Chen <chenhuacai@kernel.org>
References: <20250110144944.32766-1-si.yanteng@linux.dev>
 <5e1c9623-30cb-48c8-865b-cbdc2c08f0f3@lunn.ch>
 <20250110165458.43e312bf@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250110165458.43e312bf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Jakub, Andrew,

On 1/11/25 08:54, Jakub Kicinski wrote:
> On Fri, 10 Jan 2025 18:22:03 +0100 Andrew Lunn wrote:
>> On Fri, Jan 10, 2025 at 10:49:43PM +0800, Yanteng Si wrote:
>>> I am the author of dwmac-loongson. The patch set was merged several
>>> months ago. For a long time hereafter, I don't wish stmmac to remain
>>> in an orphan state perpetually. Therefore, if no one is willing to
>>> assume the role of the maintainer, I would like to be responsible for
>>> the subsequent maintenance of stmmac. Meanwhile, Huacai is willing to
>>> become a reviewer.
>>>
>>> About myself, I submitted my first kernel patch on January 4th, 2021.
>>> I was still reviewing new patches last week, and I will remain active
>>> on the mailing list in the future.
>>>
>>> Co-developed-by: Huacai Chen <chenhuacai@kernel.org>
>>> Signed-off-by: Huacai Chen <chenhuacai@kernel.org>
>>> Signed-off-by: Yanteng Si <si.yanteng@linux.dev>
>> Thanks for volunteering for this. Your experience adding loongson
>> support will be useful here. But with a driver of this complexity, and
>> the number of different vendors using it, i think it would be good if
>> you first established a good reputation for doing the work before we
>> add you to the Maintainers. There are a number of stmmac patches on
>> the list at the moment, please actually do the job of being a
>> Maintainer and spend some time review them.
>>
>> A Synopsis engineer has also said he would start doing Maintainer
>> work. Hopefully in the end we can add you both to MAINTAINERS.
> +1, thanks a lot for volunteering! There are 22 patches for stmmac
> pending review in patchwork, so please don't hesitate and start
> reviewing and testing.

Okay, thank you for your encouragement.

In the following period of time, I will try to review and

test the patches of stmmac.


Thanks,

Yanteng


