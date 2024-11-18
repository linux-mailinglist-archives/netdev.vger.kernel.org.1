Return-Path: <netdev+bounces-145912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617E9D14D7
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E881F223C4
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 15:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2441A9B3D;
	Mon, 18 Nov 2024 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r/ar/5vu"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78D196C7C
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731945475; cv=none; b=bjnQq9bHBenk7spkj6JWUvjKMQYOVJhGqCuGQAToEQE4V/0FknyoRtLLmyllzBJlYM+ISDDAC7+TCBrZd5XE0mKbZEkOzDX9wak529xWrMI8r2F0nkdOJTi1aWENQiQmLD5S6Eh+KrNBdjVJtHbQijyElRS2odEHcIafvEoW/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731945475; c=relaxed/simple;
	bh=OnZFbH4ZIWUv8sP7/VXOXQh7W9gNxnH7k9QBOi2znS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjXQWcN0UdSqL+x0WC/9tKGJ1RX2WZxB9+CvaAz7Cq2prKoM6FEYM+LKRJhfnpbea1R9RKvckhjRjLacXHisLrBVqvVYPax2VBriqwkHzL4rPUNijyyZNTB5PPeuke1tvt2pmNio1UDV4+uI3mROObEbsVsiVlrqPzI1cnQ/T+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r/ar/5vu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <410bf89c-7218-463d-9edf-f43fc1047c89@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731945471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vzs4vt6w15sXAXLkQP0Zktd5p6ChVpzECd9BbiSAAOM=;
	b=r/ar/5vugQgGutY0z0Ss+XPmIwu6J6w2HPZGeDs3ApIgamwCXf3GJbw9FSWUaxcRkUuJ2A
	Kupj79l47OSOExMAeKJM8A76/dKeZFQmeNq6B4yn5/lpk0NeXA4H3EZoCLj2MQjPMoJSd5
	EqtXQPfRJgcFNP0RtB08HgsY4+jv+4Q=
Date: Mon, 18 Nov 2024 10:57:45 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: xlnx,axi-ethernet: Add
 bindings for AXI 2.5G MAC
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Suraj Gupta <suraj.gupta2@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 radhey.shyam.pandey@amd.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 git@amd.com, harini.katakam@amd.com
References: <20241118081822.19383-1-suraj.gupta2@amd.com>
 <20241118081822.19383-2-suraj.gupta2@amd.com>
 <20241118165451.6a8b53ed@fedora.home>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20241118165451.6a8b53ed@fedora.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/18/24 10:54, Maxime Chevallier wrote:
> Hello,
> 
> On Mon, 18 Nov 2024 13:48:21 +0530
> Suraj Gupta <suraj.gupta2@amd.com> wrote:
> 
>> AXI 1G/2.5G Ethernet subsystem supports 1G and 2.5G speeds. "max-speed"
>> property is used to distinguish 1G and 2.5G MACs of AXI 1G/2.5G IP.
>> max-speed is made a required property, and it breaks DT ABI but driver
>> implementation ensures backward compatibility and assumes 1G when this
>> property is absent.
>> Modify existing bindings description for 2.5G MAC.
> 
> That may be a silly question, but as this is another version of the IP
> that behaves differently than the 1G version, could you use instead a
> dedicated compatible string for the 2.5G variant ?
> 
> As the current one is :
> 
> compatible = "xlnx,axi-ethernet-1.00.a";
> 
> it seems to already contain some version information.
> 
> But I might also be missing something :)

As it happens, this is not another version of the same IP but a
different configuration. It's just that no one has bothered to add 2.5G
support yet.

And to my understanding, the device tree should not contain any info
that can be reliably detected from the hardware.

--Sean

