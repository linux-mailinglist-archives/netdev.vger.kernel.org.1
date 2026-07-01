Return-Path: <netdev+bounces-303487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QvagK/+3RGoGzgoAu9opvQ
	(envelope-from <netdev+bounces-303487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:47:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FC26EA529
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:47:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=akLdPfqH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303487-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303487-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82B14302C9E7
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 06:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35D386C24;
	Wed,  1 Jul 2026 06:47:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E882222CC
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 06:47:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888445; cv=pass; b=lsUQniXtJL5FQnVexR5Ny2Dcwc6WkQRfuvF9H4hg1NBEozIx9nXHQtXdYtvwN7/oND582Bccfkec/AhqKCPhalT3jkYB9GNHzQfb0ctj7WSbmPUOETkuQ5vuwC/iQUo88rXln1ajEU+Vdb4VethJ187wVGOuiV6QMo7/NwyjN34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888445; c=relaxed/simple;
	bh=yHfnDNKQ+eMSXbU6aaouLG3JaLqu3chs+ORRJoRjSbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JkQDAyz+O30WPfffTpPQSLciLAfL6owakdI2T2K1E20TppbD/ccj5AJy3MnS1Ge45gppUYd+iognHB1fNPPqrgkYM38NqE99+uVEUPed6Yk1FmN0xhsDuxw8E2X9f+SXcbPJwAfvs7aqIEBJSlWdY569NUgeA4QC9Dmwx0W/sK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=akLdPfqH; arc=pass smtp.client-ip=209.85.160.181
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-516d0db9372so2314551cf.2
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:47:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782888443; cv=none;
        d=google.com; s=arc-20260327;
        b=YMuPYCFgtGJy5/I4i1Gk+1R3peQFpKye1LC18v3BeNbcOpSGfXxdaxs8OZhdblf+/B
         c17OZF9LPdCoicjl9CerSOyCE8XtDor04N2fTtdn+Iu+baDCiQebe8id8NLYnXwlGlqa
         h+nt7dODuS4fgUL48NUi4DnTjMZRm6DEldhB/uuQUmnlA2E9DCvhCCwMJmzosFyNrX0I
         Psv9Zue+CgR+nBsrpvmfmUt2aYmdYBX9X9h8pnTBv7njbxMas5pKafTpOUxDN34oRdWm
         3QAEmQZm902O61cO0/2zPxLawP84FLD6bcHFrNOFA2jdluCjpgv1OdkZ/vAjfMywgTDD
         hncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yHfnDNKQ+eMSXbU6aaouLG3JaLqu3chs+ORRJoRjSbA=;
        fh=LAp9DfTpiUz48XdKAKCLqB4DhzlZAVYAzdZiDou30LI=;
        b=kf+Fe66Y+bSGqcj/XCgYop2aVWpVR9fp078LKIA4W+ipEGmEhbAupshltAGDifqaKq
         nVcVqnBMe+9NZcM7r8ngxk3Axde2kDQHPfahu7qGGqqCGOYkpx+LJchG+JNuxFGiw5+9
         zB5+QSnuOOYYGjnArHvsaDtPLg4cCZCrCd7m7I37PgkmS25tmkA3ErXXDzuE76wGako+
         bZiMlLjHp9cU1Umx/Q5mKkniMD3Awhg7evD34seaRqX8BopNMvHTHJQQnWW8uP/xyi26
         cj+J1X3lIBGYDyT3Z2oHctYZhGtJM2T9uldG9tNMijYHa4E8tnTRkwwUjX169xSeLxPz
         bBvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782888443; x=1783493243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yHfnDNKQ+eMSXbU6aaouLG3JaLqu3chs+ORRJoRjSbA=;
        b=akLdPfqHpgBQc35JmxmKE56LCLbgSNjhFZ3Rh3JHaeK39wQkX7/n5RDcTOTw7n4Wg0
         xO4jvmgtxtXfE3zsBWK+O/NEApL9XTT7ukNuwoh64aIMFUYYGZ4rZKqapQtuu1A9lwi6
         zNF62F8ohzXx//Yb6ThjB8HwdbrtME3xQx7/+Rxphy2ZDkk3rCplsSylZ5JmLHXn0rE/
         TDqbmdnH505XVbdFgTN/gvvPZRklTO/QtX3eVGkw0uy9wPVZH3sS09OW1rzsjBg0fgOv
         whA6483o4+n3K5dCYaVoB1y4Gwr9qD0y9ItP5MvjYsCpkgEWsmR+hcCuuSgsPzsaejLx
         MBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782888443; x=1783493243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yHfnDNKQ+eMSXbU6aaouLG3JaLqu3chs+ORRJoRjSbA=;
        b=KMN9DvwEfQE8ZHkMx0iI2TWl/4sSm3HXr04HzCuHfuDDbWZSAMAP2E4jX2TbmzUPdM
         t3t4f/ONIHvnNI+62zwDIMgxAU0WbvfmnrNvpzG445UVbWMMcKTJfGkPdWJdILiL7NIY
         TyodV/QMt+P0UvGgsfntrIPOygJPbvB7NJ2kawUh+SIC7/10u8wwHGtJZKY5tI6bQf5n
         FeMHuE7GzE986NDqplfgLRNn2p3NOBJmrDZzlj6ruqQu/WaYazMSwK02TibigBvXEnU2
         zxqDBDxvBDasSfZta7LpST6JOMU31G4lUQKuXYr3PcDJJUbNAfwCXWgS5gCeZk2NBr8C
         BqUQ==
X-Gm-Message-State: AOJu0YzutnagbYQQdrzjIi23LuKQQqP/898ufuZ+NE+N6/tVg6Xjsl7Y
	WmIE9IqZZzFgHqFLLotzg2Z6nfXcSKFmv4SLUH7mdt3cCZb3+Ktoboeg9NuVnFFhIHK21fbpnbM
	aueHSh8FE26AghOFF6V3B8MUIf65+qbSXwK2nsKdD
X-Gm-Gg: AfdE7cnZZcoyXgRUytb0rebBXkEnucstRp1K79Ep2yr9EvtEPuu/0xnzdx45xdINtQi
	rImdaORkl5cjAxajA/wzFIEVKecXHwLdBhzqHHpyW1XS7n6iL8MPXeLMiGRtTdqT8aTzgIteG9+
	gNPbe37c1IuaW0++X2r1Y9iWrY8i6bgapL4+cCLr3QD77OjbEzyrtutKVLVPPgieniWpLfgyTgN
	OGcD5J3O4w+qlDoI0gIwWwoK0FD0gzRXQLuT8wt1/8E4fXZUJ8xEViRO85H2CzHUi226ANssVTC
	nCh+7BX/v5BQ5ek8kUdr+f16J2OFDfN2JAWqr5XzetpJDrX92lSFAvVHrU/W04uMRgd/mv4FwRg
	7yk4df61fYQ==
X-Received: by 2002:ac8:5f09:0:b0:51c:ff8:cd4c with SMTP id
 d75a77b69052e-51c26b62cb1mr4083111cf.72.1782888442345; Tue, 30 Jun 2026
 23:47:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701022617.53171-1-q.h.hack.winter@gmail.com>
In-Reply-To: <20260701022617.53171-1-q.h.hack.winter@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 30 Jun 2026 23:47:10 -0700
X-Gm-Features: AVVi8CddaaeyyM2qct7DPnVaW0hbLhXtbQ99cmq0p_vwz3JEcEwcJVnt7NyOt3k
Message-ID: <CANn89i+==hgjac7VoHtcFpm+M5DQc7U1xkmyeWvwRfnR066Yxw@mail.gmail.com>
Subject: Re: [PATCH net] gue: validate REMCSUM private option length
To: Qihang <q.h.hack.winter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:q.h.hack.winter@gmail.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:qhhackwinter@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-303487-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 35FC26EA529

On Tue, Jun 30, 2026 at 7:27=E2=80=AFPM Qihang <q.h.hack.winter@gmail.com> =
wrote:
>
> GUE private flags can indicate that remote checksum offload metadata is
> present. The private flags field itself is accounted for by
> guehdr_flags_len(), but guehdr_priv_flags_len() currently returns 0 even
> when GUE_PFLAG_REMCSUM is set.
>
> This lets a packet with only the private flags field pass
> validate_gue_flags(), after which gue_remcsum() and gue_gro_remcsum()
> read the missing REMCSUM start/offset fields from the following bytes.
>
> Account for GUE_PLEN_REMCSUM when GUE_PFLAG_REMCSUM is present so that
> malformed packets are rejected during option validation.
>
> Fixes: c1aa8347e73e ("gue: Protocol constants for remote checksum offload=
")
> Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

