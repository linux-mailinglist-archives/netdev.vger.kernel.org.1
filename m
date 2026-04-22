Return-Path: <netdev+bounces-280552-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCzUJVBD6WmqWwIAu9opvQ
	(envelope-from <netdev+bounces-280552-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:53:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC26644B2A9
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 23:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951653034285
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 21:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC9F3A1E9B;
	Wed, 22 Apr 2026 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lId8Yp78"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136AE2E5B2A
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 21:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776894793; cv=none; b=hwAhVIeCfl/oCn3vsZMlIlP3jRYyMccmovpntSVHKd+fWH1h+6XiMTiPgw67ZiPFh7Pe7OJfxFZPe7QHH6rHkl8rh4+baI0swyMxHCwkE75T0cVLV6ZCXFimUcbRfX6/p8UxqJJSUK19jmYfhOdTmB/KqSvG309Z1LHobpC+JS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776894793; c=relaxed/simple;
	bh=LXdewrHNEqF5/FU1tRdIKkldI8J3a3W8f2OKjntfn3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jg/a/l+oaPc/lvpZdSyzE0lcmhcWtduSYm/xqhIbzTvjm2uE5x28mnajM5sAUSvploywkEKu/uzJHpVD0SJK7LXAJv8TH6niQJbwk4xROFQrWxseI8ZkEavNfLUUzASh6LpRFlnPZoK+Id96ZmorLu8Za3fUPOGEqSCrkciae4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lId8Yp78; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48374014a77so77934805e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 14:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776894790; x=1777499590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2tt5yDNYvoUooMbGjjoJFOkr5ibuyilEwhAEtbKH4lg=;
        b=lId8Yp78hoq/3p05hnmYdBtPzNhjMFh23iPGa7BJ9VqpGEvKfLh0m+ecZSmbqKDOAJ
         Wdb0fitVdlGMzl17Ia5LYbRMEPUc56Argi//oQhoq6hPjcsuwuMtOt4GwQaOneNpNhqM
         ZdcUQJWeenTJ9cc3fkBRVn1kUMdie/4qQqy0d6rcjtqHEWpmC1xwC4UowP3Yh1x74p/9
         cMZ4BnMhMcPZfz+vyx2CaWPkoKx208baxROd+bh6T4dyGDkMFjWTkqTQxNLlixIvYKY/
         LrjVWBWY4x5rqRZOgccYfT3hEWgeOxxR8bWi43g2hJ9sVskBbH6k2Hn+OQpejf8GqSYg
         fatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776894790; x=1777499590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tt5yDNYvoUooMbGjjoJFOkr5ibuyilEwhAEtbKH4lg=;
        b=PGyCQZw+i7jf/ROzgr0VsbFfM9iGE7KvVvP0z8VQ/I7/aqWu2F4ZC6Vvrp5Ohpok7/
         GDtPEkjNJRKxFNnCoRHM0qDFmXSRyny/XYV+xQGZp2UNqqf/9fmzIXkN3NPHUOW7GN7L
         5fhCC9k6FwEc7qL1P3UR+yLuB6qCw+K6r1arZf2GqcCxzEScz3iDuN9Wp98NIoY4uwTQ
         eX55lPqkR6FPBAiyXkYFvHS00bgRp9162nMzerQz493yAB+NGiDmdbLX2yjEu1mQXUBm
         8dpxVqtxK3eTm8MIYNBhtJjjAJ24e5m52krDd809uZYu5N4KYqXTjMgD+RLVIqFTkf/3
         FMNw==
X-Forwarded-Encrypted: i=1; AFNElJ9P6m6b9hQE6HnOa93iNrvfuYy7ExByG8Fn9G+0Abn1vn49W/Nfz8OU4tcigrvTzIqg7sthRuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIJADYlrrkMGEvpwkfbM7pJ6lWIPnE2Cu8fKubWxcW2PecIhVN
	yJdGtv1GObLn6+HC6lPIa9usQminUOSl7sL2lX+nca2IucQ2pg7XlHqxuNRbR8FU
X-Gm-Gg: AeBDiesL6qkm+Jdejw2UrMeN+xyd3QvgNaqsXEncy1rVtV2n0hP357m0bp6t96tiu3x
	FmNZxR7f+7YJSARJUhp7mg+kDzjslAwOLTJ9Mps7YjjhqpKwXZWnWRwzWLUfteUcbSFy1DXviKc
	hrnuMd1pzXKXXFx/SHYFkJJ/qJWpyE+QHe/SEHyICFT7XsaUXFwIKhEXpw/Y1ZT768Q2p8xwemV
	ZJjOMGGTzd05eLNbynkdbJ5Autxt6TuVwQVKR/jMG4InHn+EwvPzRMLiTE16U1u8ekdA8c//alL
	eiptjFDflTDEfQoR1tjyUUSLWflrYS0QHWT8hIFvB/wb8twBs/Py3N2LRJmNkOwAnu9jJYRAjxl
	DCZ4pG75YMWpqjrouy8b3jAM8FbEDpIJJzJ89Nu6iA39DVOpZOsTxdZnKNDUvnTQ2V+t8FmS0p2
	ryjFeoP/Nn94NQPaauaK1nhO3CJKHS7RNp8vgATXIUqAHTZCQwtKDYDaer943VNb5Z29FwbZpbo
	u/ev1ymn5uvEIdVEWeVejiSj4ba7CHaz0qS4fpexWFDvapKPrd1QRo2iVuzRL1R6kgp4z8CekEe
	rJXvvxBH+YICGzIi9yvV4za01pVSD9zqVci1TvcQzfYh37o7PEG4
X-Received: by 2002:a05:600c:8b28:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-48a5c230e78mr48544025e9.19.1776894790398;
        Wed, 22 Apr 2026 14:53:10 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00069634438ccb7ad1.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:696:3443:8ccb:7ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc177dafsm578595275e9.4.2026.04.22.14.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 14:53:09 -0700 (PDT)
Date: Wed, 22 Apr 2026 23:53:07 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Alexis =?iso-8859-1?Q?Lothor=E9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, ebpf@linuxfoundation.org,
	Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: drop xdping tool
Message-ID: <aelDQyrw6eo6USKB@mail.gmail.com>
References: <20260422-xdping-v2-0-c0f8ccedcf91@bootlin.com>
 <20260422-xdping-v2-2-c0f8ccedcf91@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422-xdping-v2-2-c0f8ccedcf91@bootlin.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,davemloft.net,fomichev.me,linuxfoundation.org,bootlin.com,vger.kernel.org,oracle.com];
	TAGGED_FROM(0.00)[bounces-280552-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paulchaignon@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: EC26644B2A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 06:20:25PM +0200, Alexis Lothoré (eBPF Foundation) wrote:
> As part of a larger cleanup effort in the bpf selftests directory,
> tests and scripts are either being converted to the test_progs framework
> (so they are executed automatically in bpf CI), or removed if not
> relevant for such integration.
> 
> The test_xdping.sh script (with the associated xdping.c) acts as a RTT
> measurement tool, by attaching two small xdp programs to two interfaces.
> Converting this test to test_progs may not make much sense:
> - RTT measurement does not really fit in the scope of a functional test,
>   this is rather about measuring some performance level.
> - there are other existing tests in test_progs that actively validate
>   XDP features like program attachment, return value processing, packet
>   modification, etc
> 
> Drop test_xdping.sh, the corresponding xdping.c userspace part, the
> xdping_kern.c program, and the shared header, xdping.h
> 
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
>  tools/testing/selftests/bpf/.gitignore          |   1 -
>  tools/testing/selftests/bpf/Makefile            |   3 -
>  tools/testing/selftests/bpf/progs/xdping_kern.c | 183 -----------------
>  tools/testing/selftests/bpf/test_xdping.sh      | 103 ----------
>  tools/testing/selftests/bpf/xdping.c            | 254 ------------------------
>  tools/testing/selftests/bpf/xdping.h            |  13 --
>  6 files changed, 557 deletions(-)
> 

[...]

