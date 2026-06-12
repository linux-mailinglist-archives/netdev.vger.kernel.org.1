Return-Path: <netdev+bounces-298480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id x1R0NwewK2pzBwQAu9opvQ
	(envelope-from <netdev+bounces-298480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:06:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1476771AC
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 09:06:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=lOzIQi1W;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298480-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298480-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1118333CBB82
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA133D891D;
	Fri, 12 Jun 2026 07:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EB3D9665
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 07:00:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247626; cv=pass; b=WP9Aq0m43fkfI9N7UE1Go306uGAzjRwc2w/2ZfB9ZCeoEWGiU8hm2aNRBnD7MInT9qhZyZ+ck/VSR1kpo44yF38p4hyQhvRGlunb3uH5EPfopOHnaDXaTxAVfmRntg6t2H99d8quMa3x3Q3nq8YKL2hVEbUD0w1URQH3P4IU44I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247626; c=relaxed/simple;
	bh=fLn/U8yJbyJy4AmM/RvWgkblgbys8OLsbj/lFvTx65E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqXFS/cS8z0aKyDOMXJJeB5+YB/+ysnReZVv1MsYW/xEwHEJqnZfx4C3ioxrEiiE3pYKjUUfzg7BIEyP7iKUERJdLACwYYCLXqWQTHu0ur9gCldovfr4wCpQroc3Qytgv4+9u0jrVPMSXB3o+kLrlMfh1G3xS5H0nDPyE30w4MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lOzIQi1W; arc=pass smtp.client-ip=74.125.82.45
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-137335bc3caso833234c88.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 00:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247615; cv=none;
        d=google.com; s=arc-20240605;
        b=OaE+NKosw245o/iRcjxcCmisvY51HtsO96jv4y9hgU64sFeefl4zE4I9jPsvyUyS/D
         BvKvM2O8TRwE8YmBVc8Gg+9TKFcEJRGG3vPHd5U2eby0bp1Qc+AdS3y9QlP/FqdGnXbG
         6jhavB1hU942I9w/oPYxaZ+xEwfCeFD30VVt1sODbqL998KL3mBhVgIdF7miNrkfmOUR
         f8IcBkTx91vzvkkeVe4DYDjRAClnxlLKeX/OGuCegJoHmuZAkSo11OsOAH6VxBysUbqT
         O2usBk5W2cVdxCL3YXPXjyoYwTRLCVXoo0YgZvc9Q/Lt6MVMI9dniBqP5zVlToOXDfQf
         vGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fLn/U8yJbyJy4AmM/RvWgkblgbys8OLsbj/lFvTx65E=;
        fh=tU+ZFqXaTIn2FutjUPZjjWQ7c30h3wl8tK+jomqTqUE=;
        b=luKxkzMk7qfWeSBNeotkqMevodh1vYx0CzMOtLF+w6+5DzELtGwzPMjnFc9QmwdMjH
         Vbw2JtyRXtwycmK/Ky+KxO1OEQzlgDdKe40ESp3HWV6mDzydH17A2CqN4vRcrZwDNWWC
         wRpOP71BbvH1xdRO0PaXp/aDYeIxICXF2DGZbsTgxbkV88JEt8WUQyuH9P6j65qkMDST
         KHSgsCTYBXCCjRFO53LKqvmL7nP+MTJK7xGsSpV2GpbX9PgHPrl6TIIdYwGMym4DBOkP
         iGQ6RbVQNvIdYjfcHTBsUb7tnKIHJwd7WML7eCydPPHMuQqh5VtbhFgZuUcKkSO8NtTY
         LR3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781247615; x=1781852415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fLn/U8yJbyJy4AmM/RvWgkblgbys8OLsbj/lFvTx65E=;
        b=lOzIQi1W6XR53rdfyN2PHBuVoubKkg3loCfLnZ/xgtNFchUymchrMMaKKy8c4Y4X0t
         ZGUUworyiYJRAzKYPJS/W5ONRQFfd1IU9EnDj+Rv3tkiMBXbeqR8kVefJsayYtpi9gRk
         SRY2wB+kSeAVgNfA2ezG7kpbhIxDlk3bz9FfqV50aIJI06M3KaZWnuKKdFr/HkeAopuz
         5NdhBuDYKNLjlW4yt0yLHWhQEV8Zokl3djxEg7ehEUnV9zvG8e7PBEH7BuRi1SICfW0l
         KxJGjzxv7znjhTpIBVHVSkx6z7YS5Av9jc3fmTYpSY2bGTRuihfnq3m7KPJ2wSwP7UPX
         /hxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247615; x=1781852415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fLn/U8yJbyJy4AmM/RvWgkblgbys8OLsbj/lFvTx65E=;
        b=SUcDuikn+1c+D2WPe/boYM+nEWl7MiBzvYLq0eoW9/Iu8pDi50yGbUDeCuqqu0QsFA
         CkCSr/8wyJNq2ce0Ve6dEnSjtOT+crwAxOC+EjH04jO2EUJd11pt5Tny2bum4zdA+m+0
         XJzipmiE3cCc7x7dlxmi+khfAdfGcLbQKyxdOpBCNP1XZk5LbJp1G30fAotKP68wIR1G
         hcoy+kCVYZ6YJCSRSut6hxf06hdPK50pqma0K8ltzSYMaxkTkUXbI3N4On7FQKz1yjOs
         0gpOWXHYILIP5L/B6bE3wNfXhnqSOibv5BRoBz2r15HtldLkEJFihcBTXRFX+OzfKuvq
         djOg==
X-Forwarded-Encrypted: i=1; AFNElJ+qGfEhYf1QiISEoLmk+33Ep2itifk8L4bWMMco+fS+XrmBxqz3zRpGzp77MgOU4ZVqjVdllB8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy63a/mevNhgp+iqZXJfmZxPW4f3xrXCPfvqtzJGoHLHecrdn7z
	1OVVKhIPPOc1YS1kyp5uNgVlvOV2YPgFOIlUmu8cwSvbN6cLv4P0JMMBny7nTLF1emCg2ZHdmCG
	fZaKb9wpZxx5F2T+9AGLQ0XWRK2FJmVhZ+PauQXOa
X-Gm-Gg: Acq92OHg7BXW8a8XF//br2U7quTjXe6rVzUvkhGFwkvLhWqbdkmuCXaZ2B34Y0sOKip
	ktDMycKmxidbwKp+0YG3bGXtorvOmfkdN/2elt62YXVw3N0R9HA1/ExKNQHHmVN2fzVrUXfkxN1
	23CgzzjiJNwzr/+J1L0DkT5i6ovw8fZegQhS5eGQproAbresf97NOdFwOzs8zUiMqm2dQd850aB
	pfJF/LfY0PTHA4/waqYiLXsYCk37wggI6oichsbNSJ45pxnkkIj1tUwpzhlgLrsQeoZNw4/G7Iv
	kHRCUmQg7lvza1Jof1zmNAonR9LkWQjZE6SphL7TvRw0vQcaNSpW1BVArw4DRfx2CUlZID0a5Iz
	3vUwwx5nQ/KXYZXdzDI5cBpsvNmXqTDEKUA6JTcE9m4eb8cPY1nVS
X-Received: by 2002:a05:7022:61e:b0:137:9ee5:208d with SMTP id
 a92af1059eb24-1384bbe26a4mr620057c88.33.1781247613853; Fri, 12 Jun 2026
 00:00:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611062814.2528793-1-maoyixie.tju@gmail.com> <20260611062814.2528793-7-maoyixie.tju@gmail.com>
In-Reply-To: <20260611062814.2528793-7-maoyixie.tju@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 12 Jun 2026 00:00:02 -0700
X-Gm-Features: AVVi8CfpcR1-jNm9zVP9HiE7DEszLMMfYpkSNApG-FfdrrRUFDUxEDJ0ECI0LgI
Message-ID: <CAAVpQUDUoae0D=sJnBC6pfm5HcBhfU3dwZquE0xo8GZ8T9eObQ@mail.gmail.com>
Subject: Re: [PATCH net v5 6/7] net: ip6_vti: require CAP_NET_ADMIN in the
 device netns for changelink
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Xiao Liang <shaw.leon@gmail.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maoyixie.tju@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:shaw.leon@gmail.com,m:steffen.klassert@secunet.com,m:herbert@gondor.apana.org.au,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:maoyixietju@gmail.com,m:shawleon@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-298480-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,secunet.com,gondor.apana.org.au,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ip6_tnl.net:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B1476771AC

On Wed, Jun 10, 2026 at 11:28=E2=80=AFPM Maoyi Xie <maoyixie.tju@gmail.com>=
 wrote:
>
> vti6_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
>
> Gate vti6_changelink() on rtnl_dev_link_net_capable() at its top,
> before any attribute is parsed.
>
> Reported-by: Xiao Liang <shaw.leon@gmail.com>
> Closes: https://lore.kernel.org/netdev/CABAhCOSzP1vaThGV35_VnsRCb=3D87_CP=
jPVsTHbq905k8A+BuUg@mail.gmail.com/
> Fixes: 11b326fb0a37 ("ip6: vti: Use ip6_tnl.net in vti6_changelink().")

Wrong tag again.. :/

Fixes: 61220ab34948 ("vti6: Enable namespace changing")


> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

