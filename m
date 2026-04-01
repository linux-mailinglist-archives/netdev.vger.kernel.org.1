Return-Path: <netdev+bounces-273996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDQ6OuLjzGmjXQYAu9opvQ
	(envelope-from <netdev+bounces-273996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:22:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 487CC3777E8
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 380BD30F9517
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E289C39D6DF;
	Wed,  1 Apr 2026 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twFnRIT8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA903C3443
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034707; cv=pass; b=FrXSh3xWwHv/N7g3rCsp1rsgoxfpdWB7GXtctlHxB3aOj+TdCQvS/xOXdY3SfpB979BF7L04ieXL3Hp/DTKSHMACM2SAOmeWe28UVBnKbVUfpgW0+U6f5wK/jbB70WEZO52Vpp+7EFj8AuUxjiqi5RJ4VVxezm4UuJmGzEfTtoU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034707; c=relaxed/simple;
	bh=dmaTcuAy6jfJ+bmzS1Jm/uyBrkTWgyDnScrFaQ2/nas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjq+JQmd7npsoyOsfajEAtMc0SqjcZNTpWyczVSG2ge+qzNEUPNJoRbH0BjBmO55pPTbsqp1BmCKLReRcxPmzWsQoWiCuqRvwMa8tBn6KSNoartKn8yRWz0TJT8fUFGfInV+jU3NzZoasoIqoLYO69SZv1wU3QfB3ShWqEU7Rrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twFnRIT8; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50b268fba9aso57384181cf.3
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 02:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034703; cv=none;
        d=google.com; s=arc-20240605;
        b=LWZBaay0i2wJsWidqAc+0PYKGOEjk/Tb4fUqG0e5EO1Ee+/xEenKv4jTQ788u5RzJI
         EeiRi2eZY6JikE1v5qY4YXJF3IlQtPa/506IuefIWPQSOFMT4hAHG1kblWEz59/4GMGl
         AAwJ2+9Q58Dj2S3SlTc4wBpJq4SYNslqrJC8hX/2xXy+S8iS+8pl4bId1EgmtDvy9s7u
         7HICUDTFioAFoPaCSKba0aCKbOoD8AvzxNng5XAWrwIcRKB2kOs+afrpHryalRkTAROF
         KN+h/Iult+tqBy2LF6i0zePLesjl2GZp6DM0nQkB8birFVZ+kgv7EbfNV5hBokOsSSad
         nisA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        fh=R2Ykx1y6E0C9eczfjfXIGXuRHfQ/utETnNqnXhj1A40=;
        b=SJokG/omPh4rRTDQFVv7u/WlgNVm30e5XIP14OH8xFZXNgj/gPUQuaZbCsLnuQM/yw
         CUcSNs/IXFYixqq/ObTr2+vN/oTO0eGTsog4UVkGsk8wDCwHXYjeqK99lU8vSI+yrjrE
         hah2cyMyJ9Ao4+wIb7TZksUxNC5C9pCfvhGuPjrA8RXtbBlucWzijI0gYqYgXB8i9/b9
         44kt/AF6PisCfJPH6Ea4l85rCA32oRT/tdBIUTlGNLvCcFADGquVDNcsCCnQosAGFZhq
         sELMjhgwsHG6KpX9WkXvcjf4H9OK6U+4JaEtXP65/8pk1CtTbhxK1b1c8CT1fvTFkhpJ
         2QiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034703; x=1775639503; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        b=twFnRIT8SirtW12uUCHs6hTeF/J2DOg5PKAmKI/mwRCncAk4AIvZwUq8xR7yTK0iJ+
         4ImgI8xWhYvzAYMKo33ksmbew7TAwPlXPwRplqecw+NYSPwHcYD8NcIFmA0v/FzgmIrA
         GlgznlRQinWJpsA4qp4IlnNYa4zu4LMzYJu3khv64uuDL3+ybWpc3gfaIp1N30uXymnh
         o/KWJm7bZFr+X8f9bK2b9IBUwDPo2JrcV4mBBOIg3fqCL5h118wWZzw/mlpOg5YazSse
         2pJzkr32Nm/rqUXZUcHdfdBBA5R+Rztx/u8eIHbmmnYHi26nHKuFO8CqGzwdfgZfHKXJ
         VrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034703; x=1775639503;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lctUVgmnSzTUnScobr+jAtLkB/onmBi35F0YaMEt+UE=;
        b=Aol1BKXzpM8CmPSGS93O9YrsJjZA6WlIGF/cNoaNxoX+ySXTHB5ZLEDK+hvAwC67NI
         xd/vtdMf3PTrTmXZ8P4iFsXvWEctxFBdju6WbuGhR/EXvDFG9csvLT+8ckXPtg2SnQRw
         VF2dyazW0Oz+8CwTUemFLp+9Lg6z7UXbORrtAzUQi74LM6OVoS2SKmM8F7R6aRgzsvBe
         jrLp2FDH1xNVvkNjZtvRWbcQ/MZItD5qYEAPs6pRT4L6VytfOj+DAVyiEAk6o/T8kTf2
         haqUFe8UAUR2UJoA3WrkcaikjufF2OAVJqeBBViAA/xJPlB99mCQ/Fs62MlyhhnIZO6g
         rjOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAc3en1/yYRkU4Dw1DNt+St9BDs+sJ0jIpvYalkTSvZbnBh34yzMu0U8HQYGpsHjQsNcvCKTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcxdmc0KxIqx0BEROndLnYKR5UDjBPJYlLIuw5tl1ABrUeoq1N
	mZNh72cs1ZqdFmNLaGrcL1oKXtECZxCXw4RRFlJyBVG8ZeStc3D9r3UEVp6Wc0fxn7pNocaYDo+
	6djmX6l+Xa2aIKB29VRLWUI2J/dT38121P5m8ZhCv
X-Gm-Gg: ATEYQzxjxjlY7lP5Ug2ZYUzolxC23eGTRxpUOuXwfNtBlsLqPjnsO3WR0FtUYNlwFUo
	6FXSUGRyCbckgf1bZjFg07neVU8dCaGU84MrjIQ5RbLMtdEHFtxQtC6f0s+jEN68Z/6egLW3faB
	zPIez2P0IKcFkXiha/WbntTOqtEVK/x3mjftiVBzhY2nFNmZD2GjYKCyuXSWc3+q2VqnLhX0v34
	4Wj0UVx6JYLlVXMv6wnhMv5PBnfZP2JVAYKonI5Rd+HbwsBzC8zTszGPR73noZyJckHoGGT/Z0r
	8RrAja4B1BsYmudr
X-Received: by 2002:a05:622a:5909:b0:4ed:b2da:966f with SMTP id
 d75a77b69052e-50d3bd84b29mr44808651cf.31.1775034702251; Wed, 01 Apr 2026
 02:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-7-dwmw2@infradead.org>
In-Reply-To: <20260401074509.1897527-7-dwmw2@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:11:31 -0700
X-Gm-Features: AQROBzDMpjzScINQf3v40GgXHFr7zNRIwe6Qb5aBvyyAycV5Up8H_bwJXHOzd_8
Message-ID: <CANn89i+GHkkubJp3MTKZ_r4tde1qLejfsxUh+w0gPZ3ec+YdjQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: Warn when processes listen on AF_INET sockets
To: David Woodhouse <dwmw2@infradead.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	Guillaume Nault <gnault@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>, Kees Cook <kees@kernel.org>, 
	Alexei Lazar <alazar@nvidia.com>, Gal Pressman <gal@nvidia.com>, Paul Moore <paul@paul-moore.com>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, oss-drivers@corigine.com, 
	bridge@lists.linux.dev, bpf@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	torvalds@linux-foundation.org, jon.maddog.hall@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273996-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,lunn.ch,davemloft.net,redhat.com,blackwall.org,linux.dev,iogearbox.net,gmail.com,fomichev.me,google.com,sipsolutions.net,netfilter.org,strlen.de,nwl.cc,amazon.co.uk,paul-moore.com,vger.kernel.org,corigine.com,lists.linux.dev,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,infradead.org:email,amazon.co.uk:email]
X-Rspamd-Queue-Id: 487CC3777E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 12:45=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> There is no need to listen on AF_INET sockets; a modern application can
> listen on IPv6 (without IPV6_V6ONLY) and will accept connections from
> the 20th century via IPv4-mapped addresses (::ffff:x.x.x.x) on the IPv6
> socket.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  net/ipv4/af_inet.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index dc358faa1647..3838782a8437 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -240,6 +240,9 @@ int inet_listen(struct socket *sock, int backlog)
>         struct sock *sk =3D sock->sk;
>         int err =3D -EINVAL;
>
> +       pr_warn_once("process '%s' (pid %d) is listening on an AF_INET so=
cket. Consider using AF_INET6 with IPV6_V6ONLY=3D0 instead.\n",
> +                    current->comm, task_pid_nr(current));
> +

Some kernels are built without CONFIG_IPV6, so this warning would be
quite misleading.

