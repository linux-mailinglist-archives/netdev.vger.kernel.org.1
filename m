Return-Path: <netdev+bounces-260862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNoUJ43Jnmm0XQQAu9opvQ
	(envelope-from <netdev+bounces-260862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:06:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C90E11957C3
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EBE3D3020FD0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D29238F95C;
	Wed, 25 Feb 2026 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZasswQh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D838F945
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013880; cv=pass; b=bO66Mnm0JTpvU54wlIcdzNHiguSA8oq8wxYvXWYmfip19TJrUsw311rRX5CLy/1afnKmitPa8/4ZhRpZirl+Jsr/6ptOVljkPHoErv1WMw+lOKcN98tH6qlgfX7ixaFk8852H5/GSsGWqUYQOfFINXUycgbbw7UF+uXJWxn+ouY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013880; c=relaxed/simple;
	bh=8M5R32h56N+GE+3p6222Pi+jD6v59RXbo4rIa3GGXzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPllKQc/UBq7Z+sY8kn7pg/G03Cvp2S34W5pwNiyEwEmM+eiEsBi9UHuXuWyECZZOfS0MLiSHECaWHkuyOjcuj4lRImYyNYPtUvjip6akgkrb22m0gKXAAbr0yrFvKXBq0MnzKoGcY+RIEqVdm7Z9ffZZ6LrkkH03fzDTJnX0EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZasswQh6; arc=pass smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-65b9608a9adso10977051a12.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:04:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772013877; cv=none;
        d=google.com; s=arc-20240605;
        b=cJTGoF+NmgB533MiYoJzewjtsAXryFftMJlsDB0CTxBod/7F76oherYNkkRF1Zr8uC
         uLzM5sYLv0hFtOxT2SV3Aan0fSGZNzEWDzN/LwuBo+nnjovw184n8kHAkuG5knApHsdn
         lGFkGxxsJKdpy008VhwbbmZIckKMqwGh6lA14NpV8GjUyj+bK5pkKwfW7ydkaf3DJIlD
         +cG2ZFbUwggwENGR7ccHq5KPIoqp38eWVWzQqg40XuEtRzgrxwdNEJBWPxNjMCiXR3lk
         49WjdsfzwNrthbJzSUqIiDez5SjINNt0yU6L0+PwYW7++VuuU3l7OEiLhvcOh5Dapcya
         VN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8M5R32h56N+GE+3p6222Pi+jD6v59RXbo4rIa3GGXzs=;
        fh=9FMb3MaekwI7D8wBTAz9jhbuhnyD3uovhCzqCN6EbEk=;
        b=YIccG9WaQwcgmG5OaY4QbAo46zkCh+oBTQTS9Cx+/4ARyCu1TWuwCIB7Unz3yuQY2Z
         W41uvZlPGTZa9PfM8t/Xpv2hHnL4MC1B6K4EN49N3zA4ryDBnID5BaaTWbOJlSrZHPvx
         gjZiCw6dMdmxpa4+e+kB/Onp8Ct/lk7k8Q+zRtESiDBNONurMUkF+uc0CJpjwhrYOqIA
         Xww7Hi2+vMosDom1Mf7hYRD3cAW52J1tAq9XfC0IOgjv+B55pqxDc9AktfF2qK0Icl9r
         0I4RXErF8DqN2htMIoZoTFCq9zYU+mBm3r1ronw4JlAeKuTkSsKEG7NchnWMpcFJN9qi
         5rAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772013877; x=1772618677; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8M5R32h56N+GE+3p6222Pi+jD6v59RXbo4rIa3GGXzs=;
        b=ZasswQh6Z6BNfzyr9lAVHafJlmUHyHbi5oAIapRpAlceF09IqIAu9C2cLbbQ0pk+pA
         +rYTrhd3Pn72geZSEtd3fPXUI78HYC5q1PHA8D4XCVUHR6dsoLzvvgybGFnTa7GJMgzQ
         K79FAYshyrB8HyY9JXLFKYVOR8rHXTZBz2d1/sNxRh/8ycXQ8bOTJ7xcYnXx3G1V0Rml
         QdzIGlyM5fUkLXz58RMy6n8ujD/cLSaBAYpOL9xWPjKw4u/JNesejtSNQqzFpUf6cW1Y
         uH2dFNTVqEI52/vfPfqmdEDTmrxitOXGv//DJCkdUyaTJfLv9+9lxKQ5kBGptKyfVBYP
         D4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772013877; x=1772618677;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8M5R32h56N+GE+3p6222Pi+jD6v59RXbo4rIa3GGXzs=;
        b=MObNBjSMoiJLV0tGVmJ+t3tzaagpYQ14ph0q119ehNvd58H4gV8xUNsCixTZeU0UlE
         SZA8Av3ELSIyhFHBmw7BRZ/n7ZdKePWUWfPPmPRJHHCCX2sSZOQHc8WJ/7VP3ZcvFS62
         m43HlwCH957gapqNpKk2imItyZg4cqKlS1YnzzkwOqHzGdxk/dOciSkvWWD1O+BKxmA8
         sGQNvKwhTKHAq9WpNvt5AK4HY3aqDMU2uozA+PnX3NPyTd0YPdud48RqompRliHqBXG7
         HiedPRUCtcf0wyq3H76ESgKcSmTjZkPzXk0Zdu8IY3OocUTyNPZJ0fsU9lJCpdGxNUdK
         EZ2g==
X-Forwarded-Encrypted: i=1; AJvYcCX/TV8/VWYcrAYMMnZbAra1wrbOLFFC/jGCvHzAusxP670jCNJ8F3YTEGANGGM7J9LjoJhfXTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhqfDDTsL9EtD4UzZn+GRc7x7sqThiffH6xpkAalEen/0yOj3w
	oiVt3dtijU1iCkGMWTrNkWIywvi5cYNhdflH3bGgYEhfrCUHg+jhNfDKHLejWdTcffY9oXw/Zc+
	1nnBAol1kNTAxE/o7TxUi4Wi3IuaCZn4=
X-Gm-Gg: ATEYQzyF+YgdVoO+Y73CCwGcskWLiRBixN18MEZzTIikuoluvmg06NCRqoP6VjYohKS
	PDyoI+ykWlRYwKHeCws/jNxmfYWN6wMn49kDbCFsN1n9NJXesd/ahP26wGS1mU2MZXrnpIvcsOH
	NhRFhay7G2Mp3m0XApJYZSAvsozTlp4E++UQh+6PoblUG3l8Y87wyTZN/UbLHF1FQgkKtTt3rI/
	fBAcJGYzOQiVJ6GCLZyGUcmHYEagHzymeEm7obCa7wfUFB2xwAlVBhQNK9eeJo46945qVelvb/L
	EwQibh9lJgN0mgHU55gL/A==
X-Received: by 2002:a05:6402:42c2:b0:65f:81be:e7a5 with SMTP id
 4fb4d7f45d1cf-65f8b8f35a7mr1035923a12.23.1772013877072; Wed, 25 Feb 2026
 02:04:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219090216.12884-1-zeeshanahmad022019@gmail.com> <aZbanQC5ci7yLqzj@horms.kernel.org>
In-Reply-To: <aZbanQC5ci7yLqzj@horms.kernel.org>
From: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Date: Wed, 25 Feb 2026 15:04:25 +0500
X-Gm-Features: AaiRm534VHjph1ia74LUHEryOEu6qZCq9bhwTL3nsbuK0eFqFyIDEFKjkp_nW-M
Message-ID: <CAPBWGpEzZk8oUqxD_N0mOqVw8p09Xidf7g0kfUnpm=gyZBqftQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] net: core: fix logical inconsistency in failover_slave_register()
To: Simon Horman <horms@kernel.org>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260862-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zeeshanahmad022019@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C90E11957C3
X-Rspamd-Action: no action

Hi Simon,

Thank you for the detailed feedback.

On Thu, Feb 19, 2026 at 2:40 PM Simon Horman <horms@kernel.org> wrote:
> It's not entirely clear to me what the behaviour should be if fops is
> NULL, or indeed if fops can be NULL.

I've performed a deeper audit of the failover module and found that
failover_register() currently allows a master instance to be registered
with ops = NULL. This appears to be the root of the issue. However, I
checked all current in-tree callers (e.g. net_failover.c) and confirmed
they always pass valid ops. So while it practically doesn't happen
today, the framework technically allows this inconsistent state.

> So I think it would be best to do the same here - that is modify the
> code around line 66 to make it conditional on fops not being NULL.
> Otherwise, if fops is NULL then steps that would have been taken are
> skipped.

Wouldn't skipping the rx_handler registration at line 66 lead to an
inconsistent state? If we skip that hook but continue to link the slave
to the master (line 75) and set the failover flags (line 83), the device
might appear linked but the data path would remain unhooked. This
concern is why I am leaning toward a more definitive "abort" if fops
is missing.

> It is true that in those steps would never be reached and the kernel
> would have panic'ed due to a NULL dereference on line 66. So maybe your
> approach is better, perhaps with the addition of a WARN_ON_ONCE.

I agree that WARN_ON_ONCE(!fops) is the best way to handle this. It
provides a clear signal to developers of a misconfiguration without
allowing the kernel to panic.

Based on this, I will prepare a v2 targeting the 'net' tree. It will use
the WARN_ON_ONCE check to both prevent the panic and abort the
registration (returning NOTIFY_DONE) to prevent an inconsistent failover
state.

Best regards,
Zeeshan

