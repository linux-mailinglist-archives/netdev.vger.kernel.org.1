Return-Path: <netdev+bounces-303353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uX9dBmIfRGo8owoAu9opvQ
	(envelope-from <netdev+bounces-303353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:56:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 852756E7ACD
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:56:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=T0aVO0oT;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303353-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303353-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E67A3009B31
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43A446AF2E;
	Tue, 30 Jun 2026 19:56:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3626226C385
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:56:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849374; cv=pass; b=HhzKt1fJBCQusfyqjaXx5+RuWhQtMSlMUu+4lY6Uu9zySSXDPitqIrsbIWzFXmN8cUzpuKLHZDovARG4acFQ8B+IAxtjUdSB7IR/gb+TwfIZlKW0AePPcqVSSvoKr0vyeCiPSH6UmL5BJDDUyPM3HQQ+OoLDXeXIM+oFd/CKvnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849374; c=relaxed/simple;
	bh=gNP27ClMNuGPvwTBelGEB0ilhV3y6Tkafor3lK0WH8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTxvbXRhv5xYnKA3xqkHq12S0zUxQ+7RTFVUNvJ8kwembbtGTb6EMBPYFmf3GDEH7UR3stPJxu0b5JYPz9p9aIOnRUw5aInTNItHgp8y2CCJVdlLohBF0cnCBzsnoO3ATl6EiFu7Ok9klXyYP+71jOXCTfKLNZJTV4Rrs9Z1BM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0aVO0oT; arc=pass smtp.client-ip=74.125.82.49
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-139b5e604b9so5712983c88.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849372; cv=none;
        d=google.com; s=arc-20260327;
        b=T3iaDa/wVXRRrPlqQStGEvPRS5sMpViC3UQuSR1XvjlnriMNd+DK+d2VtWrAygYNWY
         oyQF3K6U+QkYsBxBuPBrsNCXVhmBE7CoXu5G1dsqK+LUgw7PrZJPmSkH2ugqeNWILh5e
         zyB22kuzUbPLqzFk332yajXZl4t4oS3FmeEDr6BnvP4mpylmHYvrROH4qRXIRB5DHSVB
         3XTE7uESbBef15A5Iknk4ZCgSvsWLUFyF2wf/yevNrolTl8vWkjtAdiJxoHrjxbdXXQE
         sMp7FUxn4vtZg1G0jzpEru8FfEXlmgwYSp4bZDSVEdPDoQVv+AJc5wPIXg633ZvNlZN2
         wmHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oCcBUqrKk3+tG9SJ8vJkQqelJaPg1/2s5eyRkBEOZfA=;
        fh=Div+kQsTYf7sVLw0s3V7qo8l6IwDWbhGzLUsp16wfs4=;
        b=SFfw+NVx3RuBD+6qeDN18xmXxxnOD0/OX2Z3aDbMLQKZaVeVlZtwSaQoxfTEcroCH4
         hQskZKS4n/Q/BFL6KKgZk1tTcGxMs0SB8A+5uzvE3eZx1J08UDxXv1Wma4qziSE4DYCu
         WaxT6Y/QEaS977VRZDk75uo2qORfgBiYhD025/hNP/TWqkeZfILTHSzX10CAK4R4jIYO
         M5Z24rmKkZQ/cgVoXZv/gsSVzWqpZG5uURWoXJmmdCkCswGpWYcdiepsZimaaRTgeFoJ
         HqPueNW0f1Ho8V/xLFjxIJ7J09UVf3qtae4ZpJA8lrPsNiZe5wsfxF1qwL0gkLayEwGW
         VBkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782849372; x=1783454172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCcBUqrKk3+tG9SJ8vJkQqelJaPg1/2s5eyRkBEOZfA=;
        b=T0aVO0oTyBgKgoxAun0ZPTBpxDKt7GxWcFgWaOrGiv6WZd2AueesxaskJI/c6Q9Kq0
         IPpzght2CwaOiU6OSFMPexMXbS3MHSPMwZWwaUxrjgQ4MxHhfY/VMwX61rgXrn3udTpV
         Z4fyIHlNy6IiDBGfXw1pP9O7XgXlm3hNtZtPv8kIooxJsspmXJTarSEHgCnZOwaJcIMi
         sl+tcpYOsgszKJ8mzCDT8zx1RO8eQIQhekfWxfB1qxXMf3X/C+cb0Kn/3h6uboQk4CzG
         qntTNRscUHlZ5SjmGfF9J2hC542XiFS8Y/qUT3gPwHlWSHWIp+JmG9ZI6eHhEzdwNGgC
         F1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849372; x=1783454172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oCcBUqrKk3+tG9SJ8vJkQqelJaPg1/2s5eyRkBEOZfA=;
        b=YJ1Bh+M/dtSjxqkflbyQkeZ9ues+u5c+X8RPolQUbVCqH3ISrQADP3vP2z+/2Q/QrY
         3za++A/h2Ak4qCIq8WQoTTqu9djKLBFwRhm4iMBNZ/pcUbkuIRV1t6+RkmWGBusnVtcq
         iUCHENW7BMvox5eVOyR2S7j1QDgcfgx0PgU0sUYsgWq+ef5XjIlmzFzkFLLY62Tass1Q
         bkBoDMtDu+6syhw4Ca9DNCb14z8S9bQhF8UbFs9w5ZOKWD9aHfdgmm2ZPbGmzs/6zloJ
         Od6e70dCWe7gBD7G/rURZcE7UFSUCFkMNV5cDGvw6eUAUuRVQYH3RRCBCYAAKIc33wvI
         gCzA==
X-Forwarded-Encrypted: i=1; AFNElJ+IHWKy/PGxS3UH0sWLoco0kM8UO+9UnlBI0vVFBABZTfVJOlojwzVCXGp5Z4BnRMP4lcHokis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0kqWd8ySSBfHIGkShp1sMxy+oVKhjcNxxUixUVDiSJkkImoq
	hUoEFfyn1vLuhDg8f0aoC2gYad7cixspUmvHk1YfVI0kwU99C1XzYXq6f/aX+08SDRgSsFN+gRi
	4JXlxjhcRQb+zuQyogm/fI+Oi6jbIy4nySH5CBw8U
X-Gm-Gg: AfdE7cm7gZXjq+oq5iymuj+7a+3nqAHngdx2Snp6TBg0KyGWX2LMeEUmBhNcodQm3NH
	ceQOHEV/kU+gROpNhBqgLUXDl9IPQ/lj/mlpND4KcYefcJqmIsaZ1OulLM5ukJ83osuM+PYtB2W
	228UOaZkk6v5V077bL0ZwDvlclcA2qwyV0bJMm6RwGYnk/q+A6BZrXe3eApaEmp0GUrlOe59ew5
	fMVFL/u4r0ljReE9x/yxGVUtb2wpaTdIiVGySeHiYfFmA2M02htAQh/vDy6SRgsHlxnX0At0lf3
	AGCA8QwEqBqz08m3QJl/DyxLFqM9udhVum8MRaNtUfynBJoHNAED4MwZSwLChR3OAVKCb8Dk0vQ
	57Wg/j0QI6/Q9B7WN6TD5E6tdRVfZNk4NRIQeXg==
X-Received: by 2002:a05:7022:622:b0:139:ed5d:7564 with SMTP id
 a92af1059eb24-13b2a1e2e80mr3007619c88.43.1782849371347; Tue, 30 Jun 2026
 12:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com> <20260629181226.1929658-11-kuniyu@google.com>
In-Reply-To: <20260629181226.1929658-11-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 12:56:00 -0700
X-Gm-Features: AVVi8CcRQlYOH48FSpJETw3K4jDg0yYYq5az33ySkVCv4-PuKZCHiZ8oV2a45xs
Message-ID: <CAAVpQUAHYsJWLknKfmjxwJMfXn=Ykx9psrP5_i=_OUa1U6VPuQ@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 10/10] ipv6: fib_rules: Convert
 fib6_rules_net_exit_rtnl() to ->exit().
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303353-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 852756E7ACD

Replying to Sashiko review

On Mon, Jun 29, 2026 at 11:12=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> Now fib_rule is protected by per-ops mutex.
>
> fib6_rules_net_exit_batch() no longer needs RTNL.
>
> Let's convert it to ->exit() and drop RTNL.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/ipv6/fib6_rules.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
> index 5ab4dde07225..04dab9329d0c 100644
> --- a/net/ipv6/fib6_rules.c
> +++ b/net/ipv6/fib6_rules.c
> @@ -635,21 +635,14 @@ static int __net_init fib6_rules_net_init(struct ne=
t *net)
>         goto out;
>  }
>
> -static void __net_exit fib6_rules_net_exit_batch(struct list_head *net_l=
ist)
> +static void __net_exit fib6_rules_net_exit(struct net *net)
>  {
> -       struct net *net;
> -
> -       rtnl_lock();
> -       list_for_each_entry(net, net_list, exit_list) {
> -               fib_rules_unregister(net->ipv6.fib6_rules_ops);
> -               cond_resched();
> -       }
> -       rtnl_unlock();
> +       fib_rules_unregister(net->ipv6.fib6_rules_ops);
>  }

---8<---
Does removing the rtnl_lock() here introduce a use-after-free and list
corruption regression with the netdev notifier fib_rules_event()?
When a veth interface is deleted while its peer is in a network namespace
undergoing teardown, the cleanup_net workqueue can execute this locklessly.
---8<---

Again, Sashiko misunderstands that a veth device can be removed
while the netns of its paired veth is being destroyed, which cannot
happen.

Even if it's possible, the concerned net->rules_ops is namespacified,
so no race can happen.


>
>  static struct pernet_operations fib6_rules_net_ops =3D {
>         .init =3D fib6_rules_net_init,
> -       .exit_batch =3D fib6_rules_net_exit_batch,
> +       .exit =3D fib6_rules_net_exit,
>  };
>
>  int __init fib6_rules_init(void)
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>

