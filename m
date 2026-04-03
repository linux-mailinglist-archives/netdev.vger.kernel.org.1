Return-Path: <netdev+bounces-274851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD2aCHklz2notAYAu9opvQ
	(envelope-from <netdev+bounces-274851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:27:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C210C390602
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 04:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 784EF301DCCD
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 02:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AB134C9A3;
	Fri,  3 Apr 2026 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pj9APJiX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755CD34A3C4
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775183208; cv=pass; b=lPziCmUGrExF+tfzSK1CIJkUuqdhs8SosiHe3kONFL21l974M1yQ+WpmS7Q9cC4q7NP0d6PU3d/7NokVmKHg+9H81Y5haUS+oSTldSe6YLsRzTOo/NsDv/eevY649ASbJHdW+MJ3YhJFW1j8SwCgoHmSZHzy2OXCrWze7fp7U1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775183208; c=relaxed/simple;
	bh=vcJVYVcsjtujJhxPM2Hmf6GUicBFUB6Kawjcdbn0m+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AlvWBwNXuNxsiJYcYu0+LYUoiqI2IfT+//hDj0JZpekoWZ8A9XKTzYQiQWY7MKB76Q9TN97uu/coZZvqSfp2nsompxtlPZrrZODeDOzAlfA7Qh/qAZXWuwKcZyLL8fuJKZx2IlfgsGOYVNdOfQa1X1QzaKvMrdB2Ub6oGXXZ7Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pj9APJiX; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7986e0553bdso15329477b3.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 19:26:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775183206; cv=none;
        d=google.com; s=arc-20240605;
        b=P1Ni07Gq9WaVf1JNVL80m4mvuh/LXdvMty18AvWTiiEi3Nvf0W3rIvp4VrmjjlFBbj
         VXcJ9FpX/MNTFR8PDQIHzvg6YwqzFHbgMPgJYKhcyCx2ZprGgLvIpbDNVWCA5TAZTuRr
         /evXMS7s8b4liJgD5gykL6uP2WTvV7PLVwaL1e/U0rcxoKX/S+HaFM//Q6VH02r07txN
         PUmdY008YLhcZLwgIIKDfL3/GY3IBaELqaG50iwIk0Mc7DpcNkpmKpLehlbLweNPLBXv
         jhZX8w4KeuZ/XDLJM3mqIgdegiEhSeNbd46BmaaBqd31K1mLbF5YTT/FyrWKkfbzPi6W
         FUlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oDMKzHqeL/XyiO2Bewz0UeWrM+1zjaTUFq6LPDrd+SI=;
        fh=UbU+EOg+yy8yYAy0DAdf55+mOYvwtoMslsmGn+eNaQQ=;
        b=PB+Enn59JxaxElO5dsjtPKHtG7ugEVNd2yKJqBUgDK99YejOVKyYWkVVoRzxFv5zi0
         Lwc/o9df8o9R4gWjckS2aoOlHas2Qs9kMa7SeQ7XoADB9LlnUBSRPtaZzDTXErZB66ZW
         Gskit+r8f5dS+JFCAhDeNxri7N17g+0DZFvIa4y/OTZkcCDeb4G7wvB3/3TXm5s9hccy
         2L7oQPuVFcRuz1qJU9dZ3yHk/p9dKtFT6bOMATaxN0Y5+/IyXbfT4DKByj8gkXz3wZ5U
         ylix3Lwko//G7SPN07d7DVNTG0hiQRo3JtjNvCED8/EgA2xBeFviPy9rUbC5Z/cmxXMD
         YXKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775183206; x=1775788006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oDMKzHqeL/XyiO2Bewz0UeWrM+1zjaTUFq6LPDrd+SI=;
        b=pj9APJiXwPQpv2w/t6G6RTFnZEOcQthmzNUT0gh9/PMgPwKu0cOD8de4u4xK8MFJG8
         rh5op5ZoOQFvio0wkCcf4oeMdLGXICbgT0ECbrVKn9uZwhLNNVYPQwgL24ik/wPbdw/n
         u5KFOb+Tuizym1/1P+Di0L2Wwr5/HOANx9ZcMLCy5hDIEkFgBImB8ZQjW4sw1rsUWTh+
         ByWNE7yg5BohdHOxBKMA0nSisf1YKIzKOw0bKPmn6LqpQctIK5vy7s2NhKCslkRlkNEY
         zv+sYPBO1mzQuJNfw9rfaEIuFv6AuqLwyelA3QR4mlS0VGVbYGY9eIxKBaE6y/k5acem
         nkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775183206; x=1775788006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oDMKzHqeL/XyiO2Bewz0UeWrM+1zjaTUFq6LPDrd+SI=;
        b=h7lDXaaYOsmZ8wJ7tADqFxfqw1BBsoe5mrAMYYYQR7rLzd8ybeIIFrQYEgZ0HcWKwa
         KYH34l17sBw0zKjZTMy6X+anX3JMj3Ng7Q6aVKxEh++x8ivG5p8LuLny6eTyRBihRVJe
         bmHsGWJjzdYyY0+bGfa12z891ymU668rqdigGryecPirZc/Q6mmNsdLHBZ1iIr0ZLQf+
         zPN/jd1J9LJNWrcHB1X6SjVy5i+I641ppJlZ/vh6DYgZhqt9Cac3UQ9mwQFSUUfo2QHf
         QsxThz4P0GsX4umywpH5MZ376oiFtOnslw8xNtUUcAhZnKT1mNoMN8iVOFh5RAoYt30C
         mM7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUGUyp0PwzqCC5c38EKO0aa+uQG2jvNem0TWDfoUUrff8gYmOe1Q8n9FrccVuRZBQFfSQjXY/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0rt3vcdHGm3HHGAel/e9JP8pSdGVZzx9ZKav1iTVhho9ewsJh
	iJJ9AI7Uv52EbB1GIdNSfEdB6ilPXzJ46HcOUrxv2GYml2zvX9iPIvk/XLR+it+MxiPQdC2HTbz
	YjDUk1rIyWkQz0Il2L1n3n9OoC4Ui1Crl+kwElaxm
X-Gm-Gg: AeBDieteFjqKwsnKKUJD7wNNyuSMDXPZLTsQ8VTfnwgiYSiqonJG0PieAVWRF8+I0HP
	PNUzz+CFH/UxXcEO7BQJ+HMlFdJfMaXrOI6CC7LkLQwD9SE9hrYByNO11EUXqSgMCuOLcpr1Fqu
	6X6m2JauiNLUJSxI8n0kZdQrFFgP1AKiPCdqYQ3smbUq0n9Yq5RVqE1O3k3PfmOzpVeYIVgapW3
	kw5idY5lvWSveHs2Se7Ahc/LzkU2mNoTFedR659aW9BKaLUSdYyesYgDUddGSjo4AkgyeiAkvc2
	Imt27y+AOiF+6jNIOw==
X-Received: by 2002:a05:690c:90:b0:79a:c396:c01 with SMTP id
 00721157ae682-7a4d6732758mr17280927b3.55.1775183206003; Thu, 02 Apr 2026
 19:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403015851.148209-1-jiayuan.chen@linux.dev> <20260403015851.148209-2-jiayuan.chen@linux.dev>
In-Reply-To: <20260403015851.148209-2-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 2 Apr 2026 19:26:34 -0700
X-Gm-Features: AQROBzAh2Ysi0SF15X8q_e3XfU4X2ZmmJIBBcIrVoyrG5eWnijGl8DAlrd1gYkE
Message-ID: <CANn89i+1VzG3KSv1NvhTbPm2EdG4Lvii256yZj_wq9jcB-qQ0A@mail.gmail.com>
Subject: Re: [PATCH bpf v6 1/2] bpf: tcp: Reject non-TCP skb in bpf_sk_assign_tcp_reqsk()
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
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
	TAGGED_FROM(0.00)[bounces-274851-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,davemloft.net,redhat.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: C210C390602
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 6:59=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> bpf_sk_assign_tcp_reqsk() only validates skb->protocol (L3) but does not
> check the L4 protocol in the IP header. A BPF program can call this kfunc
> on a UDP skb with a valid TCP listener socket, which will succeed and
> attach a TCP reqsk to the UDP skb.
>
> When the UDP skb enters the UDP receive path, skb_steal_sock() returns
> the TCP listener from the reqsk. The UDP code then passes this TCP socket
> to udp_unicast_rcv_skb() -> __udp_enqueue_schedule_skb(), which casts
> it to udp_sock and accesses UDP-specific fields at invalid offsets,
> causing a null pointer dereference and kernel panic:
>
>   BUG: KASAN: null-ptr-deref in __udp_enqueue_schedule_skb+0x19d/0x1df0
>   Read of size 4 at addr 0000000000000008 by task test_progs/537


>
> Fix this by checking the IP header's protocol field in
> bpf_sk_assign_tcp_reqsk() and rejecting non-TCP skbs with -EINVAL.
>
> Note that for IPv6, the nexthdr check does not walk extension headers.
> This is uncommon for TCP SYN packets in practice, and keeping it simple
> was agreed upon by Kuniyuki Iwashima.
>
> Fixes: e472f88891ab ("bpf: tcp: Support arbitrary SYN Cookie.")
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Eric Dumazet <edumazet@google.com>

