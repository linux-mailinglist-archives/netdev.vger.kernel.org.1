Return-Path: <netdev+bounces-168315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1741FA3E7FE
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 00:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D0216E4CA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 23:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9835A214210;
	Thu, 20 Feb 2025 23:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vS1t529t"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5543179A7
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740092582; cv=none; b=hlZPfmEpglrR6LJ7o0c6RfBungm86xcsPmrDzXwpDvWEz2Gb5yYcT1ChS5KggWMjohRaPJfMygq31dUA3eJ0p/xIvnvO5C3OexLSZKSzJ1u79Nl8xTu2gtkRNHT38tPSBHnZIeui7XDshCe345WRw5jYZandkLHeDcuujBDwdG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740092582; c=relaxed/simple;
	bh=uIaVptdvr0a2z/TZwEzCoqF9O1XeyQPSwljljV4KEUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDZwBysIi45lJ3QObUrxn70fLud2+fq2SNWFxHx92RUw+zINm52HhkozAqycMhzIkuULDGe0ecKtCdXUpP0KTJsa0xG38x55LzCWIrHPdbtsyZF1z68rq4lPVyNB28K1Q6piuqtBi9TNnmsm4P1NFUa+4XFN3gqyOcvecEnQgd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vS1t529t; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <04bfac2e-e28d-45eb-a715-59ac4b58aca8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740092568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Eu8pMeDIWiKwVDhxOuwqXCLJhjCur03nD0DkknqcV4=;
	b=vS1t529tZKZ0RVfPV34OM2ab9Z/C/GYc2cnXMDl7QjatidUR/luDmlrGsM3LBgbbV9nsdj
	McIk/Erc3cnT8z+jLTzYBe65foflrxUu9F/lC4SC0rUnEKGae4ypjvztifKaBZyqxrfju/
	a67HouTb1fGHwe1rCfJ6cf+bpiW03cE=
Date: Thu, 20 Feb 2025 15:02:41 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v13 00/12] net-timestamp: bpf extension to equip
 applications transparently
To: Jason Xing <kerneljasonxing@gmail.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 ykolal@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250220072940.99994-1-kerneljasonxing@gmail.com>
 <67b74b0ca099e_261ab62945f@willemb.c.googlers.com.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <67b74b0ca099e_261ab62945f@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/20/25 7:32 AM, Willem de Bruijn wrote:
> Jason Xing wrote:
>> "Timestamping is key to debugging network stack latency. With
>> SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
>> network issues can be attributed to the kernel." This is extracted
>> from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
>> addressed by Willem de Bruijn at netdevconf 0x17).
>>
>> There are a few areas that need optimization with the consideration of
>> easier use and less performance impact, which I highlighted and mainly
>> discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
>> uAPI compatibility, extra system call overhead, and the need for
>> application modification. I initially managed to solve these issues
>> by writing a kernel module that hooks various key functions. However,
>> this approach is not suitable for the next kernel release. Therefore,
>> a BPF extension was proposed. During recent period, Martin KaFai Lau
>> provides invaluable suggestions about BPF along the way. Many thanks
>> here!
>>
>> This series adds the BPF networking timestamping infrastructure through
>> reusing most of the tx timestamping callback that is currently enabled
>> by the SO_TIMESTAMPING.. This series also adds TX timestamping support
>> for TCP. The RX timestamping and UDP support will be added in the future.

Thanks for working on this BPF feature. Applied.

> This series addresses all my feedback.
> 
> The timestamping patches all have my Reviewed-by.

Thanks to Willem and other reviewers for their input in this long thread across 
many revisions.


