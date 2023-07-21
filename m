Return-Path: <netdev+bounces-19973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B32BA75D0F7
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 19:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39851C217A3
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCC4200DC;
	Fri, 21 Jul 2023 17:55:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037127F00
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 17:55:43 +0000 (UTC)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD99330F5
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:55:41 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40540a8a3bbso25181cf.1
        for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689962140; x=1690566940;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lmGkZtpKVjhWYJo2BcFWKOp6KYzC2gVreeXVnY79hdQ=;
        b=HcDcdW3PQrGiBuvKbMgW73wM93D6wrOyfvTVkJiM6Lavj72a1BYy0Dk3MWKGj58W3p
         ++kQnfvPPgwluoQKtIp6yO3YTMIVk74HUD9QTLH4JRfXAXJh9shGTFGOvn0FqOXnuX5b
         bkhRet5kmH4bPOMl1MOmrwNfWSN13vvoNFyDPrzKTrcaBkAhlQLp/HBz0CPOhmG2qraN
         yr4S5EnR/Qy0hugs/0/awpvQzSK72OuuwOFJqFB+2AfQRNL/bMyywqWg+Zj5SrZ2FeBQ
         A1HrerfNOjAsqckecyfwkxuiFYmibFoIjSEosycROVr++q5ACox2QeztA/plIA0XhwPF
         NPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689962140; x=1690566940;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lmGkZtpKVjhWYJo2BcFWKOp6KYzC2gVreeXVnY79hdQ=;
        b=EJDVjUJnvvDxndkkByd74rDOhjyIDiJsYhlnh0VFFxuXrSMLntPVvdHSnhQ9Pzbjv3
         LKxje7lMbQ0hgiuSA37oxAS/W0D8CwUsYFZpek7YREc4cIk7bRk/uN+8bnBDcMXNcH/g
         mjqkq1Qzc+FjX7jQ9j4vzTekN+AfEQsJ1GJjKa03bRpvMucIivZaT6t+JQY/O6Yr/s4B
         Vo1bOmiZP61OryhqRU5u9xLeq5dNmqWSwnrjq0KBx+7IyiE01WMwnpOC/6vIjVQzlLxL
         u37f7MEFy1IwUZvqGlxAix61/Rp06PNfmCPmS4k6A9JWMZQjLdHAFTxXNKY1P01h4UYp
         /9cQ==
X-Gm-Message-State: ABy/qLbiD8J5XUeNizpy841VRXpyUKv30ZmaAnmiyMzkhjnFCEOnuuOh
	gkx/GJzWm8ypwdX7ZL+eVBJd6xmViw0zIU7C5+5vTGqzuBbKsxvG6607kkSi
X-Google-Smtp-Source: APBJJlEWnpG36KeoqNKYnCBVekAlVVigLRc9QA61UtEMrgROBGDH3Uj96Mhhc3k6JjYThKrGLGjZbT93SZh4vvWZsow=
X-Received: by 2002:ac8:5716:0:b0:403:f3f5:1a8 with SMTP id
 22-20020ac85716000000b00403f3f501a8mr26479qtw.12.1689962140542; Fri, 21 Jul
 2023 10:55:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Fri, 21 Jul 2023 19:55:28 +0200
Message-ID: <CANP3RGfRA3yfom8GOxUBZD4sBxiU2dWn9TKdR50d55WgENrGnQ@mail.gmail.com>
Subject: Performance question: af_packet with bpf filter vs TX path skb_clone
To: Linux NetDev <netdev@vger.kernel.org>, Jesper Dangaard Brouer <brouer@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Pengtao He <hepengtao@xiaomi.com>, 
	Willem Bruijn <willemb@google.com>, Stanislav Fomichev <sdf@google.com>, Xiao Ma <xiaom@google.com>, 
	Patrick Rohr <prohr@google.com>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I've been asked to review:
  https://android-review.googlesource.com/c/platform/packages/modules/NetworkStack/+/2648779

where it comes to light that in Android due to background debugging of
connectivity problems
(of which there are *plenty* due to various types of buggy [primarily]
wifi networks)
we have a permanent AF_PACKET, ETH_P_ALL socket with a cBPF filter:

   arp or (ip and udp port 68) or (icmp6 and ip6[40] >= 133 and ip6[40] <= 136)

ie. it catches ARP, IPv4 DHCP and IPv6 ND (NS/NA/RS/RA)

If I'm reading the kernel code right this appears to cause skb_clone()
to be called on *every* outgoing packet,
even though most packets will not be accepted by the filter.

(In the TX path the filter appears to get called *after* the clone,
I think that's unlike the RX path where the filter is called first)

Unfortunately, I don't think it's possible to eliminate the
functionality this socket provides.
We need to be able to log RX & TX of ARP/DHCP/ND for debugging /
bugreports / etc.
and they *really* should be in order wrt. to each other.
(and yeah, that means last few minutes history when an issue happens,
so not possible to simply enable it on demand)

We could of course split the socket into 3 separate ones:
- ETH_P_ARP
- ETH_P_IP + cbpf udp dport=dhcp
- ETH_P_IPV6 + cbpf icmpv6 type=NS/NA/RS/RA

But I don't think that will help - I believe we'll still get
skb_clone() for every outbound ipv4/ipv6 packet.

I have some ideas for what could be done to avoid the clone (with
existing kernel functionality)... but none of it is pretty...
Anyone have any smart ideas?

Perhaps a way to move the clone past the af_packet packet_rcv run_filter?
Unfortunately packet_rcv() does a little bit of 'setup' before it
calls the filter - so this may be hard.

Or an 'extra' early pre-filter hook [prot_hook.prefilter()] that has
very minimal
functionality... like match 2 bytes at an offset into the packet?
Maybe even not a hook at all, just adding a
prot_hook.prefilter{1,2}_u64_{offset,mask,value}
It doesn't have to be perfect, but if it could discard 99% of the
packets we don't care about...
(and leave filtering of the remaining 1% to the existing cbpf program)
that would already be a huge win?

Thoughts?

Thanks,
Maciej

