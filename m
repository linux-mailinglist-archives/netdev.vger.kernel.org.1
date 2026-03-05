Return-Path: <netdev+bounces-264522-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJIYLdncqWm4GgEAu9opvQ
	(envelope-from <netdev+bounces-264522-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 20:43:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A6217AF1
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 20:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C1B7302D1BA
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 19:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE633E556C;
	Thu,  5 Mar 2026 19:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zRIb0S37"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA23CF683
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 19:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772739790; cv=pass; b=hrv3mX7rfezRboF5S9/xXeVCVY8ZFkQQKSSiJH+sxg6gE35d9Lm/Rc0ImLGRjo5LGbmzdhHRRM3EIo+PfNmXC5epK93ftzF5SbR9bQXo3icjeN7116WftqtOAHGyHUfyBS+Sk049yDCdI1o9lhWst3SJU6PyGHoI/6ng54eE0/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772739790; c=relaxed/simple;
	bh=fR1TXWfd4CA+egVR32d5wNh0tx0iKYkAsimEICO08/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjZ/YputErIk8lZlDFw5Ds4+WJpajXTjqLiyEZrc5EylKT5ejAKQzBr3JvtSxRkpcX4RAXOoLo6r7+YehVe6bQJm1lprWbqmZBIQqRl0v0TbF/rTkn/S/1OjqQ1jTM3zTjZxE/tNemKRrbVsbX0/FqJIC+Siha0cQWxvdkdlYH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zRIb0S37; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1271257ae53so10243911c88.1
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 11:43:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772739787; cv=none;
        d=google.com; s=arc-20240605;
        b=B9M7sBxt85AJn9WNYlv0y1CP0Dki7+goGSoaY69R+hOd4tspwsbZqq4qezIZOqa1L5
         7aKWGalhdYpkFynVskCZ45SISXyf0wlgVjYxgr80kr+KZ+GJ0QkrT1bdpOJ8ez2dusAd
         de6NF8/Aeo2wq1a8KksYqssKuNTz6stQgCEB9zol0+znqOim810n0tn5WN6pjM2xhGYM
         /TwTriki0McnVUFOAEmT232CSrtJK7uTD3esYnCRq1gkGvYg9TLLkk0O6CEcQSbhOiWi
         q/4zsWvbi4Ev9TA2z1HJs96NCKihCB2DPHBrBUwe7pZfAqAgLGcHik9vcIV/Y8qVNQ6z
         i4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oX1aoye6X+Uzh2BOw07U5xvyxILQi2uKYkUCyKCeMXs=;
        fh=nltmnYK5WK6m07HyzXXXt66LOlr9j9zc4jhhiA97JyQ=;
        b=aVSLdzFfkgZoXJnjKhvrEJXR03TXQLc5jmnWJWa9WEG2mL541pIZpR46FyYEhkxQQ+
         O+EzbBkNNudj7g9dmBsDzWV0wHY/kQfhtqsfIQmaznSuyyzVRsdXadClUsv2ynzBfLgS
         VcfL3Sh+D4ShPkjKKQH3Bka0NfCMwCv2Q4ONtDpGO3cIMfldvvJwgprOUIvQpH8YC3/t
         lYw07xX+uZJV8/LDl9fmXmutABVpNoREJpOOdBFrHNQDe4tPptLq1V+aTfhrnau07rhv
         rPYWH8t+2Neif904If0lQma8Ox467Tdu3DK8rHv58UrLwAZW712I9wWuvRjK5mkpGU/R
         rN/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772739787; x=1773344587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oX1aoye6X+Uzh2BOw07U5xvyxILQi2uKYkUCyKCeMXs=;
        b=zRIb0S37nRFLLHrkQEr6CZesQYhMXpcQJbQw88CZ8Ter7V56sC0AHOeC4AI/B/LUGP
         fuL9mXQJ8RmyUvaw1KJOUjjSaK86wNe2H/0KJC/ghiCQTyjUa+s4ZpGGoI8OKA/BQHcB
         IyXrmgEPyMoELDIDcleFk27OwoNrLIWtoKe+D/GYzGGzM/pztAN1wYNLTenjykaa8ud7
         FAsg2d57I+4/v/r5AYOErI3DLSLGjv0vaDzbBJ2xAfDLb48zwyj+in4l7iwsSMuYwWgq
         mnZtPqjv5nHcsNZtCFruYI2hK0qkHEIVH0yp2H8fP16AVKOMtPYgrJNHdNqAUZNaSJmt
         4GMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772739787; x=1773344587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oX1aoye6X+Uzh2BOw07U5xvyxILQi2uKYkUCyKCeMXs=;
        b=TOOLK/oW30fdv3l4XFH9ja1X3K38aFGn72QebHYGUkT2SSZNgtH3ROFicz/45iPEJD
         E2tjxRQtnNxJKhf8+RF5JY2kq3GQalWqxBZzntqMUC2ayl7B5xyZZqto84PdSXtgvOfC
         Xn8E+HMy/5kr0k8wlgDg/kfaWLUgglI5C+BJ9StwIUgzTrGsIq56qoS7fBAg1/qvGW1M
         U3bX7kO/X62dk6XcRlwr13dSehM6OxZLmOve1vKRlwkVZNR9XzL76sbGv+af/4LGVams
         dYKOw95XhuDvGWEcRltS8B7SHBsi7bxzxTyscesUlxaMs5hvJVQGykbjblxbsmixmVsg
         wNsQ==
X-Forwarded-Encrypted: i=1; AJvYcCU660z/FmCKVpJ9X2ZIq6dJVrxcXf9XOyBKcpOqGIt7qkWPRzstfdkKaM/50t/oa5Mk+zFno0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzJsxS9OBY2MB79VuDfBZCf/D//HpL2Eu1TRT1o8ALX3CY5JZ8
	tldoVwUz/27n7dHVE7gUS5McF/+vWVFJl/5VxUVDhhrPdOtmeinz5AFiG6DubytzPR38v9PMNGn
	7ElKk2yhiPYPFTIqCicPYnp8OCb19zowPmc7Hpbg+
X-Gm-Gg: ATEYQzzQ1gBL/k1pKCou2N2fZDG4eDHzoBCDqYeRp1fINZLNeXZMzeBaoARf8IwqHRh
	zZ//tjXyPTs6qTj6mgLAy0UNfS9m8onfQYkfK9FQuz55aMmorzykvVlj8AJAOGXbKzMJkCnVRdJ
	3qdEUWnLVhDThYY9oxjq4+I8WACbYbvCUvS+BMHO4cqJswLSH0QmrOcXpeI03jb2KmFczFgD1nz
	LekOXmomskeaCLiy7ftdd7v2FP7WeBIrwd0T+lKxcjL+JDF75ajhpoYjGH7+M21C2pcMTrYG73p
	YdSliMQUVEK9vazU+BIiZye/UZ7FAnYQLSeP1BfSfSDb8FCgia27f1bAXoeU1ugxMds0n55i
X-Received: by 2002:a05:7022:128b:b0:124:9f67:6b6f with SMTP id
 a92af1059eb24-128c10ad55dmr449281c88.20.1772739786763; Thu, 05 Mar 2026
 11:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304193034.1870586-5-kuniyu@google.com> <202603052252.qcNefHFm-lkp@intel.com>
In-Reply-To: <202603052252.qcNefHFm-lkp@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 5 Mar 2026 11:42:54 -0800
X-Gm-Features: AaiRm508G-v6MJNuY-4iHqxIFwZuCKLIrOOkb_pTH11Y7XuxTur_rvFnh0604sA
Message-ID: <CAAVpQUBbsRin3NO7-zARiBbOBTMZN=zr017_zYMaOo_VZr9Tfg@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 04/15] ipv4: Retire UDP-Lite.
To: kernel test robot <lkp@intel.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, oe-kbuild-all@lists.linux.dev, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 580A6217AF1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264522-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:email,01.org:url]
X-Rspamd-Action: no action

On Thu, Mar 5, 2026 at 7:04=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Kuniyuki,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on net-next/main]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/=
udp-Make-udp-46-_seq_show-static/20260305-033454
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20260304193034.1870586-5-kuniyu%=
40google.com
> patch subject: [PATCH v1 net-next 04/15] ipv4: Retire UDP-Lite.
> config: nios2-randconfig-r131-20260305 (https://download.01.org/0day-ci/a=
rchive/20260305/202603052252.qcNefHFm-lkp@intel.com/config)
> compiler: nios2-linux-gcc (GCC) 8.5.0
> sparse: v0.6.5-rc1
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20260305/202603052252.qcNefHFm-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202603052252.qcNefHFm-lkp=
@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> net/ipv4/udp.c:3748:29: sparse: sparse: symbol 'udp_seq_ops' was not d=
eclared. Should it be static?

Ah, I forgot to make udp_seq_ops static.
udp6_seq_ops was done properly

Will fix in v2.

