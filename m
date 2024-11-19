Return-Path: <netdev+bounces-146311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09989D2BE3
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 17:58:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A433A1F22E01
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7140D1D0F41;
	Tue, 19 Nov 2024 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="P5sP+b/f"
X-Original-To: netdev@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3E01CEAAA
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035233; cv=none; b=mrtwL5cYh58qG5WvjiBDshocbA7/wp/udCkdPpgkU6YRhEsGL6hGf3g/s9e4pgeft9HZ4ib332gN1Bl8YzlKkgrPJIR/L+5OjM7SlGbdpAdEtjBz284yeP9LkLrbxqiNRzhtCsF5ZivyKdJIEMujMaKaP+QTaT7H5K7Ei8IrHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035233; c=relaxed/simple;
	bh=XGrwKi67XF737xdiMkAN/AopG51wUhl1vugsRFoUkBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PS0p07W7VA5EN4WaBPwARrusfcREJyFCavPi12AcagoOoZvx0WdLga5hPCPSijKXYdI8m0WuESZbFnMHzYR7NK1K93+Msrjkz3/uW2Y4DdL/8XzTyPwMiVSdokPvwZa0VfN37YhxwHkzOFg6G0Ip1wTYBrit0GlorfOamI2hgmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=P5sP+b/f; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B9DCA340066;
	Tue, 19 Nov 2024 16:53:48 +0000 (UTC)
Received: from [172.20.0.209] (unknown [12.22.205.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 85F1113C2B0;
	Tue, 19 Nov 2024 08:53:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 85F1113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1732035228;
	bh=XGrwKi67XF737xdiMkAN/AopG51wUhl1vugsRFoUkBw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P5sP+b/fCh99OBgzLGOgzrBElrdgij7MQV2JszYWcXDHNEBionuRmx1A3WtGapmgs
	 SqX+EdnL8g2LAa+1iPtfmlGFNzbWLI33e6f8yZlrj12g62prXMVyHPAc4aUQ2zrQXo
	 hC6NX3H38P8qra0xNTGqTlBv/W9CWztTavP+Dtx4=
Message-ID: <303f83f8-e2cc-4a33-8bfe-ba490f932f18@candelatech.com>
Date: Tue, 19 Nov 2024 08:53:47 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GRE tunnels bound to VRF
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@idosch.org>
Cc: netdev <netdev@vger.kernel.org>
References: <86264c3a-d3f7-467b-b9d2-bdc43d185220@candelatech.com>
 <ZzsCNUN1vl01uZcX@shredder>
 <aafc4334-61e3-45e0-bdcd-a6dca3aa78ff@candelatech.com>
 <e138257e-68a9-4514-90e8-d7482d04c31f@candelatech.com>
 <b8b88a15-5b62-4991-ab0c-bb30a51e7be6@candelatech.com>
 <4a2f7ad9-6d38-4d9e-b665-80c29ff726d6@kernel.org>
Content-Language: en-MW
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <4a2f7ad9-6d38-4d9e-b665-80c29ff726d6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1732035229-1HnZjzXN1SbO
X-MDID-O:
 us5;ut7;1732035229;1HnZjzXN1SbO;<greearb@candelatech.com>;5d0776c40008f739dc5c0270debef63d
X-PPE-TRUSTED: V=1;DIR=OUT;

On 11/19/24 8:36 AM, David Ahern wrote:
> On 11/19/24 7:59 AM, Ben Greear wrote:
>>
>> Ok, I am happy to report that GRE with lower-dev bound to one VRF and
>> greX in a different
>> VRF works fine.
>>
> 
> mind sending a selftest that also documents this use case?
> 

I don't have an easy way to extract this into a shell script, but
at least as description:

Create VETH pair: rddVR0 rddVR1 in my case
rddVR0 has IP 2.2.2.1, in vrf0
rddVR1 has IP 2.2.2.2, in vrf1

# Create GRE device bound to rddVR1 (and indirectly bound to vrf1):
ip link add name gre1 up type gre remote 2.2.2.1 local 2.2.2.2 ttl 255 dev rddVR1

# Create GRE device bound to rddVR0 (and indirectly bound to vrf0)
ip link add name gre2 up type gre remote 2.2.2.2 local 2.2.2.1 ttl 255 dev rddVR0

Add gre1 to vrf11
Add gre2 to vrf00


gre1 IP address can be 10.1.1.2/32
gre2 IP address can be 10.1.1.1/32

And then you can generate TCP/UDP traffic between gre1 and gre2 if you bind to them in the normal
manner when using VRFs (SO_BINDTODEV or similar).

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

