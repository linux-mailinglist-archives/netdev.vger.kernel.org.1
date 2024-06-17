Return-Path: <netdev+bounces-103907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F8790A2A6
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 04:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6641C204F7
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 02:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DDE010A2A;
	Mon, 17 Jun 2024 02:53:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBA1367
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 02:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718592796; cv=none; b=txe4X7Gq5qC8YghpSpiIOg7gLxJfhzOlAS3z04cW4CHkrCjo3TOmZJf3MPBIDrD7NRSBeD7xh1/EYtidpv1Z6zo5JXKwsxoTmvlMOXdQHVWYrsLx1KZbLGHaUrNkfLpa2oIjegisfjulCRVf1boQhHo1CyxgI7pufCkMEiCx6IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718592796; c=relaxed/simple;
	bh=ee4ov1ZEVQs+gLyi8ucqcHJvV6GqUN0eHwcUY/NnVoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y7ceOmBVh9JwQgTej59eeUog2KL+SlLTI0/QFQaVTQmvRq5jyRl3RYXJuoqhkDODvZMTGsb9y85/OANH+ggrEjTZZ0mY+biEBxLJCq/UxNu7DOr1Vm1D/EWVvejrRSkAoN00UFemfwZd956f6Gjb0oK90kLrb/nhgYKzGGlGzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b80958102c5411ef9305a59a3cc225df-20240617
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:22e08927-6f10-4e91-b3e6-9f27473f6b23,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:28,RULE:Release_Ham,ACT
	ION:release,TS:33
X-CID-INFO: VERSION:1.1.38,REQID:22e08927-6f10-4e91-b3e6-9f27473f6b23,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
	N:release,TS:33
X-CID-META: VersionHash:82c5f88,CLOUDID:b026bdfa77b38599331b338f5e79df2c,BulkI
	D:240614185458SXRYECY3,BulkQuantity:6,Recheck:0,SF:24|17|19|44|64|66|38|10
	2,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40|20,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
	TF_CID_SPAM_FCD
X-UUID: b80958102c5411ef9305a59a3cc225df-20240617
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <luoxuanqiang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1424243327; Mon, 17 Jun 2024 10:53:04 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 815B0B80758A;
	Mon, 17 Jun 2024 10:53:04 +0800 (CST)
X-ns-mid: postfix-666FA510-32989244
Received: from [10.42.12.252] (unknown [10.42.12.252])
	by node2.com.cn (NSMail) with ESMTPA id 31DFCB80758A;
	Mon, 17 Jun 2024 02:53:03 +0000 (UTC)
Message-ID: <7b700f6e-3ad7-a358-8dd3-c5120a115344@kylinos.cn>
Date: Mon, 17 Jun 2024 10:53:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net v2] Fix race for duplicate reqsk on identical SYN
Content-Language: en-US
To: alexandre.ferrieux@orange.com, edumazet@google.com
Cc: davem@davemloft.net, dsahern@kernel.org, fw@strlen.de, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, kuniyu@amazon.com
References: <20240614102628.446642-1-luoxuanqiang@kylinos.cn>
 <1718586352627144.1.seg@mailgw.kylinos.cn>
From: luoxuanqiang <luoxuanqiang@kylinos.cn>
In-Reply-To: <1718586352627144.1.seg@mailgw.kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2024/6/17 07:45, alexandre.ferrieux@orange.com =E5=86=99=E9=81=93=
:
> On 14/06/2024 12:26, luoxuanqiang wrote:
>> When bonding is configured in BOND_MODE_BROADCAST mode, if two identic=
al
>> SYN packets are received at the same time and processed on different=20
>> CPUs,
>> it can potentially create the same sk (sock) but two different reqsk
>> (request_sock) in tcp_conn_request().
>>
>> These two different reqsk will respond with two SYNACK packets, and=20
>> since
>> the generation of the seq (ISN) incorporates a timestamp, the final tw=
o
>> SYNACK packets will have different seq values.
>>
>> The consequence is that when the Client receives and replies with an A=
CK
>> to the earlier SYNACK packet, we will reset(RST) it.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This is close, but not identical, to a race we observed on a *single*=20
> CPU with
> the TPROXY iptables target, in the following situation:
>
> =C2=A0- two identical SYNs, sent one second apart from the same client =
socket,
> =C2=A0=C2=A0 arrive back-to-back on the interface (due to network jitte=
r)
>
> =C2=A0- they happen to be handled in the same batch of packet from one =
softirq
> =C2=A0=C2=A0 name_your_nic_poll()
>
> =C2=A0- there, two loops run sequentially: one for netfilter (doing=20
> TPROXY), one
> =C2=A0=C2=A0 for the network stack (doing TCP processing)
>
> =C2=A0- the first generates two distinct contexts for the two SYNs
>
> =C2=A0- the second respects these contexts and never gets a chance to m=
erge=20
> them
>
> The result is exactly as you describe, but in this case there is no=20
> need for bonding,
> and everything happens in one single CPU, which is pretty ironic for a=20
> race.
> My uneducated feeling is that the two loops are the cause of a simulate=
d
> parallelism, yielding the race. If each packet of the batch was handled
> "to completion" (full netfilter handling followed immediately by full=20
> network
> stack ingestion), the problem would not exist.

Based on your explanation, I believe a
similar issue can occur on a single CPU if two SYN packets are processed
  closely enough. However, apart from using bond3 mode and having them
processed on different CPUs to facilitate reproducibility, I haven't
found a good way to replicate it.

Could you please provide a more practical example or detailed test
steps to help me understand the reproduction scenario you mentioned?
Thank you very much!


