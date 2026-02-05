Return-Path: <netdev+bounces-257292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCCnAXPphGkj6gMAu9opvQ
	(envelope-from <netdev+bounces-257292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:03:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A31CCF6AA4
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 20:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 211D23018BE8
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 19:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A5930DD37;
	Thu,  5 Feb 2026 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUKrkkTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C7030CDAE
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 19:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318191; cv=pass; b=gILo43G30E59j9ijKzXimnkZQw648SCIeyqUwKUK0vNFN/wNG1VGTEBAop3Jcx4q7Z1F/GSrtr3kH6TYTVDmXUoFIAqwfYI1g9YaPLmWn+j9bULMxe4VKBAUceh3tFbuCGlGSA/9f1DRYqt+jxThbzccTsG5eI0jS2yfTVVy1eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318191; c=relaxed/simple;
	bh=Sv7j14ymtGLHlmTqP+BoOPCTX/cQqHoGUXoIMpAvOkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TFyORZ2d8+D/GLByDItoIcXE4hKdIw74OB8C81ENTYvl0goISZ32XBO1nAjLaOZ45uYvEASOMKkQxv9du+wwPJvJ6WX2np/ej2+yefKOFSEtW6gHzS2YvOaB/nLuLcWyhzUwEEipPg0Ho/yobct8fXnwY8jyapK+XWh7p6by/ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUKrkkTd; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c5513f598c0so473685a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 11:03:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770318191; cv=none;
        d=google.com; s=arc-20240605;
        b=Wxkuv+ZLUAuc5m7Te524L0x0+qqrRvBiu7TI+YkZi4Gnd7y2AGu0rUqySfOnRRMaz3
         LMzxMnQu9af9I/+kR/W/QPSi0pen3TZzyCHq84aa37Qmt73/DzSnDhzurcT5Juw9M8FI
         1N8eNNB29YwgnRqu/Y2o6Xp7G69Rx0IiyBF0BkjqUMKP4WHyN8STQ6mmrenxPXdHyGet
         27/9oWqEZefs5s0HDgJCYPefYugoD0WUP7AJ7KqiA0nX9if5t1NKcsir628hCB5TA+oW
         vhcmu4XYFAFEA9s2VO/tTzK3Rhda9T8bRLzZISdi9w1JEZg40PDBNpypBF3DnQMwNe5M
         lq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wMq2czingLs1wcNHuupFAGOHUrKeCMVUSnWEEmpxoVE=;
        fh=ONMdBrMzHbY9Mvjk8J3LfndvfOA1sgemPQ1QGkUQA2o=;
        b=Jan/TrqkVUYRrUWOXIwAHdstJTko4iFuVpDinW5fpz8TS4Gzte9krSbRqelyjLiByJ
         XoYUdFM6wOwb/hvhxbIPv16mG9nqYmLRRF9HPMLI+ND1gpx4AKvzZfzL4OAaI5zzgt2+
         QKZ4sLAwI13ANDCwJWpBaJOMcGEYg9zdh0s+c9sV2f/HGvuyujC62QHw568yd347XZVL
         QCDorEK0ch5UUNYRhawivK//YVWKm0lhEffP7nZdSLyi51+dikBylbgQ1bBCzvpDUugf
         +Pi0wb7mFdxl6j73hvpqcQP8GO0tVgoBVY0swVzWoLJff1RF6diD3N/M+oOs+XCMoc+d
         52rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770318191; x=1770922991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMq2czingLs1wcNHuupFAGOHUrKeCMVUSnWEEmpxoVE=;
        b=LUKrkkTdaUKhoVrqnePTJHYYIUfa+gb1niw+MpsIPqA92saT4XjtO3gZsXtV5NBxJj
         +Ayt7uPHrCdwSp44o+VXbJcoj0SqoyVVx6uQ5SGMXgsS3Zx+xWIb+EVMixaD+hZTUyqb
         2w6Bn/h5eD9aIyJ9h8kvniPLFigHwCJoD7ya5LT28WY7sKgTC/rskkw3pgDvuPagfQeF
         8PVqYM67CBJFwMKKdmcLQoWJp/ga1ihxCyFEM7ktW0DjuoYddCNtvfn9vNrLgojiki0a
         YThcs42zzL0IVnXiNryAQSrsQrPZrm2gYOszfcuiFF6VTxkevoPmtS5zNmaam+lGFaX8
         nw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770318191; x=1770922991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wMq2czingLs1wcNHuupFAGOHUrKeCMVUSnWEEmpxoVE=;
        b=vKqcoc24qMP/+M2VwkSKCxJgp1o+HKeFEDtaRTvjw78gtWPfGaB9yi0QhkdNmUouR4
         oqT7gJOGViIz13EYaHeuX/IVOhKOiyGKmvYzRuRfBWZfhD4eu+Ctuwe3yCAEu+MmyJW9
         jZ0LzvWBT9Ae4S1ryh0r46VywiRjHByzQxF9ff6lUuB871UByXnrhaWstuB03cQr6kSH
         wmB1hvpYiyBdig/joj67XcHhfEHBvf0jELn1Hj+SRfr4B9N0srn5dsKea3TVJ0mbqIWE
         GLFD7DRUJ1GqSRQVfwb0vQsCOaaGy1WynlWy52b83GqzwGgO5eKlqJhbVbt5LwBewx08
         /NhA==
X-Forwarded-Encrypted: i=1; AJvYcCUbUdjj0UPx5MWy9vggUghraUWHj+dEk274oFvgP6MX4bCY0X2uaE3R5LwgoBsXBv9v6puMU4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGVkW0mV+KQs3u9FAtltCHsZtxiNjrQeCRCitHhBycF16CDS9x
	N87R73xGYdONL45scVdpat+gygz9l9g9X3sa9gcll+RybNB8Kqrsw1hXYeOLusBN5p7K63ypbHe
	l3jitux3xJVxRP5ZlS5/E3HjxLv+yglg=
X-Gm-Gg: AZuq6aJsyofmambELYlFGeG6u5TYQX3Vu+c/7jPVWe0QnEfXeUs7iWxdAS+fG9YbtLm
	nH1EKxn6aRQifNEdX7ih6Z+yLBKm0xiJiSj7l21h7zqw4q8oHWXRl0W91bqZrUgjuXAd+zyugnr
	AhAIHNUiRI+4fXkN7uLlPuDQ9uRJBfsI1vMj09mKoFOB+9pdqIj3AbFEoQ7jVALzsZD/op9qF0h
	tB0MVTPNOv5X2Nz97Pe9Dly4uDJJthdJ9GONA3lYngkhr3sDStmIq2eWFZapZN0/S7lL9d8h3aG
	8vhgmX2t4bACQmRGnwOlC0G/vdVl
X-Received: by 2002:a17:90a:dfcd:b0:352:d59a:b28 with SMTP id
 98e67ed59e1d1-354b3cae091mr42496a91.19.1770318190665; Thu, 05 Feb 2026
 11:03:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <431335747d3604c46f2e57a32d839a73aa8a8536.1770042461.git.lucien.xin@gmail.com>
 <20260205115542.2195362-1-horms@kernel.org>
In-Reply-To: <20260205115542.2195362-1-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 5 Feb 2026 14:02:58 -0500
X-Gm-Features: AZwV_QhI8OwuLRWeiqC_GNUtx69lACcTHyYZmGGt6r8v7RB2RzBMyspqQrCybPk
Message-ID: <CADvbK_e8Sbm8Q3KVR=uZZDYuQLTdprRskN=jgompaSeYDkmhFw@mail.gmail.com>
Subject: Re: [net-next,v9,15/15] quic: add packet parser base
To: Simon Horman <horms@kernel.org>
Cc: steved@redhat.com, marcelo.leitner@gmail.com, aahringo@redhat.com, 
	alibuda@linux.alibaba.com, jbaron@akamai.com, hare@suse.de, kuba@kernel.org, 
	tom@talpey.com, linux-cifs@vger.kernel.org, daniel@haxx.se, 
	quic@lists.linux.dev, jlayton@kernel.org, tfanelli@redhat.com, 
	dhowells@redhat.com, linkinjeon@kernel.org, hepengtao@xiaomi.com, 
	pc@manguebit.com, kernel-tls-handshake@lists.linux.dev, 
	illiliti@protonmail.com, xiyou.wangcong@gmail.com, 
	andrew.gospodarek@broadcom.com, mail@johnericson.me, edumazet@google.com, 
	pabeni@redhat.com, matttbe@kernel.org, netdev@vger.kernel.org, 
	smfrench@gmail.com, metze@samba.org, mbuhl@openbsd.org, 
	chuck.lever@oracle.com, dreibh@simula.no, davem@davemloft.net, 
	sd@queasysnail.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257292-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,kernel.org,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A31CCF6AA4
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 6:55=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> quic: add packet parser base
>
> This patch uses 'quic_packet' to handle packing of QUIC packets on the
> receive (RX) path. It introduces mechanisms to parse the ALPN from client
> Initial packets to determine the correct listener socket, routes received
> packets accordingly, and adds support for ICMP-based MTU updates by
> locating the relevant socket and updating the stored PMTU.
>
> > diff --git a/net/quic/packet.c b/net/quic/packet.c
> > index cf64a6aaa795..16a7db6ccd87 100644
> > --- a/net/quic/packet.c
> > +++ b/net/quic/packet.c
>
> [ ... ]
>
> > @@ -14,6 +14,637 @@
> >
> >  #define QUIC_HLEN            1
> >
> > +/* Handle ICMP Toobig packet and update QUIC socket path MTU. */
> > +static int quic_packet_rcv_err(struct sock *sk, struct sk_buff *skb)
> > +{
> > +     union quic_addr daddr, saddr;
> > +     u32 info;
> > +
> > +     /* All we can do is lookup the matching QUIC socket by addresses.=
 */
> > +     quic_get_msg_addrs(skb, &saddr, &daddr);
> > +     sk =3D quic_sock_lookup(skb, &daddr, &saddr, sk, NULL);
>
> Are the address arguments swapped in quic_packet_rcv_err()? Looking at
> other call sites in this file, quic_get_msg_addrs is consistently called
> with &daddr first, then &saddr:
>
>   Line 476 in quic_packet_get_listen_sock():
>     quic_get_msg_addrs(skb, &daddr, &saddr);
>
>   Line 513 in quic_packet_get_sock():
>     quic_get_msg_addrs(skb, &daddr, &saddr);
>
>   Line 536 in quic_packet_get_sock():
>     quic_get_msg_addrs(skb, &daddr, &saddr);
>
> But here quic_packet_rcv_err() passes &saddr first, then &daddr.
>
> Looking at the implementation of quic_v4_get_msg_addrs() in
> net/quic/family.c, the function extracts addresses from the packet as:
>
>   sa->v4.sin_port =3D uh->source;
>   sa->v4.sin_addr.s_addr =3D ip_hdr(skb)->saddr;
>   da->v4.sin_port =3D uh->dest;
>   da->v4.sin_addr.s_addr =3D ip_hdr(skb)->daddr;
>
> So sa gets the packet's source address (remote), and da gets the packet's
> destination address (local).
>
> Then quic_sock_lookup() in net/quic/socket.c expects:
>
>   if (quic_cmp_sk_addr(tmp, quic_path_saddr(paths, 0), sa) &&
>       quic_cmp_sk_addr(tmp, quic_path_daddr(paths, 0), da) &&
>
> This compares the socket's local address with sa and the socket's remote
> address with da, meaning sa should be the local (packet dest) address and
> da should be the remote (packet source) address.
>
> With the swapped arguments, quic_packet_rcv_err() would pass the remote
> address where the local is expected and vice versa, causing the socket
> lookup to fail. This would prevent ICMP Packet Too Big messages from bein=
g
> processed correctly, breaking Path MTU Discovery.
>
The code is correct, I may add a comment for the explanation:


        /* ICMP embeds the original outgoing QUIC packet, so
saddr/daddr are reversed when
         * parsed. Only address-based socket lookup is possible in this cas=
e.
         */

Thanks.

