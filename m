Return-Path: <netdev+bounces-261132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNHXIW2yn2kpdQQAu9opvQ
	(envelope-from <netdev+bounces-261132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:39:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A8C1A0291
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3749430AE259
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC7C37882A;
	Thu, 26 Feb 2026 02:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPbOfjRH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E363793BE
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 02:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772073415; cv=pass; b=RAwofa3C4KU4cJyUMTSVsBwVV1kwc+fdJicsYrnlDYr+theirReznomTUhz+oaqbiLTPdDXHXNL4y70Us8d5qlGoozp5Tw3U8zqv/wjs85UmJyf0O9tXsXIZty+7nTJE+vcJIaD5H6rhTb2Xtr1ATthtQOJUK7ZSmYfURvuoVFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772073415; c=relaxed/simple;
	bh=1ZciyI4+DGXHpThB/JLb0BLUYmq1LwVEH1+J0ZCkbt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssHK6e5WfFF8RVPh1R5lG6h2o3aNQEgf6I8O74fsRRM/P42pHcG6wsxyvdl7Na/2KKYN0Bt7Mq7fFKsrqYiK36nHQ85FpV3JBw79wnJzPCEPL/Nt9eYUrZcqyRE6+ynbCpXErjJM0gVN+Pm8GnEqUlpCkSNFAJE/+5oaq0PhzJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPbOfjRH; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2bdb17511aaso630371eec.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 18:36:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772073414; cv=none;
        d=google.com; s=arc-20240605;
        b=ids3iHfS3AXq+M4XTraeIGIkUd1rb6RwKRVS/xvlsRICoA2gx+A/3ClawHAMN+ruIM
         a1w0ZTQff9R9VttOhYGdQ4CCMqqLuE4IA5IQvR7s/jWtmtEHKMNnuo3H72zvEgswDPpn
         0IA7r4cu34DfLAa9d7ES7GkDi91G74aLmG2COphn3UsORSn4dUMUAtWWCB2wxSUtn3BB
         CmLzhAvokRlEgEowx/DOtXRKLIB23HEbHBz9J8/1J20c9/d7qWW2VtaFbSiC+gfMwLVw
         F15EGWxFKPOjbrABoRAwMlTZdhmvKs6KuxPBoNRXYUEUg7KWz1DOU8I+d0gl4WxfdJge
         +biA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YhbERqa0o72EhM/3kdZd1Wu3INud2VV6b/l1EQqUyXs=;
        fh=vN/4bfSu4Q7V8a9yjgi7ja6rjv3iGEEGtQ8WXKRp768=;
        b=j4Ebfl5Oh4grU+OaBHWN+A7wg1sE4XQVodPvzok1J4zfSfXp/h+ttx21vhOv2Al4+c
         NTTJ8ABmskvHCl8CYD/JwYZ+rsGcEU+XnDB5eYaQ9J+RD3jTYuaZ0zt7wJ7tFkNVlNAi
         McNs9sRSxRKErA+EW+84YRXfDbBdzy4POTO5yjyY/pUCHpuEWg9mymjflWsSlranszE4
         NXFfeUiBDPB6ftqHQJFnURfVIH/eFz0P4TMjMmhy/58yF3ZJMoxVBMizWbg1l+JlMDCq
         eiI/fDhJnda/OoABmPDCm59SX6OXT84eaWeGQmUhYRWhlQWhEv08nZofYswEEJLRlA2C
         XvEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772073414; x=1772678214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhbERqa0o72EhM/3kdZd1Wu3INud2VV6b/l1EQqUyXs=;
        b=YPbOfjRHeDcjXBOt/UPpPrCurom2KKGyRnlxqGQXfJCXLdMNmFcQEPSNJsVkWcMAh8
         kV+QPGmuYp9X/5hFCVpYW1+9w1PT/sZ8H0vpIKVmxs69wkhDwiJ7IgUXZT8qYlGYhFZt
         wwuclwdm8Jux6WVWjqTEsi5KlXsO/HS9CX/Kvj/0XQjlVc30d9W8J6L4uydJt6bQfjWt
         nY1LXooQdRAugyDEv7FHR/M++smbRg5L73TRC5CYRkY4LsZxR8UyE83DGLa7mjo9ZyoR
         fktYwqFa1opGy/ZOcEqpDcMKWVPyd5yyE2FRnEbY6FlnPQhWsKc69OZ5ZZU2Oorzs63i
         0zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772073414; x=1772678214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YhbERqa0o72EhM/3kdZd1Wu3INud2VV6b/l1EQqUyXs=;
        b=naittG2cWEi9+cRUUylrdvS4UymVrkrVJtoHe8IDqh4kN6sM0qTslDQZCKPLg93tOB
         GxDZhMtgqfjE9D7LeWuozJCEUAJM01NlcTYcLbCSts/E0wXPzyXDWdZEZ/2b2Uvmf8Np
         LChBXZdV1NgHpLsBvdnu9UVj5sFFHWA4vIaQ9MvipCpzTKXtA7fgW61g0fweH0KH/YRt
         5UazSFLj1GYXTNfmzomoinMmL9UzlaTT8EHKDglE9Z9pUi59MDDpEIO4Se1MKxf8rSK1
         QFjhCb4jmvrUL5di/ncigiHEYk6sT6PlLOGT79D0AFyx6zkp42k3Z/3yG62DYbTQ1fyK
         4KTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvcQXgmXDinYIK2jmJuQDorAxxcZhgMlYcfRLvS3RBVxkW1p8atQ5k+kvj2dT9Pnl1XJkInbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YySEzJkxWwV0udqnbkO1GGfWbPEqsrjM82ZWx0eSgH7BLg60mMz
	n9Cw/zv2nTZVd5MmBkauCXoutZ3J0zNLPChPC1FEip8YBgEAA3nTFVZbTqSrA3fBp1UHHAho8+J
	4wJ1p6+jLg6p4PyGYbSDDRGz6zinfcFo=
X-Gm-Gg: ATEYQzxU3ryZeNGFoI4OVL6hIbi+L6Ck8IWQRRQR7zJuvrnbLb2VZYy6skspFycho0e
	ovkNC+X18yuLYcQF777SXyHXcIfawDSkVT68NIermT4q0eVRYucZhtcT1zz3TzPZ+e0uBQJWbf5
	hpjvIgpdDnrVM5BRIFjLnvk9oZ0WEHcuoAGycTzVgWdnzOHxqBIPiwHcoTwh+xcIixoKGBzGkWU
	HsTDYzy1eklZdeWrdsvfJKEkuxUx0Ylv/RdHmUfO8uTlZpWjzQ+P5J89KDr7NB4N0EkB/I8w5BB
	JPCLe3TDX1yvJ+jZGig=
X-Received: by 2002:a05:7300:e80e:b0:2b0:4c56:be16 with SMTP id
 5a478bee46e88-2bd7bd52906mr6640269eec.29.1772073413691; Wed, 25 Feb 2026
 18:36:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226021215.1764237-1-edumazet@google.com>
In-Reply-To: <20260226021215.1764237-1-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 26 Feb 2026 10:36:13 +0800
X-Gm-Features: AaiRm50MubjkYXRNLpas3sRE8WtYtPIzgDp8lnRbqYEDJ5715r2UdxxcvXlYhhY
Message-ID: <CAL+tcoB6z4Ap1RMfthFh6c_Y=JOtygcApeT_e9w8qHj2LodAmQ@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] net: use try_cmpxchg() in lock_sock_nested()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261132-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E2A8C1A0291
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:12=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> Add a fast path in lock_sock_nested(), to avoid acquiring
> the socket spinlock only to set @owned to one:
>
>         spin_lock_bh(&sk->sk_lock.slock);
>         if (unlikely(sock_owned_by_user_nocheck(sk)))
>                 __lock_sock(sk);
>         sk->sk_lock.owned =3D 1;
>         spin_unlock_bh(&sk->sk_lock.slock);
>
> On x86_64 compiler generates something quite efficient:
>
> 00000000000077c0 <lock_sock_nested>:
>     77c0:       f3 0f 1e fa                 endbr64
>     77c4:       e8 00 00 00 00              call   __fentry__
>     77c9:       b9 01 00 00 00              mov    $0x1,%ecx
>     77ce:       31 c0                       xor    %eax,%eax
>     77d0:       f0 48 0f b1 8f 48 01 00 00  lock cmpxchg %rcx,0x148(%rdi)
>     77d9:       75 06                       jne    slow_path
>     77db:       2e e9 00 00 00 00           cs jmp __x86_return_thunk-0x4
> slow_path:      ...
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

I like this fast path approach. Thanks, Eric!

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

