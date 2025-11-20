Return-Path: <netdev+bounces-240222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E7C71B8A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 02:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 321AA34F6B0
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 01:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931091F8723;
	Thu, 20 Nov 2025 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="vk968b+G"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster5-host1-snip4-3.eps.apple.com [57.103.72.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04939846F
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 01:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763603366; cv=none; b=sY3hgvqd/0LocRNuCa7N4BjeCF5NISBhStxyLvkSdi4otHcRnfw4up5Yp+xS9fiq/W1DF1/PvmDfHXkPgivhQySue/ezXHZx2QSOnwhfIA4jhtXjDg23UCkSJL5DG2zvTRcK2C3HPfqMBtTiwDRw/GAVyKsIodCasl9yh0Oo04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763603366; c=relaxed/simple;
	bh=mblNpcAYzXlLPHao6o15h+dBL5z70PeXlX4O4+4Z50k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=frpbqVHt3yYeiHjZxD+1x6nLwizcMDSysRwJCuYEfVFW+VI9YiYdyA2H7R7mRAKUdRPotZ2VFc8LbdzRMyaFElKfOtQdpdhIxpRde3HjGwDfKkNoANXH60gqEjROI7O1rS5gTaYPjigrxPjza/WSlz1KlaPeJu2xp51rgMuOj/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=vk968b+G; arc=none smtp.client-ip=57.103.72.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-0 (Postfix) with ESMTPS id B821E180013C;
	Thu, 20 Nov 2025 01:49:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; bh=+x1v78Y5dS3KX3Xl1/XIL9djbMk9nT89vr6Nje0I8Lc=; h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme; b=vk968b+GhFo6wo8KrU0PgbeeuvaRljpxfY7iR4gREDGCP19zkgkl9qtJGC85JJEXgPQ1dv9/Kdw+RWgwRihPwJljutDoblMUtPQZmDW8Vt7mqcVYQmzH5Nz0D9kH9pllVfU71JQPScJIGhqr4mwiPs9ugishPehvkSylPfKChV2LABrsOGZKIV23ym5FVsDJZEaG5NIgVJWB2bJog/OloXZmnCrNM7YSvq6iC3O7AZbhIIrLXlFENOVgfQawXd2WGMN7r/DIA50v4xE3GcO+NUYK5Rjp2tOD3Mz8qs7YgBfkIQ/YzlesU9Q0W2oWgaEklYR0jFgHDlF2C0zojQSO/w==
Received: from smtpclient.apple (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-0 (Postfix) with ESMTPSA id 3AF261800124;
	Thu, 20 Nov 2025 01:49:21 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
From: Jon Kohler <jonmkohler@icloud.com>
In-Reply-To: <CANn89iKr4LUSaXk_5p-cot6rxDngLJ8G6_F1eouF3mGRXdHhUg@mail.gmail.com>
Date: Wed, 19 Nov 2025 20:49:08 -0500
Cc: "Hudson, Nick" <nhudson@akamai.com>,
 Jason Wang <jasowang@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD5D3F27-9E32-4B18-97D8-762F0C3A9285@icloud.com>
References: <20251106155008.879042-1-nhudson@akamai.com>
 <CACGkMEt1xybppvu2W42qWfabbsvRdH=1iycoQBOxJ3-+frFW6Q@mail.gmail.com>
 <5DBF230C-4383-4066-A4FB-56B80B42954E@akamai.com>
 <CANn89iK_v3CWvf7=QakbB3dwvJEOxuVjEn14rjmONaa1rKVWKw@mail.gmail.com>
 <7D7750CA-4637-4D4A-970C-CB1260E3ADBC@akamai.com>
 <CANn89iKr4LUSaXk_5p-cot6rxDngLJ8G6_F1eouF3mGRXdHhUg@mail.gmail.com>
To: Eric Dumazet <edumazet@google.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIwMDAwOCBTYWx0ZWRfX0XkFmu6UpArR
 nnbFsOw3Bn3vlrnlRoJQKIjRpR/yadRZYyOf+wgHmet0IpZjFCslvq/nn6N22Z3PPZZRmWxo9uT
 mL6CYFw825inZttstTHJvA9AjQ6VmXvUB1judEfkyuLgh1nlc6be4RuNImkiD+9iLVBBBmwpPdI
 mckS1+mdtkaPOwbGl+sF042qfgABekY6qyJlIL9yg3ee1BEIj6BUR/U0b3YkEFa8CVOXx00LpY/
 GQh2K0PDAzr1QmJhjxxUwGhyWWhDUQXXwMoT9Q2Q9vZV/W74DOuNXMkv0P1gt8eVCArw/qr81Tv
 sjtDgEBuXKhH/GhXH50
X-Proofpoint-ORIG-GUID: 1RHK0u-xp7olkkXGa5shhPn2FEGxkSjE
X-Authority-Info: v=2.4 cv=Ho972kTS c=1 sm=1 tr=0 ts=691e73a3 cx=c_apl:c_pps
 a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=x7bEGLp0ZPQA:10 a=azN_SmmUUI8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=1XWaLZrsAAAA:8 a=X7Ea-ya5AAAA:8
 a=20KFwNOVAAAA:8 a=9lgtCZJs5JIvLQylpJcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 1RHK0u-xp7olkkXGa5shhPn2FEGxkSjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1011 bulkscore=0
 malwarescore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511200008
X-JNJ: AAAAAAABnJ+fWtskoFB7M5TpCo9868XWOd8SDt9cXlBQl4CUyUGxHxYQsylGLUQX1haxXrsTxK678xe8PHdhraAJGLbyJQhoLcN35ACJxs+wRqJwKoipnCZDZCKKEBoAgwrX3mi9adpH5prSe3WBaSEVgWv/SjoUGAlg5IdabN4CZl0ycez5GBVYAsx7GKrwnToWG/l3cKI+NAAUTm33VF1SPrt8KwOX+6n93jJparm1CLiSTtGxk7shedwcLd3CjJSya6LkX+xHwxBEpNNRrISj+Xj0m1EB7WaUHn5fVfPiHqvDS6PapnbN/+Kzs2njURf5qrHqR1WGDE0fzKGXJSBDys+lC4Q7tYa8CjZmAzAtjKz6JsgOs0icwxgP5CL4jPYbg35ZZwAbCzUhHHeFh/8j3SWhNKK9y15gkgcJ8knd71o1PLe3ZUPOhR0edcvUC1rV6Qac+eM6Ru+uY6N20UoWSoqqS+SDlf4zw4dIm2J606iuUOO1KUd36ceivcWTTMgdhniaU8VApn9Sbt2OXafBf7JQgeo7JWYfuW2krWGWpUcimbo0P937wyDjs3IY3npPwIy+xagvaugwXCDwUuNmswMW2P6BedBGeWEoaVfNmVOJtu1SnAaTzoJxKWWoL1mzcl4I+BDc17NyN0YSNkSTeY2dCFaKJGrWsyC07J/IXEukPcYZqdFqHtBgzuuiDTB2OgMRjKAGKk9FExjOUFJxYPWm30RfArr6nPCb79cYqlqRnRa9b1x+AUyC/hwroe5HHd/AhdUsE+yp0NEBPIh7JG/9+nnr



> On Nov 7, 2025, at 4:19=E2=80=AFAM, Eric Dumazet <edumazet@google.com> =
wrote:
>=20
> On Fri, Nov 7, 2025 at 1:16=E2=80=AFAM Hudson, Nick =
<nhudson@akamai.com> wrote:
>>=20
>>=20
>>=20
>>> On 7 Nov 2025, at 09:11, Eric Dumazet <edumazet@google.com> wrote:
>>>=20
>>> =
!-------------------------------------------------------------------|
>>> This Message Is =46rom an External Sender
>>> This message came from outside your organization.
>>> =
|-------------------------------------------------------------------!
>>>=20
>>> On Fri, Nov 7, 2025 at 12:41=E2=80=AFAM Hudson, Nick =
<nhudson@akamai.com> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On 7 Nov 2025, at 02:21, Jason Wang <jasowang@redhat.com> wrote:
>>>>>=20
>>>>> =
!-------------------------------------------------------------------|
>>>>> This Message Is =46rom an External Sender
>>>>> This message came from outside your organization.
>>>>> =
|-------------------------------------------------------------------!
>>>>>=20
>>>>> On Thu, Nov 6, 2025 at 11:51=E2=80=AFPM Nick Hudson =
<nhudson@akamai.com> wrote:
>>>>>>=20
>>>>>> On a 640 CPU system running virtio-net VMs with the vhost-net =
driver, and
>>>>>> multiqueue (64) tap devices testing has shown contention on the =
zone lock
>>>>>> of the page allocator.
>>>>>>=20
>>>>>> A 'perf record -F99 -g sleep 5' of the CPUs where the vhost =
worker threads run shows
>>>>>>=20
>>>>>>  # perf report -i perf.data.vhost --stdio --sort overhead  =
--no-children | head -22
>>>>>>  ...
>>>>>>  #
>>>>>>     100.00%
>>>>>>              |
>>>>>>              |--9.47%--queued_spin_lock_slowpath
>>>>>>              |          |
>>>>>>              |           --9.37%--_raw_spin_lock_irqsave
>>>>>>              |                     |
>>>>>>              |                     |--5.00%--__rmqueue_pcplist
>>>>>>              |                     |          =
get_page_from_freelist
>>>>>>              |                     |          =
__alloc_pages_noprof
>>>>>>              |                     |          |
>>>>>>              |                     |          =
|--3.34%--napi_alloc_skb
>>>>>>  #
>>>>>>=20
>>>>>> That is, for Rx packets
>>>>>> - ksoftirqd threads pinned 1:1 to CPUs do SKB allocation.
>>>>>> - vhost-net threads float across CPUs do SKB free.
>>>>>>=20
>>>>>> One method to avoid this contention is to free SKB allocations on =
the same
>>>>>> CPU as they were allocated on. This allows freed pages to be =
placed on the
>>>>>> per-cpu page (PCP) lists so that any new allocations can be taken =
directly
>>>>>> from the PCP list rather than having to request new pages from =
the page
>>>>>> allocator (and taking the zone lock).
>>>>>>=20
>>>>>> Fortunately, previous work has provided all the infrastructure to =
do this
>>>>>> via the skb_attempt_defer_free call which this change uses =
instead of
>>>>>> consume_skb in tun_do_read.
>>>>>>=20
>>>>>> Testing done with a 6.12 based kernel and the patch ported =
forward.
>>>>>>=20
>>>>>> Server is Dual Socket AMD SP5 - 2x AMD SP5 9845 (Turin) with 2 =
VMs
>>>>>> Load generator: iPerf2 x 1200 clients MSS=3D400
>>>>>>=20
>>>>>> Before:
>>>>>> Maximum traffic rate: 55Gbps
>>>>>>=20
>>>>>> After:
>>>>>> Maximum traffic rate 110Gbps
>>>>>> ---
>>>>>> drivers/net/tun.c | 2 +-
>>>>>> net/core/skbuff.c | 2 ++
>>>>>> 2 files changed, 3 insertions(+), 1 deletion(-)
>>>>>>=20
>>>>>> diff --git a/drivers/net/tun.c b/drivers/net/tun.c
>>>>>> index 8192740357a0..388f3ffc6657 100644
>>>>>> --- a/drivers/net/tun.c
>>>>>> +++ b/drivers/net/tun.c
>>>>>> @@ -2185,7 +2185,7 @@ static ssize_t tun_do_read(struct =
tun_struct *tun, struct tun_file *tfile,
>>>>>>              if (unlikely(ret < 0))
>>>>>>                      kfree_skb(skb);
>>>>>>              else
>>>>>> -                       consume_skb(skb);
>>>>>> +                       skb_attempt_defer_free(skb);
>>>>>>      }
>>>>>>=20
>>>>>>      return ret;
>>>>>> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
>>>>>> index 6be01454f262..89217c43c639 100644
>>>>>> --- a/net/core/skbuff.c
>>>>>> +++ b/net/core/skbuff.c
>>>>>> @@ -7201,6 +7201,7 @@ nodefer:  kfree_skb_napi_cache(skb);
>>>>>>      DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
>>>>>>      DEBUG_NET_WARN_ON_ONCE(skb->destructor);
>>>>>>      DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
>>>>>> +       DEBUG_NET_WARN_ON_ONCE(skb_shared(skb));
>>>>>=20
>>>>> I may miss something but it looks there's no guarantee that the =
packet
>>>>> sent to TAP is not shared.
>>>>=20
>>>> Yes, I did wonder.
>>>>=20
>>>> How about something like
>>>>=20
>>>> /**
>>>> * consume_skb_attempt_defer - free an skbuff
>>>> * @skb: buffer to free
>>>> *
>>>> * Drop a ref to the buffer and attempt to defer free it if the =
usage count
>>>> * has hit zero.
>>>> */
>>>> void consume_skb_attempt_defer(struct sk_buff *skb)
>>>> {
>>>> if (!skb_unref(skb))
>>>> return;
>>>>=20
>>>> trace_consume_skb(skb, __builtin_return_address(0));
>>>>=20
>>>> skb_attempt_defer_free(skb);
>>>> }
>>>> EXPORT_SYMBOL(consume_skb_attempt_defer);
>>>>=20
>>>> and an inline version for the !CONFIG_TRACEPOINTS case
>>>=20
>>> I will take care of the changes, have you seen my recent series ?
>>=20
>> Great, thanks. I did see your series and will evaluate the =
improvement in our test setup.
>>=20
>>>=20
>>>=20
>>> I think you are missing a few points=E2=80=A6.
>>=20
>> Sure, still learning.
>=20
> Sure !
>=20
> Make sure to add in your dev .config : CONFIG_DEBUG_NET=3Dy
>=20

Hey Nick,
Thanks for sending this out, and funny enough, I had almost this
exact same series of thoughts back in May, but ended up getting
sucked into a rabbit hole the size of Texas and never circled
back to finish up the series.

Check out my series here:=20
=
https://patchwork.kernel.org/project/netdevbpf/patch/20250506145530.287722=
9-5-jon@nutanix.com/

I was also monkeying around with defer free in this exact spot,
but it too got lost in the rabbit hole, so I=E2=80=99m glad I stumbled
upon this again tonight.

Let me dust this baby off and send a v2 on top of Eric=E2=80=99s
napi_consume_skb() series, as the combination of the two
of them should net out positively for you

Jon



