Return-Path: <netdev+bounces-272737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rtA3JY95x2k+YAUAu9opvQ
	(envelope-from <netdev+bounces-272737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:47:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BBC34D8A8
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 07:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1273300D682
	for <lists+netdev@lfdr.de>; Sat, 28 Mar 2026 06:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7610721CA13;
	Sat, 28 Mar 2026 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="kep81Z+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B541040DFD1
	for <netdev@vger.kernel.org>; Sat, 28 Mar 2026 06:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774680460; cv=pass; b=stBw6Jf7764h+aX9JQK1wp7ORowtn9aLRp9VJaaCHogTQK2C6fj9D8JCzWxC38iVBmgIaByVIjZR9vfwD+ezncENMOlJBQ0i93wUwNXJ+R6ic3GaTeob28Lh4QprtPezMLOqyBH2t/J/d5YzQ68460sgYhbDiJ6dKo0Sc4JUuSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774680460; c=relaxed/simple;
	bh=zryy76DaHt7oi4lNm/4tBM1hJztZ3WKVYQDK+AX6UqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CXPWAD16IPy7KqNZv5xmU50482Lq5fJeoJwPdiANDXhX2bog1IX1VGeb7+NKjWnUOzNBVfSfzeYK/VjUFa0lVNaoBniPppkPKLVwtywJmlTNvWyJIEDKEfBcQbGDWGlmGWTX694L0QISo+5/Zd76qWmFC54QqnVSx5u6u2tZfPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=kep81Z+s; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adbfab4501so13806755ad.2
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 23:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774680457; cv=none;
        d=google.com; s=arc-20240605;
        b=HROOAy4rvRxlSS+ASTjbhKkIx4fuONx/Z0tHQypHoz19iBQ4nL5T0dADcwp4E89aHk
         ielMF3voLREU3LTOvoyvGXqVu73FypkZtU0QLeLY2wieLDGPfWhPfAu12wrx5u6rF7e4
         fq0aA1uB2OYWVUv5gx577Bd69xMOdcHV2TwjcWSx3El8GyUaKqd/o42O4R+rQgiiyVYz
         iMTk3Hz7wcr2W2X3KveX7pW/qliKi4JrapMyqhzgedZVrm/thhs2TgUaAYaXYLCdPWRV
         W1ZLREgva+Ah1i0yUfGARPv7fqQJPhZdrGDh45r2Y9sh0W3LrXBa3KPymevUkwaO8jJ0
         v5NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=efA79Kc3jncizKFfyvZBGhmIZfpFT0np0LuNGDRDSDk=;
        fh=GNrInmpCufHw43ct8y2HLbjENc0ttbzizuQgway7IA0=;
        b=QKwWgUuxFiB5RfjpEgblBkLm2tEsS01LVStpozN7DCQ2wm2bnmfsWDt/W2M98z8llF
         EWeUgAL0CizGrixx42Cz96HB3RdTLKKqDtSiYcQ8qyJOZM6Xs2ktfOmw5Fjd5QYIo8ek
         gJJqzKkdkwR4Q/aN7VZpa4PDjkZFDgQOv3x5qjEynvLOVB0Ujic/DkXp5o6MHNXSV8AJ
         Em+qeAJEc5+6jDVW0SnU4qqZNxWdXDFg2iXaL/QGhReZPviYqd/RQBD3vqExmKRUMczG
         jd6BdE+h2mSRKzuwhEn087fn6o+ulE1g2NVGtX98TNiCDtitUf46xQsdoY+QXeQQyJZo
         ab3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1774680457; x=1775285257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=efA79Kc3jncizKFfyvZBGhmIZfpFT0np0LuNGDRDSDk=;
        b=kep81Z+sVSoWso6SPIi4jifpGT+BuGov0+GWkHXoyGxRDerg2wX12FU3Ti5lkpBXcm
         CXbO78o0Ir1HmKWexYFFVM7LIJ0iOAlj3oOvXXLKWjmrq7h+x3qAhloszWuCQu0NiWPb
         8zdX7x522XcKtTRtkDdNkYzwtGTHrRTyXvT90eLtNpN/peOXL4QdFUqFC6Dc6nMY7QAO
         PxNw3nRyqXqJdNzah9BYb5KgwY/pur/EWjejohaWo9n2sXaOjzR9Xd6c/R8ciHh8spYo
         5fBxeKJO4zi5VVMv/pDq1m4AZARWCCQhqTC8BXcN2pP783KRJciLxT/jexlwBhO9d68u
         ui3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774680457; x=1775285257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=efA79Kc3jncizKFfyvZBGhmIZfpFT0np0LuNGDRDSDk=;
        b=cTeaw2xZrogdWLKtdiaCrFmZx/G3Q9ts3Km5xqte6hN3B9nFF1gym2T/S362by3LgM
         X+xbO0zFHfI2nalgndgzJOI5/308qiwqb9QpCFrWIoZSiacjQ3bq/AUeAl1or7K242bu
         /f9Iag1zJP7XHZnx2XEbjnF+fedH6bcZez+RiMCrgz4EpbD1OVTm22pYquEYnYCqXrns
         QlhCUZgHyO9frdWmZUZdHyiNoi1Od1O1RNOZ3e6rbTgcc7X2K2W7uqB5fMJj3awqsHPE
         O3HgMrvHC9zVkve0tBaycaVFFTZ3uSRp64jUwXMVCOBbf+0sNzeVXaslFFNm60pcPr2y
         MUsg==
X-Gm-Message-State: AOJu0YzvEprEGkcSohohFGQEBEIy/HLKzNu+IGEGGe/FLvzooBb2Yl+V
	IHfgE7e9mJGbCTZDlzt1fI31uh2fN1DuOyBPIOCxu7zt4Oj/Ytv/lOaWPVQ594hiIMDz0h5CgaK
	3yUrkIX4zAMaIG/iDGOektWf+232CAj2SPTNQJ3Uj
X-Gm-Gg: ATEYQzwtTXQOHaeRJqKNwlj7nIvEp+l04xriAaLWFmZtfCT7tH2GH2QHbi3lhKso0D3
	eG2lidvn4qOB4jjOmQBE+f+C8kk6iG8564C6gIQL5fKF+0fgQLk41EoJnxcch2+rOXx64MnNPVZ
	AgoUwXd45gKdfBpgBJ2zsY8kAy2Qu4jG99HamMzogEsAFd2OaLfYIJ5XIceOPB6vr9Sz0jvoJoD
	IbamGXMIquqbJS6IQd6EyqKCZvA/d9RPSvddVMkH1rGvzDN3pReH8WA6GFdfrr/LaLTEbIuquqS
	cyvBJKyz
X-Received: by 2002:a17:903:1a0c:b0:2b0:7224:a4f3 with SMTP id
 d9443c01a7336-2b0cdd40b60mr52610835ad.48.1774680456961; Fri, 27 Mar 2026
 23:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328063000.1845376-1-xmei5@asu.edu> <edad225a-79cc-42de-a771-b1ea6d430ef7@blackwall.org>
In-Reply-To: <edad225a-79cc-42de-a771-b1ea6d430ef7@blackwall.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Fri, 27 Mar 2026 23:47:26 -0700
X-Gm-Features: AQROBzAbJpV1CkxbRr5-qliISa1tOnspYTMXZ0FCgpdfmusuPjcBODzQ14y4YhQ
Message-ID: <CAPpSM+R5pM_X2_dbWvvpUn-MvZtqiLEXbmotnEQf+5DvPjxumw@mail.gmail.com>
Subject: Re: [PATCH net v2] bridge: mrp: reject zero test interval to avoid
 OOM panic
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, horms@kernel.org, 
	kuba@kernel.org, idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, bestswngs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-272737-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[asu.edu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:dkim,asu.edu:email,blackwall.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E1BBC34D8A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for the quick review.

On Fri, Mar 27, 2026 at 11:44=E2=80=AFPM Nikolay Aleksandrov
<razor@blackwall.org> wrote:
>
> On 28/03/2026 08:30, Xiang Mei wrote:
> > br_mrp_start_test() and br_mrp_start_in_test() accept the user-supplied
> > interval value from netlink without validation. When interval is 0,
> > usecs_to_jiffies(0) yields 0, causing the delayed work
> > (br_mrp_test_work_expired / br_mrp_in_test_work_expired) to reschedule
> > itself with zero delay. This creates a tight loop on system_percpu_wq
> > that allocates and transmits MRP test frames at maximum rate, exhaustin=
g
> > all system memory and causing a kernel panic via OOM deadlock.
> >
> > The same zero-interval issue applies to br_mrp_start_in_test_parse()
> > for interconnect test frames.
> >
> > Use NLA_POLICY_MIN(NLA_U32, 1) in the nla_policy tables for both
> > IFLA_BRIDGE_MRP_START_TEST_INTERVAL and
> > IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL, so zero is rejected at the
> > netlink attribute parsing layer before the value ever reaches the
> > workqueue scheduling code. This is consistent with how other bridge
> > subsystems (br_fdb, br_mst) enforce range constraints on netlink
> > attributes.
> >
> > Fixes: 20f6a05ef635 ("bridge: mrp: Rework the MRP netlink interface")
> > Fixes: 7ab1748e4ce6 ("bridge: mrp: Extend MRP netlink interface for con=
figuring MRP interconnect")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > ---
> >   net/bridge/br_mrp_netlink.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bridge/br_mrp_netlink.c b/net/bridge/br_mrp_netlink.c
> > index ce6f63c77cc0..86f0e75d6e34 100644
> > --- a/net/bridge/br_mrp_netlink.c
> > +++ b/net/bridge/br_mrp_netlink.c
> > @@ -196,7 +196,7 @@ static const struct nla_policy
> >   br_mrp_start_test_policy[IFLA_BRIDGE_MRP_START_TEST_MAX + 1] =3D {
> >       [IFLA_BRIDGE_MRP_START_TEST_UNSPEC]     =3D { .type =3D NLA_REJEC=
T },
> >       [IFLA_BRIDGE_MRP_START_TEST_RING_ID]    =3D { .type =3D NLA_U32 }=
,
> > -     [IFLA_BRIDGE_MRP_START_TEST_INTERVAL]   =3D { .type =3D NLA_U32 }=
,
> > +     [IFLA_BRIDGE_MRP_START_TEST_INTERVAL]   =3D NLA_POLICY_MIN(NLA_U3=
2, 1),
> >       [IFLA_BRIDGE_MRP_START_TEST_MAX_MISS]   =3D { .type =3D NLA_U32 }=
,
> >       [IFLA_BRIDGE_MRP_START_TEST_PERIOD]     =3D { .type =3D NLA_U32 }=
,
> >       [IFLA_BRIDGE_MRP_START_TEST_MONITOR]    =3D { .type =3D NLA_U32 }=
,
> > @@ -316,7 +316,7 @@ static const struct nla_policy
> >   br_mrp_start_in_test_policy[IFLA_BRIDGE_MRP_START_IN_TEST_MAX + 1] =
=3D {
> >       [IFLA_BRIDGE_MRP_START_IN_TEST_UNSPEC]  =3D { .type =3D NLA_REJEC=
T },
> >       [IFLA_BRIDGE_MRP_START_IN_TEST_IN_ID]   =3D { .type =3D NLA_U32 }=
,
> > -     [IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]        =3D { .type =3D N=
LA_U32 },
> > +     [IFLA_BRIDGE_MRP_START_IN_TEST_INTERVAL]        =3D NLA_POLICY_MI=
N(NLA_U32, 1),
> >       [IFLA_BRIDGE_MRP_START_IN_TEST_MAX_MISS]        =3D { .type =3D N=
LA_U32 },
> >       [IFLA_BRIDGE_MRP_START_IN_TEST_PERIOD]  =3D { .type =3D NLA_U32 }=
,
> >   };
>
> Alright, let's limit them :-)
>
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
>

