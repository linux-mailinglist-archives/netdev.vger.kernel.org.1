Return-Path: <netdev+bounces-294743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 73RHGRsjIGoMwwAAu9opvQ
	(envelope-from <netdev+bounces-294743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:50:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C85EA637B22
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 14:50:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=FsFVGDOC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294743-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294743-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B32AA308B825
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FA948032D;
	Wed,  3 Jun 2026 12:47:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D63477E36
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 12:47:32 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780490856; cv=pass; b=XJx8ZjqJlqGKBQAcgApSm5kIgc9WzSO5mahmlpfdks48eU3RcStwI3GUcC/vm7564cT9HdmMaAbmp5nckOPnCEVbtCGgTHckvz8e4VCIxgUS5GukbINhYqQceX4zZ5yVCzJ3Q8T4BM2iUIBpLr7e1OAZAQQNtWfUk5Vbk/LriEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780490856; c=relaxed/simple;
	bh=j6hyrr/4iuKxM/ancTgM38DJrPpBPdgI5NcZlOfmBes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uB4n+ooK0fKGno9fRxXw/U4JF8BoBBo44Kwc2FOh4TYxf4RW0LQ6+8UNH0wGtSl7ISjaypVnQFfGD84QRT+ma3Y+YYtUbR7HNQ8faSe+iKLlpt7tJGMUBVTrcC2GA7EYhSs9/8uKtGkEs8Iolsb9fDwwRPrdvGNiTRtp/rvlEf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsFVGDOC; arc=pass smtp.client-ip=209.85.167.178
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-486503ae8f0so1273235b6e.0
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 05:47:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780490852; cv=none;
        d=google.com; s=arc-20240605;
        b=OcVs8cD9/LrBjo3ExxXfoZJHjEJNcZPPbT5gENrLpX+q3TFIowAmgELTkXVfMELbAh
         oHKQqWr5ItLiB9AStTY7eZsT6dVipdkZf2g0+nZMM4JYd4brdCjkky6kh3OHxcaWyxP0
         y7pEFyOMP1S1ku1u1izSz+TaBipyU1EE6m0YYFMnoNNOy0ofMsi0cCAWmwkOrxgx6ihp
         i4C8ixgjDXvzAGs+wOUyU540dgUVvZZmVK0h6Wtps5zo/vda3AtS+c5S86UeDj3A0oD/
         9KRNchQYQu8EWD882JqEMfj2ch2Lt2s+LQa1SfITUq2lfq9nA0cSKmdSoZfjMfoHrYMk
         9mZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cTKxPFaiIfBZM9Dhlxbl3UmYj1K5qBmNKEq6wC31pb8=;
        fh=SArXSSzqvExU/1HtjsX6ieWxWuQF0khPjBL9vEpv0ZU=;
        b=bRHMn+JPmL9qT0WlyeZ3+BDAubLxp95BDE5mEEyG37QLnFAJVu+4e4eI9UIBJWeo+I
         kwPLtshwJXLJcOyGmpNmvfqKqgMPFWGBoLfsCscAbDDa8B35/s8froKx73OHpsvIaGZ6
         jGjlOhONF4isuzCZAoW/qVDLautXd21JqX/BA7t/QEtwKdJ6Bl8JiraVQ78NEHX+iQFf
         qJbIJ/XtFSyxs1UXL49EGb+crEEjmwsHd6TXdfBAsTWFoR1AbkP5UykxGSYMQ58RWtwv
         TuPPOlN2Zg41HmpcY8pATrMRC85RQAgG7/z7vzGdASw46eROPM0g0rMfspyI0ENFQmP2
         sVJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780490852; x=1781095652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTKxPFaiIfBZM9Dhlxbl3UmYj1K5qBmNKEq6wC31pb8=;
        b=FsFVGDOCxzZthTaPX1YR1LMYflzsey1ebHXegbn6t++lReAU/AtHOszzBpj472hgkp
         ks6kPveu0tveKcye05Bw2H+jvDX1mpXDgf9Y9/IVmSO8p6E3oQmqkg8eidewNi/eu+ac
         D73h1osSNuPRRWuiZOMFjErqds0twxYmiyZLNCUCqxkcSmMqb8QL8nsd0Bo8a/U+XRDS
         LfkRhJ9iu8XiAG/+58CiCxT3e75i0isLkNiZUHU/ozNfPnWVbpeXE1ks/V/os9oMWiBH
         9jsakIPDTduIszhiNzgjzlGsG1QbVEJlB3SO6mUCRmaSWhYVEdwxMrtUU28yMzX7TuUk
         OfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780490852; x=1781095652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cTKxPFaiIfBZM9Dhlxbl3UmYj1K5qBmNKEq6wC31pb8=;
        b=igoR4obATlohqVhRu5EoHPz1fDV9xtZpZ8gVpYZRnmWhIwXC9aVP8gBlQNrqR9fy6+
         L9gf2YkuV52Z0EWSmbn0cfQvB3CPc0quhQsjwR7DecTY9L5r9zFi8AA2hVaDSszePSo0
         IJFGvSDV6N2mXiYrC8sZjdqamPmxen0GnWDx0N/S3YOe2cqXaqRAXLLCaszOPZB2+fDg
         srk8f3lkl+nCA28bCyCVmpW5uXU0lWieB4z+i7o5KaTbsUfpWUSSfddAsaomQtNhLDv5
         D2Skto3dAycfeJsUZ4h/OCbJJTFnzCxCXqTAEDhqqV5G0DGAdLOehVF2qB/fRSP75jF/
         vNvA==
X-Gm-Message-State: AOJu0YzizliY386prhnArsMU51duyTF5/kSuPjIxobYJADutjsSHQdXR
	4KYN5g5Aocchp8mS0SpyOSzxlPG2ju2Qz2UsGfPbt2aBpBL1ylzA2jdmT0QQrejL/vZKXo4wML7
	Tpxqn5QJlWsaaUrWlAhY/ADy2QKJKRE0=
X-Gm-Gg: Acq92OGxs+fd/TXAcpS/yhF1LiM9x/wa1EUlOnUSc0UD+9Ov6kAfeBLGz5Fh0Pq6PJ2
	osat/EdQJYi94xq0JB/Ef3libTkmvNQX1MSOxBKbnuwZN0mFqZ1VLscptTPdMqNIbciLACWqCnE
	ZHdyygY9F2kYXSD5UkAdix0B5/nla41+gOljF9OnNM/TnlIMCRm58PD1mmesfPdg4EWoxmemmfk
	demQNOS6h+iFEtePOhR4YZuxZ63o+wUlD8cqqZh9ATtnaL60p6ykbCI5WLiJovMuywA0FEwvHt+
	fktC0EUCZx29HL4zMrZsit/xsjakHpwM4oh5TQoIfrlyU+0hvYhRBcWHdfIrWtI0Q5q69aATcfK
	S5WhvlDbC3sET0t8bdJ2DoscAdzvzn7E=
X-Received: by 2002:a05:6808:2208:b0:467:27d2:96a7 with SMTP id
 5614622812f47-4865aa2eca3mr2064649b6e.15.1780490851686; Wed, 03 Jun 2026
 05:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528092838.2099352-1-hanguidong02@gmail.com> <20260603120603.GD3410996@horms.kernel.org>
In-Reply-To: <20260603120603.GD3410996@horms.kernel.org>
From: Gui-Dong Han <hanguidong02@gmail.com>
Date: Wed, 3 Jun 2026 20:47:21 +0800
X-Gm-Features: AVHnY4LNfI82oeyp86BYfdxUEEGSOWo65Jq0CeWNcDM1IdAsHZr28A0VGvT0SpU
Message-ID: <CALbr=LaoU3hLc_aLH_sYzKKz7kaeBM3JgHdnVmRwq4VxXLiryw@mail.gmail.com>
Subject: Re: [PATCH] sfc: Use acquire/release for irq_soft_enabled
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, ecree.xilinx@gmail.com, 
	linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-294743-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:ecree.xilinx@gmail.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:baijiaju1990@gmail.com,m:ecreexilinx@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hanguidong02@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hanguidong02@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C85EA637B22

On Wed, Jun 3, 2026 at 8:06=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Thu, May 28, 2026 at 05:28:38PM +0800, Gui-Dong Han wrote:
> > irq_soft_enabled is a lockless gate for interrupt handlers. When clear,
> > handlers must only acknowledge interrupts and must not touch channel st=
ate.
> >
> > Channel reallocation disables this gate, swaps and initializes channel
> > pointers, frees old channels, and then enables the gate again. READ_ONC=
E()
> > does not provide an acquire barrier, so an IRQ handler can observe the =
gate
> > as enabled while still seeing stale channel pointers or channel state.
> >
> > Use release stores when updating the gate and acquire loads in interrup=
t
> > handlers before touching channels. Keep the existing smp_wmb() after ga=
te
> > updates, preserving the current ordering with event queue start and sto=
p.
> >
> > Add small helpers to document the ordering and avoid repeating barrier
> > comments at every caller. Without the comments, checkpatch warns about
> > memory barriers without comments.
> >
> > Fixes: d829118705f8 ("sfc: Rework IRQ enable/disable")
> > Fixes: 8127d661e77f ("sfc: Add support for Solarflare SFC9100 family")
> > Fixes: 5a6681e22c14 ("sfc: separate out SFC4000 ("Falcon") support into=
 new sfc-falcon driver")
> > Fixes: 51b35a454efd ("sfc: skeleton EF100 PF driver")
> > Fixes: 6e173d3b4af9 ("sfc: Copy shared files needed for Siena (part 1)"=
)
> > Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> > ---
> >  drivers/net/ethernet/sfc/ef10.c               |  4 ++--
> >  drivers/net/ethernet/sfc/ef100_nic.c          |  2 +-
> >  drivers/net/ethernet/sfc/efx_channels.c       |  4 ++--
> >  drivers/net/ethernet/sfc/falcon/efx.c         |  4 ++--
> >  drivers/net/ethernet/sfc/falcon/falcon.c      |  2 +-
> >  drivers/net/ethernet/sfc/falcon/farch.c       |  4 ++--
> >  drivers/net/ethernet/sfc/falcon/net_driver.h  | 12 ++++++++++++
> >  drivers/net/ethernet/sfc/net_driver.h         | 12 ++++++++++++
> >  drivers/net/ethernet/sfc/siena/efx_channels.c |  4 ++--
> >  drivers/net/ethernet/sfc/siena/farch.c        |  4 ++--
> >  drivers/net/ethernet/sfc/siena/net_driver.h   | 12 ++++++++++++
> >  11 files changed, 50 insertions(+), 14 deletions(-)
>
> I'm not sure if it would be worth breaking this up, say on a per-driver
> basis. My main thinking here is that it might assist in backporting.
>
> But, OTOH, I wonder if this should be targeted at net-next without
> the Fixes tag - can this manifest in an actual bug that effects users?

I found this by code inspection rather than with a dynamic reproducer.
This kind of reordering is realistic on weakly ordered architectures such
as ARM.  So I think it can affect users, even though reproducing and
diagnosing it dynamically would be difficult.

I was not specifically aiming for stable backports.  I also think this
does not clearly meet the stable rules, which say that a patch "must
either fix a real bug that bothers people or just add a device ID".  This
was found by audit and I do not have a user-visible reproducer, so I did
not add Cc: stable.  The Fixes tags are mainly there to document where
the lockless pattern was introduced and to make the patch complete.

If you prefer, I can split this on a per-driver basis to make backporting
easier, or respin it for net-next without the Fixes tags.

>
> FTR, there is an Ai-generated review of this patch available on sashiko.d=
ev.
> However, I believe that all the issues flagged there are pre-existing and
> can be examined in the context of possible follow-up. I do not believe th=
ey
> should block progress of this patch.
>
> Overall, this looks good to me.
>
> Reviewed-by: Simon Horman <horms@kernel.org>

Thanks for the careful review.

