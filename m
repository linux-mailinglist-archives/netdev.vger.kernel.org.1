Return-Path: <netdev+bounces-297952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id To4FO8BRKmprnQMAu9opvQ
	(envelope-from <netdev+bounces-297952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:12:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E4266EECB
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:12:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=XbOtbx34;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297952-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297952-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E60F30269D5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 06:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9C2358360;
	Thu, 11 Jun 2026 06:12:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602DC35674C
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 06:12:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158324; cv=pass; b=KEdJkHF4813DwSKiUhkrBUOFsolVFuP8OvXQ6Xhhp10GDFn0nKJ9YKXF48vbko9wIUl8RwNXutDQjqBNIyuJGD53vPY5jMXuWCOtRyZeHDlIiMaLza68xukcTVADfT5FeUjkHrM/of16L6THUAUSXdP6uI7Wi8rnAI9l6MTdNmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158324; c=relaxed/simple;
	bh=6uMDhe3s+8phVycZ4mWnM1+NrBk8YNuTjia1m/TqtqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmVeWaqSfoCEG3a15v4PBiiCZx9Bkvot+nm9+he48vYbVjozTF0N4T3Rvey5P8uXSwBdSbKTCtY+PrSXefP7vBGBfs+6Lj7JUyNhKzGT0RBlV3P83QwD+x4ewrsTuXR91rec8tSWE2Gur6CMGveR+x01iK6CHxYrdyzaIPhaB+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbOtbx34; arc=pass smtp.client-ip=74.125.82.52
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1382533d428so2938575c88.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 23:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781158321; cv=none;
        d=google.com; s=arc-20240605;
        b=ADJ7tcN7xYEgD7dlxYJxIzp6oQo4QWyq//2oQhFbWI8i8tsI/9+2lqkFmYMXxTumJV
         JE59RBF546jx4scSPGG7fkQCz1h+SMjMYAStQKRUetry2UVt8mtN4kFD9/dlTevFYrqO
         QU7VE9JTe0SQwMaRtAyTEQ+RgHqligK3MPT/Wvw9fLIEi6cbGfJs3+7KQcmTh/G1QVSv
         AZZBiy1ZM7eR75jmE4CzqBwLevIPnUfjJIl3Fs9yeJiRnpLHuqxqXXRJcMY6tbXfi2Dt
         m7Yx4bndqXdsYLWjM7NU7OGSWakhKLI7UM5/GU6tESmvAF5loI/TfGJscOUYBtX1e/Ze
         KQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DVuHM7/3dS9EbFkPJRKrHdVcq08dk1S52xv7iZVtqOg=;
        fh=cDIADNnOPpeUKAJtjS2xy5JWOxmIH+otWYYu6/TJbGU=;
        b=YhmszbUro3zhQcK+agc1vidMJFCWBzkssUdxFkWRigPDd/qD2l4sRzebDqZYJ+UG9C
         VodkNerr+WqKokmIsFrqTI40NoNdPjZ4JA9PRy7P8/ZNfJv8H61Xsmrw72HBTtvbPJrh
         kKSDSmqkp22g9WUlXdxYyPshnnHDJUsTXKXussOrCkyrx7569f4eZ+c0nuKEbk8LVoA7
         MBh6qpnYbFazFIXsIaRHyKvF532r4RYgIp4KUgMNLaoJAzcdvOzmaD5Ico521ZnG+PnJ
         oT7nQzYn8S1NfeIozd1tOCy5vEG5juzEJO8loygSoK5qPRoELGRGmWnCV3GZ+sVIay7A
         orMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781158321; x=1781763121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DVuHM7/3dS9EbFkPJRKrHdVcq08dk1S52xv7iZVtqOg=;
        b=XbOtbx34nerVx6BCJO1kueaccu76gPo7YuwUXQmtES/8OwWzGxKbMJKi89SlR6xHpF
         Z4kEKfn2B49LT1Ti6bOSksmLW5PQi65JTHxhcBvNAoveeAPHtdZCWQ6aYFR5qUWm8XY1
         I2BiC7kn4Tc1Ma9hi7Bpft032f+TtEgHNISuwd2uqxwbGrOWZ37DgLo+gEbm3ovTbena
         HA88fmQ6P9bPjGkcewlLrcNHZvhRrknLly6Z2JmbzTemDL+3m4QKZYjpk4LWXQ/q6R0W
         ttx+jw4Iza0WQ9MppBWUQAS4Sfr5S0q0EO8PLozN9AzI7Fs5xuHlhardUZ1CuwTGPGw4
         6UxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781158321; x=1781763121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DVuHM7/3dS9EbFkPJRKrHdVcq08dk1S52xv7iZVtqOg=;
        b=VXHxGrHwRAVUKMU0CLHOoaOj8hBxQiwTmcPTCm0HR722J2iscnhe0qlGNayDG9I9bk
         O689QlazlMX53DHEl8HdBFpyYTW7A4TFgvoW1O4NuaZpIFzJIvBqMc9QQyqxUlCxLws9
         IKfOfrgZC48pMLfhaOna0NMnXwSYRK+1QhFnO+CdByypJP7VpE9J91QIHflHvCXdg9M6
         8OxF9KBZqoQojxjnjLTWqKsQmaTeyDTpsnu4xqJY9AN0Q1tnLKJGRsaNdWfYPAh0O3IP
         rn19MoklB5QcOUrS/SQ/HOiVS4jY5mHXNVIg8cQw+yN78SSZeMe27G3s4w0Sa/kjtJ3T
         o7SA==
X-Forwarded-Encrypted: i=1; AFNElJ9SkORDWkSTBu+vIPDD9JlnuhAR8xedkTlky3YqG29bMA+jiis12IoPcRozvC11d+UVVu1vAhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJJ0ESi//OnYJmskV9X9030qqlhJ99/LZsalXbDw+/A/pTgKOC
	28lKTRyVROsefbcR8GJVcnXBmj48LYm3CXawazHrMy2NkH07sRxygN5JQj/HI/02QqHnOj0bgg4
	Ea9ccd9vc3EQGgyxSFX5xladdTP1MRskhLL51KHLK
X-Gm-Gg: Acq92OFfj+ft7zkBCRJnxNRycXpzrj/Jk6yOEBKZP7yzf5S+/mIWfwMN+F5gP6e5xD9
	vHyphR0iPSJpht6f3/XrB30AwQrFlz0p89TPLZhWCMqSJh6bDzWdFxqji9qcoOMhiFJNwKvkZMG
	wu9Ke9ayt69yk5aQNtbQDxH9c+Q/gxHDfLfalxtEXpLqbC1DYjt+ayWlwAqcGZQpOYQIknRuDVT
	8+Bmyy2CD4kYEkmN1zN4UIBFesko7tOLTpZlMBTR8wQQMa10dVFBxoyOFEy+cJ80MIGUG+QVqGc
	b9ty+tmzyBlAXbj8A+XMn0EVXiEZUy57wbtfjff63jOQw9I0NeQj8KUlcKdBpLH9MW1maiF1HmL
	YlPlQrNzO8PKpiXrRRei0FwBMSL98zW+V3DIulQoX5hSOD9YNds+kM09GyT1zwEc=
X-Received: by 2002:a05:7022:1e05:b0:12d:b7e5:a67b with SMTP id
 a92af1059eb24-138421a9261mr1143508c88.14.1781158320538; Wed, 10 Jun 2026
 23:12:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610155946.894878-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260610155946.894878-1-rhkrqnwk98@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 10 Jun 2026 23:11:49 -0700
X-Gm-Features: AVVi8CcJX3xqxzypzeI_Nz6IpNCvi1NwKNZ6i4ylbn2um6RtpL6pV7zktRtNHGo
Message-ID: <CAAVpQUC-ibCY8-xSc4RL5M9Zvbm6owpethgBK3-W8GmqbPVTTQ@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: clear sock_ops cb flags before force-closing
 a child socket
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Lawrence Brakmo <brakmo@fb.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:edumazet@google.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ast@kernel.org,m:brakmo@fb.com,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297952-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6E4266EECB

On Wed, Jun 10, 2026 at 9:00=E2=80=AFAM Sechang Lim <rhkrqnwk98@gmail.com> =
wrote:
>
> A child socket inherits the listener's bpf_sock_ops_cb_flags via
> sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
> tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
> inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
> without it.
>
> If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state(=
)
> calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me()=
:
>
>   WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
>   RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
>   Call Trace:
>    <IRQ>
>    tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
>    tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
>    tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
>    tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
>    </IRQ>
>
> The child is freed before it is ever established, so it should run no
> sock_ops callback. Clear its cb flags in inet_csk_prepare_forced_close(),
> which covers all forced-close callers.
>
> Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
> v2:
>  - move the clearing into inet_csk_prepare_forced_close() (Jiayuan Chen,
>    Simon Horman)
>
> v1:
>  - https://lore.kernel.org/all/20260605094954.1374489-1-rhkrqnwk98@gmail.=
com/
>
>  include/net/tcp.h               | 7 +++++++
>  net/ipv4/inet_connection_sock.c | 1 +
>  2 files changed, 8 insertions(+)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 98848db62894..97eac5fa341c 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *s=
k, int op, u32 arg1, u32 arg2,
>         return tcp_call_bpf(sk, op, 3, args);
>  }
>
> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
> +{
> +       tcp_sk(sk)->bpf_sock_ops_cb_flags =3D 0;
> +}
> +
>  #else
>  static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *=
args)
>  {
> @@ -2959,6 +2964,8 @@ static inline int tcp_call_bpf_3arg(struct sock *sk=
, int op, u32 arg1, u32 arg2,
>         return -EPERM;
>  }
>
> +static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk) {}

nit: I think prefered style is

static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
{
}

> +
>  #endif
>
>  static inline u32 tcp_timeout_init(struct sock *sk)
> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index dbcd37dfdc15..209f73a61a1d 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -1290,6 +1290,7 @@ void inet_csk_prepare_forced_close(struct sock *sk)
>         __releases(&sk->sk_lock.slock)
>  {
>         /* sk_clone_lock locked the socket and set refcnt to 2 */
> +       tcp_clear_sock_ops_cb_flags(sk);

mptcp's ->syn_recv_sock() will trigger the hook in the failure path.

inet_csk_prepare_for_destroy_sock() is a better fit.  We don't
care if the child socket is locked in this path.


>         bh_unlock_sock(sk);
>         sock_put(sk);
>         inet_csk_prepare_for_destroy_sock(sk);
> --
> 2.43.0
>

