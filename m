Return-Path: <netdev+bounces-256498-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNmAKP+UgmkRWgMAu9opvQ
	(envelope-from <netdev+bounces-256498-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:38:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CABE00E9
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 01:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7E6B30BB2E1
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 00:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913581C84D0;
	Wed,  4 Feb 2026 00:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wQ+rOVZ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AAE163
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770165496; cv=pass; b=Vb+98YLb5DRHrpkk4nsfdJtBbu5Y7VZTGu4cpO0v4mUa16/TiJkhshl5qk5EIfnulQNBl4S54sNq13ycQL6+03XIqZjWtTiw/jfUm96iY/NlhzyhIFYCfI+LnbX9MFV8WbtZyxpHZoLJiRscxUt/YaxIsHVbbNaP7akhVSryRAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770165496; c=relaxed/simple;
	bh=Xcb3i+4YMlv16uxkG7HBi1SF9S5bTh2IUK2L9N+2Kc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEz3QUQ0eUI8AI5PNueEYmFC3WVbNI6V0Q4Nl5+7qTceC4DmAhJeXPUaJFjtgX6J7k6lAFdx5MSKOg6FsglosZCCcN6gXn4M8vLgdtN0Ns0rnz5s7kYRBsfHQ1f2/7mByVsPYsdP8T2vTDPOLnXBjNdFJJVfRvEvmOmzmnq5dxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQ+rOVZ0; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124a677c9afso3696930c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 16:38:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770165494; cv=none;
        d=google.com; s=arc-20240605;
        b=VNEyOCbX6D2i0TnZCowjWjNf9M0cWs4V4m7M54kVq5ETcWeZjc/KaL/C0u13TWkq0H
         mHM4/kaQ+KFrdJIpFMu8IneQteC//mv4dUFyUv4S6KI5HxaOAEUlkXllHBQa73WiQNI3
         IChNXyhpYwZHk0F9bRij9yUVfE6flDNYfRJIs/YrgFHfUz2+GBSP3FLP5BOXwr/R/r5w
         XB5E+iILy6PvbawSnQiA4C+Hwkyd7Uu0K3bcYuiruP7ro2QPjgn+F+puSA+neN7UJcVW
         f/uQDrXJDfFCAeaBG3cSdAqKGNFOrbdKMpiVH7c2ptxv27zu7OctxDPqARiV/UBpZRKM
         CVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R9N91J1cu60bubstiN4aO7IYoDV3H4rS/i3O8mKKxXg=;
        fh=bMQLAySHX/K4ldNMC+MpRxVJYz9pWUjUVF15rwOCuZA=;
        b=HusPJGGY3alspbBcQNyLOwv2NaV277v++r3YE/JwuYb5QnMpI2GrebhxoAE+6hKqJK
         cGwV8lRd7O8krBXtKo0QSsCPH3AOt2NURAr1s9nV7YlB4/y+Owpd8OrZJjoJb3fEMeKh
         XpQgCFMByX2k/TfwpXewUXGKFVeB+ozk00TDZPBGNrx1RtcO3BpESACInXhihqEsxihj
         X6ayWmEa5P5nu+9RFoEkptLwWO1qtbNXpjr0wv+MkPmbbLEBBRhTJMsywJYIwsKSw5h3
         oRIBkiHrb0tUxBzwW5Macx+Zm3HwXA+MRVjKFs31dHCWEDzey4JmMM84Y30AxY6gRoL3
         cnwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770165494; x=1770770294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9N91J1cu60bubstiN4aO7IYoDV3H4rS/i3O8mKKxXg=;
        b=wQ+rOVZ0VTEoN41IFSaNY9WAcraIvZWWyg/5/XAwCn9oZm/TD26c/e4HhscTlB8cWg
         lhIsylroOsyU+nMzRj/bGn436nAUPMFgT4icaMwDLwxruf9JTsJXKKPPCRs6nR3kWD7y
         OPUy4eDpg6tMNdLqK8tzOglvo7CUmdcGlrULZ4XHsFZFyNilAPFB9Z+IgQUk8ZzFaLEB
         TNPx0k7BRp09/izhD+x0726RyDCX6cEAnn5heC1vqoZLaMiL0NIwwi4gdxiPeYMzTJ26
         30QO923LjlbGeRwhOGMX/1o4LfCLdVNRd3kDhe/jYllso2BSAc3Z/BYj8er10GR+ACm0
         /CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770165494; x=1770770294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R9N91J1cu60bubstiN4aO7IYoDV3H4rS/i3O8mKKxXg=;
        b=mz7RbwOXBOK3q+isLa2j9I5NRCcLBh1nm/uPv7LSd5VPXR7oNv7teZ2VD8IxGQ7+ic
         qUP2HIqloqtuhoY7xWUza7KKQixXpvNm4ISEELmu4u8TnGZsYoObw2U572+1ywsW/idr
         WZtJDdaJ6kmkc4mkTbrVJId9Xm9rWim3VYF3O2a7C4Yd9OHvWi1iw9hXLM6dVkjd8VAp
         jIw4remt+SZ7Mx0qvBBareyblGTegupldtY6FY9is+fmQ4y/rwYoSUsMYnbGg07W57oW
         UtOXyTY4whOXTwXSKseeCYwa5WTW52TTe+TqZFFRpHBeepyMXnKCK0b7J98yWv7oDxlU
         WRLA==
X-Forwarded-Encrypted: i=1; AJvYcCXiz63hyGIv0C+9EWEzO2dSkImPJV4OlbUV3XMHirfqJJ4XvtjZkn4tGhNzHCjjRpFTKD1dp0Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzadabwm03rnLYux/Sfaaax0ibUlbLnphs8tNWWRMCGEPygIliz
	B5J5XhLpfVJRQvU3i8xivebLIE3bQ+iFi0Bj5woHA6ocI27vpOWgOjdx7kaPKhJL6pjJPXFZHfR
	YKMcuTGZIIwOl2ds6UgmOIsmRSFJBF5WpEXulLry/
X-Gm-Gg: AZuq6aI7aBhncYkEHlDBcomhOuySbl2h13ExjNLYqUjVgvXJTJeeAsEHFpJCCJpzoLV
	GghJjS0/TjOgSW62rzOd+H4IZqjxJ3JdzCCYRJnBvanK2U7OGqsg4lcQ1jtoEMqzndKMqxca5Cs
	bETTLd4mQqzcIr5Q0itmqHWAdWb+tZ/qspHvvQQFPcnNLiTx3z9/P1x+4UAvkCmbRo/olhMO2D7
	vbdqQusT2ZdLn9lRd2m22RsXEeHbQOlJjbXeK5UbJS/onMAdNsYMzKt7j2U3f+yiY1T4uKXmoNX
	akIQeANl+Y4Y9aRuB5Sy/gqtktov1987A33RLg9ZgId3oDiRrPN4Y396gA==
X-Received: by 2002:a05:7022:f103:b0:11c:ec20:ea1f with SMTP id
 a92af1059eb24-126f47da388mr668539c88.33.1770165493694; Tue, 03 Feb 2026
 16:38:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203052210.3684125-1-edumazet@google.com> <20260203052210.3684125-5-edumazet@google.com>
In-Reply-To: <20260203052210.3684125-5-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 3 Feb 2026 16:38:02 -0800
X-Gm-Features: AZwV_QgjG6Sz5tsx-qI971xo-6YfieU23bh86ow4ZpLUOKOEuKtRyNrTvmkho2w
Message-ID: <CAAVpQUB3QEToRRcUQR4C2_K2OdwDa7sHQuuhA8K2Tbpkad+ocg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 4/4] tcp: move __reqsk_free() out of line
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-256498-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vmlinux.new:url,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22CABE00E9
X-Rspamd-Action: no action

On Mon, Feb 2, 2026 at 9:22=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> Inlining __reqsk_free() is overkill, let's reclaim 2 Kbytes of text.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 2/4 grow/shrink: 2/14 up/down: 225/-2338 (-2113)
> Function                                     old     new   delta
> __reqsk_free                                   -     114    +114
> sock_edemux                                   18      82     +64
> inet_csk_listen_start                        233     264     +31
> __pfx___reqsk_free                             -      16     +16
> __pfx_reqsk_queue_alloc                       16       -     -16
> __pfx_reqsk_free                              16       -     -16
> reqsk_queue_alloc                             46       -     -46
> tcp_req_err                                  272     177     -95
> reqsk_fastopen_remove                        348     253     -95
> cookie_bpf_check                             157      62     -95
> cookie_tcp_reqsk_alloc                       387     290     -97
> cookie_v4_check                             1568    1465    -103
> reqsk_free                                   105       -    -105
> cookie_v6_check                             1519    1412    -107
> sock_gen_put                                 187      78    -109
> sock_pfree                                   212      82    -130
> tcp_try_fastopen                            1818    1683    -135
> tcp_v4_rcv                                  3478    3294    -184
> reqsk_put                                    306      90    -216
> tcp_get_cookie_sock                          551     318    -233
> tcp_v6_rcv                                  3404    3141    -263
> tcp_conn_request                            2677    2384    -293
> Total: Before=3D24887415, After=3D24885302, chg -0.01%
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/net/request_sock.h      |  9 +--------
>  net/ipv4/inet_connection_sock.c | 10 ++++++++++
>  2 files changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> index 23bb909771fb..5a9c826a7092 100644
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
> @@ -123,14 +123,7 @@ static inline struct sock *skb_steal_sock(struct sk_=
buff *skb,
>         return sk;
>  }
>
> -static inline void __reqsk_free(struct request_sock *req)
> -{
> -       req->rsk_ops->destructor(req);
> -       if (req->rsk_listener)
> -               sock_put(req->rsk_listener);
> -       kfree(req->saved_syn);
> -       kmem_cache_free(req->rsk_ops->slab, req);
> -}
> +void __reqsk_free(struct request_sock *req);
>
>  static inline void reqsk_free(struct request_sock *req)
>  {
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index dc4e2c5725cd..3d0997c39418 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -918,6 +918,16 @@ struct request_sock *inet_reqsk_alloc(const struct r=
equest_sock_ops *ops,
>  }
>  EXPORT_SYMBOL(inet_reqsk_alloc);
>
> +void __reqsk_free(struct request_sock *req)
> +{
> +       req->rsk_ops->destructor(req);
> +       if (req->rsk_listener)
> +               sock_put(req->rsk_listener);
> +       kfree(req->saved_syn);
> +       kmem_cache_free(req->rsk_ops->slab, req);
> +}
> +EXPORT_IPV6_MOD_GPL(__reqsk_free);

Probably this needs to be EXPORT_SYMBOL_GPL() due to
drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c ?


> +
>  static struct request_sock *inet_reqsk_clone(struct request_sock *req,
>                                              struct sock *sk)
>  {
> --
> 2.53.0.rc1.225.gd81095ad13-goog
>

