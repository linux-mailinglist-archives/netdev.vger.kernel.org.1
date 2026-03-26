Return-Path: <netdev+bounces-272216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JazAhGLxWlc+wQAu9opvQ
	(envelope-from <netdev+bounces-272216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:37:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2961D33B01B
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 758973015FF7
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 19:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111CD3A3800;
	Thu, 26 Mar 2026 19:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="njfdCQGQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B03E3A5E94
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 19:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553801; cv=pass; b=k00+DeJIoUukLV5RUIHgMpS/FuNz5eOZziSV1u5UJhbmc7Htv7YeLSnjIMo9vMoLkz1H26yrF5sduMspdHtc734PYe1M7GLHz5JGdSRY7FSDz0Ly/tAySDgMa2dMLUB8utWpRG7JpLzQziROlTM0mTZ9XUzpL0rgaZtE/X4vX7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553801; c=relaxed/simple;
	bh=DKrSxjREVfmkfXwj6zBr+w0YWx0d1EHSPvcDV1OyFs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sc5d249fHWyQotKVgAde3DSvVuyCDDPr78cyLw/9im4q6yBkAtono/oHvFU5tKXzshoDWoNaCZb+NQzXlphLUw1rRfvlbn8EImxjjAS5y5nmvfeuKGTyAKC31/7m0GGZIvviCwUAomaZDQXKLhnpid0hli5y0usaDAZZ+44+klo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=njfdCQGQ; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506a7bbe9d0so12170431cf.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 12:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774553797; cv=none;
        d=google.com; s=arc-20240605;
        b=ChSbmp4ZqifBaXBNp2tySN+hMlMnPuksVHZbGeqJJVxvh1mvZRPVqLJ0UCjZvzE4KU
         UoyhXU2LGO5YOcmi0ik1nADpHwNGuymAjCryqllQjAhqLpsg5A6R2iraNIHh1mMq5EQ/
         EL4KHvjwj9gczQitd+yjWeeaAH3p8RRaZ21MjPw/60Va8KPN9ZdQHjwttdMWOyx0N+Bb
         eFYmVL74ILWv779k+GHySE9EUI5WVZF/z3J0V1rasQGlU9pmCOyL+8Asa7LQkCMeoYTx
         /gPk1mLz7RVl/XXcy/PiW4bDM2/62Ixo4GU5JZ4Hp3WDfAlPNUIhFqTsdT8wzXX6BEzv
         NrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DKrSxjREVfmkfXwj6zBr+w0YWx0d1EHSPvcDV1OyFs4=;
        fh=GBGzTo5ayaSoUatiytOSpbmWzfT4k9xb2FSfiUz9n4E=;
        b=IbyjTJZpWpzLdXIDShEU//RwUgKnIoC0jQsfFcGatouEr+/13Pk/AOh3yaDzbhQRT+
         PtChY3mHatX0jVMOdlmivuSVsOZpKNZcAVWRfGMZiw6pL5iBExOCC5u2enfycs7Xjfet
         znZjhDx2bWDpOJQiuLK+qy1R+b58h/C7RFHSwSqlQ38L/zvdlJe/06Z5btD9yifwFE7G
         SpyZCBC2WUJ0SL9LYVHImtRvM0Ortgg/wLTZd9LKSatRnHED3thZuZgRKqg6zisNl964
         X4M1F9tDhedADVdg+9zgDg0FDJ+jwhXA/SzH8PyHHqkd48qL1xeEJqNdxYqamsraxYvX
         ihbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774553797; x=1775158597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKrSxjREVfmkfXwj6zBr+w0YWx0d1EHSPvcDV1OyFs4=;
        b=njfdCQGQrBtua/RYZtLhpywo0IxAr5B9Gw5jayHzX+2KVtViPhibdNL6lF6jDg6vPd
         aLEmadjX92VlsTOdTpNU850CZt4yvVc2VNZQAjsCL7du01BtmpqPHvHOFF2iy8IgAk9j
         DYueqTDjuStsWNfIIpImVyYbmNgZ9tb2yN8FoBppwUUf0x6ZuTBpHzAC8SxAdOxtP6fv
         ByJkv4KkG4JhCffLkuhnSyLMWodK9NcX2brPNUZSk4MwQc7uEnv1PguuyM/Xl59nNIuz
         xawZqBzYNQYajtnanz16rQIY+wlomQUw6dgJm7xNFW28a7pDwfOGQgGnn+jLVjslzKe2
         E7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774553797; x=1775158597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKrSxjREVfmkfXwj6zBr+w0YWx0d1EHSPvcDV1OyFs4=;
        b=JYC77FYC4jqSrgvXPNaGjJcRfuijTPZ3qXKL+HdtmmE6bcNOXbA4dbq/C3Th5ONZTj
         IKW1GGQlksjGfPEj1ZtmX9b1Plz2Y+n1H5rteE/3zTzHd9ua6FoTLaqDFlFdDJVP24XE
         4+D4nKWnDxQnWWyjGbF/SPYtJctdJgBwL16PGhnvcRcnUiWDJf+GF7lbo3S8EuYXCMs+
         4djwoxXHe21s9CjS3LHR+naHEVM3Z/9jkJQCn8VfjRxG/iTXt0dL/R8bWWnVTWlkuD33
         wU+VRK4FxP5I5men1nSadR0aKBJ0uSxu+ilasFjNpAifOwcGpfZCwc1/NjEw9yLJW4u6
         +ZXg==
X-Forwarded-Encrypted: i=1; AJvYcCWdkXQ8mGXQpHKAEG9+8v/hKgqupyrTBjqJRIPJsP4MNmjLURi5Ijgme/UJ+bkoj18myikfeFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo9ZTP4rtzUF8xb4P2Ef9OUvpw0fGNUzIuxT1n6SRPM1pahEj4
	Ot8OnBvZ/2RhAjRB5MfKBGVrSKY33bDXCC+KFMKvMnI7rZawU/EjKsJ3O8b5rG747Ny/AO9aMux
	CBEOwZQzJrMWhGLuSUjVxiDcfkxw4d/FsC6avu6Bx
X-Gm-Gg: ATEYQzwWFKvK+fmHZjXCN4uAZTgycPzeZDejOGjW+JJIZ34M3RXa2aEzX30SPO7vku9
	Mt0IaULPcADx0GnjmaF4e+/wcFeVvDHConL6DHjJUg/w6ljSLqJDK9FKlZJ7UUB56T8U0OxYLtF
	d7oACCBSuHmJeI44kz28wP8Md0ymtQOLiBhthN5U+eiMGCILGQnhHs8mrG0eucJr3AljtTH9TQm
	4iUaU8VFy00NukRZ+svNyUA4l5OmY78goMGeNOmYfqlI5iiVYwqMPJs0NENMlPkX2wO/uip10xg
	tLPzW4apwAel9zmNzXLRWajIoIx1W+10JlAv
X-Received: by 2002:a05:622a:408e:b0:509:182e:e436 with SMTP id
 d75a77b69052e-50b80ed395dmr129968331cf.66.1774553796419; Thu, 26 Mar 2026
 12:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326155138.2429480-1-edumazet@google.com> <20260326192819.GA1103736@shredder>
In-Reply-To: <20260326192819.GA1103736@shredder>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 26 Mar 2026 12:36:25 -0700
X-Gm-Features: AQROBzCSuDHhjdkqZPdQr3KFRvFncXH8UdzhZYVS43Ar9snh22DXLLu_9OplC94
Message-ID: <CANn89i+2hDGuNwian1HJTgAwFdmO2YtE6qp-acQgUmKzm2WK9w@mail.gmail.com>
Subject: Re: [PATCH v2 net] ip6_tunnel: clear skb2->cb[] in ip4ip6_err()
To: Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Oskar Kjos <oskar.kjos@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,hotmail.com];
	TAGGED_FROM(0.00)[bounces-272216-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 2961D33B01B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 12:28=E2=80=AFPM Ido Schimmel <idosch@nvidia.com> w=
rote:
>
> On Thu, Mar 26, 2026 at 03:51:38PM +0000, Eric Dumazet wrote:
> > Oskar Kjos reported the following problem.
> >
> > ip4ip6_err() calls icmp_send() on a cloned skb whose cb[] was written
> > by the IPv6 receive path as struct inet6_skb_parm. icmp_send() passes
> > IPCB(skb2) to __ip_options_echo(), which interprets that cb[] region
> > as struct inet_skb_parm (IPv4). The layouts differ: inet6_skb_parm.nhof=
f
> > at offset 14 overlaps inet_skb_parm.opt.rr, producing a non-zero rr
> > value. __ip_options_echo() then reads optlen from attacker-controlled
> > packet data at sptr[rr+1] and copies that many bytes into dopt->__data,
> > a fixed 40-byte stack buffer (IP_OPTIONS_DATA_FIXED_SIZE).
> >
> > To fix this we clear skb2->cb[], as suggested by Oskar Kjos.
> >
> > Also add minimal IPv4 header validation (version =3D=3D 4, ihl >=3D 5).
> >
> > Fixes: c4d3efafcc93 ("[IPV6] IP6TUNNEL: Add support to IPv4 over IPv6 t=
unnel.")
> > Reported-by: Oskar Kjos <oskar.kjos@hotmail.com>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Ido Schimmel <idosch@nvidia.com>
>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
>
> FWIW, I agree with the AI review [1] that we have a similar problem in
> ip6_err_gen_icmpv6_unreach(): icmp6_send() being called with an IPv4
> control block.
>

Indeed, thanks for noticing.

I can take care of this problem in a separate patch.

> [1] https://sashiko.dev/#/patchset/20260326155138.2429480-1-edumazet%40go=
ogle.com

