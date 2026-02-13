Return-Path: <netdev+bounces-258658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II8UKFJjj2n6QgEAu9opvQ
	(envelope-from <netdev+bounces-258658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:45:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22203138B98
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 18:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB3293034C9A
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26AF16A395;
	Fri, 13 Feb 2026 17:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h9seos/h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38C8287E
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771004750; cv=pass; b=JNkZB6O/hXs1CfSfHJjjbptz48UjHtM2YS5iOaUA+egpSCVHbSijUtUHmyBQtoQ9YxMnNM7pXDqULEj8ERy20cgFtONpS+eZ9MsSxMQFkW3wscjL5/vQ6S0QmHwTixnTKBx/Ych3IqeH1Z+Wu/v5tTsOzqGtz98fiBpGH+gE/y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771004750; c=relaxed/simple;
	bh=NlQKFza6l2j2GPRtzrG50+ywfP+FgPi8CyHcNGhjvmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A2saeWpNWiKkRqtrd5aP+KdgE515uqaY0z1ShYkFR2OIVV41q1zjDZCNc5R4q0Sq7fMscDXidfO6AQOjnnO5lV+d8zOvPUrmhu4K5gdG/K9Rn3SPk+nzyYxnzDKhw++lphCoC/SQX3aJFk9ngnE07U7iiifNbaekbIoKDgBftc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h9seos/h; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-896f82e5961so19728976d6.0
        for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 09:45:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771004748; cv=none;
        d=google.com; s=arc-20240605;
        b=OuJ5ZlO0tdzb22Q0YzXA/xplFd63hG/MrR1CQi6ZASK9z6CXaKQfh3rYwd6soyXNL2
         b3je21OEVqnrNYgv7nd6rQ0syL0eGqLkQUGkyLevApxL5ncwbrEETrNNHCZVDOgrXZ/y
         BzLYxA5RmSNug7Np+glSe0wKRUseM5JvaIGl+U1gNHVklQNIKX2ZHxoeeEFVbQ6JmQpl
         mTbm6smQ10LMSrJbVurcCyNHtIYYOby6J1relBECsvKU9Rg+o9vi8Hhvohzj3wciAxKn
         tZYbtM2XTUlOEcWfACT3A8Y1grMYxDhh3+g2EKo96v1a/94C5sgYYdKgtcIPMhBXvddO
         4FcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MP2oACDFm3pEtgrZcYWrh7Sv94HukkUZx1Nq8rOiQaw=;
        fh=5yHlJCMbRYC9T56hjuM1BE3pBNE9UlWJFhmwYuQ8/Hg=;
        b=W8XaPmTVQ2rVZWxvvhzvSSUMxD6lYSAbYcgh/Tg3XEvgR0fob9o1+hxB1ia3jt2uyz
         itDwD0NlegBqsBc5crSMObKuULMVn8Q99/NeJhLQerchZDlhCpY4BWfU37vwIi7XYX7P
         bXijs3wXjCyJqRqWxRXi2fZlEAim5q5PLwNN7KG4wSALLqkrZ2JgvW3q4sSVGPAVj5k7
         Q+pgcRg51vdp5Y+l5zqqIue4xlv3d0QVY9pExgM5wxrYM6myJd51NYN+aTPDD87pfRWS
         ot/Ga9I7HMsEQINb8nok7rB/tD+33RXVsGg41QOec8i+I01thonnqgbPKqY8ll9YU9Kw
         XywQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771004748; x=1771609548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MP2oACDFm3pEtgrZcYWrh7Sv94HukkUZx1Nq8rOiQaw=;
        b=h9seos/h8Nrw4UKZ3xQbYlp9Sh2oNyoR+uG7o5+Bup8LZQ36K4OCg+AAswcGzWBZP5
         d4mVHGN4h6FVcuXu5St5Gj5/0tNiAiT6KVM0HmINLaqtPT4aB3BTmLPjxf4ztKRUE39n
         k6h5mk3Cb+ulX/xUSVp3tvF4c7+8oopE2+FZFtL0tDcJzGyv5NKNBtDivg+96MW2k7bx
         T5HAMl+zPktttfZze9tpVJQWhQiiQKmqZifBvieK6Hdzu0nj1pbWg6pwwOZzbNMYW2dw
         3TcXkNZ/inX8QcpTO6/vwoPByM/ucNO6o7pRTZ+WpEPufYHJHqCwNxtq3fKCnMrS5PaG
         318w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771004748; x=1771609548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MP2oACDFm3pEtgrZcYWrh7Sv94HukkUZx1Nq8rOiQaw=;
        b=JuEeBpUN0Pbcww8XCTwBbZXgiqoicfadTzkgANiRXqxwGexrbQ0Cm3kXtlaSQGvSXu
         N2Zx4SmDXHuphfPsOK838DBU9voVBn4Ibckl4qtpoAlAF6TlEREwWUpk+tX+f0To7Jf6
         u55Z1EXO5ekJg+UouFtU1pSM7KFTnh20Ljb371mlVKC1+IMg3sOUe77ykcRDTuyWq0wL
         ZXAb7kHlwiwU9NpOXRFDROTqKbmY5XOktL7Ht1v6xBu57YgS+F2GULfC48Nue0QxqOWL
         awxHKJxLVQkk5bbOrykeF/Zg4V+P7Y3Q4b46WFSnuyyjBJK4cr2nDZH1NsENO+hWhvz9
         tt6Q==
X-Gm-Message-State: AOJu0Yx1hwA5DODJnwWvec5b0UbIkqz/qpKyJ971mdkh4xwQ3U5Rj7Wc
	qZlNliL/KG6jSw1P4UJvKBlifYKWMKCoVrZW147qWuaYEK8dTloRy1k2KDfTsiVwZeavItdIIio
	lDrryhHYawtW2sB/ApkkefS4tQodqBneZutcMuq1usASOkDlyh8IuuuXqp6Y=
X-Gm-Gg: AZuq6aK0rV27S6zwoPX15aAwVlecXkkxdcIhQYadwmfgJTefqkqKnbT3FMpd2eWVcNN
	Ex/cxmVY4Mo2Zx2tNsfxLMVpmMsVy36XbQ0dngC2YiDdOg8jatebyfSgzL9LV0W6FnfEEBT+W/L
	pZEM/lpK6oXyb/Up6QKkocXIxxibIM1IwZCRe1HG5nr9AVMwRoUubecUs14+Vg0f1b2e/2ymrYv
	frwUBRZv2qirVqyH+PYWaGbNzoexd7CVQbpYOB7Bx0eFJd7dhAz9E3UazskXkt/MvWEp38aR6sD
	59iN3Lg=
X-Received: by 2002:a05:6214:1c8c:b0:894:6daa:a01d with SMTP id
 6a1803df08f44-8974049cdeemr4833126d6.52.1771004747700; Fri, 13 Feb 2026
 09:45:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DU0PR02MB95889B670EBF541E6ED3EBCCE261A@DU0PR02MB9588.eurprd02.prod.outlook.com>
In-Reply-To: <DU0PR02MB95889B670EBF541E6ED3EBCCE261A@DU0PR02MB9588.eurprd02.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Feb 2026 18:45:36 +0100
X-Gm-Features: AZwV_QgEajRrtYzzOt8rnbco5R57dVPOdqZueY_Rmk74IEKEggV2DSU08o_PDwI
Message-ID: <CANn89iJBNN05gSq91nc0vVH6RVVCXwEwaFb-JtCavU2UVZR=zw@mail.gmail.com>
Subject: Re: ip6_tunnel.c question about https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=81c734dae203757fb3c9eee6f9896386940776bd
To: "Froehlich, Dominik" <dominik.froehlich@sap.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	URL_IN_SUBJECT(1.00)[git.kernel.org];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258658-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sap.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 22203138B98
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 6:31=E2=80=AFPM Froehlich, Dominik
<dominik.froehlich@sap.com> wrote:
>
> Hello everyone,
>
> We recently upgraded our kernels to 6.12.67 which contains this commit
>

This has been discussed already.

A prereq was missed by stable team.

Please use 6.12.71

> commit df5ffde9669314500809bc498ae73d6d3d9519ac
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Wed Jan 7 16:31:09 2026 +0000
>
>     ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()
>
>     [ Upstream commit 81c734dae203757fb3c9eee6f9896386940776bd ]
>
>     Blamed commit did not take care of VLAN encapsulations
>     as spotted by syzbot [1].
>
>     Use skb_vlan_inet_prepare() instead of pskb_inet_may_pull().
>
>
>
> We found out that it breaks our VPN setup that is based on passing IPv4 t=
raffic through an ipv6 tunnel
> network.
>
> It seems that we run into the drop condition here:
>
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82if (skb_vlan_inet_p=
repare(skb, true)) {
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82DEV_STATS_INC(tunnel->dev, rx_length_er=
rors);
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82DEV_STATS_INC(tunnel->dev, rx_errors);
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82goto drop;
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82}
>
> The previous version worked fine:
>
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82if (!pskb_inet_may_=
pull(skb)) {
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82DEV_STATS_INC(tunnel->dev, rx_length_er=
rors);
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82DEV_STATS_INC(tunnel->dev, rx_errors);
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82goto drop;
> =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82}
>
> I don=E2=80=99t know if it=E2=80=99s related to the negation that is now =
missing..?
>
>
> We are setting up the tunnel using a basic ip link command:
>
> ip link add name bond0-ip6tnl0 type ip6tnl local fd8f:6d53:b97a:1::a:4120=
 remote fd8f:6d53:b97a:1::b:0 mode any
>
>
> Where fd8f:6d53:b97a:1::a:4120 is the address of a local bond device ensl=
aving two tap devices each connected to one VPN server for high availabilit=
y.
> fd8f:6d53:b97a:1::b:0 is the address of the remote bond device on the oth=
er end.
> Both devices can ping each other just fine on IPv6, but when I try to sen=
d IPv4 packets through the ip6tnl device, they get dropped on the round tri=
p.
>
> We patched out the above fix for testing and confirmed that it works agai=
n.
>
> I=E2=80=99ve attached a pcap file of a tcp SYN attempt  containing the ip=
6ip4 headers as they arrive at the ip6tnl device. The SYN-ACK returned is n=
ot showing and gets dropped, leading to SYN retransmission.
>
> Can you give me some directions? I=E2=80=99m still trying to figure out i=
f there is an error in our setup or the kernel.
> This used to work for years so I=E2=80=99m a bit puzzled now.
>
>
>
> Best regards,
> Dominik Froehlich
> SAP
>

