Return-Path: <netdev+bounces-257162-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKoZJU+ZhGmh3gMAu9opvQ
	(envelope-from <netdev+bounces-257162-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:21:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8A8F32AD
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 14:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C17E930086D2
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 13:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2564A3D330A;
	Thu,  5 Feb 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2BcCQOy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76814414
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297632; cv=pass; b=rWYcslLcclZ2nsskrKn+HYRB3ZcCrNnvK3kq41VkYxMwbWE8uyxEeHijL8JSREczM9uPWrCkkhXyjjDhMXjvVdkmxHXZEqXwlFLdvl96Xp5S3Lw3lfGaj3FlDYVxfD058MT9P1JsFiCCJlgf09wsimTrfS13l5UJHaHApuoVeZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297632; c=relaxed/simple;
	bh=+0qD3481OxJx/GzPxCze8mEUjrwmVraEw0kqw6Nb+Ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pd2tWN4W3EnmsQFimo8Aa5Eh7kgI++3wL2aZx0Cisflb7zBsCcm9egEWX3QIqSbxcJLnPMuDX0OUszhVZSyXW9f0IJInXYnHiUkq0upHMEXUAXrSNakzSNMZLIs+1zHkhwrJPsMLl8PONYT/hykVLXVc9QMl6JQVr8UOnqpEntA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2BcCQOy; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50299648ae9so421291cf.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 05:20:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770297630; cv=none;
        d=google.com; s=arc-20240605;
        b=RFB/81gMvj/vDt7MThtJDHH2zSKWMCVc4KZu22AT0dtXzB3KK83OTSo37i8GmwLWkM
         bYuwrYFNxUJmbLjlxCmNPWxtP/VVtoggZXb7z9zSie8I7jMAujlyz1z6zPOQyPh2nGUM
         1o5mbBfDN8rTyHjqdqzDvma+qre/X7qpP8yE4Dl7ZtLoUvTIrlqJrsVFfhwNbGiyzP+W
         pNqzoqkhl+drcnzptsMw68AlXUzQf2sePre2g45FZYqz5CwVEiWZ75Q1z6VkI7eT6Ufj
         fJO45Uh7IseuKljAwNoXJRobL8T+Avct5z3bEusLSKBkRpaVQgvgzp70u8qKTsvcQMGQ
         bgzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nUxzn6tyMigJh/FRYg1m34qD7OVTrxYvrqfI67oJIC8=;
        fh=vAjP76cOv87YgZUBgN3byGSUb3LJ5jWpnCMY7bVHaSg=;
        b=lV+4wjg4oKecCOLcG5rq8PQoBvWhHHb+kqjj7ymwAvuGfggp6wnSNgI9zofXlQNFbt
         Zv23St2GD+rwnmb3gPGsCsoMPtemJ+ysqMtkYtHubYSJDJxWxaKk5xtLfuFPStCdyBlc
         qMFT8Pfy/VD2VF7GmM962O60Gl7eQhWCNDrjrfWGYaIcEyO0KmfMrand9rqNdvV7IHkA
         T0VA7URDNxMwZuBvAN7W59Sw5GjqesjYiC/sRr4jZDQ8O9hbhD01+Yy85+e+PZHtLnV2
         HGjKKPZCbxaqtbzr7qopkS8QUfZuBBhVTB/ERyav6PFwlWadI/iBhVDjjnb5Dvli8VJS
         Xd2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770297630; x=1770902430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUxzn6tyMigJh/FRYg1m34qD7OVTrxYvrqfI67oJIC8=;
        b=B2BcCQOy4Ztpc4d2HMMwqy7nPYW/R6GeI7fxmq+WaykAcWlEGYNdKdR7JfdsT7nS7B
         twAJFb03QPFI7rnhPCQKK6gHpBt6TbDAzlUGjQenZ94NnceBTcuFZdNLaiBJ10/44+n9
         Ck+m2uHR25+GEdDXS0t+Oi0QC6SY6xnefa7P/jyMCtdbiM3sEqzJEMVFM2pyj9z3CaB3
         tZJYkntfdAKYX3Nb5gN59/vDOqoSz74hoqDVBDvDhpguiIfYujOpJHB0gzveW0DmPg1O
         K6r0XoOBbMxTiFnm7k/zzIfJ7qr8yysIRKcsuRUfCn+L+2l2X9oyLik11V7FhCu48+Io
         xgHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770297630; x=1770902430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nUxzn6tyMigJh/FRYg1m34qD7OVTrxYvrqfI67oJIC8=;
        b=RIsit7ORWagAJWERAex/s/gILJbO5khRv0qjMP+oE5cOtEj9AO1y8YAsd/dV9iXY33
         fQRpRfixDKbZwlbgXLQsllB23c/0L8cGRkrU9Paf2+89O+B6fqmXMIxlgbvwgrZtq6sH
         G+YHAGlB11v/xdSoUIXpunZvAuVA9lZDb1RGYi219tTREtBz1PJ7srvJtl1z3A1+TCq6
         +CP0YaJH+FVh5xsVJ7WqdghkiZaew56XTObadcfHhoGnrIzLnk25N6irzPSJMobVT54L
         zgZOKXtx5Xte6PeeBFxmKlRvghl0bOWtFPgvAo3gLPB34jskcQcSsozn2K3yKBRG4LlF
         1g3g==
X-Forwarded-Encrypted: i=1; AJvYcCXYjo44J9/bvonu8SsnU98WoCi+m/+uA92SGv3buurpivsFT6iPy1JuQNZpyK8VuHey80322T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUXzp1PcQOtC14YT6Smq7Ti8GG37M69u4AvmvlxSs/sgnCsTuB
	G1f6yQeKgjUDZ5sswNxQ2VCsihn5CDsHZvzsem8yj13fxQbMWDHcWc7gRosSRSIfqonoFLg2C7M
	j7ysrawopVQ+vwgPexEKap9yz5QsPEx+41ZGQ9f30
X-Gm-Gg: AZuq6aLToHlY/Z8iKTqytPGfgPlavO1hkNBTbAqXq8E/dGfu6Os8qC5mZLzRGKAmUB7
	2P3No5kh7BzEVSnzwI3w11OpUt4chX+zrNfQWfubVegSuqPE7+dpTiLWStoCwHMi9Ed77Vc55bu
	ae0qSd2xa3luqZbKroewjJp1Q2W7W274kFZV8kEqR/zY/eyiWVWL8TrG6j8636M2ITsU57c34tA
	svM0yY2IJElyjhCs5/i7nTQuXcmTBApntKWqZd89559Sg/++K9yp5mPoCTNa+Nt7fPgvMU3OpUl
	ZShcur/aPDcg5487qAYlk4NcsjhilhDI8OVUAX7DTC4ly8yWkieOKLyoj9Q=
X-Received: by 2002:ac8:5d04:0:b0:4f3:54eb:f26e with SMTP id
 d75a77b69052e-5062c7a7717mr7406091cf.1.1770297630215; Thu, 05 Feb 2026
 05:20:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260202101454.89445-1-kelmenhorst@uni-osnabrueck.de>
 <CADVnQykLpW+GV6sSG5py1J+WTZFM-=JObhYS7Pwd=9ut1GY1BQ@mail.gmail.com>
 <f1137fcf-1778-4811-9211-4beb95db3a32@uni-osnabrueck.de> <CADVnQy=u4zQjC6A9WBvnZOvRFAVzi=0rSzbSs_4kujB2u0U2EQ@mail.gmail.com>
 <e0e3738e-c01f-4c2e-a782-3e7c99d8b647@uni-osnabrueck.de>
In-Reply-To: <e0e3738e-c01f-4c2e-a782-3e7c99d8b647@uni-osnabrueck.de>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 5 Feb 2026 08:20:13 -0500
X-Gm-Features: AZwV_QhnxEZWYY4PyKDaD8wxhkrh0hRBc34ZsogNCGNG_dmDwksiSK7pHM1MoGY
Message-ID: <CADVnQymv0063ymyWbwof3wn9WuQANhX8B_oR4Tv_YcRHMZXpDg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: tcp_bbr: use high pacing gain when the
 sender fails to put enough data inflight
To: Kathrin Elmenhorst <kelmenhorst@uni-osnabrueck.de>
Cc: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257162-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ncardwell@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA8A8F32AD
X-Rspamd-Action: no action

On Thu, Feb 5, 2026 at 3:30=E2=80=AFAM Kathrin Elmenhorst
<kelmenhorst@uni-osnabrueck.de> wrote:
>
> On 2/3/26 15:29, Neal Cardwell wrote:
>
> > The "or is reset to" part is an incorrect reading of the code; BBR
> > does not reset itself to STARTUP when the connection is app-limited.
> > :-)
> > Please note that in bbr_cwnd_event() when an app-limited connection in
> > BBR_PROBE_BW restarts from idle, BBR sets the pacing rate to 1.0x the
> > estimated bandwidth. This is the common case for long-lived BBR
> > connections with application-limited behavior. Your proposed patch
> > makes the behavior much more aggressive in this case.
>
> Got you, so the high pacing gain for app-limited sockets only applies
> at the start, before BBR thinks that the full bandwidth has been
> reached for the first time.

I think that is still a misleading way to frame the dynamics. The high
pacing gain in STARTUP applies to all connections, whether app-limited
or not. And then if a connection meets the conditions for exiting
startup (3 non-app-limited round-trips without the estimated bandwidth
growing 1.25x) then the connection exits STARTUP, and stops using the
high pacing gain.

> Thanks! I will check out the patches and test them with CUBIC and fq
> on our setup.

Great, thanks! Looking forward to hearing what impacts you find from a
len_ns  patch like that, for both BBR and paced CUBIC!

best regards,
neal

