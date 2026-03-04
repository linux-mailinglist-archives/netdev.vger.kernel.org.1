Return-Path: <netdev+bounces-264059-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNNmASavqGmfwQAAu9opvQ
	(envelope-from <netdev+bounces-264059-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:16:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B6E208659
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 23:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABC1531B3876
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 22:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6C036308C;
	Wed,  4 Mar 2026 22:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4ciRs+xv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF6619ADB0
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772661746; cv=pass; b=MhhB5qAj3tU49H/rgI76I3drsRMRjh9t2KquKZ2znczJ5VAhF8+WR8/vzhNxzxFHEt/HG8iAtR9h3rSQ/MeQtv2/rtJfDfKxKrrTQtnNgw1+y5HoVtwS6VnWjqQ0/IGrO2YSNQX9PEWEsVJk+/4hJ8ZLKNIyhQQRVjXCfIPmAYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772661746; c=relaxed/simple;
	bh=GKtKzU+gSLFKI6TI/YQYzFGwXHHe2vKWDWleOohW8nA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JinMPflj+8cM4oWhJsmVe1X8O4D0uewaeA1eOgwFtYdP/86K2kQLq40LIaP7OGo/DMFYeClbZBdU7r65symmH1HhvQZ9wxPxdcKIwajDUcM4ZxPg8fR4H9FGvm7zV+aAWkppLDfkYgUfP5PRO06i7O4Zd9Zvyh5F+as2aBU5OzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4ciRs+xv; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1279eced0b9so5309077c88.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 14:02:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772661744; cv=none;
        d=google.com; s=arc-20240605;
        b=Fro0ypTtT1h/ltPP1OxEg5Lm5B1WMNul89jpvyCA80skbIbynshL+vFOxnYrOQvoN9
         YSIGlB1gSNKEpC1h3Kyus6cBdHV9X17qV6gD1YyMQFN8+m8MaANQ8u/lmt00IvLR/MFV
         3q+GtKzZ9wfAftrZ3p7gFznpwBtuuoLti9Cw+IvCNE6FClyh15gkYkn2Le5hGuqJDnq5
         sePrNejULzCbiOrsJ4PkUAgsDwd/z+IVA7YiopwhA0cEzaVY0WK7uT3gag/0d9FaB51g
         ebB4hEeeI7gp1mDqvOKMAdxiK1MNl/Kx7j9FxoCCrTjih+f9yqXeohTT14KlcUY3EJzY
         QVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=T43OaRbZAMaNuDZ7i82ERdBEsRyibhnbtRpTGu7oYww=;
        fh=3ejsy3F/a2dYA6ffvIyEviV/ZNYGeBT3FlyshuJOLvU=;
        b=jeGyWsG7U4Q66m5v2PpJVaMqu807mQXUvken6rNOu/lj7VqHhwI4V1iav8JFNrSVC4
         BDtHUqADu7Hz9mYDBTycZzs0P+DvScJN+YWirkkCfoyzwJE+b6rdM10ZJj33FGdyUOq0
         ybfGCzKOxxSKULMA5FsSg6IBuzJmkqMlCEJYTLVYP/7/Qjd4icknl4kaDznp+vAXJJHb
         0speKbioR+Y6CO/HCvNq1vTJnztnu3fFML6/md547zjgpoxxbtXUhrYaNUDhIcZJ3ghu
         4lZ9UjSaeKicA/5lnFTr5cBrq973ZeNa6eDP6JdkxRRZsRao4oSiIfGojdAVVefVX+EO
         5PBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772661744; x=1773266544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T43OaRbZAMaNuDZ7i82ERdBEsRyibhnbtRpTGu7oYww=;
        b=4ciRs+xvwlmSY4EzDliONmEEcPCNtE4ULt2z6Nm9EZiCsCqFsPxs/EUtffJQxrJWaF
         KBvktvfqhcZfaRDZWSOLIUFWkHXcElsnL46UAzEMMpdjWUZztEcN40VZtStc/+fCT/9Z
         xD7UUrWygRd486rmGQHlEvLFbfK8oGgzbS/5R3Vhi1F4qq5nNX+JTuEvXBhDDmMXp3rZ
         qVnBzTlviHMEHs0hd1h/mXwK/Mu6f3VtVj4T/UrX4I8n7k9EarDH+bm7QLkqSdbiLnob
         M8MDTuRo+BBv3sRLPDlk/+0UNH458ByQpEL28vzm4kPtiXNlZrHgQFvKhTsrqHI5lWly
         7Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772661744; x=1773266544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T43OaRbZAMaNuDZ7i82ERdBEsRyibhnbtRpTGu7oYww=;
        b=JEWHjsF0LK0w4vs697YiCai23Jvjt9BVmiu2AUlW+fNaA8JAWfZ+QOlfjT3qNyK/IY
         fACgrYIereedZenoTEcHOZQd3Ygy6HiofDZLTZAJ45hO650Pbky4RTjwbInmprA/gbp7
         8meQqQFXtCAkUZcay4Sw5gWdN5qEDv4P/ixYUFsTjrnVb+iF5hY1nEfDMfgZIp9pmQ4t
         IFzlCMRPOMof7Dzt+/E5xXrwn2EEnaoq90yWDiKSXvfEkMU+Dmexv79ilfJkn2a8HE+4
         DYQ2T3Zw0mxEhguqN170RIM4cqWAWiaiE48Oe87/ohTBQnkl22XCexB2AEWNwRh+4HXu
         vjng==
X-Forwarded-Encrypted: i=1; AJvYcCX+RA7TEBtMxyUSkBXlYjp6W/2TCZOaKi+hNW6Ia8UH1zUpKI53bIlYrRgyGlxoo70HRu/+qek=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfQf21+0rxXTkHMPRc3pXFkiL47OLPgkQ6y8mg+P6ICDJqhL6Z
	hgu32WDB/iOG0WtYuQe8mUVRYWckr+mtT5m8FRjxme1jUEHcBMbcG03Pof1y2EujFjRP9O7plSF
	S/aYldiptkE+9Kef87Qii3hmtrJoND7APconuFz3B
X-Gm-Gg: ATEYQzyzdwqlEBSrg2zq4D+lmihhbiUkaJu7gZ5Ob5eaNLolQW2eVOiC70S8wYpF80E
	yU9BtNtp7VibU+wXRIJQwFu2qjBuu3dSUtGSMdDnGfQ6d0SWCXJie020izADyxlldbAmGYgIIVc
	xcu6ArsQeDSqrV4vrSjTO2BGbqmTY4XrGAVpPGztxL9ceciQnGo28r8agbh8KtX7+QDjsFVJCC9
	Ee/jiJv1JJjo/BzwmW7O2NQEwIAu4CpLhPxIwpGwq1QJ1A3GeBSkMZSYUfH2zTwsNxK7ephJhlZ
	Urd93vbEko6+9rPVzP4zRZMkSt+eDjwtACr7VrhIok0ye3iFMMuIlsqV/V9q/KnDUxtmn6WbzpO
	kOn0EEQ==
X-Received: by 2002:a05:7022:30b:b0:11b:95fe:beed with SMTP id
 a92af1059eb24-128b70eee6fmr1287000c88.38.1772661743502; Wed, 04 Mar 2026
 14:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227203457.558196-1-srutherford@google.com>
 <20260227203457.558196-2-srutherford@google.com> <6a7fbafa-cdcd-4bfa-ac00-204e68602f61@intel.com>
 <CABayD+eF30_OHRrGYiG-7qKbJjvs5=7U8H7SH9Hj=ou6aZJBbw@mail.gmail.com> <8b43d234-867a-481f-90e6-e155132100a5@intel.com>
In-Reply-To: <8b43d234-867a-481f-90e6-e155132100a5@intel.com>
From: Steve Rutherford <srutherford@google.com>
Date: Wed, 4 Mar 2026 14:01:46 -0800
X-Gm-Features: AaiRm5209V4jV3rXmD6xWWAGiIX6cN0RFkTqUyFBDhSb2clg8lilS8Uk4XneA5k
Message-ID: <CABayD+crjO3S2cC3=9HqSH+kngE1=yKp_MnKZmAdW-YwJH1idA@mail.gmail.com>
Subject: Re: [RFC PATCHv2 1/1] idpf: Fix header clobber in IDPF with SWIOTLB enabled
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Anjali Singhai <anjali.singhai@intel.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Li Li <boolli@google.com>, emil.s.tantilov@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 53B6E208659
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264059-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srutherford@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

I believe syncing twice isn't inherently wrong - it's more that you
can't synthesize the header via the workaround and then sync, since it
will pull the uninitialized header buffer from the SWIOTLB. Outside of
SWIOTLB, dma syncs are more or less no-ops, while (with SWIOTLB) they
are copies from/to the bounce buffers.

On Wed, Mar 4, 2026 at 7:13=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Steve Rutherford <srutherford@google.com>
> Date: Tue, 3 Mar 2026 11:44:19 -0800
>
> > On Tue, Mar 3, 2026 at 7:34=E2=80=AFAM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Steve Rutherford <srutherford@google.com>
> >> Date: Fri, 27 Feb 2026 20:34:57 +0000
> >>
> >>> When SWIOTLB and header split are enabled, IDPF sees empty packets in=
 the
> >>> rx queue.
> >>>
> >>> This is caused by libeth_rx_sync_for_cpu clobbering the synthesized h=
eader
> >>> in the workaround (i.e. overflow) path. After the header is synthesiz=
ed by
> >>> idpf_rx_hsplit_wa, the sync call pulls from the empty SWIOTLB buffer,
> >>> effectively zeroing out the buffer.
> >>>
> >>> This skips the extra sync in the workaround path in most cases. The o=
ne
> >>> exception is that it calls sync to trigger a recycle the header buffe=
r when
> >>> it fails to find a header in the payload.
> >>>
> >>> Fixes: 90912f9f4f2d1 ("idpf: convert header split mode to libeth + na=
pi_build_skb()")
> >>> Signed-off-by: Steve Rutherford <srutherford@google.com>
> >>> ---
> >>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 9 +++++++--
> >>>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/ne=
t/ethernet/intel/idpf/idpf_txrx.c
> >>> index 3ddf7b1e85ef..946203a6bd86 100644
> >>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> >>> @@ -3007,9 +3007,14 @@ static int idpf_rx_splitq_clean(struct idpf_rx=
_queue *rxq, int budget)
> >>>                       u64_stats_update_begin(&rxq->stats_sync);
> >>>                       u64_stats_inc(&rxq->q_stats.hsplit_buf_ovf);
> >>>                       u64_stats_update_end(&rxq->stats_sync);
> >>> -             }
> >>>
> >>> -             if (libeth_rx_sync_for_cpu(hdr, hdr_len)) {
> >>> +                     /* Recycle the hdr buffer if unused.*/
> >>> +                     if (!hdr_len)
> >>> +                             libeth_rx_sync_for_cpu(hdr, 0);
> >>> +             } else if (!libeth_rx_sync_for_cpu(hdr, hdr_len))
> >>> +                     hdr_len =3D 0;
> >>> +
> >>> +             if (hdr_len) {
> >>
> >> This is for a very old tree I believe? We now have
> >> libeth_xdp_process_buff() there for quite some time already.
> >
> > It is, yeah. I thought I posted a cover letter with more of a descripti=
on, but,
> > frankly, I may have messed up the process of posting.
> >
> > From the cover letter -
> > Found an issue with the IDPF driver when SWIOTLB is enabled. The issue
> > results in empty headers for packets that hit the split queue workaroun=
d
> > path. It's caused by a spurious sync in that path. The header is synced
> > from the SWIOTLB even when the header was shoved into the payload.
> >
> > I cooked up a sample patch, but I'm not an expert in this driver, so I =
have
> > no idea if it's the right solution. It did allow my QEMU VM to boot wit=
h a
> > superficially functional passed-through IDPF NIC and SWIOTLB=3Dforce.
> >
> > The patch was written against COS's 6.12, so I assume that it will not
> > apply cleanly elsewhere, but I figured a wrong sample patch was better =
than
> > a long paragraph describing the same thing. My read of more recent kern=
els
> > is that this problem is still present, but could be mistaken.
>
> Ooops, sorry, I haven't read the cover letter =3D\
>
> Did I get it correctly that in case of SWIOTLB, we can't sync the same
> buffer two times? But if the hsplit W/A was applied, then this double
> sync corrupts the data?
>
> I'll prepare a patch for the latest net (with you as Co-developed-by or
> any other tag you prefer) once I find a way how to play this nicely with
> libeth_xdp_process_buff(). It performs an unconditional sync and bails
> out if it returned false.
>
> >
> > Thanks,
> > Steve
>
> Thanks,
> Olek

