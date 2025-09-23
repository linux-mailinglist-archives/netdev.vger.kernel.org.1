Return-Path: <netdev+bounces-225701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD46B972F1
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2034418A818C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 18:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482592FE56B;
	Tue, 23 Sep 2025 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVEm2i1w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22814235BE2
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 18:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758651795; cv=none; b=tv+gc7tSpPqO6Aos25DOe0Sk3pRpSIWZfnakmMzjKU9GnJU5TJmjY5qk6zYt6HkY5rXYa2m7t9hXAfair7/Qle5Bb8zqoMlkgiY0Puwz4+gTPYjEWZjsvbL66xKbYUDkOkkWIJLlPWmjVFPZQNk72ltv1f7axzBN7Jq3MHqPUPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758651795; c=relaxed/simple;
	bh=8jaT+A2dXp3U0beqB5oXT4ih2/C09svOX1a6h3DLpsA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cRMW7jz4lEnPXgOcuqF1CZyU/1ZTY1gGZXhRsynqqQ6tFZGEVnuC14OU/y8fwMsGtgaShTZJ6TrkxdcIDAcAHAEgiHgflRqvA5sF8YZyKzqGSxGOgoTmsX2nEW8iGyWfG9yDrhe/zsd006CfJExOylQZIyFhLZtwxWr0wmHgFGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVEm2i1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206ECC4CEF5;
	Tue, 23 Sep 2025 18:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758651793;
	bh=8jaT+A2dXp3U0beqB5oXT4ih2/C09svOX1a6h3DLpsA=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=EVEm2i1wN8gHQKEneeqVApOz9YQ9zmYlNsPWomipSz089ucuf7Y7SbnqUC3AStNhQ
	 cO4VbUgH29ShbamFrni/DzkA+PQYn9k0Sn8uQ1COKdcTDQgtryq/I7gPK0s/9GvAS0
	 4apWO9xrQdKVlZ9y5xhqKnmlVTPk8ch+noHGksiykC94/uet3AHb7CJk5JUqNrfnTf
	 zX2KO5DIBSZK+VracHAweXX/peL8IRujnrKo8XiEozh5YzQrMmppFnyQehXCcE4CWD
	 VR0CH0/d5RSkLKjCmmXgZZbwvG64oAXlMrsgOa++m5aFNhxTijYM9NU6pn92W9Hxyn
	 v7UEq9wFhv1bQ==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Tue, 23 Sep 2025 21:23:08 +0300 (EEST)
To: Dan Carpenter <dan.carpenter@linaro.org>, 
    chia-yu.chang@nokia-bell-labs.com
cc: netdev@vger.kernel.org
Subject: Re: [bug report] tcp: accecn: AccECN option
In-Reply-To: <aNKEGWyWV9LWW3i5@stanley.mountain>
Message-ID: <da87ed1c-165d-fd21-7292-19468d1c8a8c@kernel.org>
References: <aNKEGWyWV9LWW3i5@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1467881368-1758651010=:13787"
Content-ID: <d5214b7b-23f5-33fd-7d20-1a937e17b5f0@kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1467881368-1758651010=:13787
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a9ce3636-eac0-c3d0-725b-980dee8330c3@kernel.org>

On Tue, 23 Sep 2025, Dan Carpenter wrote:

> Hello Ilpo J=E4rvinen,
>=20
> Commit b5e74132dfbe ("tcp: accecn: AccECN option") from Sep 16, 2025
> (linux-next), leads to the following Smatch static checker warning:
>=20
> =09net/ipv4/tcp_output.c:747 tcp_options_write()
> =09error: we previously assumed 'tp' could be null (see line 711)
>=20
> net/ipv4/tcp_output.c
>     630 static void tcp_options_write(struct tcphdr *th, struct tcp_sock =
*tp,
>     631                               const struct tcp_request_sock *tcpr=
sk,
>     632                               struct tcp_out_options *opts,
>     633                               struct tcp_key *key)
>     634 {
>     635         u8 leftover_highbyte =3D TCPOPT_NOP; /* replace 1st NOP i=
f avail */
>     636         u8 leftover_lowbyte =3D TCPOPT_NOP;  /* replace 2nd NOP i=
n succession */
>     637         __be32 *ptr =3D (__be32 *)(th + 1);
>     638         u16 options =3D opts->options;        /* mungable copy */
>     639=20
>     640         if (tcp_key_is_md5(key)) {
>     641                 *ptr++ =3D htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP=
 << 16) |
>     642                                (TCPOPT_MD5SIG << 8) | TCPOLEN_MD5=
SIG);
>     643                 /* overload cookie hash location */
>     644                 opts->hash_location =3D (__u8 *)ptr;
>     645                 ptr +=3D 4;
>     646         } else if (tcp_key_is_ao(key)) {
>     647                 ptr =3D process_tcp_ao_options(tp, tcprsk, opts, =
key, ptr);
>                                                      ^^
> Sometimes dereferenced here.
>=20
>     648         }
>     649         if (unlikely(opts->mss)) {
>     650                 *ptr++ =3D htonl((TCPOPT_MSS << 24) |
>     651                                (TCPOLEN_MSS << 16) |
>     652                                opts->mss);
>     653         }
>     654=20
>     655         if (likely(OPTION_TS & options)) {
>     656                 if (unlikely(OPTION_SACK_ADVERTISE & options)) {
>     657                         *ptr++ =3D htonl((TCPOPT_SACK_PERM << 24)=
 |
>     658                                        (TCPOLEN_SACK_PERM << 16) =
|
>     659                                        (TCPOPT_TIMESTAMP << 8) |
>     660                                        TCPOLEN_TIMESTAMP);
>     661                         options &=3D ~OPTION_SACK_ADVERTISE;
>     662                 } else {
>     663                         *ptr++ =3D htonl((TCPOPT_NOP << 24) |
>     664                                        (TCPOPT_NOP << 16) |
>     665                                        (TCPOPT_TIMESTAMP << 8) |
>     666                                        TCPOLEN_TIMESTAMP);
>     667                 }
>     668                 *ptr++ =3D htonl(opts->tsval);
>     669                 *ptr++ =3D htonl(opts->tsecr);
>     670         }
>     671=20
>     672         if (OPTION_ACCECN & options) {
>     673                 const u32 *ecn_bytes =3D opts->use_synack_ecn_byt=
es ?
>     674                                        synack_ecn_bytes :
>     675                                        tp->received_ecn_bytes;
>                                                ^^^^
> Dereference

Hi Dan,

While it is long ago I made these changes (they might have changed a=20
little from that), I can say this part is going to be extremely tricky=20
for static checkers because TCP state machine(s) are quite complex.

TCP options can be written to a packet when tp has not yet been created=20
(during handshake) as well as after creation of tp using this same=20
function. Not all combinations are possible because handshake has to=20
complete before some things are enabled.

Without checking this myself, my assumption is that ->use_synack_ecn_bytes=
=20
is set when we don't have tp available yet as SYNACKs relate to handshake.
So the tp check is likely there even if not literally written.

Chia-Yu, could you please check these cases for the parts that new code=20
was introduced whether tp can be NULL? I think this particular line is the
most likely one to be wrong if something is, that is, can OPTION_ACCECN=20
be set while use_synack_ecn_bytes is not when tp is not yet there.

>     676                 const u8 ect0_idx =3D INET_ECN_ECT_0 - 1;
>     677                 const u8 ect1_idx =3D INET_ECN_ECT_1 - 1;
>     678                 const u8 ce_idx =3D INET_ECN_CE - 1;
>     679                 u32 e0b;
>     680                 u32 e1b;
>     681                 u32 ceb;
>     682                 u8 len;
>     683=20
>     684                 e0b =3D ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT=
_OFFSET;
>     685                 e1b =3D ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT=
_OFFSET;
>     686                 ceb =3D ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_O=
FFSET;
>     687                 len =3D TCPOLEN_ACCECN_BASE +
>     688                       opts->num_accecn_fields * TCPOLEN_ACCECN_PE=
RFIELD;
>     689=20
>     690                 if (opts->num_accecn_fields =3D=3D 2) {
>     691                         *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24) |=
 (len << 16) |
>     692                                        ((e1b >> 8) & 0xffff));
>     693                         *ptr++ =3D htonl(((e1b & 0xff) << 24) |
>     694                                        (ceb & 0xffffff));
>     695                 } else if (opts->num_accecn_fields =3D=3D 1) {
>     696                         *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24) |=
 (len << 16) |
>     697                                        ((e1b >> 8) & 0xffff));
>     698                         leftover_highbyte =3D e1b & 0xff;
>     699                         leftover_lowbyte =3D TCPOPT_NOP;
>     700                 } else if (opts->num_accecn_fields =3D=3D 0) {
>     701                         leftover_highbyte =3D TCPOPT_ACCECN1;
>     702                         leftover_lowbyte =3D len;
>     703                 } else if (opts->num_accecn_fields =3D=3D 3) {
>     704                         *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24) |=
 (len << 16) |
>     705                                        ((e1b >> 8) & 0xffff));
>     706                         *ptr++ =3D htonl(((e1b & 0xff) << 24) |
>     707                                        (ceb & 0xffffff));
>     708                         *ptr++ =3D htonl(((e0b & 0xffffff) << 8) =
|
>     709                                        TCPOPT_NOP);
>     710                 }
>     711                 if (tp) {
>                             ^^
> Here we assume tp can be NULL
>=20
>     712                         tp->accecn_minlen =3D 0;
>     713                         tp->accecn_opt_tstamp =3D tp->tcp_mstamp;
>     714                         if (tp->accecn_opt_demand)
>     715                                 tp->accecn_opt_demand--;
>     716                 }
>     717         }
>     718=20
>     719         if (unlikely(OPTION_SACK_ADVERTISE & options)) {
>     720                 *ptr++ =3D htonl((leftover_highbyte << 24) |
>     721                                (leftover_lowbyte << 16) |
>     722                                (TCPOPT_SACK_PERM << 8) |
>     723                                TCPOLEN_SACK_PERM);
>     724                 leftover_highbyte =3D TCPOPT_NOP;
>     725                 leftover_lowbyte =3D TCPOPT_NOP;
>     726         }
>     727=20
>     728         if (unlikely(OPTION_WSCALE & options)) {
>     729                 u8 highbyte =3D TCPOPT_NOP;
>     730=20
>     731                 /* Do not split the leftover 2-byte to fit into a=
 single
>     732                  * NOP, i.e., replace this NOP only when 1 byte i=
s leftover
>     733                  * within leftover_highbyte.
>     734                  */
>     735                 if (unlikely(leftover_highbyte !=3D TCPOPT_NOP &&
>     736                              leftover_lowbyte =3D=3D TCPOPT_NOP))=
 {
>     737                         highbyte =3D leftover_highbyte;
>     738                         leftover_highbyte =3D TCPOPT_NOP;
>     739                 }
>     740                 *ptr++ =3D htonl((highbyte << 24) |
>     741                                (TCPOPT_WINDOW << 16) |
>     742                                (TCPOLEN_WINDOW << 8) |
>     743                                opts->ws);
>     744         }
>     745=20
>     746         if (unlikely(opts->num_sack_blocks)) {
> --> 747                 struct tcp_sack_block *sp =3D tp->rx_opt.dsack ?
>                                                     ^^^^^^^^^^^^^^^^
> Unchecked dereference here.
>=20
>     748                         tp->duplicate_sack : tp->selective_acks;
>     749                 int this_sack;
>     750=20
>     751                 *ptr++ =3D htonl((leftover_highbyte << 24) |
>     752                                (leftover_lowbyte << 16) |
>     753                                (TCPOPT_SACK <<  8) |
>     754                                (TCPOLEN_SACK_BASE + (opts->num_sa=
ck_blocks *
>     755                                                      TCPOLEN_SACK=
_PERBLOCK)));
>     756                 leftover_highbyte =3D TCPOPT_NOP;
>     757                 leftover_lowbyte =3D TCPOPT_NOP;
>     758=20
>     759                 for (this_sack =3D 0; this_sack < opts->num_sack_=
blocks;
>     760                      ++this_sack) {
>     761                         *ptr++ =3D htonl(sp[this_sack].start_seq)=
;
>     762                         *ptr++ =3D htonl(sp[this_sack].end_seq);
>     763                 }
>     764=20
>     765                 tp->rx_opt.dsack =3D 0;
>     766         } else if (unlikely(leftover_highbyte !=3D TCPOPT_NOP ||
>     767                             leftover_lowbyte !=3D TCPOPT_NOP)) {
>     768                 *ptr++ =3D htonl((leftover_highbyte << 24) |
>     769                                (leftover_lowbyte << 16) |
>     770                                (TCPOPT_NOP << 8) |
>     771                                TCPOPT_NOP);
>     772                 leftover_highbyte =3D TCPOPT_NOP;
>     773                 leftover_lowbyte =3D TCPOPT_NOP;
>     774         }
>     775=20
>     776         if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
>     777                 struct tcp_fastopen_cookie *foc =3D opts->fastope=
n_cookie;
>     778                 u8 *p =3D (u8 *)ptr;
>     779                 u32 len; /* Fast Open option length */
>     780=20
>     781                 if (foc->exp) {
>     782                         len =3D TCPOLEN_EXP_FASTOPEN_BASE + foc->=
len;
>     783                         *ptr =3D htonl((TCPOPT_EXP << 24) | (len =
<< 16) |
>     784                                      TCPOPT_FASTOPEN_MAGIC);
>     785                         p +=3D TCPOLEN_EXP_FASTOPEN_BASE;
>     786                 } else {
>     787                         len =3D TCPOLEN_FASTOPEN_BASE + foc->len;
>     788                         *p++ =3D TCPOPT_FASTOPEN;
>     789                         *p++ =3D len;
>     790                 }
>     791=20
>     792                 memcpy(p, foc->val, foc->len);
>     793                 if ((len & 3) =3D=3D 2) {
>     794                         p[foc->len] =3D TCPOPT_NOP;
>     795                         p[foc->len + 1] =3D TCPOPT_NOP;
>     796                 }
>     797                 ptr +=3D (len + 3) >> 2;
>     798         }
>     799=20
>     800         smc_options_write(ptr, &options);
>     801=20
>     802         mptcp_options_write(th, ptr, tp, opts);
>                                              ^^
> The last dereference is checked for NULL but the others aren't.


--=20
 i.
--8323328-1467881368-1758651010=:13787--

