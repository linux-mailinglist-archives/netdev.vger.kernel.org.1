Return-Path: <netdev+bounces-252726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJ75ABo/c2kztgAAu9opvQ
	(envelope-from <netdev+bounces-252726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:27:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9434F734CA
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 10:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7ED463008D57
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 09:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CA035EDBA;
	Fri, 23 Jan 2026 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w3RPI3U3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFECC358D20
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769160431; cv=pass; b=Lhtv1H6JRzSBwJn5ggaIfXYdOSNhRIWJNqTYa83b1ZrEwnvCQxbMjcUckngpb92JV1VAa/gLGFVYXq1IyglbDl3avTB5IBDKKwF1BNSc1Pmg+ii+a73/OTcs9BOgz/y3Vqsv8Nsp7B6iMIHk9EZhgWyGPSZP3ynuk+w5HNcGyPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769160431; c=relaxed/simple;
	bh=w8hq97EQwl5dhlk/5FV8sd+V4sf5CcfJKM0ld9PZmVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DnDoRatjdojO8NSDWG907WzX4qi61B0bJY6Is23ik2YL46f207Pk3Nt5zXRIgmIuwMLJ66KNfQQSKAOMqb8Nld2xzTGYZjyE4ahe9qjWvgBLMMkbGYi6qCh81EZs5I9vtaRMTuKUateeKrB/GRunAC7M2RnD7KqRR+JXQpE6GiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w3RPI3U3; arc=pass smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c532d8be8cso198337585a.2
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 01:27:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769160423; cv=none;
        d=google.com; s=arc-20240605;
        b=bG2bKYxWXeVUJPmNisx1lTp0hs3uh5qlHSkRlPvNryqCASIPCvt2zY725Qy66VH89I
         ONKU58OWjQErSm6181BRXZszIDhlMI8JbbOL11nyj72Vtjd5p20HrPreVRFVWFWiXtPj
         I/G+vuYBH+uoMpoHpzEbmrxOXN6V7yzpBXBJXXlp4jIsvQ/QX8TfdUYnwB1+FUYcIs05
         WeHvJiB9xEuqXpxceF9lAgMMOd81tvlP/f7epYt/YE/Jbf6wKq8wZRT7gP5UJApt5kcE
         ttU++Y0RSATg4bxs9afwYHVMXLRithsCOM8FqNGJFkhUxUnvFkESdzARMtypQKTE6QDx
         w4Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w8hq97EQwl5dhlk/5FV8sd+V4sf5CcfJKM0ld9PZmVE=;
        fh=AzMehnrLgcowE7E4KyAxtZORLdrDK2ok9CpDHENPk10=;
        b=C7cBTBCRUVenYe1La7zyom5yZDoywtGRPxAqj6JuA2YzjgajT26d2kTSxGwHMwAAcA
         zWMP549xyqAVqBjHTWCJxRO37X90+EA2iRZSRMWffRS3dHOT+3JEdOPBxz3907GGNU62
         zAGxS76ORx4IOos45N+BVMk1qC+0irbKXF4VqQAPAoPKd21WmMxRXQO/wG41hXMVDocF
         cOJZBO3M98UjWCOCcFUAuSBggqPHiJli+90Zjza1N6rejj+3V4ogL8R/sTEs+XDmOHCh
         8WmaUviC6nlRNgEEdoKYGs4uOx0Oa+qMrGNfwsQry+I6MYZh1pxJvs6DJPCw2arAZc/H
         XG8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769160423; x=1769765223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8hq97EQwl5dhlk/5FV8sd+V4sf5CcfJKM0ld9PZmVE=;
        b=w3RPI3U33+I2a+zzV9Tl6r7pHs1QkWzzGwCZKr4Nnh2FNASXzBCHjD+uyJNdLce7Wd
         wJVJLJpuv07tj8/1n1gJ+o9nTEDzAZ1aTu5JloPdDBvpZbOpqr3azyjUVCs2b6wtws6W
         bRiOIbFKKvWkmxmACbe90v0+6U0udyvvtiAbCUukNTTGFsoE5ujcehMFdLYceSs0JWHZ
         tpBcA5ddgbn3A/S7zJXiQoKo6vgWnDnnnm++lfNk6y5/PKr7Xn3oOskKf/DANwzaBbw5
         QGgqtkla4lIQT/wkpZkcrBdJNHKw58xnhtasIOhIW3vQAlpy4q2KhkuApgvsmmqQnfGp
         Y4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769160423; x=1769765223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w8hq97EQwl5dhlk/5FV8sd+V4sf5CcfJKM0ld9PZmVE=;
        b=kaxLhPc9G3oU02f3oW1grxBBHuShffTvM4Gs2Gqo88p4ZakuMvGdbE01rftglp6HnJ
         DJVUdcsaAO3vqEg3w4GPNDmc+8txkVmWrubv+HJjPC3tC1kQtmXzbXYkuKhyaeTySgSv
         u0NKxssTLiPkX425dYd07wXKueYpFu/Kso4eu/X6V5rpZ+it6xog467aHrZXlsIKOkJu
         D7aRkGU/8UaiQzc841vVyaB1WaEstUJ79hcxr7s+OIIo2hmsmMlBbxNLiPRYT220xIHI
         QREYRkj0kHV4I1zETuaPkVuXbbbq1schGEnFNw5TlxLJz90rxnk6Gy1Rc+2E07s4z+ax
         wqiw==
X-Forwarded-Encrypted: i=1; AJvYcCWlHdOXwZ0kXzydnbXbajt3U2heyvh6HURyIpueffpL7J5MQP9K27fOyhEJPW46jPamyuPCUyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVSo93LwVNdxQQ+VrCqi9dbv9nNNXh9LVfqP/cNuRchXUJtAf/
	mua7GwZ43vJ8xCCtF9Vn/fPaxpxzRHofMZxqEzUwTYq49siZ9fo6i7FhxldZplvK6K9pW5VHCQ9
	hR3zbjRX7xdODNvhd5sQ2uoLWigPyEO4bjtGGoLko
X-Gm-Gg: AZuq6aIammC6F+BBcycsQ6Xbomr/o4ziHC6k/W7ys7STEwyeUfhCrt2tu+MgdNcFFrm
	Pzf2Jwe/i1jc7DRUe6VWHcdq/jgNaAZ/T+dMaxIXOAyXQls3yNKrPhzNSImmK36xg0vCcSsvjd1
	KOfDrRNTEVk6SHQwjMQG3Y9wlvjcs5tMlFGp9t4tIRJHIt321+smH1H8Q0ScVU5+cxODn+67LOC
	Ndznlet8aKV4hMmZeJVQ3dPW9MLrqFpuMTiA6l9iGR4j3PvjxJrdkOkN/eAQXihcjsH9Rs=
X-Received: by 2002:ac8:5a95:0:b0:501:4730:fbe1 with SMTP id
 d75a77b69052e-502fe3c82c7mr6464681cf.22.1769160422872; Fri, 23 Jan 2026
 01:27:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123071635.16976-1-suchitkarunakaran@gmail.com>
In-Reply-To: <20260123071635.16976-1-suchitkarunakaran@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Jan 2026 10:26:51 +0100
X-Gm-Features: AZwV_QjvFtZdZ-77BDvicGfRvDsx3W505UbX9RO-fUby7USIq5PrNpAr77RM0Hc
Message-ID: <CANn89iL5jS8BP+eXe1HeOBNpzfmVgTAHROGBK0qCAKJxvxUnuw@mail.gmail.com>
Subject: Re: [PATCH] ipv4: ipmr: add socket type checks to ipmr_ioctl()
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252726-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9434F734CA
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 10:04=E2=80=AFAM Suchit Karunakaran
<suchitkarunakaran@gmail.com> wrote:
>
> This is the IPv4 counterpart to commit ("ipv6: ip6mr: add socket type
> checks to ip6mr_ioctl()") [1].
>
> Similar to the IPv6 issue, ipmr_ioctl() and ipmr_compat_ioctl() access
> raw_sk(sk)->ipmr_table without first verifying that the socket is a raw
> socket with IPPROTO_IGMP protocol.
>
> This allows a permission bypass where a user with CAP_NET_RAW can create
> a non-IGMP raw socket (e.g., IPPROTO_UDP, IPPROTO_TCP, or any other
> protocol) and use SIOCGETVIFCNT or SIOCGETSGCNT ioctls to query IPv4
> multicast routing statistics. This bypasses the access control that
> restricts mroute operations to IGMP sockets only.

Where has this been documented? An RFC perhaps ?

This change could break applications if they were unaware of such rules.

I fail to see how querying statistics could be a risk.

What about the RTNL_FAMILY_IPMR rtnetlink interface ? I am sure it is
available to any user.

