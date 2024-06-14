Return-Path: <netdev+bounces-103500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F347B9085A7
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1701F1C21CC7
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 08:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADFEF14D29B;
	Fri, 14 Jun 2024 08:07:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7041714A092;
	Fri, 14 Jun 2024 08:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352459; cv=none; b=TviMQlqnW8CU1Pem8jzM6Aa877n9szwQj6BG6jSY/kmI684UX1tgMAzoDAv8dOOnP16ZVhPDISL1vmR48B3WfTMMtojzk4d1uSnvcxPOJ4pKY9qvmIHfi2eu5v1dpWhrnppI179zpt4AyGpqF+j6PSNxyqumLgTvx53uNTO/6ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352459; c=relaxed/simple;
	bh=g+C9sTXUjr0qI4UHD+E6QB+63tYPAwnvonLjEzwycgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLKrIT6pjvbQEOBVXHaVXNKENZukRtmVESHJLYBPV+zMpRxf3hqvod1D1BdG2xNdoLbpnh1gQm0TnJbhkhNM2kw1e/I912RFJpLgm11kMhdrm6X0sAVRL0xk5UVn7bgScQeA8de0EOMaoRuxGoq3UoSPNJsiE2D9bGoDLpENnkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a2a97b682a2311ef9305a59a3cc225df-20240614
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:a77a25a7-59f8-44a1-9001-cbf1ed2b1799,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:11
X-CID-INFO: VERSION:1.1.38,REQID:a77a25a7-59f8-44a1-9001-cbf1ed2b1799,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:11
X-CID-META: VersionHash:82c5f88,CLOUDID:f05c5ef6fa1f85c4176edcfbee525c4f,BulkI
	D:240614144740H35N4DT4,BulkQuantity:1,Recheck:0,SF:64|66|24|72|19|44|102,T
	C:nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_ULN
X-UUID: a2a97b682a2311ef9305a59a3cc225df-20240614
Received: from node2.com.cn [(39.156.73.10)] by mailgw.kylinos.cn
	(envelope-from <luoxuanqiang@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 340878819; Fri, 14 Jun 2024 15:56:41 +0800
Received: from node2.com.cn (localhost [127.0.0.1])
	by node2.com.cn (NSMail) with SMTP id 081D3B80758A;
	Fri, 14 Jun 2024 15:56:41 +0800 (CST)
X-ns-mid: postfix-666BF7B7-860266110
Received: from localhost.localdomain (unknown [10.42.12.252])
	by node2.com.cn (NSMail) with ESMTPA id 79F59B80758A;
	Fri, 14 Jun 2024 07:56:37 +0000 (UTC)
From: luoxuanqiang <luoxuanqiang@kylinos.cn>
To: edumazet@google.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	fw@strlen.de,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	luoxuanqiang@kylinos.cn,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH v1 1/1] Fix race for duplicate reqsk on identical SYN
Date: Fri, 14 Jun 2024 15:56:37 +0800
Message-Id: <CANn89iJBOAg+KCZBvkUxdAfTS1jacBBcrW6M5AZQvr=UPFJ0dA@mail.gmail.com> (raw)
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240614060012.158026-1-luoxuanqiang@kylinos.cn>
References: <CANn89iJBOAg+KCZBvkUxdAfTS1jacBBcrW6M5AZQvr=UPFJ0dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 8:01=E2=80=AFAM luoxuanqiang <luoxuanqiang@kylino=
s.cn> wrote:
>>
>> When bonding is configured in BOND_MODE_BROADCAST mode, if two identic=
al SYN packets
>> are received at the same time and processed on different CPUs, it can =
potentially
>> create the same sk (sock) but two different reqsk (request_sock) in tc=
p_conn_request().
>>
>> These two different reqsk will respond with two SYNACK packets, and si=
nce the generation
>> of the seq (ISN) incorporates a timestamp, the final two SYNACK packet=
s will have
>> different seq values.
>>
>> The consequence is that when the Client receives and replies with an A=
CK to the earlier
>> SYNACK packet, we will reset(RST) it.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> This behavior is consistently reproducible in my local setup, which co=
mprises:
>>
>>                   | NETA1 ------ NETB1 |
>> PC_A --- bond --- |                    | --- bond --- PC_B
>>                   | NETA2 ------ NETB2 |
>>
>> - PC_A is the Server and has two network cards, NETA1 and NETA2. I hav=
e bonded these two
>>   cards using BOND_MODE_BROADCAST mode and configured them to be handl=
ed by different CPU.
>>
>> - PC_B is the Client, also equipped with two network cards, NETB1 and =
NETB2, which are
>>   also bonded and configured in BOND_MODE_BROADCAST mode.
>>
>> If the client attempts a TCP connection to the server, it might encoun=
ter a failure.
>> Capturing packets from the server side reveals:
>>
>> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [S], seq=
 320236027,
>> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [S], seq=
 320236027,
>> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [S.], se=
q 2967855116,
>> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [S.], se=
q 2967855123, <=3D=3D
>> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [.], ack=
 4294967290,
>> 10.10.10.10.45182 > localhost.localdomain.search-agent: Flags [.], ack=
 4294967290,
>> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [R], seq=
 2967855117, <=3D=3D
>> localhost.localdomain.search-agent > 10.10.10.10.45182: Flags [R], seq=
 2967855117,
>>
>> Two SYNACKs with different seq numbers are sent by localhost, resultin=
g in an anomaly.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>
>> The attempted solution is as follows:
>> In the tcp_conn_request(), while inserting reqsk into the ehash table,=
 it also checks
>> if an entry already exists. If found, it avoids reinsertion and releas=
es it.
>>
>> Simultaneously, In the reqsk_queue_hash_req(), the start of the req->r=
sk_timer is
>> adjusted to be after successful insertion.
>>
>> Signed-off-by: luoxuanqiang <luoxuanqiang@kylinos.cn>
>> ---
>>  include/net/inet_connection_sock.h |  2 +-
>>  net/dccp/ipv4.c                    |  2 +-
>>  net/dccp/ipv6.c                    |  2 +-
>>  net/ipv4/inet_connection_sock.c    | 16 ++++++++++++----
>>  net/ipv4/tcp_input.c               | 11 ++++++++++-
>>  5 files changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/net/inet_connection_sock.h b/include/net/inet_con=
nection_sock.h
>> index 7d6b1254c92d..8773d161d184 100644
>> --- a/include/net/inet_connection_sock.h
>> +++ b/include/net/inet_connection_sock.h
>> @@ -264,7 +264,7 @@ struct sock *inet_csk_reqsk_queue_add(struct sock =
*sk,
>>                                       struct request_sock *req,
>>                                       struct sock *child);
>>  void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_so=
ck *req,
>> -                                  unsigned long timeout);
>> +                                  unsigned long timeout, bool *found_=
dup_sk);
>>  struct sock *inet_csk_complete_hashdance(struct sock *sk, struct sock=
 *child,
>>                                          struct request_sock *req,
>>                                          bool own_req);
>> diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
>> index ff41bd6f99c3..13aafdeb9205 100644
>> --- a/net/dccp/ipv4.c
>> +++ b/net/dccp/ipv4.c
>> @@ -657,7 +657,7 @@ int dccp_v4_conn_request(struct sock *sk, struct s=
k_buff *skb)
>>         if (dccp_v4_send_response(sk, req))
>>                 goto drop_and_free;
>>
>> -       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
>> +       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT, NULL=
);
>>         reqsk_put(req);
>>         return 0;
>>
>> diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
>> index 85f4b8fdbe5e..493cdb12ce2b 100644
>> --- a/net/dccp/ipv6.c
>> +++ b/net/dccp/ipv6.c
>> @@ -400,7 +400,7 @@ static int dccp_v6_conn_request(struct sock *sk, s=
truct sk_buff *skb)
>>         if (dccp_v6_send_response(sk, req))
>>                 goto drop_and_free;
>>
>> -       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT);
>> +       inet_csk_reqsk_queue_hash_add(sk, req, DCCP_TIMEOUT_INIT, NULL=
);
>>         reqsk_put(req);
>>         return 0;
>>
>> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connectio=
n_sock.c
>> index d81f74ce0f02..d9394db98a5a 100644
>> --- a/net/ipv4/inet_connection_sock.c
>> +++ b/net/ipv4/inet_connection_sock.c
>> @@ -1123,12 +1123,17 @@ static void reqsk_timer_handler(struct timer_l=
ist *t)
>>  }
>>
>>  static void reqsk_queue_hash_req(struct request_sock *req,
>> -                                unsigned long timeout)
>> +                                unsigned long timeout, bool *found_du=
p_sk)
>>  {
>> +
>> +       inet_ehash_insert(req_to_sk(req), NULL, found_dup_sk);
>> +       if(found_dup_sk && *found_dup_sk)
>> +               return;
>> +
>> +       /* The timer needs to be setup after a successful insertion. *=
/
>
>I am pretty sure we had a prior attempt to fix this issue, and the fix
>was problematic.
>
>You are moving the inet_ehash_insert() before the mod_timer(), this
>will add races.
Could you kindly explain what "races" refer to here? Thank you!

>
>Hint here is the use of TIMER_PINNED.
>
>CCing Florian, because he just removed TIMER_PINNED for TW, he might
>have the context
>to properly fix this issue.
>
>>         timer_setup(&req->rsk_timer, reqsk_timer_handler, TIMER_PINNED=
);
>>         mod_timer(&req->rsk_timer, jiffies + timeout);
>>
>> -       inet_ehash_insert(req_to_sk(req), NULL, NULL);
>>         /* before letting lookups find us, make sure all req fields
>>          * are committed to memory and refcnt initialized.
>>          */
>> @@ -1137,9 +1142,12 @@ static void reqsk_queue_hash_req(struct request=
_sock *req,
>>  }
>>
>>  void inet_csk_reqsk_queue_hash_add(struct sock *sk, struct request_so=
ck *req,
>> -                                  unsigned long timeout)
>> +                                  unsigned long timeout, bool *found_=
dup_sk)
>>  {
>> -       reqsk_queue_hash_req(req, timeout);
>> +       reqsk_queue_hash_req(req, timeout, found_dup_sk);
>> +       if(found_dup_sk && *found_dup_sk)
>> +               return;
>> +
>>         inet_csk_reqsk_queue_added(sk);
>>  }
>>  EXPORT_SYMBOL_GPL(inet_csk_reqsk_queue_hash_add);
>> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
>> index 9c04a9c8be9d..467f1b7bbd5a 100644
>> --- a/net/ipv4/tcp_input.c
>> +++ b/net/ipv4/tcp_input.c
>> @@ -7255,8 +7255,17 @@ int tcp_conn_request(struct request_sock_ops *r=
sk_ops,
>>         } else {
>>                 tcp_rsk(req)->tfo_listener =3D false;
>>                 if (!want_cookie) {
>> +                       bool found_dup_sk =3D false;
>> +
>>                         req->timeout =3D tcp_timeout_init((struct sock=
 *)req);
>> -                       inet_csk_reqsk_queue_hash_add(sk, req, req->ti=
meout);
>> +                       inet_csk_reqsk_queue_hash_add(sk, req, req->ti=
meout,
>> +                                                       &found_dup_sk)=
;
>> +
>> +                       if(unlikely(found_dup_sk)){
>> +                               reqsk_free(req);
>> +                               return 0;
>> +                       }
>> +
>>                 }
>>                 af_ops->send_synack(sk, dst, &fl, req, &foc,
>>                                     !want_cookie ? TCP_SYNACK_NORMAL :
>> --
>> 2.25.1
>>

