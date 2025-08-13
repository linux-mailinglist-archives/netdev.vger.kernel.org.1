Return-Path: <netdev+bounces-213472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECD6B25315
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 20:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004B2687786
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 18:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC98292B3D;
	Wed, 13 Aug 2025 18:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="eCgEzyS7"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A2303C9D;
	Wed, 13 Aug 2025 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755110041; cv=none; b=Yc5OP3I7UnM8ou0Tw8EPU+itWaDVZfVd4LQsimZWdWESV4nuOaB7UWC/zTLyxYmXsYTcwTbYvyM4fncip4VbRg2tYeIvxG/NZk1LGFICp6/cv97STFdOJ7jQ42iGa4nxUm+WYGzUBINXTdg+VTZFLrRV8LVqhQKQEMD0qtT/WqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755110041; c=relaxed/simple;
	bh=IoaxbL2xxkdOawW0Ymk9cFwtaLc9U6tdBeFEyNZmQzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GmfciT6B/fl10LmjKJkcto7Lb0zGCW4QxhOyDU+0KDL4PySHldNGIt6rctqNcZOI25zeebRKrSmjzU8aSRUeL/WELWlULCwp1onEwbBJkw1d6N5NPC0A2Vgv574OwWWFBfFDXgDg9/5OX01kvL4YIk8YHW2kT/yUuT4+g+7LDPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (2048-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=eCgEzyS7; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from tu-ex02.tu-dortmund.de (tu-ex02.tu-dortmund.de [129.217.131.228])
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPS id 57DIXsHG010589
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 20:33:54 +0200 (CEST)
Authentication-Results: unimail.uni-dortmund.de;
	dkim=pass (2048-bit key, unprotected) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.a=rsa-sha256 header.s=1 header.b=eCgEzyS7
DKIM-Signature: v=1; a=rsa-sha256; d=tu-dortmund.de; s=1; c=relaxed/relaxed;
	t=1755110034; h=from:subject:to:date:message-id;
	bh=IoaxbL2xxkdOawW0Ymk9cFwtaLc9U6tdBeFEyNZmQzI=;
	b=eCgEzyS7MM/Jg2P/aJ+fVGf1VnjG8c45dAch5/m72fBm1R53h3l10WjbGjj0aI/6lSKcOZfa1sy
	DF8d20cXGi2yTwcx3d+p6ISJmCKI2gl73kcarXEtn/xQG/RbA2cJ3ynefuY4GLGHgp1Pt4lRGD4AM
	KaMJtrrMfKhyJxaYbooqAH8eAckfs+94QLQnm4g43YUk7+17lZoeaaGLqfAuLpdWXPqQ0FJVKQkIq
	nqM/MRdNlfRVeczpa/UjF3piJG7YEznIDeDp0Fswjw54io9/avk3DxOlvsMOar2jV918zItpVqqsT
	SiPrdUq2+Hzl2hFXei/wUE2Hwu0Dk1RRn8Rg==
Received: from [IPV6:2a01:599:41d:36e2:83f0:e388:1505:7af] (129.217.131.221)
 by tu-ex02.tu-dortmund.de (2001:638:50d:2000::228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Wed, 13 Aug 2025 20:33:54 +0200
Message-ID: <4fca87fe-f56a-419d-84ba-6897ee9f48f5@tu-dortmund.de>
Date: Wed, 13 Aug 2025 20:33:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net v2] TUN/TAP: Improving throughput and latency by avoiding
 SKB drops
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <willemdebruijn.kernel@gmail.com>, <jasowang@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tim Gebauer
	<tim.gebauer@tu-dortmund.de>
References: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
 <20250813080128.5c024489@hermes.local>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20250813080128.5c024489@hermes.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: tu-ex03.tu-dortmund.de (2001:638:50d:2000::229) To
 tu-ex02.tu-dortmund.de (2001:638:50d:2000::228)

Stephen Hemminger wrote:
> On Tue, 12 Aug 2025 00:03:48 +0200
> Simon Schippers <simon.schippers@tu-dortmund.de> wrote:
>
>> This patch is the result of our paper with the title "The NODROP Patch:
>> Hardening Secure Networking for Real-time Teleoperation by Preventing
>> Packet Drops in the Linux TUN Driver" [1].
>> It deals with the tun_net_xmit function which drops SKB's with the reaso=
n
>> SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
>> resulting in reduced TCP performance and packet loss for bursty video
>> streams when used over VPN's.
>>
>> The abstract reads as follows:
>> "Throughput-critical teleoperation requires robust and low-latency
>> communication to ensure safety and performance. Often, these kinds of
>> applications are implemented in Linux-based operating systems and transm=
it
>> over virtual private networks, which ensure encryption and ease of use b=
y
>> providing a dedicated tunneling interface (TUN) to user space
>> applications. In this work, we identified a specific behavior in the Lin=
ux
>> TUN driver, which results in significant performance degradation due to
>> the sender stack silently dropping packets. This design issue drasticall=
y
>> impacts real-time video streaming, inducing up to 29 % packet loss with
>> noticeable video artifacts when the internal queue of the TUN driver is
>> reduced to 25 packets to minimize latency. Furthermore, a small queue
>> length also drastically reduces the throughput of TCP traffic due to man=
y
>> retransmissions. Instead, with our open-source NODROP Patch, we propose
>> generating backpressure in case of burst traffic or network congestion.
>> The patch effectively addresses the packet-dropping behavior, hardening
>> real-time video streaming and improving TCP throughput by 36 % in high
>> latency scenarios."
>>
>> In addition to the mentioned performance and latency improvements for VP=
N
>> applications, this patch also allows the proper usage of qdisc's. For
>> example a fq_codel can not control the queuing delay when packets are
>> already dropped in the TUN driver. This issue is also described in [2].
>>
>> The performance evaluation of the paper (see Fig. 4) showed a 4%
>> performance hit for a single queue TUN with the default TUN queue size o=
f
>> 500 packets. However it is important to notice that with the proposed
>> patch no packet drop ever occurred even with a TUN queue size of 1 packe=
t.
>> The utilized validation pipeline is available under [3].
>>
>> As the reduction of the TUN queue to a size of down to 5 packets showed =
no
>> further performance hit in the paper, a reduction of the default TUN que=
ue
>> size might be desirable accompanying this patch. A reduction would
>> obviously reduce buffer bloat and memory requirements.
>>
>> Implementation details:
>> - The netdev queue start/stop flow control is utilized.
>> - Compatible with multi-queue by only stopping/waking the specific
>> netdevice subqueue.
>> - No additional locking is used.
>>
>> In the tun_net_xmit function:
>> - Stopping the subqueue is done when the tx_ring gets full after inserti=
ng
>> the SKB into the tx_ring.
>> - In the unlikely case when the insertion with ptr_ring_produce fails, t=
he
>> old dropping behavior is used for this SKB.
>>
>> In the tun_ring_recv function:
>> - Waking the subqueue is done after consuming a SKB from the tx_ring whe=
n
>> the tx_ring is empty. Waking the subqueue when the tx_ring has any
>> available space, so when it is not full, showed crashes in our testing. =
We
>> are open to suggestions.
>> - When the tx_ring is configured to be small (for example to hold 1 SKB)=
,
>> queuing might be stopped in the tun_net_xmit function while at the same
>> time, ptr_ring_consume is not able to grab a SKB. This prevents
>> tun_net_xmit from being called again and causes tun_ring_recv to wait
>> indefinitely for a SKB in the blocking wait queue. Therefore, the netdev
>> queue is woken in the wait queue if it has stopped.
>> - Because the tun_struct is required to get the tx_queue into the new tx=
q
>> pointer, the tun_struct is passed in tun_do_read aswell. This is likely
>> faster then trying to get it via the tun_file tfile because it utilizes =
a
>> rcu lock.
>>
>> We are open to suggestions regarding the implementation :)
>> Thank you for your work!
>>
>> [1] Link:
>> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publication=
s/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
>> [2] Link:
>> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffect=
ive-on-tun-device
>> [3] Link: https://github.com/tudo-cni/nodrop
>>
>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>
> I wonder if it would be possible to implement BQL in TUN/TAP?
>
> https://lwn.net/Articles/454390/
>
> BQL provides a feedback mechanism to application when queue fills.

Thank you very much for your reply,
I also thought about BQL before and like the idea!

However I see the following challenges in the implementation:
- netdev_tx_sent_queue is no problem, it would just be called in
tun_net_xmit function.
- netdev_tx_completed_queue is challenging, because there is no completion
routine like in a "normal" network driver. tun_ring_recv reads one SKB at
a time and therefore I am not sure when and with what parameters to call
the function.
- What to do with the existing TUN queue packet limit (500 packets
default)? Use it as an upper limit?

Wichtiger Hinweis: Die Information in dieser E-Mail ist vertraulich. Sie is=
t ausschlie=C3=9Flich f=C3=BCr den Adressaten bestimmt. Sollten Sie nicht d=
er f=C3=BCr diese E-Mail bestimmte Adressat sein, unterrichten Sie bitte de=
n Absender und vernichten Sie diese Mail. Vielen Dank.
Unbeschadet der Korrespondenz per E-Mail, sind unsere Erkl=C3=A4rungen auss=
chlie=C3=9Flich final rechtsverbindlich, wenn sie in herk=C3=B6mmlicher Sch=
riftform (mit eigenh=C3=A4ndiger Unterschrift) oder durch =C3=9Cbermittlung=
 eines solchen Schriftst=C3=BCcks per Telefax erfolgen.

Important note: The information included in this e-mail is confidential. It=
 is solely intended for the recipient. If you are not the intended recipien=
t of this e-mail please contact the sender and delete this message. Thank y=
ou. Without prejudice of e-mail correspondence, our statements are only leg=
ally binding when they are made in the conventional written form (with pers=
onal signature) or when such documents are sent by fax.

