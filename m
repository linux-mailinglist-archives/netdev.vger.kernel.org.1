Return-Path: <netdev+bounces-213803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D15EB26C8B
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 18:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AD8558054E
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 16:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC0625334B;
	Thu, 14 Aug 2025 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="mnS/ZOOr"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7262E718B;
	Thu, 14 Aug 2025 16:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755188646; cv=none; b=sxO4FpFbov69eEAZd6Na8loJn59fo7TSHh9yif6t73hjYk9boABTjoc3QuiROBpUNAwkENjw8nfvxfohti75ffDf/3DsEVv/Rlp0b3VzNcmsDmm/Xg/qyDqBC51ey/wEmVcOyQBUAO+t5PsK6duFK78nUeAZIUOmm118EBceVo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755188646; c=relaxed/simple;
	bh=fX1ATbxdejOvQXo0hSRFuVGoykiEUL0jPzLZyhO30go=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q7Z5Ai05P+1E+8oMGUgFsgyfD/T1ApbtfqwV/U4FCgrVRCrUmJk3Fu6rSlYbrUuEkygCyDefU1t8xi6Ts7iRn5OMjn9Znn4qDtjTaQsS9VETA1nqFmllyCvRJwBhyXj90wzT5eZqUB9AmZwe9mubxHyvdylCJg2Eg+g7dDtdrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (2048-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=mnS/ZOOr; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from tu-ex02.tu-dortmund.de (tu-ex02.tu-dortmund.de [129.217.131.228])
	by unimail.uni-dortmund.de (8.18.1.10/8.18.1.10) with ESMTPS id 57EGNwsi025442
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Aug 2025 18:23:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; d=tu-dortmund.de; s=1; c=relaxed/relaxed;
	t=1755188638; h=from:subject:to:date:message-id;
	bh=fX1ATbxdejOvQXo0hSRFuVGoykiEUL0jPzLZyhO30go=;
	b=mnS/ZOOrdy/OJHmDcy5OsHzn07eXqh6cAgYpMoMX1GXpSKGdLg43lRb5LU/no6aFTiwun9jegyr
	QiRcrcLl26D6hl4VX5B6B9NZDtJlEGk2y7ykS3oGv9mVaZgJr1WVqmWRND6GK5M5v3xsKt5k8STcN
	buVFslzaVDz/Nf+ZP7hL7dC4tU/5pMrj8vtFLVDpViV9rz+uyzQvJ5iTRxdQU64/hppDmkBy/plCX
	WTc2iv25JTKq0NYSqrGbNzmByyi1vBbZVwhFjwv3RofBLl4zlBLefyxLpv73kCJhminuURZ7TKCMK
	5EY3jaNAcf8VXPtBVb/D0LklPSBjbNnWQLUA==
Received: from [IPV6:2a01:599:428:1102:83fd:984f:a177:2788] (129.217.131.221)
 by tu-ex02.tu-dortmund.de (2001:638:50d:2000::228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Thu, 14 Aug 2025 18:23:57 +0200
Message-ID: <f16b67e6-8279-4e52-82ca-f2ea68753f70@tu-dortmund.de>
Date: Thu, 14 Aug 2025 18:23:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net v2] TUN/TAP: Improving throughput and latency by avoiding
 SKB drops
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Stephen Hemminger
	<stephen@networkplumber.org>
CC: <jasowang@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>
References: <20250811220430.14063-1-simon.schippers@tu-dortmund.de>
 <20250813080128.5c024489@hermes.local>
 <4fca87fe-f56a-419d-84ba-6897ee9f48f5@tu-dortmund.de>
 <689dfc02cf665_18aa6c29427@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <689dfc02cf665_18aa6c29427@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: tu-ex06.tu-dortmund.de (2001:638:50d:2000::232) To
 tu-ex02.tu-dortmund.de (2001:638:50d:2000::228)

Willem de Bruijn wrote:
> Simon Schippers wrote:
>> Stephen Hemminger wrote:
>>> On Tue, 12 Aug 2025 00:03:48 +0200
>>> Simon Schippers <simon.schippers@tu-dortmund.de> wrote:
>>>
>>>> This patch is the result of our paper with the title "The NODROP Patch=
:
>>>> Hardening Secure Networking for Real-time Teleoperation by Preventing
>>>> Packet Drops in the Linux TUN Driver" [1].
>>>> It deals with the tun_net_xmit function which drops SKB's with the rea=
son
>>>> SKB_DROP_REASON_FULL_RING whenever the tx_ring (TUN queue) is full,
>>>> resulting in reduced TCP performance and packet loss for bursty video
>>>> streams when used over VPN's.
>>>>
>>>> The abstract reads as follows:
>>>> "Throughput-critical teleoperation requires robust and low-latency
>>>> communication to ensure safety and performance. Often, these kinds of
>>>> applications are implemented in Linux-based operating systems and tran=
smit
>>>> over virtual private networks, which ensure encryption and ease of use=
 by
>>>> providing a dedicated tunneling interface (TUN) to user space
>>>> applications. In this work, we identified a specific behavior in the L=
inux
>>>> TUN driver, which results in significant performance degradation due t=
o
>>>> the sender stack silently dropping packets. This design issue drastica=
lly
>>>> impacts real-time video streaming, inducing up to 29 % packet loss wit=
h
>>>> noticeable video artifacts when the internal queue of the TUN driver i=
s
>>>> reduced to 25 packets to minimize latency. Furthermore, a small queue
>>>> length also drastically reduces the throughput of TCP traffic due to m=
any
>>>> retransmissions. Instead, with our open-source NODROP Patch, we propos=
e
>>>> generating backpressure in case of burst traffic or network congestion=
.
>>>> The patch effectively addresses the packet-dropping behavior, hardenin=
g
>>>> real-time video streaming and improving TCP throughput by 36 % in high
>>>> latency scenarios."
>>>>
>>>> In addition to the mentioned performance and latency improvements for =
VPN
>>>> applications, this patch also allows the proper usage of qdisc's. For
>>>> example a fq_codel can not control the queuing delay when packets are
>>>> already dropped in the TUN driver. This issue is also described in [2]=
.
>>>>
>>>> The performance evaluation of the paper (see Fig. 4) showed a 4%
>>>> performance hit for a single queue TUN with the default TUN queue size=
 of
>>>> 500 packets. However it is important to notice that with the proposed
>>>> patch no packet drop ever occurred even with a TUN queue size of 1 pac=
ket.
>>>> The utilized validation pipeline is available under [3].
>>>>
>>>> As the reduction of the TUN queue to a size of down to 5 packets showe=
d no
>>>> further performance hit in the paper, a reduction of the default TUN q=
ueue
>>>> size might be desirable accompanying this patch. A reduction would
>>>> obviously reduce buffer bloat and memory requirements.
>>>>
>>>> Implementation details:
>>>> - The netdev queue start/stop flow control is utilized.
>>>> - Compatible with multi-queue by only stopping/waking the specific
>>>> netdevice subqueue.
>>>> - No additional locking is used.
>>>>
>>>> In the tun_net_xmit function:
>>>> - Stopping the subqueue is done when the tx_ring gets full after inser=
ting
>>>> the SKB into the tx_ring.
>>>> - In the unlikely case when the insertion with ptr_ring_produce fails,=
 the
>>>> old dropping behavior is used for this SKB.
>>>>
>>>> In the tun_ring_recv function:
>>>> - Waking the subqueue is done after consuming a SKB from the tx_ring w=
hen
>>>> the tx_ring is empty. Waking the subqueue when the tx_ring has any
>>>> available space, so when it is not full, showed crashes in our testing=
. We
>>>> are open to suggestions.
>>>> - When the tx_ring is configured to be small (for example to hold 1 SK=
B),
>>>> queuing might be stopped in the tun_net_xmit function while at the sam=
e
>>>> time, ptr_ring_consume is not able to grab a SKB. This prevents
>>>> tun_net_xmit from being called again and causes tun_ring_recv to wait
>>>> indefinitely for a SKB in the blocking wait queue. Therefore, the netd=
ev
>>>> queue is woken in the wait queue if it has stopped.
>>>> - Because the tun_struct is required to get the tx_queue into the new =
txq
>>>> pointer, the tun_struct is passed in tun_do_read aswell. This is likel=
y
>>>> faster then trying to get it via the tun_file tfile because it utilize=
s a
>>>> rcu lock.
>>>>
>>>> We are open to suggestions regarding the implementation :)
>>>> Thank you for your work!
>>>>
>>>> [1] Link:
>>>> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publicati=
ons/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
>>>> [2] Link:
>>>> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffe=
ctive-on-tun-device
>>>> [3] Link: https://github.com/tudo-cni/nodrop
>>>>
>>>> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>>>> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
>>>> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
>>>
>>> I wonder if it would be possible to implement BQL in TUN/TAP?
>>>
>>> https://lwn.net/Articles/454390/
>>>
>>> BQL provides a feedback mechanism to application when queue fills.
>>
>> Thank you very much for your reply,
>> I also thought about BQL before and like the idea!
>
> I would start with this patch series to convert TUN to a driver that
> pauses the stack rather than drops.
>
> Please reword the commit to describe the functional change concisely.
> In general the effect of drops on TCP are well understood. You can
> link to your paper for specific details.
>

I will remove the paper abstract for the v3 to have a more concise
description.
Also I will clarify why no packets are dropped anymore.

> I still suggest stopping the ring before a packet has to be dropped.
> Note also that there is a mechanism to requeue an skb rather than
> drop, see dev_requeue_skb and NETDEV_TX_BUSY. But simply pausing
> before empty likely suffices.
>

As explained before in my reply to Jason, this patch does stop the netdev
queue before a packet has to be dropped. It uses a very similar approach
to the suggested virtio_net.

> Relevant to BQL: did your workload include particularly large packets,
> e.g., TSO? Only then does byte limits vs packet limits matter.
>

No, in my workload I did not use TSO/GSO. However I think the most
important aspect is that the BQL algorithm utilizes a dynamic queue limit.
This will in most cases reduce the TUN queue size and reduce buffer bloat.

I now have a idea how to include BQL, but first I will add TAP support in
a v3. BQL could then be added in a v4.

Thank you :)

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

