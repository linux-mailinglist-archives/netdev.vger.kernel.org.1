Return-Path: <netdev+bounces-289542-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIPoMzybDGqUjwUAu9opvQ
	(envelope-from <netdev+bounces-289542-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:17:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE531582EE4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 19:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7B86302AECF
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF702BE7AB;
	Tue, 19 May 2026 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvPffMfA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997443F4DC1
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 17:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779210951; cv=pass; b=Tdnv/zohOd0/RhoQ1uoq/FgQ3yn7RTpGWkwIO2q+5na5GgTYsbRcCEytQwZ8xzjClyNJE+LxfyrGrNwB+slMM54zCYIW/gUW/NMvQ8nQbzKQl4s+jRLQ4gTIWxYKXNrCVrm9eYXnYDZ2Dn9Gw+tm8KNgd10dQhf+bidtEmayStE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779210951; c=relaxed/simple;
	bh=/0+dScbTUNEJGVDgwal5JUJ0gDF/D9hpkgWOKCeMMaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mjlNMs6OCBI87bkAszLvrKeti0GhrQIqYOIhGapHzZc52evj4A4bCMaXSrpaeW1hFy869H5sw3zWfYQwqybusGDTLNr0knZ3shWHWfpYGx61CqRyjAt9uwH8iHYk3e69P+VNzRnIW0pYfvRopXW7okRpQFB/0EqAwpg9oFdlTyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvPffMfA; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ba180a022dso185ad.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 10:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779210947; cv=none;
        d=google.com; s=arc-20240605;
        b=UeBDIUnbZu0Ejei2BzctsT5qqQL+3KtNCRMq/WeYN5hmcYyHxJ1+sFFcG8ETYoe7xm
         3b60VX0M6YrlefOO/R9gOfRFvs2qJ8fxqkv1K5aXmUPHVxT2zt+IS2Jqpd+euEq/Bhpz
         T3RsWILCTrB8YxFot0v3vVlcyKufuPk+nXHiX1+cmnlgoqNJKr/QlqsDqM1x+j07nlBX
         Zc/o5U/9Mg6ErDFCjvtciVSLSrrCzJ/74kSeuD/K9dGrIZKEDpzSVgFHEe3J7qTUM9Xd
         QbGnyv6SqU51/EvjRiS6sFuFxeORZjT5z1Bn15rhXqCQ5wMFBmzwiGVOrPMP6s8Aakmb
         7ORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cuQNgYy+WG+dzOE/c8QzcyHW5Fy6rAQMouLvUCWrgMI=;
        fh=ly2lPk4f3j5x8BB5OuKAC24iEg7bMCLmIAGBsad6Qrk=;
        b=XcbfdDQqtovvqwNRoBU1+w8zoeBsYFbZ64M/PVLr4P2vqomVoEstEJS5SElKsBkjkF
         l00cybbQgdi69X4TSuIJzPqgIFuct1E+JS3EtH428xZMbeAYsJTnQUMDqUZGW6szL51a
         2DXf1ND0+BLMRmp2dl79a79yYBpGVhSOETVqlamERwQp1y85f9YOIVFp5sM2SZu3iUpw
         oNpVmSg6Km4ou97jWh2T3l/rpkcBwU8GacM1oDfnHulaBMey/J9nc32rlWkOnHQo0KHi
         mdPFaoUqjUP/S1mCpIvpzoeii9sFo468fqFuXXxrTZ+gvJSIu2q6hEDasuzYlaCH/qjE
         O+cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779210947; x=1779815747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuQNgYy+WG+dzOE/c8QzcyHW5Fy6rAQMouLvUCWrgMI=;
        b=VvPffMfA5D6llYqo4gH2QjMqYLcgLEjHnR8j1/32KP+OUe9sm0zaPyXT/zr8kf9lVP
         fOR2QPJNcdTKlw5qVugw/857HMDtZxpwSCqsmGdMbhHFQg51tJhjQGgRrt3e5vaws3qz
         IXkfI1w8/M08BYrEvLNuOU4e+dhLRrtZ35HsXEVySDva0EQFrO9mcp9x8Ul/ncWK7OE+
         0P0L6OJ+xSaeuC8F0eNjifgkpbE1NxTRKMq82uzbEbAFR91CsnSIA8YD2Xy7qMu5YBCp
         CO17OoJHzWToJXeYZcrf0NpqUhmv3X+oLY5PdE9Tm6U/73rcDJi22cPt7Pyd68gn/iXb
         EE6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779210947; x=1779815747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cuQNgYy+WG+dzOE/c8QzcyHW5Fy6rAQMouLvUCWrgMI=;
        b=SflF1fdBYwGEIqQstqSaX+DFz/F67M4f2KaK0n+nVAh2u6w+83nJcoPG/7ABgVfd7/
         pcBm+lU7esFz7S+uOyJQSdI9nkRmBLpVFTS0jzM62FFcFwj5PfwI2XLIXKi6wXSstcdu
         bp8OiSOD7g0eElnQJOmINXbBeUFW0IqBIKATVeZHbECqNdRmlzVp5Q1E+f4eHM5VkEM+
         mIuqJJhBCpxPdI2ZpFozEr9AD3v6pUNhmz59kTV9LfZzSh9ZQUEdtbGHpoVHCq4jgePU
         ojhAMNCIepSZxMSF3PSFpwKeQgej+fSnQD2t5RnzWqYYBkWnQxb8Kbybwhps8J/IO1Xj
         +JrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9KWFGnbdaTXAjpvSlpYl3kyq4CokagIoH8bGVkwNNQvabrb+jDPJQOdGrRzf6OPRQkZKPJ138=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPruHyhhRrj1nNDr9wH/0uzwuLvkBarobVpRF3h2XyWtCLSdWL
	obacXMRonE0ouNo8x+esD9Xdvu4RE8od1PPxNhex3K53CjcJ4LIU/xCojPQjqkquH60+zrjrb1l
	Dpor/QuAFeCFCiAnxqhgWAhyFgJxl761Uq8GOm10C
X-Gm-Gg: Acq92OH9TwReJacbMB3swb+J2iaZ3BhhYqhfxXvEKk/ZeCgjjkU3gVwqdacf+imcaEE
	xovdjIS7mUWNREXgTuXYrmqirjeol12NAj4x84gibwh1Eza+7kjjVr9LNLxm/JxJRNQwGNAT9M2
	evSIhfz3+7QwgD2KXs/25m4NzHTbLOFMGXN2zNjLuNJ/DNfRQM+v/+L4DR3MMsd/V0ed5NDVMyj
	WXkM194m7J60Ov/+/efans/AvCjf1MNUhvOTQTMkW3FQBi+klRIcODbtns9VFzwa0uerlxCO43D
	PC0fM0cyCsOy9jqsJ1s15CAPd7FFEOkhzYZXC/AzLN9IzPQ+V8NfxdnbACatlAa53KTSFufenmD
	GxR1IdqLEA8meN7gk
X-Received: by 2002:a17:902:cf0d:b0:2b4:6529:7bae with SMTP id
 d9443c01a7336-2bdb329b56bmr6839545ad.17.1779210946312; Tue, 19 May 2026
 10:15:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518030535.1057228-1-wei.fang@nxp.com> <20260518030535.1057228-9-wei.fang@nxp.com>
In-Reply-To: <20260518030535.1057228-9-wei.fang@nxp.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 19 May 2026 10:15:34 -0700
X-Gm-Features: AVHnY4LtmoXAhWXvNiu-0-asmSu8v-CvGeSzm-1g8vS_8O9j5-ZboIjVtfmFLj4
Message-ID: <CAEAWyHfk7y691oYNmYy5W8dA8cnpwG4ejnXPssMLOUO+Ljo24g@mail.gmail.com>
Subject: Re: [PATCH v2 net 8/9] net: enetc: fix initialization order to
 prevent use of uninitialized resources
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	catalin.horghidan@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289542-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,nxp.com:email]
X-Rspamd-Queue-Id: CE531582EE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 8:09=E2=80=AFPM Wei Fang <wei.fang@nxp.com> wrote:
>
> Sashiko reported a potential issue in enetc_msg_psi_init() where the IRQ
> handler is registered before DMA resources are fully initialized [1].
>
> The current initialization sequence is:
>
>   1. request_irq(enetc_msg_psi_msix)    <- IRQ handler registered
>   2. INIT_WORK(&pf->msg_task, ...)      <- work_struct initialized
>   3. enetc_msg_alloc_mbx()              <- mailbox DMA allocated
>
> This ordering is unsafe because if a spurious interrupt or pending
> interrupt from a previous device state fires immediately after
> request_irq() returns, the registered ISR enetc_msg_psi_msix() will
> execute and unconditionally call:
>
>   schedule_work(&pf->msg_task)
>
> At this point, pf->msg_task has not been initialized by INIT_WORK(), so
> the work_struct contains garbage values in its internal linked list
> pointers (work_struct->entry). Passing an uninitialized work_struct to
> schedule_work() could corrupt the kernel's workqueue linked lists,
> potentially leading to:
>
>   - Kernel panic in __queue_work()
>   - Memory corruption in workqueue data structures
>   - System deadlock or undefined behavior
>
> Additionally, even if the work_struct were initialized, the mailbox DMA
> buffers (pf->rxmsg[]) may not yet be allocated when the work handler
> enetc_msg_task() runs, resulting in NULL pointer dereference.
>
> Fix by reordering the initialization sequence to ensure all resources are
> properly initialized before the interrupt handler can execute:
>
>   1. enetc_msg_alloc_mbx()              <- Allocate all mailboxes
>   2. INIT_WORK(&pf->msg_task, ...)      <- Initialize work first
>   3. request_irq(enetc_msg_psi_msix)    <- Register IRQ last
>   4. Configure hardware & enable MR interrupts
>
> This guarantees that when enetc_msg_psi_msix() runs:
>   - pf->msg_task is properly initialized (safe for schedule_work)
>   - pf->rxmsg[] buffers are allocated (safe for work handler access)
>   - Hardware is configured appropriately
>
> Link: https://sashiko.dev/#/patchset/20260511080805.2052495-1-wei.fang%40=
nxp.com #1
> Fixes: beb74ac878c8 ("enetc: Add vf to pf messaging support")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  .../net/ethernet/freescale/enetc/enetc_msg.c  | 35 ++++++++++---------
>  1 file changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_msg.c b/drivers/n=
et/ethernet/freescale/enetc/enetc_msg.c
> index 39f057fe85c7..a999f1e7817f 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_msg.c
> @@ -109,6 +109,15 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
>         struct enetc_si *si =3D pf->si;
>         int vector, i, err;
>
> +       for (i =3D 0; i < pf->num_vfs; i++) {
> +               err =3D enetc_msg_alloc_mbx(si, i);
> +               if (err)
> +                       goto free_mbx;
> +       }
> +
> +       /* initialize PSI mailbox */
> +       INIT_WORK(&pf->msg_task, enetc_msg_task);
> +
>         /* register message passing interrupt handler */
>         snprintf(pf->msg_int_name, sizeof(pf->msg_int_name), "%s-vfmsg",
>                  si->ndev->name);
> @@ -117,32 +126,21 @@ int enetc_msg_psi_init(struct enetc_pf *pf)
>         if (err) {
>                 dev_err(&si->pdev->dev,
>                         "PSI messaging: request_irq() failed!\n");
> -               return err;
> +               goto free_mbx;
>         }
>
>         /* set one IRQ entry for PSI message receive notification (SI int=
) */
>         enetc_wr(&si->hw, ENETC_SIMSIVR, ENETC_SI_INT_IDX);
>
> -       /* initialize PSI mailbox */
> -       INIT_WORK(&pf->msg_task, enetc_msg_task);
> -
> -       for (i =3D 0; i < pf->num_vfs; i++) {
> -               err =3D enetc_msg_alloc_mbx(si, i);
> -               if (err)
> -                       goto err_init_mbx;
> -       }
> -
>         /* enable MR interrupts */
>         enetc_msg_enable_mr_int(&si->hw);
>
>         return 0;
>
> -err_init_mbx:
> +free_mbx:
>         for (i--; i >=3D 0; i--)
>                 enetc_msg_free_mbx(si, i);
>
> -       free_irq(vector, si);
> -
>         return err;
>  }
>
> @@ -151,14 +149,17 @@ void enetc_msg_psi_free(struct enetc_pf *pf)
>         struct enetc_si *si =3D pf->si;
>         int i;
>
> +       /* disable MR interrupts */
> +       enetc_msg_disable_mr_int(&si->hw);
> +
> +       /* de-register message passing interrupt handler */
> +       free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);
> +
>         cancel_work_sync(&pf->msg_task);
>
> -       /* disable MR interrupts */
> +       /* MR interrupts may be re-enabled by workqueue */
>         enetc_msg_disable_mr_int(&si->hw);
>
>         for (i =3D 0; i < pf->num_vfs; i++)
>                 enetc_msg_free_mbx(si, i);
> -
> -       /* de-register message passing interrupt handler */
> -       free_irq(pci_irq_vector(si->pdev, ENETC_SI_INT_IDX), si);

Code looks good to me but a nit: would be good if the change here in
enetc_msg_psi_free() is also called out in the commit message.

>  }
> --
> 2.34.1
>
>

