Return-Path: <netdev+bounces-289353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IB4BFrQuDGq0XwUAu9opvQ
	(envelope-from <netdev+bounces-289353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:34:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C9857B5FE
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80BD130AAA8E
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458843F9A05;
	Tue, 19 May 2026 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzKQj9C7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DEB3F929A
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182928; cv=none; b=EVpnqcOgtPfdHqMwz9DHFU74Bra41Qew+1pNEyF09rqXC3btHhnROjHztm5rxyDsnh6DD0mYsqCqIFMnJ98+hG70O9v/cqSUGvilvPYTMGwiTguIRi1IJP0n0EcE/UohUqDoTNsUdV9hJNGP0QED+bmn4rvjDVzIRDyAgVU8iQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182928; c=relaxed/simple;
	bh=/kvKbqax0Jku50QJU0HJtaoYDyooY7wIS57Hx6ADkqE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnqgEiEy7v6yhqRBz2kfIL8zSr7uKHBRGZ40dU1BQpT8we4zQNcWB5BGwznM52iWCrDfQKeAPBNjmHsrnL76Dr0R3ekvjZ6iFrgsSITea2NTdoqOKCOJvhqcnz1dpKF8e9YCiZi5oQiEm6tDwZrdKDw0G0vnQYtA/WlLEJRqnc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzKQj9C7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08C5C2BCF7
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779182927;
	bh=/kvKbqax0Jku50QJU0HJtaoYDyooY7wIS57Hx6ADkqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YzKQj9C7SlM0B3ByFFiVd2KD7nj8nk/6jgceCBFCP0wJxAvPmcC6Gn9uai2JDD3ay
	 ZrKDZpi0rEQ4aftXc9TjXU7UxU7VeltI1REDDfuv8s5bTpX2lGrQt7kixkvU1VTJ0e
	 ZuYwQih1W5xWhGwKZzBsQt8owcXmDN77dVx8399vb3+Y+5jIwHjRZ6LAaLLfjUcz85
	 ifOfuU9wXwWQKT4C6qfymYYkZOPIuZ5fG2dhFlIQLSMkEQoM/XNarBYQ1YT7a+ybV/
	 YcUfGaLD3Q+D8y4iLB9RixzTtOZ0X9zEoyQIfMm9OWYgtco1Vx9TGLMDLHNtKWSUZp
	 DQjlNzoyWxoSA==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a858881ad2so4615246e87.3
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:28:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YwQXdhbduUlMWfnJhZ4GF9vWFpcvmvEa+TURPZm+zxuBLfxwYR1
	xmORTg45C8tC10VYU4ydP8KugsCT53Wwp2OMd+Z9SDEN5Am1VNi2sASb0ML+W98FF1f6TOAyNkv
	ilg9MJnTMe9Ru+nsLtzyDSAywFDdkuBnm7O0Jqk1hOA==
X-Received: by 2002:a05:6512:224d:b0:5a8:8ff5:a9db with SMTP id
 2adb3069b0e04-5aa0e730565mr7381013e87.27.1779182926342; Tue, 19 May 2026
 02:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v4-1-8580d8e18016@amd.com>
In-Reply-To: <20260519-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v4-1-8580d8e18016@amd.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 19 May 2026 11:28:34 +0200
X-Gmail-Original-Message-ID: <CAMRc=Meg0oUCDZdnKwohrj8PH4kQv1BNkCqpFq53_PWJMDK8yw@mail.gmail.com>
X-Gm-Features: AVHnY4KULGD32r6-P10Aee0LoDZ7cEe-d929DNRhsz77N_rBrPMjnw7DFOASiGo
Message-ID: <CAMRc=Meg0oUCDZdnKwohrj8PH4kQv1BNkCqpFq53_PWJMDK8yw@mail.gmail.com>
Subject: Re: [PATCH v4] nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems
To: carl.lee@amd.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, krzk@kernel.org, peter.shen@amd.com, 
	colin.huang2@amd.com, kuba@kernel.org, david@ixit.cz, 
	luca.stefani.ge1@gmail.com, mpearson@squebb.ca, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289353-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,amd.com,ixit.cz,gmail.com,squebb.ca,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email,squebb.ca:email]
X-Rspamd-Queue-Id: A6C9857B5FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 11:21=E2=80=AFAM Carl Lee via B4 Relay
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
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Carl Lee <carl.lee@amd.com>
> ---

You didn't collect all the tags.

Tested-by: Luca Stefani <luca.stefani.ge1@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Tested-by:  Mark Pearson <mpearson-lenovo@squebb.ca>

Bart

