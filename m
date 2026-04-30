Return-Path: <netdev+bounces-282926-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UB4RIZV682mt4AEAu9opvQ
	(envelope-from <netdev+bounces-282926-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:51:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE6C4A525C
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 17:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52FD4300A8D9
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 15:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77D644CACB;
	Thu, 30 Apr 2026 15:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+Lv33Va"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638AE44BC93
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564090; cv=pass; b=rg6SoyPSj/QyzlYgdMV1JzP03dzZkRqEIAQg6gRAyYBhrcFpSUKb8kQsMhnLR7gA088fhO95EYvwRNo2j8RdTtW9rPkZcX7pCAp+6b+7Qqk6Xj3MNsL2s6OD7iPlgYc1KPzJwsGKVuCxuMQ7fLsDPQ6JIY4KXFiKYZcUVIH6NJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564090; c=relaxed/simple;
	bh=NHff015SBWIIZDAU//3Z+xZwXxY9PSwzlnhITW5PnP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVYLMXJxCjudC93t3Di8ZQ0+lj9b19S8wZUKkafFIw2p/HOEupqEVaat6gz6VEL0TMyMVrUJYSLJALJmV5pws+ZU9BZvKqXhkrprqnKVekk+a6HcgwNK4rmSJYz1JG3IMs2ad++17PxaYvbR0b0ZCJVwilGWSTVtorT9O3gOJUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+Lv33Va; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7982c3b7da9so10774817b3.1
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 08:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777564088; cv=none;
        d=google.com; s=arc-20240605;
        b=MKyYohWqEoopORwqrWKt56h4PhKnU5jD4PlyLEtkWKZ8LMUv02/8IQK68jL1oEhmhU
         cB38PdlC4aiprSBgO5s6bFpOXLxL7DB+EUtkvZSFPwqMYIr3oZEBwIOBrHMDAVM1+xYa
         sbqfh4G8eLQDdiNOgn4AG8hAyzBTNqFcF+/W6v3EUUIjJKt/RNzWMaVI0ziXVj81iGQW
         X5NQRXKbd+5GBXeUlx19mhcWRCtVhl6UQ0Sz7OVQH5Z4HQmTGp6tKqU1AcRCIMo1lYJ+
         crMipaf0G3bXUVvpvJUsUWDSWRTzfypJ4BRPS4A0zt4OJylwNrYIEHwKRTJu0BfNtVO6
         AZFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kmrba/VIZGvmAtnPma5JUyYaORZG2GeWjvJefcuxw6o=;
        fh=VgnLwlum05VtraqkpEeP6IlcNgIDW19FsW3aDxwPStw=;
        b=Kayd2NcFJhB3IFlkqgobHsbVvBu+KgJYi9m7R6pLUR6NffMENY4fK4a1sGHqoHNdxK
         qOjhcMnrbbUMcSFLc7mXOINjmbZB4QUG0+8XdmtDxUTmNbhRJK7WvaRN9D7TgAjyV/8L
         CVHXGQYkWaSSvIRwYdR7gxPsSf7pzTdqsZ2ITLOUvGRdxZEAqmOB3yKP4rd84YLc1LZ1
         Tm1iCOx+sFPva+LTCAEHp0s9dS9OhJxiXlbdKGf871asgUrrn1iF25ZX9abLN2PV7GD8
         Ke2FSXPzy6ACV/FltRB1goCH8Cehr61+5rHnQ4n9zRFOtRNOtA9+tugu6MtJ85oDYcws
         8aqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777564088; x=1778168888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kmrba/VIZGvmAtnPma5JUyYaORZG2GeWjvJefcuxw6o=;
        b=c+Lv33VaItaTVju8kazA/iSdt6kRPgb8QHIj4+XkKnEs+qPkp2jMoWCfIVzoFlPQKU
         FKn05ZdLRugJYJXYjvIA4tYR9LdKtOWbO+/iOxoJmMybS3iWAr6KDOYn0TuOqas/tTKM
         8ABbXCEIjHVoeiwQPke7LPc7+/CjbNWcx4ilmqV2anNBIaMZTU0LFBdpX3LL8PO9h6PE
         TRNpKBcdkwxTqtkJtKGU/R4a9fteTI3gj7OSWA+HpJFhFjm+aeYxB0zpkRVOGNtC1cyv
         dsNlN5DOwFatKlSq3mgLcZfcYGFnCzMPpDeVjgvekNFT0+kRRNnySPzTwTfTe7O5URD6
         +bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564088; x=1778168888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kmrba/VIZGvmAtnPma5JUyYaORZG2GeWjvJefcuxw6o=;
        b=NQ9HavDrtF7zmJFdoqCNk+niku0K5rxZbCm2YDLGgNyu0U7p5xbDhBiKo94YJnKuBf
         WygrA7LhA0p87qnQSVqbXNRst5NoNp6gfThm8W7KmAlgtIEZpjxXVVhvKKP8kfz2DvsE
         /I9iDwg+UEA6T3aQwJfw3CLdMIb920uZnofYRgluR+/AdT2lfSHwZekrVu0D/CO01kmV
         NCgyiY+QhmxJg0Ji7+8Z+AJtt3sx/MRQBOz4SSDYJOD/z7LaBsS++cVmdqDHrZo0EWQA
         j2yw2dTzNRmaUlwX3fN62wKfs7mjf/tI3OClpl8dKCbxdzgoqyxlZfiH5JADo+N5X4am
         xTCQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cwfmeb8OgF8wLz8HSFRSbGYm3B5zAbjxhudlYQDT+Np8m8C/Blbl8Z/V5RCFCocUXehEHAhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzim8aTHO8sRREDAlTAuNHTIUvbCzTAPWrzOWFhLF6O/72FodZn
	At8VYQZMikhMiOCDMOke00qRcFVnOU/H1DDtuRqDQI6eFhkfCPCfMrhiqs9dYT1KwC1h65gIYnj
	wJL+Q1TN3BEBnArKcU5a4z8dRdrnS8W4=
X-Gm-Gg: AeBDievgZu22sPa02oDRR+GC085LseAhdfr0mtMXze5qc6xqXfXieLiu48E+BWns9o9
	8XW7pprXVwful+vTyTlh/vBQoSgn+JKTbNZX0lnIYy9UxAVUO4maF3quFevYm08mas1sttT8LdT
	VnMqWoEywRRE5ZIMMJiSGVyZiJP8n4kghe6bg8gaT/wlvZbKmKq3K4TXBC/i4YU92VNOEX1ETwG
	ukFLTMeMbKa0PE2EMtdJKCoS9djMM7+0bda6lIoxhllL7ewkMkLjY3gtpXeR44vEvcw7psTvNbD
	fVKXi2hXwO8ooq1onbKnTuZHfJiLpCs44xzsttZSuwVIQCI=
X-Received: by 2002:a05:690c:8:b0:79a:60f6:c5ed with SMTP id
 00721157ae682-7bd52809836mr36661477b3.6.1777564088379; Thu, 30 Apr 2026
 08:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326081127.61229-1-dqfext@gmail.com> <9d7f1bbc-155d-4c18-bcf7-732ebe4cbf67@redhat.com>
In-Reply-To: <9d7f1bbc-155d-4c18-bcf7-732ebe4cbf67@redhat.com>
From: Qingfang Deng <dqfext@gmail.com>
Date: Thu, 30 Apr 2026 23:47:57 +0800
X-Gm-Features: AVHnY4KZEw6sEvZhRyNLFyexDtbd8Y82AgKjLjZiaVqz8Hfs_giwU2yWejKheeg
Message-ID: <CALW65jYB1jWS5LnSxRCrEeCpPfhA8saqbYYfU-LkPh_25gWfsw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 1/2] net: pppoe: implement GRO/GSO support
To: Paolo Abeni <pabeni@redhat.com>, Felix Fietkau <nbd@nbd.name>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ppp@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: DDE6C4A525C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282926-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 5:34=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> AFAICS, when the computed len is >=3D 64K, and the above min() will
> truncate it, later pppoe_rcv() will drop the packet.

pppoe_rcv() does _not_ drop such packets.
The drop condition is "skb->len < ntohs(ph->length)", not the other way aro=
und.

> > +     skb =3D segs;
> > +     do {
> > +             phdr =3D (struct pppoe_hdr *)(skb_mac_header(skb) + nhoff=
);
> > +             len =3D skb->len - (nhoff + sizeof(*phdr));
> > +             phdr->length =3D cpu_to_be16(len);
> > +             skb->network_header =3D (u8 *)phdr - skb->head;
>
> I understand is quite late for the following question, but...
> The network headers points to the pppoe hdr. Should it point to the
> actual IP hdr?
>
> Why not? A comment in the code or in the commit message would be
> appreciated.

I'm not sure about the GSO stuff. This code is carried over from
Felix's v3 patch unmodified and I haven't noticed any issues. Maybe he
has the answer.

FYI, Pablo Neira Ayuso is adding the "inline PPPoE GSO" to Netfilter
flowtable: https://lore.kernel.org/netfilter-devel/20260430055836.223494-2-=
pablo@netfilter.org/
to work around missing GSO support in PPPoE driver, prior to this
patch.

