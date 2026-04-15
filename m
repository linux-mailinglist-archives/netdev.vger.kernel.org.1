Return-Path: <netdev+bounces-278646-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A2vKBAc32myOwAAu9opvQ
	(envelope-from <netdev+bounces-278646-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:03:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1132D4004EF
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 07:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6BAA3087430
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 05:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770153644A3;
	Wed, 15 Apr 2026 05:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FzydE54M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38D41F131A
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776229388; cv=pass; b=kx4wxaE605uM9XWIKYd8W4bG4q9Xy+lpG2gd6ifMflbxiIxWcbZ9hVw+p+iKu/DKAVVgGdyyNGHHqyaGN57UujJ+eWnpf3HHbvtlSTmDKEdIzy5qYyC788DvJDMfXfcYkuoA8Bzzvcmuc465ySDl9uQcYAydJWdmYext2kh4y+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776229388; c=relaxed/simple;
	bh=fGuuE8tUzF5eS1PAD+Ab0UOa4wxXcjrLg+nGVcrtBwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YP2A/txggiF5gkjYmkHbFpk08xwlNZu6QTdXpJ5PzhVfzqMXaBVI8sYhrmrVm3xrtmZTIibSREdLjCxxqGmrISH7PKEDfdBOsdpa7soQ2nkVo36LmfQyAWH4iz0Oggsj3iGeiUHKJlhQxoegjq374lhGu7ZQx2q9gQXONiGXQ0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FzydE54M; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12c55e3858cso3830242c88.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 22:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776229386; cv=none;
        d=google.com; s=arc-20240605;
        b=QE2AdTlcUe5BTfl98FX81AIsPm0wAcCa90JTmV2dWlk2dsrVk/A1mn2VnFDLmc653K
         WTCTtilzKbT5nTwnFUMWDKt33CYfZcveOST3GPuOQ9X1XWTM+9STYXQCmmSrL4egggh6
         KvERB7Tuc9MVUsPPlyjFS84dgPGJ6rRArd5VHCGomCGyBFgBL7EtSgIH1pDenyMjCbou
         lpFA5PoRF5znyxRd0plnhYlFC2k0PtL/q7FlKvuxrqPqM9NuVQSvMurcGyS58kLHV7a+
         /8VFrtDzQ5pZo4ZDDKGdjqXpBIKbbMMvbcMt6F8Z9s0s3k9YPjjQf7SCFltuIgHtN+oD
         PGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uZC9Xmxwou/YeM1QDbSuaSicunUg5xqUIEJn3vfDI0E=;
        fh=I4WXp1e5QH4NNZkPDAXj6Dtph/9iBDAOjR7aoJfEjVk=;
        b=iXtYB1rypKT58rOTjCkWZOYp3hMToS61T1N41UBOcpyhq+1qSJY1IQvNYYc3VDzitu
         PlAAhO8hf8uzhda72bSnVZOolMmXcBRmLNqi3ibYUsrx5s4Zj3ah9sI9dpon9fxMpUzS
         fY0h6l3zwLc6w911KXMilyig+Ojf6+bWGRfQaVmU65pDzcbFxgKddt2RUC4kt3a0cRZi
         sJFeaFZs4xvLAVmlCxUtTf5mvzHaccnEXP8unpwqJY4Ooh384kyiemUC/ejzTVkZIzHj
         LaW3aDDlRF4Maa+LwZn2w6tYq1BQiMRmWwLr/v+lRfSKVbIu64siu37G6FYOInES7CvW
         MUYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776229386; x=1776834186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZC9Xmxwou/YeM1QDbSuaSicunUg5xqUIEJn3vfDI0E=;
        b=FzydE54MCUpFwKefARAstG2UILU/+dVykGD6eTZm/Slstq6Sof5aWlljVGMkGNu4V6
         sx3ka9F0lYz08bWzSFN18xeLaLoF5HlHrOlX9Vm4tF1SVbN9w+7xPRKG15Ge4hLd2Nv5
         KDlhhu3B3YIaYnsH1VLcw8M0eftdCUcnILIhz0UJF+qmppTF9Xo+w1037NqQk6y2iBrG
         eLZtxODIDxAr4V0G522+pBplLL8c5P+0a4tMZYegBcnzAYqt6+Dq0A9K6WxNozZStsmf
         GEGbN/3StpTISrPNt9Ty2nwxGQTvfQ9cnbkfJcW/RM96wFSS7RYAgDkqKtR3e5Lp6ASb
         kLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776229386; x=1776834186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uZC9Xmxwou/YeM1QDbSuaSicunUg5xqUIEJn3vfDI0E=;
        b=ioXlf4LyDHeDLnEHJ0roCOBsH29RkLMEaZhtOldXcPQmNZKe9Bsvmdbb+fGL6roXuM
         w927HKWv8bHPyoftVHpsXs6OSUJuANu4qfXr1sF4BRlfzNhqDayc24lwGK7gqqId1KRX
         qe6+kuRFjG/fFGIJgXl5M7A2n/21Yxnj7N9U3v9ELXVoAvkUsW39E215umzY1llS5FI0
         +NEd5j/0lzAdipQGqlLNBZDF51uiTqkn1xA2gzHU8KyXMrIDcCV5lQZ2Lu7CDBuYn/3c
         UBVw5pIYC/Hbe/MAeIpRdJ3p1DhOudTvF5L+iN7dZm7DfrsOsl2iBUtOGa99B+4eex+c
         VqhA==
X-Forwarded-Encrypted: i=1; AFNElJ976ZSNzx6NVYmWDkkgctIdWCGFQz4+gBqZtNeig30lEYAqIiEJCDqIa4+XbntObEoX8IYXthU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM8UFnGLcFHGledCGBaPuG5OP/Y3sWwjKtbY9Ga0c2HNdKzP+N
	kYFSMhRMfECo4AiWHrw1YX/xXoxScqvgTu9VoxkTV6WZNc81sQNItwi1K0aqYkaxVF8I4F7GGcW
	Y9kiJjjNTo/hBYadcM0LxjoXA4Gt7hPQtXAgppa1M
X-Gm-Gg: AeBDievInfvClniUabNLKxjFo7WV5WFRaxbaLMVgD9nF+9W1lzxOhJkqmAls5pJCSna
	5DRE6b+ba4ohV1IQelXOPVLnBGyDBB2K4kOJPCPUntcDF0r6T0ZBWB6VB+PH4Ca/ZBKugqGNADK
	XsYFo4hkJ6kDzgwHN6moKrBQfNYAuBUgXuGEtG+kwlF8nO7f1Gr2GRU6M6utZLK+3dpbv0zTfp4
	F0auRmEV3z2VvPUZVWsJyVgbCqo/Ou+orswxXVNFsi0AVYbMfl3XmmlPncwz0DprhXkrfSi49rl
	dmzdE7xCoQ1VWVG79hcZ5tGh1JQREm351vGbvoVXb+ZcXRpo2PhKigepH4SlfTNMYlir5aHFs+v
	dpxisPwPpXbTSA6M+dE8an99DMW0N4PI1acrAg8BAs8ZegfePbG113RIWf35F4CyUprD7gCfhEp
	gPhKu/PaLG
X-Received: by 2002:a05:7022:faa:b0:127:3915:76b2 with SMTP id
 a92af1059eb24-12c34f07f1fmr11520144c88.27.1776229385519; Tue, 14 Apr 2026
 22:03:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414-unix-proto-update-null-ptr-deref-v4-0-2af6fe97918e@rbox.co>
 <20260414-unix-proto-update-null-ptr-deref-v4-5-2af6fe97918e@rbox.co>
In-Reply-To: <20260414-unix-proto-update-null-ptr-deref-v4-5-2af6fe97918e@rbox.co>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 14 Apr 2026 22:02:54 -0700
X-Gm-Features: AQROBzC61U2caASKHWRYjmp86WpWvwDPDOjBGrBWlvFKCfDox66DepDxhPOqVoc
Message-ID: <CAAVpQUBkq+wNSRiNLMKhpeY2AAZ48d9=hG9dWyGbf_MRS89-Mw@mail.gmail.com>
Subject: Re: [PATCH bpf v4 5/5] bpf, sockmap: Take state lock for af_unix iter
To: Michal Luczaj <mhal@rbox.co>
Cc: John Fastabend <john.fastabend@gmail.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Yonghong Song <yhs@fb.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Cong Wang <cong.wang@bytedance.com>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278646-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FREEMAIL_CC(0.00)[gmail.com,cloudflare.com,google.com,redhat.com,davemloft.net,kernel.org,fb.com,iogearbox.net,linux.dev,fomichev.me,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rbox.co:email]
X-Rspamd-Queue-Id: 1132D4004EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 7:13=E2=80=AFAM Michal Luczaj <mhal@rbox.co> wrote:
>
> When a BPF iterator program updates a sockmap, there is a race condition =
in
> unix_stream_bpf_update_proto() where the `peer` pointer can become stale[=
1]
> during a state transition TCP_ESTABLISHED -> TCP_CLOSE.
>
>         CPU0 bpf                          CPU1 close
>         --------                          ----------
> // unix_stream_bpf_update_proto()
> sk_pair =3D unix_peer(sk)
> if (unlikely(!sk_pair))
>    return -EINVAL;
>                                      // unix_release_sock()
>                                      skpair =3D unix_peer(sk);
>                                      unix_peer(sk) =3D NULL;
>                                      sock_put(skpair)
> sock_hold(sk_pair) // UaF
>
> More practically, this fix guarantees that the iterator program is
> consistently provided with a unix socket that remains stable during
> iterator execution.
>
> [1]:
> BUG: KASAN: slab-use-after-free in unix_stream_bpf_update_proto+0x155/0x4=
90
> Write of size 4 at addr ffff8881178c9a00 by task test_progs/2231
> Call Trace:
>  dump_stack_lvl+0x5d/0x80
>  print_report+0x170/0x4f3
>  kasan_report+0xe4/0x1c0
>  kasan_check_range+0x125/0x200
>  unix_stream_bpf_update_proto+0x155/0x490
>  sock_map_link+0x71c/0xec0
>  sock_map_update_common+0xbc/0x600
>  sock_map_update_elem+0x19a/0x1f0
>  bpf_prog_bbbf56096cdd4f01_selective_dump_unix+0x20c/0x217
>  bpf_iter_run_prog+0x21e/0xae0
>  bpf_iter_unix_seq_show+0x1e0/0x2a0
>  bpf_seq_read+0x42c/0x10d0
>  vfs_read+0x171/0xb20
>  ksys_read+0xff/0x200
>  do_syscall_64+0xf7/0x5e0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Allocated by task 2236:
>  kasan_save_stack+0x30/0x50
>  kasan_save_track+0x14/0x30
>  __kasan_slab_alloc+0x63/0x80
>  kmem_cache_alloc_noprof+0x1d5/0x680
>  sk_prot_alloc+0x59/0x210
>  sk_alloc+0x34/0x470
>  unix_create1+0x86/0x8a0
>  unix_stream_connect+0x318/0x15b0
>  __sys_connect+0xfd/0x130
>  __x64_sys_connect+0x72/0xd0
>  do_syscall_64+0xf7/0x5e0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Freed by task 2236:
>  kasan_save_stack+0x30/0x50
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x70
>  __kasan_slab_free+0x47/0x70
>  kmem_cache_free+0x11c/0x590
>  __sk_destruct+0x432/0x6e0
>  unix_release_sock+0x9b3/0xf60
>  unix_release+0x8a/0xf0
>  __sock_release+0xb0/0x270
>  sock_close+0x18/0x20
>  __fput+0x36e/0xac0
>  fput_close_sync+0xe5/0x1a0
>  __x64_sys_close+0x7d/0xd0
>  do_syscall_64+0xf7/0x5e0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@google.com>
> Fixes: 2c860a43dd77 ("bpf: af_unix: Implement BPF iterator for UNIX domai=
n socket.")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Thanks for the fixes, Michal !

