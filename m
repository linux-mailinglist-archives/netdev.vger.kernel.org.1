Return-Path: <netdev+bounces-260157-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCXBJWefnGnPJgQAu9opvQ
	(envelope-from <netdev+bounces-260157-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:41:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A0B17BA25
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 19:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD2703013033
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 18:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4A4340A41;
	Mon, 23 Feb 2026 18:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dmlVuuI8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308DE33A6F9
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771872100; cv=pass; b=ecOGfsZVDl8VNjOJKmHjdU2mvWSixqy/9lxE344t0t4udVJ+beNDr5rrLuXwMbH2gJKT9/x1bgxr97s6OVL9q2fVQpiV6h7MAU+g46YWgjUnsE8vCdHW1YXyhgR5JfYgoCS9VJqRNqkW+nTiVqnpNifYqt4uUoqMW0yaTPb0OmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771872100; c=relaxed/simple;
	bh=1CU6RFq87EQUdoCBNe3kmvZvq44U0Vhdrzm+wbYOd3o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=maWE+WzXX0Zz7ggkCU0KSPEI/cVuCelCYXij6PERFE8OoSLnCimBHSnNgGTsFJOfe0vE3exMDWQlA+MWgtpbB4x7CiXVNL20AytA8Yg3UugeN73CFHTm7fJErRdod3PPDeZzakHJh4RzP3sTff2FVvY+ie4ly5Ot+HdlE8H6YvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dmlVuuI8; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1275750cf9cso3837455c88.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 10:41:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771872098; cv=none;
        d=google.com; s=arc-20240605;
        b=RJwywGZkCor4HjQvBynBJt8KU8f8aVY1JyJzWn0frU2klKesoQJNTZRrk8UeyribCV
         G7Byw59uE6xDuB1IxkS9O5fEIA94wfKaUf+tlLYasM9CqdtOIPr2gwWmSoNuwaprkeT4
         IPUUJdIrxq4v+HuCrZKdDqR4mH99vxYBMiTGtBCD7OTuP/My99w6pwCvNAdiR/9/k+6m
         rcm6nRvhpWUzz6C8bIBIZa8tZxIeJB8klbn6xIf/eD1TG9eU5WZ/4n11l+bfIyLIsn+A
         sO3mi4cdrtTGtGeBPzG0/6u23fcOROuVRCjS/vIS2msld200+mjL/oaAknFLPOpxWLbX
         c1Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C+B6DwSv3ZzWbIMrzjtY2CdAA9+2igi9af4Jw+ga2qQ=;
        fh=I+RX8P25HpPlT3M0Erncosgy7QLBl9oB1aCJftMxwUY=;
        b=P8ExFfM1MdKRRju4PjN6v+r1egGpjhHsKt1sOua51M9asYWlohYEMEqeKFU6fIssCq
         PdhsaovNrTgSrec2VCKFf+gRh0fG9vVxhsDnCEELQD8/yFxT6JwokQp0KOJv5EjQtOap
         jmgyYGlr6UTFFvXZEq5iIrx4A6Y6+0Qce4zaudBMG1LZrCZKNInTy2U6lA63pBrHkvnf
         XLnzxyigRzZ7DOGcM0QRaPjqLnPsHlh4LKW/LJeW4+Ua3xiz5m4gk3UU7nF8W3mHbTDK
         SLE+ufe/xNGyUkrbKL9nhc8buXx3IZme6YKgsm4acZLzQP+Rk3DAsVs22cJwPNpAuIx2
         ewaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771872098; x=1772476898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+B6DwSv3ZzWbIMrzjtY2CdAA9+2igi9af4Jw+ga2qQ=;
        b=dmlVuuI8KOGNdGoLvivLKLcplpKc1Lg0oHADMgaljlR18/zuCg1gqQQZmDgDA4zuVw
         cTEHO8RC4sJTP0H5ARs0yVE33l3gEYS/DOdP/oTcDmn3ic1U+D5omh8tc+jyV+qydzE7
         bcZplurwknvMXA2CRw0lOq1Hxx6smC2YMFK+zE61QGj9UHCDkIQ8EMCe1r0ov10mGUyu
         z8HqE47py93X+nCbTMVNyQUYAQE2Ikwe8lPqB4SHIZBYv4r8o+hGAZyg5ti7SGtCuEX2
         ihZvUW+MNhniAH399YYsPaTRo1qlls2PelktGWyr/b3gVl2KF90JII0gfMF6KGgBNNoZ
         IZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771872098; x=1772476898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C+B6DwSv3ZzWbIMrzjtY2CdAA9+2igi9af4Jw+ga2qQ=;
        b=c7bF3CnYC/xfso2DOZzmkRLi3r784mhiYjKtSCjk2wQdqjTszXDzzuF6nRaqhu2oNH
         7UmU08xGM0G/ntaig3+TSJkg1CtrUZGtKeCF777FcI2GPhS6O12qe5059dKo3NQdgqnd
         CPd9Y+eQtnDfvAQgaXwF+Imf+cmaDvZJHuJXj6e1ri5RHPmeNXFvSgqavPPfH21+lpv6
         5JBC8WnYTpaDN1M1HcbjumkwJXQ/9w7zsSv8pN8Xwy7o61dJHe3KG8/uSKxtHYdBFxpT
         4xvUKnWGUf/SUMkx5crsZYrZVm7oaFK9nSx6N2Othz/8OPnyAe6FwBi/3IEAwuvRL282
         enKA==
X-Forwarded-Encrypted: i=1; AJvYcCURIxQfhrnlzfN6hjWinSvheougQ4uWoIdVNpjTAIntqeHuo6jx7HrR6LzDSQK6/3V3ekm44HI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVxN6sg07WKtZw8aHLKUFyu8LzkxbAX6719q+5D8XP3uKHmM7y
	y24vEb1mx3O6gP3r9DI4p8qcM0q2cAKIQ7X2D/DjU6flatoQ41riGQkpYFnw6wn+1as1AG0fdei
	0YB5RM80Tbg90nwpNVEDejOfre4mveveEIFU+qU87
X-Gm-Gg: AZuq6aLzjz2FZe4BBucIj0f7mvMD+w+DCBrny4q+0djTZf6My1zht8Gx8KmjZu9Aarn
	5OiqsDzCelcOMt74eUcAlRJSLFvuyMsk5xYbJQMFz81x0HkPZp7cpCJkSC3r2bvqCmpxmDKTrvx
	MtTvhZ3QZFy+LOiZswd1kJHV9TQKSszCbSa4AuXwixkH8LbWCWu+ZGwGCftSvg5luHXsRo4UCUN
	T2ZulbI5ulFcDUYxmnOj5gBzYeCsRE/OgH2j7phUf5FKwxVZUhTrjd+jCQTLre7tNFAvvwoDHXm
	cmZPA3pXwTBhuH87uKIG9F88ISaSyjPhyd0f4YYM55kePVh0cISPobUqIAZuh44v8ViK2MaT
X-Received: by 2002:a05:7022:248b:b0:11a:126f:ee78 with SMTP id
 a92af1059eb24-1276ad33741mr4017888c88.34.1771872097794; Mon, 23 Feb 2026
 10:41:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223092716.3673939-1-edumazet@google.com>
In-Reply-To: <20260223092716.3673939-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 23 Feb 2026 10:41:26 -0800
X-Gm-Features: AaiRm50lftSFZGayIGAirOWfFeIN2pNGSuAYn6t-v_TTJanQSXcu0RfJry-8GYY
Message-ID: <CAAVpQUA7YkT3fHAUUPk2TZjr_1=K673Aph+6VWPOnv3=TRS4Xw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: __lock_sock() can be static
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-260157-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D3A0B17BA25
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 1:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> After commit 6511882cdd82 ("mptcp: allocate fwd memory separately
> on the rx and tx path") __lock_sock() can be static again.
>
> Make sure __lock_sock() is not inlined, so that lock_sock_nested()
> no longer needs a stack canary.
>
> Add a noinline attribute on lock_sock_nested() so that calls
> to lock_sock() from net/core/sock.c are not inlined,
> none of them are fast path to deserve that:
>
>  - sockopt_lock_sock()
>  - sock_set_reuseport()
>  - sock_set_reuseaddr()
>  - sock_set_mark()
>  - sock_set_keepalive()
>  - sock_no_linger()
>  - sock_bindtoindex()
>  - sk_wait_data()
>  - sock_set_rcvbuf()
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux
> add/remove: 0/0 grow/shrink: 0/3 up/down: 0/-312 (-312)
> Function                                     old     new   delta
> __lock_sock                                  192     188      -4
> __lock_sock_fast                             239      86    -153
> lock_sock_nested                             227      72    -155
> Total: Before=3D24888707, After=3D24888395, chg -0.00%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

