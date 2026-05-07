Return-Path: <netdev+bounces-285489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNq+Jo77/GmxVwAAu9opvQ
	(envelope-from <netdev+bounces-285489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:52:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36DF24EEFB3
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 22:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21FC230166D9
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 20:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D855E32E12E;
	Thu,  7 May 2026 20:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4T3hi0m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8666531B82B
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 20:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778187147; cv=pass; b=IS0bwevA6pKh88NA0hhrjbLbeolVSMYZ3hbaG1bEGYo/Cbn3kNi4tOgMVaM4AeYLLeZOs7UQ9eRcbtKc+tgM2txb/hhsx/kEz0WHtJix9w7jKQDBC6rddKXXKIrr9CcIyR2Og/HLz+F4oKzJ1pzCKrFeA8yZWyCjuoy4DvnRJy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778187147; c=relaxed/simple;
	bh=86OSAQIYk8Fza0WBZAxsFaEjEAENY+zRLdenWp0sSXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oijBtFMZpurM+rOLNYmKrcVDtPZqnaVia6t4ND2AraKJfAcs48E5SGC+GliQBSKdvxvVnhYVcTDQTTF7pWwncLE73sWYz++YNjB18jku8R983l1Qjl9BxpC4rdeUpIGCpjj2hUxnz7sGUjxUUpZYPKlSDOm7pBnDo6fHqDbRVTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4T3hi0m; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bf0b1a47b1so11778757b3.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 13:52:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778187145; cv=none;
        d=google.com; s=arc-20240605;
        b=XZ3lGMgK5JaKc++97PhK3AeKvfKsOZWJozmsjTChMCV9SAfj/vhu2OSaI4CbljqTvL
         0q3cxM+QC9SLsEtv3zbQlRHBfJlfBaW9Ozqi70kYwLfr41tJbXRPCp3P2+R/VRwNCUrC
         otrkgGfL0o7kjK5ft/xnirX84ZYj+alHwfBEuzECboT++apB/aD4l3uHgsvCnYlcDEYD
         mDY0UGZjMEqFVCIxN8u0gc6T3yzkwsp7nmVQli5256wwzqrLZ1CMD9UsJfr6yb1xa0Uk
         wsKq8mkmZuqTYwXji/ShFKZBE83WmCfrJ/puKJhExrN/HQpSNSW+MLO6RDutqbf6eo43
         1pVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AxGruxsGNZDKumgY5Vw8e2je4vXGSSu6VCMkCFSxceM=;
        fh=xuWZC/hKz/Qh/EjTNgo1B/D1+yADXcdHX6TNMVzTAeY=;
        b=hpScXczPfLvQ4F9EznSuG37lY+PcXuzBmcartmEIwxWrLpttjtKjvwEWzz6IMi14xi
         grmJb+FJdQdo1isCsc/EVe7xW3karszYCYtPwraTjUwFI706sdAOGnO+JDbkzVUa2cwE
         3YTRJpgxTzicUM7vX7+zi3j0Dvp98sB1Ck/+zt+3p8Ol5JuZbu0jXmvWCFpUTfmQlnq3
         LPD0W0aruwQvc3dGB+Sq7Uex/RUiCVzElmar659rCqZNTRcYAh1EJ84lvRQNrYQHhiGX
         2Fsx77mJvBBRvRcihzglMf8yrLWzMzxoos8NUUToRYZWElG/j4yFLm0GR3rQbi0j5wE1
         TP7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778187145; x=1778791945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AxGruxsGNZDKumgY5Vw8e2je4vXGSSu6VCMkCFSxceM=;
        b=o4T3hi0m35j+VkZAncDB4DHYKDrYS9qFY4RAlCJhP5apoUi8+69GFuUJVmauKr//51
         TznYikymrJJd0Ko5LM5Nsm/+Ex3J+Ojyoa9Ok61bNi7L82DwXMVuPtA9mYk3LWhgJuLU
         O9HIbtWF6PMvkVgle8aFvMooD95Z70PVDsqdrIGTdITcY4QCggIwvuL+01Ap7ZNhkYnI
         ZiEMIJjdkYnCKL/RRdoZU0+v/BdRea3RcCwbx4qv98UdZ2IdWwY4tuAFXXqeFCzYgMt4
         lESMvvRMioKaTNJbTPSwocF//4FhePA6LLQzrjwLdMNeZUafMTcMldWgOhAk7dEsD2mK
         7zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778187145; x=1778791945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AxGruxsGNZDKumgY5Vw8e2je4vXGSSu6VCMkCFSxceM=;
        b=YW1uk68mzmyfCZnCkaqo/TushfmwItuoPNnvtsIj21+GbtGZvRAPG1jT1EPH0ZfoGu
         683D1be8FuVS6ZW8T9B54xyI2SpeV6UOOOSlPnqI8XaR6h2sF25zIIiCan1AUSox95nJ
         Cqyy7CwxFuVqU757Og8dc7XsRdEPCf+3TpKymjSL0mSAbXGbxm0PLTDN/jwBud2xhAHt
         +hQioZSRgDS8hvYOjCMpEewchdoSTIYX+8ldVEn+Bb2K2HN4F+ByU0s3cqcIriKfb+59
         LBKYeuSxr4sNCacHBLMT2Exvk2J000s0jT7BZ/Etx0GwLIOQk1ev4+z+X2YXvoZJjHbu
         lmxQ==
X-Forwarded-Encrypted: i=1; AFNElJ/kn9TYCvmepPMJa4F+SOC/9TCcfe4YvV3pN1fQr1WRsh3wUpPQLMzr0kLu7425riAAmrZO/Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFfADNzn7zYbtyeTedmU/QTyMtttfV+mu2gTqYULdQvwfdTgq7
	ScKb6wO4AnGsUm+GMBY9q1ouUdlNF+8Ew4meCXVDZejw1Yea2rN6dze10/O+ioirMVqTZMTYMxj
	NCt4o/lY0yOBs8vIShDI2voN/NIE8Ll8=
X-Gm-Gg: Acq92OH3TIJBoD6guryrfWTgQCk5TvSRUSAQMPlfkt5OSPKR041XvDKnCWjtVvm7sld
	oLK6yYVTRGGnTHDGAx0uB/EnODqsumQgV3907fq0kRNrxPn2mEuPC4A05+/O/f2P+ncx7aRy5bN
	6GFT6ZMpkraPEVL+CRawAxQWjmd8RL/eJRw3Z9McI0VKLojz/ZvM2Y8WrBWmsqrT7C6a/JWAbs+
	c7rCxTsC7bCB/gXBwbvRYLAC+qcrAj/ALW+6xgsu9ig0aiP3vCdl3rMvxAD2t0xLik1fCIHA2Cg
	uQITbw8q
X-Received: by 2002:a05:690c:399:b0:7bd:9f34:59a3 with SMTP id
 00721157ae682-7bdf5debfdemr105514997b3.11.1778187145420; Thu, 07 May 2026
 13:52:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507095330.318892-1-tariqt@nvidia.com> <20260507095330.318892-3-tariqt@nvidia.com>
 <CAMB2axOFQN2f=veYgeJs+4tbZmb9PuNHk03TH_bmE8UL_REd7w@mail.gmail.com> <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com>
In-Reply-To: <b1d3f9bc-a5d7-4236-8bda-49e6327ee533@nvidia.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 22:50:55 +0200
X-Gm-Features: AVHnY4JXLq0U2mInYg8CWMgYg4YNUYRiIklNKGDbus860W7Gzb2PpLEEAl4-lvc
Message-ID: <CAMB2axPNhveQaDPs-ttu4uFcpvAfJCdzJ3d05HWQf4+p7uVUsg@mail.gmail.com>
Subject: Re: [PATCH net-next V6 2/3] net/mlx5e: Avoid copying payload to the
 skb's linear part
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Christoph Paasch <cpaasch@openai.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 36DF24EEFB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285489-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,openai.com,google.com,kernel.org,redhat.com,lunn.ch,davemloft.net,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 7, 2026 at 4:50=E2=80=AFPM Dragos Tatulea <dtatulea@nvidia.com>=
 wrote:
>
>
> Hi Amery,
>
> On 07.05.26 15:53, Amery Hung wrote:
> > [...]
> > Am I understanding correctly that the better performance comes with
> > the assumption that the XDP does not change headers?
> >
> > headlen is determined before the XDP program runs. If it push/pop
> > headers, there could be headers in frags or data in the linear region
> > after __pskb_pull_tail().
> >
> That's right.
>
> >>                         if (__test_and_clear_bit(MLX5E_RQ_FLAG_XDP_XMI=
T, rq->flags)) {
> >>                                 struct mlx5e_frag_page *pfp;
> >> @@ -2060,8 +2066,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_=
rq *rq, struct mlx5e_mpw_info *w
> >>                                 pagep->frags++;
> >>                         while (++pagep < frag_page);
> >>
> >> -                       headlen =3D min_t(u16, MLX5E_RX_MAX_HEAD - len=
,
> >> -                                       skb->data_len);
> >> +                       headlen =3D min_t(u16, headlen - len, skb->dat=
a_len);
> >
> > headlen - len can underflow but will be capped by skb->data_len, so
> > this should be okay, right?
> It is safe. But it might trigger an extra allocation in the pull when
> len > headlen. We could also skip the pull in that case. Or do a
> min(headlen - len, min(skb->data_len, MLX5E_RX_MAX_HEAD)). WDYT?

Make sense, but this line took me a bit to understand. Maybe consider
checking len < headlen first?

if (len < headlen) {
        headlen =3D min_t(u32, headlen - len, skb->data_len);
        __pskb_pull_tail(skb, headlen);
}

Another clarifying question. So this patch will improve the
performance when the XDP programs don't change header length. For
those that encap/decap, they should precisely pull only headers into
the linear area for optimal performance. Is it correct?

>
> Thanks,
> Dragos
>

