Return-Path: <netdev+bounces-302832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kE2yIR7kQmokHAoAu9opvQ
	(envelope-from <netdev+bounces-302832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:31:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BABF56DEDF2
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:31:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=tLTXHC82;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302832-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302832-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4AD76301ABB9
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C516C38F941;
	Mon, 29 Jun 2026 21:31:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AA215E5BB
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:31:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782768667; cv=pass; b=pVcqYCmDMHWg28QA40OJjYXhVNBOYmqmGc7CYpnAeE7Ge30jpzjg051s6yu5aJ3Pspx43/2PQAkwu25FYrnbdvA15ve6nx1XXzqfQAzfAuUMOrYXq5PQCD/i4Q6oyPTAxkpGHNvHcOryqSbkH/n5x2VoyIw+7ijwGrBykowlohY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782768667; c=relaxed/simple;
	bh=8pL66crEUS7E0/nWYUh26YLtuI6rajdVZIl/JJS1wKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHYlqJCKl9jNWPlVlWEpI6TmbYT20Hu92a8//fH8XHgZpzK6j3d2kAo3dT55ggkp65CYmOp6IZ5dCIpMCXLDqk+MuJTI5iChmfKYvhiqc7xRYAf7rqWHMmri/nGft87cSQYT7o4Vt0cx63W0A0tra4kHPWg2/airUAo1V2HrBwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tLTXHC82; arc=pass smtp.client-ip=209.85.214.171
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9df229032so5625ad.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 14:31:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782768666; cv=none;
        d=google.com; s=arc-20260327;
        b=jPfwgrF0/RJXhg+0YjjnEJUQk/+8j3uGCgAeukHQr8IwoUeR0LzsrvT1NLdYbcR9Pc
         3kSA3wSySnsIizk2XV2tj79vQErz7pEOBW/7SH+YaDdFzhdTAwg5TmgsNy1thZCuO7MA
         RtNxsF6eW5QZKliz5u8fXeHrLXq55pSmHm8+MyEQ4v7TQmP8+/pAV+mFotwCew9UVqIv
         304Sovbv6ypB1CDnnFG4RHFvUvrmI1n4ZSX6j9g7JIrO0QUF501jcApOwe8QVzLBt6GZ
         QPzkQBMs3rl7QgIMYJcDNkt/f5tZLtl567Gc9vpFG6U5vNGNJUnXKl4X+o0SGwxbXBt+
         aufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7Drz2eBjAK3C2G/BX+xSxb3d2jWMNTSgIvyLfdObPtk=;
        fh=SI93T//t6/cSzHahDoYUxrUAYFAy9OJD4IUhgVCO8GM=;
        b=hLL4Y0IiNDgl14/T0rgV38LvpHQP83C9H5GLshc6eV+CGY48VIofqgAAjm3YyXtXD7
         EnSpnGEKIpONWBR50M6HyOSqSrQwQoeI/YGQsGiYLyJCWtByEP8i91IynKG9iEy5A3lM
         f6Qst62Adu+n29R2AU0fIHDo1T7KnwFzt223ugMek0JwP+o+xO4LCFbaCy+crALFYZr+
         cPzBdpp1O+5tOqPTQVoSDF54jA87FcurbUmP6HHd7WxjQsC4Phr0o77YipE5ixAdP9XP
         5M/O6PFWFGPnSsQs6Zc05AvWIFyWyOcs2cR7PbuV7jdoHA/IRCGw9Bz2hu7AcE75DXMd
         tp0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782768666; x=1783373466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Drz2eBjAK3C2G/BX+xSxb3d2jWMNTSgIvyLfdObPtk=;
        b=tLTXHC82tpGLat/X9CH3E8WEEboi2YXTJgy/ifqTIUuuK29MYD6vd88rpUW3gMYAqb
         i2OUyFx+Tl1knbiZggSSrVUGodoYi9rqvAz5AY5NTIGnFMAMvWHdffjrcEJ99jxvQlWU
         AaASocRTOWntOrJwSITyao/OWBBGLdAJe4N9ERM5SwqbgKZgY3+kGj1Rvfyg9mUzH7vy
         ZI2VCFPzPGSwQbq5W8PYtmoItHjWCL3awbbIZNrzngwCkrEXpYgOl0y32GKsOi1TIgvG
         jqYd7m7f1sNId4nq66vpCigV/0U6VkMGvmyVG4GXhIPAESP+4Nz0UM4SHERbwHntHr1v
         D2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782768666; x=1783373466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Drz2eBjAK3C2G/BX+xSxb3d2jWMNTSgIvyLfdObPtk=;
        b=qh1HHQp/KXCGxsbIffdF7IVRCOyaZdbqJz7+mWc9wvTEeFq1OZSWpF3jYbPiaJH+dF
         xSou6W2dBCajFmGl3avFVnxCAl4WJZm/Ox6PMYgsl7EaQbuxnfOgs/5dpuhjsBVI27e+
         8NSFm2zbbmYos9LeyekLtBko7B5pXDaHCfTz6ttNjQfroUR5a4zS1z5g1piGvCAKDuxt
         8Ck4C7Qbl3HMHsAD5q477QKTHJqKfz4uxzUQP4eSrpAi9zVCTWLSWk0x4XtzRWdy69AH
         lra1r8yNBctNchzuKfT5HuDu/pRNnZfyYBZ5hDG6KNz6Rj5k4W8ubwoYais4wcxA7iHC
         W/eg==
X-Gm-Message-State: AOJu0Yy5GBoaQC//Y1S1x/EJtVg1cs3Grqkv7ttz810sy79A2jkaeJuq
	2NfYkyKiAv13g05Jn3LohaDtlVk343zkiQIvjjiOknUMwTewDO1R8tRaUmpS+l8cqUTMGJ0OwKL
	amIvomclf8B5SIFBoA/BTuu0pn68n2D2J7fSWqvKg
X-Gm-Gg: AfdE7clP7LUTTC1thzqrGIUZRPCreTNIgDFb5G2W/8loV3hkAg9Gm9k4J24hXwQ5FKI
	S5OmbMwLr+2BOjanVFFFjJvmm/vmdVzE1Okk0aLlsidtLFBY3nGyMwJx8CpaxCAJMKgqSvI0R2S
	oLf5l8Tb24K28vt/g3+fBAlRnrCbSEzABcmeVrlryJ6ra7BrwwfpKAASYTSd/n3cCOrMtg43kvc
	KxA8G9+470qE43liORnH24BfXQ2tUECXKf/mhRuyhk3vBaUwmdCzryk4fZg8Su+PCGx8qBKAVBd
	Wbtt7SvxbI+CXkaDpUS6J/pNsOBedmhH8r6Q7BNWnopLccIpkkzrR5YdIOpn+EybD5iWIAc=
X-Received: by 2002:a17:902:e887:b0:2c7:f688:f22d with SMTP id
 d9443c01a7336-2ca382bc6a6mr122985ad.17.1782768665106; Mon, 29 Jun 2026
 14:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629200358.2626129-1-nikhil.rao@amd.com> <20260629200358.2626129-2-nikhil.rao@amd.com>
In-Reply-To: <20260629200358.2626129-2-nikhil.rao@amd.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Mon, 29 Jun 2026 14:30:53 -0700
X-Gm-Features: AVVi8CewDHknKQT8diG9FuHoZzkjGEbRmYu_APhg5pR9EBvlgSfqn059XKGamxY
Message-ID: <CAEAWyHfjTpg8i7uWK=3zgyE0LdYzpx0aWMJ+0jBhABun6zJPeg@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] pds_core: fix deadlock between reset thread
 and remove
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302832-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhil.rao@amd.com,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BABF56DEDF2

On Mon, Jun 29, 2026 at 1:04=E2=80=AFPM Nikhil P. Rao <nikhil.rao@amd.com> =
wrote:
>
> pci_reset_function() acquires device_lock before performing the reset.
> pdsc_remove() is called by the PCI core with device_lock already held.
> If pdsc_pci_reset_thread() is running when pdsc_remove() is called,
> destroy_workqueue() will block waiting for the work to complete, while
> the work is blocked waiting for device_lock - deadlock.
>
> Use pci_try_reset_function() which uses pci_dev_trylock() internally.
> This acquires both the device lock and the PCI config access lock
> without blocking - if either lock is contended, it returns -EAGAIN
> immediately. This avoids the deadlock while also ensuring proper
> config space access serialization during the reset.
>
> The pci_dev_get/put calls are also removed as they were unnecessary -
> the driver-owned workqueue is destroyed in pdsc_remove(), guaranteeing
> the work completes before remove returns. The PCI core holds its
> reference to pci_dev throughout the entire unbind sequence.
>
> Fixes: 81665adf25d2 ("pds_core: Fix pdsc_check_pci_health function to use=
 work thread")
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>

> ---
>  drivers/net/ethernet/amd/pds_core/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ether=
net/amd/pds_core/core.c
> index 38a2446571af..1074a022a52f 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -606,9 +606,10 @@ void pdsc_pci_reset_thread(struct work_struct *work)
>         struct pdsc *pdsc =3D container_of(work, struct pdsc, pci_reset_w=
ork);
>         struct pci_dev *pdev =3D pdsc->pdev;
>
> -       pci_dev_get(pdev);
> -       pci_reset_function(pdev);
> -       pci_dev_put(pdev);
> +       /* Use try variant to avoid deadlock with pdsc_remove().
> +        * If lock is contended, the watchdog timer will retry.
> +        */
> +       pci_try_reset_function(pdev);
>  }
>
>  static void pdsc_check_pci_health(struct pdsc *pdsc)
> --
> 2.43.0
>
>

