Return-Path: <netdev+bounces-29041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92ABC781729
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 05:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B771A281CC1
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 03:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764C9111A;
	Sat, 19 Aug 2023 03:23:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0163C
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 03:23:41 +0000 (UTC)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11484121
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:23:40 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34b01711a15so57675ab.0
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 20:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692415419; x=1693020219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE56BA+fjk8/z3qvl6qq/GPKLP13SHW87kDx4EuRSw0=;
        b=3I1rU9H9rqRgHY2QkBBZcK4ymBmaj+bqn5e86MzshNOSE1kSP21V44AlgsQZWFjaXA
         im90AOesezLS3/sNC2niPKyHBxBzIss7jAXPl1KbFWMj6SrOydboDUuob0+PJlNPUf/O
         1NPQpdWnIZSd1+2Oh1iNnnxyQOXKE0KjUAGu3RIT5M9iuXn5a4qguwOUtxwXMyKV9OLO
         wMq4MHEDItBf+BcHkpx6DYpMu3W68yFM4iAy/OB9ddQKbfpehPB2dtXLWEG1CrMTuhXz
         EMlFulCd6HbMIZBaAsiFNpn2BDe6WWba+MiwI160LXuFuUfymARJWUavRDFk9y+6IInY
         Crzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692415419; x=1693020219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RE56BA+fjk8/z3qvl6qq/GPKLP13SHW87kDx4EuRSw0=;
        b=NW+ndqr4IBWWzFEQy/82eIMozYwJ+FdYv0u4IGA0vtNrCDtnjVMdqqCAVfvakaNwzZ
         S6AAlrAW/q9GLE1SzB5YD7Z91KG9FeZKfJyoetaPfz/nkaUvanwsRQQ+zRvwlpPkuUxm
         QE+lSVdpDavM5mRKRcMe6jJ8jbQBd4aC1h41iAAH9zmJz500ewhSGBsCxdiMuCATzpRb
         EtF2jvbBkxjFCK1O+X4a+kwSoecyIvObu3j7u3iKB0emYotwE9xVdq4xrj0P0ai3Ng1Z
         jMsewHYzHXGEcCJ8jSPveqhTJAFdUyR+W1wjzFQG2oG187Ws+90bw41H+BeKkRrceZVX
         s7uQ==
X-Gm-Message-State: AOJu0YzpNoFNt5OET+RpBUdJB1WSad4iinoqMwi2twoxKCU0kruddZ/6
	DBbWhEjTnLMSaGglOTCYh994ObCIImlJPNNlAuAOzg==
X-Google-Smtp-Source: AGHT+IFR47N9u0TH7mIkOMfDcOzMPWv0Z04MxXtBy1b6R3HfQI1/EJLUTf5amDGAYHVzNsjmpVkg9j/lxgBUg0qnvaQ=
X-Received: by 2002:a92:c542:0:b0:346:676f:3517 with SMTP id
 a2-20020a92c542000000b00346676f3517mr367257ilj.11.1692415419206; Fri, 18 Aug
 2023 20:23:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230819012602.239550-1-kuba@kernel.org>
In-Reply-To: <20230819012602.239550-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 19 Aug 2023 05:23:28 +0200
Message-ID: <CANn89i+DzusGJEZQYXe+z_zDzj7deYvWrxG7G=9L3Q+r1P0h9g@mail.gmail.com>
Subject: Re: [PATCH net] net: validate veth and vxcan peer ifindexes
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com, wg@grandegger.com, 
	mkl@pengutronix.de, idosch@nvidia.com, lucien.xin@gmail.com, 
	xemul@parallels.com, socketcan@hartkopp.net, linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Aug 19, 2023 at 3:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> veth and vxcan need to make sure the ifindexes of the peer
> are not negative, core does not validate this.
>
> Using iproute2 with user-space-level checking removed:
>
> Before:
>
>   # ./ip link add index 10 type veth peer index -1
>   # ip link show
>   1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mod=
e DEFAULT group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>   2: enp1s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel st=
ate UP mode DEFAULT group default qlen 1000
>     link/ether 52:54:00:74:b2:03 brd ff:ff:ff:ff:ff:ff
>   10: veth1@veth0: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state=
 DOWN mode DEFAULT group default qlen 1000
>     link/ether 8a:90:ff:57:6d:5d brd ff:ff:ff:ff:ff:ff
>   -1: veth0@veth1: <BROADCAST,MULTICAST,M-DOWN> mtu 1500 qdisc noop state=
 DOWN mode DEFAULT group default qlen 1000
>     link/ether ae:ed:18:e6:fa:7f brd ff:ff:ff:ff:ff:ff
>
> Now:
>
>   $ ./ip link add index 10 type veth peer index -1
>   Error: ifindex can't be negative.
>
> This problem surfaced in net-next because an explicit WARN()
> was added, the root cause is older.
>
> Fixes: e6f8f1a739b6 ("veth: Allow to create peer link with given ifindex"=
)
> Fixes: a8f820a380a2 ("can: add Virtual CAN Tunnel driver (vxcan)")
> Reported-by: syzbot+5ba06978f34abb058571@syzkaller.appspotmail.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

SGTM, I was not sure how to fix this myself ;)

Reviewed-by: Eric Dumazet <edumazet@google.com>

