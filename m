Return-Path: <netdev+bounces-264087-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPjFIJ28qGlbwwAAu9opvQ
	(envelope-from <netdev+bounces-264087-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:13:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F07C8208E6B
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 00:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D25633013A58
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 23:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19F738C2C8;
	Wed,  4 Mar 2026 23:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoM+7H9G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909B1371046
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772666010; cv=pass; b=I2hUEukPgWxPL5olb04lO5fQslHNuSoS8uI1D81rDJdqDdqcQFcQ3Jb3z5a7CrEZktVVqHOeVzkzR5X7OXYeg6i8qAGjbMBqo3nuol/BXx8GrNPy4ESCRQe0QPlkOYuCdoIpKKolvit8o9e2MwiEBMGCRngZNF/2X3Vjchzmmo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772666010; c=relaxed/simple;
	bh=5l7t5GUb2D/4t62FXPSct37+0hReMV23ketRmHriGMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVL4RgTGH80KF1TI28JbmYtutd2f7+6VaE7NI43XIv0fq7OlgvF+rSutQVl7Lgh+2S4A0DAVjF22WBJ4vT4xJtVc1HKIqv08ToZU8Y0POnWpgOD74o655Oog/v2r5JHL/4hGT3OsjD3wG2YEiTQ2DXr6DpVmHQMI8qBypwHYoyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoM+7H9G; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ffbcfbcecaso530778137.3
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 15:13:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772666008; cv=none;
        d=google.com; s=arc-20240605;
        b=W9qKYckImNvFbTEJjfxdNUGDNmNeoU4z5W4wEbDeZqG3uUnYQ1wi8vXr84Sa8HDw+9
         5Sjlml86dXU18Pw98gVpXHb3vUnQdQt2WBcovaSyeyPmAaDGic+X/G7GdrLKsa4afCrm
         ivaT86JOvLSRruZHH8s12d6hNj3XMai+ll7eBTon/Qe07Ow3WdcY/ZNabTN0mRRlSoVS
         w7wjydfYsQP6zzNWvTvu3DB3QvTRRQnWFZKbMvGXeFo19B1t4Rbs9LS/PqHe6vPZqF6Q
         FPbmqi15PlmkY8FUSceiTzCwVEkJCJV4e/OcGpCXy+u4Zm7WNgGooh1b+alyAKicOBZ0
         /lGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cT8TknxJNuHJgHXdge5Ni6drCi6rxzjYWQCjsyroxlk=;
        fh=OGZMZo5o5hTmSPgqxUhoz2DxkhPddfMx1G56yhOmgqc=;
        b=b8uNe0dNjGjFhAxoJuVvfcWdVHVGrrLptgbyTp1Sd6lZJ4vv1R/aK1pTML5/esCgjJ
         Wo2OcFZtb7oFmVib1YU8GfSHJaJ3TBRrRW2NmPn9Zzp7lam+GA46EBj5xePiQiSb5Npj
         pPFhR1q7UIKrIQn9ukLbDpX7laSSepHFoghvf14wEDjJXgU6oca7/ek2xi0WA5IGOlse
         7YTDSCrz1mi5T5lSIZc9GFohEDsbXhxIKVWv8JEvYjWuYyMxVS/8h2v+dj5+MSmLNAE4
         2yZ5Rvb5Rptfgjzslgq1SZ4Ou49Ml/eHpNGRvOgH+iok8VwfYe8ZmtwxItBXkaCQve0S
         x5NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772666008; x=1773270808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cT8TknxJNuHJgHXdge5Ni6drCi6rxzjYWQCjsyroxlk=;
        b=FoM+7H9G6QmKyKIpSt7BuADbqN6Y46624d1yiJkV2lFt2bXbo6y7zJ7w69sefkqHYt
         stw+2pKpN2Fve9nXj1jmeLSjMiwH5IuFwRfztJ44f0oFi5Xq3cjs8tikVUynRA4/HcUt
         v3UwKJKuqOaoCAaedkq00VktAtmIbFmM1p3nt/HeKn+ZAfR6nBaBAsMPYEDDuvt1/YHw
         e6QThDGY6a2QQNSFUYiVT7KxBEtQx621jO9D6+DCis7czg3KTr1y7yE2IqpfFR8Trf4V
         jl89SG40RPLh9wtrDiLPaLS60YY9wXOmHtjg7qV1HP8ufdS6HQgrh2N6uCMrhsu9b++E
         L7WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772666008; x=1773270808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cT8TknxJNuHJgHXdge5Ni6drCi6rxzjYWQCjsyroxlk=;
        b=RAGkjSEpeCgTs1rlMzRXdYrtI29nUGBWxJHF7GwSXJYaQ028QJsWlOmBJ6lwut65EJ
         UgW6M4V3cG96bJeFhMyao9Ud2Q2iH12Hse6VTo/uaGw+KZk+lf32NdM9YV7ItSVGE12c
         1xcXMqLnImFotEvdbUrNMhSECMDLgdZ9CiIW14GUBbXS+yZIlO05IVM11XDAHHWJPfTK
         yFgc7nRvhHqX6xweAfYsJ2VqqIq61Wo0yJ2ec5CvJvtvU3pz9j8sdMMy90DwjI3JnGSA
         k8NcZRxWiJVERT9K4nYlbCmXXF7VFMOisodnUwkUaVvvlXI3HLtsisDaXs/uuAsYkNPi
         ez+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVrTGG0iW5mEASNl+l8DSjHpqxEbcgvEoEXN4eE6jjOaNnQTxSEdnTnB/qXVo+Jara/XXoVsBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI9coLnOn1nxpf/h3pbph/m2P1VO1QJ2KdYXTlpvDEHQuuV0wJ
	Smem+T3cU0HibGV8G5ZHFR19hUL3MAq6br3Nzr0bEzGgoLgVCSva2TYPCMtMkHwXDMyjPnyDEEM
	N2DBaTJ7JzfgrPePBFW3jONPCUivesps=
X-Gm-Gg: ATEYQzyE1/DTT1VRcPQMy9isgdUV3b6uNIh040aG8q2pQuxSHdmyUd9rbcoPNaRFlXd
	t68Xdk4KJBb9qajHaVZRcM/D9/oow6iraTwKgzmxTBxS3KGHhuz4/iZTK6wPYqW6guXKCa0JOtu
	ZezwSuw+NBeq8vFWn3RKMRopkb60xzHcd9M8pTboQqrZIdroxbPHwd+deopnzUHhPqt3YRjn2RP
	YCmkgx6DVvjEwDxTxhc0Pqj3YU+/1sgl4mib9IFrmBOQjEkumrBtZalXuB8StgbqFaDf1odKyW7
	n7i08QfhPNp6nngfIVFROvNkagO8D6gQ6lGkWau+YwkEq9+GU08tKRkWsi7gnFuAbPaAw0g0Ch/
	o7u7QiFYyiZgmJ9R/
X-Received: by 2002:a05:6102:5489:b0:5fe:652:5d2e with SMTP id
 ada2fe7eead31-5ffaaef0e47mr1704970137.24.1772666008447; Wed, 04 Mar 2026
 15:13:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e49a24b97a25a9c25bd33411b8212978dd566bd3.1771986861.git.lucien.xin@gmail.com>
 <20260303083338.35544-1-pabeni@redhat.com>
In-Reply-To: <20260303083338.35544-1-pabeni@redhat.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Wed, 4 Mar 2026 18:13:15 -0500
X-Gm-Features: AaiRm527Z74RAkiN-mCfJkeNg8yTAxvy5WGzpm2A5_gQLEbJOF1OYgOVWbRr1Wc
Message-ID: <CADvbK_eo-aMrhr39ai6i+QU4d30_-Z=_5Cn4K9Yr2=XQat_51w@mail.gmail.com>
Subject: Re: [net-next,v10,14/15] quic: add packet builder base
To: Paolo Abeni <pabeni@redhat.com>
Cc: hepengtao@xiaomi.com, kuba@kernel.org, jlayton@kernel.org, metze@samba.org, 
	davem@davemloft.net, kernel-tls-handshake@lists.linux.dev, horms@kernel.org, 
	hare@suse.de, aahringo@redhat.com, tfanelli@redhat.com, mail@johnericson.me, 
	andrew.gospodarek@broadcom.com, linkinjeon@kernel.org, dhowells@redhat.com, 
	matttbe@kernel.org, xiyou.wangcong@gmail.com, dreibh@simula.no, 
	jbaron@akamai.com, quic@lists.linux.dev, pc@manguebit.com, 
	marc@fiuczynski.com, edumazet@google.com, alibuda@linux.alibaba.com, 
	steved@redhat.com, illiliti@protonmail.com, tom@talpey.com, 
	marcelo.leitner@gmail.com, sd@queasysnail.net, linux-cifs@vger.kernel.org, 
	netdev@vger.kernel.org, mbuhl@openbsd.org, smfrench@gmail.com, 
	chuck.lever@oracle.com, daniel@haxx.se
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: F07C8208E6B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264087-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[xiaomi.com,kernel.org,samba.org,davemloft.net,lists.linux.dev,suse.de,redhat.com,johnericson.me,broadcom.com,gmail.com,simula.no,akamai.com,manguebit.com,fiuczynski.com,google.com,linux.alibaba.com,protonmail.com,talpey.com,queasysnail.net,vger.kernel.org,openbsd.org,oracle.com,haxx.se];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Tue, Mar 3, 2026 at 3:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> quic: add packet builder base
>
> This patch introduces 'quic_packet' to handle packing of QUIC packets on
> the transmit path, including frame packing, packet construction,
> encryption, bundling, and transmission logic.
>
> > diff --git a/net/quic/Makefile b/net/quic/Makefile
> > index 2ccf01ad9e22..0f903f4a7ff1 100644
> > --- a/net/quic/Makefile
> > +++ b/net/quic/Makefile
> > @@ -6,4 +6,4 @@
> >  obj-$(CONFIG_IP_QUIC) +=3D quic.o
> >
> >  quic-y :=3D common.o family.o protocol.o socket.o stream.o connid.o pa=
th.o \
> > -       cong.o pnspace.o crypto.o timer.o
> > +       cong.o pnspace.o crypto.o timer.o packet.o
> > diff --git a/net/quic/packet.c b/net/quic/packet.c
> > new file mode 100644
> > index 000000000000..a56edc745bb1
> > --- /dev/null
> > +++ b/net/quic/packet.c
>
> [ ... ]
>
> > +/* Perform routing for the QUIC packet on the specified path, update h=
eader length and MSS
> > + * accordingly, reset path and start PMTU timer.
> > + */
> > +int quic_packet_route(struct sock *sk)
> > +{
> > +     struct quic_path_group *paths =3D quic_paths(sk);
> > +     struct quic_packet *packet =3D quic_packet(sk);
> > +     union quic_addr *sa, *da;
> > +     u32 pmtu;
> > +     int err;
> > +
> > +     da =3D quic_path_daddr(paths, packet->path);
> > +     sa =3D quic_path_saddr(paths, packet->path);
> > +     err =3D quic_flow_route(sk, da, sa, &paths->fl);
> > +     if (err)
> > +             return err;
> > +
> > +     packet->hlen =3D quic_encap_len(da);
> > +     pmtu =3D min_t(u32, dst_mtu(__sk_dst_get(sk)), QUIC_PATH_MAX_PMTU=
);
> > +     quic_packet_mss_update(sk, pmtu - packet->hlen);
> > +
> > +     quic_path_pl_reset(paths);
> > +     quic_timer_reset(sk, QUIC_TIMER_PMTU, paths->plpmtud_interval);
> > +     return 0;
> > +}
> > +
> > +/* Configure the QUIC packet header and routing based on encryption le=
vel and path. */
> > +int quic_packet_config(struct sock *sk, u8 level, u8 path)
> > +{
>
> [ ... ]
>
> > +
> > +     /* Perform routing and MSS update for the configured packet. */
> > +     if (quic_packet_route(sk) < 0)
> > +             return -1;
> > +     return 0;
> > +}
>
> Should quic_packet_config() propagate the error code from
> quic_packet_route() instead of returning -1?
>
> The function quic_packet_route() returns proper negative errno values
> (via quic_flow_route()), but quic_packet_config() replaces any error
> with -1 (which is -EPERM). This could be misleading when diagnosing
> routing failures.
Currently quic_packet_config() callers will either skip the process or
return -ENETUNREACH on the failures. But maybe it's better to use the
errno from quic_packet_route(). I will try to improve this.

>
> > diff --git a/net/quic/packet.h b/net/quic/packet.h
> > new file mode 100644
> > index 000000000000..8c23be386207
> > --- /dev/null
> > +++ b/net/quic/packet.h
>
> [ ... ]
>
> > +static inline u8 quic_packet_taglen(struct quic_packet *packet)
> > +{
> > +     return packet->taglen[!!packet->level];
> > +}
> > +
> > +static inline void quic_packet_set_taglen(struct quic_packet *packet, =
u8 taglen)
> > +{
> > +     packet->taglen[0] =3D taglen;
> > +}
> > +
> > +static inline u32 quic_packet_mss(struct quic_packet *packet)
> > +{
> > +     return packet->mss[0] - packet->taglen[!!packet->level];
> > +}
> > +
> > +static inline u32 quic_packet_max_payload(struct quic_packet *packet)
> > +{
> > +     return packet->mss[0] - packet->overhead - packet->taglen[!!packe=
t->level];
> > +}
> > +
> > +static inline u32 quic_packet_max_payload_dgram(struct quic_packet *pa=
cket)
> > +{
> > +     return packet->mss[1] - packet->overhead - packet->taglen[!!packe=
t->level];
> > +}
>
> This isn't a bug, but quic_packet_mss(), quic_packet_max_payload(),
> and quic_packet_max_payload_dgram() all repeat the expression
> 'packet->taglen[!!packet->level]'.
>
> Could these use quic_packet_taglen(packet) instead for consistency?
>
OK.

Thanks.

