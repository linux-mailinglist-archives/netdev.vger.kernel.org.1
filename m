Return-Path: <netdev+bounces-259935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMXsHFwJnGn8/AMAu9opvQ
	(envelope-from <netdev+bounces-259935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:01:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D19F4172DEA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 09:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47DC5300A8D4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 08:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0639734C808;
	Mon, 23 Feb 2026 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdK9FwaV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E65345729
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771833688; cv=pass; b=GXrMDluhT5tzeWJHvxWMK4nn8YFb6SE7WlKVe+bOw7mP4GlPWLxnxV8m8xcMoyxDukzBTbu+9GQ6YviEWW5Uwv/zwln+ZxyshHRZ2WM2Z2PAJc4DWOAcg4x08U6pRngrNivFrWyDK+pElfY8H379XCBBoSnjazq48QGTUh10IlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771833688; c=relaxed/simple;
	bh=K/6q6RkAywcpwdXEYmgKespAU22TbYrWPBmXAoPVm+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgearr3mGr+DpH0EBD0iu41jbohxHK7+8mSqOYap2Ce6urCMhKr5S6oPGL37d2Up2/cCTgtnSSoV/AGWkMjRDzG1LW+JD0G+qVSFBqv7QGx93ss2QSM0P7SbG5WzJU0B7iOyOajBl9v8dD1oHFG44hpz+Rt80G2YnrwVTAZdvik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdK9FwaV; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-506c02ec1b3so43628341cf.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 00:01:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771833686; cv=none;
        d=google.com; s=arc-20240605;
        b=J9B0Li6Tgg1xOCDEiCP33w27KarV/4BuUzRArUaToKkRR3fgzNcqmyzhTatgmIof3A
         UTzSHTRVLnKlHNg78eEQpovvcEKpCAOS+evL5kA6bBG4UMR4zWlei3nJCwwuUGRnBTYR
         ISw47jtz4eYPFZT1uh/lgbxWk+Ywup4fYS8WeMKPhOZvUu2qsIk/4mHuyVIxa3XgaHp4
         MWCWaUXiup3maRjyY3+gyZedjQldIb5VS5v1sFeXcayl9G8bhcNrfE5UGlCv0o98nlof
         PAaiqDVzstMHh7eOItK8fTCJKZ3zkO0QN1L/+/QIghCtXFP5LvflWGAi9Hdc6xjPfAsI
         PJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZHeMGjNoyVss0xbi9Q87Th7AGf/k8UCazyBAOVdMvks=;
        fh=Bmn2FrwyB+TMK4Vg022x5SyqEPgag6+f7BTZdoR6aio=;
        b=ivKUqxE2C67O278YR0uJgcZvO1tbUdpSg2j3nLeeQqfld+TfZVLHtjWr96Tar/wJz5
         CkuXWN3uhNzeZomEUsH5JCArdukZkS9TxWPUDbVGK5sxtAe5q8y7on+9W9TaP97m8+Xf
         oM+p+0cxT8DOst8LVA3qt13rWxpT/JgEqIIEk5MLWwWygMGr8a9hoe2Nfg3FFJkDODNS
         2BmKK8lMRka/SRd/2/5HzR9tp62I5VUaJNA80eToOC1flxSjZLd8WS/Q8jxp5TRLPU1P
         l66WFzKY1quH+n4c+jQDoTSNIkELO3/v4RHSbckSaY9nCSeGt8SnS3MVGiGwkXqn2HiF
         28CA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771833686; x=1772438486; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHeMGjNoyVss0xbi9Q87Th7AGf/k8UCazyBAOVdMvks=;
        b=QdK9FwaVhnzFMU6phiq69IYWiUe6H2Cv/lLVizsub4gFEpSQGK3k/KNKj8JnzX+Nh5
         9UvPxhVtjpdAsDitwJcHr7PIa+Y/iTTQQAd+w+AYruVsZ2J1cmKRTCmN1yhXnxE18MrS
         o2qzRTV00zQBFt5w8uJzDahEDaLD59DpjN/P2cFo7+Cdg3BRs2NmeiMcHm0T1NfF7DK5
         icWWCsis52EynRC3yZ45ZJqmlR4V5FEbuhp4VOHZScNJ+PrIcCkfpXqIJ+li/jKQXdU4
         cgzkKQpHSnI2BJJx1KRSl15frFB5OXrNj4l2RmrrHvfTLQz4hIaFwfXc6VJouZueEh9E
         QPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771833686; x=1772438486;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZHeMGjNoyVss0xbi9Q87Th7AGf/k8UCazyBAOVdMvks=;
        b=XCKKSkl/gA+JN2U16IzcWurBXGM8uz5QuPZSdvZZMwS+a71ndmAKKY9WFTncmNW7DA
         i389Q4tgpTvhDNDKuEpnBnWOzmfc7KHhKtLAzJ9GBtMAzsM5WtCU3Q6R6muChOpfIoNw
         fZhVHwgg4bHzGaagdsChaK6nRlEC5ZRs2465YUwOIIsqb1CE+kr/aGAO8fqx0KmdmPsl
         x7oxvxU2aRX3tMijqpHYHO4/LIg+FkAHWNvzlZLYc0YnYNBCyuO52GEfJy2UMs3k3Exf
         JvZuMdxLnHeSYJLfL+lNwPRfg69ZVHlI5Ic0nnq3HKp4o20yDlxLwHgIpiEmyXOtkXv8
         reGg==
X-Forwarded-Encrypted: i=1; AJvYcCUtaknWDWUfGmq/XfiUUxSqFtJueyUYwpwdKj7AhyIs6qUJVCdTyEouQbnfR8LZtqsv6omwlLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG3vGz6M+cX7OVDxVtxJE0ypsfINw+D2Q3DwwceEcRGrTzJez2
	LnMmCzVjPOcR1fEUCokERPorrR0a2B7lOIfWF9iNtSFytlVybrXiEdizscBT+ZwluX+E6qtMxsh
	q2TTp2wWT7uRWbM6qIfqHaYiftSR7GxmEKeMOovfm
X-Gm-Gg: AZuq6aJMU1eM1JKc2l0yXznp7e2GRtYcxxo6g7Ews/D8Gu+JSh9xsODdff8ucO9UchL
	9MK2F9S9B1ndsF5dQcFfc6dhhFu0DQRtYIxdLNKYFAJISMD4VAa8z2VqxDh1vOAGjg5FmUdkX3M
	oTlksOwWNRQC8cWxEWAkK8dkaRaFzg0azOxqgEeS2M34XPStMf4eBwDaiPL+eMGxsdRQykplUOU
	4RrJEuzmKQTWGFLa9l1UGyLYjyFLy5quQnsdei/38OgHj8vtG7jTcu+9cUaG4Xb5DadAwxz16W4
	O4QuLaQ=
X-Received: by 2002:ac8:7f8f:0:b0:4ee:1f69:fdeb with SMTP id
 d75a77b69052e-506f30ad7fdmr174135491cf.11.1771833685719; Mon, 23 Feb 2026
 00:01:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222-fix_zero_wnd_fin-v1-0-5f4034952f3c@gmail.com> <20260222-fix_zero_wnd_fin-v1-1-5f4034952f3c@gmail.com>
In-Reply-To: <20260222-fix_zero_wnd_fin-v1-1-5f4034952f3c@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Feb 2026 09:01:13 +0100
X-Gm-Features: AaiRm51s6F5nJUNwqq5YLxG7UGRRbTM5Nc5rtJlp4nPZ5LnqHN7N58OnUco-aUs
Message-ID: <CANn89iK5Kk2D-zMiw_2syb9OdmkKdgAA7aGfi8QNZ9XR4=CfvA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] tcp: re-enable acceptance of FIN packets when
 RWIN is 0
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259935-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D19F4172DEA
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 1:35=E2=80=AFPM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> Commit 2bd99aef1b19 ("tcp: accept bare FIN packets under memory
> pressure") allowed accepting FIN packets in tcp_data_queue() even when
> the receive window was closed, to prevent ACK/FIN loops with broken
> clients.
>
> Such a FIN packet is in sequence, but because the FIN consumes a
> sequence number, it extends beyond the window. Before commit
> 9ca48d616ed7 ("tcp: do not accept packets beyond window"),
> tcp_sequence() only required the seq to be within the window. After
> that change, the entire packet (including the FIN) must fit within the
> window. As a result, such FIN packets are now dropped and the handling
> path is no longer reached.
>
> Be more lenient by not counting the sequence number consumed by the
> FIN when calling tcp_sequence(), restoring the previous behavior for
> cases where only the FIN extends beyond the window.
>
> Fixes: 9ca48d616ed7 ("tcp: do not accept packets beyond window")

OK, but this commit is fine ? It seems the issue is coming from buggy peers=
 ?

Eventually the receive queue would be drained by the application, the
peer would retransmit
this FIN, and it would be accepted.

> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index e7b41abb82aad33d8cab4fcfa989cc4771149b41..fde612f12d3625000081958d1=
3cec8779684a642 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6379,7 +6379,12 @@ static bool tcp_validate_incoming(struct sock *sk,=
 struct sk_buff *skb,
>
>  step1:
>         /* Step 1: check sequence number */
> -       reason =3D tcp_sequence(sk, TCP_SKB_CB(skb)->seq, TCP_SKB_CB(skb)=
->end_seq);
> +
> +       /* Some stacks are known to handle FIN incorrectly; allow the FIN
> +        * to extend beyond the window and check it in detail later.
> +        */
> +       reason =3D tcp_sequence(sk, TCP_SKB_CB(skb)->seq,
> +                             TCP_SKB_CB(skb)->end_seq - th->fin);

I don't think this is the right fix. Basically it says that FIN do not
count, but TCP RFC says otherwise.

It also adds code in TCP fast path.

See for reference

commit 22555032c513e62fe744d4cdd553539897e8e922
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu Apr 18 21:45:58 2024 +0000

    tcp: remove dubious FIN exception from tcp_cwnd_test()

    tcp_cwnd_test() has a special handing for the last packet in
    the write queue if it is smaller than one MSS and has the FIN flag.

    This is in violation of TCP RFC, and seems quite dubious.

    This packet can be sent only if the current CWND is bigger
    than the number of packets in flight.

    Making tcp_cwnd_test() result independent of the first skb
    in the write queue is needed for the last patch of the series.

    Signed-off-by: Eric Dumazet <edumazet@google.com>
    Link: https://lore.kernel.org/r/20240418214600.1291486-2-edumazet@googl=
e.com
    Signed-off-by: Jakub Kicinski <kuba@kernel.org>

