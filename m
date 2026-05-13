Return-Path: <netdev+bounces-287670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIVeJ7ycBGr3LwIAu9opvQ
	(envelope-from <netdev+bounces-287670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:46:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DD1536685
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3EF630004EB
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CC13FF88A;
	Wed, 13 May 2026 15:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu82oi3F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A473E558E
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686678; cv=none; b=f8gc8UqUbD5dbBzrosUKErU9vSOxahn2dS1PVaFjojE68DL+UU68DgQEXQ0yLBJ+TG/jrpIqXCYt978E5u4iArO4Tits9knqzZLPFFXoTtqRfBhyxNrHdpA8/avjbkqcxbNjas2ecnIcqjethr/XsrJixNtgzt8q9dq0oq0zq/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686678; c=relaxed/simple;
	bh=8GGIgCX+zAQPtwUyy9GgPJRYW2fewUZJH8NYGs7OIC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfaAdNt3G06+6upz2WYUsn4JlvAu37Xh48ZfKFiKvZdBe4GxMTMw0+27AinaEq0OWUu1vMNkSdjHtVGObBQ29CADP66g0wmWxUsUkLjnR/yjo/3HPyzcjg17kP69a21k5L7yEShIgl38jDv4IUOEh1oaXxlCSr8cONAgBAbujRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu82oi3F; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2b7d3ecc10dso67663825ad.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778686676; x=1779291476; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zEBKF7C4xRw4g2kc1/IUvgMJHt3gkAWQ6iC67xzyWuY=;
        b=Uu82oi3F8dyDLU9jFZM/iJgd6rFuEkOLGeJiSNGDURxLoNstEvQRNl/s3g5wwKKJzd
         0Cu5yol+cZd72kAsV32NvnybvsxfGIg/HZGqfkukTB1JC0WM1QSlo/7SsoYAaQqIOqbs
         PfuWwURcO3GhU/cG18XiDZcBppPwzzf/VKpYRUPtbB7i6BM7JN2IMfbBch/A+w2EWA+X
         S5fOH+ZHA4+c7pzDE1yxatHTvSAJ9y62btFaUYS9AgV6S/SPI6hOK20YQncLDaVPkgbN
         ubfFCI/paYaDVnX7fcDE+G7h9ePvPW4ngW7HL/Q46OhhWwff57CfLQohcCN0MS42rCdK
         6FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686676; x=1779291476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEBKF7C4xRw4g2kc1/IUvgMJHt3gkAWQ6iC67xzyWuY=;
        b=LPM9tPnxTv1FFF7+BzmBty23EuxnOTeYy7XoDnu8EoGcZNwYGQb2DrfqEb4nK+d/s8
         yLirCMX6lNBEH5p0AlrAqL4HPrQgkoKWpS3tfZm1vT9Khic2Zvzj6RchO7B9MCKSrVdT
         bqOQXiqwfEtZUmvtUgE8YjqS4hDVHKns1Umr/LAFxfu0lt1nTXc9dhD8bXEQ0DWLxF1w
         buYuRM6DGnuDNZ7Q+SvQ95R/UgNueBnRRLu7d5BIiK6yYvHId/nLHZILQBhUVwFuAz9P
         oPGC1DoYg1wlCOyirO+gmdASTAzwwytX8YhYhPU/pO67uoMMEgSnKHkNGr1Uu2t6lp87
         Ff+A==
X-Forwarded-Encrypted: i=1; AFNElJ8BLb9teeYcfihiN0pzJ7ynbg4wIH19XCxeDmsbp5E8K4tN6HEmN66Vofm6ZsLM6GmeAORn3hE=@vger.kernel.org
X-Gm-Message-State: AOJu0YySk5gCrZyluRt1irKPd35BBzZZwuRjOAkEi8L0r4xA2/7OVMii
	1CPmO8CBuFSPXNZLAvdg6eHG87TsYCAHBj36F4KXKafZql1DABPZJsFx
X-Gm-Gg: Acq92OEwgT1zfEBCEILQ0ie9QdZmqENBZUGN5OlIy9IfoIns7dn/YwpQV1d5mQf8LUp
	fHbbAFBR+LOg3jpZJk03Ga+jIojArYaQDqNo8OQN4c/AjKb2mR4bd3VPEH5IVIkXTgGv9y5+yPM
	ARprdSHGWVH0Og3A3DFamco4jRpIPFr+USuczdqGvc1a4qictCebw4qK5/0BFrpjaYXAxFEl8kI
	XNm40MqYWmgyy987KOoILBaBhsnb1WfwXng9AUeuEjVtfLHyHwJOmBhkTDwQXuozWTZwlQxewXl
	c9Stb4eKMNBPTwDsQxxXmjAl9GQMvC2a4iKiLyyMD7PIVTesOFN5WUoUTBNZYAXwzuUpmapZ/0T
	9tGkfB5M8Ywr0tk9fq68VQ74YsQ/zTubOURbttF6QgyGhAZLaOXe5qImh8/B46tMvXKw2S9zra9
	rwdxJQSKHsCkciXVL70Rrtwaznki8=
X-Received: by 2002:a17:903:3c70:b0:2b7:88f9:9c3d with SMTP id d9443c01a7336-2bd273aaae9mr40364395ad.12.1778686676561;
        Wed, 13 May 2026 08:37:56 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e365a1sm165648865ad.44.2026.05.13.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 08:37:56 -0700 (PDT)
Date: Wed, 13 May 2026 08:37:55 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: cache csum_start/csum_offset to fix TOCTOU
 in xsk_skb_metadata()
Message-ID: <agSaZtBh-v6isF_8@devvm7509.cco0.facebook.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
 <20260510012310.88570-2-kerneljasonxing@gmail.com>
 <agHurBlnAgjVNq-u@devvm7509.cco0.facebook.com>
 <CAL+tcoDrjJ8iHzSGz_Orf7iH-1WJ2H_LZd6BMKTnDS3MVN8daA@mail.gmail.com>
 <agOozH29XU6KQUTy@devvm7509.cco0.facebook.com>
 <CAL+tcoDqtEAqX65-8crUkUko5T_0nq=LSxAbMg+5jCAHa_uC=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDqtEAqX65-8crUkUko5T_0nq=LSxAbMg+5jCAHa_uC=A@mail.gmail.com>
X-Rspamd-Queue-Id: 47DD1536685
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287670-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,devvm7509.cco0.facebook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 05/13, Jason Xing wrote:
> On Wed, May 13, 2026 at 6:34 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 05/12, Jason Xing wrote:
> > > On Mon, May 11, 2026 at 11:03 PM Stanislav Fomichev
> > > <sdf.kernel@gmail.com> wrote:
> > > >
> > > > On 05/10, Jason Xing wrote:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > The TX metadata area resides in the UMEM buffer which is memory-mapped
> > > > > and concurrently writable by userspace. In xsk_skb_metadata(),
> > > > > csum_start and csum_offset are read from shared memory for bounds
> > > > > validation, then read again for skb assignment. A malicious userspace
> > > > > application can race to overwrite these values between the two reads,
> > > > > bypassing the bounds check and causing out-of-bounds memory access
> > > > > during checksum computation in the transmit path.
> > > > >
> > > > > Fix this by reading csum_start and csum_offset into local variables
> > > > > once, then using the local copies for both validation and assignment.
> > > > >
> > > > > Note that other metadata fields (flags, launch_time) and the cached
> > > > > csum fields may be mutually inconsistent due to concurrent userspace
> > > > > writes, but this is benign: the only security-critical invariant is
> > > > > that each field's validated value is the same one used, which local
> > > > > caching guarantees.
> > > > >
> > > > > Closes: https://lore.kernel.org/all/20260503200927.73EA1C2BCB4@smtp.kernel.org/
> > > > > Fixes: 48eb03dd2630 ("xsk: Add TX timestamp and TX checksum offload support")
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > ---
> > > > >  net/xdp/xsk.c | 11 +++++++----
> > > > >  1 file changed, 7 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > > > > index 6bcd77068e52..cd039e397018 100644
> > > > > --- a/net/xdp/xsk.c
> > > > > +++ b/net/xdp/xsk.c
> > > > > @@ -722,6 +722,7 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > > > >                           u32 hr)
> > > > >  {
> > > > >       struct xsk_tx_metadata *meta = NULL;
> > > > > +     u16 csum_start, csum_offset;
> > > > >
> > > > >       if (unlikely(pool->tx_metadata_len == 0))
> > > > >               return -EINVAL;
> > > > > @@ -731,13 +732,15 @@ static int xsk_skb_metadata(struct sk_buff *skb, void *buffer,
> > > > >               return -EINVAL;
> > > > >
> > > > >       if (meta->flags & XDP_TXMD_FLAGS_CHECKSUM) {
> > > > > -             if (unlikely(meta->request.csum_start +
> > > > > -                          meta->request.csum_offset +
> > > > > +             csum_start = meta->request.csum_start;
> > > > > +             csum_offset = meta->request.csum_offset;
> > > >
> > > > Wondering if it's better to READ_ONCE(x) these?
> > >
> > > I still chose not to use it after reading the suggestion from local
> > > AI. The reason is there is no WRITE_ONCE pair to make sure everything
> > > is no data-race. I also checked some existing implementations around
> > > the shared buffer (between userspace and kernel) and didn't manage to
> > > see the usage of XXXX_ONCE(). Does it make any sense to you :) ?
> >
> > Without READ_ONCE your patch relies on the compiler honoring exactly the
> > loads and stores as written. Which I don't think it does (hence that
> > whole WRITE_ONCE/READ_ONCE mess). IOW, it can pretty much generate
> > the same code (and read csum_start twice) even with your patch applied. Happy
> > to argue with your local AI if you give me the output :-D
> >
> > I grepped io_uring/ and I see similar pattern for reading user supplied
> > entries (via READ_ONCE).
> 
> I roughly understand what your meaning is here. My thought is the
> data-race condition in this case still happens even with the
> READ_ONCE() protection (because no such corresponding operation is
> performed on the writer side).
> 
> Actually the local AI said use READ_ONCE instead.
> 
> I can change this as you suggested for sure. Maybe related fields can
> be protected in the same way in another patch.

In general, feels like we should be doing READ_ONCE on all user-supplied
descriptors (to make it more apparent that those can be concurrently changed
by the userspace). In practice, probably too late and too much churn to update
everything at this point, so let's only fix the ones that can lead to
TOCTOU.

