Return-Path: <netdev+bounces-292357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIyGJqwSF2pf3QcAu9opvQ
	(envelope-from <netdev+bounces-292357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:50:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C95105E72DD
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD3F9311F8D2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A323AA507;
	Wed, 27 May 2026 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="qG0mezKr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154323033DF
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896080; cv=pass; b=M9m5DfMQNqVOnX1MPojqIsh4iJVnD22XlAp1bBPPFkD++ELtiMIhrXorp/WW+ud/B8rFRI9tnGIwGYAN/8jR2NN0Cz1wPdDhgXiyU2y26bcM1F/WS3VGQBVH3/xrb8qTOiBmg1AMQGun4kgtsXA+yX2taouV8HWwZ5ewaRkFepw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896080; c=relaxed/simple;
	bh=39fJw59A1j8AFUeERM/bxuE4NAvIkOFiiHdZd3vi0Dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVVhf7UTpHo2DEHb4jO92a8ZuywHfA6robEgNZ4B+DG9LhxxBRUjjtMNGVTvgijA8kiK1o0jAdXhH0D6xCr9gqIyVnNRNVX+0F7FSAm+0kWq8iUONjpxpVmKu7MHAjdfiRe9dlKtCvc806WF1K8ZcKH/4vmepFnT7mrsKwAlpyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=qG0mezKr; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8025f1c227so9106214a12.2
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:34:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779896075; cv=none;
        d=google.com; s=arc-20240605;
        b=grNNp0hsCuslWHlGSfsV1nTztCr5y2YDssBLjFJqTR9QY4bnikjW1vQ2JjHsrJKrB0
         Q9jZu368V72E3SkPoxbVgjmZtBuoSPOZXIO3C1IK5fZ/M+mpFhSOT20WGH3CEf591cf8
         8EbPftTPzrQksWYj8jyotT4Kb/7Bt7cJmt31o6i/lceArtUYmfRJhJ/MHXB8XUqBAEui
         AgvMN7vNhhTRID8NuDRGsiXLJ5PIIYlWP/qwYuTH+tVNNdFqsHXTCKJ68YqrstujcWiQ
         NPrgOQLU/bJ1IUkvzCv0P8VBJTWBpaDxAAU5DfvF8tOVz73dZD1ntNzGRSpRwo2iWLaB
         3aNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7i5he3xFS6NNV1pEkNJal4i/08w0Hk6VFzTzAuTBFFQ=;
        fh=xLmr3BgYswbxrl1OAvn56pinlO5Zxhhy/tRkr+c/5us=;
        b=WTWA0TWvpRC5870UzIrb7GLJ/TQzuTuOuuQxF1Xxa+OkjG8fM4PpGx0xVMxDplsU+G
         907r2NHBBE6potB/GvUotlugyXxShIqsSUSoPzVfBtAI3oJESgaMqlLuBIAQZ4iDyboP
         S+m7SPwBctoaw9k/bbtuGFgu3G+sXuK8CvBhlKHfD3jiiHulZJtvU5alxaWyAfQrLj+N
         DOAb1QMFchLxM6J4jdAh3+ApQrk+Dt7Ep+29PG99GA0QdYf2PrGulOTrjQxMcDAUA8Rs
         1sPOMmceoTnZ5jugrSRTLMS6omSbLZbrlwWdj/QkO50PdLnvrnBF2DfsPEWIlXl7Bgjl
         RSPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1779896075; x=1780500875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7i5he3xFS6NNV1pEkNJal4i/08w0Hk6VFzTzAuTBFFQ=;
        b=qG0mezKrPQTuz135X51hr5Yt/Rdfq2u9pESFQdfH1re68Y7KJ+ecVsBPbzqMRCmknE
         Yzo3SzokJoqsI2qnFqPAljm0cYlI68ATdomfb+VWNDOp32D6f95jgaMkuazFlgemvaWZ
         AbMgrx8QHJjz0x1kO0ZLdX/t3wDcbTr5FEpfUheRNHqWaYfnBhbwV+niSdYhtkWUtdTq
         e/oNHKHODBo46PL7fdUNbwP8amuie/D31lBfQ4BgLDOwN4HeRJB8rhXwaECxOdxRcGlc
         7kH/mWfAQZazu05OFwvvwC9VOP+8vkeyAoXBalc1oA3eqUhZ/TNeayHXKRpwZMHwTn0H
         cC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779896075; x=1780500875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7i5he3xFS6NNV1pEkNJal4i/08w0Hk6VFzTzAuTBFFQ=;
        b=q7Q0G22jSQxMYkFHOLDs0Fs6xLsMSdw6g7Kj/amL3/53pVQuBU0+UkKnwhosFeibFl
         Soxqd1UaBxj0N4iptU5BECm8KYe2rEr5S23e0MRhmtlW853WvHsFmdskA2NM5RHZe2R6
         Rsqdnoq8lAY4S5Zx64keN+k4binSFxkSWV6GIUNRn+PRnZFLL7VUhyEsrVWZHPPTm+jg
         uUWvLyKOrr2fU+CNpIpefODb+Tns2rCjB4Na80r1KAizr55PSeTUY/8EOU10RFmAkAgn
         rO/ygImeZkS2A/3JFlLZPQ5xxqKZOT6IjwejnkAqu+tZgH22Om683i9+pws25dtq2Ydb
         lp7Q==
X-Gm-Message-State: AOJu0Yx8uJys+EXi4n2f3UwGSjpolKlxoZYDxyU3zhITjlun7r+IWI7v
	01WORqiTZ5cpuywC3/lIC7Bddgygqx1fMI77t+Q01dalRemiUXYB/LEjPQU6SEaplsbsefQmlhX
	FdHYpYgbFj8EU7AvpcjKCqpeYJp45ii9keQ3OnYqR/RTcpiRXAR5IkoTM
X-Gm-Gg: Acq92OFA6FAADvOoYkQXdFVb5qyCtY2l58jOn8Lc6E2XYFTiB6sJD4nl1twS+B6Uk1i
	mu4ePG6+yzvfw5384zSlgnfidft1nwxSXEevzSiZmavnPfqS9v6IlKwB6LrM5mz5uiF8eS3Ug3x
	Dpf2/jBhR5NcllEFUkOdLuM4GLhGUgQEz0wGyZPVsmGN12DmiwfWh+w4rAq6oqAzzh+yOF5dOe3
	eMgHrHP50j3eb0RL65Aa0lYa7Wi8h+bTdofsBYJBqmGtbrUG7paslBFZr54qi59hvBq/4oEHXv6
	RRVBkth/AL7MQV/T4ucsTpro/jX9sA==
X-Received: by 2002:a05:6a21:3115:b0:398:7792:3882 with SMTP id
 adf61e73a8af0-3b328d15f0dmr24868580637.16.1779896075477; Wed, 27 May 2026
 08:34:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521131436.748832-1-jhs@mojatatu.com> <d22446ec-d5bd-4950-998f-2af15a46bfea@redhat.com>
 <CAM0EoM=CPeOaoMUjXEp3eGeBVjomyWYV-2qj0jMOP+DNvjuPMA@mail.gmail.com> <78db23f1-1ac7-4d87-97e5-668b685818c4@redhat.com>
In-Reply-To: <78db23f1-1ac7-4d87-97e5-668b685818c4@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 27 May 2026 11:34:23 -0400
X-Gm-Features: AVHnY4JomXPuN0pzsulR4HNKApZ9eY5c6VAo7MMHR6IUysl_mZTMZu1XcPzwH5g
Message-ID: <CAM0EoMnaqFgKBYBKrXh4tdbo6-JXC1HBhHWqOx=kQu9yFxk2fQ@mail.gmail.com>
Subject: Re: [PATCH v2 net 1/1] geneve: fix Use-After-Free in RX path
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, horms@kernel.org, victor@mojatatu.com, andrew+netdev@lunn.ch, 
	rajat.gupta@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292357-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: C95105E72DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 4:22=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 5/26/26 2:38 PM, Jamal Hadi Salim wrote:
> > On Tue, May 26, 2026 at 5:45=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> >> On 5/21/26 3:14 PM, Jamal Hadi Salim wrote:
> >>> Context: This commit fixes a UAF in Geneve. The UAF component was dis=
covered
> >>> because it is triggered by a buggy 'pedit' action[1]. the buggy pedit=
 uses
> >>> skb_store_bits() and can write into shared or non-linear data without=
 copying
> >>> the entire skb head. The Geneve device invoking either pskb_may_pull(=
) or
> >>> iptunnel_pull_header() is much more likely to reallocate the skb head=
, freeing
> >>> the memory pointed to by geneve's stale geneveh pointer.
> >>>
> >>> Note, although the patch looks big it's mostly re-arranging functions=
 to avoid
> >>> forward declaration.
> >>>
> >>> Sample UAF below:
> >>> ....
> >>> BUG: KASAN: slab-use-after-free in geneve_udp_encap_recv+0x2e8c/0x319=
0
> >>> Read of size 1 at addr ffff88811bab3c08 by task kworker/u32:1/62
> >>>
> >>> CPU: 4 UID: 0 PID: 62 Comm: kworker/u32:1 Not tainted 7.1.0-rc3-00182=
-g0e3e91779b94 #551 PREEMPT(full)
> >>> Workqueue: ipv6_addrconf addrconf_dad_work
> >>> Call Trace:
> >>>  <IRQ>
> >>>  dump_stack_lvl+0x8c/0xd0
> >>>  print_report+0xce/0x5e0
> >>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
> >>>  ? srso_alias_return_thunk+0x5/0xfbef5
> >>>  ? kasan_complete_mode_report_info+0x80/0x200
> >>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
> >>>  kasan_report+0xd6/0x110
> >>>  ? geneve_udp_encap_recv+0x2e8c/0x3190
> >>>  __asan_report_load1_noabort+0x18/0x20
> >>>  geneve_udp_encap_recv+0x2e8c/0x3190
> >>>  ? get_stack_info+0x38/0xc0
> >>>  ? srso_alias_return_thunk+0x5/0xfbef5
> >>>  ? __pfx_geneve_udp_encap_recv+0x10/0x10
> >>>  ? udp4_lib_lookup2+0x31c/0x700
> >>>  ? __pfx_udp_ehashfn+0x10/0x10
> >>>  ? srso_alias_return_thunk+0x5/0xfbef5
> >>>  ? __xfrm_policy_check2.constprop.0+0x40/0x5b0
> >>>  udp_queue_rcv_one_skb+0x65e/0xd20
> >>>  udp_queue_rcv_skb+0x142/0xb00
> >>>  udp_unicast_rcv_skb+0xd3/0x2c0
> >>>  udp_rcv+0x198f/0x2570
> >>>  ? srso_alias_return_thunk+0x5/0xfbef5
> >>>  ip_protocol_deliver_rcu+0x1f8/0x3c0
> >>>  ip_local_deliver_finish+0x362/0x5d0
> >>> ....
> >>>
> >>> [1]https://lore.kernel.org/netdev/20260519033950.2037-1-rajat.gupta@o=
ss.qualcomm.com/
> >>> Fixes: fd0dd796576e ("geneve: use GRO hint option in the RX path")
> >>> Reported-by: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
> >>> Tested-by: Victor Nogueira <victor@mojatatu.com>
> >>> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >>> ---
> >>> v1->v2 Address gemini-sashiko.
> >>> 1. local variable "len" initialization in geneve_post_decap_hint()
> >>>    Although doesnt contribute to the fix, it was introduced in fd0dd7=
96576e
> >>> 2. resolve out-of-bounds transport header for non-GSO packets
> >>> ---
> >>>  drivers/net/geneve.c   | 174 ++++++++++++++++++++++-----------------=
--
> >>>  include/linux/skbuff.h |   5 ++
> >>>  2 files changed, 98 insertions(+), 81 deletions(-)
> >>>
> >>> diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
> >>> index c6563367d382..dc5f5394836a 100644
> >>> --- a/drivers/net/geneve.c
> >>> +++ b/drivers/net/geneve.c
> >>> @@ -256,6 +256,79 @@ static struct geneve_dev *geneve_lookup_skb(stru=
ct geneve_sock *gs,
> >>>       return NULL;
> >>>  }
> >>>
> >>> +/*
> >>> + * Look for GRO hint in the genenve options; if not found or does no=
t pass basic
> >>> + * sanitization return 0, otherwise the offset WRT the geneve hdr st=
art.
> >>> + */
> >>> +static unsigned int
> >>> +geneve_opt_gro_hint_off(const struct genevehdr *gh, __be16 *type,
> >>> +                     unsigned int *gh_len)
> >>> +{
> >>> +     struct geneve_opt *opt =3D (void *)(gh + 1);
> >>> +     unsigned int id, opt_len =3D gh->opt_len;
> >>> +     struct geneve_opt_gro_hint *gro_hint;
> >>> +
> >>> +     while (opt_len >=3D (GENEVE_OPT_GRO_HINT_SIZE >> 2)) {
> >>> +             if (opt->opt_class =3D=3D htons(GENEVE_OPT_NETDEV_CLASS=
) &&
> >>> +                 opt->type =3D=3D GENEVE_OPT_GRO_HINT_TYPE &&
> >>> +                 opt->length =3D=3D GENEVE_OPT_GRO_HINT_LEN)
> >>> +                     goto found;
> >>> +
> >>> +             /* check for bad opt len */
> >>> +             if (opt->length + 1 >=3D opt_len)
> >>> +                     return 0;
> >>> +
> >>> +             /* next opt */
> >>> +             opt_len -=3D opt->length + 1;
> >>> +             opt =3D ((void *)opt) + ((opt->length + 1) << 2);
> >>> +     }
> >>> +     return 0;
> >>> +
> >>> +found:
> >>> +     gro_hint =3D (struct geneve_opt_gro_hint *)opt->opt_data;
> >>> +
> >>> +     /*
> >>> +      * Sanitize the hinted hdrs: the nested transport is UDP and mu=
st fit
> >>> +      * the overall hinted hdr size.
> >>> +      */
> >>> +     if (gro_hint->nested_tp_offset + sizeof(struct udphdr) >
> >>> +         gro_hint->nested_hdr_len)
> >>> +             return 0;
> >>> +
> >>> +     if (gro_hint->nested_nh_offset +
> >>> +         (gro_hint->nested_is_v6 ? sizeof(struct ipv6hdr) :
> >>> +                                   sizeof(struct iphdr)) >
> >>> +         gro_hint->nested_tp_offset)
> >>> +             return 0;
> >>> +
> >>> +     /* Allow only supported L2. */
> >>> +     id =3D gro_hint->inner_proto_id;
> >>> +     if (id >=3D ARRAY_SIZE(proto_id_map))
> >>> +             return 0;
> >>> +
> >>> +     *type =3D proto_id_map[id];
> >>> +     *gh_len +=3D gro_hint->nested_hdr_len;
> >>> +
> >>> +     return (void *)gro_hint - (void *)gh;
> >>> +}
> >>> +
> >>> +static const struct geneve_opt_gro_hint *
> >>> +geneve_opt_gro_hint(const struct genevehdr *gh, unsigned int hint_of=
f)
> >>> +{
> >>> +     return (const struct geneve_opt_gro_hint *)((void *)gh + hint_o=
ff);
> >>> +}
> >>> +
> >>> +static unsigned int
> >>> +geneve_sk_gro_hint_off(const struct sock *sk, const struct genevehdr=
 *gh,
> >>> +                    __be16 *type, unsigned int *gh_len)
> >>> +{
> >>> +     const struct geneve_sock *gs =3D rcu_dereference_sk_user_data(s=
k);
> >>> +
> >>> +     if (!gs || !gs->gro_hint)
> >>> +             return 0;
> >>> +     return geneve_opt_gro_hint_off(gh, type, gh_len);
> >>> +}
> >>> +
> >>>  /* geneve receive/decap routine */
> >>>  static void geneve_rx(struct geneve_dev *geneve, struct geneve_sock =
*gs,
> >>>                     struct sk_buff *skb, const struct genevehdr *gnvh=
)
> >>> @@ -299,6 +372,21 @@ static void geneve_rx(struct geneve_dev *geneve,=
 struct geneve_sock *gs,
> >>>       if (tun_dst)
> >>>               skb_dst_set(skb, &tun_dst->dst);
> >>>
> >>> +     if (skb->encapsulation) {
> >>> +             unsigned int len =3D 0, hint_off;
> >>> +             __be16 p;
> >>> +
> >>> +             hint_off =3D geneve_sk_gro_hint_off(gs->sock->sk, gnvh,=
 &p, &len);
> >>> +             if (hint_off && len <=3D skb_headlen(skb)) {
> >>> +                     const struct geneve_opt_gro_hint *gro_hint;
> >>> +
> >>> +                     gro_hint =3D geneve_opt_gro_hint(gnvh, hint_off=
);
> >>> +                     skb_set_transport_header(skb, gro_hint->nested_=
tp_offset);
> >>> +             }
> >>> +     } else {
> >>> +             skb_unset_transport_header(skb);
> >>> +     }
> >>
> >> It's not clear to me why the above chunk is needed.
> >
> > I think you understand this so i may be stating the obvious:
> > The main motivation was to isolate the pulls from making the transport
> > header stale
> > IOW, geneve_hdr(skb) pointer could become "stale" if the packet's head
> > was reallocated (because geneve_rx() is called after all the "pull"
> > operations) - so this ensures that the inner transport header is only
> > set after all header pulling is done - otherwise we get a UAF.
>
> Uhmm... my questions sparked because this patch adds quite a bit of new
> conditionals in the data-path, which I would like to avoid them.
>
> But I must admit that re-reading the code - I'm likely low on coffee - I
> don't see the UaF. This sequence:
>
>         pskb_may_pull(skb...)
>         geneveh =3D geneve_hdr(skb);
>
> is correct/does not yield to UaF, and AFAICS `geneveh` is always
> reloaded after pskb_may_pull()/iptunnel_pull_header(). Could you please
> share a decoded stack trace for the UaF you are observing? So it's clear
> where exactly kasan reports the problem.
>

The only one i have is what is in the commit. Comments below..

> >> Why can't
> >> geneve_post_decap_hint() retain the transport header set in the curren=
t
> >> place? it would make this patch much shorter.
> >>
> >
> > It was more to ensure clean state for cases where we dont have GRO hint=
s.
> > The "else {skb_unset_transport_header(skb);} " handles the case where
> > we are missing GRO hints - at that point outer UDP header is stripped
> > but tranport header is still pointing to where this outer header used
> > to be and something down the road may misintepret the header.
>
> This looks like an unrelated problem?!? And possibly not a problem at
> all?!? Upper layers (outside GSO) are expected to re-evaluate the
> transport header as needed.

Let me provide context, maybe that will help explain or provide a way
to fix this better.

I received multiple patches (via security) to resolve the pedit issue;
Rajat's was the first one.
Rajat's repro tricks geneve into having _negative transport offsets_.
Does that trigger anything for you? geneve just trusts those headers
are valid.
It was not Rajat's patch that caused this splat but one of the
multiple other reported alternative patches. I would have to dig in to
find which patch caused the splat.

Does this help? The key i believe is looking at the effect of negative
transport headers.
I can send you the repro maybe you will be able to have a better approach.

The most interesting part:
This patch "fixes the pedit issue". IOW, if you apply this patch to
geneve, _none_ of the repros can trigger the pedit issue.
Of course that is not fixing the root cause which is pedit - but i
figured it was worth posting because it does resolve the negative
offset. TBH, I was hoping this fix would go in first as a plug to the
pedit bug and also fix the negative transport offset. After adding yet
another fix for the cloned skb frags and seeing that Han Guidong found
a way to trigger using a different repro that creates it from a kernel
module i just shrugged.

cheers,
jamal

