Return-Path: <netdev+bounces-254887-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DNEK9Wme2lWHgIAu9opvQ
	(envelope-from <netdev+bounces-254887-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:28:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BB0EB393C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E16630157F6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 18:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D802F6188;
	Thu, 29 Jan 2026 18:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQkcZhBk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FB22F6168
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 18:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711315; cv=pass; b=JA0PbvNGQUeLHWobukLV9C1frHfU0gghPNQByVvIOCgJqb9eoJS6GfFmR6iXS4YIzFRQkAAP0J/vhF7WtldHtDe48JIpkxM2ZM5drM7G6FY2G0mXRZZy1hdmzgllha3t9YOnq3URoaET0XHOIKgcttCLbckU0rPiVsJhzZJQdks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711315; c=relaxed/simple;
	bh=s6dBwpRUC8kmWPUOeRbOQj49eHBSQ5EbYLn5ZF8Vrx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkUX9vZCV5I/KyesdEVFJ4E6OpDqoDnHYq069el1aLD4Zb10etiL8iwXkRZ2qfq/Zr9Mj7VuE9gW0ZL4G/FMk4B08BM702/l5022m52J6lydbqr+CViAM5qwj8Jb9OB+gA4n/InUo3sr00mYOHkXcFlTf7r51z1eVTjMnPFb3LU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQkcZhBk; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34c27d14559so725254a91.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 10:28:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769711313; cv=none;
        d=google.com; s=arc-20240605;
        b=H3MH6uN6+gzmsDBN8+XIktmANH3zLkgXSGqtDrBUlGLYOLhbjNWje/craH3KLYKXMq
         /a8wVU7o+gyNY3yo+72EAkrbNYCTW7iYv+snAOIRTtVFiKh/XR0tONZgyol4a/1n5mzc
         L6g//QHRv1HIj1RvhK+5TOPCNzm2DGnIXEvfJ09VkMJB7mdmUPxcADTTX60is58b2EiQ
         ehowW9j9S8CNTblpTy5R7JGjfZqc6XU2CWz4VKUhvHXCU2J4zsuWdH3kUdp460bpYyJw
         NUzuAMqO1HP8uQDTzkZcVp7bfd5cjqxgcTSOQB0B7TXw2ypu1zzTkptdc2iCnHnB+5Gv
         8nTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mo/ng+fMSnPglDzDDUYatnZfwWM1+7CUkEAzUwXHl1I=;
        fh=NL42ll6Sv19svTu8aUmazgyBOzfdGp23YxKeD2oh5Og=;
        b=dR2wtrRBHyo2+HXBq/6bmZhBJoKSiLSljx190WNwbqw4SsJesHzi4o21nVUWoouy6p
         oNTXnUpdFP8Ephul0rGk6V6/wFcfj3ziJn2fKJn5l5Zr7kebx0gSU62nJbHbXoZVUb1q
         Q4F34xbwzE4gKSkHv5IY+T7BDDxuys9r/3Dy2ECWGMEN3fQZ2oQInT52sukkjKUtQUqH
         rKyWQhNn0OOw9QKHuA1BZ+TX1wyYaUc2Tdj/BrhR4Ly/XMCHw+j5vIEGXkpeEETPI0Bt
         meNgZvsCi8IhlN48YXu9Po2LKYe5qSs6NwsflHzzjHA4u9HONzDfSb1GWmv8s7YUDBmt
         D1Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769711313; x=1770316113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo/ng+fMSnPglDzDDUYatnZfwWM1+7CUkEAzUwXHl1I=;
        b=SQkcZhBkjOZk1h/WTTKWsk/X/CyQp/psg2Ue6Bnlukerd53DQ1ah4sbnccGm0NjE1n
         h4UET6M57Hawz90EGfte+Nhy1mB/QS10KUWfJVOFn9YQ2y8R5apLAk0MJ92OdCoXEHqN
         RJ0QYK4HI9dBH/ECPqMdOscxIvl0m5IYqDgefC0UZC4g5zht7NpPRDYhL7Iii/WUmTLt
         7y6MWNIu2ZscZTWs3tn9dIn3L8kG3H9oMWupTuc6Gx+7+PNOt2KNYjjcTB7zMBqX8UxX
         +Uu0iADv36JM+g2vQ8WdDN4i79e1erCsFkPuuEMDZ8tXQl0usdK6vOPjb1DHDHIYlgyB
         NAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769711313; x=1770316113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mo/ng+fMSnPglDzDDUYatnZfwWM1+7CUkEAzUwXHl1I=;
        b=UotQwlufJm0VYps9WZNr7aZj7SYO0+qDKn2SaRfME1+Ef/8YaTlgki1jfhPQpmwO/i
         yJIzmAUubJG1GtqwhupGile5GrPOqjctegflsJf94Qc2xXJsIrzRJimuRDE6h00etu8C
         E6vFGQv8X6WiNbsXPG4UJ6f4SRdh2zp2W1gy1C5q0gvMt8r4TcmR6go7LU9GTEt0JA8f
         CPEvAkxqIrWriiFu9jmh5g7TOOTXhCLS2i56X7qQR2qslW2G9yQWqC52A5XBd5eyDki2
         m+wFF43t8kTxZIL+2WgXYmHvrhn0RpaJJEZdGZ+VuAj40JvNKS3pqv94+7kNo/e1sC6v
         TwNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHC+cg2uzNW4pG8ijjgqkuh+xjvRH28ztakuJuCmk5z03duOdV2uKxXYELqH//Axu8GsoeX7A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFbgLDQNttQwCeTcfaW7V7P03vT+UERTwrqYOHLOBZ1kKflB7
	vbzqTZ7Va6JiuGybiGgvK0CzFWftdAI/o+bvhVwQSSeAiwRw37DyDsa4rq3Z1tsdycqqaP3xaMj
	r2nwL777Ze/OoeD5gROf1yKcQM7akbDE=
X-Gm-Gg: AZuq6aLbUzw1cjkgVTYWHGjq6N9SAuieN27XYEYj0AdPPt/8wT37fZCAB6ahVvuEkO3
	X+JaoCBZsH4orkAPZfaWPzif1uXRhZqEADmD1m3k0H1my/P9ZwO7YgsCkhBH7kCN3e7+VePJJr/
	f8HAt8k6LmTfzDpX0dn2s9HpMfSwGvz8mLIrNTuFlk7JaecJ60Uh6tg1tSEq87YS9BtpiSP8YTc
	ZtkvhK7e5UJhhfFxd07B2oAydvE85XvkHYVy9HHgVlwuWTkjmlPrcwTRuOfqoro8m2QMqetyRN5
	z79wqIyNizdn4jZ1/5oQ341dFs5ZD7cwHA7RayMXi7xG3luTpjYatiMdeQ==
X-Received: by 2002:a17:90b:3d86:b0:34e:630c:616c with SMTP id
 98e67ed59e1d1-3543b3d9177mr265037a91.31.1769711313198; Thu, 29 Jan 2026
 10:28:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769464405.git.marcdevel@gmail.com> <713d6f1ca57b402be420ade1331acee4898675c4.1769464405.git.marcdevel@gmail.com>
 <20260128202739.79af1bb8@kernel.org>
In-Reply-To: <20260128202739.79af1bb8@kernel.org>
From: Marc Sune <marcdevel@gmail.com>
Date: Thu, 29 Jan 2026 19:28:22 +0100
X-Gm-Features: AZwV_QiZGsndQ698VlBvHu1YBGXvRJxxvZhVSffNSbWbn1WY7TtqyB2ct__Srio
Message-ID: <CA+3n-TprC7Fs0HiBndR+OpYmy2vq=raiuSE=_R49LVxjax8Aug@mail.gmail.com>
Subject: Re: [PATCH net v2 2/4] selftests/net: add no ARP b/mcast,null poison test
To: Jakub Kicinski <kuba@kernel.org>
Cc: willemdebruijn.kernel@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org, 
	dborkman@kernel.org, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254887-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org,kernel.org,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcdevel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bareudp.sh:url,amt.sh:url,altnames.sh:url,arp_ndisc_evict_nocarrier.sh:url]
X-Rspamd-Queue-Id: 2BB0EB393C
X-Rspamd-Action: no action

Missatge de Jakub Kicinski <kuba@kernel.org> del dia dj., 29 de gen.
2026 a les 5:27:
>
> On Tue, 27 Jan 2026 00:53:03 +0100 Marc Su=C3=B1=C3=A9 wrote:
> > Add a selftest to test that ARP bcast/mcast/null poisioning checks
> > are never bypassed.
>
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selft=
ests/net/Makefile
> > index 45c4ea381bc3..a765f1800752 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -9,6 +9,7 @@ CFLAGS +=3D -I../
> >  TEST_PROGS :=3D \
> >       altnames.sh \
> >       amt.sh \
> > +     arp_no_invalid_sha_poision.sh \
>
> alphabetical sort pls
>
> >       arp_ndisc_evict_nocarrier.sh \
> >       arp_ndisc_untracked_subnets.sh \
> >       bareudp.sh \
>
> > +readonly V4_ADDR0=3D"10.0.10.1"
> > +readonly V4_ADDR1=3D"10.0.10.2"
> > +readonly BCAST_MAC=3D"ff:ff:ff:ff:ff:ff"
> > +readonly MCAST_MAC=3D"01:00:5e:00:00:00"
> > +readonly NULL_MAC=3D"00:00:00:00:00:00"
> > +readonly VALID_MAC=3D"02:01:02:03:04:05"
> > +readonly ARP_REQ=3D1
> > +readonly ARP_REPLY=3D2
> > +nsid=3D100
>
> unused? (please run shellcheck)

Errors fixed in v3.

>
> > +ret=3D0
> > +veth0_ifindex=3D0
> > +veth1_mac=3D
>
> > diff --git a/tools/testing/selftests/net/arp_send.c b/tools/testing/sel=
ftests/net/arp_send.c
> > new file mode 100644
>
> Could you check if mausezahn from netsniff-ng can send these
> packets already? We already depend on mausezahn for other tests.
>
> Similar comments on patch 4, I'm not gonna repeat.

I can do that for ARP, but not for NDP apparently. Only basic ICMPv6
echo req/reply is supported. For NDP (ICMPv6), it needs to be
specified using -P (hex). Kind of ugly...

In RFC v1 I proposed to use a scapy
(https://lore.kernel.org/netdev/3cfd28edb2c2b055e74b975623a3d38ade0237f1.17=
66349632.git.marcdevel@gmail.com/),
which is substantially smaller than arp_send/ndisc_send.c. I dropped
it based on the v1 review I got. I see scapy is used in bpf/ and
tc-testing/ self-tests.

What's your preference?

a) use mausezahn only for ARP, use ndisc_send.c for NDP
b) use only .c progs for consistency
c) recover the scapy patch and squash it in patches 2/4

Thanks

