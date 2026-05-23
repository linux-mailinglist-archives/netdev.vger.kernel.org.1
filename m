Return-Path: <netdev+bounces-291024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9mNXAeEiEWq5hgYAu9opvQ
	(envelope-from <netdev+bounces-291024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:45:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD6B5BD036
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F040A3018BD3
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 03:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC00221FB6;
	Sat, 23 May 2026 03:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pSRngL3e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526C19046E
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 03:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779507932; cv=pass; b=muHI56EL1Nz2NLJL6b6Xp5tEKgCPe9ukgA6PtXK5DAe1uICPSAi+bVgTc4QNnPDwPjb6kVHjC3ZtDHQahlJPF51IecTshsRhzwVNOPaRo7W61oHvBEruhPu3enXUYlT7RCmXladP9+X3FZxL3mQkwvzOjg5j+vR8PmK1D9ckFtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779507932; c=relaxed/simple;
	bh=lRHjyyY93s8zco7Hkw4E8F42qqWqrJl7lyHZv93adbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFXo1ZZmCSMOVLTpuogUr4NWEyW05/cr07LLmIiNKiAYwbYfu93t/GYvjasQvXboBpkxdnu2rZCLoKua4asuA48m5a9f6VqESL6hPEOv+hx9fkeYfXnIXeYPV/QxTjOAjJC9PELam3cucUhLPXJwPbeBpwpsGUdSsxNo2/f0rPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pSRngL3e; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12ddbe104ccso5960767c88.0
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 20:45:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779507930; cv=none;
        d=google.com; s=arc-20240605;
        b=haQMDg65tQuuQiO+QWOE2VeVkvNkTsc2HxzOe6riDhdZOo1hV53AkH5JOKSRzeVobL
         k+Kah7UnE1bKyeGbAARlAvpKpi0vVzPne/iHhIRD8qaNXovWAruv8n/m3irBvlz1qaqp
         rXHmpVoIlB3iWozLpeeAG7LaP2ZM5T8YaPMLApdBWPAN1wBZas1gDrc+aR35pLFKKPY6
         +OOmsr3bb3hYlPla25XDGKFqDTBRbtMKpKo36gGgTlJ5c4X0mzlfHLnWR8BDzU/4ytmG
         9Pt0wIHF8R/G3P06frGbeJQI7REy3YwtRRMaAa3jBU5ggNiU9flDLwsJ8HFOLlTaBmR7
         fonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q1lxXIMKtRJqWpbij0xKSJz8c1311LgC7gC5lh2geAM=;
        fh=jxAikXAZSv3xRCXXSfjIrDH6I+++SPYxq2CwfulPHG8=;
        b=iX98OcpxUDg3zaQ6CFmOyoZj8LcEwKCdxsnjQFHuqLb7I3H2WEJnNb8eTOvgeQEDaK
         1ndgYaiA9Mw/Ym7ISPEBmlYg8Zt/C515ni6HWyo+XORu1N73osx7RC2P21u5FMbsw8hR
         nzF2v9xLyNyJDTk+28m7Q33lQogPj/Z97i9nYsMJyGM2S/Yi+5jR0bPuiqoAyo7bwyvF
         4ClozG9KdUcvuSbRltvjwo67+zyNBpNu8N+rG92delHEtEekILylQFAHN8jKWnWjwExI
         olY/yNsCGfkpXQwSQ+2SvIakeO5jkpFO9gceEDZy5jbFVLkcrhP99RsebsD4LFkRcXf+
         R0ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779507930; x=1780112730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1lxXIMKtRJqWpbij0xKSJz8c1311LgC7gC5lh2geAM=;
        b=pSRngL3eFtqungHJAMa+yDXG9DZk2mPCOLR4LSBc04LrTDbf2EUDShJhwf5AA/ptHw
         mIeTjrZKOfXAOqzfZXq/Q3xPRPBhYVl7Nf0F++/53FTnUeudbCZR6E3r+wdsN/hx7Hyn
         INDD0+wncOxU3VWifyGETiBPBVy1kkOZx/ukurdhisRsNlGUlcbj3/4Ywy1UHH5F9sdw
         Fbjxrf41T+pd5NLBtp/jGUbrXE+J+ACsxJNjPTk1W3kwj++ZRUQSUl341kf5xLHDTkzU
         KIu3bVnQL596hxh5lU4m2AS2vJyCLCABa1wmL362N2TNREYLFiLroV+S7GcXg4ZxRred
         g+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779507930; x=1780112730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1lxXIMKtRJqWpbij0xKSJz8c1311LgC7gC5lh2geAM=;
        b=AqE1oOXKV+bwF0w0UVLl5OevC8r4gL3Q0znsSE+p3eDFvna0h8kvn0Ee5BT8xm5Fxy
         roJUff2cWHWcLUPLgD9Bila9PlJ2hzSJNP9NcS03heNo7FyVhYJ5EZP8S/TW/DRBOyoP
         CwpaF9oDTTUXx3qMKz7u1AHI8tXDC0TjyaGscFET9HmGqliyjlQO5x7u+tOgqRK2L4eU
         4EPgzJR0kA27jEte7ffeYN+dRc21x/fcS6kZaS+41KCo9xX9KzVM7dXBMqfas+MM/1P4
         zj3ca6C63joHTGRG/3xgQoYkLka+XABdv1ZJCH8q+ZEeRhd+OhOcVD5CKVr84O1cT6Ef
         H7vA==
X-Forwarded-Encrypted: i=1; AFNElJ9inIkBSZVSKy2wGFwItzD+nBSaI+K7XBEMiMChCyVR4xcE0OkJNn48t0RPsqeXv7vlvuwUNY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyHS7vFvzaC3MRSv3KunSWEB/ga20PD8GHhhrYYt8V/MjCN9Yo
	lyT3TmsjfL6Bzt3+GvUSEebjQdKu3lH1cdwSiYXzaN+YNBcczrQXzQEkXCG8JA3fXyR5+ojiMft
	BS5MkpKkHG0BNY+B08IYEoSrCMvktEXmNaQFyo1WE
X-Gm-Gg: Acq92OElGUfNfwbNIVeTGJvgiS9IwRc/sqdu4uI0uRhruWkrLNEjC9XAH4EVyZSXB6Q
	CHpyegC/1F4tpw5CN8hBKxi70fKWRcMVvlKDoSU0Sm/Sv50bGgU+8zCmnUM6zzHuYpRZqqyTdS2
	dwwaarcoxbrqlY5AEZyk040wH3q13pr/m1HGvLiwzLQH7Mu5XXD0mCYD41JqdArx+vCRjV4Pzo5
	I0uMbAjgT+neZJGO+RssycHlU9bvX3xOYOxw95ncb86sozn1bHqraMpTKu+re0Sm2xSTyjxN0jd
	erNS7dgZ5zCr/jZF2eIX/dtU6sJ8B6CHHqMo6cL6Zo2hEhT7BDS/m7Bp0RNOV1OvYnyB1OxaQl5
	8AciFusE4tNxTJxoeM+7uM1f0ebIBq2hW8c1LK7tOEE1nsnBz7HbMp/dZgGCke8w=
X-Received: by 2002:a05:7022:31a:b0:130:ca3d:f963 with SMTP id
 a92af1059eb24-1365fc637cemr2036341c88.41.1779507929294; Fri, 22 May 2026
 20:45:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135244.40869-1-kerneljasonxing@gmail.com> <20260521135244.40869-6-kerneljasonxing@gmail.com>
In-Reply-To: <20260521135244.40869-6-kerneljasonxing@gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 22 May 2026 20:45:18 -0700
X-Gm-Features: AVHnY4IeLjCR1jS6PCs5Xcpr8mg2UcgrM7Vo5vku5jBhf71wpQp-9S3YIggYdNA
Message-ID: <CAAVpQUD8gsYPyZS4Dbyo0DMEjEczBTJRZ3OW51CPZhnLw22YGQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, willemb@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291024-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,gmail.com,fomichev.me,vger.kernel.org,tencent.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tencent.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4FD6B5BD036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 6:53=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> From: Jason Xing <kernelxing@tencent.com>
>
> Add two if statements to accurately isolate bpf timestamping and so
> timestamping. They can work respectively.
>
> As to so_timestamping, only add a loose condition via report flags
> to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> and performance impact. If the loose condition is hit,
> tcp_recv_timestamp() is able to handle the exact case and doesn't
> hamper the existing timestamping feature.
>
> Make it work in TCP protocol.
>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/ipv4/tcp.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 21ece4c71612..7ad3561dc8cd 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2353,6 +2353,16 @@ void tcp_recv_timestamp(struct msghdr *msg, const =
struct sock *sk,

Simply drop const from here rather than casting to
non-const for bpf_skops_rx_timestamping().

sk in all callers of tcp_recv_timestamp() is not const.


>         int new_tstamp =3D sock_flag(sk, SOCK_TSTAMP_NEW);
>         u32 tsflags =3D READ_ONCE(sk->sk_tsflags);
>
> +       if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +           SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
> +               bpf_skops_rx_timestamping((struct sock *)sk, tss,
> +                                         BPF_SOCK_OPS_TSTAMP_RCV_CB);
> +
> +       if (!sock_flag(sk, SOCK_RCVTSTAMP) &&
> +           !(tsflags & SOF_TIMESTAMPING_SOFTWARE) &&
> +           !(tsflags & SOF_TIMESTAMPING_RAW_HARDWARE))
> +               return;
> +
>         if (tss->ts[0]) {
>                 if (sock_flag(sk, SOCK_RCVTSTAMP)) {
>                         struct timespec64 tv =3D ktime_to_timespec64(tss-=
>ts[0]);
> --
> 2.43.7
>

