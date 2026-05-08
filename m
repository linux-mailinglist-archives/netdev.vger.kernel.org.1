Return-Path: <netdev+bounces-285905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD/QC8UD/mlYmAAAu9opvQ
	(envelope-from <netdev+bounces-285905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:39:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FBF4F8DFC
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 17:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40A383025BD9
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 15:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3933FE34B;
	Fri,  8 May 2026 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIZoeBwj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386DC3FD143
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 15:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778254550; cv=none; b=IpjGZqcwF83bXYOJGc7/4gpKj5wk2hjrCGCxwh8pb3bH9SrCr9fL9IYzzPe/4uoDu8/XbONEl2p5Udu0OrLMqVyT/8QLMowvwK/blMAqaUn0cGhqKbval3ub7WBrzcrTUJBvTk66NC2rzU7OoO4K6KDNH+X7G3tdI5U5BsApTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778254550; c=relaxed/simple;
	bh=+Sqrd3+qAMwXxnn7YbjPZUDRiBSpsfeWZG5do9th/6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmJbuNSWXN883SLdw/Ii109pKGB1gLdCgrodIWVtPPd6tFHyqd0DWPak09RQehpXYdsWHbAqIoa/o6x1e+Ic9LBXFBtvZ32Nk7k1q2TMP/z10kuIUPPu0wkg6Z8SObefesG7JYdSPAiVRNKaLimQBewfsj70HOlRlx3nvuj2dd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIZoeBwj; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3650453fb28so1409415a91.2
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 08:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778254548; x=1778859348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=13lGB/qr9bIuYWgUEqIjZKpDgkXvR7yqgv79HDTtvfs=;
        b=aIZoeBwjX7IC2U7N7E5A7mhosKQTaE+uamgxqB5LylqIFnmrXEnVXTNQWdRuzN7igc
         WqTjKj3Kfa4HGRVfuq8f3cBEpltpdPt2RjOtc5FO0YLpbFG7sVULXD3nz0/Z8IqXxl+n
         FgFrS8Wv4oJyZsyWk0gqsAof15hlrC33gXn0wBGIXQ+rmChFVyQGISdggWFGiovr9cUO
         /YLvQlrtAAd3Ip82X4S+kVqwUvE0sclV7sg4GdYN2NhIRHCy7kkV5QIyJ3G6ZquBqloE
         IhXjb2iR5TO1HrmU3BnOttRxp3VP2Xr48H+klu7pmFlKhHFt8xekBhhGK9paZhrE9XNb
         Z/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778254548; x=1778859348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13lGB/qr9bIuYWgUEqIjZKpDgkXvR7yqgv79HDTtvfs=;
        b=dGky3geZWWnxF1zWLJ4EfugX9Ye0fV+0hHWLmK31PiyctJLARvy+G4hKDFB6+OqTR6
         fA5M6q81wxzEnHgD5TLoS73psiWCTcDwe5ZDphINCTd8TudFsLHepQ8HPxnDSDrJVKe3
         vOUWi2Jk59ygskt6l5CjQXvyXRBJ8udZOIOi0dR4hKG4dEwqQx8gFfhP6n9wkWOdFl4C
         nkXY3z8Pps0s/B41nOGAerweGx14YN4XOMsReMygL6jS5Z4ECdJR8Eq9cbpAzOUOecnO
         2Hzwri+t7jcvkM7AMNZnkvzBalNCr5JFe9FRq7ptJQNwQ5Ig7ezTzYqNjr8kKtRcmBBv
         FnBA==
X-Forwarded-Encrypted: i=1; AFNElJ8mBOuwgzW8C23UVajI+0IaAIvwVGLw1yF2EojUyxzWbo/wZAuAGYchENoLHKaiunHEGoNHMKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCGCAb6Ic/Ua26tqVDfildrJlykAMF6/FKFrhNiSCXmYqDO50K
	tReOrzmHDCE9w7suRo1bZP+fT7/BdTYvwHDMNuAi7PkZeuv0ooD+uO1p
X-Gm-Gg: Acq92OHJdqE+FTqwRmw9XHbgAgBgJcq6T5dxJdhJjARV3pcyd/CUroVdeWXheMZjN2L
	/XAuObEkcJ/vsGchb3fX8V49UlWl2lS2L1JdNnJpLLzvL+ytWetFKx70Blf97lxIGs5hCFaX+a9
	4nYqiPq3bHEa+bKju5I5KV/FWy9l4yX7jTdXkah5qV/mT7PNXtoBmkNYzEE7JnXesfHu7htjm+R
	ehBf21Fu8evSZ63aMZsMJHHvYH2u3LWnyfvIAmH2rowPegDDSw6EAVrAC2yx+rAhMKYOIHIlwpA
	DZr226w3KKXqqlhCi+thmrVfbSOa9Nuql2cKmxcuCXVpiHzOjoB3/R4N60TMkImxLIwzERCbv9N
	iqQys4B9XUyvjXIytNVor9wbNideKe3iqAlkb1TnQQ7TswR+qpoEKiCIDjAStEeI9SwSX8oLDvf
	G2nCkNG2h3G9NOY18=
X-Received: by 2002:a17:90b:3805:b0:35e:b017:da6a with SMTP id 98e67ed59e1d1-365aa73cc81mr13780678a91.0.1778254548466;
        Fri, 08 May 2026 08:35:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367c1b6851esm119724a91.8.2026.05.08.08.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:35:48 -0700 (PDT)
Date: Fri, 8 May 2026 08:35:47 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 8/8] selftest: bpf: Add test for
 BPF_SOCK_OPS_RCVLOWAT_CB.
Message-ID: <af4CV5itdz5Dzwo7@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-9-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260508073355.3916746-9-kuniyu@google.com>
X-Rspamd-Queue-Id: D3FBF4F8DFC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285905-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/08, Kuniyuki Iwashima wrote:
> The test is roughly divided into two stages, and the sequence
> is as follows:
> 
>   I) Setup
> 
>     1. Attach two BPF programs to a cgroup
>     2. Establish a TCP connection (@client <-> @child) within the cgroup
>     3. Enable BPF_SOCK_OPS_RCVLOWAT_CB on @child
> 
>  II) RPC frame exchange in various patterns
> 
>     4. Send a partial RPC descriptor from @client to @child
>     5. Verify that epoll does NOT wake up @child
>     6. Send the remaining data of the RPC frame
>     7. Verify that epoll finally wakes up @child
> 
> During setup, two BPF programs are attached to simulate
> a real-world scenario; one is SOCK_OPS and the other is
> CGROUP_SOCKOPT.
> 
> While the SOCK_OPS prog handles the dynamic adjustment of
> sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
> BPF_SOCK_OPS_RCVLOWAT_CB via userspace setsockopt() using
> pseudo options:
> 
>   #define SOL_BPF               0xdeadbeef
>   #define BPF_TCP_AUTOLOWAT     0x8badf00d
> 
>   setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int));

Hmm, so you do want to have this enable-on-a-per-socket use case.. Then what
happens to the skbs already sitting in the rx queue by the time
we enable BPF_SOCK_OPS_RCVLOWAT_CB? Isn't there a race? Or am I missing
something?

