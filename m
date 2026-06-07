Return-Path: <netdev+bounces-296219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dqoIKV5MJWqQGQIAu9opvQ
	(envelope-from <netdev+bounces-296219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 12:47:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB85665001B
	for <lists+netdev@lfdr.de>; Sun, 07 Jun 2026 12:47:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mojatatu.com header.s=google header.b=dv1fadNV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296219-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296219-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C839A304BBDC
	for <lists+netdev@lfdr.de>; Sun,  7 Jun 2026 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD2531F9AC;
	Sun,  7 Jun 2026 10:42:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62CB291C10
	for <netdev@vger.kernel.org>; Sun,  7 Jun 2026 10:42:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828945; cv=pass; b=TTnOv2bta7G1jOg1Sxwcp70hDGkpTd8r1RNzodpOywVFYBA/0ZonRCdufTMgFywJO5U8x31wZgFHBDEC+wO7klg4d4N0MCIIGbbDG+aflVMQnAR+EMkyOH6D8c/nZfQr0jWvt9rvfTlfMKHDOXk5uvCjc0y/rVXjxkmQhJ3h06s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828945; c=relaxed/simple;
	bh=nm1kSW7uGBwHp9ivo2uRnEtL5DMlKDtFnw1T3o2OkRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tip8lpaflJPexTyvIrE+UC5R/vMJYrjCsAY5NlOR5P2pJ73ZxDA+5hVtktsRuMr6ES+jtm87W7dnZbJofcHnCkeT9A8bhj1a8pV1xqtgCL1GQLySiiYF3nwccF7U4vzpaaYBohRPCc5S8MACmg2f54BwVh0AMZMjcJAF5bP8qj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=dv1fadNV; arc=pass smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8423610ec93so2652432b3a.2
        for <netdev@vger.kernel.org>; Sun, 07 Jun 2026 03:42:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780828943; cv=none;
        d=google.com; s=arc-20240605;
        b=lUEV2klVN0PnxpEaxr2Cu9TmPxbe7znal4WsPh1ceePQ3xnIjLP3oFoZwOEAQuyhC7
         NBicM3bj/HDBGOxPhJbCUyUEaSOqbz3tUMkU4KE9MMIOf1eZXgTX+4hVDwFcnq7zpcKJ
         p/C0QnTlVpNisDqKGmUByl/gYHj0MQMrigMkQqH1iUuFSG7Soh5vVUWjL5VAC1530K0T
         jbD4t5CcxTIZdD9m1k7q6AFRlkAWxWL16PvDHxqhVfCkjh8C77r2KFvzAgIM9AQGvfwm
         WgTaOL67Wz3YRsdPLSbBmAck9yp8xGPmdL5RwAERzs/KXcijxIaKzg5n+IbqTQ/N94EI
         x8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PC9jnqHu/XnMh1/2hI7tqdGIASHNGz+5rE+pmkkpmvw=;
        fh=tPIdxDGehFhgFaZEb/9rKY73nhiNY/B/RlP7swQUxF8=;
        b=iDlILTgHI8OHcUPaf3Wu9bBkIKS2dapHqAs584I87XYTd4qz4iKk9uYzh6dDdNojdc
         Fsg9pP6Pox927bdpFptbwsAsYYmYa+IAVnbbLCXmqyybADZ0/C1+4FwsaQ4HOAo5GvAX
         EcbONjpazNXjr8sSvaya5mxSEr3AmJyW3BNAxw9brkM2aNX5icSaXkgo975vM+g4DD0G
         B+zS9mxdnrp+AwpWVaEn5FSk0AtN1zV0z3nYnnb2JZfi5ay6BhS65UO0EuSLNn2nE5nk
         g5zpL8kkZqLkwYq097yx/jzI9cvv3vjDJ4goiqD6h4sxa/ue6mU6VMDqeCtMTVZWvB/D
         3vFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1780828943; x=1781433743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PC9jnqHu/XnMh1/2hI7tqdGIASHNGz+5rE+pmkkpmvw=;
        b=dv1fadNV54Tbz3SEeBOzfCHDCAFQonVTR/owMGriDqC+5ZopoEtxEy7sou8KJWDv+b
         2yOQqIKqzHwSlPNsnFBVNl+hI6UyAbK7/1Vm2ic9zPxEkg/ApW4W+46ETor4UaPPFNwc
         MO7d2ZEzZkKH+hEb80BSx7Fqvx6kuRHawyL1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780828943; x=1781433743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PC9jnqHu/XnMh1/2hI7tqdGIASHNGz+5rE+pmkkpmvw=;
        b=fiWu1rVf1Lkp0liEWygoGlvBrS32IdjWgRlJ1MPMX6ix41ezz7oZX57U9mJM3bxYzM
         wDzahR2zioDafWnpBy2iuagQdQdFnWFg1MpS7PBGxhHvVOpi/lpeqCtM5xxvUSNvXn5m
         C1Di948mqI9enkDDiZP305ooNRGAC1+RPyQhFVqIp1f+lrZWgLx3nGMWV6ZONSXxAaQ2
         stbJa7Ez5Lf/J70dlAziyLdhabh3dtAb5xbW0OAfkshRi9TJ9xZAczDlKljWUOveioOg
         Mp9z6IJqtpTNCGn/Eqokpn6c/K1n+6H4fphLH8bWGE43nbdB/FjTDJFrQdFWwx6gWijZ
         speA==
X-Gm-Message-State: AOJu0YytiKNi1gpfF45WZwAUTzGdQ1Uygi7MV/7tcnzmaIVWrJUBbxwY
	B6C9h0CLkk8gEjg3gTlzsj/I8vHZ31xbFlKG2zU9PHYKg5P6t5rbV7FWr5Wz4KwnTKNOhVq5pe6
	hpCIfAqi6SOFx6Ex4L7Hy/4B8DV8+c0Veul1CJkt3zTlIYq9vc/QjuLRr
X-Gm-Gg: Acq92OE1mkRcYpu1XNskki512c5d/xknf/5iE4jYwkupdnESw3vk+2Jh7HDhySuMBtR
	5/iQVF0xSBmzL9qytfDNLgWmXj15aQ75ZKZe+WzMJroimupJmFzKDhCj7/IRyGPgGSB+X84E6qK
	dHguqLC7arlirGFL5KDlFfxos0AL5HRh/lhJbCbDOtPlt/CAT/Ry+70zmrDoSyaySmkDqVhBBWz
	XXEfNpDpMAnqoec3GBVZzokFKMnZ83bChX+JI/xoJuP6g2Sxha87DYCryPGu5COc92OymYd0Kkp
	popKLuUUCGxERHHF7lg=
X-Received: by 2002:a05:6a00:4b04:b0:83e:d427:9817 with SMTP id
 d2e1a72fcca58-842b0db7dbamr10636323b3a.11.1780828942886; Sun, 07 Jun 2026
 03:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1780809474.git.edragain@163.com> <6200dc9e5ea7a85d500e72543d897c2d930fcdce.1780809474.git.edragain@163.com>
In-Reply-To: <6200dc9e5ea7a85d500e72543d897c2d930fcdce.1780809474.git.edragain@163.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 7 Jun 2026 06:42:11 -0400
X-Gm-Features: AVVi8CchEQ3PxI_r86lB2NRfDKNEQNLVatLtq5CzQ7njqfgPPuE-f37Tjh_w5s4
Message-ID: <CAM0EoMm5YH+BKEUbtAy7iaxrF73Wti==9n1gbMOHwK+vaFALdQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] net/sched: act_ife: ensure ETH_HLEN is pullable
 after decap
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	xiyou.wangcong@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn, 
	edragain@163.com, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-296219-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:davem@davemloft.net,m:xiyou.wangcong@gmail.com,m:yuantan098@gmail.com,m:bird@lzu.edu.cn,m:edragain@163.com,m:victor@mojatatu.com,m:xiyouwangcong@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,resnulli.us,davemloft.net,gmail.com,lzu.edu.cn,163.com,mojatatu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB85665001B

On Sun, Jun 7, 2026 at 5:14=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Yong Wang <edragain@163.com>
>
> tcf_ife_decode() calls eth_type_trans() after ife_decode() removes the
> outer IFE header and metadata. However, ife_decode() only makes the outer
> IFE header area pullable before advancing skb->data.
>
> As a result, the decapsulated inner Ethernet header may still be shorter
> than ETH_HLEN in the linear data area, or entirely reside in frags.
> eth_type_trans() then operates on an skb that does not satisfy its
> expected Ethernet header access requirements, which can trigger a BUG in
> the pull path.
>

From inspection this looks legit. I did not run your poc.
Could you create a tdc test instead? You should be able to craft a
scapy ethernet frame using nsplugin. Something like this:
Ether(type=3D0xED3E) / Raw(b'\\x00\\x02\\xaa') would suffice.
That would be more helpful for future reference as well.

> Fix this by requiring ETH_HLEN to be pullable before calling
> eth_type_trans(). If that fails, drop the packet just like the other
> decode error paths in tcf_ife_decode().
>
> Fixes: ef6980b6becb ("introduce IFE action")
> Cc: stable@vger.kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Yong Wang <edragain@163.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/sched/act_ife.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/sched/act_ife.c b/net/sched/act_ife.c
> index d5e8a91bb4eb..e0075e3f6949 100644
> --- a/net/sched/act_ife.c
> +++ b/net/sched/act_ife.c
> @@ -759,6 +759,11 @@ static int tcf_ife_decode(struct sk_buff *skb, const=
 struct tc_action *a,
>                 return TC_ACT_SHOT;
>         }
>
> +       if (!pskb_may_pull(skb, ETH_HLEN)) {
> +               qstats_drop_inc(this_cpu_ptr(ife->common.cpu_qstats));
> +               return TC_ACT_SHOT;
> +       }
> +
>         skb->protocol =3D eth_type_trans(skb, skb->dev);
>         skb_reset_network_header(skb);

We already do a pull in ife_decode(), so why not just extend that to
have ETH_HLEN?
Given that IFE is always encaped over ethernet frames it should be
fine to assume ethernet header.
i.e something like:
-    if (unlikely(!pskb_may_pull(skb, total_pull)))
+    if (unlikely(!pskb_may_pull(skb, total_pull + ETH_HLEN)))

cheers,
jamal
>
> --
> 2.34.1
>

