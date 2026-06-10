Return-Path: <netdev+bounces-297461-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id onhrCwkAKWqhOgMAu9opvQ
	(envelope-from <netdev+bounces-297461-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:11:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC87666619D
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:11:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DGqfKSh6;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297461-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297461-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E287A302F617
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C7B370D7D;
	Wed, 10 Jun 2026 06:11:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF65370D54
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:11:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071876; cv=pass; b=AAGBvdcwvNc5pWaHWl5rOO4wf42fRTBHa2L/HOXZB0r5OsgpzrbmERUUccLML1iVaUfu/GcOQP5jAB3CE1vig0sFhoOE2q/IizGV3BVbiRRPSN093yr3dY8Uqq04sB0XTpcs0YRlDhOLWOXKuiw7y38/fB6dJQ4rouUg306jjw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071876; c=relaxed/simple;
	bh=QYif3R/spp7mR49jiuqCRarwjPV6UuVKEEqXbXLTWBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnK052lRuXjHc5fkWkB5ceUjJeLNCEHG5pMZsB/ATwiTPMK93qcmKWIGJiklu9xEFwXhIzgNKf39BBFnIwmaCte+K3rOIFbc6kkT+qrs96G3reQC4T6UWFWE+ku1+EsRQUrBPH5lUyDNxnPqTd/j80HwHz+bM9mIkgF16EfrMH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DGqfKSh6; arc=pass smtp.client-ip=209.85.208.54
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6913160c9ddso8505970a12.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 23:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781071874; cv=none;
        d=google.com; s=arc-20240605;
        b=Gk/0kGufuVUJh0sG9i+nZjucGz5I6pYtIlf8NOUtURGcGpdfpStiBRLqCwehuhq/mY
         AHp504okr4IBaBozcHFCKoZiqx1bwYe3/u6JFytSuTNRinOTf98NQbQ24MmxwIcAj9HZ
         Lw5lZt6kXz63QHxHm6T12uXMnTDi6tji0/e2sKuK85FChCfmqaEqEZA7pnv4k4h3MA93
         MHcH4BquIy4fGh+/KM6EPjH3bbvVdHgHUV2RANKOvsY2Zl6tET2x/v+OuhELY3xwHLW6
         zFaCKvfr0UK6N02u+sdRxw3lqdGhun+Js/Oht7xCmIObTunZVaiADVXdHW2VUejoWJt/
         qgUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Uc426gs+gKlawhZVrWgjK5dZaPGvEZGz0i45gd463Jo=;
        fh=PxP6mQ+Adba8Zo38Ug8djYVDGwg+h+lF6Z99d7XWv1s=;
        b=Syj5IwTaG/E9l1NjpPZh7lEOBUoxtSnzH2R9xRYdcICdKBvTH8X4if9h6tSHFQ1Y7p
         JlWLA4HjbvBodo6rOz9DajgcVjqaWnuMQ0bhgNRWoC9ybrO1kDe5c/e2kGIQVmK46/3t
         wxojA6gxzgeBI1fjWepWTyhLdEteNWaEWp99PIsOGwYx0H1dA4w4u/u3roz+uDiPr5Vb
         weU0aZ24TyiKIBYxrNCvNBhbUPuW5UI3EvV8KHYPZ4Kpxw88R+tNVTE5KqbW1S6whrQJ
         o2TbenPaPnjKzPqLmRlgzrBR6r6bcoDlZ8gvEmVkE5bAJQ3RBLDs/hzh3A56mvJfz8Uc
         sqCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781071874; x=1781676674; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uc426gs+gKlawhZVrWgjK5dZaPGvEZGz0i45gd463Jo=;
        b=DGqfKSh6MJ7LIlg1jU8WDefsSeRZKnbzwf/RSqYf6Alcz/6e+HCiiPAeQZVIQ7314/
         6gUBftjIqr/BamS8n2GorKFSkH6t2rfmVCDiv/RcPdaOWv5KXEetm6OKTjppxmG2NwFs
         +0peRyWRTVnuytM3u1vK7lH16o4nPPN3pCiputiePN7qDGX4r0Q75IJLA0ORYjvq1mnk
         MS58Zq82MZkX6qEiSWi/qYGsJk+janomo7vCgfo3I+j1KZe25quyZoIMaAPBpD5SRWn3
         980CprARXvhYJISoAMbzBrUJUvgJiln8jfYpBqDCuk/Chb48YD4GvGeu2j5fa7Xi6Qp4
         DVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781071874; x=1781676674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uc426gs+gKlawhZVrWgjK5dZaPGvEZGz0i45gd463Jo=;
        b=c+02LN5gyX0WTvgZW5OWTnav2n1rm3b9VC2b8HKLNgHsh4hcvh0JZmxZb48/MqPqVb
         siMjuJwK+tMjo6SWW1g/KGry5Br1pUBNYTMezcsJ7NNBKizr7eHFRxwOmhbnyIxHARNW
         TUwjZBfSTXgx4CKCRTvryfua+gtq6Nlr2vKAF4S//z0kY8kcvN1RWmD7zNyxnxOT07Rr
         OvlyOXR/5a0zSs29dBMPHqoZjWQpNuq2zVtbH/JO2VtU+xVFAQNfH294a4AqUCsnanJ8
         Ou2//HQgmCd0uMe/s6GS79mqMQaKq6V90fKGZlqcOEGAKjr44YsxVlbcoaJE0kFWGRPh
         vVRg==
X-Gm-Message-State: AOJu0Yx16uJpAzmtA4RSCTqAaMDqbPBae/aewmMuXxgO+Wo8pqDfgc9n
	I0nHl1KsriTqAyn+DKKVdcg+IHVBzMFRDehY+4r16o+kMgepEqWeVvDK+5ME7eOefQUEqoL9oGk
	CVtrYOOurwUEEsz8UNylYPzFF5wp8Q7M=
X-Gm-Gg: Acq92OHrk7IL8IbBlTXdJdJlwxSEEBI/wzvK/WI1SKRsbyruJ1KOvGrMhnBy40bvoxP
	sIz7+LEzGw+kJp3vKIg0E8s+VEehu+ulFmEK7EmuPxXB+Ondz/rfzi96szHbDN65KEY1AWjONFU
	ZRagMFAAVt7tMDy6uStuDNCziXzfk731vb7P4lcVidkfOXhRWiODu3h56MfO7XEMWZ3k61EtTkT
	cxwvV+y6vcRN9Mo+ijQlIEOKatsPf69mhDSUA9g0N2j1rt5A7idMs7AVGSbrGhoIVZsBS0QKlXd
	eYZWoFDadpOm7MP8H+QqPXD8EZKeY9VfWH3YWe77dazYu4ylFcY=
X-Received: by 2002:a05:6402:364a:b0:691:52e1:646 with SMTP id
 4fb4d7f45d1cf-69152e108b3mr6477436a12.18.1781071873869; Tue, 09 Jun 2026
 23:11:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605122215.825-1-7991aleschino@gmail.com> <aij3_qm9x7LJUfbG@secunet.com>
In-Reply-To: <aij3_qm9x7LJUfbG@secunet.com>
From: Alessandro Schino <7991aleschino@gmail.com>
Date: Wed, 10 Jun 2026 08:11:01 +0200
X-Gm-Features: AVVi8CfhpwF9TnRNcypnziUhI73i74ZlVyJ8N_21zhB7w7uYR1zjBhXX3f07XHY
Message-ID: <CABNe9nPN9-w91L8TMetYXszAE7C3ZFirrgPkB5kcKHot2XCaOQ@mail.gmail.com>
Subject: Re: [PATCH ipsec v3] esp: fix page frag reference leak on
 skb_to_sgvec failure
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297461-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[7991aleschino@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[7991aleschino@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,vger.kernel.org:from_smtp,secunet.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC87666619D

You're welcome!


Il giorno mer 10 giu 2026 alle ore 07:37 Steffen Klassert
<steffen.klassert@secunet.com> ha scritto:
>
> On Fri, Jun 05, 2026 at 02:22:15PM +0200, Alessandro Schino wrote:
> > In esp_output_tail(), when esp->inplace is false, the old skb page frags
> > are replaced with a new page from the xfrm page_frag cache The source
> > scatterlist (sg) is built from the old frags before the replacement, and
> > esp_ssg_unref() is responsible for releasing the old page references
> > after the crypto operation completes
> >
> > However, if the second skb_to_sgvec() call (which builds the destination
> > scatterlist from the new page) fails, the code jumps to error_free which
> > only calls kfree(tmp). The old page frag references captured in the
> > source scatterlist are never released:
> >
> >   1 sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
> >   2 nr_frags is set to 1 and frag[0] is replaced with the new page
> >   3 Second skb_to_sgvec() fails -> goto error_free
> >
> > Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
> > unconditionally unrefs the source scatterlist frags. Since req->src is
> > not yet initialized by aead_request_set_crypt() at the point of the
> > error, the source scatterlist is obtained directly via esp_req_sg()
> > Existing callers pass false to preserve the original behavior
> >
> > The same issue exists in both esp4 and esp6 as the code is identical
> >
> > Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> > Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> > Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
>
> Applied, thanks Alessandro!

