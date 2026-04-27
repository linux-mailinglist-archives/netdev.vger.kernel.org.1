Return-Path: <netdev+bounces-281249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ/iDiAS72mU5QAAu9opvQ
	(envelope-from <netdev+bounces-281249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:37:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C230B46E711
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2C1313005382
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 07:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C583822A3;
	Mon, 27 Apr 2026 07:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZveSDvW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B3D382382
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 07:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777275419; cv=pass; b=RZEQjxX+IlGRnRNcv8nfE/56g2TgTqzOxSjydT3dosK80ldg3Jq9MlRvR2o8KuADpqV/nbrVpka9WHn+1uyshiE0rkngn0Sx3UFHGIEpoznnuW7zsyr/nmT6XfCnJzrj5LUR3BcY7Wa4ppZ9KFyP9g94IWkNOouRMPf1VsRw5Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777275419; c=relaxed/simple;
	bh=DLATZw/E6X5X5U4Q/6l08XSMP/bwe7ob52fPdh13YhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbXJiZfXhFZF7IbHLvgfrT9MY0w1uIwQbL15WDIduPuH4fZfZ9IKEfjN9BZTypvsySuug7xTVPQbiswwwbx377M3OwEwrW/WJRgmQseTC+UX7V/Q5C1Pfw4ElfcIwX5+dcTaRLdJeZe36MDiD45k2bhKsPckpeiMv/zol6dQKUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rZveSDvW; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d876329bbso107989831cf.2
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 00:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777275415; cv=none;
        d=google.com; s=arc-20240605;
        b=D6kMXES5o6L+w6e1/ADgIC9H4vBKJCDiiLhAVeLHRtR5umTXAZCKiCUGpfDaHq8S0r
         1A50B2SWDhWZ+sZeAJYYfNBW8nyEXrVgb3rADwOWjBG3Zbjz+JYp/SlijQn0egUy5b5R
         IS83WYx62heKg4abaM8c4S0ZxHvEW/GCtBz26ESqdbAFTsHkRzbI5AOcQr/YHIOsj5GC
         H2V7fIwOwJ1m9CfGkuJZo8LA+CUtCcH/9g+QgdFClNX/ziSoGikUuH/zykcFYkCXEcy5
         ZQv8GCFDwevuJVWM2yXrif5l1bv+JkNr0lL9toSwYcboyHsimCPvkRgghAEEHY5stRGz
         tvCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v7hV5C0UMkp30VZ36pfLZBNeBSgytE4WrIQisiBHlvc=;
        fh=msNdiVQncVKJbbfSWTP6z/TrDOwlmXOtEcPRBIJdqv8=;
        b=eheR53gGNYhTLysnRiVMG64PPjOcx64raT9b0qWKNiqTdGSNgqXu5HlWUymalnuUfu
         tP0gfCnPpGoVGWPS6B9Z9n5nBS8YCPHIiEvSrB8l/0n3ftqYpW9Mblw9odMSqRct69Sj
         yZ3HHZ9HZJVG5dyc77RTfG51D3l4GEQDJXsA+UseG4rndqFMsFRNevDt9D1jpIIqABdO
         /Rdu6hUs3V+dlvIs1abn4FfJzG6xse9XUafnwhgMcXUAZlJMOLwGu7PJbJ1L4xf3eah7
         8mJlcDVxzFg8W3brEGD7HsvLL2K89nBsGEtrlzB+3wFpe1ue1GCH6FUmvcTYEIgxOQGB
         1kjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777275415; x=1777880215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v7hV5C0UMkp30VZ36pfLZBNeBSgytE4WrIQisiBHlvc=;
        b=rZveSDvWMnTRN83T5O+G/aIx0uafgSwT9Omrwrr7vcpt+8fJvx1I0vekTSBAHTQtyw
         x9fFt4ta3jUhWLR/CiTca40kHnvbkExZiuSXwVJ+ecZ+EZjO75Fpepj9SVFQZriInB8c
         S0byyab8I4oG6CjXo49Uev2ut42OHiVsNbxPOt53inJCzVL37CJlCgLC+C9kPNDrcjNP
         Ez9MZYXJcOKFjgubp834UVvzpXefzbyUVtU2isQ28gBSSS1dwC30YxI1m783jJQqnVRP
         T60SeFZIgrxCaj9DRJu53lgAMvHp4o6bzekq4HW55Ufvr3og4GpxdEpWPwD9GNIIcYrQ
         npTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777275415; x=1777880215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v7hV5C0UMkp30VZ36pfLZBNeBSgytE4WrIQisiBHlvc=;
        b=Vr8qtW4sJUq7sUTGIHCIj+lLUyc2JGEUg4SnwxuMJzP4UPDsFfQpv0OdTtHnhFqDX5
         ezadNMGzZ8JFsjMWzIERsED8xk7OIAI7Tmk77yQGe0uXWs4gk4gnb+2AgcFmWqIOFrRC
         gsX5om533b56XIojmf8MrGbZ2cGubXe1O9DHIKy8Z8oUmyUQDZBN9bcQtcA/BepzyqgO
         +P6mQ0nSWj30sxH1GvcKP6hm6aaOXqK+ivr0gnO3GvGqyruuQf+vj8qQTmOamxaG2zkD
         m/L5yl/Bw8HEm+hGcKckxOyU+bL3ySWA7Vbs+rZ2Si0nfAm1ar3Jb2SRVgBHZQBwyg9K
         xAsA==
X-Forwarded-Encrypted: i=1; AFNElJ9Oebo1MkI4ECnEWZZCvhkUlz8cDgZ6oO7i+L+Sd3qtYBOp5tzQfeQIbAgNnPlFv7ATkDzx5bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwORRi/OtDAMEJ6Fhs8GuJWLJmVj4hYR6+hUXUd0qcX6NtfnSKu
	ovFzrwkWAt4wGUe0NVPXfQ+GSzaln/CvlMex2oHu5tTamM22HrPO9jX/v3YgVDnGy049/kTx3jB
	DvTF/9nLnioGQ0KDAS3azHLoa51Xh4U6mgOQZ0Yea
X-Gm-Gg: AeBDietx5Q3hYgsxadYqRop4L2rDCfYF4NDZs41pwPV9uaF2mc4ifxXCmmUU4TFa18e
	2jGqWn5sIfnbfbxBxoRSItujwHYRnCVKPyBLbNSTCcvlLsc7ys9P2xdr2QkNf1I09zLAWZW5ea2
	vkMvKnEMPR/8Vi/mehyjBBRpzaf3P+GVSTa9vzTCJZ19qPjgE66ISAZpKAdZn5KAMl4Gvg/oadv
	E7wdTpzULETdDqBqB5vFjPYK2q28dCWATS/LN4mYhbH7dqO9Y4OILyT/01YqQzbTuAe/EO27V8V
	8RgRPh3ujG/RN08w8/nsPg8QfKNvnq3bpzzmbWIBArZngmlkyrPkFXzrCLFbloSjywdRjLiOR5A
	2lYFQ3GUI
X-Received: by 2002:ac8:7fcf:0:b0:50b:4946:2781 with SMTP id
 d75a77b69052e-50e36c4959cmr595635871cf.38.1777275414972; Mon, 27 Apr 2026
 00:36:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414013634.43997-1-ahacigu.linux@gmail.com> <20260424014639.54110-1-ahacigu.linux@gmail.com>
In-Reply-To: <20260424014639.54110-1-ahacigu.linux@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Apr 2026 00:36:43 -0700
X-Gm-Features: AQROBzCL4oBIXS1zs1IlbDWmYGsdfXvFJC1NgEt2hHNDKn6LozYfbM0-MQyV8_Q
Message-ID: <CANn89i+UDvqJVQJO3ye3ZGB7vyOawTHPsKJNFzZxT=yyoS4g-Q@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: make probe0 timer handle expired user timeout
To: Altan Hacigumus <ahacigu.linux@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Enke Chen <enchen@paloaltonetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C230B46E711
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281249-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Thu, Apr 23, 2026 at 6:46=E2=80=AFPM Altan Hacigumus <ahacigu.linux@gmai=
l.com> wrote:
>
> tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffies
> using subtraction with an unsigned lvalue.  If elapsed probing time
> exceeds the configured TCP_USER_TIMEOUT, the underflow yields a large
> value.
>
> This ends up re-arming the probe timer for a full backoff interval
> instead of expiring immediately, delaying connection teardown beyond
> the configured timeout.
>
> Fix this by preventing underflow so user-set timeout expiration is
> handled correctly without extending the probe timer.
>
> Fixes: 344db93ae3ee ("tcp: make TCP_USER_TIMEOUT accurate for zero window=
 probes")
> Link: https://lore.kernel.org/r/20260414013634.43997-1-ahacigu.linux@gmai=
l.com
> Signed-off-by: Altan Hacigumus <ahacigu.linux@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

