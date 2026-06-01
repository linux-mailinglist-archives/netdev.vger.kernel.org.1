Return-Path: <netdev+bounces-293554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGwUDC4bHWoeVwkAu9opvQ
	(envelope-from <netdev+bounces-293554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:39:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8988F619BD0
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 07:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9B3F300B3D1
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 05:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3EF335BBB;
	Mon,  1 Jun 2026 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K84cj3Ct"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78F033123D
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 05:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780292393; cv=pass; b=I6l7535WdDFQtdUvNFM4aEMIwUsR0zBXRgAdn1AHF4fHLZVf3jJj75flAvllnqIPGRgEJ3quyHUrpOj39eys5ntJSRvUgCLE9dX1ZMXmzd3WeCwKjnUJH6R4GaznIbZvek/yR1XiIRdtShKIuKVYQXz7mGL9MnrHasFVGZKEvts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780292393; c=relaxed/simple;
	bh=fhMh7VI+fDjToJYmmaPjtR0k2mbAxzQziy8hOa/+IsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rwSzr9YuAcwB3OfxMas86a/rlcdJIdCIKXsboeufDbOcquB8TfSWxKlxP7/XMbNKo8uoaaknnVV/iivCos74lHtLpR8aBRCfGk1eJl1oVkUlPn5c99gcEq6SkM17/j/q6SK5sC/z/95rRNXLGRTLwVViDHIe+DCF9HegS4FM5uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K84cj3Ct; arc=pass smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so614756b3a.1
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 22:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780292391; cv=none;
        d=google.com; s=arc-20240605;
        b=I4jya0niRm+/HU2ttY2hxd2opXDp5UoOVXty6vTDs/JNwAoUCY50UCWlp4qk1FwBbc
         LILKwCfZPn0B74sHpD/VjYgvmA3fWRHX9WiGUFhIAIL6vDZdUt2NGCv75YAMeUQeOPWl
         lI0+yPBvdiqWrZWkShun4Ow1rQ/hg4DddftbK+349L8Ap+TX0yHCr+2s/w+b23hQMH34
         lxXifolAsE80sqlKhHX6W2/45RK5flE44EApFqCOB5pZNqhL7q3TlVI7q4cFzAk/8vvU
         07EB3rdL2/iARN+cjF1Fcn7UxUhJuFU/Al1qLif6BrR1SjJMYoRDWT//zLzk+j/Qk10o
         EL7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=++Hez6BcFzhV60mZuduDVLo3yt8bc2DYA37KVaO+BJI=;
        fh=D08NPQHx3brbEsLZJeKHltqjLiL+ZJxd2gBXuo1JP3g=;
        b=LcWb3CkXSPFjh/GblfVQHZrTdR8UE72OQrvtQPpNPaLUypQ1Ghl6Tl2rWLWDTrSbC0
         2Q0iOq6sQnYz0ht4xfeBpfeiRZdSON9NzXFrBndDJvK6/YR20jSpYt+cFqA5bx8x6UHg
         AWXZY1RC+5lshS1UUz30lydT2N5wfmR2NMK+FaDLl83vcLBAAJFIi+Kb6xmn1n8t+t5y
         +pTmdIUY0smJpue7e7SXQrMfAcopN/C/MUAcbSAI4/NvqsQpyWVZu0yYXV9VndvUvAlb
         KEHwz4mstbwFrOCoaEDE2V5obC/FwxahNfTWVouJfPnklBaMNZ0bN4GvRBootYPwYgKB
         qBcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780292391; x=1780897191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++Hez6BcFzhV60mZuduDVLo3yt8bc2DYA37KVaO+BJI=;
        b=K84cj3CthnomIq0DqtdTK2knnkiTVz+sQ3g05MLRfBUH5e/ybAMdA6sKwebHGI8FrR
         hShfXT2joZukStWndOGBCDcr/6UfgDVgx3jZKe+lcttm26YVi5QTWiePsw7Hsx2lhD/A
         rak59RVzFKM4YJQt15dYwAxERW86EbmTN1hziztfN5ZcKPNKeuRiQSYY2tsPJdqO0HZx
         +w6UtRpVuI1lL+86LRLoHqf6AOG6ICvFwgGI6U0/XkEjyRuJRpvInmqmqHVbnkjq37Wb
         OBW76qTR/rMt832pq7ESTpR6ULAakL5j68HysWVURayqkzhEGh9ApXptkVfPpKyZzpXp
         yMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780292391; x=1780897191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=++Hez6BcFzhV60mZuduDVLo3yt8bc2DYA37KVaO+BJI=;
        b=lp3CsHqSFKbTjYkvwYsjiWLEiciqzmQaYugLDMeTZXFrQCmxljFbD2N8DPZi25q8sN
         zXfdl9dLR8aayzArjv1E1/0yMKmVtgGbZkU5COoE6CeowtEDF3C42ZB2+6CDu73Y5Os9
         TA28oM9KADKOSemkJVEj4fqGtqUKQoKP6SFIeQDvsDqcmcQTx55nvSl1Ckis96Ja/xx+
         lOthyrFthBLPayPBq2oXVDk1Lp38b7ODsMGqr8j1HwRHVMRHsuhfeQ0WAskRcYhO5yrj
         C693j1XOhq6uYsHynSKHQfS2nWaltFhsz9TFVTb4YlOQddMKchK8FJRCuqNuM3HEgHh3
         nsww==
X-Forwarded-Encrypted: i=1; AFNElJ/scsOxchkcZ9eUUtcP1H7jWSPw1++LSONk4B7hjhz//JZjPJZ0x/WNZKTNeAU4fAdx6IUJRfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVbdg3EiwrmNRc+0pn1EfqcNKDqv087uAgSK2CPTlwCmclkVdp
	Np6/2QnPlRgAY7cTs6Kvb6/9XMyrUc5KOXc2jWfAwVZvr1ZY0SYXz//SOHqIOmqP1/aji2Y4hIc
	gT78QZiPy1fjVAHGwsktxUA8XGVSYBQ8=
X-Gm-Gg: Acq92OE7wKnHMGrctTxBVtQdjl7F4joMrUMYR1d9nNnKyWM3krwH36ZGOf7t5J+2t9s
	u9A0dW9GoY/uhVzKaeRhCtjbVlPXhRmUS32RwnqingeeYt371OUEU3W0ZxE4XfiJBx+Mo5n0rKH
	++56pviAV0WCguEM7Ln/UBDf/6wAbqIZfblog1FHWnzQpF/nCbzAIK5ZMZo6pVEUMOMcIYBB1ts
	391AkPSdchnx9xmotdv048XIeJUV6Bt9V7CLFkpW3qElbi1VCddnPZccYrgJ5KX/S8S+P0KpIt3
	MfORuvJjdmv2fIlOYk4M8xcDoexIIw==
X-Received: by 2002:a05:6a00:aa8c:b0:829:b08f:7353 with SMTP id
 d2e1a72fcca58-84225806185mr7434867b3a.7.1780292391030; Sun, 31 May 2026
 22:39:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
 <2026053145-bungee-flyover-840a@gregkh>
In-Reply-To: <2026053145-bungee-flyover-840a@gregkh>
From: Grewstad <dogestad24@gmail.com>
Date: Mon, 1 Jun 2026 11:09:36 +0530
X-Gm-Features: AVHnY4KL0P2TgGuqwzNPsVxgOuqCoiWIuNNwDFufUXPHqDJofsznfpXWQubqhvg
Message-ID: <CAD03fjaxcS0rfZbNPNQjg7HxAhhTvOBxH=p-Rj_ngaGBPmpXMA@mail.gmail.com>
Subject: Re: [RFC] drivers/staging/axis-fifo: TODO file and subsystem direction
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jic23@kernel.org, jacobsfeder@gmail.com, linux-staging@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	hjk@hansjkoch.de, davem@davemloft.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293554-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,hansjkoch.de,davemloft.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dogestad24@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8988F619BD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 31, 2026 at 8:56=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
> There really is no difference between a miscdevice and a character
> device, the interaction from user/kernel is the same.

> UIO provides a mmap of a device to userspace where it is controlled
> directly.  Probably not what you want to do here right?

Yeah, on second thought, UIO is probably not a great fit here. This device =
is
expected to handle streaming workloads, so having a kernel driver manage
the data path seems like the better approach. Thanks.

> Is that what this device is?
> WHat really is this device for?  What is the goal of this hardware and
> how is it used today?  Do you have the hardware to test with it?  Who
> uses it?

Well the hardware is programmable and meant for hobbyists and researchers. =
It
could do anything, but SDR/DAQ and low-end networking are common uses. But =
since
It is a programmable prototyping board, making it hard to cleanly
categorize it into any
one subsystem.

I don't have the hardware, but I plan on testing it using QEMU.

I was looking for guidance on whether the current miscdevice based ABI
is already the
best fit, or whether it could integrate into an existing subsystem.

Thanks,
Arihan Bhor

