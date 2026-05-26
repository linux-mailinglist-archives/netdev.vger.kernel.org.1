Return-Path: <netdev+bounces-291597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLpQOTFhFWoiUwcAu9opvQ
	(envelope-from <netdev+bounces-291597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:00:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D2F5D2DD3
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACECF3017E7C
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 08:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DE63CF962;
	Tue, 26 May 2026 08:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLV+owrl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A983563FB
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779785941; cv=none; b=AKoyXVSgmgx0+Rzmm0KD2uazp4Jv1ZnCmI5pvjI0wMptIyLXfk7yB7tnt3iHIGey1tThdlaq2H0kjAfK9uE+cdQizdGHDIpE2Wwf9tufrk+8r715ZtU4o6fSHL0TOqPhJFCfop1eCOjLnNTh03dYGJreTJV8oxMrqeGNmXBgYRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779785941; c=relaxed/simple;
	bh=esvc5C0z6NvoYeNbVH5eLtCmoEKd9s8oBDIqxLkZbT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NniN+Pqu2txWOlJJ0O7iZHWHlG0k9lzNQ/tl9kegn//8ZEXvbcjTD/KJ0PLyd/v2acowR+yisR9ZgmSO77MVaFBx91vRLa1Cnqq9r6+pCbALnYC9ePzAGwUW6T2I4mt6GGI9cwihaPJk3JXqaqibSA/7nKHusuTLhZr0btJV9M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLV+owrl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D3E61F00A3C
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 08:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779785937;
	bh=esvc5C0z6NvoYeNbVH5eLtCmoEKd9s8oBDIqxLkZbT0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LLV+owrlzHWD38tnxfC+Q9lGl5VFX+WD2Li3wlLyqr14AaK3dqT8kquzhYPcqtmN7
	 WUgNXoL/iTpD2C+dGCYisgM89EZxrFOG+V+DvFcnO+YDw9EFgNNikvR8AmF9twPbbA
	 56Rf+wqssGdo1LsqzA9lwV9uk+bc3/xxUSkLgtEHdm8xsFXwcm/+GpllM1o0v+BOhj
	 SOBwQoA01FZflE3fljlNOXnthUX1Hibfn0vQWWiiLbwsFW3yUhs2QlndXk2i9/gOG1
	 /OARADyMFTsevc3hDb9Aqi5nEieQLy97eNKWbXn8T83GM0vg/+6ZkiXhjzVy4Jdfzq
	 q7I9r31YB7cqw==
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-135e88b8e55so1676399c88.0
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 01:58:57 -0700 (PDT)
X-Gm-Message-State: AOJu0YziOtLn1IIUCsdeXcSuNHFi75nvLpQKlU7qy2S88Mu+yDpum2yK
	uDDhRSBW53H4OGwGUJWOMeB1agvBE8b7ec/KriHBYu2zX3dk7w0lHGV7kZkaJUytKm5eQmasP3m
	YAM56VvY+szgl7G5K59+VCT2P6NOslDov1RabEA9PIw==
X-Received: by 2002:a05:7022:671f:b0:12d:d972:b96e with SMTP id
 a92af1059eb24-1365fb3f882mr5912975c88.20.1779785936938; Tue, 26 May 2026
 01:58:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v5-1-1a826cfbc128@amd.com>
In-Reply-To: <20260519-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v5-1-1a826cfbc128@amd.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 26 May 2026 10:58:39 +0200
X-Gmail-Original-Message-ID: <CAMRc=McK-AArPcrRc8rmotfoM8tSxyogGVVA3K9AcB0uG1szdQ@mail.gmail.com>
X-Gm-Features: AVHnY4LZtc64zrZWegKq1EajPJ2Vd0ki5rPVFvKA1TA8kegym2HlKDZUmZuluRc
Message-ID: <CAMRc=McK-AArPcrRc8rmotfoM8tSxyogGVVA3K9AcB0uG1szdQ@mail.gmail.com>
Subject: Re: [PATCH v5] nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems
To: carl.lee@amd.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, krzk@kernel.org, peter.shen@amd.com, 
	colin.huang2@amd.com, kuba@kernel.org, david@ixit.cz, 
	luca.stefani.ge1@gmail.com, mpearson@squebb.ca, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291597-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,amd.com,ixit.cz,gmail.com,squebb.ca,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[squebb.ca:query timed out,amd.com:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C8D2F5D2DD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:47=E2=80=AFAM Carl Lee via B4 Relay
<devnull+carl.lee.amd.com@kernel.org> wrote:
>
> From: Carl Lee <carl.lee@amd.com>
>
> Some ACPI-based platforms report incorrect IRQ trigger types (e.g.
> IRQF_TRIGGER_HIGH), which can lead to interrupt storms.
>
> Use the historically working rising-edge trigger on ACPI systems to
> avoid this regression.
>
> Device Tree-based systems continue to use the firmware-provided
> trigger type.
>
> Fixes: 57be33f85e36 ("nfc: nxp-nci: remove interrupt trigger type")
> Cc: stable@vger.kernel.org
>
> Tested-by: Luca Stefani <luca.stefani.ge1@gmail.com>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Carl Lee <carl.lee@amd.com>
> ---
> Some ACPI-based platforms report incorrect IRQ trigger types,
> which can lead to interrupt storms.
>
> Use rising-edge IRQ on ACPI systems to avoid this regression,
> while keeping firmware-provided trigger types on non-ACPI systems.
> ---

Hi!

Can this be queued yet? The problem is still present in stable branches.

Bart

