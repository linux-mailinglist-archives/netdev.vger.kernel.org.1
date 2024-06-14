Return-Path: <netdev+bounces-103553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B4908A05
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7EE1C27248
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECD6195385;
	Fri, 14 Jun 2024 10:33:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588FE146582;
	Fri, 14 Jun 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361231; cv=none; b=GuN5FT8pclcHsbCCrZlKUlcO/GxHwtoFdUCJfji3syf519XVdXjkRHSOfgzzI7Iqh+StdCiqwkK6AQG7rc+jouUKnk7v+DJQV1qBciIYwFTl35Elx/2udK0Ytfx85uyNeXuyciT8jfm3SLOIGh0hNXeANZ3eFajTTGjTEvLvUJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361231; c=relaxed/simple;
	bh=1knMsh8HE/uLqdwfneid1eDPZ2hiMkkpaPCL9yNabis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btX4KUNpveNSBVqIt8iXnsW/6QDPuupkyXH2/bA+DE4cy3XQNHNAvqIxaKxBJkrRD1d50Cgt3it9WgAdA2mFoyuNqVpSS6is+O9M7YMF8evto3hvvqFwx6ApTATxW/PU7cZg+YOtFUyaPpw2OFZOKVVXp8UDeWwe8wsiyPz4/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 91277dac2a3911ef9305a59a3cc225df-20240614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:3923f807-859b-417f-a51c-044b38158a78,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:1
X-CID-INFO: VERSION:1.1.38,REQID:3923f807-859b-417f-a51c-044b38158a78,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:1
X-CID-META: VersionHash:82c5f88,CLOUDID:3408e41a52207bd45173a2324f63f1a2,BulkI
	D:240614144740H35N4DT4,BulkQuantity:4,Recheck:0,SF:19|44|64|66|24|72|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN
X-UUID: 91277dac2a3911ef9305a59a3cc225df-20240614
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <luoxuanqiang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 534930339; Fri, 14 Jun 2024 18:33:40 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 88DBEB80758A;
	Fri, 14 Jun 2024 18:33:40 +0800 (CST)
X-ns-mid: postfix-666C1C84-46297613
Received: from [10.42.12.252] (unknown [10.42.12.252])
	by node2.com.cn (NSMail) with ESMTPA id D0EF4B80758A;
	Fri, 14 Jun 2024 10:33:39 +0000 (UTC)
Message-ID: <ae9635cb-d896-4f85-8541-96f7c21546d3@kylinos.cn>
Date: Fri, 14 Jun 2024 18:33:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/1] Fix race for duplicate reqsk on identical SYN
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, fw@strlen.de, kuba@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
References: <CANn89iJBOAg+KCZBvkUxdAfTS1jacBBcrW6M5AZQvr=UPFJ0dA@mail.gmail.com>
 <20240614060012.158026-1-luoxuanqiang@kylinos.cn>
 <666c066e.630a0220.98be4.aba1SMTPIN_ADDED_BROKEN@mx.google.com>
 <CANn89iJDcJmT6GfrPRvkt-BBfwHDhssDDMF=5JZMOCRrhxm5bQ@mail.gmail.com>
From: luoxuanqiang <luoxuanqiang@kylinos.cn>
In-Reply-To: <CANn89iJDcJmT6GfrPRvkt-BBfwHDhssDDMF=5JZMOCRrhxm5bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2024/6/14 17:41, Eric Dumazet =E5=86=99=E9=81=93:
> On Fri, Jun 14, 2024 at 10:59=E2=80=AFAM luoxuanqiang <luoxuanqiang@kyl=
inos.cn> wrote:
>> On Fri, Jun 14, 2024 at 8:01=E2=80=AFAM luoxuanqiang <luoxuanqiang@kyl=
inos.cn> wrote:
>>>> When bonding is configured in BOND_MODE_BROADCAST mode, if two ident=
ical SYN packets
>>>> are received at the same time and processed on different CPUs, it ca=
n potentially
>>>> create the same sk (sock) but two different reqsk (request_sock) in =
tcp_conn_request().
>>>>
>>>> These two different reqsk will respond with two SYNACK packets, and =
since the generation
>>>> of the seq (ISN) incorporates a timestamp, the final two SYNACK pack=
ets will have
>>>> different seq values.
>>>>
>>>> The consequence is that when the Client receives and replies with an=
 ACK to the earlier
>>>> SYNACK packet, we will reset(RST) it.
>>>>
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>> This behavior is consistently reproducible in my local setup, which =
comprises:
>>>>
>>>>                    | NETA1 ------ NETB1 |
>>>> PC_A --- bond --- |                    | --- bond --- PC_B
>>>>                    | NETA2 ------ NETB2 |
>>>>
>>>> - PC_A is the Server and has two network cards, NETA1 and NETA2. I h=
ave bonded these two
>>>>    cards using BOND_MODE_BROADCAST mode and configured them to be ha=
ndled by different CPU.
>>>>
>>>> - PC_B is the Client, also equipped with two network cards, NETB1 an=
d NETB2, which are
>>>>    also bonded and configured in BOND_MODE_BROADCAST mode.
>>>>
>>>> If the client attempts a TCP connection to the server, it might enco=
unter a failure.
>>>> Capturing packets from the server side reveals:
>>>>
>>>> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [S], s=
eq 320236027,
>>>> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [S], s=
eq 320236027,
>>>> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [S.], =
seq 2967855116,
>>>> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [S.], =
seq 2967855123, <=3D=3D
>>>> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [.], a=
ck 4294967290,
>>>> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [.], a=
ck 4294967290,
>>>> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [R], s=
eq 2967855117, <=3D=3D
>>>> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [R], s=
eq 2967855117,
>>>>
>>>> Two SYNACKs with different seq numbers are sent by localhost, result=
ing in an anomaly.
>>>>
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>>
>>>> The attempted solution is as follows:
>>>> In the tcp_conn_request(), while inserting reqsk into the ehash tabl=
e, it also checks
>>>> if an entry already exists. If found, it avoids reinsertion and rele=
ases it.
>>>>
>>>> Simultaneously, In the reqsk_queue_hash_req(), the start of the req-=
>rsk_timer is
>>>> adjusted to be after successful insertion.
>>>>
>>>> Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>
>>>> ---
>>>>   include/net/inet_connection_sock.h |  2 +-
>>>>   net/dccp/ipv4.c                    |  2 +-
>>>>   net/dccp/ipv6.c                    |  2 +-
>>>>   net/ipv4/inet_connection_sock.c    | 16 ++++++++++++----
>>>>   net/ipv4/tcp_input.c               | 11 ++++++++++-
>>>>   5 files changed, 25 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_c=
onnection_sock.h
>>>> index 7d6b1254c92d..8773d161d184 100644
>>>> --- a/include/net/inet_connection_sock.h
>>>> +++ b/include/net/inet_connection_sock.h
>>>> @@ -264,7 +264,7 @@ struct sock *inet_csk_reqsk_queue_add(struct soc=
k *sk,
>>>>                                        struct request_sock *req,
>>>>                                        struct sock *child);
>>>>   void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request=
_sock *req,
>>>> -                                  unsigned long timeout);
>>>> +                                  unsigned long timeout, bool *foun=
d_dup_sk);
>>>>   struct sock *inet_csk_complete_hashdance(struct sock *sk, struct s=
ock *child,
>>>>                                           struct request_sock *req,
>>>>                                           bool own_req);
>>>> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
>>>> index ff41bd6f99c3..13aafdeb9205 100644
>>>> --- a/net/dccp/ipv4.c
>>>> +++ b/net/dccp/ipv4.c
>>>> @@ -657,7 +657,7 @@ int dccp_v4_conn_request(struct sock *sk, struct=
 sk_buff *skb)
>>>>          if (dccp_v4_send_response(sk, req))
>>>>                  goto drop_and_free;
>>>>
>>>> -       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
>>>> +       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT, NU=
LL);
>>>>          reqsk_put(req);
>>>>          return 0;
>>>>
>>>> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
>>>> index 85f4b8fdbe5e..493cdb12ce2b 100644
>>>> --- a/net/dccp/ipv6.c
>>>> +++ b/net/dccp/ipv6.c
>>>> @@ -400,7 +400,7 @@ static int dccp_v6_conn_request(struct sock *sk,=
 struct sk_buff *skb)
>>>>          if (dccp_v6_send_response(sk, req))
>>>>                  goto drop_and_free;
>>>>
>>>> -       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
>>>> +       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT, NU=
LL);
>>>>          reqsk_put(req);
>>>>          return 0;
>>>>
>>>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connect=
ion_sock.c
>>>> index d81f74ce0f02..d9394db98a5a 100644
>>>> --- a/net/ipv4/inet_connection_sock.c
>>>> +++ b/net/ipv4/inet_connection_sock.c
>>>> @@ -1123,12 +1123,17 @@ static void reqsk_timer_handler(struct timer=
_list *t)
>>>>   }
>>>>
>>>>   static void reqsk_queue_hash_req(struct request_sock *req,
>>>> -                                unsigned long timeout)
>>>> +                                unsigned long timeout, bool *found_=
dup_sk)
>>>>   {
>>>> +
>>>> +       inet_ehash_insert(req_to_sk(req), NULL, found_dup_sk);
>>>> +       if(found_dup_sk && *found_dup_sk)
>>>> +               return;
>>>> +
>>>> +       /* The timer needs to be setup after a successful insertion.=
 */
>>> I am pretty sure we had a prior attempt to fix this issue, and the fi=
x
>>> was problematic.
>>>
>>> You are moving the inet_ehash_insert() before the mod_timer(), this
>>> will add races.
>> Could you kindly explain what "races" refer to here? Thank you!
>
> Hmmm... maybe this is ok. Please respin your patch after fixing
> checkpatch issues, and add a 'net' tag
>
> ( See https://patchwork.kernel.org/project/netdevbpf/patch/202406140600=
12.158026-1-luoxuanqiang@kylinos.cn/
> for all warnings / fails)
>
> Please CC Kuniyuki Iwashima <kuniyu@amazon.com> because I will be OOO
> for about 4 days.

The formatting error has been resolved and the V2 version has been sent. =
Enjoy your holiday! Thank you!


