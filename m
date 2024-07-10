Return-Path: <netdev+bounces-110613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2231A92D744
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 597D61C20D2B
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F278194C79;
	Wed, 10 Jul 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CrnMGvTx"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955DC34545
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 17:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631611; cv=none; b=fDmaWbhSEZ4yf5+JthT+P47TNyUIyfSpTntsIUckZKHX4x5RcwtCHEw1iD2BtPQQzFe5DIFFcd3pyy5J2PNO+sqLJF3GTbQZCGp16ehhsAZYcWuwMa2e37DJ+PUvRlrtI/+MgEtAH1kdll5JN5Gdhip83TwfirXWs4IOfvgHtBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631611; c=relaxed/simple;
	bh=PpwFZyJcTEANA8ii7bvn13zk1/NaXc/mGijZrOP6WNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V9Ruvz4sNiGA9lGtXA2cdZ574o9k0+sOIQNuRT9bkFz+ZVRx02DkmUDxfZk/RliAts/osbALMTuFIbEJPOm1qR59TsMs5/T0YuiBKtCyKalLAnHJOrkGY6jvMGLhWt+QqoQce/DTVHKN011HpGso1pd9Cp011v2ToOydv2zf7h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CrnMGvTx; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: daniel@iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720631607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JtDzTpankV+2ppodHebGXvxpgFTOogvB6IHT3oelcQ=;
	b=CrnMGvTxWHQA8abtNFrzqd/gVwKjEYj4gpD6QScUH1qR1y+C6iX08SAexOT3nLgWVOPPTv
	gldnoblswwL7BwGU0NpuGr3DvaZEjS8R8XjX/J3QPxcuemYvpS+I7Vio/EDYAD1VeXV71R
	VhRsVpHjhKoBFrx0tkNnJGvp5TpRnoM=
X-Envelope-To: bigeasy@linutronix.de
X-Envelope-To: syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com
X-Envelope-To: netdev@vger.kernel.org
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: davem@davemloft.net
X-Envelope-To: dsahern@kernel.org
X-Envelope-To: eddyz87@gmail.com
X-Envelope-To: edumazet@google.com
X-Envelope-To: haoluo@google.com
X-Envelope-To: john.fastabend@gmail.com
X-Envelope-To: jolsa@kernel.org
X-Envelope-To: kpsingh@kernel.org
X-Envelope-To: kuba@kernel.org
X-Envelope-To: pabeni@redhat.com
X-Envelope-To: sdf@fomichev.me
X-Envelope-To: sdf@google.com
X-Envelope-To: song@kernel.org
X-Envelope-To: syzkaller-bugs@googlegroups.com
X-Envelope-To: yonghong.song@linux.dev
X-Envelope-To: tglx@linutronix.de
X-Envelope-To: m.xhonneux@gmail.com
X-Envelope-To: dlebrun@google.com
Message-ID: <1874f2ac-4e76-41cc-b320-2903d77d5b96@linux.dev>
Date: Wed, 10 Jul 2024 10:13:18 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Remove tst_run from lwt_seg6local_prog_ops.
To: Daniel Borkmann <daniel@iogearbox.net>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, andrii@kernel.org,
 ast@kernel.org, davem@davemloft.net, dsahern@kernel.org, eddyz87@gmail.com,
 edumazet@google.com, haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 sdf@fomichev.me, sdf@google.com, song@kernel.org,
 syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev,
 Thomas Gleixner <tglx@linutronix.de>, Mathieu Xhonneux
 <m.xhonneux@gmail.com>, David Lebrun <dlebrun@google.com>
References: <20240710141631.FbmHcQaX@linutronix.de>
 <cb5d07ac-2224-6ac7-d2b2-cdc5db918106@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <cb5d07ac-2224-6ac7-d2b2-cdc5db918106@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/10/24 8:16 AM, Daniel Borkmann wrote:
> On 7/10/24 4:16 PM, Sebastian Andrzej Siewior wrote:
>> The syzbot reported that the lwt_seg6 related BPF ops can be invoked
>> via bpf_test_run() without without entering input_action_end_bpf()
>> first.
>>
>> Martin KaFai Lau said that self test for BPF_PROG_TYPE_LWT_SEG6LOCAL
>> probably didn't work since it was introduced in commit 04d4b274e2a
>> ("ipv6: sr: Add seg6local action End.BPF"). The reason is that the
>> per-CPU variable seg6_bpf_srh_states::srh is never assigned in the self
>> test case but each BPF function expects it.
>>
>> Remove test_run for BPF_PROG_TYPE_LWT_SEG6LOCAL.
>>
>> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
>> Reported-by: syzbot+608a2acde8c5a101d07d@syzkaller.appspotmail.com
>> Fixes: d1542d4ae4df ("seg6: Use nested-BH locking for seg6_bpf_srh_states.")
> 
> We can also add in addition for reference:
> 
> Fixes: 004d4b274e2a ("ipv6: sr: Add seg6local action End.BPF")

Added the Fixes tag before applying.

Thanks!


