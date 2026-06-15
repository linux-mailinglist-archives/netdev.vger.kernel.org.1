Return-Path: <netdev+bounces-299546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QxOrAqUxMGr2PgUAu9opvQ
	(envelope-from <netdev+bounces-299546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:08:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C5688B15
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 19:08:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=mcSXSTgB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299546-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299546-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65D953009E07
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 16:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9840BCA9;
	Mon, 15 Jun 2026 16:56:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA862407576
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:55:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781542560; cv=pass; b=G3Rlfh+8XkahFSWDxCVmxCqAOJXdeOyOaPIqn5ojsnXQRfeMrdVKutIrdDroYBKgP18wkSsRFSpQphqk0VCE6g6GQvkJNH6wc2LpKErymy8+e0GXIsPRJDyV1l/TUytAsTtq5lrd0Acw8O6o+9buMfnz1nlcBObklTRrma0eyvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781542560; c=relaxed/simple;
	bh=4YPWMK+0WYWJceGQjSJj/WOQ+Iz5+dRnHqH63ccwQUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a9Rcn9c3GBMSyhq2ubORQqq+T5LtYwC0AqSKtrntbwUIxlbaAI+IEEqm8lBbCD/Inp5FZnl30qWjhthldS4l+M8Orhbh2NP2UTi147s2fvRK9Tt6s9U5Y0by9v4JCairDZ/oa5Mo2rr9t/3LXy4q4CNuezN8lQh1jpxyJEgrNXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcSXSTgB; arc=pass smtp.client-ip=209.85.160.176
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5176fc0cc72so38339731cf.1
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 09:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781542558; cv=none;
        d=google.com; s=arc-20240605;
        b=fcFEwnNbJ9zYPbbQWpal3gm923/WeT1I95g4wMNa+rFoqxEdtuosnUPZlf/1LaSRq2
         dAd3BZNu8ALsfSGPSsC36vNDH7ihzN+rDoiiCitVt01iwpArk6JWHRNMfhw+aesLLozU
         tA4oHRyqWaJPRmohRIFNcG1OlRRxh0H1SMvRFcINiZzKoIYtZdEFSUHGPEUfuQpUBFzq
         graJKz/CA0x6tdkmy27T9MDVgyhgMuKcVghZ8AjXjUogjmkquLTW0EwQ2G/nkU7TlWk/
         REy7nDkozRTkl9cHcf7jhVQq/VqKQ3LUOUytZAAJCk0xFGKyG25vAEqxY54LFJBierHH
         1ItQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=op3KaiCmJCT9futuSMniceaWe5Q/wKrwv8uwA7WTvb8=;
        fh=hNzy4O4tk2xeHhbcxz2d6lzTvVRCyXqa1b5K7LahNDg=;
        b=La+zcaRCb4w2AFSROcZvMSYaRDOCDJaI0WnmtmM3a27pbX2t7D78/qW2yhAhY4r+Jj
         GxIgIDfKeVidXOsGk70D43X1u6YK/3mOU5n9D2iytifLnEEe459B3J/qAwH9RiyJRIzI
         nHj8j+KtU0VujfKD6DY8N+f38UxaqM826SUbeIwklI+z0Ladm3/5hupqIp0I9i+dELC8
         nrBzjef1ezEspyX73hPHt4XRphr5KkaGdRH+gbcoNztRySHBQmGLsTzcnZvGtepSOCHv
         iJFSzI5G073S5gHaFoljp54P3fyGJmqkLgeD4aRr7Gq36vP3OoUybEInLxH2OPFetzVC
         +/5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781542558; x=1782147358; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=op3KaiCmJCT9futuSMniceaWe5Q/wKrwv8uwA7WTvb8=;
        b=mcSXSTgBoO4O/qL7Qd87hqo3I3Z0I3BGtkW9A2FPKwCQFvqqU09+es8L6ET2ATj6TS
         7Y0ystcfUhQ/69kFzrPWyYo4/gCZKYKTX9HxxAuBBHdMxPhm+t2G5A6hZdnB2nyYOxen
         cj+Dw6ZJfmjy6XyY1hcyb+h/1CJuYTQ0VV0GiRrIFZ8Hj647FS/PEPXYNyij5GXyqWhB
         9iZtnFD/rWWi1xRU0fKOZRhwyEtUxr6w2fgymUImnNv1IGHiMFQdxkid2CVucz4H/za4
         uxWKCbj5fDTA13HQiDMrAaIyoxWuWw99510D2QSPmEa5OkPiBhGLoBdmiacTXBZRJZn0
         //LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781542558; x=1782147358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=op3KaiCmJCT9futuSMniceaWe5Q/wKrwv8uwA7WTvb8=;
        b=NDXtto3Gcq71dGYUR05k1xtz2xjGEHxrJmKLgbBpR7vKYxMR8BUfLCdsHCEfJfkCTM
         OIzU0buzc++18+HS5a29HRVVfMSzrpePDQTkdh5BZkSewRKuIJy4/b98LH6ZX8s+CK14
         dZtYpYKNV/6UFSnGOedWxeOrB6P/W+Fd8RK4AsbRrj62e+SHj74oJL977EXtpWJlf15k
         m6t1C23P/Cr14VJoQjw+A3DKCniTLyQSJIXvj0G211GnxAeB8SecWvmw6RA60txH4tt3
         Ng6RpoOeDU3LSLhdT4tF/gjU/ST5MkDZ9gc/UQbtWjjueOSUmOOT30wq/p+s45i6Qv5O
         VOPg==
X-Gm-Message-State: AOJu0YzkGPAJweOzQdy1ckvekQerdilpsHQGlxLtxHSryLALvnzPEYfq
	1QqobRwjCG9uGVYAXdz/4r1p3BgFBHk50kOPdpvGW1Rcuir7SBDDOYowxoaogGVF1tonTSx1yh1
	tRmrvTRJewHQLI/s0UOerUdlnyuVX2QL7k41LBE2K
X-Gm-Gg: Acq92OHiTvg9UIgzDWMKHf54JocX04iv6p7K3pSyxnyGp+Lq57sm+xmQCBld5eePJIU
	dmc/2XChM+ILEkIyqTG0SgjM7GxJemWm/mjZy07A3sPnnPYti81H8aZebG40WkG8erZVPEfPpUR
	/+lJ/DX1YiLTaZTnR4e9hxecxXl+bsG1gO1IKoV1y2zuVSaFWsSNvC/fDw5TfiiylGINJD13Fn6
	1m/2oTQJ1wEWF34qkf8v2RZDnilSJZ/tUUogIVTaVU5oUnPyeeRWjDWsZ1aoQXZBScvvbwHcMzu
	jYsRiWH6q5+y6jwiHU0cV12Wf2tgPDUsFXVSM7efiB6/7RnrWUth8LwlhAmTtqddzWPZETLH4/8
	fLxVVF4WNhj5phbtyRxvn
X-Received: by 2002:a05:622a:1115:b0:50f:b4c0:630f with SMTP id
 d75a77b69052e-5195357c228mr175976161cf.54.1781542556797; Mon, 15 Jun 2026
 09:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615042158.1600746-1-ntspring@meta.com> <20260615042158.1600746-2-ntspring@meta.com>
In-Reply-To: <20260615042158.1600746-2-ntspring@meta.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Jun 2026 09:55:45 -0700
X-Gm-Features: AVVi8CcLt4JINR95JUJ5Pig2rgeZiW8v5j_nnToRd6BeBcgfvgXVPVQccUrwbf4
Message-ID: <CANn89iLjf-d08s1ofLo3fDUQENYji9qwG6fQbiAN3fyvxP=+BA@mail.gmail.com>
Subject: Re: [PATCH v14 1/2] tcp: rehash onto different local ECMP path on
 retransmit timeout
To: Neil Spring <ntspring@meta.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, dsahern@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, martin.lau@linux.dev, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ntspring@meta.com,m:netdev@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:dsahern@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:bpf@vger.kernel.org,m:martin.lau@linux.dev,m:daniel@iogearbox.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-299546-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,meta.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E33C5688B15

On Sun, Jun 14, 2026 at 9:22=E2=80=AFPM Neil Spring <ntspring@meta.com> wro=
te:
>
> Currently sk_rethink_txhash() re-rolls the socket's txhash on RTO, PLB,
> and spurious-retransmission events, but the cached route is reused and
> the new hash is not propagated into the ECMP path selection logic.  Two
> changes are needed to make rehash select a different local ECMP path:
>
> 1. Add __sk_dst_reset() alongside sk_rethink_txhash() in
>    tcp_write_timeout(), tcp_rcv_spurious_retrans(), and
>    tcp_plb_check_rehash() so the cached dst is invalidated and the
>    next transmit triggers a fresh route lookup.
>
> 2. Set fl6->mp_hash from sk_txhash (or tcp_rsk(req)->txhash for
>    SYN/ACK retransmits and syncookies) in tcp_v6_connect(),
>    inet6_sk_rebuild_header(), inet6_csk_route_req(),
>    inet6_csk_route_socket(), tcp_v6_send_response(), and
>    cookie_v6_check() so fib6_select_path() picks a path based on the
>    new hash.
>
> The mp_hash override only applies to fib_multipath_hash_policy 0 (the
> default L3 policy).  Its hash includes the flow label, but that is 0 by
> default -- np->flow_label is unset, and auto_flowlabels only computes
> the on-wire label later, per packet -- so flows to the same peer share
> one local path.  Keying the hash on sk_txhash makes the local path
> per-connection and lets a rehash re-select it.  Policies 1-3 are left
> unchanged.
>
> The mp_hash assignment is factored into a small helper,
> ip6_ecmp_set_mp_hash(), shared by inet6_csk_route_req(),
> inet6_csk_route_socket(), tcp_v6_connect(), inet6_sk_rebuild_header(),
> tcp_v6_send_response(), and cookie_v6_check().  It applies
> (txhash >> 1) ?: 1 for policy 0 (the >> 1 keeps mp_hash in the 31-bit
> range; ?: 1 keeps it non-zero, since 0 would fall back to
> rt6_multipath_hash()).  inet6_csk_route_socket() calls it only for
> sk_protocol =3D=3D IPPROTO_TCP so that non-TCP callers (e.g., L2TP via
> inet6_csk_xmit) fall through to rt6_multipath_hash() and retain their
> existing flow-key-based ECMP behavior.
>
> tcp_v6_send_response() also sets mp_hash from the response txhash so
> that a control packet (a RST from the full socket, or an ACK from a
> time-wait socket) selects the same local ECMP nexthop as the
> connection's txhash rather than falling back to the flow hash.  The
> time-wait socket's tw_txhash is copied from sk_txhash when the
> connection enters TIME_WAIT, so it reflects any rehash that occurred.
>
> Setting mp_hash explicitly is necessary because the default ECMP hash
> derives from fl6->flowlabel via np->flow_label, which is not updated
> from sk_txhash (REPFLOW is off by default).  ip6_make_flowlabel()
> cannot help either, as it runs after the route lookup.
>
> As a consequence, for policy 0 the local ECMP path of an IPv6 TCP
> flow follows sk_txhash even when fl6->flowlabel is non-zero, e.g. a
> reflected (REPFLOW) or explicitly set (IPV6_FLOWLABEL_MGR) flow
> label.  This is intentional: only local path selection changes, so
> rehash can recover from a failed path; the on-wire flow label is
> unchanged.
>
> sk_set_txhash() is moved before ip6_dst_lookup_flow() in
> tcp_v6_connect() so the initial ECMP path is selected by the same
> txhash that subsequent route rebuilds will use.  This avoids
> unintended path changes when the cached dst is naturally invalidated
> (e.g., by PMTU discovery or route changes).
>
> The rehash sites (tcp_write_timeout(), tcp_plb_check_rehash(), and
> tcp_rcv_spurious_retrans()) call __sk_rethink_txhash_reset_dst(),
> which re-rolls the txhash and, when it changed, drops the cached dst
> so the next transmit re-runs route selection.  The dst reset is
> guarded by sk->sk_family =3D=3D AF_INET6 since IPv4 ECMP does not
> currently use sk_txhash for path selection.  For IPv4-mapped IPv6
> sockets this produces a redundant dst reset on a cold path
> (RTO/PLB); the subsequent IPv4 route lookup returns the same result.
> The helper is deliberately separate from sk_rethink_txhash() itself:
> dst_negative_advice() calls sk_rethink_txhash() before its own dst op,
> so resetting the dst inside sk_rethink_txhash() would skip that op
> (e.g. rt6_remove_exception_rt()).
>
> For syncookies, cookie_init_sequence() computes the cookie value
> before route_req() and sets txhash so the SYN-ACK selects the same
> ECMP path that cookie_v6_check() will use when the full socket is
> created.  cookie_tcp_reqsk_init() derives txhash from the cookie so
> the full socket's ECMP path matches the SYN-ACK.  Both the SYN-ACK
> assignment in tcp_conn_request() and the full-socket assignment in
> cookie_tcp_reqsk_init() set txhash from the cookie for IPv4 and IPv6
> alike.  On IPv6 this drives ECMP path selection; on IPv4, which does
> not use sk_txhash for ECMP, it only affects TX-queue selection.  That
> selection scales the hash by its high bits (reciprocal_scale()), which
> are uniform in the keyed secure_tcp_syn_cookie() output -- the MSS index
> only perturbs the low bits -- so the queue distribution matches
> net_tx_rndhash().
>
> cookie_init_sequence() is split from the former version that also
> called tcp_synq_overflow() and incremented SYNCOOKIESSENT; those
> side effects are now in cookie_record_sent(), called after
> route_req() succeeds so they are not bumped when route_req() fails.
> cookie_record_sent() is guarded by CONFIG_SYN_COOKIES to
> match the guard on tcp_synq_overflow().  route_req() receives 0 as
> tw_isn for the syncookie path so that tcp_v6_init_req() still saves
> ireq->pktopts for REPFLOW flowlabel reflection and IPv6 cmsg
> options.  The ecn_ok clear for syncookies without timestamps stays
> after tcp_ecn_create_request() so it takes precedence.
>
> Signed-off-by: Neil Spring <ntspring@meta.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

