Return-Path: <netdev+bounces-301742-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nfBuG1gSPGr8jQgAu9opvQ
	(envelope-from <netdev+bounces-301742-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:22:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B186C0521
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:22:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=E0vrIAUX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301742-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301742-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4279A300953D
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8413DCD90;
	Wed, 24 Jun 2026 17:22:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB2C36EA88
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 17:22:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321736; cv=pass; b=VurvBixA8mbA27qLs6M2ltHE0j/KkRzIiB3NjNbpeGnWaqLfn/0x9jZ9kDEmofPI2eZp/RDpYsqW5ykYfmHH1idzlFUUvJ7YZC9/tTwUPjsMS+xa6NU5bcM2XbJcZ3ByHOuT4q6Ri4XXVS5pxIFaBl2gs7s1hbOZaPnlw25S6sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321736; c=relaxed/simple;
	bh=SzOGeYej1D3PVf55SFyacAgmv2a2bZUZcnTV6d98zwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lboGkaMMpA94Trq0f+o+n2+qrVE6sIog1/fKIoS1gGK8vxrPKQk0aZ/+BNIRL1I84RD6qyAan0u+XK5eyBLhZ74hD3IdtJ72rYM8t1cGrzkNiLJLKCE+w6peBsfsAciIEObpPPtH0BmTppUB6ili8MEXvyHo9snT9U+J8+rFLoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E0vrIAUX; arc=pass smtp.client-ip=209.85.160.182
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5176fc0cc72so12072091cf.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 10:22:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782321734; cv=none;
        d=google.com; s=arc-20240605;
        b=XTZ8jWmNlFAS0laHms45AssHSn+JG56vzxNxIra3VLrWAD6N3+HcChNr5WjQ5LAEme
         divlYdXKH67zcJnf6kE3pbAjG1Q/Gq+0PYENDyqBNGELTMmy4DdIbs2T67Z29JSrFbDy
         8m3RBkPDGa8FWGvptqI5Tt/Q2XsphYHjGERHq7X2SK+I4M/O1BVRloZTIvPC87pOHAQ0
         zuVY7wxqAhJCT/Zg9u+ktsqhg/2KI43Ohg3/ZNNqjRcEALr95JaBS1Fg9dLNqD0dZWRG
         s7qqBPJQ6LUF4va1UirR5Rl+2jKLYZAPzAOsGJAMkKpZzo69/HhHZUpOsL/Mz7qmhuFx
         2pew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+DtQ0ms2+9uuo3MPcURrNHJAcns5kzVKFvrPom5Ywmc=;
        fh=7xiu5CJm2N+jJtR5E8codZNofSEpvRo87TlvIZGh+Yo=;
        b=VuoGwf3zqXJdmehjj8zKw7HI2kwH6k+A6LxTUiBjsuP4Tx4Ec/N1GePDWV0fGVJxCT
         kUJ7k7hjKPhICgBvwRXUDtb/cOYgRHPf5bRdhDOars1vAw1TIpUY2UQnUqRFMKXArxA9
         PgCiniL3hPk1N/HqU1pT6a53vrwHkapB++ELFoWL43mIpr1KFv0fzbDtp6+UNiuoW2SS
         3kYbe4j+xzdcGsBguV7iaVJUWxycZVOvAPqXX4o1/9NFgeSx9Pt4XLPLiLJj8bTK2zf7
         lWyGT5jNFlMCQN1gLYY+I2FzIKduruc68AF7SKSFh+2c/KStLeWgN+zwDttuFrW/Da6q
         s4Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782321734; x=1782926534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DtQ0ms2+9uuo3MPcURrNHJAcns5kzVKFvrPom5Ywmc=;
        b=E0vrIAUXes6jC6kGLexqkcXlZlOyG9oIuU8rMwOXXMdTCPQWOacvA0+w2ekEoAjYR8
         foSTJiDBJsdMIokeOz3qM+ETgR+gkEelP3HjiSbeNXEIsa/szJhT6Z4oC6luuEJYB5vx
         otxmK7KWRQRIvvord3soPsHYfel9o+xgaFUsfRZ+lGXUf8cieemptw4Osg5ZLE7HR3l3
         udhuV+q5C3sYEhFLJ0gq4Kf/lXnIU2XtPWDRjSuYhL69cpjMo+FHfAedD0Ex3a9tLWaf
         dpjJC2rg1MeTPjp4o36cS2buGA9s8/aOVCkz3bBsNpwgUvPR5C4eu1IBtZ6rZAaav6pR
         zS4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782321734; x=1782926534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+DtQ0ms2+9uuo3MPcURrNHJAcns5kzVKFvrPom5Ywmc=;
        b=tZX9GHbkGhzkNpR/ptcNdN4V8urQ3OWck0VapU5dAyVRXbgIIUBEBff4YjRSQ8BfDI
         hqCO3DpPUqn0viXTMcnVI5GhKVKQzbLRFj+gl0y6QzAZIUoxE9vCe+joegrZ9TBU7oBp
         4ZYEoHRqFMnPr5o0xNvXRfb4i3Vk3YUyEJU72WFnkwKLn4qWi/bgCu1JkCGBbvvj1oG7
         m7ZMc/C6OMUKIrztiuc+FcFNHfCZsr22e5VNtT0pcFWhlAEOvjgJdRxqOFuzn9NPddi0
         iyZ4NyuCNoFKeCyFRtaN4BbsBMxH2CtM5QsmeQwOHPK8eJH+fXY5Rn6ZtaMOKR+dPzLV
         qz0A==
X-Forwarded-Encrypted: i=1; AFNElJ8B3mPyAHUIHgHkBoLxsD9gPu5LrpLe3Ia+QTbAoznCbhyK/rkha2rcJPeifVtwiWDlZ2lN37I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlVnaMNl+u9Brh6cmVp7vzCoISTiknRh+/dPLsti7gMK5CwK+H
	hQBeNi8CSE7Ju7nUJi3i7BdHpOCsnhUpmxQu+9xDXFonvYr3k8t4OpPJDZZwuBO7NuT9NC1gySY
	IJHcEFIWI//9ymJVf1acUVE7uO78dcLbCEdTgi7A9
X-Gm-Gg: AfdE7ckRM+ywYaX721F5tc9P8aoGT2Vztte40yio6bAdbCWq06jaB/m8WLMXvzuL04s
	U6OZPQq16lomaovmKrjFulmPg1UxFtt6iFFcV1hkFuVuREWb/Sx9XZ+lu7ssUxPWb3D2SPn/PDN
	PBNyB7ZVN2z9k9bNqT3vIz11yY+SgtepsqmTppj0r9D5rj+H0iSBcyGoP/lhS40IIReltQRwAFG
	1REK/oh3CoItUDq+QeiwBdily7xR6pGvorOCvFDOST0NwTs6KcwVAFA/HsHU8esOfG+wSHA4XgA
	0j9ft0XQd0yNCHth/eKlQrbNJdb/Ft/3dDtG3Ln4VxWdrQyCLq801ZdpVqFSLqYOGdpuUaoClCd
	aOE/VTzHICg==
X-Received: by 2002:ac8:5914:0:b0:519:f02b:45cb with SMTP id
 d75a77b69052e-51a61ba92e2mr58504221cf.26.1782321733203; Wed, 24 Jun 2026
 10:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624171156.822055-1-zhangfeionline@gmail.com>
In-Reply-To: <20260624171156.822055-1-zhangfeionline@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 24 Jun 2026 10:22:02 -0700
X-Gm-Features: AVVi8CeGGO5ftFjp7zM7MBtkbPMykBRTKgX4L356RvckP-xExeKMm6obLudGOkk
Message-ID: <CANn89i+SdKsYnqOqivUO0oOKzm1pDP+jAkVqqMH90GKbjKX_9g@mail.gmail.com>
Subject: Re: [PATCH] ipv6: fib6: fix NULL deref in fib6_walk_continue() on
 multi-batch dump
To: Pengfei Zhang <zhangfeionline@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chenzhangqi@xiaomi.com, baohua@kernel.org, 
	Pengfei Zhang <zhangpengfei16@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:zhangfeionline@gmail.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chenzhangqi@xiaomi.com,m:baohua@kernel.org,m:zhangpengfei16@xiaomi.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301742-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,iu.edu:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B3B186C0521

On Wed, Jun 24, 2026 at 10:12=E2=80=AFAM Pengfei Zhang <zhangfeionline@gmai=
l.com> wrote:
>
> From: Pengfei Zhang <zhangpengfei16@xiaomi.com>
>
> inet6_dump_fib() saves its progress in cb->args[1] as a positional
> index within the current hash chain.  Between batches the RTNL lock
> is released, so a concurrent fib6_new_table() can insert a new table
> at the chain head, shifting all existing entries.  The saved index
> then lands on a different table, causing fib6_dump_table() to set
> w->root to the wrong table while w->node still points into the
> previous one.  fib6_walk_continue() dereferences w->node->parent
> (NULL) and panics:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000008
>   RIP: 0010:fib6_walk_continue+0x6e/0x170
>   Call Trace:
>    <TASK>
>    fib6_dump_table.isra.0+0xc5/0x240
>    inet6_dump_fib+0xf6/0x420
>    rtnl_dumpit+0x30/0xa0
>    netlink_dump+0x15b/0x460
>    netlink_recvmsg+0x1d6/0x2a0
>    ____sys_recvmsg+0x17a/0x190
>
> Fix by storing tb->tb6_id in cb->args[1] instead of a positional
> index.  On resume, skip entries until the id matches; a concurrent
> head-insert can never match the saved id, so the walker always
> resumes on the correct table.
>
> Signed-off-by: Pengfei Zhang <zhangfeionline@gmail.com>

Patch looks good, but you forgot to add a Fixes: tag

Perhaps:

Fixes: 1b43af5480c3 ("[IPV6]: Increase number of possible routing
tables to 2^32")

> ---
> The same crash was independently reported in a production environment
> (kernel 5.15.137, triggered by ovs-vswitchd issuing RTM_GETROUTE):
>   https://lkml.iu.edu/hypermail/linux/kernel/2402.3/02068.html
>
> The crash is probabilistic and occurs in fib6_walk_continue() at the
> FWS_U state:
>
>   case FWS_U:
>       if (fn =3D=3D w->root)
>           return 0;
>       pn =3D rcu_dereference_protected(fn->parent, 1);
>       left =3D rcu_dereference_protected(pn->left, 1);  /* crash here */
>
> The crash dump shows fn->parent is NULL.  At first glance this looks
> like fn is a leaf node whose parent was freed, but closer inspection of
> the walker state reveals fn->fn_flags has RTN_ROOT set =E2=80=94 fn is it=
self
> a root node of a routing table, not a child node.  A root node has no
> parent by definition, so fn->parent =3D=3D NULL is correct for that node.
>
> The real question is why fn !=3D w->root despite fn being a root.  The
> answer is that w->root and fn belong to *different* tables: w->node
> (which became fn during traversal) still references a node from the
> table that was being dumped when the batch suspended, while w->root was
> silently redirected to a different table on resume.
>
> This misdirection happens because inet6_dump_fib() uses a positional
> index to resume across batches.  Consider a hash slot containing two
> tables [A(pos=3D0), B(pos=3D1)] where B is large enough to require multip=
le
> batches.  On the first batch, B suspends mid-walk and the loop saves:
>
>   cb->args[1] =3D e;   /* e=3D1, position of B in the chain */
>
> The RTNL lock is then released.  At this point a concurrent
> fib6_new_table() inserts table C at the chain head via
> hlist_add_head_rcu(), making the chain [C(pos=3D0), A(pos=3D1), B(pos=3D2=
)].
>
> On the next batch, inet6_dump_fib() resumes with s_e=3D1 and iterates:
>
>   s_e =3D cb->args[1];   /* s_e =3D 1 */
>   hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
>       if (e < s_e)     /* skip C at pos=3D0 */
>           goto next;
>       /* e=3D1: tb now points to A, not B */
>       fib6_dump_table(tb, skb, cb);   /* called with wrong table A */
>   }
>
> Inside fib6_dump_table(), w->root is unconditionally overwritten
> before the resume branch is entered:
>
>   w->root =3D &table->tb6_root;        /* now A's root              */
>   /* ... */
>   } else {
>       int sernum =3D READ_ONCE(w->root->fn_sernum);  /* A's sernum  */
>       if (cb->args[5] !=3D sernum) {
>           /* sernum changed: safe reset, w->node =3D w->root (A)    */
>           w->node =3D w->root;
>       } else {
>           /* sernum unchanged: w->node untouched, still in B       */
>           w->skip =3D 0;
>       }
>       fib6_walk_continue(w);   /* sernum equal: w->root=3DA, w->node=3DB =
*/
>   }
>
> The sernum guard was intended to detect tree modifications and reset
> the walk, but here the two tables happen to share the same fn_sernum
> value (a global flush had previously unified them), so the guard does
> not fire and w->node is left pointing into B's tree.
>
> From this point w->root and w->node belong to different tables.  When
> fib6_walk_continue() traverses upward and reaches B's root node
> (fn->fn_flags & RTN_ROOT), the exit check:
>
>   if (fn =3D=3D w->root)   /* B's root !=3D A's root, check fails */
>       return 0;
>   pn =3D fn->parent;     /* B's root has no parent: pn =3D=3D NULL */
>   left =3D pn->left;     /* NULL deref -> crash */
>
>  net/ipv6/ip6_fib.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index fc95738de..bda492634 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -636,11 +636,11 @@ static int inet6_dump_fib(struct sk_buff *skb, stru=
ct netlink_callback *cb)
>         };
>         const struct nlmsghdr *nlh =3D cb->nlh;
>         struct net *net =3D sock_net(skb->sk);
> -       unsigned int e =3D 0, s_e;
>         struct hlist_head *head;
>         struct fib6_walker *w;
>         struct fib6_table *tb;
>         unsigned int h, s_h;
> +       u32 s_id;
>         int err =3D 0;
>
>         rcu_read_lock();
> @@ -701,23 +701,22 @@ static int inet6_dump_fib(struct sk_buff *skb, stru=
ct netlink_callback *cb)
>         }
>
>         s_h =3D cb->args[0];
> -       s_e =3D cb->args[1];
> +       s_id =3D cb->args[1];
>
> -       for (h =3D s_h; h < FIB6_TABLE_HASHSZ; h++, s_e =3D 0) {
> -               e =3D 0;
> +       for (h =3D s_h; h < FIB6_TABLE_HASHSZ; h++, s_id =3D 0) {
>                 head =3D &net->ipv6.fib_table_hash[h];
>                 hlist_for_each_entry_rcu(tb, head, tb6_hlist) {
> -                       if (e < s_e)
> -                               goto next;
> +                       if (s_id && tb->tb6_id !=3D s_id)
> +                               continue;
> +                       s_id =3D 0;
> +
> +                       cb->args[1] =3D tb->tb6_id;
>                         err =3D fib6_dump_table(tb, skb, cb);
>                         if (err !=3D 0)
>                                 goto out;
> -next:
> -                       e++;
>                 }
>         }
>  out:
> -       cb->args[1] =3D e;
>         cb->args[0] =3D h;
>
>  unlock:
> --
> 2.34.1
>

