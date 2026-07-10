Return-Path: <netdev+bounces-306624-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iPRiHRcbUWrR/QIAu9opvQ
	(envelope-from <netdev+bounces-306624-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:17:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D56273C832
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 18:17:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=I7UarXwp;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306624-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-306624-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56A3C300398E
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 16:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A670368D59;
	Fri, 10 Jul 2026 16:17:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E8368953
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 16:17:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783700243; cv=pass; b=AHosJsjaQzFWyDppcU53INzICqp5b/HszyZ/T8s22Wo/N/u6iwaf7vjkCq73ghM42+OkudWJCz0Dct7WWqQxlOHkvWL8/IIVCxnnciRr0P39Wj9VrAR6yfpCBgKtz4JNyqrFSWhaYkgk1SaJth9tGMbB3m0+Yf7om3Su+B3zqnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783700243; c=relaxed/simple;
	bh=s738RpUfllL7hET1bu850Mz/d374obk/RRGu/hOrYZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHjL6lIVVXw9JkBOsjIGPAyu1eISYT1Xlopp4SgUGdGx4NEqQ+6qJv/9LkAqPMuybcp3Y4CXiQAXWTCxjIbKGf2NxIGHUy5rAlp4AB2rKoHIUf4KQqKWRNaKHDpflgQSFR9hK09CUF9PruMpSSg2GvICCDpy9ycsy8DbYnj0dEc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I7UarXwp; arc=pass smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-69531108f25so1852344a12.2
        for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:17:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783700239; cv=none;
        d=google.com; s=arc-20260327;
        b=UvKZa3Yh+jiWkWK43CqUbb8lsfHD5GGiibA1A+Q0da7hmQlLoIJP+r6BcaPbYDFt7z
         D/ezefgEyt2Iu2/W9laQ/rx6LDm5YSXiqIuFtUDtHGiunJmfmc+cwQXkcb/P5YSCDABk
         BdoopM/qT/uLJ9aa2i3nGtjfe5o8qoewRJwIt6BKNnC+YLt1QSEykvwKavBQqv19Ms5b
         zrtXYUwJDLJ/7kYLtOuAuVMFL526xiilC2Xm8HeOQSmJQQ3H5bBbWik9ucMIOiJrlLav
         Rzv5/dGrfp6gWTtcOMvwB//L5Hd+vntlXVBj6EAsY04i8eLbvkAuXfBW2L5YAEJKL6Gk
         5ASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DYARVhf6/Vs7Op0OgefICS1l90epwG0lBtrCsJAaI+0=;
        fh=sYvAhNCg3xejiwbSn/eYhLiiO5kjbxnnj1R3CqiFBeQ=;
        b=YlUJ/qxXiUMt0b3qFOO3eMFVP3oHy2LrzRlIew/7NhZtti9NLwo1LVjKkVUKK4J1uC
         35bofSb3oKPBPblKzj8Y5bkI+39KuVtsioc7dBZdjYEEqrBUBuO/+P/GWBLpVTHlhBdP
         vc+jsPmHUy4U2Wq+TaSVFbrYJUjZ37glSJ2Ebax8iVk8r8YRytd2xeJyythSehYpp9S0
         8NcecKYazEipSAR6W4TksPH6O2EsTSgjDeqVoaqjg75nTpRytSaLI/wHi8deEB2iAo6a
         bOr1MtSKXh4zxdbEQ303pOUXJPFmcM2SGACWDU9WalcEJN/FMz5WUA99AeFI3NGt1ViH
         4i0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783700239; x=1784305039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DYARVhf6/Vs7Op0OgefICS1l90epwG0lBtrCsJAaI+0=;
        b=I7UarXwprqz+KUTt+6xXiR8V0K6O+RuWdNv24U6sFv1obdOMd+3RkLbGy1eNRUMta7
         3OU1td17xuSbrQZIvFQ1PcCWp66j0jS2Kq2RY0Y6sWcoH5u983898NR3mGHUuO77BkDl
         0TJQ9fSr/k/ZO6Jz6jVRI1xAh9Jj3G9ZyCnJ4RYEqFGBrB506h9vm2ukfHTnibu7BbKj
         DRHaeuK4lhqPXWcBAQ4sYeu59Y6b1C5zsTSJkS+EqoJygNRGX7hMdJZOYFkZ/nU3844y
         wv/S0XMj7USFieBjVDiYl3/xVbdGtyf+zRq+vvFe+RwwYDuYnPQJWiCH1qtv0AcubYVv
         3thQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783700239; x=1784305039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DYARVhf6/Vs7Op0OgefICS1l90epwG0lBtrCsJAaI+0=;
        b=ifcx7NdV5KtesMUeN68cc8myRndskosDxTM5so9M+en28pxggT93AY7GB7WIVCONPX
         3yGqU+VeZSGztOb50mobDo++ecD2OHKOZLU2D4GU82S2DLHSD8Bd1SKpJ0D8Li/dDrmt
         S04pdk/4o51UGxTToljsDggWIA4Tyd2B+srXQrw5vAWgm2yDkhTEhbUNxrjT0X1qeB47
         vPjM5eg/hrJxFh7mwxsP4k91pag/Eh7gsjYC6CKP0gYaS8Fd16ayBuzi8gC8w1d65z5S
         LQowkmH4ef63ZeNmTLXa3BR/kp69b4Wy+463mIiHrUsd/yHuGlzS6pfMGvAPUop04+sz
         43TA==
X-Forwarded-Encrypted: i=1; AHgh+Rp24fX5kqPRceKN/1sM3Fc8fPBbmCFwduO0IBKASmhx6obdHBBmlsOkJWV5OSpxLuep4HlnvGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKTXDRlFHAPO6xiCQWDHR46vhItKBLyvwFU8j8o67aHQXNFNR0
	XvwKkJCSaWQzV83XFSn+oMSfZKB1QqfwxUWkZ8K6fF1D2LxNsYEmTijN9OpU2aUdV4P3peQI9mz
	R5PMhmjAG+/jMrWNk8A74h4t9GHr+vMjSv3XJU9HH
X-Gm-Gg: AfdE7clqUnxWP76gL8sQQKMOPUDgWo/qMMioPbRjmpGYYNHHvc6WWKmjYppB5J99Qah
	Q2fjwszXcTKoLfdULINUnae/Os+I836HTB/MN6j8J0mt6cUSB2TZ7Tome9zODe0CKHIa+l+RSdv
	+Sg5KxDgXpb8NWPAV1NNCfobiEtf2QqKrybPcafi6Q1vRaD9e7T18p609VLvq3uS60S/C8p6Yeg
	kDB/KfuX4vnqWNiz7Dy3aBbBUnhxo/U8fUke9m6qdI9f9mXEfdPH66ERPBqiwc3Dwu05+u3cBQV
	0TV/0iRG5SolGa8rdGIg7o0YuXf+QTsJTiv15oqZLIEwc/rNRmQtsPkJd2TWmijT0+yeya8uMNB
	GEEhicsrLCRB7QatXGXU8S8dQ2paDn/0i21qh6iQXUSH/kXGqo/nx
X-Received: by 2002:a05:6402:3883:b0:69a:9ce6:ba09 with SMTP id
 4fb4d7f45d1cf-69ab44abd47mr5083839a12.19.1783700238489; Fri, 10 Jul 2026
 09:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alD1FJjR5r5n5Eau@linux.dev> <19e8e6f9-0d4c-4ae4-b519-603420619363@iogearbox.net>
In-Reply-To: <19e8e6f9-0d4c-4ae4-b519-603420619363@iogearbox.net>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 10 Jul 2026 09:17:04 -0700
X-Gm-Features: AUfX_mxWWvAt0t5YudKd1cAOJoDGSt7x1VGIJWlv6jWw7fSKrFHdnC0qoVMgGm8
Message-ID: <CAAVpQUDsd0=E5ZHDuUSxMkZh9jPZubzBDba+ECu5zsywoRDjEw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: tcp: Fix use-after-free in bpf_iter_tcp_established_batch()
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Jiayuan Chen <jiayuan.chen@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Ben Cressey <ben@cressey.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@iogearbox.net,m:jose.fernandez@linux.dev,m:edumazet@google.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrii@kernel.org,m:yonghong.song@linux.dev,m:martin.lau@linux.dev,m:jiayuan.chen@linux.dev,m:emil@etsalapatis.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:ben@cressey.dev,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-306624-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,iogearbox.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D56273C832

On Fri, Jul 10, 2026 at 7:32=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Hi Jose,
>
> On 7/10/26 3:44 PM, Jose Fernandez (Anthropic) wrote:
> > Hi all,
> >
> > Gentle ping. This has Reviewed-by from Jiayuan Chen and Emil Tsalapatis
> > and no outstanding objections since Jun 29. Is anything else needed for
> > bpf-fixes?
> >
> > On the automated review's flag about the pre-existing double-put on the
> > bpf_iter_tcp_realloc_batch() failure path (cur_sk/end_sk not reset
> > before seq_stop, so cookies can be re-put as pointers): agreed it is
> > real, and it predates this change. As Jiayuan noted, it is a separate,
> > pre-existing issue best addressed on its own; I kept this patch minimal
> > for stable.
>
> Given TCP, it would be good to still get an Ack from Kuniyuki or Eric and
> then we can ship it. Are you planning to also follow-up with the other pr=
e-
> existing issue finding?

Oh sorry, somehow I missed this patch.  Will look into it today.

Thanks !

