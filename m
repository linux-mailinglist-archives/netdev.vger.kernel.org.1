Return-Path: <netdev+bounces-257934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIu5BUbaiWlFCgAAu9opvQ
	(envelope-from <netdev+bounces-257934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 13:59:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8128B10F476
	for <lists+netdev@lfdr.de>; Mon, 09 Feb 2026 13:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 70819301475A
	for <lists+netdev@lfdr.de>; Mon,  9 Feb 2026 11:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9275937105A;
	Mon,  9 Feb 2026 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwnVmbRZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDF336F427
	for <netdev@vger.kernel.org>; Mon,  9 Feb 2026 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770637279; cv=pass; b=h/zhMoM/NSgvbCvNcfB7JH2+ueikJMv12StegFjBEZ3k0omcdOWxdPIKpDG5gjXsKb0FqJ1jiX5LaeYpPpnfo58uLNrZbePBv9l8ZyOsGxRCrIbeVu2G517sQx+zHvs0Kv+HmvTnywq0OcFsIjlzzFQ/sASva66bGe0wV9pNKbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770637279; c=relaxed/simple;
	bh=AjNuSZh4zcviKXKCnZlS9/KAmPUU2mz+9QTgCjQZ+QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXaldCUEnEWfClu3ryxAL0b9LiCphUfZWRv56tYBjm+kOJ+JlfV6smP6QKBrNpFoPLs3FI1WU2q1/sZWFQLJrqWTc/q+eAJzorEFavrCFe2cCg2v6m/KGPAJuva+BDneFt/D5dxqMjWMXnWGUL3vAQ2RR4WsmLbF1bry0FBSCYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwnVmbRZ; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-790b7b3e594so46289957b3.3
        for <netdev@vger.kernel.org>; Mon, 09 Feb 2026 03:41:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770637278; cv=none;
        d=google.com; s=arc-20240605;
        b=g+VVdEBEhfzqhEPVnZ6vumv3YhDGc4AgSNBcTs6yVJtcwz7lXwsFtZ0ipzPYadq0yP
         JGHzZa6VHZq6ITKTfBV1c7HgOKB5jn22pfr/tp+bGDGC8ePA8gfSvKe56xIFqPrPbtP6
         wxLALwhrv7QktgOkIMlwCNYzgAZ7BhLZGWQEzqitYEXqh668iwFgdWu2YitpE/KkX/yE
         w+bQ5iq14xs6B+tETFylesmcavD8rYj95FM6TRqaYbqMcUHMuhDhqvMCEDip3IzQ+vwc
         +RrltX4VcbaTw2+O2MxWa//3PMESscCMI95JXH+dwiz/hRNSyl1t9Pr40pnIY+6W1Chv
         vZJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=agfwRv5BYKvKOnJn+0U2423jmDQfU0HQzH4z0m85B1I=;
        fh=7e3TvQCPo+yuf7WEaJCHv1RoI+siaPzcxuJyVNKgjLk=;
        b=BWclRvsgXN37nDW4/DCxwMsrPNymxqpK48BBVZKDzGh469xhJ9i/mfXjZlyls95lN7
         xjqHI5XQpIaurML0Bx/Nuq8TtJAFFz/YlehfuG3DvZV5KFowZ/mrIAQB/zKsDGolgLCe
         ZYMitOK88yd8IkrN6ZsY4Mrt1GRYln7cRH2roeaGYIlTX/IXThjINst61PEQLnmUItSy
         cCvhSEolFKHb0y0L+reSXA2pPX99WZaIkGgnRnP/9HADMnvnKcrgZdIN0lm7sbI10Y6Q
         wa8rLE2v+NNLUpEF+jkkVaxyIMojUU5WOa6EIvA6lo4haFP3StbEcDVmLJA2kTJzhkbU
         5Sxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770637278; x=1771242078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agfwRv5BYKvKOnJn+0U2423jmDQfU0HQzH4z0m85B1I=;
        b=fwnVmbRZ/ZkBwwiPCbkH1kUxYxjeTPZpqYsEnXXMR8+zryVP5Ko1TmDeVEfbMBwLWL
         9Nn+ugwnVyTdDwhrsJuYfkdw2DQfzVjU2zxkDl2rI49ueAya2O5ub/P65jo639b++RuI
         gGTdmERCceHMtCh9SqyEDoNU9VVUNavm5yfx3MGaoma0+gnbD2h8nWxRaEgIqpSn7O7v
         wgpk4fhqHKXHDoWh+zjrm4JMDiOCB7O2bBBXqwluTrp0rwotImiKpBI4uv9bCS0q6Cqr
         AODfvKZmB5Zhh2PzHvkFLTE/uzqApe+fbHhVhDwJlKQ6VR6NnjgKPu/I1au48HyfBlrC
         nijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770637278; x=1771242078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=agfwRv5BYKvKOnJn+0U2423jmDQfU0HQzH4z0m85B1I=;
        b=mx5m5SewROUaE2X4R7410IwBwRn/D/EyUeWKoNaf1xYSlQqQyGF9uGhpotoh6fMCf0
         gmmfxiKOlRjVYxFlQDq6/Ciy3kPiv5JI9YS/QAOt85AhAN6yMA0FBM5xQmjWlAGOBcvm
         r+uRPjA3BDRmqP3SfuDmBLxhr+6zePfLu2TWnMairYyIKgpz2MdodsuR23oVhiOJHQ0G
         1e5n3s5KGpjQCR7MSS3/t77rGsLtVGxj1/oSP8PoF+YGANFpPh/dTrugEAlSaUAu+kky
         n4DXs6r0ZEy9zqaKMHUNwsBGIKJHnKz95NVDwZyiitkRgsZMAyS3kWauC/osaVVKN2HL
         6LHg==
X-Forwarded-Encrypted: i=1; AJvYcCU/MO0fNbIEhcvNAAuoaCMEVrpVAwOT/IXoJ5I97N44vMlLoHDHFaI425GAoro1ZzCHXqLrPms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsRPLu+21qtSgBjTu8BGMqEwSYq/p8dAdO1+6mtYfUMGci2P1
	eqHQ/6rkIh+i1C3yQmEfOY8ySsl9wxzHxBmP7FogUHJ4TI5eimf0VVTobQP/0Q4g6ZljRr5dahW
	+Mt2Sa6Q2dJoACgp3AuuVUAJYApCciI8=
X-Gm-Gg: AZuq6aInOal5Tk/fYJfX18RM5DMyremka0cd6guJjYEpB/Nw+t8/iy0D0k11w/MkzH/
	CBrEKc2tnfjtNi8MziqVYlE8Km8hDxwddYiv8LEkX6KtEOeZzhkhZxCuMxl3aMTnQSLLmpGe3BP
	EoJKUrXQm9HRb/hA23aVc8Q/phAAOunvoN6dRRK989DkeXgyMjssmRVM3rqMlGzE94iikaSMRw0
	vSDp2X8NiRxKrJRi+so8FMo1uqrpI+XG4SxFwqbv3a0RXzGWWWLwT7vT9ecg8GlsanijBd4p97Q
	GQdKBPpz4En1XsvXdnghG74B
X-Received: by 2002:a05:690c:d93:b0:794:7866:2630 with SMTP id
 00721157ae682-7952aa603b5mr111212367b3.5.1770637278373; Mon, 09 Feb 2026
 03:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209021134.21194-1-dqfext@gmail.com> <24606a3d-b8b6-4e34-845f-8a76e9d13154@linux.dev>
In-Reply-To: <24606a3d-b8b6-4e34-845f-8a76e9d13154@linux.dev>
From: Qingfang Deng <dqfext@gmail.com>
Date: Mon, 9 Feb 2026 19:41:07 +0800
X-Gm-Features: AZwV_QhMm4Zxz1Q8Dev-7zvOAUXSfimxjHOUYIrGZfk99aitdgmQ3MLIffvN0Ao
Message-ID: <CALW65jbaV4WCznjo4NxYe2Vs0NLLU+xV6-Z4sV9DNu91A+sUGA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next] ppp: don't store tx skb in the fastpath
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	linux-ppp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	TAGGED_FROM(0.00)[bounces-257934-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dqfext@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 8128B10F476
X-Rspamd-Action: no action

On Mon, Feb 9, 2026 at 7:17=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
> On 09/02/2026 02:11, Qingfang Deng wrote:
> > Currently, ppp->xmit_pending is used in ppp_send_frame() to pass a skb
> > to ppp_push(), and holds the skb when a PPP channel cannot immediately
> > transmit it. This state is redundant because the transmit queue
> > (ppp->file.xq) can already handle the backlog. Furthermore, during
> > normal operation, an skb is queued in file.xq only to be immediately
> > dequeued, causing unnecessary overhead.
> >
> > Refactor the transmit path to avoid stashing the skb when possible:
> > - Remove ppp->xmit_pending.
> > - Rename ppp_send_frame() to ppp_prepare_tx_skb(), and don't call
> >    ppp_push() in it. It returns 1 if the skb is consumed
> >    (dropped/handled) or 0 if it can be passed to ppp_push().
> > - Update ppp_push() to accept the skb. It returns 1 if the skb is
> >    consumed, or 0 if the channel is busy.
> > - Optimize __ppp_xmit_process():
> >    - Fastpath: If the queue is empty, attempt to send the skb directly
> >      via ppp_push(). If busy, queue it.
> >    - Slowpath: If the queue is not empty, or fastpath failed, process
> >      the backlog in file.xq. Split dequeueing loop into a separate
> >      function ppp_xmit_flush() so ppp_channel_push() uses that directly
> >      instead of passing a NULL skb to __ppp_xmit_process().
> >
> > This simplifies the states and reduces locking in the fastpath.
>
> Quite insteresting optimization. Did you measure the improvements? Like
> pps over PPP interface, or the length of backlog at some ppp rate?

Not yet. I may test it with PPPoE when I have access to a network
traffic generator tomorrow.

