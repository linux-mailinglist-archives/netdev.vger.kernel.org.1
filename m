Return-Path: <netdev+bounces-307243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aCwHEHgQVWpQjgAAu9opvQ
	(envelope-from <netdev+bounces-307243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:21:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2AC74D89A
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 18:21:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=oluFiQoF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307243-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307243-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D83CF30591B5
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 16:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D4F40BCA9;
	Mon, 13 Jul 2026 16:18:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E331240756E
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 16:18:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783959539; cv=pass; b=WjWCfeiQvSMhLZNCX3oVFWVfTwwyWl8YAEgff8EtYQVnsbvdkAyqLg4AxYrCEw9LzvFLyoXsxrnsBzjIMMWyPUdUXLUXbVH5wapj1Tr8el0i0M8AA0DSR2GL8WiRHd8ClwQ6AsPRtQSWefDCKVDMr8nkjxGvkhdGe0SvfjNlBy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783959539; c=relaxed/simple;
	bh=IgUBDAc7uROr6GpgG1hnysnVvrlnG6dWZhfdYiIRH5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pt5jbmQV0yIe9se54ot5Iuh14odNY694OwbJ4GhTv+VC2B0zV7E9aRhGjvK7KlCQxbINb5ZkbSCAnzT9/QE+nehUNz67jGyuXVWGNu1EJ5Fi8HPRa74hrSPTz1HUg3XCnyVeyiE0pnoWsEPrU9zz+ZwhNkZmsA3trjDU0wDHcq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oluFiQoF; arc=pass smtp.client-ip=209.85.218.42
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c15d5468673so15173866b.0
        for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783959535; cv=none;
        d=google.com; s=arc-20260327;
        b=p3WmOvel34rwQVoy0xhDGRNi6L82HFwGR4TZuDEoBAosy1vsg+Qo+wk0WCG9zPPWp5
         itGVE/vwfFEqdk08VZ/YxJlFBHjbjGCrIH1fehsIdGCEWPi2osevwmx5/ZfSVPhwZi0r
         i2duT1e80sMIIfs2fJSAihOssotFDTLfHcszVWLiqQV7hoRKIY5o+c7BZM8VW3tVFxON
         vizKJYfElhoFTL3hoBMlkEPQZ+lCZoAKKdadmBo7Kc0jpjvwTODE2ABKlpe6zJrap5CX
         XMId3OTtEg/sag55V5fkZY5ogxBU5DIOduBjCCecNMdijoNZsxYVY7Xtnz8DloX1PgvX
         uZXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9543NKwiKLQgsi8qtC001tzOTSQxH1KY7XkZdcSvQ5g=;
        fh=4/cmxA0ZsVjKAH90kxLLH8zQIPMihrnm3kws1yd3UxY=;
        b=ZCpTKr71XYvgqfe7cDWuey6Or3lZwoWE+dVYEt31SUIB3p2DMGMv5CgTanahJAzjl7
         sNbGfIFThmMjmCG+Z0f/Cld5lf3vWsYcS76rRlZrDAKrVQTBx/9+ktxz3fOTW92zLT83
         wFS4Al3c4EG6FacYixU7z/qTwRDFI6uj7jZPjUbp5k2rCds0+1Ayy76WdK37BX6UfQY3
         wAnCdsUd3dpOBL0k0vwcCXBbW0eK3lI8G6f4UCOLhkIZN39LBbXF3gO+3j4JdXhrXvuJ
         1FScDdf1tS0qYkgpq3A8ddmq8H9l6WOEveCZdFUXpExkb9eTbgdZELq/+mcWl2B54H4m
         Xakw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783959535; x=1784564335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9543NKwiKLQgsi8qtC001tzOTSQxH1KY7XkZdcSvQ5g=;
        b=oluFiQoFYYG44r0ELqIzMDSdOfXhcfK/1ZpAgwPQEOAdAZFsjWN4n/Y9gcZUvpIMjo
         urAIBVl41pOrgBfAOKgP7121xQKKuAP38ZQdnR1Br2l/rhsExXVnmreCvMSCIyLhG8Rl
         rT9KPWRzX2y1DBGiuvHDSdw3MI9475mdLayVxny/7qtPbJEo18D8IFUMudxGtwlZUysv
         mOy+lUlXoOVOY6CkoJT82m4DBZV3URGPpT6wjDh/mPuVmQ5tpxf736kUGJDkAQfDQ4+3
         BJERIacKsBclYNGKAYZCYeHEk4n6zXB1f7r3GnkexZTBc/wTs+egNVRXZl2yalKIFTBi
         HWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783959535; x=1784564335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9543NKwiKLQgsi8qtC001tzOTSQxH1KY7XkZdcSvQ5g=;
        b=jBueJeWMIuClGMk/1RjHzGKKKX5xF7BoazE4wMGE8pY3gQnzJ+EW/gIj7q/EpDLGey
         esuAr7rXqV7T/docun1ZaH1x1zSTDtI7l+APLEWYCS4ZIdOeP4B+6vP80djq/SRISl1l
         Ma0S3EtAfzKXoqieasspW/uooi5qqLn7setHz6cu4SWG4aE1tdG02FPo7M8+pJeWFU97
         r+AxnfIxLpIWhSEenlWUXzAsx98XN24VKZ3tb+FmahDgrm9xywR4eHmQbsru1nNYqZxs
         owFLCHBwfkQQ93BuzSVc17IzggVALx70opl2mm+79a8crEOkIF6H1qpF+SpFevKa5yS+
         GaDg==
X-Forwarded-Encrypted: i=1; AHgh+Rq89MiS5ovUC/CGfAXMGE9Sdm0U6aiF+u2tVExOePnX4pmNAf4P0kmiuK9Hjlfw6aNXDvgfKuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTpRJrYftTpw8dmZffWKcFdwtGQQWBXb8ajX1/x1Ku1CqlxzHy
	guG0GuO6c7pQn8rCBiDK5i4maRxUQormvpat4UnZQrSRySpvOleFKoGBimX4mf6+AkWEEcewxS2
	S98FNBMSBmcEf28VFUX/W19B3WnuFRtE=
X-Gm-Gg: AfdE7cmMZ/Yz3X6D30jChq0nL2SDVGWwl1uWmUs7iYe5VTNWXuwebMlh1oRGIgzWjGK
	BtJ4cDVd+e0S6fDIEsVXE0FvaQAMKDsRDhJOe5DCDmY9K2KTwT7vZIEfmWs0L2HDOF0OC3+26zG
	8+3I/1Ub4NybbiTMWPh8hqzGs2qNIGBCIigss0KDM0dc+prXK2Y/hs6Be1BhVR7jilSwPxJ2bJf
	P0aRfeAfklfRc1lyTxvT1kC2SPvejfa6diCSI3yRD08o4Co56OHaEu/NFO4DWkcwel959sEmfYN
	2neK/uI6RVHZ/j1+QekUVg5LbXzk
X-Received: by 2002:a17:907:94cf:b0:c16:242a:472f with SMTP id
 a640c23a62f3a-c16242a5889mr387661666b.23.1783959534948; Mon, 13 Jul 2026
 09:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704062234.2625208-1-bestswngs@gmail.com> <e3bb8ad1-cb24-5d74-6ca6-a7a1e41fb133@blackhole.kfki.hu>
In-Reply-To: <e3bb8ad1-cb24-5d74-6ca6-a7a1e41fb133@blackhole.kfki.hu>
From: Weiming Shi <bestswngs@gmail.com>
Date: Tue, 14 Jul 2026 00:18:16 +0800
X-Gm-Features: AUfX_mwmodbrNCtcVBLuQvOELt3jqNJGuYrMFhI_EA5_XzVr_n3M1ChoNx00WdE
Message-ID: <CANgPUi1akLRZjwTxw_7_JzBs2tgDx5k5M32vE3hosmkfhkM+aw@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: ipset: skip extension destroy on hash
 resize replay
To: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-307243-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kadlec@blackhole.kfki.hu,m:pablo@netfilter.org,m:kadlec@netfilter.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kfki.hu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E2AC74D89A

Jozsef Kadlecsik <kadlec@blackhole.kfki.hu> =E4=BA=8E2026=E5=B9=B47=E6=9C=
=8813=E6=97=A5=E5=91=A8=E4=B8=80 20:59=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On Fri, 3 Jul 2026, Weiming Shi wrote:
>
> > During a hash set resize, mtype_resize() copies each element into the
> > new table with memcpy(), so the new-table element shares the old-table
> > element's comment extension.  An xt_SET delete on the old table during
> > the resize destroys that shared comment via ip_set_ext_destroy() and
> > queues a replayed delete on h->ad.  After the table swap mtype_resize()
> > replays it with mtype_del() on the new table, whose copy still points a=
t
> > the freed comment, so ip_set_ext_destroy() frees it a second time:
> >
> > ODEBUG: activate active (active state 1) object: ... object type: rcu_h=
ead
> > WARNING: CPU: 3 PID: 5311 at lib/debugobjects.c:514 debug_print_object
> > Call Trace:
> >  <IRQ>
> >  kvfree_call_rcu (kernel/rcu/tree.c:3825)
> >  ip_set_comment_free (net/netfilter/ipset/ip_set_core.c:397)
> >  hash_ip4_del (net/netfilter/ipset/ip_set_hash_gen.h:1098)
> >  hash_ip4_kadt (net/netfilter/ipset/ip_set_hash_ip.c:96)
> >  ip_set_del (net/netfilter/ipset/ip_set_core.c:813)
> >  set_target_v3 (net/netfilter/xt_set.c:412)
> >  ipt_do_table (net/ipv4/netfilter/ip_tables.c:346)
> >  __ip_local_out (net/ipv4/ip_output.c:119)
> >  icmp_push_reply (net/ipv4/icmp.c:397)
> >  __icmp_send (net/ipv4/icmp.c:804)
> >  __udp4_lib_rcv (net/ipv4/udp.c:2521)
> >  ip_local_deliver (net/ipv4/ip_input.c:254)
> >  ip_rcv (net/ipv4/ip_input.c:569)
> >  </IRQ>
> >
> > The replay passes a NULL ext (the kernel-side delete that queued it
> > already destroyed the extensions), so skip ip_set_ext_destroy() when ex=
t
> > is NULL.  This also avoids the NULL ext->target dereference that was on=
ly
> > kept safe by the new table's ref being zero.
> >
> > Reachable from an unprivileged user namespace.
> >
> > Fixes: f66ee0410b1c ("netfilter: ipset: Fix \"INFO: rcu detected stall =
in hash_xxx\" reports")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> > net/netfilter/ipset/ip_set_hash_gen.h | 6 ++++--
> > 1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipse=
t/ip_set_hash_gen.h
> > index 5e4453e9e..bc909ae2d 100644
> > --- a/net/netfilter/ipset/ip_set_hash_gen.h
> > +++ b/net/netfilter/ipset/ip_set_hash_gen.h
> > @@ -1080,9 +1080,11 @@ mtype_del(struct ip_set *set, void *value, const=
 struct ip_set_ext *ext,
> >                       mtype_del_cidr(set, h,
> >                                      NCIDR_PUT(DCIDR_GET(d->cidr, j)), =
j);
> > #endif
> > -             ip_set_ext_destroy(set, data);
> > +             /* On a resize replay the extensions were already destroy=
ed. */
> > +             if (ext)
> > +                     ip_set_ext_destroy(set, data);
> >
> > -             if (atomic_read(&t->ref) && ext->target) {
> > +             if (ext && atomic_read(&t->ref) && ext->target) {
> >                       /* Resize is in process and kernel side del,
> >                        * save values
> >                        */
>
> Please rebase your patch against the nf-next tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git): th=
e
> second chunk of your patch is not needed as it has been fixed.
>
> Thank you and best regards,
> Jozsef

Hi,

Thanks for your review. v2 sent.

Best regards,
Weiming Shi

