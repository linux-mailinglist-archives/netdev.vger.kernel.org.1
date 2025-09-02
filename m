Return-Path: <netdev+bounces-219190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1F7B4063A
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E393AEE00
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5259F2DECBF;
	Tue,  2 Sep 2025 14:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="fdsen98Q"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF93633997;
	Tue,  2 Sep 2025 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756822155; cv=none; b=iFnnjCAYF97VWK0nctBlHKXUgY19Sutu+lzp2J4c0CFZZsxXBI1G5u1xisitppuqTvNJKYVVZVG37vz1uYD8GQKwz6fSq4swVtQBTotOgp6axbT3+Zc6WE+3MTqY8IiacC2MvroEPkd+TkKQUeYGUT+Qw/x8EjLHVfAuf9e4Rw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756822155; c=relaxed/simple;
	bh=KzkiZ5qvqIoQlYndEM9XN6Bhq9ry5AFmBbDty4rBnG0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ud+oFhEAdeusLu08SkMfxmuz0I0aexE9W3I3ehCpFy7yyLda/naAF4AG1KFoj40Gi+6Lo7g3wdueKAMMPGsDIPruHR5MhRn98dEDRCvyMJ+70DmRS4w2RaPk3R6t8DYW5lxUtz515dDK2sJIGls+UB+LkdF/yN03RChAk7V6tFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=fdsen98Q; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756822150; x=1757426950; i=markus.elfring@web.de;
	bh=KzkiZ5qvqIoQlYndEM9XN6Bhq9ry5AFmBbDty4rBnG0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=fdsen98QNIhpCjMoF3/8tyjEXI13etRPhdLD2SKw0QPc85fw+Xj9dROGfNQYCF41
	 gTJFhIBMMz9kP9fZlrFTi/HWuF8SyouQ7pSM1ulhJ+EZcTtpQZxsLIBOI4uCAvfUp
	 aP03jdWushpnb5RfbW7hV+txUq7zDo1PU8SZ6pS2LENWhO5lIJVZ4tt8DFPCAqQJa
	 azmqowb+chm6glc3TJQ7Lm+VctuzjQqNxniSOUvtzwHNtAxyf+kWBo7PZaAubDiif
	 SsJ9CXZxOMko+Mj/tmzRNL5ZnWI+DhE+7BvVqcPQu82X3tMBcEM2zJCxXePujws+h
	 AHJ/as8uNKtXeyHpNQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MVJNT-1v0lqT2Ns7-00SdSz; Tue, 02
 Sep 2025 16:09:10 +0200
Message-ID: <8e72762c-8ecd-4cc2-ab40-29f9da326cdc@web.de>
Date: Tue, 2 Sep 2025 16:09:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miaoqian Lin <linmq006@gmail.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>
References: <20250830091854.2111062-1-linmq006@gmail.com>
Subject: Re: [PATCH] net: mvpp2: Fix refcount leak in
 mvpp2_use_acpi_compat_mode
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250830091854.2111062-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zU80xfLdMP18WyZaHElTE/S9lpxK78ccI0RpgwlJeCfR/hYkotG
 9kPqvi1nBS0RjcFkxuYEqih2Xz050DYf3YeyCd/T+74LVge3nnf3ZJj1E6aF0XG7Ev+4f2l
 GvZtjNvYv6FFGUbztcgkcO2ZAApzo/VQ483K7llBlb3nt4+L5KqCncuGw8ur45WXbFIlzK0
 0vOEWdBqmwVp6qYNdZ8kw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:saa5pMFWFw0=;EwMxOvSYXpAN0c2PaSXvbwN7Rlk
 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
 42JulUNbHjqaiwqSzAo

=E2=80=A6
> It did not release the reference if present, causing a refcount leak.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17-rc4#n94

Regards,
Markus

