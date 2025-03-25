Return-Path: <netdev+bounces-177371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9E2A6FCBB
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23153AC803
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC35267B77;
	Tue, 25 Mar 2025 12:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Jf7vlGGR"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E034267B7F
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905227; cv=none; b=DFyjWbR5QDoZA8gNfoScyHyGt/TGmZNF2akWD3RTdBO4Dnrqd94JSWtucei89bsM9KVFhiiKfC33GwXdrCYvF2MUrhR00Zqg/MovZdOjTaQKU9sDqYwo903K74Rij7RkBCwBEkXczbXQoc6uKYd1aBhudANKHw71C3BnwpC6jTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905227; c=relaxed/simple;
	bh=fRI2Owqgw85GmBsf1kqLISTrjN6ADCz0KAC+v9Cbe1M=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=PxLAOcdWpIj6w0jGkgL4t8rbMcyhf094Xg8Mvn8jGKsUP0+K7ScunAULzDXZprolQUMiTZILF1YkwreYxhgk5ON5m1ft+ZihC5tdpIByhRMVqjGs9Dl4NdqzBWAP7ibQCfSc8pBT0XcW5qmeOgtHloQUjOSmFJHxsvXVXFWm2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Jf7vlGGR; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742905220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3g0qORwvvABSJ2Rv9GuvfAIXABDwBe5tSMPOLykHwsg=;
	b=Jf7vlGGRkuuwY6Df1TuEaUfzikmOC1Dz/EVPuFgoj2acjNTNaj0kKju1JCDNsYz39FsBUC
	H3k/t9v87SUbjw2Xo8r/A6WS9Ujo//l227v7OcoGCLDzUYDYZByIA5LlPu52DYlWjKQovi
	I3Z4T17Gxs2HEc7/W42mPGZQDGXCPis=
Date: Tue, 25 Mar 2025 12:20:18 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <5cdc1bdd9caee92a6ae932638a862fd5c67630e8@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net-next v2] tcp: Support skb PAWS drop reason when
 TIME-WAIT
To: "Eric Dumazet" <edumazet@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuniyu@amazon.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, dsahern@kernel.org, ncardwell@google.com, mrpre@163.com
In-Reply-To: <CANn89iKxTHZ1JoQ9g9ekWq9=29LjRmhbxsnwkQ2RgPT-yCYMig@mail.gmail.com>
References: <20250325110325.51958-1-jiayuan.chen@linux.dev>
 <CANn89iKxTHZ1JoQ9g9ekWq9=29LjRmhbxsnwkQ2RgPT-yCYMig@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

March 25, 2025 at 19:29, "Eric Dumazet" <edumazet@google.com> wrote:

> >  ---
> >=20
>=20>  include/net/tcp.h | 3 ++-
> >=20
>=20>  net/ipv4/tcp_ipv4.c | 2 +-
> >=20
>=20>  net/ipv4/tcp_minisocks.c | 7 +++++--
> >=20
>=20>  net/ipv6/tcp_ipv6.c | 2 +-
> >=20
>=20>  4 files changed, 9 insertions(+), 5 deletions(-)
> >=20
>=20>  diff --git a/include/net/tcp.h b/include/net/tcp.h
> >=20
>=20>  index f8efe56bbccb..e1574e804530 100644
> >=20
>=20>  --- a/include/net/tcp.h
> >=20
>=20>  +++ b/include/net/tcp.h
> >=20
>=20>  @@ -427,7 +427,8 @@ enum tcp_tw_status {
> >=20
>=20>  enum tcp_tw_status tcp_timewait_state_process(struct inet_timewait=
_sock *tw,
> >=20
>=20>  struct sk_buff *skb,
> >=20
>=20>  const struct tcphdr *th,
> >=20
>=20>  - u32 *tw_isn);
> >=20
>=20>  + u32 *tw_isn,
> >=20
>=20>  + enum skb_drop_reason *drop_reason);
> >=20
>=20>  struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
> >=20
>=20>  struct request_sock *req, bool fastopen,
> >=20
>=20>  bool *lost_race, enum skb_drop_reason *drop_reason);
> >=20
>=20>  diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> >=20
>=20>  index 1cd0938d47e0..a9dde473a23f 100644
> >=20
>=20>  --- a/net/ipv4/tcp_ipv4.c
> >=20
>=20>  +++ b/net/ipv4/tcp_ipv4.c
> >=20
>=20>  @@ -2417,7 +2417,7 @@ int tcp_v4_rcv(struct sk_buff *skb)
> >=20
>=20>  goto csum_error;
> >=20
>=20>  }
> >=20
>=20>  - tw_status =3D tcp_timewait_state_process(inet_twsk(sk), skb, th,=
 &isn);
> >=20
>=20>  + tw_status =3D tcp_timewait_state_process(inet_twsk(sk), skb, th,=
 &isn, &drop_reason);
> >=20
>=20>  switch (tw_status) {
> >=20
>=20>  case TCP_TW_SYN: {
> >=20
>=20>  struct sock *sk2 =3D inet_lookup_listener(net,
> >=20
>=20>  diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> >=20
>=20>  index fb9349be36b8..d16dfd41397e 100644
> >=20
>=20>  --- a/net/ipv4/tcp_minisocks.c
> >=20
>=20>  +++ b/net/ipv4/tcp_minisocks.c
> >=20
>=20>  @@ -97,7 +97,8 @@ static void twsk_rcv_nxt_update(struct tcp_timew=
ait_sock *tcptw, u32 seq,
> >=20
>=20>  */
> >=20
>=20>  enum tcp_tw_status
> >=20
>=20>  tcp_timewait_state_process(struct inet_timewait_sock *tw, struct s=
k_buff *skb,
> >=20
>=20>  - const struct tcphdr *th, u32 *tw_isn)
> >=20
>=20>  + const struct tcphdr *th, u32 *tw_isn,
> >=20
>=20>  + enum skb_drop_reason *drop_reason)
> >=20
>=20>  {
> >=20
>=20>  struct tcp_timewait_sock *tcptw =3D tcp_twsk((struct sock *)tw);
> >=20
>=20>  u32 rcv_nxt =3D READ_ONCE(tcptw->tw_rcv_nxt);
> >=20
>=20>  @@ -245,8 +246,10 @@ tcp_timewait_state_process(struct inet_timewa=
it_sock *tw, struct sk_buff *skb,
> >=20
>=20>  return TCP_TW_SYN;
> >=20
>=20>  }
> >=20
>=20>  - if (paws_reject)
> >=20
>=20>  + if (paws_reject) {
> >=20
>=20>  + *drop_reason =3D SKB_DROP_REASON_TCP_RFC7323_PAWS;
> >=20
>=20>  __NET_INC_STATS(twsk_net(tw), LINUX_MIB_PAWSESTABREJECTED);
> >=20
>=20
> I think we should add a new SNMP value and drop reason for TW sockets.
>=20
>=20SNMP_MIB_ITEM("PAWSTimewait", LINUX_MIB_PAWSTIMEWAIT),
>=20
>=20and SKB_DROP_REASON_TCP_RFC7323_TW_PAWS ?
>

That makes sense, we've done similar things before, such as adding
PAWS_OLD_ACK previously.

Thanks for the suggestion!
--=20
pw-bot:=20cr

