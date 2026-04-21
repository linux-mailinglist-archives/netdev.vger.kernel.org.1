Return-Path: <netdev+bounces-279965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JbTjKDbL5mnZ0wEAu9opvQ
	(envelope-from <netdev+bounces-279965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:56:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 990684352EC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 02:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4B9730046BB
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 00:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099D61EE7D5;
	Tue, 21 Apr 2026 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXu1sbtq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3FA1E376C
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 00:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776732975; cv=pass; b=bgU/ivn/K9dHO//Ty/tn9gwvgVOEAyq7whpYRmY/MRi3b00p73YXXSvwyKu9BM1l2XKedzUjtNx2u8jyw7cT8vPTOXiMGx+0+Pkzl6sAgMGctmvLjvMaZIZQ3+Wdbt4+n0yw6hX8pbJnH2Dylb26ZZLIg6fY4Yxo/sXsmEgvyjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776732975; c=relaxed/simple;
	bh=zw2Xj5D+twWP5EXNsOub/4MG7KCj0nY/wF4125mUPbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tOXeTyv0yOWhN4dSxwa6SnVTQbUA/L8IdRzMhqcYf9oxbHpSdgb9lXiAuuUqDn/9nRPOgH+M7u44KGUnDOhsnYIXe+9GJrSMYUkCM14n7kRlWLOA2WzdXaFWUZpD0wLTD86NDbcgMUAYC5ZAuDVJWDp/H7gBfX0iJpb7HnWs9oc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXu1sbtq; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38dd575bca3so44680051fa.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776732973; cv=none;
        d=google.com; s=arc-20240605;
        b=YWyQQoxJRUf1VzAYieTYYPA5uO4NxgxTW3PmMMeMCtX6uVyw+c7gqpH9rLnObX+0nf
         ln7oz/pNjXTUDOAFuBXMjJrtc1QKzOYFcvGq7wh9Xnm713NdLPY4APa44JLRs6chka1z
         ZqUOV9fDUZTuZ1Zps9+DHL77gEQb/oayZBWEz0Yd5lpiAkHjc3xGhHvw1k/qqWdwVHYZ
         dKE+pC33Ki2Qykv0e8FHTK+BqlCdVFTpmoJ4WiV81YbysAxWO/OPL2Ggaal3xiRHzBF2
         TgcFq/dz/0M8ge34GrGvyXWGJU+UwIChx4LS5NjykKFKhVMRWCmAx5eAViWBC22D2iil
         AgAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AoAIhqfWg4zYslwqGY/uY8Cm3DteXSovXormgLKYPmk=;
        fh=7QnmmHBh+cwAEIJTXf+izjBrr/elB9K1Ml+u0lf0p/4=;
        b=cj4Hu5fgWVyCrAuIxKqPWqO+teZwAjhE+0gQw98UPIhaWNRIJzLILAoSt1fP9sBw70
         0HhA1LNLdTefWBRcRmFj8x35hPdM144YwDh4BaCBaZpiakUJr9Q025G+41sPJye17v11
         /O4sDJ+zOiUSMr7hOVtj4zd45bQtb4dixUlIailxhX+h76adpmXribosONTPnUkAZVyJ
         0vi3mgSg2bi+cLk4y1tEJUyJlq6vBgJjk2zefmRB9tkCe1575dPo7nKPfI7YMQUs8Nec
         ihXnMxI7vUH54WgBZCWXqNMPYjXW5t8gdDku9raTHADvBRDzD2YlNOtBY5x7FaOKHbRO
         NRGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776732973; x=1777337773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AoAIhqfWg4zYslwqGY/uY8Cm3DteXSovXormgLKYPmk=;
        b=hXu1sbtqx3ndnCMM3lTh409bO6WhNzsK2y9s5Ms1hMl7amLI+7MhINruBcwz4ULBMP
         TFMUWS7joufug/MgjOCEYGdNVkoF+ZAHFhMgDAVgrdJMAL38iNtjnjHFWNpPiOs0HEd1
         TOAJCarNOaCZseawJi2eI57vg3OjsFiAfJzHADCqi13EPPsksb3HiqksqSzUc+Pz8epz
         nzlv5bnBQZttUVrG0Lh+3HpX01MEtF7dKRo9D9NyUQEm7VwXaZLWubLH0BabXhyw38Dl
         nB4lHq1SYP4iT0YzXVYPO/hMBeJ+7eJXQqC6pqBV+ezphXgcdHoQhEo7o+5oJJR6uejJ
         kvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776732973; x=1777337773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AoAIhqfWg4zYslwqGY/uY8Cm3DteXSovXormgLKYPmk=;
        b=dCABICym6YfZlZ0d3ulpsWSwIlG6YTxsMjecjbz8dfPdrQn8DJUsq0PoVLAn2jeXOx
         Nxc+GOtoovHm1qAcCehZ1aYsrhxefckLdBnp9fyqjcGXD96D52GWq1sFinRk0v49Lxgk
         QGQo/yf1FaMHcgstAJhsSHS/2f+3lNojDdvQB67ib4v80NTq0YwWNM33gxWjLQEQ+cLY
         E0hX+pf08kJ1OJcvxHIv4BDQmBRR7jaKo7zGsyzOnD9inHxRnh8+6wLBPYxh1VAeqYCR
         GGJExLt9DOqP98J3xgesl2HTqo1K7hqnFtpw/x+PDms1GgszKdRVmcIis5EUZFjJQaLa
         ye/w==
X-Forwarded-Encrypted: i=1; AFNElJ91hhrnpE7qpT4Xi3YZ+ysUlT+GHk2/JSmUb+nKf3rhgBVDN71PwOWevjz6K1iV/970qOheTHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uAWPA/4wmENvsFw1TOxvK3aEFyzecU6flMZgvxnUN3/TM9gz
	AG/zZnPD6L8rbQSLAkXiCQrdUqGt1NwByu5U4kavBwuxD2K/zl2/72rvMhYJF9AkWPAQr3KuAZw
	gJWbz7RlVwFM5xMyFOcZDek0W3d5iKuO0DCNdLgM=
X-Gm-Gg: AeBDievNIPOdMX69YnqZTUBURZUUqNzHkddLBT54/YKR1f98in3UbQ0WVUOVC8deCny
	kW9dVWC3fqKxExTO0WlhWpqOy2xTDkWcYB9dE6ntKl6/iW9tZL4Fr9dM3qHgNou6Zgd7djHpDFe
	vFyTZ7+JEydEmwDcVs84e+aGE+ZF4LK5yeEk7yZdjklbwgcDFvZ6xm2Js04+yaIN0jQ8vibs32E
	MDhtsjdx39NQgJM3h/idDm/wlWPpaiW32vQRpihN2wY0/uJwyRnvPDp6g/Dqzb5cVtWqEBxVzq+
	ICRijujJBE77EHVeaA==
X-Received: by 2002:a05:6512:6c8:b0:5a4:d44:99f2 with SMTP id
 2adb3069b0e04-5a41717463fmr3847291e87.6.1776732972611; Mon, 20 Apr 2026
 17:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
 <20260418045644.28612-2-kerneljasonxing@gmail.com> <aeZEjZSsVIdpcbFF@devvm17672.vll0.facebook.com>
 <aeZI3ig6w0PhGaVU@devvm17672.vll0.facebook.com> <aeZTxgvr0mdIG-lK@devvm17672.vll0.facebook.com>
In-Reply-To: <aeZTxgvr0mdIG-lK@devvm17672.vll0.facebook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Apr 2026 08:55:33 +0800
X-Gm-Features: AQROBzAgjHPMaajXL1_HeA_ksrKRPIE2-9gIROGm-sBSmjqsSk1fMrPQjnwr3bI
Message-ID: <CAL+tcoDzydfky1B0pBoOoE+rVQQyQLTMs1ars7JinKO-JEr5Tg@mail.gmail.com>
Subject: Re: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-279965-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,tencent.com:email,mail.gmail.com:mid,fomichev.me:email]
X-Rspamd-Queue-Id: 990684352EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 12:27=E2=80=AFAM Stanislav Fomichev
<sdf.kernel@gmail.com> wrote:
>
> On 04/20, Stanislav Fomichev wrote:
> > On 04/20, Stanislav Fomichev wrote:
> > > On 04/18, Jason Xing wrote:
> > > > From: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Fix it by explicitly adding kfree_skb() before returning back to it=
s
> > > > caller.
> > > >
> > > > How to reproduce it in virtio_net:
> > > > 1. the current skb is the first one (which means no frag and xs->sk=
b is
> > > >    NULL) and users enable metadata feature.
> > > > 2. xsk_skb_metadata() returns a error code.
> > > > 3. the caller xsk_build_skb() clears skb by using 'skb =3D NULL;'.
> > > > 4. there is no chance to free this skb anymore.
> > > >
> > > > Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp=
.kernel.org/
> > > > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto sepa=
rate function")
> > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > >
> > > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> >
> > Actually, I take that back.. While looking at patch 2 (which always
> > confuses me with that -EOVERFLOW handling), looks like we set
> > skb->destructor in xsk_skb_init_misc? So this kfree will do
> > xsk_cq_submit_addr_locked? Not sure that's what we want? Should we
> > move xsk_skb_init_misc to happen after xsk_skb_metadata?
>
> Ooops, looks like you already addressed these in v2? Let me look into
> that..

Thanks for the detailed check. To be frank, my mind sometimes went
blank while checking those complex paths...

Yep, let's discuss that there instead :)

Thanks,
Jason

