Return-Path: <netdev+bounces-303352-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NuY2GcweRGohowoAu9opvQ
	(envelope-from <netdev+bounces-303352-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:53:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B196E7ABB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 21:53:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ZhkpPQON;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303352-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303352-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF8AF3045EF8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA068472760;
	Tue, 30 Jun 2026 19:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558C03DBD53
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 19:52:49 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849170; cv=pass; b=uqH6Ceip7xOW0mtlm84wbe/jZuZ87uS2GroswXBKbuLekfrUWbEnwmJoK6b+gMXJAYqaE4gSq7vakiutTtLCpmayTWT6a8gd0guoGkbdtcyFm++OnG7PMvH1dKk+oOvzJER6OhG7XZAlVtkcILyB/VY7HQFfDRTFfR6UAyNAMkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849170; c=relaxed/simple;
	bh=pQk093UPXkDI2CLgAJS3Ls4ngF+W78fqHwUuBkw7Saw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMZ1tDe4x2MEWCbjeN+25jHsuHJlmIBKmzyfe8T3GCccJslerBR/PPPEpASgiYKtl2htfwdf2zx6PeAgshwlCbZupQKGy3GgdNsDZesumw9cowE2oV8wrGWpkI0JGsv5t+uiPPa5AQSO3p7Ctr1bbKgnaa0EE79yGXxVh8mEBt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZhkpPQON; arc=pass smtp.client-ip=74.125.82.51
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-13b2b08a553so2723085c88.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 12:52:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849168; cv=none;
        d=google.com; s=arc-20260327;
        b=dDy2MkptgsVXCvDbasieyCP8orPE0wgb5OynZss4LB0scmpuBWQQ1NiDUJQFKm8+6i
         LofUERo5Hw+NrxcXlMAsQlEtnkkPUCSap/oaSqhpEwz3H+hj2Nhl1jylTzsgjfVKmv7v
         k+fYt0dhfwkOOu8ErBdolRBfZmuD5fxNId/Y8o41BDmrfa62Y4eCuQfIBYwrUg8vVuki
         8Uwr9aFhfIU1G0C5kaHVxlDNfP9ZX5+qvmxmDVkVMO4e7Ug/dkOmDVL0uMw9jvukny7c
         OmNyfAfjvijdd69sY93B0VLEbF8m+fjH5ro4I8NWdBUUdjbsZuC4SR9CDfG6RgnpQwAG
         1udg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7jL7x6MybyatejrGYVunRlmuamZBlc/HwD0QKy8gmec=;
        fh=LZ44XGmTC5sB1XXBumG+6Xy4ekyLIJ2j+d5/uZa9vPE=;
        b=rG2dSq0DS8ZfIUYFwrdaMV66vn+tBwMCL3dS51EmebkRk53ZK03wOhNEYX/gHm19Qu
         WS6x4RIUN9udDk+XG/ULShytsRyaghVQjSkSx85RUAAGZD0v3/gLNYxwNlqipAYQKSTc
         xqVyuYMSItQWKDLhuj4+t/v0x4Zq+x+dFIoUDoG/DA2heWlaQISg/gE6ddEsvb8Cu7WL
         32JpqgYyhQkIBLvss5figX6pfzwym7LvWlW+6gPvWpMRwufjxd00QHlOkp1GLODcS0/U
         t1wwAMs5sWTA+Iw5iYEVK5RXpYT6w2syVJJJkQ8VHF3g3B0U5G/wRrBPd/Jp8wkgezbl
         lWqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782849168; x=1783453968; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jL7x6MybyatejrGYVunRlmuamZBlc/HwD0QKy8gmec=;
        b=ZhkpPQONHxYacGTI0qotm+Ymp1J/BG0bcCuoUAjUxhOGqzuV6FjNhimWXS7jP9vm/5
         rNBgMj8w9ALtPOa6+jm2vGHEGWOWjcEjie/VHroICGwY8Zf+7Rfo5suvqTGtasdrFJG1
         m1VtmdmMQE2E3oyUpnO8mGT5cU0td+uXWM84ESmYLXCPKtx/AMbBYEqgFF1nKdxis1qJ
         +CObol7zE5qMekaHN6PXsYAHcpg3SN/5e60/6l9LoldCSdx5cCWD9lu6MytU8xe4LUxG
         oXYbvgDt8maemdJVoepAeBNeh6rqlMKytVBIH5gBjUKbrDbpVObOOzIa/s7Xel49EWw7
         LwPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849168; x=1783453968;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7jL7x6MybyatejrGYVunRlmuamZBlc/HwD0QKy8gmec=;
        b=p0ppisde3YoVbZVfopuxRYYerywoxr813hFaflE0y9ZsGBoaYeA802uCFndz9f4qqZ
         mUypnRM2FBrIZW5R+yDKwQpMsDkdTbLkkqLKe7AViD/6DI2W6t9lDKgq1/k1eHo3UWtq
         3wn6/GpL5tIDe+BmWarCJkjZuIDhSl1bGhNaugYF+/ZBRu/kH+pYSLibpdIGjjvgsAOt
         Gd5GABoxKJ28AkJ6WsVU+PnWlO+Z32BSYgUN/hIq5TbnJnKguAF9uxl93wL73HNy2Ggl
         4Mws/SHs4EtdslQ40W2vArCw+K5Q3Ip96a8r7ZAt5AqZauis3tGG7Cw51rdzqWh311qv
         E/JA==
X-Forwarded-Encrypted: i=1; AFNElJ/xcsOzPRArzuIS604n1/Lj3Yk0wtgp9aLFspcu9KAbvwwc2F2giERxnA1+5TFzAgfrOuXQcUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWpmO9WTFI9rD/edbJmTA3LxNmAJOTYkm/q9n0bPwSEqczUyxw
	RLyxpss09Bk7lqyjW7Z0dwrxt+h7VSMTaURX5hxFBtY+uBzS/gYVEE+aPl8XlvawgvnD8PWOLEY
	E1crdwUZtB8RC/KJW6fUth1DvdFNkZUg92ayww1vb
X-Gm-Gg: AfdE7ck3HHuJU8atyCUIqB6leEYP0u7hJVi/BLcA2bmys19eeNnUKdyaeDNsAEX2fUV
	SUeUoxphNTLdN5gT7WC7DIsURBETi1h2tIR8nkeMG5/y6Z6xYmvY79WlvbF+JbyJDk7Lv39IvOR
	k1JnSgwm544W7/5rE+GxrEhucMSh8EAQNZuvF87+FNd9fdMCJ+uTughpx7Z4mPvngDDC7PvF5Tt
	iY1WRsu0NScxLzeKH5FhB4LJGW4HZjYrcBgTsHXOvGokJ95ylouL10attWOanRwfRc0OrWIvBap
	gV2TCsVkFZPznrjTYgmZAXCQ9D2l6sdVKOlvUZI7Lcso0V20QoqjELLhvKoi110L7/jSVF4gu95
	7Ii5G39a8ikkG5SxgtbJeuZjsDy3iANafA5r8Ea9KDgmS6TEE
X-Received: by 2002:a05:7022:41a4:b0:139:819b:f5b7 with SMTP id
 a92af1059eb24-13b2a1ac2bfmr3338103c88.29.1782849167632; Tue, 30 Jun 2026
 12:52:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629181226.1929658-1-kuniyu@google.com> <20260629181226.1929658-8-kuniyu@google.com>
In-Reply-To: <20260629181226.1929658-8-kuniyu@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 30 Jun 2026 12:52:36 -0700
X-Gm-Features: AVVi8CfIKyGVcabDMfxFytwjHCP1PFkY2flhFLcdjP1PkHe3DB6TNIYg_38Z6XI
Message-ID: <CAAVpQUDtJ4eqxoWe-SA4BiNtxnKNZfa1-Gw9aFKUX0U42MgrRw@mail.gmail.com>
Subject: Re: [PATCH v1 net-next 07/10] net: fib_rules: Drop RTNL assertions.
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303352-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6B196E7ABB

Replying to Sashiko review.

On Mon, Jun 29, 2026 at 11:12=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
>
> Now, fib_rule structs are protected by per-fib_rules_ops mutex.
>
> Let's drop ASSERT_RTNL_NET() and rtnl_dereference().
>
> Note that fib_rules_event() iterates over net->rules_ops without
> net->rules_mod_lock, but this is fine because all fib_rule users
> are built-in and concurrent fib_rules_unregister() does not happen.

---8<---
Is this description accurate?
---8<---

Yes.


---8<---
It appears that unprivileged users can trigger a race here via user
namespaces. If a user creates two network namespaces with a veth pair, movi=
ng
one interface to each, and then triggers netns destruction on one namespace
while concurrently deleting the veth interface from the other namespace:
...
---8<---

Sashiko somehow thinks it's possible to remove a netdev and dismantle
another netns, both of which require RTNL, so false-positive.



>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  net/core/fib_rules.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
> index 25a3fd997782..5eef5d6ace82 100644
> --- a/net/core/fib_rules.c
> +++ b/net/core/fib_rules.c
> @@ -387,7 +387,6 @@ static int call_fib_rule_notifiers(struct net *net,
>                 .rule =3D rule,
>         };
>
> -       ASSERT_RTNL_NET(net);
>         lockdep_assert_held(&ops->lock);
>
>         /* Paired with READ_ONCE() in fib_rules_seq() */
> @@ -955,7 +954,7 @@ int fib_newrule(struct net *net, struct sk_buff *skb,=
 struct nlmsghdr *nlh,
>                 list_for_each_entry(r, &ops->rules_list, list) {
>                         if (r->action =3D=3D FR_ACT_GOTO &&
>                             r->target =3D=3D rule->pref &&
> -                           rtnl_dereference(r->ctarget) =3D=3D NULL) {
> +                           !rcu_access_pointer(r->ctarget)) {
>                                 rcu_assign_pointer(r->ctarget, rule);
>                                 if (--ops->unresolved_rules =3D=3D 0)
>                                         break;
> @@ -1064,7 +1063,7 @@ int fib_delrule(struct net *net, struct sk_buff *sk=
b, struct nlmsghdr *nlh,
>
>         if (rule->action =3D=3D FR_ACT_GOTO) {
>                 ops->nr_goto_rules--;
> -               if (rtnl_dereference(rule->ctarget) =3D=3D NULL)
> +               if (!rcu_access_pointer(rule->ctarget))
>                         ops->unresolved_rules--;
>         }
>
> @@ -1082,7 +1081,7 @@ int fib_delrule(struct net *net, struct sk_buff *sk=
b, struct nlmsghdr *nlh,
>                 if (&n->list =3D=3D &ops->rules_list || n->pref !=3D rule=
->pref)
>                         n =3D NULL;
>                 list_for_each_entry(r, &ops->rules_list, list) {
> -                       if (rtnl_dereference(r->ctarget) !=3D rule)
> +                       if (rcu_access_pointer(r->ctarget) !=3D rule)
>                                 continue;
>                         rcu_assign_pointer(r->ctarget, n);
>                         if (!n)
> @@ -1400,8 +1399,6 @@ static int fib_rules_event(struct notifier_block *t=
his, unsigned long event,
>         struct net *net =3D dev_net(dev);
>         struct fib_rules_ops *ops;
>
> -       ASSERT_RTNL();
> -
>         switch (event) {
>         case NETDEV_REGISTER:
>                 list_for_each_entry(ops, &net->rules_ops, list) {
> --
> 2.55.0.rc0.799.gd6f94ed593-goog
>

