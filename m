Return-Path: <netdev+bounces-277275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEwWI0uh2GnegAgAu9opvQ
	(envelope-from <netdev+bounces-277275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:05:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9268A3D3122
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 09:05:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63952300B472
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DB738B12E;
	Fri, 10 Apr 2026 07:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wx/Taxt5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22D385524
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 07:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775804742; cv=pass; b=q4n5Lm96Usu6RAkS5aDW3jLZXGgnbq5OpKqp7qKTnVN+EZ2RCiA4Wf8i/JBQnQi4xWPzpJAu9Xxc7V2QN4GBg3CVJu0BCaaNzCibs/XdQxUFhXbur/ftJDx28tvwhZZJzNOz5AzZCtx/lLwfsYLp83g+XGPb4poDNhx7tWamRjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775804742; c=relaxed/simple;
	bh=z8gSP3PcBd/It2/0Cdc30diOdfycFzZJjCzVVCHITZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=musX3MjuiZ4CMWUKw0LeTv1sEIFFPz5pfPXuq71jatpSA06yt+RxKPPThyJF486iHXE/qrKYiduUsKyfjMzI0ruyhML1nc/aWX3xbbFOTt3SCjNvvoAjIcSrI9ck9uKTsnPIFRJj302Ftmf0xirgvHe0aKfoZUBu1MigtClVvk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wx/Taxt5; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-66f727d6849so2435430a12.1
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 00:05:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775804739; cv=none;
        d=google.com; s=arc-20240605;
        b=AQWe9p7CO7bJ2RkUGe81CumUYR6u3xWTf/mmdr4A3S6kilM+nMi3PKn5Jn1mOzb5xs
         okE2TOFOtfLe3N3QzlHzSnUAuvgN37L60+SLSQ0Qv9mXKS9ByE4UGSxQ+QZVYAtclYMq
         Ks39Cl7O0FJ42ygteOQxOsnlrzJKhdSJNBf0pAO5s/ab/7WNOm90aEPg2WBt2PWK2aZl
         dMwpga9eKOn5aZJrd2dCjhNseL0JS0D4ZYomFGjtdZxCZ3qWbutYZQnpbaayv+9v0Chw
         5C5hYyjL806R98Ys7SQnme57+lbYWkUfN5b//GRoA0qStDJKEetfJaOHg8Pt53Z6HpFP
         V5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=z8gSP3PcBd/It2/0Cdc30diOdfycFzZJjCzVVCHITZ8=;
        fh=vVMMmVnI+0qe3OOLOSIeljvRUf0tUDD2zS6snHRHC8A=;
        b=Kb0pM3KkiQKKtH+tmY49EfdGQeirEWEU0vFuGUy/SE0U9f/ZcG5xIm8P5mYyimK4Y3
         MxsEirM0XHG4kFXV4HZFE011uPRhG8oJXd9pN9FV71Qk2Y7/6MFhVgQIv0bzLUfwgoBF
         4jUNlM0vw3M9wIYojVnFCTwoJqc+w1Wno9ybDCirD2wuiwsatt2m2+y2njWqM3boaYdz
         vy6zPaLlzFuFr0P5iD6ZtlE67LAHIh6vD/jQ/CO7cuaam/+uw4rJrRVo8NlaH64kxcyF
         Gt6n0kebYYun8aChW3WxVvHbDCbHliZAe0DzCgxoPwqKE6z1l9BcSz8cs8qM9OVU2Huj
         3LfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775804739; x=1776409539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z8gSP3PcBd/It2/0Cdc30diOdfycFzZJjCzVVCHITZ8=;
        b=Wx/Taxt5z/rg4BRGIevMsOyxvha1BWm8HmXBW4vvzyAIjuyy68V3WrJb70J0XeTGId
         3IvNevHZjRMKWdZCukKcp5EEFsiRYFSHfB3tp6nmCwcPDk1BogO2viGTm8szGpCAplUY
         VISZfS/CxoEWJ/tE1wiToatDDyN4WIJ4qjqC9b71D7H/qN0ywf/OHFzRoURKfuj4PHG2
         iPbTIZAKDKAR1ooJMuHQzDU3ND8RMppPAXtBQx6uUva+cbTw+CNxB6ASPKO9ndo/q9dr
         kG2nnhni6x10polNp9LuEOwRrH4gohZFRs59j8Y/2jpLcZj0ICu66LfnXZaAAd2iTiab
         cHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775804739; x=1776409539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z8gSP3PcBd/It2/0Cdc30diOdfycFzZJjCzVVCHITZ8=;
        b=tPPqmIuZysEtZgGWKAG9He1NnI3N7KWJlVhIgzQ3xBqFSX2GNdk3C5wqO/VFdWDo6V
         +4H6Awu6ZzjFKIQRtionYX5AFlP4Tl9ggyURlsKUWHfJB3gz132mZ/45iUiBezk+G80T
         oKR8Q4pH6qbGhRhMROoMtMLygcZo8ckEMZ2OWS0ptZu1fWFkH8qc4+9tDoo98/QEzX0d
         b0CTdhfCcRHBg9inldTQwmRuLvUb2qCEl0erzs7Y87bIFuB3qM7hwlJBnaBgRAC+35Zb
         FvAxX26udxlqVFO3RZpnSHvNkJ7HZaDxIX9MR5CpktdFBV9MNL659gDug3YqH/X5bsaL
         U/zg==
X-Forwarded-Encrypted: i=1; AJvYcCUcoyMPOjbZsWLT6kAGqKmphvYGmul9Br23HYLa9i6ECtwN+/6qE+EK8UkMQBpYbPoQgIwU9zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNnEvQh12Gtg/vTj6t4ruckBMc2FnytKX1yGcES9u09Up2ZIp
	tp/hYeHPyEsIhwuzZ237UQ/+7Sp+V7DD3B71cKzT7XlmunJSISGyQ12y93wilABIk4WRnYdta6R
	yP64T68sS34UBtBCRMGuH2xDOADUzcyeBD14ImJk=
X-Gm-Gg: AeBDievFSUam+k2jHbKIvR9f9FfeI5X5pbUejOvmzgrOKicWVK4BmJh6ZEYHZeJp2IX
	gdrzF/fMBr9khS2qfHpFseVQd8Wc/puQxt+0dWczBexhrWSdbubBrIHRh/UfRhS4lmnp4RFP+CB
	xyVEq6+M6NLZj74OLY1NHkddVPr5hcQ5ClSPUSlSiIUqTLLbl3j16szvkfH6X0im9AYZ8mt0np5
	SFHjdElyy3QjVLrfg+8cv3AdvnnsD2It37jmGSCV642DvyOnKLYduQtUELFJRacP4gpBaO38ut/
	AGqLOxA1jEnfaPB2uGaGaaDj/5hsn8NEbmsbjJKubhi4nigGNpc=
X-Received: by 2002:a05:6402:2109:b0:670:a4b4:2176 with SMTP id
 4fb4d7f45d1cf-670a4b42493mr106612a12.22.1775804738789; Fri, 10 Apr 2026
 00:05:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
 <20260331-realtek_forward-v1-6-44fb63033b7e@gmail.com> <CAD++jLmRT+3EJ-f_FNuZwOGU4fBB6pGHhq2OuxBS7O-cEnWt=g@mail.gmail.com>
In-Reply-To: <CAD++jLmRT+3EJ-f_FNuZwOGU4fBB6pGHhq2OuxBS7O-cEnWt=g@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 10 Apr 2026 04:05:24 -0300
X-Gm-Features: AQROBzAZ9LnSu5ywwTVwmSkGlEycqs2tbwq-wbRiBxYP7lds7t5ofpNcaU76usQ
Message-ID: <CAJq09z6Y3MfkyiyaMhPTQH3W7p-ZmsNeS-iBKOeQNWWpDi0UoQ@mail.gmail.com>
Subject: Re: [net-next PATCH 06/10] net: dsa: realtek: rtl8365mb: add VLAN support
To: Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277275-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9268A3D3122
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus,

Thanks for the review, I took some time to evaluate the possibility of
reusing rtl8366-core.

> This patch ignores the existing abstractions for generic RTL8366 VLAN
> handling in rtl8366-core.c and realtek.h, which is actually compiled
> and bundled into the same object with the RTL8365MB driver.

While rtl8366-core is currently only used by RTL8366, I understand the
goal of sharing VLAN handling across these drivers. However, RTL8365MB
differs from RTL8366RB in how VLANs and PVIDs are implemented.

1) In RTL8366, VLAN4K, VLANMC and PVID are programmed together, and
the helpers in rtl8366-core assume this 1:1 relationship. In
RTL8365MB, the VLANMC is exclusively used as an indirect way to set
the port VID used in the PVID (port pvid points to vlan MC table index
and vlan MC entry has the VID number). In this patch, the VLANMC is
conditionally allocated only when a port uses it as PVID and
deallocated when no ports use it. VLAN MC membership is not checked by
the HW but I still keep it in sync when it is allocated.

As VLANMC, at least in RTL8365MB, is effectively only used for PVID,
I'll put all vlan MC methods behind public PVID methods in the
following v2. There is no need to expose them for now. For the next
RTL8367D family, VLANMC is gone and there are dedicated registers to
set the PVID VID number for each port.

2) In RTL8365MB, vlan is always enabled, controlling filtering by port
(.port_vlan_filtering), while in RTL8366, it is enabled by vlan_add.

3) The abstraction doesn't set the framefilter in RTL8366 nor does it
clear PVID status. I'm using framefilter as a way to disable PVID,
dropping untagged frames, together with setting PVID VLAN MC index to
0 and keeping an empty (vid=0) vlan config at that index.

Without clearing the PVID state in RTL8366, removing a PVID VLAN
member and re-adding it as a non-PVID member will leave it configured
as PVID.

4) I don't know how IVL would be handled in RTL8366... but that's a
topic for another patch.

> I understand that it is always easier to develop and test something
> for "just this one chip", but I predictably have to be the one to ask
> if this can be done in the shared code.

I agree there is room for sharing logic in the future, both for newer
areas (table access, VLAN, L2) and existing ones (phy_read/write), but
this likely requires rethinking the abstraction and harmonizing the
assumptions on each driver first. It is possible that the hardware
behavior between RTL8366 and RTL8365MB is more similar than what the
current drivers suggest. However, the existing rtl8366-core
abstraction does not model this in a way that can be directly reused
here. Aligning both drivers would likely require reworking that
abstraction rather than adapting the RTL8365MB implementation to fit
it.

This could be explored in the future as a separate effort as it
changes how RTL8366RB driver behave. For now, I would prefer to keep
this implementation local to RTL8365MB and then follow up with a
separate effort to reconcile both drivers and extract shared logic.
Some of that work will likely become clearer while adding RTL8367D
family support.

Regards,

Luiz

