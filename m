Return-Path: <netdev+bounces-272699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QzSBJekcx2niTAUAu9opvQ
	(envelope-from <netdev+bounces-272699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 01:12:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D7F34CA66
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 01:12:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A645302690B
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 00:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F360740DFD2;
	Sat, 28 Mar 2026 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YG6yyyT/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66340DFA3;
	Sat, 28 Mar 2026 00:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774656742; cv=none; b=a4qNlQECKEN7V/WEuaoQnyCArMgePRgf5V1WZpz252tjQvn63FDfmGWDeDQ4G3XCJ71hgUAThgkfQXkLAyty18TQqZKoIGkirU8+Rd6SW+juMz7+gJQ7OMJSeVkZRutZiz5y9zRQ/Pozrp5vKzChcB+2uAsW5MsaQTEwfHapJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774656742; c=relaxed/simple;
	bh=xI4UmJEnokRASbJcfMS56GK0lMPnJmKS4svstiEkqQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2UwDtvUktLwDZMbFxN8eHYpTqtN+rzRhCioVcsOVF9cU/6SqN7jUwZWSJBZ5eSxLl/YA8cOeKc62VLYbD3lOeBk7zvFTvOBPlowFX5zTTmJ6MELLMmKLY4PRMnhnjDbsbEmP4lJpr5q+oUNcXiHMpZXvE/02jQ48rXabIgZz+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YG6yyyT/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97597C19423;
	Sat, 28 Mar 2026 00:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774656742;
	bh=xI4UmJEnokRASbJcfMS56GK0lMPnJmKS4svstiEkqQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YG6yyyT/teC+XVHylGg9uEGmj9oNdUXrQXFAxZkU134QrjTqNT6dcPvsxALiLiAjw
	 sEDGzZImGyYamQ9V4erm/hxnYgLYNv+sra22wk/Kicxw4Y/sqBJK4HMIw79yRJUL4W
	 flC0wEClK7JdJ4i1joKF3EiEmJkBM12BdLS9XSIYzyZDoXjihT8jn4pl045bhovY8n
	 sb/Bpeo3qHlSDGLYVbvq9yj/EH1b22lad4kU7PbTGTIMVDmDG93wrycitv74Zoohxp
	 YHCnGcAOu0dYJlXD1gOhlAwtNhDdM3qqq1ZcT/S+ms6BJ2Xsfl/FqzFFHwzb3ibcvp
	 NTvju/PDEfw7w==
Date: Fri, 27 Mar 2026 17:12:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Toke Hoiland-Jorgensen
 <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
Message-ID: <20260327171220.6d10d710@kernel.org>
In-Reply-To: <785e0b04-91e4-457f-8d6c-e0a911c0fd88@linux.dev>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
	<20260324150444.68166-2-leon.hwang@linux.dev>
	<20260326124205.1a3bb825@kernel.org>
	<785e0b04-91e4-457f-8d6c-e0a911c0fd88@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272699-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,davemloft.net,redhat.com,fb.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21D7F34CA66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 27 Mar 2026 14:42:19 +0800 Leon Hwang wrote:
> > It may be worth adding a selftest to
> > tools/testing/selftests/drivers/net/xdp.py
> > which sets MTU to 9k, tries to attach a non-frag-capable prog
> > if that fails attaches a frag-capable prog and then checks if
> > replacing the capable prog with non-capable fails.
> > Drivers may be buggy in this regard.  
> 
> Do you mean adding these two tests to xdp.py?
> 
> 1. Verify the failure of attaching non-frag-capable prog to mtu=9k
>    driver.
> 2. Verify the failure of updating frag-capable prog with non-frag-
>    capable prog via libbpf.c::bpf_link__update_program().

Not directly via libbpf just ip -f link, it uses libbpf internally
but testing with  ip link is simpler. Also - there are already XDP
progs which return XDP_PASS in frag-capable and non-capable mode,
so just use those.

> As for test #2, it may require a helper to attach prog then update prog
> using libbpf's APIs.

See above.

