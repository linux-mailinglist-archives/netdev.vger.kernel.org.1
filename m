Return-Path: <netdev+bounces-35566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D8C7A9C0C
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 21:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C8D1C2011F
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E719018C28;
	Thu, 21 Sep 2023 18:53:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BA412B69
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 18:53:27 +0000 (UTC)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199DE79602
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:53:15 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-34fcc39fae1so18955ab.0
        for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 11:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695322394; x=1695927194; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZhZTyGMIwZ/ie/LDnjolHR2PA5j6eoOnn74VlJviEM=;
        b=MHYyaSZFDHxJdp+KNJa72USUNY4jSsVlN1zFOuDcDHbfhbOvl7Ed3OorsanXvud7AX
         OlUCffcr/lk0BYL6+4f9ok0xeIPT5wyyi/6qtvtCuhtjwvkC02buiYaWWidzkHQIbFjM
         682+p1OmHT+1buNLV3tBovrfaL8qa4cYsU8iHZUG4KsECHEIQ3wtfyiJZITsJMQ43uo2
         CcvQNsgpQXWXeteuM8I1ahsyt2Hcf81pQUsO3fTmB4RmeUqqn5tPhLrN69/LQeiJEYn6
         hmhCzOlRfn3q1lqHn46rgKEstKL+A8LNU8dzvmzmOuMLvXOFviLLJVw1rAPXB49H+tZr
         +Ntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322394; x=1695927194;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZhZTyGMIwZ/ie/LDnjolHR2PA5j6eoOnn74VlJviEM=;
        b=BzRJefJdzN+0Y2s0T+6ViLNlKyrhlGOA/KjAq4vGdS0GpPzNI6tX6S62U6bgvwGiMB
         C5vTrWpRHodGT9EzMpFx7hitAK15rar9jHIKC/bxipgWDW218WTwgRO8EPG3+Fc0fvHF
         /a6/LCWqf00iJpurVho9WAJdqpsbJbACm3+H5giC8jjBLcj9fJ0xIFxTAVhqCHnFG9hF
         Nyj59HU6xFkPf+0RT61EiXq7/6eSojGZeSJNRTGGH3/D6obZy75PvZxRRZ4VByhJKk6N
         jhLrTInV12t7L3Hp8xqZ7q0qTRJ8y/Fk13FHCY3UbVP37+RUp/vxv/okFWz2ev4ll1ZF
         4B4g==
X-Gm-Message-State: AOJu0YyUw/nQT9PAa4Bvj7A2L8A4yxF5DhsHK02Q28R8JZZSlZK/xUl4
	ds1MaiyO8i/ww/1xIwn0TsmKH7ibfBqIul25J4F7aYOAGkQyfa2ibYM=
X-Google-Smtp-Source: AGHT+IFWIeurUPvjpL8vBL+NRQRjjve76EQFHIAx0HeE7Z69wb2lo8venh8x2KPWv7LuxH/KDV+UnqVPhre4/L2Akrw=
X-Received: by 2002:ac8:5b11:0:b0:403:e1d1:8b63 with SMTP id
 m17-20020ac85b11000000b00403e1d18b63mr211399qtw.24.1695294572440; Thu, 21 Sep
 2023 04:09:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <730408.1695292879@warthog.procyon.org.uk>
In-Reply-To: <730408.1695292879@warthog.procyon.org.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Sep 2023 13:09:21 +0200
Message-ID: <CANn89i+wUq5R2nFO8eGLp7=8Y5OiJ0fwjR+ES74gk1X4k9r0rw@mail.gmail.com>
Subject: Re: [PATCH net v3] ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, 
	syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	bpf@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 12:41=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
>
> Including the transhdrlen in length is a problem when the packet is
> partially filled (e.g. something like send(MSG_MORE) happened previously)
> when appending to an IPv4 or IPv6 packet as we don't want to repeat the
> transport header or account for it twice.  This can happen under some
> circumstances, such as splicing into an L2TP socket.
>
> The symptom observed is a warning in __ip6_append_data():
>
>     WARNING: CPU: 1 PID: 5042 at net/ipv6/ip6_output.c:1800 __ip6_append_=
data.isra.0+0x1be8/0x47f0 net/ipv6/ip6_output.c:1800
>
> that occurs when MSG_SPLICE_PAGES is used to append more data to an alrea=
dy
> partially occupied skbuff.  The warning occurs when 'copy' is larger than
> the amount of data in the message iterator.  This is because the requeste=
d
> length includes the transport header length when it shouldn't.  This can =
be
> triggered by, for example:
>
>         sfd =3D socket(AF_INET6, SOCK_DGRAM, IPPROTO_L2TP);
>         bind(sfd, ...); // ::1
>         connect(sfd, ...); // ::1 port 7
>         send(sfd, buffer, 4100, MSG_MORE);
>         sendfile(sfd, dfd, NULL, 1024);
>
> Fix this by only adding transhdrlen into the length if the write queue is
> empty in l2tp_ip6_sendmsg(), analogously to how UDP does things.
>
> l2tp_ip_sendmsg() looks like it won't suffer from this problem as it buil=
ds
> the UDP packet itself.
>
> Fixes: a32e0eec7042 ("l2tp: introduce L2TPv3 IP encapsulation support for=
 IPv6")
> Reported-by: syzbot+62cbf263225ae13ff153@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/0000000000001c12b30605378ce8@google.com/
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: David Ahern <dsahern@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: netdev@vger.kernel.org
> cc: bpf@vger.kernel.org
> cc: syzkaller-bugs@googlegroups.com
> ---

Looks safer indeed, thanks to you and Willem !

Reviewed-by: Eric Dumazet <edumazet@google.com>

