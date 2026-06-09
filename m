Return-Path: <netdev+bounces-296833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cZBhIT5pJ2p2wQIAu9opvQ
	(envelope-from <netdev+bounces-296833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:15:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBEE65B93D
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 03:15:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=jry4WnR0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296833-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296833-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 295C6301BCFC
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 01:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C364025F7A9;
	Tue,  9 Jun 2026 01:15:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEC52749CF
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 01:15:37 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780967738; cv=pass; b=F0RLK/qRQUIjgZbVoanH7MB/1O8Uu8Pg8BqKvrqp1mTPXD2ESpSzxBfOaHsdZllzllFjjbHPFtNqrmzngDLWItLKdBvF3LQxgV/D1AdX5GlQiozXLrz5RSpavVXqw4NpPdGwFQlKmlWZ36Jfb+ZjcXy0/mzar8bBwrA5zR4BiuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780967738; c=relaxed/simple;
	bh=Nz0mDBqZiy6SwWAJUJFsIE3UPcHXzQp7WDSMq+Hy1J8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oETFsiAfkBaYi2iSCkch13mJgnt39sycxZTuOeX4fkdKzGsMC9oetKV9TqSnQ0Re+bSkJtnsFrM07suxA75eW9DC9jQj5RO8kmRvFL3sVuKT+E6pZhERMi7HwV6hGunX+1KcUlUcbnbJuETdvgmM5KKvSIsjzWiwus0v2bWke+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jry4WnR0; arc=pass smtp.client-ip=209.85.160.175
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51778069c31so40160741cf.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 18:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780967736; cv=none;
        d=google.com; s=arc-20240605;
        b=Yxm0fD7k9cWL60P74vGrMYylUWXAhGuJmgsHHmSmWzNE2ta1DL3G6loUjlzg7PwafE
         yzGA7Yk3JfYAxc4LYv2heYSejmnmT7e2RrxXBFUCshybut8T80At/Tlp5xWXrq9QxWdt
         7YGWDEzsmJANZZwojehY6iH6J5JRB6poT/BbY6KRgr4/nncW0VV+noBsng0oEW6aFQ/e
         HWUGrEgumWrsiCHoyJFQe0tOoc2HbauZUuiU4cm1N0e8aRFUfkkj+ajMxdNAIN3Br45D
         2NkqlaHKNp8MYLpQAizN0Zs+MOcCGYkOQ7LEJzta8PDkkP8lVnel8VuF+ogx8DEGRnPT
         uIpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nz0mDBqZiy6SwWAJUJFsIE3UPcHXzQp7WDSMq+Hy1J8=;
        fh=c4gMf42RWDRKhdae9ROr3M1KKEPR06Hp4+27DBvl0ec=;
        b=SI8L9qGzTiwANe9EF3RU6CuXZ6Vm3k0nVCS4WnRPgFhyI4fK9SymPm7u9lDD+lyiNE
         WbVrMkfSws8TaIHtGMlS9JWz96y0R6ptpx2qm2dq/iitQWwDDVkcLX9Qp4hCk08nNgSq
         g9sdyjg2FMPpX92u1j5LTk9E3Ufv7bSen3DULqn1aswqJWBPRs1/sMZoxys1/+98gAWD
         1Dg87KIAAcvtXKSfKqweHZkezbWydJJVFa5GbRuNItc3XkSzvbeUZfrRKl13Zz1GXnle
         lDp7XJL8xv89pckfj2GKLbetgJyK9IVrcAJbAeEOmbilPVjo72F1gSoBWOVPxNFdciOQ
         fSkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780967736; x=1781572536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz0mDBqZiy6SwWAJUJFsIE3UPcHXzQp7WDSMq+Hy1J8=;
        b=jry4WnR0O/K1zsOGUApbyDwV+J+HuJDuacpdD+9xsqwEcs2obmXiWSl1Ispb8P1PIh
         TbYXY34jSGQXgnvcRqicF9rLkGRtzT1AJjgoyjyrv3ITxVfu8ZTsAbZTlYdnoX42VtHu
         PhK6p8yx6yNWRU/nOd0U9Yondrnu9gMVe3BAmeiX7RV3zAhUQ+HSkn0uqtPKqPHPervh
         tfgZfjbvxG0tG5CWDIg3TNfD3nDg+VN6sw83pUvqjsEaCvVKaPujWLgzYvs0KKw3YBlG
         hEmDJISKwK7LV0rO4Ew8jmokgC3pNZiMTCQcZXCYitJsam/ReD861VubMajofIsfgPh9
         eJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780967736; x=1781572536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nz0mDBqZiy6SwWAJUJFsIE3UPcHXzQp7WDSMq+Hy1J8=;
        b=Qpm7rD1Up/cSIqMSaODSKzE5j2JhMJNVAjxa4kIZgLU8rAjZWKiggUTNHG86J4xP7j
         eKxaC+Dx9wh479TWiQ0dioycMOydoVfbBgSKSgIkXjZJyImfbHVejYqeomSPW5XFDiKg
         3yd5L8/w7Mv5zPZB4SfFYyVx2zowMonj5kXdo3i//Zqrv3phD7lrNjnP5B3OJnh30drR
         QwPw3n9nJRM0vXyOxBYEL2T5QiZ/s/U24VoQ4delYeZAbuQLLLRIa2z3MB+xcyWgv84+
         EZrBeY4QPD7CrVHtNbyf2IC3KaTQ0rNl7gL9BjeSh8ierB78aEAbHqOMuCvPwVS39aLv
         7zBQ==
X-Gm-Message-State: AOJu0YwlzkOlFhTY9i1pNwo4jCCNhE9YUB4CaWmxxbx7KG1N8ZwZ1S20
	d61AtEZxRE+5bvukwP0eou1iMCTh4LGxO8QnhdRBNAyIOYXQUQ/W2kPY2gVZWoHfW35GxQsQ68I
	Bl2L/WVkBcvLg/y8mH0x09sA929ox/MiUroAvUz2VkGu4Za4YZBE/Wj+S
X-Gm-Gg: Acq92OGcoVlB0dHwMDGsRUhxCI/Cc3+9D8Nl2XVKCMX0PpZ3MDbysBB4hJG23smSGmH
	2cXfZROdDypEwLrpr3eO1odX2ZR0xWs8hDwAl9TBnmPlHmu0pVcGbEbr0mxZopJFSkyemtF475g
	3GR9xuLmB/yyM62i2/mC2PtqSBEUxE3f0p013syl2IDW5tee5ExtrCKE+7MZTNb7EuHXfjzFgZ+
	/lYmLCGHwnPBrcqiKo2EOP0tZZTOwwmB74yTld30xlaxi9hdf2XYOm/a2qW5QXzWPP+S8x7+66U
	AHF4MackCNaQgONWU/VuHTCdsru0kE7fmEAYx26+l7Bzu2RrnCkNNtINajO2JjxLT4BSCQ6Ookm
	M3hKYRPfjHYghbEoYEEXoxrbVA+Bo
X-Received: by 2002:a05:622a:1186:b0:517:71ac:83f5 with SMTP id
 d75a77b69052e-51795a08cc9mr267707651cf.3.1780967735532; Mon, 08 Jun 2026
 18:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608130755.5626-1-maklimek97@gmail.com>
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jun 2026 18:15:24 -0700
X-Gm-Features: AVVi8CchGWb7sBH44DM2V_xs-5lB0sjWJEpP0rG6c63RyQnzh6jbHYUZ_tC62r0
Message-ID: <CANn89iLjG0krEoEE__3KUrcK+ZO+USZRC_2qZV5hAsxRpkTmhw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/10] tcp: support non-GSO jumbograms
To: Mariusz Klimek <maklimek97@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, 
	ncardwell@google.com, shuah@kernel.org, kuniyu@google.com, 
	alice@isovalent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maklimek97@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-296833-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DFBEE65B93D

On Mon, Jun 8, 2026 at 9:35=E2=80=AFAM Mariusz Klimek <maklimek97@gmail.com=
> wrote:
>
> This series adds support for sending TCP jumbograms over MTUs above 65535=
,
> and adds support for setting such MTUs on veth devices.
>
> The TCP stack is already capable of receiving jumbograms and (up until
> recently) sending GSO-jumbograms that get segmented before exiting the
> host. However, the TCP stack doesn't support sending regular jumbograms
> over high MTUs as described in RFC2675. Specifically, the TCP stack doesn=
't
> support an MSS greater than 65535.
>
> No device currently supports setting an MTU greater than 65535 but there
> are some devices that could benefit from higher MTUs and that can
> theoretically support it. For example, IPoIB in connected-mode can suppor=
t
> MTUs up to 2^31. Virtual devices such as veth have no physical limitation=
s
> and therefore could also support such MTUs.
>
> This series only adds support for setting high MTUs on veth devices, with
> support for other devices being delegated to future patch series. Allowin=
g
> jumbograms to pass through veth devices is useful for testing jumbogram
> functionality, and also increases throughput when compared to BIG TCP (se=
e
> the benchmark numbers below).
>
> In addition to removing the upper limit on veth MTUs, This series adds th=
e
> missing pieces that allow the TCP stack to send TCP jumbograms. This
> includes a bit of code removed recently by Alice's patch series [1]. Most
> of the patches in this series are rather trivial. The main problem
> addressed by this series is that the TCP stack conflates the TSO segment
> length with the MSS, but the TSO segment length is a 16-bit integer, whic=
h
> doesn't allow for MSS > 65535. This series decouples them.
>
> Running iperf over veth on an Intel Core i9-12900K CPU shows a 5%
> improvement in throughput.
>
> Commands:
> iperf3 -s
> iperf3 -c -l 500KiB ${SERVER_IP}%veth0

You are adding code to TCP fast path, for a narrow (and possibly
dangerous) use case.

I am sorry, I will not review this patch series coming from a first-timer.

