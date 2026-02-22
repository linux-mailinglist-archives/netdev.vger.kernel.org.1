Return-Path: <netdev+bounces-259883-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFhoDAclm2notgMAu9opvQ
	(envelope-from <netdev+bounces-259883-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:47:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AD016F910
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4D4300F9C9
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 15:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7AF3563C4;
	Sun, 22 Feb 2026 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxM9Kwdo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3C5155757
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771775205; cv=pass; b=GWSdDU2trnehYvDgt0phlktb5uNaCCsU19I1dbqPJ8zpXFmH/4MNwohU0F03fqbUP3D58XuYdw5JwnzsspwIe4Pq3KW/X0tTaKn/R/u/PGXvfTPfllbcbFG3KI7+PDsBh2wE/o1JujxYHfF/buHSL3Gq2BGCDWyI9gXikufhJOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771775205; c=relaxed/simple;
	bh=HhdgCorp/O+ExPrtCNffOENjmZnGij2cf7NKpiBIAB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p7fetSzDzJnlAKPXovfUgdFlya07rkjgouQsxJlXdgPJp+29EnNOb7BHuYsFRxdm3rTS7pqMv8rArpoiVJWqLhBjymz8WFZ7WkexRd/OHiG1Zei+7eSKqcIx16lvHWAWKykgD/ZPfcZRfzGmEQXbpZ7RbHfdeZyyHs5tffqbSyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxM9Kwdo; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so3291583d50.1
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 07:46:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771775203; cv=none;
        d=google.com; s=arc-20240605;
        b=CdU0MnVlGoJoA59LHQbZg6Ftw00iVHBAfoN1MwEmwW6ZHZuRGCyz0KFAy46A3Zbs1H
         YipXxe4uo86ldPtoPPj57/i1WQr4QSzqA7zc8puakgzYuhiNfeA/aHJZzIb/8+hvHra3
         gBzIRWbeKFuRcBbZTq/r/zJr+5VsrZh1KXdnyWJYsJ0d3o/yTw3lpFv0Q0OzeLhrwLwO
         dIlZD3oM0dtkUQL5+loYxtr1lXW4Z+GYJd9MxoBO4RJbOwfLd7n2W2G6FAB91aUY9mHB
         ddOWUNTyz67lHqTdmuSFkR49i+jF2r9mg8KxJSAwIROgwmrJsdbVinwfAqrKkV60yb+h
         p+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zwTBoJ3Pn4xkTqYfm7fRIA7skG6IW30Ne8ev27Pq0gk=;
        fh=9h6HdlM7ihk+dTQoVsopk8wwR3LpLQAgcTVmtL90lyY=;
        b=ItMQk2NAoS/RhhGHkwOBNfeJqIZ1hM+EDyMM80SCGoX2+7KbpD6qGMbOqfsTJqmh9+
         0skLMpX9jjVXEziDWFcoAmNA0X4cRaBBxy53V74KZ2eVeLodWradlzwkKth5U2+QUZjP
         n51SShguPHdZg9a0tB0muN/wEzf9D1xd2NLLXVRNCwdvguQRLpscWCRMV7AGjgDTrbS8
         ruN/qo4xX7GQb+KEITHE+s+s8+DDFFW5ZT5r2HKChiGlCI3gyTig5QJC4/vvVh6FTWmy
         FHG5Hc2XXWyeuyvSScGgMKqxvrNf4ZYt82D30o5RFtXdXcS4gPOKk9A8smGojJip+fXG
         Y5/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771775203; x=1772380003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwTBoJ3Pn4xkTqYfm7fRIA7skG6IW30Ne8ev27Pq0gk=;
        b=lxM9KwdoEThpoy+Oco6qibhyGSGs9JKLXJmy+EQ4IjSs9zvdn17wdLPVo4Nvb2IM3R
         75H2b2uDGtlVmQSLQUh9gjqke6Ip1GxpS23Ynll16qkAentnqJhEKe7OLY8tXoqlsiDX
         bFi2modf7Z/eQXOCEsgORKBXTvOUk5il8f6UIxoVxHNSsX1Jet1s0WxXKNUBXeKkNY9e
         TQg2jeqkp9dEQK1w3bFbVT106a8l1Q9g3zKx2jtACOouBhkLR7p1FbDnUJBHfjyZ+TPf
         8U0iW9yntx5PPxbv77wBo/5BZ5IcVOyeZVyt7+1J2GcyOAFFLuCCZp73KH/JXi1S9MRf
         whZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771775203; x=1772380003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwTBoJ3Pn4xkTqYfm7fRIA7skG6IW30Ne8ev27Pq0gk=;
        b=PrqpBjrqkGYc7n9SbqULZT9cR4nldqM+ooSbJ/0gGP5EJKOwAfYQDXnHi/Z/mCGqcC
         Sga6s0L/2L3QUFkDAq6xxcBS5p0wH0ZQrjshNFf83qKSmQZe/XztJHOxP7Yh/9Bb61hS
         Nt4Xhtmcwvda48MSrXP2EmZxmH+vE/r15rOHi1BMkvJoFdQLwRYpC5CNRYTGp9QrCTCy
         uvdTy57AbxID/I2+q2RjvIcHXP+Aa+YoKWp0ZC/ymR6aKgUJwwrRJunE1YnpdY+fj7KV
         LgBCQFkCCgLzVNhy0/+jTSA5NW+hxheYUAsL/Bed2LojwI6N0iKLb8VBbJgWNF+3pHkN
         yMQg==
X-Gm-Message-State: AOJu0Yyw46HthwKdNhj97Q0Q4Rk9K9744kiA7zaWG1GiBbF9vRgzg+vQ
	m1WbGBa95r7XKe4fVVrwt8mrTHQTHTXtSOancoL1FtKTz91UsHTlozrwvu/IxI78A4I7jarDP25
	5N1j8kC2NZsETygtd2/ukvOqGZ+k1WXw=
X-Gm-Gg: AZuq6aIdqEPm1pvcUSvDeKFDL63h9J4kcLD8WPso1RWvYQL2Qht2YGSHP6+4ICTr+pt
	ruapvVNYWTh9wS7KTduqdBzueb+QqFei6C9RCTKYwZlP0CZ3ND5CUlhiyavrEi0oQ7yMgbvrm6Y
	LY7ozhrcL3Eu8MoewlmzNczahvnuk6DZqx4OIiynhEC+fzbD3RHzAPM12CkycEVONiEbkwtMera
	vdfNoldOHYaWdWvLocdbpvDi4qBYPRihEKCE5xZnJvRKUhghZRI8dZesJOs6X3HYHatdrxWZ5Ht
	5idva0KIunrbVWlJYUI9Aetag4VJEr3c5xdH7A==
X-Received: by 2002:a53:d00a:0:b0:64a:d720:f247 with SMTP id
 956f58d0204a3-64c787d5bdcmr4823133d50.26.1771775203586; Sun, 22 Feb 2026
 07:46:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260222010820.8994-1-guschin108@gmail.com> <20260222131156.GA53543@shredder>
In-Reply-To: <20260222131156.GA53543@shredder>
From: Vitaliy Guschin <guschin108@gmail.com>
Date: Sun, 22 Feb 2026 22:46:32 +0700
X-Gm-Features: AaiRm523XD4gIeg2H-V8R7uxOI2zJHYIUiObe0in0oOUJJiu_m-PipD60WgGDn0
Message-ID: <CADpPVw7ZULL_yF0LWO0QP90xcaLfZWJzAqqZW=1BkRc4HvbufA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ipv4: add lwtunnel hash to fib_info_hash to
 fix mpls collisions
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	dsahern@kernel.org, edumazet@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-259883-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guschin108@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 86AD016F910
X-Rspamd-Action: no action

On Sun, Feb 22, 2026, Ido Schimmel wrote:
> Did you consider using the nexthop API [1]?
>
> It doesn't suffer from this problem since the nexthop ID is used in the
> FIB info hash computation and it does not require patching every LWT
> family.
>
> [1]
> # cat lwt_hash_nhid.sh
> #!/bin/bash
>
> ip link add name dummy1 up type dummy
> ip address add 192.168.1.2/24 dev dummy1
>
> rm -f /tmp/batch.txt
> for i in {1..100000}; do
>         echo "nexthop add id $i encap mpls $((i+15)) via 192.168.1.1 dev dummy1"
>         echo "route add 100.$((i>>16&255)).$((i>>8&255)).$((i&255))/32 nhid $i"
> done > /tmp/batch.txt
>
> time ip -batch /tmp/batch.txt
> # ./lwt_hash_nhid.sh
>
> real    0m0.467s
> user    0m0.109s
> sys     0m0.347s

Hi, Ido Schimmel.

Thanks for the feedback!

The nexthop ID approach works well. I agree that using nexthop ID in
userspace is a better way than writing patches for each type of LWT.

Please consider this patch withdrawn.

