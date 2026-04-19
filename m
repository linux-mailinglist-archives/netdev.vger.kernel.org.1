Return-Path: <netdev+bounces-279588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id LheMI/Lk5GmkbgEAu9opvQ
	(envelope-from <netdev+bounces-279588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:21:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0253424551
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 16:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B230C300DF61
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 14:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43C31D86DC;
	Sun, 19 Apr 2026 14:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rg939vXS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC2315B0EC
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 14:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776608493; cv=pass; b=RZ6L6fZ230FXFp/R6kZYyOo0KxCDDq03rjDvR4Hr9kDZllHPTx7CLga4I97jTYumLltZpvzavFO7uz0hiHb4az4uiyq9fABdrmv2CtX1i2rovlcY/0PIX/I+MJx4AEIZpgyntBNE8zJcEtGO2CfUcYGIbOf2IshqvARYMKnNntU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776608493; c=relaxed/simple;
	bh=vbS1DC16YcH1eNpgVmY86hKhwbfQDacZvJZ1lL+Fnws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XD2l4eEc8QNY1ooEujgcuXSrnEXVeFoC8Vo5lFiczr0ldfRJ3O5VpBOMGnphzJSiUEhS20VWUuYB6rvdzzG4JGKBQOSAuMS/zYNwr92z70xg3rD+BfkFQ9rOcprp/qhxXswfY3eKQq/q+KdE/fVmPxFg1oC4mT655fhmLarJSZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rg939vXS; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50e4ad756bbso9647291cf.3
        for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 07:21:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776608491; cv=none;
        d=google.com; s=arc-20240605;
        b=YWNezl7N7fnkHuZK9HwO7fEIS6dS2MQWzmJWbG1sr9fFFloYL4568oOQVUrSvBjgr9
         H1bC2/cmfOZaWc2AHdNT+nlo1drA6V1GthSsX6D621bRm4m29UIzveanJZgECU1RIgOv
         rtib93XjCMvlNIEBueXm1frRQftOtqjKF5gwSstNJXn9s4aiJYDS968IXD5EkgdHYk2u
         kT7RLgUNQ4CQ1Cg+QbLR9/hiuWjThPZfQK9A4kkAXEUtFFl24NJOn7Iz7IAe8VI+NTEh
         MJi0NuYk+0lOjw9Cl+lUAXLN3IqDI9fITtHvbKQ6daFiRPijJOXKjMIXeL/fFg6Gatjn
         Gemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6oiSiIofGHKFHSCOdj0P9rIQdznAwZp58HuyJ67DQ8k=;
        fh=iBVKP8zTY1NKtPKncgS4TJp491UBTZUPg43mg6F6I5Y=;
        b=gOxINN6DKbLWj3TfFzUNth/zcvu339Di9OLwC0TfhUEE1VblWgKKk+VZwKRlWEjI7S
         GjzGKf7oX6FUbrvMTfiej1/Cgkb866yZig0BfRDBnmn6Zl7hNa/EFXDGN4wfSsRSr+KP
         s1JaZn/y61noKyZWHNCAD/+k7IAryeckzpqAjWBXxzYlsv8TqkA2BRc8kXMFtOuBqnpb
         +npeSe/IlGDRLsubx1uBi52tcVwUAtWjbc24ZUWIObPQFyWwUy8meU8DjhR3A+IpMw4f
         Hq5JpF4b8Y83NXOvXIONxw/sXVRA9Iem0VqtcEy68pG7OhnaQha+VWFEwxZ5rVwQ6n4b
         IKrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776608491; x=1777213291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oiSiIofGHKFHSCOdj0P9rIQdznAwZp58HuyJ67DQ8k=;
        b=rg939vXSW5gwxfLHHQHY/UA/ejz2I6GpiLbebw//QerYJ4TnwM2tAGZ2XUbZDX+/N6
         xuqs6drrxE9uqk2aKyi7n21XVJDMu0xmJr8LGJOiwbTNE3CE1ED3dDXpaSk7ZzB9hhWI
         RKhEeoxRuXMNLFNTaerHLujo/WrbIh5qu86TdaSVKPF7GCHwCJmFNF5Rja3VieI4vAET
         gp6WQlUndwvD6QvcKJl/3BuyIzSSDzDWlI+G6jmRT+MmUcHA+oEHF7hxC05a9C1GXFw/
         CFID+HOKeI2lHQve39F8O9ZJ/+cklxLmuEOjJO1/3TDibr3wOvB2hDqGyAaIE5EyGCBX
         qZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776608491; x=1777213291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6oiSiIofGHKFHSCOdj0P9rIQdznAwZp58HuyJ67DQ8k=;
        b=MJurOsFP/dGKtoSb0z7uWGC+RKWT8Cr2yAgsDau8KaaWwxZ51GxJ8lZJWTQXCAYYEa
         2YKEBBZAw8WkyyIeqprTOLaxQMdn9al713UBq2AYrQ+66UMXZRC9bsXG6Xf9XNOn8ccU
         6ohEaDyhrAJlebeYNTnlI2ZjFfuTDiuBZNj/8QtsNs3foljKg85R2OpZfDvj5X5uIOxn
         nm1lwhTsttaNX1KIKwsnMDS59M5GB213ONnpgvBl1iW+vDqOKCj3wHdBfK4yVe0wJ6ti
         o5YJThxobCdKsEfgB8dfOQ1UXM47zrF+Mebw/cDN0/D34+dnhVZToWRnAt9+ouDKcD0j
         dWRw==
X-Gm-Message-State: AOJu0YzN5qooDoDJB4CxCk8TkaJzoPvkLkmo10owxDoioL4tVsRuRR/r
	Hmu7hOmcZl5JPNWH2LcHX4XXJoPM4+7fl3y1cwxeON57/e48GGzVa6YPUyOot7HllTK17sNfbKt
	8EgAOLjBJ8BPG1inEbS+Qi0+5dF5LjnwiQ6CFYUBb
X-Gm-Gg: AeBDieunAn+XhbOdKQf94NX12zD82PP78WHtXv5PBpgoAyftOcNEYavM6sPbQDOmm+n
	5xhu25xAQtwPkomZBhn7M3uxQLOlIZs6rFRtR3UFKSTHsuqL91o3Kdnd2BmXQjztAwsZDwZP7C/
	gjUDlO1f4IEAY+eg/UWlqq5NnmXk20+OBe7KgZ2sYYLv9wTF3TuKNoUkgihPnCDpIXfYHysxg6j
	df+UKKTXwUi82YKC0j69QqX2zSof8qHp7/IAF5TTbHY6/p6a24enbzOQkcrRyvdDtRZDoCcBa1q
	4IXbxfCMdyXqU14vWMneREOHkPGYwhSxb4OqTRmxSOLPygB4W/XNML529u5Tz6U73+Zz6Z7UN9s
	8Wa8ecQ==
X-Received: by 2002:a05:622a:a10:b0:50b:36e5:ba0b with SMTP id
 d75a77b69052e-50e36be3a7fmr151776071cf.18.1776608490395; Sun, 19 Apr 2026
 07:21:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1776563662.git.caoruide123@gmail.com> <efb2c33f544ece7727704608fc577525b415ae26.1776563662.git.caoruide123@gmail.com>
In-Reply-To: <efb2c33f544ece7727704608fc577525b415ae26.1776563662.git.caoruide123@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 19 Apr 2026 07:21:19 -0700
X-Gm-Features: AQROBzDvyInzVXUvYfPj9DGj4kGpOFpdjhhlbxfCojGAE69GoF1BaVqIqRVOfMQ
Message-ID: <CANn89iJnCKQLa5kkJaMwkQHa6Zr-5KvgpzmiLa00JAZLxL+tFA@mail.gmail.com>
Subject: Re: [PATCH net 1/1] ipv4: icmp: validate reply type before using icmp_pointers
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	andreas.a.roeseler@gmail.com, yuantan098@gmail.com, yifanwucs@gmail.com, 
	tomapufckgml@gmail.com, bird@lzu.edu.cn, caoruide123@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279588-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,redhat.com,gmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,lzu.edu.cn:email]
X-Rspamd-Queue-Id: B0253424551
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 19, 2026 at 3:24=E2=80=AFAM Ren Wei <n05ec@lzu.edu.cn> wrote:
>
> From: Ruide Cao <caoruide123@gmail.com>
>
> Extended echo replies use ICMP_EXT_ECHOREPLY as the outbound reply type.
> That value is outside the range covered by icmp_pointers[], which only
> describes the traditional ICMP types up to NR_ICMP_TYPES.
>
> Avoid consulting icmp_pointers[] for reply types outside that range and
> keep the existing behavior for normal ICMP replies unchanged.
>
> Fixes: d329ea5bd884 ("icmp: add response to RFC 8335 PROBE messages")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Ruide Cao <caoruide123@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/ipv4/icmp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 4e2a6c70dcd8..d8036663f035 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -373,7 +373,8 @@ static int icmp_glue_bits(void *from, char *to, int o=
ffset, int len, int odd,
>                                       to, len);
>
>         skb->csum =3D csum_block_add(skb->csum, csum, odd);
> -       if (icmp_pointers[icmp_param->data.icmph.type].error)
> +       if (icmp_param->data.icmph.type <=3D NR_ICMP_TYPES &&
> +           icmp_pointers[icmp_param->data.icmph.type].error)
>                 nf_ct_attach(skb, icmp_param->skb);
>         return 0;

Pedantic mode: Perhaps also use array_index_nospec()

