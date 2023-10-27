Return-Path: <netdev+bounces-44804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7347D9EB0
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 19:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196702823B0
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 17:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA22139867;
	Fri, 27 Oct 2023 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JAY5/w7M"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBCAB678
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 17:15:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693AB212B
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698426942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q/IUIuBlUAVSfw0ZYSSp7HA1ApY55xXa4CdJDVH1eo0=;
	b=JAY5/w7M7b5yusg3/ZtnTZ25lJTZdMcmQ6YwrkAUkAaU7P/52rfn2hbnfY4G9F0Q+9XEU6
	usMeDvwTDA+YhlnpbswEVogGGwDfQzYkwZOTCCRSi4pHnAf9A4/0jR5cPrL3y195yVgGyu
	/97oj3xsMjibVoDq2xUwmm2nKDAFV8I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-gijo-ICMN0G2uJbkvKPxKw-1; Fri, 27 Oct 2023 13:15:40 -0400
X-MC-Unique: gijo-ICMN0G2uJbkvKPxKw-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9c439446b73so20930766b.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698426939; x=1699031739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/IUIuBlUAVSfw0ZYSSp7HA1ApY55xXa4CdJDVH1eo0=;
        b=qQ/aIFw4N3KB+vWHzenjRR0YNnm1TpAKY+0IrStMXX/aA3hafSSsfj8oLZHLft7UGo
         oblzuIE2K1ABc3ZfTLRhlE+rqNgsau9VZAwForxu/nPf0JxKpi8ovsO5bemCumh7xoGJ
         itYo4vdi4FHp6dVoLspZ29FZLJdDDcdXJC2wZ3s94DkzuTJRy51E1y1Y7RQUwOb8TEzg
         qbMF6zLih3t58OLAXjWyjCDeW1yhrre+pmDfsJITcD6IeL/ymJUthKx+xKTzVVdzdAmb
         deHmbWKJ2yW+CJ6ByG0xD5A7pgjumqVlkbgNGpC1mbwGN8VfN1BvZ2baiAqsDYTQ44gk
         VxfA==
X-Gm-Message-State: AOJu0YyzWwUZC7Iiq5FrCJRTspvDHJ8E3eJ74MU5NtO72d6cHiTFFC6k
	4BYOg5AJdtSQnlh1moSiZSxjptWRvtzkpX01uVRrzFt4NWl4FeSJKIxFjD+/+hT4LT+Xq33IrJe
	mpo3tNuwqOPS4sl6V
X-Received: by 2002:a17:906:6547:b0:9b2:b149:b816 with SMTP id u7-20020a170906654700b009b2b149b816mr2057738ejn.7.1698426939547;
        Fri, 27 Oct 2023 10:15:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFz3zKvAwgByzPtlH8RkxXx58KVrHzT8wVir7rvNE4KKx7DFWWzSBC5wS9Pl7fc9z5bjQxnfA==
X-Received: by 2002:a17:906:6547:b0:9b2:b149:b816 with SMTP id u7-20020a170906654700b009b2b149b816mr2057715ejn.7.1698426939166;
        Fri, 27 Oct 2023 10:15:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-239-222.dyn.eolo.it. [146.241.239.222])
        by smtp.gmail.com with ESMTPSA id md12-20020a170906ae8c00b009be14e5cd54sm1483469ejb.57.2023.10.27.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 10:15:38 -0700 (PDT)
Message-ID: <e245fb6a37d3c99df6efa934c5f05616bc1df7e7.camel@redhat.com>
Subject: Re: [syzbot] [mptcp?] WARNING in subflow_data_ready
From: Paolo Abeni <pabeni@redhat.com>
To: syzbot <syzbot+c53d4d3ddb327e80bc51@syzkaller.appspotmail.com>, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 linux-kernel@vger.kernel.org, martineau@kernel.org,
 matthieu.baerts@tessares.net,  matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org,  syzkaller-bugs@googlegroups.com
Date: Fri, 27 Oct 2023 19:15:37 +0200
In-Reply-To: <0000000000000fed5606088ee598@google.com>
References: <0000000000000fed5606088ee598@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-10-25 at 11:48 -0700, syzbot wrote:
> syzbot found the following issue on:
>=20
> HEAD commit:    9c5d00cb7b6b Merge tag 'perf-tools-fixes-for-v6.6-2-2023-=
1..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D123fbacd68000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D530f7d8ed0a57=
417
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dc53d4d3ddb327e8=
0bc51
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40

FTR: preemptible kernel, last mptcp program run on the CPU splatting
is:

r0 =3D socket$inet_mptcp(0x2, 0x1, 0x106)
bind$inet(r0, &(0x7f0000000040)=3D{0x2, 0x4e24, @multicast2}, 0x10)
sendmmsg$inet(r0, &(0x7f0000000440)=3D[{{&(0x7f00000000c0)=3D{0x2, 0x4e24, =
@empty}, 0x10, 0x0}}], 0x1, 0x24040890)
r1 =3D socket$nl_generic(0x10, 0x3, 0x10)
r2 =3D syz_genetlink_get_family_id$mptcp(&(0x7f0000000080), 0xfffffffffffff=
fff)
setsockopt$inet_tcp_buf(r0, 0x6, 0xd, &(0x7f0000000140)=3D"a7", 0x1)
sendmsg$MPTCP_PM_CMD_ADD_ADDR(r1, &(0x7f0000000300)=3D{0x0, 0x0, &(0x7f0000=
000100)=3D{&(0x7f0000000000)=3D{0x28, r2, 0x1, 0x0, 0x0, {0x2}, [@MPTCP_PM_=
ATTR_ADDR=3D{0x14, 0x1, 0x0, 0x1, [@MPTCP_PM_ADDR_ATTR_ADDR4=3D{0x8, 0x3, @=
multicast2=3D0x7f000001}, @MPTCP_PM_ADDR_ATTR_FAMILY=3D{0x6, 0x1, 0x2}]}]},=
 0x28}, 0x1, 0xf00000000000000}, 0x0)

self-connecting fast-open with an empty data buffer (on a preemptible
kernel, what could possibly go wrong?!? :-P)

The splat is caused by the following check:

	WARN_ON_ONCE(!__mptcp_check_fallback(msk) && !subflow->mp_capable &&
                     !subflow->mp_join && !(state & TCPF_CLOSE));

Without a repro it's hard to guess what is going on, but looks a valid
mptcp related issue.

/P


