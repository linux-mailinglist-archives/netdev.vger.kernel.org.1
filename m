Return-Path: <netdev+bounces-256098-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPJiJwhjgWn6FwMAu9opvQ
	(envelope-from <netdev+bounces-256098-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:52:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5337D3E4A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 03:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E5EC302DB6A
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 02:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35E131D739;
	Tue,  3 Feb 2026 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6tJvkim"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C036B31D37B
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770086922; cv=none; b=OJfORBmLGyZS/TyJfcZcVUK3QOMiBbBbgdZ6j1bHMWKi2/OVdfloLTPjP1f4uX1O0x42vBOPuIJuADk+3oNwl/2AqFvVDlP8ovBpyJNePSu3LNNmMHluQC9EMnIzl33/zZSEInK06sAq2mSzuUN+3qBXw81AdMp+K054NzINJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770086922; c=relaxed/simple;
	bh=DZ9sjQ7OobQVtrw67X/MUaC1/NWxqtCzyDCqnbHzMBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UauryeRWlLzKryIF5KjqlfVyVV2xe4aFIwZnfflG6sGYtomTCMAxmc1+Zcz2th0Rd9HWjKllLfSd5kkAkzTeBTam96RscrRNJZgy6OsgyxkK+2Pc15WoN++e1zdSdk+e0a1JDb7FDTs0CWddXbBYO14QlN0bpEeR5WLuOM1GON0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6tJvkim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4729C2BC9E
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 02:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770086922;
	bh=DZ9sjQ7OobQVtrw67X/MUaC1/NWxqtCzyDCqnbHzMBE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=d6tJvkimtgjfjfgauk1xJy8ulSYaD0Jp0OTxSEJkELKx3qASoM2H5Tuqrb3834Ng3
	 bSxyz9Jl2m2FPCxBsDy9CER/++LKuZA+kmdx9W0+Z5tKoaAIfyca2IN/nIC6mFlrpi
	 s1KnUQ86xO90oRQeBUzOkb/m4Ndhx92fPWoeO6mOj7STCcMxlWBCTDqQbOr0WDh+Wt
	 ZyNiLsCOfo+mlpCS3XRIhTJaA/cRx8uajMlkdY+kZ1mEB/zNQ6Mhi83EcosdyOjgtL
	 KpkTuQvEropdq9vqIxEE5iVQ/8JD1zTnvpNU6PDN4dj4iFRnxbVx2t1o9FAJeTRsVt
	 2crBA8wBvEDuQ==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8860d6251bso776836466b.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 18:48:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWLK2N5m+dkgGBTPNTcBqVAZxG+xmPFP8KMD2+xolwAmrpC3U5bLdrMloF/fmd2uNakFaw/YY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdgJddqDff6ZfQsobnZWcZJ/lQDf7wKZ6QREwCFt9xcEUGP9AK
	AUBmMPdf83dqJeHBYLGWUEjUdfL0G0Hi3q8cpM0oTYuFTwxfuTwBjQSdbT7mrgdvgAzJylcJmvb
	yqjy6LmZ+y9GHiC3czsuY83vlKcT26hw=
X-Received: by 2002:a17:907:98a:b0:b88:6dd4:9c92 with SMTP id
 a640c23a62f3a-b8dff8993f7mr880118866b.62.1770086921204; Mon, 02 Feb 2026
 18:48:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260201023619.366505-1-chenhuacai@loongson.cn> <20260202160749.454a7ffa@kernel.org>
In-Reply-To: <20260202160749.454a7ffa@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 3 Feb 2026 10:48:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7_8=sjZo9_WuzCtka3FuJpk-xstYm8Rz9OQJt8xQ5j-Q@mail.gmail.com>
X-Gm-Features: AZwV_QhYTku8RbeulaSZvU4gxQAzHFKJeS2ujPEDyWOk0DJPvz7QlOpYO_DFX0k
Message-ID: <CAAhV-H7_8=sjZo9_WuzCtka3FuJpk-xstYm8Rz9OQJt8xQ5j-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: Correct spelling from clk_scr_i to clk_csr_i
To: Jakub Kicinski <kuba@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Yanteng Si <si.yanteng@linux.dev>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	Serge Semin <fancer.lancer@gmail.com>, loongarch@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256098-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[loongson.cn,lunn.ch,davemloft.net,google.com,redhat.com,linux.dev,foss.st.com,synopsys.com,gmail.com,lists.linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenhuacai@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[loongson.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E5337D3E4A
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 at 8:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Sun,  1 Feb 2026 10:36:19 +0800 Huacai Chen wrote:
> > In include/linux/stmmac.h clk_csr_i is spelled as clk_scr_i by mistake,
> > so correct it.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
>
> The CC stable is unnecessary, please repost without it.
OK, will do.

Huacai
> --
> pw-bot: cr

