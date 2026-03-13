Return-Path: <netdev+bounces-267635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK49Nv2VtGndqgAAu9opvQ
	(envelope-from <netdev+bounces-267635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:55:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B2B28A8E8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3519300F2B8
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA4813E317D;
	Fri, 13 Mar 2026 22:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="LvQ7+Aoj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362CB377EA6
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773442552; cv=pass; b=oKnscye2mT2JuLxD5U0o+61gzmHjdofy8fAbfmA8xut+/xYQc9eXBUtJKbNjr/PAAklsotj5XllEfCd2kMQWfAVtSaAqO7sEs6IpmIHIkFgP+XJ8/J3vWeOrKWK/UevW6sO+jQGxIGgBHSjKKqpwa1UKiL5STFPgzFbzS9Rhhl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773442552; c=relaxed/simple;
	bh=1Ty0xY5cZA829vovRzYzuYeyQoqsHZ6EMyQIZz33Oxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUxaMbCuAjGB3RZIzWdLyEymTsUnhp4nZ0ewiUtXggGU6Vnv3vaIYzB3dAA+i//+C3YvOXvTFbNUY3E8SYVDhxoTG3v4H9Gpgyv/u2nCcYSRsV80Migf1mtNc+cwnSgNBPQnBg508HVxvoquryjFcxCtdlbTOpC/ZK8cZeicqWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=LvQ7+Aoj; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so2409197e87.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 15:55:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773442549; cv=none;
        d=google.com; s=arc-20240605;
        b=G2l02ve2A2BqMXdlTNaIldI4goNAH9Gwvrnn1IJRsiIgvAvuhMPWwjVijiePWi+UMv
         lb+UJUbvLnWoMmpy9AyD4g2KcdyPOeiVyheUtbqg5y+b7O+fCwb607NGddQNXXVxoHDn
         hhDoRkHqgylW8SQ5Eu2/l2xBqBXHuB57k4ALrL6KOrIc2rVLYSWNUFUUPspLhTytaTB3
         iNKwLOLTzRYdrDa5YGSsFQKfrxYkjIs7DQj3ej5v65/oSX7x7SAN+WbFxeivJ3KqEeHq
         b17TEUVrfsUtExojtGufuH1AwDHZSlHMtMrSkPsjeDKLEO4qtyHGv+tLwq1nZj8FBMVM
         qg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W3QNx1W8EImhWG5G2h7xr/vJQj2kmarfg6d7Z6ksV9w=;
        fh=yUop17RoBf3QcEq4adbpXkX/YNh6BJrMnGFzPWERoYw=;
        b=bNnjJB4mgfx9cn6EsPlxQxDIqatcHJmft0snWWDI0679vJ5VxsKQMPIsfh1abBjhmp
         qkgy0LfKCIYeb0jGJ4IwiavYKI2a8QKK3hcksPcHknQtOlvKmKJJ0Fxmw79g77SBXFiG
         UaOylPhQve8f+yX3msGz5X9LLDqmGW8QyNHoeE8nAqTSExoYHg+yrlaw4Ec/0Gpl56xP
         ojEDR6v0PMrSofXqc/jYrfry7DZtMf5xf0YPFXqtn1+HAl96POyD4pTQ5Qv/DxUl+zqs
         5lQlppC08+XdN59To4iJBZyMEr4NWjHnvVX0Z4L4xySfTAD+oKP0fqbCKKE6+4QDxcT4
         55zQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1773442549; x=1774047349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3QNx1W8EImhWG5G2h7xr/vJQj2kmarfg6d7Z6ksV9w=;
        b=LvQ7+AojIQWbWslVxV6LZp++FCtfugv49r69G25dyddJVQ9fPkxdSjNimICXT1G3RT
         yteZJtN4o43lx5JI9ETEBiPHRQUuYuVt+Y2bqPbCdA6ZSX8ic2t62emO7/JsN1LrfnP0
         GKHCPYWxD5DiwyI7H4bda8dma8dX3n+0KRrUQs5iNgQEFZSSBb8gtD2DWkdT15jp8bC0
         VufTk410tXmf+a+ZS9Z3onFFt4HURkznVec9CNUXuj9a2omod4iiPXOFMka6sbFzUrCg
         xsia3X3JlB+QfnmIuBi4pwgW5SlGehvapj4envNOBrZpXA+IOgsPpVRGRzEilcV1HeZB
         SYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773442549; x=1774047349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W3QNx1W8EImhWG5G2h7xr/vJQj2kmarfg6d7Z6ksV9w=;
        b=oSERMb6T4nHC9KoGc5K4auhMiLVAwT6zBwCgncjhTGFrBKmHtExiuMiUP3xBzmRpAF
         K8f+Mk4SLIY3E7g9+M2WC8/GV5BkN4lWHE/IIgjHFWMS8+V6X8tJJiMSmVXhRxsdQn0L
         lyj9qnDaXyb2QJtdLKLc88asQThJxQSJF6cv6tRLF7Lz2oTslHY0TWX6syF4NxQdzLh0
         NTXgsttH9eCJWK6D0DL7UFZsLc64fsrWtAfL2+QR2zSAZ8qLR7jUAgxZ/DtzFSonnSqY
         UFHoXAKtB7uJOeYMALDIRUXIM8PKei9EJ6aYfuwbjBZhK5hGs0s/M0x6C2fdrzmOrYax
         ljwg==
X-Forwarded-Encrypted: i=1; AJvYcCVKPAY90Er7hFMAX6tGoyGlEhRqIQiIKL1Yr0N134H8uOiECyl1HHM7FKeN+gsSthLdwy4LBmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqsWBHcVJLYSrUSQNibGPBhOU2rFR2Oui72ilCJjaUgn9Hspg
	eWv5GQs7saXXOlUmcRFMFQRuQ8TZt13W/oVnfyOrL+ucQSz4Tia2KEe+n/JaHOyBkySwB2Xz8bi
	SUOCAEqMtMWItn6kb1x941Y/R5w8j8IVIYxgzHPP6
X-Gm-Gg: ATEYQzxg0nc1RaxKrJnlefurYBpOe1r23eQxyMh/Wdvmj2polhfMfjyEAYGZNh3kXy0
	RZ4XnWxuaEA3RvQJhGUGqSGZixYKI0Zjn7ry2tpQXbnaieldW0nsdQepEFKwcIczMIzAyYkCl+T
	r+BItJxn8341PDVn0hzp4MGlW+9b2auyxO9Be5CqdG8we3ARZS+6IWii7NEl2EcsNV9a2uPfGG2
	mDzgwKc/J539p2yU8Co56J1TT8F3kJdi3RShs+WkmcS7y5O4WsvxNDs2AwIGDQpPceAY57U7uM2
	GflIPghPIzbPhS+7b8E+BUMwg0Bgyn5Hsns9oL6nDA==
X-Received: by 2002:ac2:41c4:0:b0:5a1:227e:2753 with SMTP id
 2adb3069b0e04-5a162705a51mr1219058e87.7.1773442549289; Fri, 13 Mar 2026
 15:55:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312223157.25083-1-panchamukhi@arista.com>
 <abNxz9T_XB-JtBCj@strlen.de> <abPVr5RtRmZeyszb@chamomile>
In-Reply-To: <abPVr5RtRmZeyszb@chamomile>
From: Prasanna Panchamukhi <panchamukhi@arista.com>
Date: Fri, 13 Mar 2026 15:55:38 -0700
X-Gm-Features: AaiRm53c8uPZmtPIEF5jDrLrZEH8Dcp_VPBm6r1Z8iuHGq0Ct2Kh-ySBjwFklDE
Message-ID: <CACqWiXBYJgM3S+QfON-fJQ=dPX3r21CVMN9rAXcxM+hi=DzydA@mail.gmail.com>
Subject: Re: [PATCH net-next v2] netfilter: conntrack: expose
 gc_scan_interval_max via sysctl
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Phil Sutter <phil@nwl.cc>, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267635-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchamukhi@arista.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,arista.com:dkim,arista.com:email,netfilter.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2B2B28A8E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 2:15=E2=80=AFAM Pablo Neira Ayuso <pablo@netfilter.=
org> wrote:
>
> On Fri, Mar 13, 2026 at 03:09:19AM +0100, Florian Westphal wrote:
> > Prasanna S Panchamukhi <panchamukhi@arista.com> wrote:
> > > The conntrack garbage collection worker uses an adaptive algorithm th=
at
> > > adjusts the scan interval based on the average timeout of tracked
> > > entries.  The upper bound of this interval is hardcoded as
> > > GC_SCAN_INTERVAL_MAX (60 seconds).
> >
> > I already said that I'm not keen on this approach.
> > Its a 'we can't do any better' type "solution".
> >
> > If anything I'd be more inclined to make a change that allows to
> > more easily override the next_run computation via bpf.
>
> It is regrettable that the request for this knob appears to be
> intended to enable a potentially proprietary hardware offload
> extension, implemented through a userspace daemon and a proprietary
> SDK.
>
> It's 2026, there is plenty of infrastructure to offload the connection
> tracking upstream, such as act_ct.c and the flowtable.

Thank you Pablo, for the suggestion. We will look into adopting the
hardware offload feature soon.

Thanks,
Prasanna

