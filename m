Return-Path: <netdev+bounces-298876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5V5SFT+0LGp4VgQAu9opvQ
	(envelope-from <netdev+bounces-298876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:37:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEEE67D742
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 03:37:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CpY886Fr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298876-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298876-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D8B0F3017E4E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F307A381B00;
	Sat, 13 Jun 2026 01:36:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B6E39A7F5
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:36:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781314618; cv=none; b=NRnoFDN6ak1CMNQ/8DL40FHvzkJPV7qHXNJHftPbuSBxqXs/kt554tmK/mpS88jAhASQkHH4WP5RAHJHYc0YikRQkHs8lcDgF4w5cP6It7G5IEzoSf5MgZJWmT3Olw/Zdgc7dpNW1sy3wZAj1E9AMCvaOCb58HIltQb6fwPhW+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781314618; c=relaxed/simple;
	bh=ATCD8YWcyycCwAf5daRrjVD1RP8gGZsuumqpfm7uutY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=U+Y+m7DIu+f3XpYleJExAioV9PZ5sCNO4NHsAfAh2cXH4ZhczaZjkoyJRolSE/NHDriHe8TmWTAiNP67ff1vw9DvM/JFwNZu7FPl8cTEamAq0i+dOe2tVuUw24eW95L2w0esaYSkEHr1cSuQ6HSKzluXWhcOu2zx/mgUC45pthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpY886Fr; arc=none smtp.client-ip=209.85.210.44
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e6deacafa8so1646325a34.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 18:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781314617; x=1781919417; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvfgZCv77btIU2CurjCFxTmu/1bI2beZuVQe8JJi27c=;
        b=CpY886FrNj4EQww+vVk87tNbyjOoMjx5GMiDePF0Y5cfPIi/mYw+Z5j18KHqIZZEbg
         FcDVvF609q7lA5/qi9oCQWCW/F0JTLseILy9f1ltPgHuI+ERjGzNq4trVID7nckeTiEB
         lcKYy7CuOQtxw0uLSNFJtBBqYZhraCvIM0i2GpgkCGt3IMvKQZhG5pmOwRGoFDizFjrC
         0j5mLhEc8kclUYhZE5PWjZLar0R1iPaX0IzytiUn2tQUaz5KdiQ18c6McNxBWis8E8zg
         ocTy7QMIm5+h12O4CGNre7BV46gPOqf+3Jng+FbkUF/Gr+3vBXrpw2cD9ivkz806XQEi
         c7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781314617; x=1781919417;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uvfgZCv77btIU2CurjCFxTmu/1bI2beZuVQe8JJi27c=;
        b=eTlxpBk/WymiR3llTWEswcIZIGUG43kNOxHEE/0er9uVWHrLR3lRGBAEW3ytU2XVhG
         bI/4CDRb9DZwADU8rjxYAn1zjlNKdmkcQkwINhVUB4xIRXPMHncSb68/4s2chRPxx7P5
         W1rNSOPmX/deJ0yyEgp8MCNri/apxB7pQ/FRboa/I7LZjA0nXh1rLilP8Jjw2fARecLv
         a3FTRjndv77hFP3eoo4WgMfsaerX9FCDy06ZSE/sASASyAYnbHOruoD2l6Ne85+PNI88
         Er0lr24FAYYACeB1YAsvA7DjB4NUQMc3FNJ1ufRadmCERkJcahuh49GeefyVDP01h6fG
         y1YQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ejunkzJMwScfg7JAcTvMGK1cYRA6wLpXQG5TVGE6DkSw8ebzM5AMaCq9qu4zcWHhOXn0ITCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOpqR33FhqCcdeoGt8SCZ3s0kNAh2LVHw4heGLM+3GfbJsuISn
	Zb9hO7bwuRJWqNk94JIkJS4/b6u9ZvUXW0P4z8DU09iEDbi/77vXu6WV
X-Gm-Gg: Acq92OH1VScPiW1S9K1o/xSMRz8FQRs4jawi2RMVMj26U3thXSvRP5PUWq1RHJqyeF6
	HAr4Gk8RsZrNnHSFEb4bae1wQ0GyWMI3qz7x1al7+EUft2XieqvECiA09NsZTtJBQma91CjFpt0
	NWNorC6zERKxAH7WVBKP4EpD53Pb7csbw7N7DFmYIAHo8CpHDnvoBehXyfwan1Erul8OFg+LtV/
	//lunSd8V7iYF0uX+CKBJ4wzYcZTvyiU2ZGIOQhUH4FrE81Vwa2fe8n4rfVq23xjzCZKFFyfDgM
	CQywzrdSqjTkTAU7UWJBpUNyxiYm5y7B8Uc5Qf/RotF6oSL5RJHQ152LOpz5a1wv4PAunW6g1qp
	JJBsjIgzrlrtts/Oa3ElBM5lR4Fg6u8dSiivUB1JZn5aTWK56WRr3ZToe0+36HvxR61PWfXjEbs
	QRRIk886V7ZJUETHE46SniWjuRBzx9fdG1GBSAcJU0PPxOyyv7Pk2wldS37llYdu+/XgKOz0xnL
	YH/eKe4BFlKV4Or
X-Received: by 2002:a05:6808:159c:b0:486:cab8:cb7e with SMTP id 5614622812f47-4872dd9f213mr3099133b6e.1.1781314616544;
        Fri, 12 Jun 2026 18:36:56 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-487315b016csm2006539b6e.18.2026.06.12.18.36.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 18:36:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 18:36:54 -0700
Message-Id: <DJ7JBWTVOBVX.1YKW7ULLZC9Z4@gmail.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <bestswngs@gmail.com>,
 <bpf@vger.kernel.org>, <cong.wang@bytedance.com>, <daniel@iogearbox.net>,
 <davem@davemloft.net>, <eddyz87@gmail.com>, <edumazet@google.com>,
 <emil@etsalapatis.com>, <hawk@kernel.org>, <horms@kernel.org>,
 <ihor.solodrai@linux.dev>, <jakub@cloudflare.com>,
 <john.fastabend@gmail.com>, <jolsa@kernel.org>, <kuba@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <martin.lau@linux.dev>, <memxor@gmail.com>, <mmmxny@gmail.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <rhkrqnwk98@gmail.com>,
 <sdf@fomichev.me>, <shuah@kernel.org>, <song@kernel.org>, <xmei5@asu.edu>,
 <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 3/7] bpf, sockmap: zero-initialize pages
 allocated in bpf_msg_push_data
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kuniyuki Iwashima" <kuniyu@google.com>, <jiayuan.chen@linux.dev>
X-Mailer: aerc
References: <20260612130919.299124-4-jiayuan.chen@linux.dev>
 <20260613002906.1336958-1-kuniyu@google.com>
In-Reply-To: <20260613002906.1336958-1-kuniyu@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.15 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:andrii@kernel.org,m:ast@kernel.org,m:bestswngs@gmail.com,m:bpf@vger.kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:hawk@kernel.org,m:horms@kernel.org,m:ihor.solodrai@linux.dev,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:mmmxny@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rhkrqnwk98@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:song@kernel.org,m:xmei5@asu.edu,m:yonghong.song@linux.dev,m:kuniyu@google.com,m:jiayuan.chen@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,bytedance.com,iogearbox.net,davemloft.net,google.com,etsalapatis.com,linux.dev,cloudflare.com,redhat.com,fomichev.me,asu.edu];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CBEEE67D742

On Fri Jun 12, 2026 at 5:28 PM PDT, Kuniyuki Iwashima wrote:
> From: Jiayuan Chen <jiayuan.chen@linux.dev>
> Date: Fri, 12 Jun 2026 21:07:47 +0800
>> From: Weiming Shi <bestswngs@gmail.com>
>>=20
>> bpf_msg_push_data() allocates pages via alloc_pages() without
>> __GFP_ZERO. In the non-copy path, the entire page of uninitialized
>> heap content is added directly to the sk_msg scatterlist, which is
>> then transmitted over TCP to userspace via tcp_bpf_push(). In the
>> copy path, a gap of len bytes between the front and back memcpy
>> regions is similarly left uninitialized.
>>=20
>> This leads to a kernel heap information leak: stale page content
>> including kernel pointers from the direct-map and vmemmap regions
>> is transmitted to userspace, which can be used to defeat KASLR.
>>=20
>> Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
>> page is always zeroed before it enters the scatterlist.
>>=20
>> Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel=
.org
>> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>> Tested-by: Xiang Mei <xmei5@asu.edu>
>> Tested-by: Xinyu Ma <mmmxny@gmail.com>
>> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>> ---
>>  net/core/filter.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/net/core/filter.c b/net/core/filter.c
>> index 3e555f276ba80..6e345ca65ca14 100644
>> --- a/net/core/filter.c
>> +++ b/net/core/filter.c
>> @@ -2832,7 +2832,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg=
, u32, start,
>>  	if (unlikely(copy + len < copy))
>>  		return -EINVAL;
>> =20
>> -	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>> +	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZE=
RO,
>
> This is a red flag.
>
> We have a bunch of KMSAN reports due to raw/packet sockets,
> which requires CAP_NET_ADMIN, and leave them unfixed although
> some people attempted to "fix" them by adding __GFP_ZERO to
> __alloc_skb().

yep. It's a bpf prog responsibility to avoid garbage in the payload.

pw-bot: cr

