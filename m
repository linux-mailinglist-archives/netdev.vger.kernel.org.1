Return-Path: <netdev+bounces-286959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMbdMpvHAmqUwgEAu9opvQ
	(envelope-from <netdev+bounces-286959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:24:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A59851AF05
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE3A931A7DF5
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5836D428856;
	Tue, 12 May 2026 06:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEHWRCep"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EE8426D33
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778565977; cv=pass; b=QXwC1EuGVb9M9+O3wgHHMwz0JJH6jIAsbyamZqh1nx7Ix+e7GNMLv9J645WqBmUCZXsZzUERBkWyHczDIw1xbAebwsKnGkKz0Pg/xBlcdOVLtcpsCF224rh6+QnUEbf/AaAVZEeaEJEi2WoYPHndluh7w69wYKSdpyU8Xaphn3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778565977; c=relaxed/simple;
	bh=yxZL62iX8pebWS6AofBmV9FGACpi7rIEMuv0C7XnSII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfQY8Gnu+Ih0VA4L5/xduGi4YoHI8hqomLXeK3A0ViMhDbavRmdl4LDPsYnis7Ctbi5zib33b/MX0wOqZJK28Ch8sGRfyhoeoTaYh8XI+or+8on+TL4GU38A4fg0txPLiOP7Ns6rU/cNvf1ICKMvi/UZPHZsrdfFi4cxgpfJYNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tEHWRCep; arc=pass smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so5218788eec.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 23:06:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778565970; cv=none;
        d=google.com; s=arc-20240605;
        b=HqCsPDwTr19wxpvCXBSGXts1M6Ev9xIa4ek8CPuEqv5/nrOLEqrVEsxcbFLgAxSyQE
         qrEBkGrxiJqhZ+bIxM8E4s4SuHDJgqWnc1lc4pqeuLSBw+C2vbDUiTzI30K+BkjDrIvu
         k57IVNFnvl7dJELe5OfVqOmxuVQMa4F6106VER8eqHPcYtOPgqXns4WxxzBifJUlUfVe
         gmCtmYbX3t/AGEzCbs77Lv9b+O0pkGXWjz0NObpOHkmMRP6eGsyHJLdmy4SNXUl3MHii
         zQh8KrH4OKZlDAQoypSbKzCqkYeegEoF8PkMzsClJ3AveVnDlUgfVbGmiYB0HqKAmUVk
         Cxvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CrrmqA1MIjLw7p2PiJAG2cpDnb+P9Y0HrkTx6QFkzK8=;
        fh=nuuHL47rZR5tzQfARtgLFvPo3XPlivJXi804oJorfXw=;
        b=ZsyJGIdEFHSVNXXiuI70U+0Mzx02Asc3HAjCme0jlWJjF75SZ4fDyOTRIxodUz8kAo
         VdrALGRbzquZvFGvNiB8OOSJW1eOQjV+M4fjRWAx+2fAZITAZs7GKMLAaHvqhLw0UiY/
         mzz0RTq7SkebwsEPl2z+ZKNv3FTTsw3wgAzsAmXS7nssDvV+KhIyeTJmcI3dJcTAIAPz
         nfsSIKmzIQz6vpGhv3HV9rYDs0qr8IO1m2UzCQhLLNvK+vLMJzmT04cWGOFGh8mNYRIh
         0LmGa688muKd6XXfVL6vDxi2X0ShMVGt9JSvoS8UZlRAZjnnVa+usWEuePzsX5W+TaeY
         uQ5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778565970; x=1779170770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrrmqA1MIjLw7p2PiJAG2cpDnb+P9Y0HrkTx6QFkzK8=;
        b=tEHWRCepdx5nmp6yIVCYqQVzLmcrQesovgaR9iEkViVeFajmSrIpSEYelr2lD2XxoP
         xh5y8Zvqn+p86e68KD2mvaQiqYvCBtE5yPAPTikVo2xqoL3Tzv1bOvc6AoLsBX9tMQ5x
         bYKhs3w7Wz6+rTS0+0PdymwNuR6Mrju/sIlosbiQTM7eQulfT33DGAwgDmm2ablH56dQ
         bWpBu7X7LqvzKybeZhNl7lGCCxcAzvLmd3Uqv1PZtG5EGNwdM3TqVIVGnx8neXBuwl/W
         L4ZL2IYFzfr7AuRSPKZt2mLvNKX42PoQwoqq4VK13MoKe4InA0vqbgWOu8BlRN8yU7AO
         0QiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778565970; x=1779170770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CrrmqA1MIjLw7p2PiJAG2cpDnb+P9Y0HrkTx6QFkzK8=;
        b=Tu1tEfjTsv1iNHawAs5/9wRMuyqBPAMaI7lNlShtdUgga/Y0/4w/kkkeDZqqsMDn0E
         nU4WqVF5Eo2TNEhicG8dxUF1Ewmhi6S1gOuGEJ8JJ63F9iAFOhyDoVfDNVaFvBLlO/A4
         AILyWXbk9NNVGDX+G+lyGybnJnp0I5EWDj24PrC+RZ1IBOKdzH5WCgXn4OS0wFAg41Tz
         NSLWMDKjse7K9SkiuaOZadfpIAdx72jX2mldLATURff0E1PaLnbdmD924ouFGNXYI82N
         +0ulTim+ClMHRkx+lcvCnjrxsc9acMEZAwTrNcfb2WkzbfyESUfAQkrcP+Exz2EDd0gI
         4M9g==
X-Forwarded-Encrypted: i=1; AFNElJ+ZhbskXCGb3OhPhWEZMDNnNkuMNmwfeLf7KrEVEQOQiHSg0+Qk+JMDoYGsFc/9KsGqk+tHtzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVK8wnhQJFq4EndkG4YPuyaNhpM4ifPmoYj+foltkwOEzLopL
	XJqKKouWJwv2jZ7IjjKR80BMLf6S6XLLS7q6InoWjRGjVT1ojD+FjhQbwZCo7tYXa/rKokjw3QS
	ZbXKDVXMTneXv9k9qOiXbCUllr4vTVEM=
X-Gm-Gg: Acq92OF4Nm8MNXiEJZSeBFFIs7XnwqmR7uBK7xEsMY8ktTGNe29YXfetFL32Iehca8e
	N4ZH6UyKZSGSCOF5lFtJmsq6DxGL8HMIQcguxQLnwSXYCkno2KO97US+1DG688QT3HnX6gZH9L8
	zBeSESxD3rbsrV0CbIWHt7Z0AEsO9QP0mU8u4rZG1rI8tmag8iSuA6Z8Nt8HI4rI56NtWyzRI7g
	FmwhOX69+M57MBWBW4U6kCxDuXX2NwiXlmfN4R16lrFk5HHW6yQXbp1okaj9CcGcmdcdKRk3RTv
	OMYPxZAw
X-Received: by 2002:a05:7300:d70d:b0:2f5:3f62:37b4 with SMTP id
 5a478bee46e88-2f54c080b64mr13761984eec.8.1778565969672; Mon, 11 May 2026
 23:06:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511135703.62470-1-clamor95@gmail.com> <20260511170548.0065fd07@kernel.org>
In-Reply-To: <20260511170548.0065fd07@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 12 May 2026 09:05:58 +0300
X-Gm-Features: AVHnY4J1P3ErzmBnYdLDEn2tVC5ojwqEMUhGov68STEE-MFG5Dk8UXTF_hePr8Q
Message-ID: <CAPVz0n3wcgaXzSLAMT=Yt=+FC=n7ufkn_CAaKNcyTr=a+7bdTQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] Add support for Infineon/Intel XMM6260 modem
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Thierry Reding <thierry.reding@kernel.org>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Peter Chen <peter.chen@kernel.org>, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6A59851AF05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286959-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

=D0=B2=D1=82, 12 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 03:0=
5 Jakub Kicinski <kuba@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, 11 May 2026 16:56:55 +0300 Svyatoslav Ryhel wrote:
> >   dt-bindings: usb: ci-hdrc-usb2: Document nvidia,external-control
> >     property
> >   usb: chipidea: tegra: Avoid controller/PHY init if bus is externally
> >     controlled
> >   dt-bindings: net: Document Infineon/Intel XMM6260 modem
> >   net: usb: Add Infineon XMM6260 Baseband modem support
> >   dt-bindings: phy: tegra: Document Nvidia Tegra XMM6260 PHY
> >   phy: tegra: Add support for Nvidia Tegra XMM6260 PHY
>
> You need to split this more on subsystem boundaries.

Yes, I will in v2. I needed an initial patchset combined to have a
reference point and show that all patches are logically linked.

