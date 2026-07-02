Return-Path: <netdev+bounces-304127-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jybXKTJGRmpANgsAu9opvQ
	(envelope-from <netdev+bounces-304127-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:06:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DDA6F669D
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 13:06:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cloudflare.com header.s=google09082023 header.b=dsKrAud1;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304127-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304127-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=cloudflare.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76F7D300C32E
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 11:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202E43D9DA6;
	Thu,  2 Jul 2026 11:01:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F33CA4B6
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 11:01:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782990110; cv=none; b=mgM4ELy3w1Fnyr+YOxtSg9z9wint2ZkMaPNk1pkoFmCHG/SS2dFIcfqjCgj9QP4ckgrNkcvygTpaQT2OW4DJ6QjgA4LOyRglJ/Zyo9WU5kIH+qHRsX7K34E1SM8cdkWAXyImTUa2vqyQXpGrt8VAQQ7EKRf3RRHybFo2QuQUv8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782990110; c=relaxed/simple;
	bh=LwEPgX1FY6tnbKgNNa9uz7DXSwqHQTt/mWky3yxefIA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tsZtXEe/CSjn75q2BNOujmoCiECCdcdoMeia5eFcp6+Kw+OrWRdlz/wlZUmEWiVgQGbjghZXfPD+T77ejXuHNi5Apo4KVZLknyu0/MvVp3jvk2NGm/tMqV2XKUF6KnQtvE+w0ieQ5cbSvGbhvmdSH03MSxYmUJx3mQu4tdjXp5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dsKrAud1; arc=none smtp.client-ip=209.85.218.45
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c128cc012b4so69950766b.1
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 04:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1782990105; x=1783594905; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LwEPgX1FY6tnbKgNNa9uz7DXSwqHQTt/mWky3yxefIA=;
        b=dsKrAud1JIb9c4yWvHtVsMPm3dVUF8ZpguWPMx6ePTrx/iaXTI80WLLbHZzUce0yR5
         Vgzbzh9FRB2/FkaPXoHNspLFbdw3kuG5mMJVRG4H+T6oyq2qgNd/FOFNCJQbjaEFGgpa
         LOfkPpese5ABd9E7Hd4Rn4wQxthQZaFGZQhs5pgsovBBol+5knfxn2fwFOWyVmiQP714
         kk6RKP9Nq+gUY9b8HyKnmNbMXUIQAijpLnVJqO6+8szCMOBjFp+nAD+H1GzD9QBIvdW0
         cOX3NjJfZphGB+H6wxfzpMr9F96JkrpW2D49ewAabZdW0wcozQQrgR/xniHwb/FZSDDc
         /uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782990105; x=1783594905;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LwEPgX1FY6tnbKgNNa9uz7DXSwqHQTt/mWky3yxefIA=;
        b=lQqSLmyNkLCTTmWW/do52zwgbceYoF7A79AJXeT4NNeQI1pC7DgMgMQTQtB9O1PJD0
         sKe1hE19Y/h/ciaGBhsZu3otdhSlnMo+eiRzhQgtUG6AlME718N+1GYkr8/mBhpbh+1K
         QupXVp4cPggCus/EAXcXmseA2KGNROGQZZ7hZjs5VU/xMqrEQRJQIoJltC1DWm+Mg0Vc
         pBVcRIhoe1jVBCXWyoZXcJlhm9ter+v+Fus94czDlcE7gaK74a8renjX6rkpyHWYvPS2
         BjImZmdxecnaBi0Cuk9ePtG3lH5UWSv/ZQq6h2cDqXOCrwPQTeefhAs3azH0jfMTYTGv
         kx+A==
X-Forwarded-Encrypted: i=1; AHgh+RpoVGHhHI98H+y3MFox21CpDgm+kSfThv/vojEz3htFPFsx5yKqKO+PCKfC8SfD2n0qBoFyiyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEQcbHXLT/8cOezIwbV7QzCFW4tk/1WTZTjXPBd2jB2YH6xSm
	BQoCNohlFD9yGEMYEnSRyor3l6yuVo0whEWJUMUpAk5ukOh2laqZ3dNnyMNb/P/K6SA=
X-Gm-Gg: AfdE7clUTE1D3Q5zEV5bG8KGgNNemlxFWM+SMbQNuzS5qAa3MXgVdphjOtnnrSfz7+5
	Qgg38flA1ytaznieGMQrHbP6OxJD/QcsDV2dkcl0ZHkCRdEuFJML4tSRGQgFDgbVR5QMTOHeWzK
	XOHPnxoOELx2h7QBymN0zwPaGIxbishYbC+gHgSAPP2o/2YDO/+neTQJJuewESMgSdrHf/vBijr
	l+jvwzBZpOLOeztUSqvBC9IS4Sa654P3cjOD8pdh6ZQ/zHhKkudxFifmcsIagHNVq2XYrfRb6sb
	mqMyikfGJ34q6eGjO1Qtl1Zi/IzqrUqdzQgmjD2kY+ZGAFzwhwKW3Tk7lVbO5O2Y5Cu0K/CG7CB
	BMhYolthm3YCc7y0G2ZL6zIyvSH3qe2aGcnKA2w9FcBs+54BulziJkMFYEvLYbqOqSHbqgR1oS/
	wYl93XrWFlC6eEgWY=
X-Received: by 2002:a17:907:3f1e:b0:c12:7b4f:cd5c with SMTP id a640c23a62f3a-c12a7b4b3f9mr274460366b.19.1782990105568;
        Thu, 02 Jul 2026 04:01:45 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b60f5e1asm108533566b.27.2026.07.02.04.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:01:45 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Eduard
 Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya Dwivedi
 <memxor@gmail.com>,  Martin KaFai Lau <martin.lau@linux.dev>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  Jiri Olsa
 <jolsa@kernel.org>,  Emil Tsalapatis <emil@etsalapatis.com>,  Shuah Khan
 <shuah@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Jiayuan
 Chen <jiayuan.chen@linux.dev>,  Eric Dumazet <edumazet@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,
  Willem de Bruijn <willemb@google.com>,  "David S. Miller"
 <davem@davemloft.net>,  Jakub Kicinski <kuba@kernel.org>,  Simon Horman
 <horms@kernel.org>,  Cong Wang <cong.wang@bytedance.com>,
  bpf@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH bpf v3 4/4] selftests/bpf: Fail unbound UDP on sockmap
 update
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-4-ff8de8782468@rbox.co>
	(Michal Luczaj's message of "Thu, 02 Jul 2026 01:28:22 +0200")
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
	<20260702-sockmap-lookup-udp-leak-v3-4-ff8de8782468@rbox.co>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 02 Jul 2026 13:01:44 +0200
Message-ID: <87wlvd1wpz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304127-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mhal@rbox.co,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:shuah@kernel.org,m:john.fastabend@gmail.com,m:jiayuan.chen@linux.dev,m:edumazet@google.com,m:kuniyu@google.com,m:pabeni@redhat.com,m:willemb@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:horms@kernel.org,m:cong.wang@bytedance.com,m:bpf@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_SENDER(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,linux.dev,etsalapatis.com,google.com,redhat.com,davemloft.net,bytedance.com,vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,rbox.co:email,cloudflare.com:dkim,cloudflare.com:email,cloudflare.com:mid,cloudflare.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37DDA6F669D

On Thu, Jul 02, 2026 at 01:28 AM +02, Michal Luczaj wrote:
> sockmap now rejects unbound UDP sockets. Adjust test_maps. While at it,
> check socket()'s return value.
>
> This effectively reverts commit c39aa2159974 ("bpf, selftests: Fix
> test_maps now that sockmap supports UDP").
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

