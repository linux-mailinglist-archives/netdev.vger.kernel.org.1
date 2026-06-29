Return-Path: <netdev+bounces-302833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ycz7CZrkQmp9HAoAu9opvQ
	(envelope-from <netdev+bounces-302833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:33:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EE56DEE06
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:33:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ocMGAmA8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302833-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302833-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27936301D6B6
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74963B2FDF;
	Mon, 29 Jun 2026 21:33:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C14038889B
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:33:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782768790; cv=pass; b=D0dPBi7UKvfzlr0ZAnZ73eCxFYoJZ25YEdazT5RDUZFDYVm0lmtcgX6zYWT0AW7gEErlSepyu9Sim7yDnocClQYMQzhkQw/paTAKf+gHFUoPe1cJu1WnHV1WR1WCC1oXbxaWgQOUK2QbfXOha2tZ5Z3ZgtKwZUF/M/rb5l1wFrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782768790; c=relaxed/simple;
	bh=2pqAjAULSYvA4uHOrlE78AACuJZy4RooT/cKjb/cvCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DY4B7E7setRdYc25kOJQ4HE+wP2nSDW5AkNvf1EVK3ZGVY7j/DrzHMVAc1hHcWnhbllEqzWq0A8boHOZKIMy7xjYtikICrzJjb+a7O2MrYagNqiU0uej3QtofiRL9QvpaHGX2RI4CtcKl+wxE4Vy6YPUaVKgdl/uzflD8rRyQkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ocMGAmA8; arc=pass smtp.client-ip=209.85.214.175
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c9df229032so5675ad.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:33:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782768788; cv=none;
        d=google.com; s=arc-20260327;
        b=SkymLB/PE4lbcMyCuhE6IPStxHmMTqVJCr/Vzi7wm94OrW7gk9xJOopjwrPrQZHlAo
         N+NeAfY4On0jb0pv3ES4VBJEveA7BdPKl2jgDdpTuOWGKxE1j8AYe3fSPTkcHt8ljhwf
         SpYYZhudkiYhONX0DgubIbyrJVeFKg3JHpg0oZRsIFEC0tKEfOiLwfr5tKxwTDg1jePa
         VJLalXn8bgq+on5YK1QYePt6mCZ6RDvkmGAvXSkUgycGa3+k2Uh/DBqfE19qKDpPddrf
         FJYz5yXAStCgDO3fHKhynSTFzXbeLpAoxkHo8ItFF6wK6Vzdk1goLaJa5S66wMW2uYqg
         25Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o5eEJna9kFs+C7YUH74f/fYXfv/U6527r0qK59Qtang=;
        fh=SI93T//t6/cSzHahDoYUxrUAYFAy9OJD4IUhgVCO8GM=;
        b=jG8wT/jQvYXjmYurExBXljAOvW7gyXMUuaE4n4YPzlchkfLE10Z91GiC3n14kubouZ
         IqfKhA1kXo5oLibNU3h0SIzQ/JXHyNQOqFsq+g3nXG7cs1Q4pm5IRWQ1mbuF9sX4JCGs
         r1+SZ/mdZmB45Hed8nBrr7KUWt8r4NmNJ/8f9CSuPDX+efpS3O91c5ufPAs9mUuZ3ClJ
         freHi2bLN4dWf50QHBCcN13COOkI1Rckv2El9O5aXcWo0LNgJp8jQiEtGDa6Le4Fkb4c
         lj8R7/xHZETmlyP+WCHk1XGS5tIxHOD75fko034al6dGOBNOBqwS8rCHMhU84CjuaNd2
         wwgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782768788; x=1783373588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o5eEJna9kFs+C7YUH74f/fYXfv/U6527r0qK59Qtang=;
        b=ocMGAmA819VALZgEs7vyTamTW5gKjfwty8eDYqynLL45yfrvJbmdMM78FKpwbntXCd
         +M+3L5p91TGKN3V7pewl+Zq6oYOrJWiztTH1JRKwERV9am1XeUxKVPUiEYVNKKhsGAJe
         D3/QPmXNPGdFj0ruplk7RtL+mw4esqi7Aixz87guriA6LoJRl6LddZSTA0AzAf5X0cHd
         cE/tqI8yuz17NbbG87NYndwem66FY+T8YLc3/FyauEVjTsCbKwp0sPZukC6fxqg5xTCs
         w2ZRvlt7UaDAteIfRzijqABHoifyallQPVIA+MBW9mW2Nke9e5rjPeqGcMYfIoY7/fyE
         SP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782768788; x=1783373588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o5eEJna9kFs+C7YUH74f/fYXfv/U6527r0qK59Qtang=;
        b=Fk7rY5AHaBCaP/yeGEIwzkEkEqaP1+5R3x7/0LlHho7osLprC5XyNVLr6Uvx+V0QZb
         uaogPxd5Tk8ob+Gimwv7YTA0+8M6DNOVNqJctgh2fb3d5zYZzjgbfKYGp7oASJ6INJAD
         8pWpgLRBFZqKgoo0YEZQQ163oq1mQ2UszMZNdNQH4phND0wdIjgdtLS2yWPLX16nLzDF
         pyROc0x2W2TiQCVJ/IYgk6W4ajDKasCfaWX4opQm4vD4n4XzKXG2C3aQ3J7E9uAXXQM7
         uEkCC3eDIpAhdf4bJxjm6daxecwbEyGAoIg+ev8CmFIhKxmEBnJqHGixLhgsTqixNcj9
         zfzg==
X-Gm-Message-State: AOJu0YxAdfY5E2/F1MNqg31hHtLYwLjM3oar9+8bNq7cShgqZXCsPYjh
	qgO9oqAb3+OLewQOtytim2Xvhr6+l/BkrtANyrF5+827R/USHERtsiCmkpX+FJJG2Jkv87qIoHC
	al788XyYZt5CIAFVMD7mRGrVRb9vH0l0vyiEOpVFvp2D5SIedCPpdYRQNwEM=
X-Gm-Gg: AfdE7ckzwGOBouRm50pvjCIcwRX4F2pMYWiRoxiZhBL4tT2Bl1i5tSbfEVqwILdFL7Z
	xKLFLr/BJVicHgCvydrptv9FXNTjrA8tmi1RvV8ItFXkm3VgYBhluRI89F5MoxIThuD0avBek+q
	l6MSQOzuSsJtwBmFQEeyhJRfbVdRPhZeK8/h1/qvJR7slo9gSxBcENc3+nOtJZkTo/a1yjfGbQk
	0GRvMFMrjIxWSqgshwzaV4+26lZ0C9UKoY1vILnG4a2iHsN80JWF+zggwWFCBZwIhNipm7J7fPY
	CebyMoOXBttqL+HSJqQJFnYkFBPfS9HXPeSdtha8cceDF6TPe0A4Rls8lucWWcw9tNnf7kA=
X-Received: by 2002:a17:902:ea02:b0:2ba:73c3:49b0 with SMTP id
 d9443c01a7336-2ca380dab77mr153375ad.14.1782768787925; Mon, 29 Jun 2026
 14:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629200358.2626129-1-nikhil.rao@amd.com> <20260629200358.2626129-3-nikhil.rao@amd.com>
In-Reply-To: <20260629200358.2626129-3-nikhil.rao@amd.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 29 Jun 2026 14:32:55 -0700
X-Gm-Features: AVVi8Ce06WeW3wPZTsbCk5k2FW1tTIekWx1t_nWbi1vVhu1DMYYrtuaeHW2GEdA
Message-ID: <CAEAWyHcS7bi-wPEMQ38U+BLrnSJevHm6eDYQBp4n7omvHRPgeA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] pds_core: fix use-after-free on workqueue
 during remove
To: "Nikhil P. Rao" <nikhil.rao@amd.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, brett.creeley@amd.com, 
	eric.joyner@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302833-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 72EE56DEE06

On Mon, Jun 29, 2026 at 1:04=E2=80=AFPM Nikhil P. Rao <nikhil.rao@amd.com> =
wrote:
>
> In pdsc_remove(), the workqueue is destroyed before pdsc_teardown()
> is called. This ordering allows two paths to queue work on the
> destroyed workqueue:
>
> 1. If pdsc_teardown() -> pdsc_devcmd_reset() times out, the error
>    path in pdsc_devcmd_locked() queues health_work.
>
> 2. A NotifyQ event can trigger the ISR and queue work before free_irq()
>    is called in pdsc_teardown().
>
> Fix problem 1 by moving destroy_workqueue() after pdsc_teardown(),
> ensuring the workqueue exists when health_work may be queued during
> teardown.
>
> Fix problem 2 by adding cancel_work_sync() in pdsc_qcq_free() after
> free_irq(). This ensures no new ISR can queue work, and any
> already-queued work is drained before freeing the qcq. Work draining
> during teardown may race with intx becoming invalid, so skip returning
> interrupt credits if intx is no longer assigned.
>
> Also change pdsc_core_uninit() to free adminqcq before notifyqcq,
> since adminqcq's work accesses notifyqcq via pdsc_process_notifyq().
> This ensures notifyqcq remains valid while adminqcq's work drains.

Code LGTM but wonder if this change could be split into a separate patch.

>
> Fixes: 01ba61b55b20 ("pds_core: Add adminq processing and commands")
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
> ---
>  drivers/net/ethernet/amd/pds_core/adminq.c | 15 +++++++++++----
>  drivers/net/ethernet/amd/pds_core/core.c   | 14 ++++++++++----
>  drivers/net/ethernet/amd/pds_core/main.c   |  5 +++--
>  3 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/amd/pds_core/adminq.c b/drivers/net/eth=
ernet/amd/pds_core/adminq.c
> index 097bb092bdb8..c0d9b7e6b8c3 100644
> --- a/drivers/net/ethernet/amd/pds_core/adminq.c
> +++ b/drivers/net/ethernet/amd/pds_core/adminq.c
> @@ -77,6 +77,7 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
>         unsigned long irqflags;
>         int nq_work =3D 0;
>         int aq_work =3D 0;
> +       int intx;
>
>         /* Don't process AdminQ when it's not up */
>         if (!pdsc_adminq_inc_if_up(pdsc)) {
> @@ -121,10 +122,16 @@ void pdsc_process_adminq(struct pdsc_qcq *qcq)
>         qcq->accum_work +=3D aq_work;
>
>  credits:
> -       /* Return the interrupt credits, one for each completion */
> -       pds_core_intr_credits(&pdsc->intr_ctrl[qcq->intx],
> -                             nq_work + aq_work,
> -                             PDS_CORE_INTR_CRED_REARM);
> +       /* Return the interrupt credits, one for each completion.
> +        * Use READ_ONCE to get a single consistent copy of intx since it=
 can
> +        * be set to PDS_CORE_INTR_INDEX_NOT_ASSIGNED concurrently during
> +        * teardown, and skip the credits if so.
> +        */
> +       intx =3D READ_ONCE(qcq->intx);
> +       if (intx !=3D PDS_CORE_INTR_INDEX_NOT_ASSIGNED)
> +               pds_core_intr_credits(&pdsc->intr_ctrl[intx],
> +                                     nq_work + aq_work,
> +                                     PDS_CORE_INTR_CRED_REARM);
>         refcount_dec(&pdsc->adminq_refcnt);
>  }
>
> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ether=
net/amd/pds_core/core.c
> index 1074a022a52f..570c0cd7339e 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -110,7 +110,8 @@ static void pdsc_qcq_intr_free(struct pdsc *pdsc, str=
uct pdsc_qcq *qcq)
>                 return;
>
>         pdsc_intr_free(pdsc, qcq->intx);
> -       qcq->intx =3D PDS_CORE_INTR_INDEX_NOT_ASSIGNED;
> +       /* Pairs with READ_ONCE in pdsc_process_adminq() */
> +       WRITE_ONCE(qcq->intx, PDS_CORE_INTR_INDEX_NOT_ASSIGNED);
>  }
>
>  static int pdsc_qcq_intr_alloc(struct pdsc *pdsc, struct pdsc_qcq *qcq)
> @@ -145,6 +146,10 @@ void pdsc_qcq_free(struct pdsc *pdsc, struct pdsc_qc=
q *qcq)
>
>         pdsc_qcq_intr_free(pdsc, qcq);
>
> +       /* Drain any work queued by ISR before it was freed above */
> +       if (qcq->work.func)
> +               cancel_work_sync(&qcq->work);
> +
>         if (qcq->q_base)
>                 dma_free_coherent(dev, qcq->q_size,
>                                   qcq->q_base, qcq->q_base_pa);
> @@ -304,8 +309,11 @@ int pdsc_qcq_alloc(struct pdsc *pdsc, unsigned int t=
ype, unsigned int index,
>
>  static void pdsc_core_uninit(struct pdsc *pdsc)
>  {
> -       pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
> +       /* Free adminqcq first: its work accesses notifyqcq, so we must
> +        * disable its IRQ and drain its work before freeing notifyqcq.
> +        */
>         pdsc_qcq_free(pdsc, &pdsc->adminqcq);
> +       pdsc_qcq_free(pdsc, &pdsc->notifyqcq);
>
>         if (pdsc->kern_dbpage) {
>                 iounmap(pdsc->kern_dbpage);
> @@ -479,8 +487,6 @@ void pdsc_teardown(struct pdsc *pdsc, bool removing)
>  {
>         if (!pdsc->pdev->is_virtfn)
>                 pdsc_devcmd_reset(pdsc);
> -       if (pdsc->adminqcq.work.func)
> -               cancel_work_sync(&pdsc->adminqcq.work);
>
>         pci_clear_master(pdsc->pdev);
>
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ether=
net/amd/pds_core/main.c
> index 22db78343eb0..638b9c7a509d 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -435,8 +435,6 @@ static void pdsc_remove(struct pci_dev *pdev)
>                 pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>
>                 timer_shutdown_sync(&pdsc->wdtimer);
> -               if (pdsc->wq)
> -                       destroy_workqueue(pdsc->wq);
>
>                 mutex_lock(&pdsc->config_lock);
>                 set_bit(PDSC_S_STOPPING_DRIVER, &pdsc->state);
> @@ -444,6 +442,9 @@ static void pdsc_remove(struct pci_dev *pdev)
>                 pdsc_stop(pdsc);
>                 pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
>                 mutex_unlock(&pdsc->config_lock);
> +
> +               if (pdsc->wq)
> +                       destroy_workqueue(pdsc->wq);
>                 mutex_destroy(&pdsc->config_lock);
>                 mutex_destroy(&pdsc->devcmd_lock);
>
> --
> 2.43.0
>
>

