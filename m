Return-Path: <netdev+bounces-280216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFQ0OnHE52nuAQIAu9opvQ
	(envelope-from <netdev+bounces-280216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:39:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B86D43EBA1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 20:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 461B43007498
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 18:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0019C3750C4;
	Tue, 21 Apr 2026 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEB85HuP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CF23A5E92
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 18:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776796782; cv=pass; b=ksMH+FF9Oqxmy1siM/poQNJeJVh/Ug/dU1KvriItAkGhC3W/r+7U/pa2M8rM2S5nnKJLOCOsvwFdosn2ULIR8QvYcAqRYVRNAcPEU/JOpxvuiaMa91fb9lOgcUGDUoDQalRPIJSvha9ldwxDKAkJ0E6VkPFTAlq3PWgd7jOR1Oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776796782; c=relaxed/simple;
	bh=XkUggc2YLAU4PEeLnjN+cRkW+CxfqN6FC35jAqE9Xaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9SbVHYhdgdEaRx49xDD533VkGTHd3KxrEGDagmz1qtayiL78o6nLzh7Z1mN1qsG6vD4+AjVnUoS57apR9hCk5JJ8fQJJabtL5rUmO1KqabFTA302hgcB+JtEqiQlvKn9Z6f21uL57/WpSspuA8BCAO042tzXSsqpl6LnWFwlAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEB85HuP; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6714f678bdaso7584938a12.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 11:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776796778; cv=none;
        d=google.com; s=arc-20240605;
        b=QcLfYylJX5SXLN6VVmLNS5oOlXqTADGA3Rpc46PTVuDwwpGTFFrAyYtX5ydcisHrrE
         nQ8rkCg4N47+bUghzcVcAfsyMZFtsesTEc1raI8ujI9L2jIAWe0tXAWqv5h/8TKyxbRl
         Mm5QhRORrDzZODbooyTgt7xJg4+qm4jnuWSOnriTkQ/VdIR0juTl+wPlzOdQdqiJ2Pj8
         JNFClhiMVS6N+Kp4TdzzculW6si3W4cyxlQ7rDnwGj58kc9aObsSPifBaaZkd/gGvrwv
         9aRLbvAwGMCjwX0anEXYZjJeOVZAT5t/WjrBvllGeuLKcoVcxzb2nlnTuwKCJnX9NHxb
         f+zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GL+MNg+fLay1tPgEJjKy5ape62o0vD/BhQMsEMOoPpk=;
        fh=Qk3zsSediddKkd91lT6LSMNqyOz8uQhKMnRWtNZ7Ehg=;
        b=PHGtiYSrM6KwSh1dt6iamBJyhUqnqEdsZUnnTH5kDvV975hUhnPdBTxSvK6szdyzCZ
         vx8kYoulv6ciQs3J6JF4OMvViC39jIagPUd35BcQGcvguxjhZj22jzaZOftzjUueqIMm
         Iy7cQ2FkIgHqhZZac1l33eHUAll4EFnrieHHw8uFt+TdJR41rsleeak/tathVZywFVOP
         pqc7HDr1ETMwj6acxN927595QNs0VsZaUdU7ecM6GX5FlEcw/O+YwzZ58CsWz0Ece5np
         attdhMoXWylD9ooAWg0inQ10FxjWJQPt+6GexmCN4Nm6T8IkeTuuZhge999q1LfClc/v
         t3Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776796778; x=1777401578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GL+MNg+fLay1tPgEJjKy5ape62o0vD/BhQMsEMOoPpk=;
        b=iEB85HuP5LthnsBj2E7++hKY9A1doLCAr/eAu7KltI0GIjOQ0CUIP1Le8/rMxBH8x0
         J/o82vBlnbXDwijXT1+aksPvq/ItQYE+/+hT6eOEshYzNOZfLA5fF70MAu6jYLtB6zNb
         RS9OElGt0OXQ6lyv8ANBxlqg4BdITc5W7uVn/Kik1fUGpZNN78b+H58rxMoPKJmc1N97
         95Pd+xwwDVRsK5UcYz+KMSwdtwPIWXyWNrS7wRv5HzdS6qoVf7Lc6lKLhHyx8MOPhBBV
         QKVo1GBZ43JNyqg8vqq8/7n4OsWJYjU1j8ZMUR9rLjqpNkQwMMUj7qCiMj+NBE7Mtryr
         jC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776796778; x=1777401578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GL+MNg+fLay1tPgEJjKy5ape62o0vD/BhQMsEMOoPpk=;
        b=r403DUxSq7EkBMdS7hn3Q2MLD3Zc2PlTlLlbBoIbNtK3kKu7V5awX1p6gK99GL8Akx
         uddmQLHjZ/cR69xK1vzl5Ofjgr7PCNxHnFmTgELsr0JElwyIfYby5NrDUQtX00AmXN7/
         YKNmX7mnzyoCDQP8TWQgNCTuMlTzx90fZh/GZmJJ/FFT9ktBaHDtLHK+ao6eqSPbT80e
         oUVoMxnKWvzMZxjD4nmq1lyV2/q4OEXdn9NBXTdtUWRHBaa3W2aFZBb1PaonH0AB53gN
         Y/jGDKyWLu3Mw+Ff1nVAyNgrr4e7UK48yoBsCTBA8hKpqwT45dDaCKxJAE5mGm+x8TfX
         W4aw==
X-Forwarded-Encrypted: i=1; AFNElJ9CYE6W38erErocpOoHh/8SV8+4yCfjowN5YHaL8jyem1/6L3mOQDqFf3q/g/tytqZEii8xedU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsqPLD0pDzSJQwSzwPSdS1rVnAOqQHGCkHHEaMhL/uXkX3Hykm
	tqNmStm01pC2NAYQFvH8j3dbh5h4tezkjildehZcGxTL/BPCU9XvrP79jK/gnwrKZ6nNI9PeQL/
	DZw1Y8EE+AQFvwJqGK8fTgPOEs7/CO70=
X-Gm-Gg: AeBDietolzlw98iz1YOMvYp+udjaMULffcoMjF+B4v0ZEevWCX/aqyK3JNujBC63uSw
	YbkI6SlUTPmIe4IJb01W1wGQ9nkXMoSAYEUX9uI+RaRpW+9zlix4PGCsWX938KAvynSb1U7uK/O
	c5qwm0f4fkLqxyMLBE6/kHtlBhmVC9hmfV83iElhSsAuWCaEZsM1weniCTWFGqe4KpgMQElDGZc
	rKjVybxGa+kW2y4Oue5NIkrKGn9PEvLoJslpLTPtDuToUg3zZq/+VMp7YtpBuxq3GorcSfz95xU
	vFPr9APO25rTxufqCA==
X-Received: by 2002:a05:6402:26d2:b0:66e:8ce7:5461 with SMTP id
 4fb4d7f45d1cf-672bfdc947cmr9242701a12.16.1776796778071; Tue, 21 Apr 2026
 11:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420023304.57105-1-dbgh9129@gmail.com> <20260421153338.GE651125@horms.kernel.org>
In-Reply-To: <20260421153338.GE651125@horms.kernel.org>
From: =?UTF-8?B?7LWc7Jyg7Zi4?= <dbgh9129@gmail.com>
Date: Tue, 21 Apr 2026 14:39:26 -0400
X-Gm-Features: AQROBzAz9a21Rc_4CyNlK6c2aO8-bB1aTwzpX8mJpeDNlq_57_t5J4LfnJ76O_o
Message-ID: <CACrCO_XVey7DcyAugHfcqOs=rj8j1u2=D2ervdGNONk50KrzQw@mail.gmail.com>
Subject: Re: [PATCH v1] net: liquidio: resolve VF pci_dev on demand for FLR requests
To: Simon Horman <horms@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	Kory Maincent <kory.maincent@bootlin.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org, 
	Myeonghun Pak <mhun512@gmail.com>, Ijae Kim <ae878000@gmail.com>, Taegyu Kim <tmk5904@psu.edu>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[psu.edu:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280216-lists,netdev=lfdr.de];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20251104];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,lunn.ch,google.com,bootlin.com,linux.dev,suse.com,gmail.com,psu.edu];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.622];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dbgh9129@gmail.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	TAGGED_RCPT(0.00)[netdev];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B86D43EBA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Simon,

Thanks for pointing out the correct tree target and the linker error
on net-next.
I will rework this, targeting 'net' and ensuring the necessary
functions are handled correctly.

Best regards,

On Tue, 21 Apr 2026 at 11:33, Simon Horman <horms@kernel.org> wrote:
>
> On Sun, Apr 19, 2026 at 10:33:04PM -0400, Yuho Choi wrote:
> > The PF SR-IOV enable path caches VF pci_dev pointers in
> > dpiring_to_vfpcidev_lut[] by iterating with pci_get_device(). Those
> > entries do not own a reference, because the iterator drops the previous
> > device reference on each step. The cached pointer is then dereferenced
> > later when handling OCTEON_VF_FLR_REQUEST.
> >
> > This can leave stale VF pci_dev pointers in the lookup table and makes
> > the FLR path rely on a PCI device object whose lifetime is not pinned.
> >
> > Drop the long-lived lookup table and resolve the VF pci_dev only when an
> > FLR request arrives. Use the PF's SR-IOV metadata to derive the VF's
> > bus/devfn, get a referenced pci_dev for immediate use, issue the FLR,
> > and then drop the reference.
> >
> > Fixes: ca6139ffc67ee ("liquidio CN23XX: sysfs VF config support")
> > Fixes: 8c978d059224 ("liquidio CN23XX: Mailbox support")
> > Co-developed-by: Myeonghun Pak <mhun512@gmail.com>
> > Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> > Co-developed-by: Ijae Kim <ae878000@gmail.com>
> > Signed-off-by: Ijae Kim <ae878000@gmail.com>
> > Co-developed-by: Taegyu Kim <tmk5904@psu.edu>
> > Signed-off-by: Taegyu Kim <tmk5904@psu.edu>
> > Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
>
> As this fixes code present in the net tree, it should be targeted
> at that tree, like this:
>
> Subject: [PATCH net] ...
>
> In this case the CI defaulted to the net-next tree.
> Which might be harmless. But please keep this in mind for next time.
>
> ...
>
> > diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
> > index ad685f5d0a136..b967c7928b4a7 100644
> > --- a/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
> > +++ b/drivers/net/ethernet/cavium/liquidio/octeon_mailbox.c
> > @@ -26,6 +26,29 @@
> >  #include "octeon_mailbox.h"
> >  #include "cn23xx_pf_device.h"
> >
> > +static struct pci_dev *lio_vf_pci_dev_by_qno(struct octeon_device *oct, u32 q_no)
> > +{
> > +     int vfidx, bus, devfn;
> > +
> > +     if (!oct->sriov_info.rings_per_vf)
> > +             return NULL;
> > +
> > +     if (q_no % oct->sriov_info.rings_per_vf)
> > +             return NULL;
> > +
> > +     vfidx = q_no / oct->sriov_info.rings_per_vf;
> > +     if (vfidx >= oct->sriov_info.num_vfs_alloced)
> > +             return NULL;
> > +
> > +     bus = pci_iov_virtfn_bus(oct->pci_dev, vfidx);
>
> When applied against net-next this causes a linker error with x86_64
> allmodconfig (at least) because pci_iov_virtfn_bus is not defined.
>
> > +     devfn = pci_iov_virtfn_devfn(oct->pci_dev, vfidx);
> > +     if (bus < 0 || devfn < 0)
> > +             return NULL;
> > +
> > +     return pci_get_domain_bus_and_slot(pci_domain_nr(oct->pci_dev->bus),
> > +                                        bus, devfn);
> > +}
> > +
> >  /**
> >   * octeon_mbox_read:
> >   * @mbox: Pointer mailbox
>
> --
> pw-bot: changes-requested

