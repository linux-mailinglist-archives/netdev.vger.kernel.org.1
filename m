Return-Path: <netdev+bounces-275500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHo+Ai/10ml5cgcAu9opvQ
	(envelope-from <netdev+bounces-275500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:50:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC93A047B
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 01:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C955230068FB
	for <lists+netdev@lfdr.de>; Sun,  5 Apr 2026 23:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD64383C96;
	Sun,  5 Apr 2026 23:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="G2kMGy6p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD142192FA
	for <netdev@vger.kernel.org>; Sun,  5 Apr 2026 23:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775432996; cv=none; b=Yasux/5INNYXfyuqHAvXbPCflW7p5nTtsGictUCFKHCZyxQpI/Rt/XKz6QHoMUmOYOgToonuoeRuZaBpZ1SXh/PeVjNvTuoNJ4q7ZzB3r5zsfuSvJTf2XElkBqOYSGSx1nJSFJgklATOBES+QWNUn9gXd1h+4FRoU9Q+RLeCtZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775432996; c=relaxed/simple;
	bh=UuxRCYBnHXVCIUC2lYpysNUxFrS3xTL1sRQnQsBThTI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=dhb8a3KZmB2FFfkA9Q5aw335qd53MtKBh91oJUlUbLnWBxOjgLPS0bjtZwV9HPfOaTdYz4gh3Nii06JpJqeg13G7V7rQOYRloEpoqzHA5Z8qwXz+co4ZxRnYvN9UD/HsMtzh3F95f02iWyWYoT3t4pTsHGW0GhBNJI0PSv7b/iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=G2kMGy6p; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so3053367a91.3
        for <netdev@vger.kernel.org>; Sun, 05 Apr 2026 16:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1775432993; x=1776037793; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUZVBN2VN4vnEw4Br5X4PEYZMIf8IsAQPOGK1gD3tCE=;
        b=G2kMGy6pTcYp0CwkVO8L3CE0hricXF/suYcSyykCS+BPxGgSDM+3c8h0KqccPejTe8
         ++gKJUAF9thas8dat8Mz//iUeIJUTMuCJn43PpPDo/OGVwWine0I617zjj79E3fwCp7O
         /G7ZnRimr+1+cjxcIyAriRA+OUnYk1DQVlEBmG9dVn3ldNmVDzBH6oJpCCIwvR4p/Xvb
         eGtzJO2o5T1Z8C42QhLWyrEu7A+JPL71qp2k6DL43/MxCfccVit1PWiad5yckV0+Zxy7
         7jrO6+dy72lPkS53TNDcQ3qJSZy+9I8W0VdQ9qXSsrOLTC4q0gTtYHHzEwguCL7cmxjG
         TDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775432993; x=1776037793;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XUZVBN2VN4vnEw4Br5X4PEYZMIf8IsAQPOGK1gD3tCE=;
        b=hQG6Cv6lfVPzzQ9yDd1cd1s1MlyVMjeavl3sPVI9YEMnFGt1FDulmk2lPX6ZXcG/JR
         tX9EBOVMlpU9NAHfpd8UIzDTx0hAHES/lub0zl25jKcR/I0EFt0A2RG7uXG/GIX2z+QU
         iYj5puHwcRssPwGpChvwb//5V16tPzKpF9I7krK4KaxEZ6Yf8GIl/Jm5hoWONwKdwktq
         EhBe7pY4L1uEvxLk9UcZhYtr+UD8jIo6azNXMA9e9lYoHTxnRvEqf1Uh1F6iA2qQK4h4
         AjuBJBZK0o7jJHJLgp2pUkOhqhCRPYP23+QEbcK3Z6PdbLOMZpyTfNq6gNURKK/RG8Y7
         JAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG5YaAQ4Mlt0kWu+x3Kxx+0q5zV3Dk2i6G6XEwvJYjSN9sb6OWbLo+g5ai2yXG7p0AE9kzJRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2cOq341s61GSTe9DAcoUkF0dJsTa4q81AN+3l/1q+w1uUvmyQ
	IsVgjCpCCGCp9BprI3n7jpPMqv9x4/cmxFMWzVFIL46Es6xutSr6zvd4PvV8wytaSEg=
X-Gm-Gg: AeBDiesiHuSVdMkvUjczazb6pMTjWXkRNoquqslzK70SguekG0zgD9HRkgUHGBGdcZf
	VJ6mEOv2i+BaIjUETG10TqGstFoUi23mZcdGw4VkNRD4aAu2KIUSI5no6LlMh95l/vXqwU3dfwR
	nQWX2TXGCiorrJryxDWAYHgCPHEUqsb+scH/yz+Ttb4GKWkTc5hZ9vmgLn9lwBblinUtV7KwftL
	8DX0hbeyqzYUslDGkmwWlmQ9PmnZCS8jKkBMd/GrYz4RBNNJsnkJU4SOgjQeqO5wIPJdTAGgoMc
	WjTOWSLnRRV11Lg5Kk5CdtJ67tB3+2GFw5v/vWxulEiXH2kQg+jG+5XKRA+06Kr98+MYEWjJlO9
	09vWosuQ9N/fA0T6gQm4mhd20V+97KaGCkhwZRNEE+P2vtCp8639+rtxn2jFg+p4R5dZ1sWlKu+
	/C/UyD+Y8=
X-Received: by 2002:a17:90a:d403:b0:359:3426:c60a with SMTP id 98e67ed59e1d1-35de67da841mr9588504a91.4.1775432993231;
        Sun, 05 Apr 2026 16:49:53 -0700 (PDT)
Received: from localhost ([2604:3d08:487d:cd00::5517])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm21338044a91.10.2026.04.05.16.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Apr 2026 16:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Apr 2026 19:49:51 -0400
Message-Id: <DHLMGWNKBI4K.3LM87NOU4XB3O@etsalapatis.com>
Cc: "Quan Sun" <2022090917019@std.uestc.edu.cn>, "Yinhao Hu"
 <dddddd@hust.edu.cn>, "Kaiyan Mei" <M202472210@hust.edu.cn>, "Dongliang Mu"
 <dzm91@hust.edu.cn>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Stanislav Fomichev" <sdf@fomichev.me>, "Alexei
 Starovoitov" <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix SOCK_OPS_GET_SK same-register OOB
 read in sock_ops
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260404141010.247536-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260404141010.247536-1-jiayuan.chen@linux.dev>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275500-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[etsalapatis.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[std.uestc.edu.cn,hust.edu.cn,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: B1AC93A047B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat Apr 4, 2026 at 10:09 AM EDT, Jiayuan Chen wrote:
> When a BPF sock_ops program reads ctx->sk with dst_reg =3D=3D src_reg
> (e.g., r1 =3D *(u64 *)(r1 + offsetof(sk))), the SOCK_OPS_GET_SK() macro
> fails to zero the destination register in the is_fullsock =3D=3D 0 path.
>
> The macro saves/restores a temporary register and checks is_fullsock.
> When is_fullsock =3D=3D 0 (e.g., TCP_NEW_SYN_RECV state with a request_so=
ck),
> it should set dst_reg =3D 0 (NULL) so the verifier's PTR_TO_SOCKET_OR_NUL=
L
> type is correct at runtime. Instead, dst_reg retains the original ctx
> pointer, which passes subsequent NULL checks and can be used as a bogus
> socket pointer, leading to stack-out-of-bounds access in helpers like
> bpf_skc_to_tcp6_sock().
>
> Fix by:
>  - Changing JMP_A(1) to JMP_A(2) in the fullsock path to skip the
>    added instruction.
>  - Adding BPF_MOV64_IMM(si->dst_reg, 0) after the temp register
>    restore in the !fullsock path, placed after the restore because
>    dst_reg =3D=3D src_reg means we need src_reg intact to read ctx->temp.
>
> Fixes: 84f44df664e9 ("bpf: sock_ops sk access may stomp registers when ds=
t_reg =3D src_reg")
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/6fe1243e-149b-4d3b-99c7-fcc9e2f75787@=
std.uestc.edu.cn/T/#u
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

This patch only seems to fix the problem when dst_reg =3D=3D src_reg.
Why is this not an issue when is_fullsock =3D=3D 0, but dst_reg !=3D src_re=
g?
In that case the dst_reg is unmodified by the whole macro but is still
marked as PTR_TO_SOCKET_OR_NULL. Isn't that a problem? Can you add
a test case for is_fullsock =3D=3D 0 but dst_reg !=3D src_reg in patch 2?

> ---
> Apologies for the Easter timing!
> ---
>  net/core/filter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb05..8fee00e6adef4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -10618,10 +10618,11 @@ static u32 sock_ops_convert_ctx_access(enum bpf=
_access_type type,
>  				      si->dst_reg, si->src_reg,		      \
>  				      offsetof(struct bpf_sock_ops_kern, sk));\
>  		if (si->dst_reg =3D=3D si->src_reg)	{			      \
> -			*insn++ =3D BPF_JMP_A(1);				      \
> +			*insn++ =3D BPF_JMP_A(2);				      \
>  			*insn++ =3D BPF_LDX_MEM(BPF_DW, reg, si->src_reg,	      \
>  				      offsetof(struct bpf_sock_ops_kern,      \
>  				      temp));				      \
> +			*insn++ =3D BPF_MOV64_IMM(si->dst_reg, 0);	      \
>  		}							      \
>  	} while (0)
> =20


