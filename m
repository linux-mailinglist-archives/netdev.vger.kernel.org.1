Return-Path: <netdev+bounces-282331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJUvFffZ8WmLkwEAu9opvQ
	(envelope-from <netdev+bounces-282331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:14:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 46944492B40
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 12:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A03D3011115
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4231A3CA4AB;
	Wed, 29 Apr 2026 10:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ek3KlBxT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08F13B27CA
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777457634; cv=pass; b=ISFXyxLPUpfNc4lp7Rl3QtqfMBn4sZFp3+6I5om/IF7II1RIfGkHVLjf+wleEeUmBaSNjv7QEPCexiVGRDUNMiJPZaacHVuqstDRyFo4RqI+d5UJzRP6C1eQfYjtKekn84ngeKqdctfofQgcOMzT+qecmG0NF2Q+tp78KEw12kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777457634; c=relaxed/simple;
	bh=fo4EiBwhV8mhP4Rm6q+hItF/pD/17eREaDJbCWs6gqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfxZNKOYne12ZeQASNzp6FjEugdXCtEsTm55lrcbfDxZeNuw7DqJRS3UHuTqXex7GT3Atx+P6RXFMd+Cymmq/DeoVnb2ZGG5nf1dW8RE1KJy5B7dkcwt89vcW82v9u3qOyZ7MZLLFpVgjDvEZGxVJSR4FPeNqfRC/fz9o50FDVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ek3KlBxT; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79ea87af213so11237877b3.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 03:13:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777457632; cv=none;
        d=google.com; s=arc-20240605;
        b=JIVCBEvOQF0LIgK2nZpS88ffDrKoslsIDysHpOx6CkXzWXUUEq9c/bblN0kvGULAZx
         FFgXA5jAizKRcrS/rjTXSztz5cvFfQ5viOsUHj4bKcFTGeS806hYabSSc7q/kEyW6pm9
         AVH/Qiu1cF3Xd4aAyChGtXLmw711c93iKXgM2vfUbwrZAvEvmvuH+vfeXZeidJTsFjXo
         j2I2uAgDwQkvdg2lRpLfdBuryGqoXibJr2e13/RIqVprrZGBbkVfYID9Dk7P2rO0kGq4
         ra5TVuN2tgYKHvZ7Z0hpThslMU3lMDKf/7soh6n/sYKINX1vsSKWG1NQOpjncxA7gJMu
         MBKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Fa95ogoQhE0p2rwPNbDEnCdMgoBzvOVValx4cHcuhpg=;
        fh=AZkt1LcwpUx73tt1wYvAnEHKhwAsLO7i9dxveBzLIbs=;
        b=ceCff92DD98rql2h6djcAS9g602tEcGBMzgnphx4ARwAOdzuWUX8I6yYKHPG+jR1RR
         Vq0i6N2KO/xRdtiARSxdC8EY21DRfeziQRoBIeiNqu1f2sgHxvbyViE9VitNjtru6DaN
         DZevYKRZ90Fh3vTQ/xZ9Fid8l+eZqeRbIcFGiQFaKHvui4BgEkLNDhaCKwWFUjxnY0gs
         xrXwHFqr4w5QaFm3ixLhXgq1zVnCiggqSFAePyMRqQjumhzcZHB8rdgJ6mVMyKwSZkdo
         Lm+7HRUd4VAVZpixw0bpEQAbaZJL9Vq1DXEShKM7MC9j73BQNv0ZJWO/7dxf8J96lyaR
         36Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777457632; x=1778062432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fa95ogoQhE0p2rwPNbDEnCdMgoBzvOVValx4cHcuhpg=;
        b=Ek3KlBxTqkgWUcEVdeWYv70SBAyPrkePW9OKWP3V029suKOCL/7CpGa67sMRgz1Ye2
         aESqi7zPIMB/RqfWOXhAVExWf1nJz4FawzEyaAaO0Sg73Srk6aELJiP5dQSirwtpO/28
         gf/2aSJvgFjcxMMIGK2ikbYkXGlUe5WYej2rjPVotfUqkuJeORkwsVn8Ap7tX9cxQAH/
         50IlT0+XhFE8xBNmC4nT5lZFUsoXcUXbaoprvnyjhZnE1jq3J1VwxE5C00StphVMktoX
         sJz1qlWy6RhfZL/FaRIQXNMEMb3I+tR9cWMjb1Ikhfodd+WVCoWvG75L5ltDjlu4PsXw
         fiVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777457632; x=1778062432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Fa95ogoQhE0p2rwPNbDEnCdMgoBzvOVValx4cHcuhpg=;
        b=pwb9E68U7VTmkOrTOa+kOJPat3x+ebpwxPwIhwZR917EEgr/erhiwe0848gLZqniln
         tVBrU3Sk7+H+0XB3qGK9utxDkdb0R0bn0O8y5MJkr73E73aOgX/jhKRqfHxYAwcGhato
         tKQYyvi9VyB2cBi114cIxDVBrOykgMSHvsqvyUwQdSDhVHHviLvmeduDb5d8HUiHRlv2
         Rboiax7V8SICOvT79kueC0MajHmc5HhsPn3XEvopocvF7OeM5vp25PguXp3whFAo8igP
         f5Dr7WcnfzLyKq9/VvnRi8aQuQwsg25y5Lk+j03b3yRQIHjQytTzRxmD9R4cYIk5fPQr
         g93Q==
X-Gm-Message-State: AOJu0YyZ6zgnD9YHdcoW92uaaV6V5uO56rkw9ImrXrj4OKFOe7TKjmrI
	JiYh0yWBv5DylKRSMOY0nTZELSxPwRpzGSzcfSjdwPlEkFj5MG3btkY9/NRXBW5iKk0bT58HWtD
	y/aPrYG9gj8LSzuCHhZkdKffPwUzM3Io=
X-Gm-Gg: AeBDietBzout6CHiX96EbLzohG2KrUmYo+tLvZ5PPYdWQwY5W8k3CcdsUv4WH0IWOdy
	BqQWgJrS8jSWAqntjyP5nTcsSftLYY8L8MVL1xlANRHHOLsS9v0qVN3ki1uXKv2qFoSjPN1NiFY
	Ff1IFkXILwEq+S9H/QRkupB9L3dxjnt5MctNu9ib7DInwrVNQgwFB3GmonQo5tZx1U79cHvHHKE
	EqAlWzTGCiIw+YmnSB6koet31RxNcWBUDhevE37sSEySTVa1aOlug+eEQqTXrV2Yih88QIGk+B7
	GHZjio4yxUwHaHq+IB/b
X-Received: by 2002:a05:690c:6610:b0:7b4:6f40:639 with SMTP id
 00721157ae682-7bd26720337mr16777347b3.17.1777457631842; Wed, 29 Apr 2026
 03:13:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGp+u1bdbe_5Xk6icnDcs70Krbr_6M4yXjhs0HVo8T4953wNSQ@mail.gmail.com>
 <345650f0-6da6-447c-9b27-0bbefca0558f@nvidia.com>
In-Reply-To: <345650f0-6da6-447c-9b27-0bbefca0558f@nvidia.com>
From: Ginger <ginger.jzllee@gmail.com>
Date: Wed, 29 Apr 2026 18:13:40 +0800
X-Gm-Features: AVHnY4J9YPIXW1V1o8KG2ZjCXSkwqVGDgNnMcU7TMaiMF703EkjM0JeyOrbdcFQ
Message-ID: <CAGp+u1baSuC9z9rGkJR0v1+eBW==9ppxh7tSn19jJOA9bX1Ycg@mail.gmail.com>
Subject: Re: [bug report] Potential refcounting
To: Tariq Toukan <tariqt@nvidia.com>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	ttoukan.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 46944492B40
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282331-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi Tariq,

Thank you for your prompt and detailed response. I agree with your
point that calling refcount_dec_and_test() is safe.
However, the major concern of the original report is that whether
simply calling 'refcount_inc()' is safe in 'mlx4_add_cq_to_tasklet()':

T0:
if during a tasklet callback calling 'mlx4_cq_tasklet_cb', a destroy
verb arrives, which eventually leads to 'mlx4_cq_free()'. Both
functions can decrement the 'cq->refcount' and potentially enable
cq->free.

T1:
irq fires --> mlx4_cq_completion --> mlx4_add_cq_to_tasklet -->
refcount_inc(). Here, the refcount increment does not check whether it
has been zeroed in T0.

Side note: to see if T1 (i.e., IRQ) can fire, I checked the calling
path to 'mlx4_cq_free' and only 'synchronize_irq()' is seen, but not
'disable_irq()'. It means that T1 may still happen after T0 calls
'mlx4_cq_free()'.

Is the above race possible? IMHO, perhaps it would better to change
'refcount_inc()' to something like 'refcount_inc_not_zero()' if the
race may happen.


Best regards,
Ginger

On Wed, Apr 29, 2026 at 4:36=E2=80=AFPM Tariq Toukan <tariqt@nvidia.com> wr=
ote:
>
>
>
> On 27/04/2026 5:07, Ginger wrote:
> > Dear Linux kernel maintainers,
> >
> > My research-based static analyzer found a potential
> > refcounting/atomicity bug within the
> > 'drivers/net/ethernet/mellanox/mlx4' subsystem, more specifically, in
> > 'drivers/net/ethernet/mellanox/mlx4/cq.c'.
> >
> > Kernel version: long-term kernel v6.18.9
> >
> > Potential concurrent triggering executions:
> > T0:
> > mlx4_cq_tasklet_cb
> >       --> if (refcount_dec_and_test(&mcq->refcount))
> >       --> complete(&mcq->free)
> >
> > T1:
> > mlx4_cq_completion
> >      --> cq->comp(cq);
> >          --> mlx4_add_cq_to_tasklet(struct mlx4_cq *cq)
> >              --> spin_lock_irqsave(&tasklet_ctx->lock, flags);
> >              --> refcount_inc(&cq->refcount);
> >              --> spin_unlock_irqrestore(&tasklet_ctx->lock, flags);
> >
> > In T1, the refcounting increment on 'cq->refcount)', although within
> > the protection range of the 'tasklet_ctx->locl', is not synchronized
> > against T0 because 'refcount_inc()' does not check whether the
> > refcount has reached zero in T0. This case is potentially problematic
> > because T0 decrements he 'mcq->refcount' and can enable the
> > 'mlx4_cq_free()' to proceed.
> >
> > Thank you for your time and consideration.
> >
> > Best regards,
> > Ginger
> >
>
> Hi,
>
> Thanks for your report.
>
> IMO the described race is impossible.
>
> CQs that work with mlx4_add_cq_to_tasklet as their comp() callback (i.e.
> T1) are added to the relevant list only after refcount is incremented.
>
> Hence, if a CQ exists in the list in T0, it necessarily means that
> refcount is already elevated, and calling refcount_dec_and_test is safe.
>
> Regards,
> Tariq

