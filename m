Return-Path: <netdev+bounces-294280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5sW8ICv8HmocbwAAu9opvQ
	(envelope-from <netdev+bounces-294280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:52:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C4662FFB8
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 17:52:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=e73MyjNE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294280-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294280-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D49D3007BBE
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04BA3F1ACE;
	Tue,  2 Jun 2026 15:50:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437A3EDAD8
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 15:50:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415414; cv=pass; b=SUCjz6vFBQZ0osxJpX5xFKppebNxXm22PYpZ8O7CKqJCrtYF15s/DvWClysz/EvamWpU454HoYu+r9F+JT583h/YDm6nzOFiqtzJ5/LFEeSl6uFlBMK3gXJB9a9p1YCEC+nCx6AjbIQYiW56EW7S82DqIw6JQ81nuva6OtOSJ+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415414; c=relaxed/simple;
	bh=XOnGwjMx91iBauduKCMlw4rFAouak06v92SQM8h7hmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yncwot612SOtnBPV5j/Vi6RZwuFEHg/HVbfv0PhtgTPhl6fJAE36TulWXY2+8zBQu4xjH+2606Lz6bcP1dxEBVCiIN+RL9kz90/I8bKVFUuhuR9RHMj8DYQGV1/nx4UwA1r5xrYjbSkKOuL+jAWg1/eGRK1Rrm86vwudqhA0wI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e73MyjNE; arc=pass smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6896c54a7easo80435a12.3
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 08:50:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780415411; cv=none;
        d=google.com; s=arc-20240605;
        b=kZJQFJFVyWtMeOrqYTvtRaw/qxwsYnWCsJ0nvn0iV1/UCizRjfS2CzlxW6Zn+j4j7U
         JRDd4AFI+8hRNPRN2ndTJV4gol5DoWYb9p0mGmDh0CvFjt45D0oRaH6euvK3hdhzY/Aq
         SDKDllAVItJ1NTiCMRIRdBzKoSGT6xYyQry1rIq7BDMCHd1FvQTfNu9hQnVzrhzwbkXn
         D4eq8sJ5leFpdB/9+fGVj7D1MMQ43cYtY7mDuGE7uh2c89EzLA+bOq67ZU9JbQO4vHUI
         obqyt722YNCXkQ2ZSjC945HBkLCVu8eNehTqKh8sQQokVfP2V3RhbMolnGzEoQ4/VDyv
         nYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MkED1IgZW+Wv3qyfFPo5J1tct5Sxg+vtS8DaiME5OlE=;
        fh=ISEQjLhWKSsnFfRXMBsarCFMEmsSlc9xQYxlySfjwV0=;
        b=kPGO0PYykqlYw+uVwFaOgBVoB6mVy+IB6ea56poECVEWYzFczCCDmHkang5SeLsw7W
         aFlLvSYmLgVakN53Tmt2+MX4EScIwtqrVvjl88QLrUySAn34aasWhxgMcwlL5EEISeHz
         NX5yHSu5ynMVLWobwMxOLscL5j+/ALgceV37wSypyAIBy0IaooWBgWkI/Z1ZdpgsdBpP
         ILEjZkKAs20L7Wb8GUphH/uK82uVPVivZMxEnRggqeZSz9VLfsHKABtQsRyUFS6v4JEI
         Y3lK60TOe23rNaQlzKZsYopX0+K94PoWkWTFkgqi40MbszBdFizCm00Zbuo5TzjW6scr
         4gAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780415411; x=1781020211; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MkED1IgZW+Wv3qyfFPo5J1tct5Sxg+vtS8DaiME5OlE=;
        b=e73MyjNEdYk54BKLg0K0IX+nblABBntSzCuYv9o/k4d+kVvv+bpeZMorxDwEwebpCB
         zni5hvC3VtDhIPeklm5Em2rVWm+tY5A99CnFqqkMe2DDxN/INPr8akG8HwTjNhpdZIYN
         4DBA+8hy7/AmS8cOyX9MUnKwbIuBbToxUq7KFRDdIEFeHrT7VJrWRVUt7F7D8SYN+LqX
         quFEN5A9VFUWIS5CsFrILVm4dmXQfO/A53AOOpTyFLvyYnyex3NBYkpmcUnBBbgOzxIc
         YDOpLf6ZTQcsLJn+WUiLy7a9s4B3YFN3S0s8DTSMYzGqrkN823D1jpVtMGFdkTX9wNaT
         L4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415411; x=1781020211;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkED1IgZW+Wv3qyfFPo5J1tct5Sxg+vtS8DaiME5OlE=;
        b=nl1S06oof0bboBtBXm2HVzGsFXxXFcfSZD0+A5iNn9EFHSQdq2DWo8H5UiPYuOEX2Y
         vit5rYbiPZOy0xOw2CeGVZ+l6sxzKx7GfZDocEDPHLdLgVdUC/m1E8lesp0i1mb+p7/t
         JVLViiX7qFOyfGYywpMlG7/4rIPueHdHLbq3AddgB/MJw9uJ0hTo17OY/Tbh+UHkneqw
         EcgPeBQSgLhNfDtV6/MATYnqzqeI+X2uL+8phkNc+HIMINt//OgEPW2CdHRprBHw+hBn
         UXswYLZq1T4jPc9jiK9XlZmtoRC58+vwioc8pJeLX+eqBPVnYV7gTr3/re5OhkG8Esob
         EGqg==
X-Forwarded-Encrypted: i=1; AFNElJ/HnBctLTDYuVDRqi7it8ZOsMWmBymjDm9ZX1pdt/qNHjUYYYjfGpCWTul9Mg5GyugqxRUcF8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYfPCxsk+n33yFqOb8J6607lPsPNPJomkcrYtsb3R/tjd8xt94
	t5m8r5XwVMVk3fvg+nmKLIjQqYjDABK7iLkmkJCBwkK/8KFdT8o6ofEOzNLgGP8DAPoDBSNjEeB
	/ZfWydOstwo4c+6F/EMo7AuwK3jej0s0=
X-Gm-Gg: Acq92OGEQjBb17cWmJAKn/ZWhv+kQ+qmD7xeIL/u+SyT+Lf93Zvalc+gvE9MgV9F36b
	EMJxIwRP+IT0OXhQEPzb+Qcdg3O/pFkrY2mQtCWucLa0Nagv45AbXh6XtJCB5zc9FFa0lAuhrDH
	KSbacP55+WZPdhWFlZt/izRonN7nV2jTPwbQZz3GKjZ4+erbeg4Fpkv1APa7zSwPiauYT2mg7ML
	wN3nm2dsUXrfOTM2n+uAWAmA1HS3VBgPSDyrRuHujBufsNL7raxsNk8MPBh5hQvflwt0Q8eCE5D
	dqdi3b4S0XA6UV6z7g==
X-Received: by 2002:a05:6402:3906:b0:683:edf6:3461 with SMTP id
 4fb4d7f45d1cf-68e5db44372mr191815a12.18.1780415410941; Tue, 02 Jun 2026
 08:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529052333.1665989-1-dbgh9129@gmail.com> <20260601190237.76d7d47c@kernel.org>
In-Reply-To: <20260601190237.76d7d47c@kernel.org>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Tue, 2 Jun 2026 11:49:59 -0400
X-Gm-Features: AVHnY4Ib7chsj52pmDO5UDJKaDJMC8on7TXbAzFt1moon316MTfAxQ0Gbkk1GQA
Message-ID: <CACrCO_VPYjvM4zMsxez6Uip5REPLqHhTExiUsgOPYXMo=ASTPA@mail.gmail.com>
Subject: Re: [PATCH v1] octeontx2-af: Fix PCI device reference leaks in debugfs
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:sgoutham@marvell.com,m:lcherian@marvell.com,m:gakula@marvell.com,m:hkelam@marvell.com,m:sbhatta@marvell.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294280-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56C4662FFB8

Thanks for your time to review.

On Mon, 1 Jun 2026 at 22:02, Jakub Kicinski <kuba@kernel.org> wrote:

> Looks like cgx struct has a pointer to the pci dev.
> Can we use that instead?

I looked into that. While struct cgx does contain a pdev pointer, it
points to the CGX/RPM PCI device rather than the RVU AF device.

Its driver data is struct cgx, as cgx_probe() does:

    cgx->pdev = pdev;
    pci_set_drvdata(pdev, cgx);

The debugfs callbacks here need the RVU AF private data (struct rvu) for
rvu_cgx_nix_cuml_stats(), cgxlmac_to_pf(), and rvu->fwdat. Therefore
calling pci_get_drvdata(cgx->pdev) would return struct cgx rather than
struct rvu.

Unless I'm missing another path to reach the AF device from struct cgx,
it seems we still need to obtain the RVU AF pdev before calling
pci_get_drvdata().

> When you repost please add net-next to the subject:
>
> [PATCH net-next v2] octeontx2-af: Fix ...
>
> and make sure you base the change on the net-next tree
> For some reason our CI wasn't able to ingest this change.

Understood. I'll apply this for v2.

