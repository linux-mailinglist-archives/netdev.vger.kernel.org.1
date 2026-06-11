Return-Path: <netdev+bounces-298093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zpuJE+6ZKmprtQMAu9opvQ
	(envelope-from <netdev+bounces-298093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:20:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6CF671417
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 13:20:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=Zt7sFntY;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298093-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298093-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 300533024B05
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 11:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83983DEFE2;
	Thu, 11 Jun 2026 11:17:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F53BADA3
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 11:17:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176676; cv=pass; b=sIBXYhvezsavdJkpYNgH9MqWR4vKK8TRlAThvr5i+PNGRawvZrxoM/pZHGh40xPgzkbZ1CyYjy6wzaTd9YwgxxzfdsliBN8cac8ujZiGSvfj3COQC4HYj0pKCYZP1t7mscyamQWfpEEzU86n0K/66vkKICdX4Ce5f5vWKMEyf18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176676; c=relaxed/simple;
	bh=VtT5vojwdqEg/wq6YqUy0m7T8hxaq7HR3Fqo7QJUUMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXjL55ABBl6RfwCnp6F07X2K0rzNYKvjcdVwp7fwjuyHb0veZzvKj27LlQEbbWCHRMPxpYlOTPt4zLo7v/Jsegjk22MuM09okaqfThzwQz8eOxaWVO/pQ5bjtmoVmRRU6HjSF/bG++NAzct0tVcQYNxGMtkVckH7whTKIRt3qm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zt7sFntY; arc=pass smtp.client-ip=209.85.160.174
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-517de710886so16688141cf.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 04:17:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781176674; cv=none;
        d=google.com; s=arc-20240605;
        b=SMe4zi/Ot9FPhhVcEQw1eO/aQ5il+NjzZgHICaKU3yxrUmszjiDb7yRr2heEBuhK9+
         8XBcCjXhM/I7ZIIqtuC5f9vLLXocHle+wM0Nnz5KVC/adQk/yj5KxVNhAaWOUDJo1/Yz
         5jqqyN7tOMOBAyz23A2s96KAszStW07bv/iy79r6SGRDEQG5sPIulb+5vHXoarvC+2+i
         ftxMooPCyfv/6I+C74Yp+R2UM5YV1qyVN/5+H0G0F0at1iB/X6sTq44tFr4rlGrN4X4g
         JJi9xOhjmnhP+WUyLqv8+MH19qvVLd6LYK5aMbKmslwhExpdbYtJXLxMamtUalHy7HdR
         xkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NEo9V89taV4y8wonAHl6Wh9ZQsQYYBE3lNGgi3NzBWI=;
        fh=kZFoqRWv7P+ahEdEfONt/X2zvdNd1HVuVxFQ8V7wqwk=;
        b=ay1ZuNRGzQ1/Io8LX/I5o8YEqDB0dxNwu1O4f9nXEiYFZOzwFWPlKcU1u9ISm6Vw4D
         WH65G/B3i5sp8w8Qa+1SEw4C+9ouM1JYMGP8ul0DH+8qi5AgLYtaozbWDjV8qyvr+clx
         FEPAMlJODj8PKaf2rR0AcypcTu7N96VWO7Yiw2foLpibSyZriAU1Kcv9Ex/BbSKn0hpQ
         oo75Kga7CX5Ovc0/eULmT8z2GJPpooqWXxuCPcCpbjaIB/WjVH6xJNMmK+L4JxeLCj1F
         6CFuNnTp+KlwdZx5jQQafH+j075Llg03W+QrfRD+HbfEX99KqyyVkdo1oQJ3rtBrwIVE
         kRMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781176674; x=1781781474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEo9V89taV4y8wonAHl6Wh9ZQsQYYBE3lNGgi3NzBWI=;
        b=Zt7sFntYt55sEEh+srZaozHRZ/hCAMcvBA1nz4vCzyLDSQlBKTvvbqy/PO4lTupM0B
         Ddi+cGknrS4RAx1+NGsbQb+mnG51xUEu4ag+nwqHDny/3YGWnN4Y+zEiiQTmarUmHoDb
         vPHPpMzuyv4iDrnF1ZVxeZJhy118UsjORH0BgwmWrDKK6Fpxlfg3Vfd77a0UHut1r/x0
         o2GaBEOtckoG659kmmNtqP6OJdv2H7JNJCo+aJPhhE3Md4Ab2046wjGPy9cgocu2MK5D
         CsfCQQ5DDVZa6HDK0YiwDDsGum7FbxPTXa8DcUSY/O8QRh1DMwUZ0juFL1rVxiKtZHfO
         QM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781176674; x=1781781474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NEo9V89taV4y8wonAHl6Wh9ZQsQYYBE3lNGgi3NzBWI=;
        b=PV4FrcQTkYuXFFSMXHbzlMpTdgBRMpen+f5q5r8p3jvjkKAartrUqtxE6qQvbyklOx
         dI0YoM7KDu7o0IjkOLRAW/fxAMqV9s+C26HXYFuKr8crXRT//3+Jq4MwnAj5eGEWc8D+
         NEsSdlhya7IOxBy66JuTf5t/6HeDoWI9Wo8XX6Hix1L1J1kxyWxanxFz7y20FO9bMLtt
         vGChQ5hE9N6zWwUYWzUC7DLs5Sdi2ntxqYemZuyurfzqUlkVrAmM6qwHHO2EXMFcKJDL
         AqlSotRcTiIAVhRgIPc6O+iB3Qfa24j6OngyqaYUNKl7RKOyiN5og4s/xbat0PUkFG9n
         Z66Q==
X-Forwarded-Encrypted: i=1; AFNElJ9gQUSbPJ9tFzHEGPWbqshg5KWPrtjsctuTNZsa22NoGH0TIF4QFM0ccZxmGdyINCHjb1UzEWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YweD/A37lF4ic/RF0OHgDQm8VqKjypvz6XC6WhCkSMOWL3ka1p8
	sWh6By+5A6GR7kmj0Qy20DdqxJaZNfPRWTf0EVa/e8BcMCRn73rfpvI/fmsBfbJDhpcroudQ5WS
	sx/lIuAW+tN+2RgcAu74nUli4vWP/wbB4rH09P3Rg
X-Gm-Gg: Acq92OGglsuIC+aYSRs/5+mSpCDyrP9TVDhZkhWBJPunslPmi4VSlOg4ohUzCxowMdU
	8rRnFIJEqzs4OensJcCcbqXPiyfWwZtocENni13Y8Aze3ePTtWo3TheghN06sU3Xwcnud9uvR3M
	WWIbSqvU7DE7Pn7pWsee1QybNbwta5dFnZOSFPv6Z9rdBfP8i7IoYGFSyTccZeT9bhksFSA+g0k
	bUBuS+lSulsiU7eF4M673xW0QZdHM47S8kvPymjMrqAeAaur+keIPuefTzuDwf2FH+CZVvbyNHQ
	PQiXZGqjQo+sKUW72qQtCUUO2VSSShiuXHPrRVBel7Hkvx0maM8MiYzsvFY/rSW6l68oXnRvkoL
	A+UfBGtSjDFvq3xRTpj758DDAHYZE
X-Received: by 2002:a05:622a:5a05:b0:517:21ad:faa8 with SMTP id
 d75a77b69052e-517ee28d793mr34717401cf.41.1781176673884; Thu, 11 Jun 2026
 04:17:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609091337.2672441-1-edumazet@google.com> <27897949-2991-4963-96d4-6d011183cce9@redhat.com>
In-Reply-To: <27897949-2991-4963-96d4-6d011183cce9@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 11 Jun 2026 04:17:40 -0700
X-Gm-Features: AVVi8CfLD3b46BBIVpWWjT51F9vvHVPvFlMwF3DbNH528EDB2JNc6uxq2hRI38I
Message-ID: <CANn89iK=ETX=M_Xdik1Ni37DtXxdNZag-ESEVspx15H_xHyxng@mail.gmail.com>
Subject: Re: [PATCH net] ip6_tunnel: do not use dst6_mtu() in ip4ip6_err() and ip6erspan_tunnel_xmit()
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298093-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,nvidia.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D6CF671417

On Thu, Jun 11, 2026 at 2:53=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 6/9/26 11:13 AM, Eric Dumazet wrote:
> > This is a minor performance / conceptual fix.
> >
> > 1) ip6erspan_tunnel_xmit()
> >
> >   ERSPAN tunnel can mirror both IPv4 and IPv6 traffic, skb
> >   (the packet being mirrored) can be an IPv4 packet,
> >   and thus dst can be an IPv4 destination entry
> >
> >   Use dst_mtu() which contains generic logic for both families.
> >
> > 2) ip4ip6_err()
> >
> >   skb2 has been prepared as an IPv4 packet, and its destination
> >   is an IPv4 route.
> >
> >   dst6_mtu() is optimized for IPv6 destinations and uses INDIRECT_CALL_=
1
> >   to call ip6_mtu() directly if the ops match.
> >
> >   We should use dst4_mtu() instead.
> >
> > Fixes: b40f0130a23b ("ipv6: use dst6_mtu() instead of dst_mtu()")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Any strong opinon vs redirecting this one to the net-next tree? We are
> trying (with limited success :( to keep the amount of changes in net
> under control, and this looks like a minor performance optimization to me=
.
>
> If there is agreement, I can apply the patch there stripping the fixes
> tag without a repost.

Absolutely fine.

Paolo, feel free to use your own judgement on these minor things, you
do not have to ask for my permission.

Thanks.

