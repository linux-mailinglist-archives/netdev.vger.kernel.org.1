Return-Path: <netdev+bounces-276925-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL7IDnN712mXOggAu9opvQ
	(envelope-from <netdev+bounces-276925-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:12:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D68A3C9034
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 12:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C68A3001814
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 10:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907B939527A;
	Thu,  9 Apr 2026 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoglJCqG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D4C4A35
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775729520; cv=none; b=pGeLs7XIj+VPLPxxEBm6qsg7f2g60/0rJk0xOVr1rm4s0ewZxYtwki2yQjHCbD4PNwfusITyAjLnrdk1YontY49O6kdoJrILgi/Y3dFpM8oXJh1yLknrKtQOK+ZlRmse/c0pP1ZjdctY9EoR7A1QDTLC7tnJ6aqS5KFuFvw9QhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775729520; c=relaxed/simple;
	bh=QUDkch0toSoATG6Ag9O36eqszo1W1Tm2RxQ3+yJOkIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UaGoF+FJ86eM4bb+6izsmTHUCNlhG6xMCspDB+2/xb+2tlPSk8LjSd1QuoIE6HmcBq57ALoLx7cmbDPPRy/cXDPWTqpCdN/gV+KLw/SmM4MkWrWd3KlGDof9BLOEunmAWJOPKtFBeNDw2zYXWceuHHu2qJB2P1GUVYEEUe3m66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoglJCqG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82a893d289bso379053b3a.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 03:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775729519; x=1776334319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ze6uJ71rMugLTsbbiL/lEDVgsRa2xx9AjXO0GTiYltw=;
        b=MoglJCqGZ2EEJ85xYbhYfBMjOiipOxGavOiTOeWfL2dlW6DfqCkpOetUj974FWtKSe
         zV9uRI9BMyFRouUF3GjK/QI0EdW1bkmWlxnl6MaWWoAQb9jk507u+FsJzW0mvGnZE9Lr
         SupeILf10oYn43SKEQ/NFbuyDqcHSIUAIX1z//wSBW0eTmOxrzeH9Id/obMcZClfTCHg
         qihyTHXrFqf6a6Jc9jl9MDyKAiVjoa5ovkYKpfnZBR2ns9jHrcGFVC242luYz22ZtIZM
         mUEj5k5KJ6kdoTKYnq7xtbX70GWeLMU3bWyW/kf0PT470u735hJJpZX6nlSR61HaejQ1
         Y7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775729519; x=1776334319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ze6uJ71rMugLTsbbiL/lEDVgsRa2xx9AjXO0GTiYltw=;
        b=cfn85DPEBo0ExvUIzVuY4nK34OowuaWzMkjws77BTMmq5fuFl5Jt+Y4bzZVnM+NvJK
         7kxw15VlTpj5UNNjcBiOIpowzE4an7p1pGN2yO/vqJbyg2K5/5ZVHj9zCJHGXkgnnANU
         6ZeyVFVbTr8Dxg2Qdonk9GKHEtLfCzq5y6sM+vtWfarlpatMcerot+7Zlpgrj8x1S+u4
         aw7+MJuZ8ZP7VPS36CCJDt62UCrcVO9tH739VX9UW4iAVBlS/o0qhy3T4yumi4DT/f07
         mG+Wr+kgmsTDfKdROo+0AIoGhQ3J1EfvxDnSfXAIV22kU6lQ0YmY3ww4/SHCJfwR299V
         0NCw==
X-Forwarded-Encrypted: i=1; AJvYcCXwkY5pwETNf2vRYFCFJ4D2yVwtsTV05JpRKpttJoW9pmKJ3N6TGcKg5Jmgc+1BX03oe9jVGk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YybWJks2NjQyKsIHsdaZ98shThYw+WkmdbvGTejFL88vFmDqzd9
	dZl4BqB+WLbMDOaIVfCjKLXtpNyH8lWpKfiArOQpc66K0eaWHt5A5q04BLg8babs5SKvgA==
X-Gm-Gg: AeBDieun6Mqb8Yb2LB+D85fkQ4VARykuM8cs4jaTNc69fcWPah1Y2UPIJ4arlLq/5S/
	hA3kgmLDFUzAoMZvu0x4zZkwza0BF+M6Pp64F2kq/4oS41p+T1XSPv7jfusQLjUIaHpakWaqPu6
	ybCS/ho1V/+F+kM0VsY7JqzJ1utu9suxEBQMhtEHK0MVodC9TQJR4GeGwtxYQaE8oOHx/2VMm7n
	VUYlnRJb9D1fmqZPYOpTshx6NDBjxtArbaBhHo1rsE0wxWX72q2rN1JiR9DQAtIq+VZ/rbShe4Y
	eBK5p6L9lx+2NnXwUG0ZHnZiKJa7VvEY6yKw2+neLVHRpPlecad6kqxZ9LutI0C3auwAALNe08R
	4Sd8FBjs7nYX1V0bpvZSzDZZl0pSF3p/4LbOw4XR9UI657mNM9bgoAk4HqCUnEql7CyGzZitEqI
	PNGTaOW1oQ/2HLa9lAEvG2rYsP8rDeoviIafFYfKatWSS/mR52E8UIP+i4MTq4
X-Received: by 2002:a05:6a00:2e85:b0:81c:446d:6bd0 with SMTP id d2e1a72fcca58-82d0da9f9c9mr23580213b3a.23.1775729518705;
        Thu, 09 Apr 2026 03:11:58 -0700 (PDT)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c4126bsm23194864b3a.36.2026.04.09.03.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 03:11:58 -0700 (PDT)
Date: Thu, 9 Apr 2026 18:11:53 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH nf] netfilter: nft_fwd_netdev: use recursion counter in
 neigh egress path
Message-ID: <add7abl1x_NJkcC-@SLSGDTSWING002>
References: <20260409053629.698822-2-bestswngs@gmail.com>
 <add2ajF5YGqd4MxZ@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <add2ajF5YGqd4MxZ@strlen.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276925-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D68A3C9034
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 26-04-09 11:50, Florian Westphal wrote:
> Weiming Shi <bestswngs@gmail.com> wrote:
> > Fixes: f87b9464d152 ("netfilter: nft_fwd_netdev: Support egress hook")
> > Reported-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >  include/net/netfilter/nf_dup_netdev.h |  4 ++++
> >  net/netfilter/nf_dup_netdev.c         | 18 ++++++++++++++++++
> >  net/netfilter/nft_fwd_netdev.c        |  7 +++++++
> >  3 files changed, 29 insertions(+)
> > 
> > diff --git a/include/net/netfilter/nf_dup_netdev.h b/include/net/netfilter/nf_dup_netdev.h
> > index b175d271aec9..17362f76d1d1 100644
> > --- a/include/net/netfilter/nf_dup_netdev.h
> > +++ b/include/net/netfilter/nf_dup_netdev.h
> > @@ -7,6 +7,10 @@
> >  void nf_dup_netdev_egress(const struct nft_pktinfo *pkt, int oif);
> >  void nf_fwd_netdev_egress(const struct nft_pktinfo *pkt, int oif);
> >  
> > +bool nf_dup_netdev_has_recursed(void);
> > +void nf_dup_netdev_recursion_inc(void);
> > +void nf_dup_netdev_recursion_dec(void);
> > +
> >  struct nft_offload_ctx;
> >  struct nft_flow_rule;
> >  
> > diff --git a/net/netfilter/nf_dup_netdev.c b/net/netfilter/nf_dup_netdev.c
> > index fab8b9011098..e2fe8bb6fe0d 100644
> > --- a/net/netfilter/nf_dup_netdev.c
> > +++ b/net/netfilter/nf_dup_netdev.c
> > @@ -29,6 +29,24 @@ static u8 *nf_get_nf_dup_skb_recursion(void)
> >  
> >  #endif
> >  
> > +bool nf_dup_netdev_has_recursed(void)
> > +{
> > +	return *nf_get_nf_dup_skb_recursion() > NF_RECURSION_LIMIT;
> > +}
> > +EXPORT_SYMBOL_GPL(nf_dup_netdev_has_recursed);
> 
> I think thats a bit too heavy-handed.
> nf_get_nf_dup_skb_recursion() fetches from pcpu counter or current->.
> 
> Can you move nf_get_nf_dup_skb_recursion to a shared header file
> and make it inline instead of having a function call?
> 

Thanks for the review. I will send the patch for version v2 as you suggested.

Weiming Shi

