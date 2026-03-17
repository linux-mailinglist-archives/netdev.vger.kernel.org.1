Return-Path: <netdev+bounces-268727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAWRAImuuWnOMAIAu9opvQ
	(envelope-from <netdev+bounces-268727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:42:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 030262B19C7
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 20:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0277B3019391
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 19:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA0D34321A;
	Tue, 17 Mar 2026 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CYxaeQps"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A24342CA7
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776515; cv=pass; b=iRNruvQHQ/FdLwwp1bIHjLbRq6w4K+u3U5eWMY7iI+5Z//fuP3CZozYGvNFSrCeGw5qP8auh/1rQ+zUgKSNUvfPVo/jTw77Fiuu4WdrdDFOnbEDsK+ktcTp/L9WoMnw1BGtBGmgCA346ibWmh7zpX8INOtl373zonMi+JTN1n0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776515; c=relaxed/simple;
	bh=QCWMHpVVu+D5FW7JPVSE0ebuTyTslAu5xJTTJuekyOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgRP5BhevgAjcOXe0cPgRACj+I18FWRJby2Vte8qZGDPM7zI2pI/y6ErUDfg3cnbSn6+AqR2UB9AO4KTYkEQEkkmKAP/rinfoaRfJFqPKTvKb/c2fu6ulF+BJAjFuBHjh/9k9JOcRJYfp9aOfSuQjgMMNvJxsfArPGlsXuqRjv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CYxaeQps; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-128ce536fe0so2562c88.0
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 12:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773776513; cv=none;
        d=google.com; s=arc-20240605;
        b=Q13hjH7jVPPahmnEa9LQuU5xiUCbenaqZuDcVQt1hcG4n1Axxvpd1ntfStkewFdRvl
         VKs/TrpmyWJ+YVsqpf3C0QsmOcmz9QEa6SwMUX4j+361Yiqpo4zQc+Elk72NTKIWA7vB
         IdXPyLWuPDttQQ/go3+iPj2kd8nOKtf3Xn8u+HUCLUr58UsOskHmlbvgDh+2MZAeLrR2
         6DM9OHFgsQQ6shtpY8Q/nvvvoy6ijniBoTC091PK6SQeCEIhwK5CX1H8yIQ9C+K7es4x
         z16N2ssLVyzDQ0hqGl/eEcNsr40WdI57fBAAwEYVpGJD7NeNezIDLOgjgLiN+kIe7CaR
         oSiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QCWMHpVVu+D5FW7JPVSE0ebuTyTslAu5xJTTJuekyOA=;
        fh=6TgwdaheTAKaMlb5XFbFXKFjiu1ItXpoi0K4G9JmAPY=;
        b=SPLPVZMfNpJ1P+xXCL8QmqtJ6FwP1iwXNlQDrG70hTNg2ay/ILByXLSv2LEIJUQdwP
         uTL4a44CawShnNPCr70iWVhut3gBflGJYVWUTEHAQSVc3jxm56R4F4XLdh79VsqQm3rH
         fuNumfkFNQKcFgTKP4TMn8Xce6LLLFanACv3DLP90Gr1K6QyfGKoL4eRDkUfohGjp5nl
         oSi0TF1Ic5GyorOF8DHaOm92ASeSfjigHYHXvDGjVBvsoFdNvqMBTCDDjHDvS7BeqsSA
         r86xB8mohiTOaiOK7OvTvwlp6CCjC6Yv/yJiPAG9bsk/Q/x89b8rAqFcgYjsk9ioUdOh
         STHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773776513; x=1774381313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCWMHpVVu+D5FW7JPVSE0ebuTyTslAu5xJTTJuekyOA=;
        b=CYxaeQps4RN9jBYSY4sOLIVrag4J0zL5LaTITmTU2hahhXWb0nznwdKTUqEn9iqwUk
         2sWufqDAtkEJaTLuPlGVL36VCD4FsfsRLfV0HAuN190YXvreIoeoZEspj6tmyUU+nxib
         HVUZ+Oo/3+Jsx/I4nxmHVWHzYsXridN4S0ugu8/r3fhKBiuJhzI+zYwMk+TVU/a32tAd
         IRh1C7bspCZEVo9lQqVGp28F3lPyxktc9GApvpSQPbfLXf3MtcSzIU32jhVZGYgjzXG+
         g9dbw/7T03Xb7AYTmAwKXQeXZ4gTVjta5DAC6wjm7y/7uTdNkEcFsnD8jlgsQTuF3Wbi
         HYKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773776513; x=1774381313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCWMHpVVu+D5FW7JPVSE0ebuTyTslAu5xJTTJuekyOA=;
        b=H78wt+PvTeeuPYWJ891hwU0+DL5t4391a2mGEoFrDvmXt069FPR9+05J6xeSz3Dw6K
         IeXkG7PGM5L/Pa1gZLIOXzQGSstyQVXI8P26Taf9H39G5Yluz+MSg5PkiH8n46+Bc1jv
         oVF4pnFQS1GV5gZN0MHnI1I+pa11DfJc2/GJdQkHX0U38Um9AXXYrm0Rgh7CNMsUGe2u
         aAQara1anpW19FEfeky29qUAWXnWSLN6PPUDT7Es9lulKwEOAPSHZ/IHtMUEKbCNtLYK
         uNuVqAGnriIbENNLNFB4crSYnNs91AhOepd8neORLNuDEP0GgO/QWnNsTTn+ogWXI0Jl
         tC4Q==
X-Gm-Message-State: AOJu0Yxq+mK6fYfVltZ5qXkfh8W5+EBknteT32xqxEvugzZWlrnLwdwe
	qJstd91ry9/5PODhnIIooKzEOdKguZt7gm/eVSghXz+ebi6lEmsCeDljgTOKE4dHf3a+6/uVk7h
	yebaAV1Ku7dcFJjrFSkNfruvxwSnZTvikmU35VFTe
X-Gm-Gg: ATEYQzwnZG83M6GsIPOj474oFiX8cdf1crnebdZqqKxdUu6UljG7/wRXb0UwkkE2sb8
	sGmuK7uwpChl1ly+bdwTRu8CpOUhc2n767As8K7qEp2x7goe/rpbkE6tN76RjpiFS/FWi1GzuFL
	MvJYQHB/ngI/V+sbbT9Q0D1E5jss4s3oYZPti0gQtkjiUTMcArwqRn1EzEAPhSHr71Ui+RzGZDX
	IK2iCrk2l19oEuRF6KSUWl2RIpgh4og8nC85IRTtS2aw9kfPbgsDm3Qlu8xkdUmm3ZWitSrlepb
	sLT+vAU=
X-Received: by 2002:a05:7022:fa1:b0:119:e56b:c1d9 with SMTP id
 a92af1059eb24-129c589735emr56420c88.4.1773776512501; Tue, 17 Mar 2026
 12:41:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309113852.2c654de5@kernel.org>
In-Reply-To: <20260309113852.2c654de5@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 17 Mar 2026 12:41:39 -0700
X-Gm-Features: AaiRm51yQOS8nElDOuajtwRwi-_yfgi3tvt3IjaOteKHRazfMZt5Xp-qTk_MGd4
Message-ID: <CAHS8izMBx3j1nJwJ=b+ctGoJuEgTtMx8WsH2y-W=Sine+wo_3Q@mail.gmail.com>
Subject: Re: fbnic qemu is open source
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Zinc Lim <zinclim@meta.com>, willemb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268727-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almasrymina@google.com,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 030262B19C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 9, 2026 at 11:38=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> Hi!
>
> The fbnic QEMU repo is now open source and available at:
>
> https://github.com/facebook/fbnic_qemu
>
> It contains the emulated datapath for the fbnic device, the FW
> components are not included (PHY programming, NC-SI, init, sensors
> and such).
>
> The main practical use I imagine is being able to test TCP Rx zero
> copy (kernel and/or user space) without any HW dependency.
> There's work on adding relevant features to virtio but it's going
> a little slowly. Also being able to test code and selftests with
> a more "real" device than netdevsim with vng is super convenient :)
>
> Big thanks to Zinc Lim for the open source heavy lifting (isolating
> and mocking out the FW parts, cleaning up the code base and getting
> it thru corporate reviews).
>
> No plans at this stage to upstream it to QEMU because TBH I don't
> expect that QEMU would care to carry random HW emulation drivers.
>
> Sorry if the announcement is a bit self-serving but folks expressed
> interest off list in being able to test the queue API and zero-copy
> Rx without real HW so I thought it's relevant.

Wow, very cool! (Sorry I missed this announcement initially) I'm a bit
of a noob but I'm a bit surprised a 'real' driver can work no qemu
with a bit of magic.

Is fbnic-on-qemu about as feature-rich as fbnic-on-real-hardware? Do
most of what it can do on real hardware it can do on qemu, or is it
just really zerocopy that fully works?

--=20
Thanks,
Mina

