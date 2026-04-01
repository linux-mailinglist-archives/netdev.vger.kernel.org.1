Return-Path: <netdev+bounces-274001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD15LOvjzGmjXQYAu9opvQ
	(envelope-from <netdev+bounces-274001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:22:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54BA377800
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 11:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68F183002937
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D96A3CB2EF;
	Wed,  1 Apr 2026 09:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PcbMzFc1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796173CBE60
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 09:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034900; cv=pass; b=TIrh5LK8z/jArdxImMbu+WfGSFZskfe9uHAUKaEYg3V+MtcaAZKE+T8nDwj9OPjd1PcVHrjB3kySrmfUdf81f9u+/Qch2w69U+05ftKDnd8f+uvNb4XGxHA5X5RvLc9BkuSMoG8ZkXjxtC1fiApXFlABfQBl2M2MzbhiL2nVa/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034900; c=relaxed/simple;
	bh=Px8VZ/mZa/wVBiSvlhUqswxvgLPunBza8vM2mBYbtJ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uE9eZzg1mMqFwvU+r21ijqIqBEIwmgCI7SkqTN1WLoiE2zNvK3g/5C9VREgcAhyP6WiyBsNGZVjj4TJStr0pC58cIoDfnhGcpHAwxdL/FnfDjD4P8mjbEmNck36pXV2BudJp8HVrIfbni5u627IVin1fD+ovoC3QxoSwYayMKkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PcbMzFc1; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50baf2df711so43305311cf.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 02:14:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775034898; cv=none;
        d=google.com; s=arc-20240605;
        b=HF5g5+KeO/AJZT32/RciaDki/diB2y2ewYQB/5fc9Bp12bAVsiQ/mWgDAV+HYI26CA
         HJ3TQYE7IZID24rrgwPgcPvpDG9Zo1CF3cRC/J/0S8+LweilNa9T2RZTTBoRft+yuB1R
         jsJfBejOCJNE1vGZncnnpQ38+vhbrvZnMGbo8ExrHmqDbae9ZeK+np5gSES7tlUNLMjG
         AkwTMMEJaNuX+l6663fLnxlR2Wtlza9LFQw2iNNBcPWb+wk1Al+mSZ06tAVn8UQ+B8zj
         XBoH0m4aJXdw3l4KWV5bgcoo0WufvsjERXknHD/usK7bqCVtEl4RvQ1vGsrDJLTb5Kbh
         x/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        fh=k5P61lJoa1bM4J1pKAe8qvoWKIV12tz+Pl2zCcFjsDA=;
        b=TkmtRdBkXe8YzO+BVNUk/0/KopkUykCGTT2GQ/VwWehFzlGuSvgIvlfd9bEY4syFZ/
         0aJ73f2AVryXFG6fjZQoagDDlqnjeRDQ0jAnAHQxoF9P6kLrYpJbxDLwMGaI7tY5hFZM
         l4t27LK37HbwwuRxAUmxtCP7BOu3kbvLjv4eAWAtF0x7wd78hQoVEGoEAMtO8+TaEnxP
         j+DDeJKcj0FSMZD/kp/AcvyhG7XniT9dmAbqb9+sRcbsoN4QHSRyPr9zUhO8U0RVoGr4
         hIcYulbFqRsugKyS0w3mB1s4bnqC4J9fhPrB2FR/rt7oSuXw6ocHV/4wrbg+WrxlIYnI
         dssA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775034898; x=1775639698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        b=PcbMzFc143UJPNLa1IszL9pPW8NVryFgbF485R7GCAGuU6p+ZrBk02ECuyE3QGpPPR
         s8PmzFSS1wArBXxvuc+UtXXMnAOwCJ+jq+1vNSV+UniMmd1Z5E8/yTmPY7jdYzGGTVr6
         NzWp9TOvjIix3ogAaxIjggzONpWn1bnYrGEVP35Jv2A4mKUlB7v6q/VKR1ubhl2Awk3s
         Kxcz59bI9slSkfdhXbqubS/KzGRsdYjcTJgVAK0tjaZi0oohw05fsUO/dcsMUFE+pl0E
         aVByIpngrWTZAFOiI7hgEJOSTa3dRZmFq7KhzfK0ZJxLzy54WLBvphLnzo2fZIpudTwx
         M7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775034898; x=1775639698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNCKy3dqIhDpgGkChFZLtJKaP66u94+8Bb0TUa2FxLg=;
        b=EIid/hiWzL0Dn+2MIxx06MlYXOO/hv/nyPpuyalk+/bc0BjwGS4sXCGoKUKUmf68na
         5MxK3rk7REZh/7abwG4HY3oto3T43CqJLqk+hWOT08cL4AtHnAgM7jxB38YjXt+PCRXm
         ZilnFac9BNejpbKu2gFq3pMcHB7dsrJsk4O7Jobloa5t6aDHHh9ONWrFxQiA/lzS0JsT
         asFtpiaDkSJTzHqvgl2yk569YC8jCaGKPuzP7WpsbnsSqbnVE34MbBuhmSTINVqhnBA6
         3SPdYL/YqURAAvlMQF+pODYVOg7j4+rTIQif7nTRvjDT+JJyhQYUkq4LH4YrH4zPNXs8
         1NNA==
X-Forwarded-Encrypted: i=1; AJvYcCVDcgBz8XttkFxR6GljkbTl+1hWI7KnJY/JvEnyiK80sKgAm8N+N6xJGQdLmLv1Akdu597onVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlAk6qte/l7x3E4S1Q+aj1ltOeYOQUsc3cei/jM9CtklZQ0YJy
	eTrW09X46fvYvSWpiiKtCWWLyXwUrZwQEmgL5F8xvwmJxNbsyezB3yJltwYARbyLsMED6cmx/w3
	kzDIWkfpy/vpjjnm9wDhNOZyan4FsyDgkIXD1tHMc
X-Gm-Gg: ATEYQzynkvtwvxhzydkxMlMvrALE1hiRP9KdRO/FmSINZo3n+T34w2UM4vUhCG9Eac2
	hqt547GGpfTcqtIUG+EIFwQsa0McUDuJcLiyVOWnc84Z/Ju7aZSxfN4hZCRbI/qlVqb8KNiEvaF
	K0XCldwv5GjR1ahzH9f6oTZq88GLah5uLYVnMzf8wngvzPD5JwZMnRq8NG2Bsf8syvTLc2jJTYC
	/cUJd/vObL7h4nxJo3fx7OjzDfC5ArsSg9Qv1P8dl8dJleXUWZFQm/LmTZi3SOQC7GY/QnbJgDW
	+xAeNQ==
X-Received: by 2002:a05:622a:1c05:b0:509:2ef7:7034 with SMTP id
 d75a77b69052e-50d3bcf5f5dmr36705111cf.50.1775034897967; Wed, 01 Apr 2026
 02:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401074509.1897527-1-dwmw2@infradead.org> <20260401074509.1897527-4-dwmw2@infradead.org>
In-Reply-To: <20260401074509.1897527-4-dwmw2@infradead.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 1 Apr 2026 02:14:45 -0700
X-Gm-Features: AQROBzAoGbAvZgGI1SP1QOjEPB9AfHu4JQqffzH3Pc3uWqwtvvbxFW3VGI6Tc4w
Message-ID: <CANn89i+iRUgqtd+eirfSUM3k+keNZKzLwsHxZtwE+vHdv7H5PQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] net: Guard Legacy IP entry points with CONFIG_LEGACY_IP
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274001-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,infradead.org:email,amazon.co.uk:email]
X-Rspamd-Queue-Id: A54BA377800
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 12:45=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Wrap the IPv4-specific registrations in inet_init() with
> CONFIG_LEGACY_IP guards. When LEGACY_IP is disabled, the kernel
> will not:
>  - Register the AF_INET socket family
>  - Register the ETH_P_IP packet handler (ip_rcv)
>  - Initialize ARP, ICMP, IGMP, or IPv4 routing
>  - Register IPv4 protocol handlers (TCP/UDP/ICMP over IPv4)
>  - Initialize IPv4 multicast routing, proc entries, or fragmentation
>
> The shared INET infrastructure (tcp_prot, udp_prot, tcp_init, etc.)
> remains initialized for use by IPv6.
>

...

>
>         /* Add UDP-Lite (RFC 3828) */
> -       udplite4_register();
> +       if (IS_ENABLED(CONFIG_LEGACY_IP))
> +               udplite4_register();

udplite has been removed in net-next.

I would think your patch series is net-next material ?

