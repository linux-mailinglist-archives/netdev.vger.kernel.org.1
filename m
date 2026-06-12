Return-Path: <netdev+bounces-298791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yrASArdwLGqAQwQAu9opvQ
	(envelope-from <netdev+bounces-298791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:48:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 084D667C620
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 22:48:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Rz4O4uXk;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298791-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298791-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CEFB3006914
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE1D340293;
	Fri, 12 Jun 2026 20:48:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DA1331EAB
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 20:48:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781297330; cv=pass; b=e073kEzXFS/vF4IAgnDcLTJCjJfOg8yfYePMCzTcuKnnPgTNYEp3DYXZv666jx/lr0MVpKx6xsu7UGr3dWeMSa0aYK7zFY0aMDqgNIvpC2zNB/+qirbgGKRwo1wU0VFPosPc3at7qiARFJ3dUZmHmwp5P8t67bI+YpB3cy7UvFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781297330; c=relaxed/simple;
	bh=/Fphz4AEg7VLjRCOZxlhmLxXkJAlQQIuOqqXUfYvmhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wabhf6gtTwBCs52WGIY9Hjg+Hc1dwsjDp649J0554rpF4zqZTAIDdmUxSbM+Ixy38tHgFIghqyeRu30IojnaWt6Qc3iF59tPiWCkfEKHomvZ4c4wZD7moo5xCP0kZsSB3H/vSHbi1PcTH/VQVIDiz8BmDxvgRW6pcETVkmJKQgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz4O4uXk; arc=pass smtp.client-ip=209.85.210.181
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-842273a2c4dso1009835b3a.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:48:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781297327; cv=none;
        d=google.com; s=arc-20240605;
        b=b5O4+0JOfyP1UrURYgA4qBrDeTnG2t2g1GwQcRjjSJAHqsk5LIP8JUzJJnTyN3h0Gl
         cFzq8V6f9lNkz4XaSjfztVsBVzpvh9vMP6aCc6Hf7C3XLCzPfSu5PQPKCfMUVI3RzPTl
         2zE5ttAJO01IjcWrSWx6XVgbA7Rrbl/OLAo5/TuYVwd21HArN5Lo+JRJVFt6lQ2MpaEd
         r5TJBRQzboE1WZLlt7VcrUidNQRR/mRo8QjfbP2T2GyWBH6bkl+DPUvyTwjQUREYm1x5
         iL15qH31EbYnGymsD1cdn/8pdHqM/ecikCf/zvyAI3luj15LJBPZlCIuD0z1KMNFEeQF
         OIHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c8b+p6IKKfS6Vat52avOATunY8iF7eAXvlismBPMZXo=;
        fh=64w4Cm65Oku8tiA/A6vBrY6EXrgvRqOIY54/EI5UbYU=;
        b=TYFU/Ubem6Imdu++e5zzuVTaKczJbbvb6M+9KsOz90ntcN8JtGkCzGWjiWTpw+XROP
         wAVT52FnPcrSLvzB7dDPNmjROT4T/9K6pcU40bEQmV/Z1eX4lJ1b2L1iwxWvHLVcyOGi
         4Auv+4YiypGuY06o/Ij1E/cjHv4xuxM0a2L5DglASGKz0m+jcRvHiH+/oOqhOegOQPdU
         BtaDae8mR5HVVZDCkagNBAchMFK50N/b8IPKJE8TI9oVPEOdnDzdYVh38ZqyXQF3sRw8
         gE5St6maDa3G8OSNTBmDksYIrVCaP4rKMup2ZLZnOqPDxj1KNYrMAiQKU5cLGbs8kFdS
         Vjpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781297327; x=1781902127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8b+p6IKKfS6Vat52avOATunY8iF7eAXvlismBPMZXo=;
        b=Rz4O4uXkUS4KQ+emsU9w10n54DK1FbhKyEug7x8FUEwq9YX80TyLM3Y1paWUBB5vDE
         YXQcdQShvg5lTU+BR+IzkYTBajUTLyor2RrDATfsaoMSFtgtuGKXAQRyLeLLoZ+tNBPj
         83/oOoUHChVzIA4lFR1zVgS+lDIiLO5TPORPwf5UgXWo7RmfiQcpuZDvmyuREH1R8OJq
         PbAqmxF/L1VR+4TN6k11QYGsZ9yvcNRUbO6v1WJwNze+o2sUsV6imgUVsTeNdKP6zO9H
         l0S5KZqriKwxhL3d6t9yyRJ6v7gFSDjGlkz/IqkwPGyvwB3da4ooD+mApB3tpR2lgdqr
         PWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781297327; x=1781902127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8b+p6IKKfS6Vat52avOATunY8iF7eAXvlismBPMZXo=;
        b=Eqp+emx98hF7tj7EtvtGukhm1yeMS0OsPESsjIR12Hl5rkLM9o9p+Fwf+FzJfYqRFb
         vmjl1dhLRnPrWrYSYs5Y6ZZDQcxQc9Dr+Jhz6l6f4kpTup4EiSLkNKohcgCWBys+BEss
         P4qCi+fhST2E4MW+cavP9KNsSB+bTuX8hni/k5cIhU174SeOLkGVPfISwunx0bePWiml
         jNBC2ikQw+HfGM0XCn/YjZT8nMg0+AyadyJ48zU1JBASLbi2IKx9nsdoPnTbOysc028T
         i0XWClhfFU4pJ8WfHO9M/dBUlsfPsd3jutqC2Yg+yUsiMXYSo5jNEudJ8oMnK+vRKUFA
         qg2w==
X-Gm-Message-State: AOJu0Yzduv2dX+b88gIrd6RrFSTIHurb2bacFifc5KtdYG4lAj6YzcDK
	/hYDnQN1whyU0MG70SEt2cpX//nNrOc3JZT1cj1cH/9exaHU9gA6WdifBtdr++RxVcikh3RvR5H
	I1S/CijBA6C0/OYJct1GNE7QUZIZa1bw=
X-Gm-Gg: Acq92OEKdqEKQoIXMcCh3ju/bQdnQZG2PoLl1pONUtTn6VaiZNxdbF7HCA70tvFfWzh
	BGXFGAdGYl8dLvqJ3yqjXz0dkbtEu5TGQ6jFoKY7uurw8nT56vOvxV5fHhkoYn2HFlEPvzVsMzs
	SjcEmZ3ctHx5RKEEhvQd5/n40XCK4xuBl98FgIyFo6qJZdWkx/T3Cq3I+M86kiK1ENZZA5HRnL+
	36IkPnkSsMzoZOZNV2L3ESMjhKbZK7eHlWFnHbEEbeHT88k53UMwxxjBSmlZKdqkg/Sm2Jngx5P
	UslYaL3hGu3PUfc+fff0Ku4Y9U8pz0hX+BapZwQV8uSuFrv+Hd0jrkXf3+pFhwQy8xywzqHrOvt
	zyzMWZw==
X-Received: by 2002:a05:6a00:2351:b0:841:69e4:f21b with SMTP id
 d2e1a72fcca58-8434ce6b56dmr5081219b3a.39.1781297326992; Fri, 12 Jun 2026
 13:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0b03854cabaac243a0cdf42375c66cd033750bd0.1780855297.git.lucien.xin@gmail.com>
 <20260611082008.138377-1-pabeni@redhat.com>
In-Reply-To: <20260611082008.138377-1-pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 12 Jun 2026 16:48:34 -0400
X-Gm-Features: AVVi8CfE7HTOI2SzE8B2TbKR1nN28BzQl7R5aNYkEsfQb-6dW-l_TEr2rNPdIw4
Message-ID: <CADvbK_eHGSu3Epj-oGudVmjWwas-goF2rFGb-J-vYOvW+L9Npw@mail.gmail.com>
Subject: Re: [PATCH net-next v13 15/15] quic: add packet parser base
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, horms@kernel.org, metze@samba.org, 
	mbuhl@openbsd.org, tfanelli@redhat.com, hepengtao@xiaomi.com, 
	dreibh@simula.no, linux-cifs@vger.kernel.org, smfrench@gmail.com, 
	linkinjeon@kernel.org, tom@talpey.com, kernel-tls-handshake@lists.linux.dev, 
	chuck.lever@oracle.com, jlayton@kernel.org, steved@redhat.com, hare@suse.de, 
	aahringo@redhat.com, dhowells@redhat.com, matttbe@kernel.org, 
	mail@johnericson.me, xiyou.wangcong@gmail.com, alibuda@linux.alibaba.com, 
	jbaron@akamai.com, illiliti@protonmail.com, sd@queasysnail.net, 
	marcelo.leitner@gmail.com, daniel@haxx.se, andrew.gospodarek@broadcom.com, 
	mef@scarletmail.rutgers.edu, paul@jakma.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:quic@lists.linux.dev,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:metze@samba.org,m:mbuhl@openbsd.org,m:tfanelli@redhat.com,m:hepengtao@xiaomi.com,m:dreibh@simula.no,m:linux-cifs@vger.kernel.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:tom@talpey.com,m:kernel-tls-handshake@lists.linux.dev,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:steved@redhat.com,m:hare@suse.de,m:aahringo@redhat.com,m:dhowells@redhat.com,m:matttbe@kernel.org,m:mail@johnericson.me,m:xiyou.wangcong@gmail.com,m:alibuda@linux.alibaba.com,m:jbaron@akamai.com,m:illiliti@protonmail.com,m:sd@queasysnail.net,m:marcelo.leitner@gmail.com,m:daniel@haxx.se,m:andrew.gospodarek@broadcom.com,m:mef@scarletmail.rutgers.edu,m:paul@jakma.org,m:xiyouwangcong@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298791-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com,scarletmail.rutgers.edu,jakma.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 084D667C620

On Thu, Jun 11, 2026 at 4:20=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> From: AI Reviewer <ai@example.com>
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> quic: add packet parser base
>
> This patch adds the QUIC packet RX parser, including ALPN extraction
> from the Client Initial to demux to the right listener, an ICMP-driven
> PMTU update path, and a per-net backlog/work for deferred parsing.
>
> > diff --git a/net/quic/packet.c b/net/quic/packet.c
> > index ba5204aceda6..430fc06d0012 100644
> > --- a/net/quic/packet.c
> > +++ b/net/quic/packet.c
>
> [ ... ]
>
> > +static int quic_packet_get_alpn(struct quic_data *alpn, u8 *p, u32 len=
)
> > +{
> > +     int err =3D -EINVAL, found =3D 0, exts =3D 0;
> > +     u64 length, type;
> > +
>
> [ ... ]
>
> > +     while (len >=3D 4) { /* Scan extensions for ALPN (TLS_EXT_alpn). =
*/
> > +             if (!quic_get_int(&p, &len, &type, 2))
> > +                     break;
> > +             if (!quic_get_int(&p, &len, &length, 2))
> > +                     break;
> > +             if (len < (u32)length) /* Incomplete TLS extensions. */
> > +                     return 0;
>
> [Medium]
> Should this branch be treated as a parse failure rather than a success?
>

The rest of the TLS extensions could be in the CRYPTO frame of
the next initial packet.

Returning error will cause packets to be dropped in the callers.

> The other length-bound checks in this same function return err (-EINVAL)
> when a declared length exceeds the remaining buffer, but this one returns
> 0 without populating alpn.

The splitted TLS CLIENT_HELLO messages are very rare.
The ones I saw from some QUIC implementations are splitted from these
TLS EXT points. I will improve it when seeing more different split points.

> The callers initialise alpn as
>
>         struct quic_data alpns =3D {};
>
> and quic_listen_sock_lookup() then takes the no-ALPN branch:
>
>     if (!alpns->len) { /* No ALPNs or parse failed */
>         sk_nulls_for_each_rcu(tmp, node, &head->head) {
>             ...
>             if (... && (!alpns->data || !quic_alpn(tmp)->len)) {
>
> Because alpns->data is still NULL, the match collapses to true and any
> listener bound to the address/port will match, including ones that
> registered a specific ALPN list. Can a peer reach an ALPN-restricted
> listener by sending a Client Initial with one extension whose declared
> length is larger than what is left in the ClientHello?
>
> Would returning err here (or always assigning alpn->data before
> returning) match the comment in quic_listen_sock_lookup() that
> distinguishes "TLS parsing succeeded but no ALPN was found" from "parse
> failed"?
>
ALPN demux is a feature trying its best to dispatch the first initial
to the right process. If it goes to the "incorrect" because the peer
doesn't provide proper ALPNs, the userspace handshake will reject it.

It's kind of the peer responsibility if it wants to get processed in the
right process, send with the right ALPNs then.

> > +             if (type =3D=3D TLS_EXT_alpn) { /* Found ALPN extension. =
*/
> > +                     if (length > QUIC_ALPN_MAX_LEN)
> > +                             return err;
> > +                     len =3D length;
> > +                     found =3D 1;
> > +                     break;
> > +             }
> > +             /* Skip non-ALPN extensions. */
> > +             p +=3D length;
> > +             len -=3D length;
> > +             if (exts++ >=3D TLS_MAX_EXTENSIONS)
> > +                     return err;
>
> [Low]
> Is the post-increment intended here? With TLS_MAX_EXTENSIONS =3D=3D 128, =
the
> check (exts++ >=3D 128) first becomes true when exts has already reached
> 129, so 129 extensions are consumed before bail-out even though the
> constant name suggests a cap of 128. Would
>
>         if (++exts > TLS_MAX_EXTENSIONS)
>                 return err;
>
> (or moving the check to the loop top) better reflect the intended limit?
>

will change to ++exts.

> > +     }
>
> [ ... ]
>
> > +static int quic_packet_parse_alpn(struct sk_buff *skb, struct quic_dat=
a *alpn)
>
> [ ... ]
>
> > diff --git a/net/quic/socket.c b/net/quic/socket.c
> > index 8f348d7c678b..19b164baf55d 100644
> > --- a/net/quic/socket.c
> > +++ b/net/quic/socket.c
>
> [ ... ]
>
> > +struct sock *quic_sock_lookup(struct sk_buff *skb, union quic_addr *sa=
,
> > +                           union quic_addr *da, struct sock *usk,
> > +                           struct quic_conn_id *dcid)
> > +{
>
> [ ... ]
>
> > +     rcu_read_lock();
> > +begin:
> > +     sk_nulls_for_each_rcu(tmp, node, &head->head) {
> > +             if (net !=3D sock_net(tmp))
> > +                     continue;
> > +             paths =3D quic_paths(tmp);
> > +             odcid =3D quic_path_orig_dcid(paths);
> > +             if (quic_cmp_sk_addr(tmp, quic_path_saddr(paths, 0), sa) =
&&
> > +                 quic_cmp_sk_addr(tmp, quic_path_daddr(paths, 0), da) =
&&
> > +                 quic_path_usock(paths, 0) =3D=3D usk &&
> > +                 (!dcid || !quic_conn_id_cmp(odcid, dcid))) {
> > +                     sk =3D tmp;
> > +                     break;
> > +             }
> > +     }
>
> [High]
> Is the sk memory itself RCU-protected here? sk_nulls_for_each_rcu()
> dereferences fields of tmp (sock_net(tmp), quic_paths(tmp),
> quic_path_saddr(...), etc.) before any reference is taken. That is only
> safe when the sk allocation is freed via RCU.
>
> quic_init_sock() does not call sock_set_flag(sk, SOCK_RCU_FREE), and
> neither quic_prot nor quicv6_prot sets slab_flags to SLAB_TYPESAFE_BY_RCU=
,
> so sk_destruct() (and quic_sock_destruct()) runs synchronously on the
> last sock_put(). Can a parallel close on tmp free the sock between
> sk_nulls_for_each_rcu() exposing it and the field dereferences above?
>
> The same shape appears in quic_listen_sock_lookup() further down, where
> quic_alpn(tmp)->len is read inside the RCU walk before
> refcount_inc_not_zero().
>

SOCK_RCU_FREE will be set in the patchset-2 via quic_hash().

> > +     if (sk && unlikely(!refcount_inc_not_zero(&sk->sk_refcnt)))
> > +             sk =3D NULL;
> > +     rcu_read_unlock();
> > +     return sk;
> > +}
>
> [ ... ]
>
> > +struct sock *quic_listen_sock_lookup(struct sk_buff *skb, union quic_a=
ddr *sa,
> > +                                  union quic_addr *da,
> > +                                  struct quic_data *alpns)
> > +{
>
> [ ... ]
>
> > +     rcu_read_lock();
> > +     if (!alpns->len) { /* No ALPNs or parse failed */
> > +             sk_nulls_for_each_rcu(tmp, node, &head->head) {
>
> [ ... ]
>
> > +                     a =3D quic_path_saddr(quic_paths(tmp), 0);
> > +                     if (net =3D=3D sock_net(tmp) &&
> > +                         quic_cmp_sk_addr(tmp, a, sa) &&
> > +                         quic_path_usock(quic_paths(tmp), 0) =3D=3D sk=
b->sk &&
> > +                         (!alpns->data || !quic_alpn(tmp)->len)) {
>
> [ ... ]
>
> > @@ -48,6 +196,9 @@ static void quic_sock_destruct(struct sock *sk)
> >       for (i =3D 0; i < QUIC_CRYPTO_MAX; i++)
> >               quic_crypto_free(quic_crypto(sk, i));
> >
> > +     /* Deferred ALPN free for RCU readers in quic_listen_sock_lookup(=
). */
> > +     quic_data_free(quic_alpn(sk));
> > +
>
> Without SOCK_RCU_FREE or SLAB_TYPESAFE_BY_RCU on quic_prot/quicv6_prot,
> does moving the alpn free into the destruct callback actually defer it
> past an RCU grace period? quic_sock_destruct() is invoked from
> sk_destruct() on the final sock_put() and is not itself an RCU callback,
> so the comment's "Deferred ALPN free for RCU readers" assumption seems to
> rely on a guarantee that is not configured on this protocol. Should this
> patch also set sock_set_flag(sk, SOCK_RCU_FREE) in quic_init_sock(), or
> alternatively take refcount_inc_not_zero() in the lookup helpers before
> touching any fields of tmp?
>

SOCK_RCU_FREE will be set in the patchset-2 via quic_hash().

> >       quic_sk_destruct(sk);
> >  }
> >
>
> [ ... ]
> --
> This is an AI-generated review.
>

