Return-Path: <netdev+bounces-265422-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AiODFWTrmmmGQIAu9opvQ
	(envelope-from <netdev+bounces-265422-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:31:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E702362FD
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 10:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32EC93006B70
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 09:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3DC3793DA;
	Mon,  9 Mar 2026 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rhpMDkGt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88FE1A9F91
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773048445; cv=pass; b=k7lluOfKh5u2hw3JQWt7gXhF1qCagjNG59AvarD2fVU4N8mhHwOmM2m4AoO3iJeTVlQ9+EzYML6PilnnJ5SRgDBJH5JqJ9zRw3KMNTM3DsTwfl2RVVTSZsK+zMO3qgZWBZ28Hzy5pItfkfWwvcK+W7JT7KNWBSuRd/Ss5fkVcxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773048445; c=relaxed/simple;
	bh=KRg67KYop4N0GYuq1ulIbzn25MYTnK5W2894J9F0VtQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+t0uA+g3iiLhMaF7c10TK4mCmsmSL0r05ArI00ygh3+BaaW5yTgyXigOij6tsXhF+lisIc1JyBcfUG8V2trIEVjkolOhdV8KdOxBtSNZ1tg3aJry4OuTRB7FqKVGv+msijVA13cWTGMK1AK426pSiwxaBbYxrndc8WO+Z4QVDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rhpMDkGt; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5069b3e0c66so162455571cf.1
        for <netdev@vger.kernel.org>; Mon, 09 Mar 2026 02:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773048443; cv=none;
        d=google.com; s=arc-20240605;
        b=ImIQN/1UYBzVQXs+T9ElCviO6HEMeQoROYphcT2wP5nRMBLjQbMjBuMl7Hf4QB/h+G
         4HRAHxBOPdc9Nr6cYhIwWsM0W6anjsUGPKC4CdhR2tKqr2njhJ4647GfcYap0VYQGcpO
         RBndoUX73TBIHSE/d31h/inkWNbmqXgrZrpSBTgDIV1vLe0ah5BDpHZN3ehJIdsfc+dL
         njwOJa24hVNuizES2vROVJkZ/JtIJRpsS+nQGNxXPyXodQhw0HTAV9lRHkJkkbStOedQ
         tvXZbH084+r1VebfjiPEeT+YGF1KiOluCZqd3WzhkrfKqdTikd1hFHy/rqXsZtCjI7vi
         OoPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V689RnMNCiq5v9NKZp9UJyJzDdaI4f7fA+TJBBF1pOI=;
        fh=pZLImAI7ZyYAdWGG6Jv74ck0+jpk0oEAP4ESjVlmeaI=;
        b=Ckq4Emyk4Ylc5YB1klPPAQUBx3wOUXqNhg0J1kOBOujEGw5kYXNAvzGs8fTyyF4ljK
         0BCfVnFASD8fh7UYSTIguiiQbCu/gAVXfNwbAjv0QRdtD6ExAmnsdDDfGLhdParvmb0X
         s0GR2cNR5i6kPSIK6IDx1/tV+7cnzsC4F2qwBa2N8sKwLo9VRBRS/ImcaDeNThD5MAeA
         ggtiU1TiwnrY9Z6/pKoqSsdvZpAUxJlBVjWcLg+859A43Ln6kazZwFPprs7GT8YkX6Q6
         EH1A2p5LvZwgSyWVa3TiW4TauVHPaDT+0jbmGqPKLhO5anYdc5dGc4nu95MQvDu27EjU
         x0WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773048443; x=1773653243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V689RnMNCiq5v9NKZp9UJyJzDdaI4f7fA+TJBBF1pOI=;
        b=rhpMDkGtGMIEmlnLkfDw2oXrfvhd4gXZfyDb7vS/fo19/8788aB0Xku9llKzqY01+S
         5uM39fHj1fLAansQoDXAxWhMsyYZvJuTli/jcZWgTWhuvXRWeAP7hOJfQryBVsVM/CGu
         XDgsPXWJJLUWxjLZjwx1+FOKJpYmwBCmIelJSsD0IhjVtsUmhyjzLERvX4l19CdW+eEo
         SiJ45CxLYR4GAjM5TX7qZRQwTDi35l/6Aer6Bs2SZhPC2HtS7NX3uM1k+USHB/fGnPLd
         RQg56VDtvn4d2PpeTA7GUqbdPc8t6c9H/ep1ChuXl1TaW0tWNEQ0kzJZM2mYzmDuXLzI
         ksKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773048443; x=1773653243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V689RnMNCiq5v9NKZp9UJyJzDdaI4f7fA+TJBBF1pOI=;
        b=Ftue3z7I92AvJKHCcCU148N+Qca6CcT0ma5r+qCSFOAyBoshSy4xDlSnGSVdrF/1+7
         c9nRqfYSBPPqVUhdQQUQtLNI/W2dsFZy4RUmd7LRYBeMH9/+h+UMDO/LZQFOnZb6zDG5
         lS00PEL2966hceoHeL4/xLcuMQjdxOkmkOFPFW8mXiubcnUrikczcwoCW1aexdyLmYgc
         VQ6iORBvpC8GkI79aUm0K5tUvpGUlyUup7FQwb5h1V6uG+ryJ6DzDvWPFgSaRxHRlRgc
         pUxNTKmWvQhHR1G3b3SwTn8YFsrPpvfB/IfL5c3AyWm7BAOD3fxq4Rv2UJogPbnW+2ex
         7TOA==
X-Forwarded-Encrypted: i=1; AJvYcCVH6wSXL3GD4tmYQh0OXCXkP0EiEqhx+PoiyUEEmNeIUpiA0zcAB4JjAoDlIk2r9xv0zLzHKCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye07fLCwnZ7TOmg8P4I5lpWg7ETgRZIhxVa3Z9OAP2Gj4MABYP
	xIUyKf7e64CQ7UjJiXNWsk5nb+d8yBQoO2h7DXnuVm4uAnZbOgmajvF7ayoutsZJGq1lbj4CtPY
	iv/Fhrj1WvJvReLj2emZGmb3RnAqvSIi7qzg+CfPi
X-Gm-Gg: ATEYQzz2C/k/fKS7fHnu2dU+fC6Fts7jGvdf99LN+pE0R6qNT7iRjI0VhL3ZmpWD+S7
	tLMneueqA3P+w1oZX8ERJ6oDv28wuR4d5S6HGlbZyZOZT98cV8CpDzUaglx7eTE1RhlcLGLiPM3
	XYjfE6FsUvMuEKCX2iHvTzEXQysmww5jausDTofeILll0h7c+joGE4RKUh73L9hsUGJaS9nIhuv
	dJIPrkN9ZzT99fCWYAyZp8GBv0hfei4jQ/7OQujaapuT3HmzzcN0P/cAl6b8Vw0VZjwIQodgxkd
	534OruI=
X-Received: by 2002:a05:622a:211:b0:506:1e25:c0d3 with SMTP id
 d75a77b69052e-508f4b39629mr125560661cf.30.1773048442380; Mon, 09 Mar 2026
 02:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-0-4c7f96b1ec69@gmail.com> <20260309-tcp_rfc7323_retract_wnd_rfc-v3-3-4c7f96b1ec69@gmail.com>
In-Reply-To: <20260309-tcp_rfc7323_retract_wnd_rfc-v3-3-4c7f96b1ec69@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Mar 2026 10:27:11 +0100
X-Gm-Features: AaiRm52XfGKozvuZyB36ujKchA9srFaJs8-SNxpJxUZoRWouiMvaeYGJTNLDzWM
Message-ID: <CANn89iLzOhZ_DbAQytwZrzoZ6cvkkvLPbvUF81k1C2tBYRSFDg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: increase LINUX_MIB_BEYOND_WINDOW for SKB_DROP_REASON_TCP_OVERWINDOW
To: gmbnomis@gmail.com
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, David Ahern <dsahern@kernel.org>, 
	Jon Maloy <jmaloy@redhat.com>, Jason Xing <kerneljasonxing@gmail.com>, mfreemon@cloudflare.com, 
	Shuah Khan <shuah@kernel.org>, Stefano Brivio <sbrivio@redhat.com>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 87E702362FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265422-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,lwn.net,linuxfoundation.org,gmail.com,cloudflare.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.976];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 9:03=E2=80=AFAM Simon Baatz via B4 Relay
<devnull+gmbnomis.gmail.com@kernel.org> wrote:
>
> From: Simon Baatz <gmbnomis@gmail.com>
>
> Since commit 9ca48d616ed7 ("tcp: do not accept packets beyond
> window"), the path leading to SKB_DROP_REASON_TCP_OVERWINDOW in
> tcp_data_queue() is probably dead. However, it can be reached now when
> tcp_max_receive_window() is larger than tcp_receive_window(). In that
> case, increment LINUX_MIB_BEYOND_WINDOW as done in tcp_sequence().
>
> Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
> ---
>  net/ipv4/tcp_input.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 2e1b237608150c2e9c9baf73cf047ed0823ca555..e6b2f4be7723db14acf2ae528=
df17b6d106b9da9 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -5678,6 +5678,7 @@ static void tcp_data_queue(struct sock *sk, struct =
sk_buff *skb)
>         if (!before(TCP_SKB_CB(skb)->seq,
>                     tp->rcv_nxt + tcp_receive_window(tp))) {
>                 reason =3D SKB_DROP_REASON_TCP_OVERWINDOW;
> +               NET_INC_STATS(sock_net(sk), LINUX_MIB_BEYOND_WINDOW);
>                 goto out_of_window;
>         }

Reviewed-by: Eric Dumazet <edumazet@google.com>

