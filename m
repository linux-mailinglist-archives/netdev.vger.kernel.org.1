Return-Path: <netdev+bounces-287694-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKNCFgO6BGplNQIAu9opvQ
	(envelope-from <netdev+bounces-287694-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:50:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E4538525
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 19:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9A3A30459F9
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 17:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6B94DBD93;
	Wed, 13 May 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brbtuFEa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D44DBD7D
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693700; cv=pass; b=i/5Lisu9On2MOeRcfgrNTqgzmuZE6k9ORNY5XLQpY8PgLQTwaZlQ9U3KRGOWCRMkFOXilh3d46+O333Jp6FQMJH/5FLqaKgzxVOS8rAO0xSV+xq2mG+V+dahuwDzl1LFOa7gHKQDds+CFun3j1L9bM3V2Gy7W5GnW+G6XhYPCHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693700; c=relaxed/simple;
	bh=6mKKdTvK5cZhpi/RRSOEX613zOGTzbC3S1RaopRBLKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FBB4BfkdF+8RphoPkzibP6RcRpQow8FsJ87B/zWFGDpwsaNMKJS3ccNBsovk7sHQSDCFonnZSw/QfuYeDdfxnUOFVFRMko9FUmuNI8naJmyIG1gEK2pB2ZOi8IgWB8reTsK4kcfrOmspVeLPx5nIHOgYmMlc4ebcywD6bJ05M3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brbtuFEa; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c15849aa2cso9465899eec.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 10:34:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778693698; cv=none;
        d=google.com; s=arc-20240605;
        b=LoOfuceMPkz0ENuWGp95tdUTDJ3/eZcMAMu32GIocFKz8tW8K5rs5G0q7RymwU+Tku
         GiQ//IQ6SQ+069JKgWb47N79hdqoq1prVcDICcYRk1Obb6py2jSVF1AcnyhJuaF08/Go
         v9/S7pGufXfJOjHVCalE3sXed/T3CgXTIku4aOoveD1t4v+yiGubHIGnsE3p0aKJIF1U
         Su/N0bBohEe5+EzfXkWrk33E/TcnGrzkDW2uMnRXuMyxQebSvAIE7ifL9oTLGXbs9tG+
         4s5hXAbyKWvxcLuEBlNFAtA6BEopi28J7gQtbrKmuVui7Gy2Pn9WdVs6s7YpVJufjGso
         eDZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SpmEe38ixB0yNCM9L2G46PM6Le+IQzZX2ErAyq3Ln7g=;
        fh=sncaUSgFoxRggTInjAtzEz39X2jw34nfjMQQDYFl5+A=;
        b=E3L/eiXmHItqr2V9rwRhOV0bnS+CWd15XG80LyPLlHq8Nlx18Sh/r+w8ZjN1dA21bJ
         8S8rgIz/X5gm3FPnTsfyJWF+zN7HOsF9zqs5ki4Zgacgq0RSzi/xvuHtSaH4h90T+wuk
         egUglYas7eyICZO6eo1qAYWbcZGA/SNoX2y9W1nYOGPFWZsdGINuuLstalvXfj4Wqt7H
         CyvCpMMRx2YzihEjl7UMpvsm/I8GFPSJ4o6bRbG/vZ/WEFtidqhbz2i3+dlDLZb+uCJV
         Uho7XSO/hbCE8Ci0JHbuMju/V8djhdmOcnrULtFp74oEkxepO8tGn1/XgTHI8yfFzLZS
         2UTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778693698; x=1779298498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpmEe38ixB0yNCM9L2G46PM6Le+IQzZX2ErAyq3Ln7g=;
        b=brbtuFEazLvBam8XINvJDXjF4XU7Qkp7fQiYSxPQTepmB8WvWHIRTCVTi9pB7foIL6
         0/W0vSriBFjY2RkGafYIp3N8uXwzdwScxWHoxxZtSCBovdpx7Xs6FOZzh/qaY31Jdj4t
         YTTlWuFH78pT5gkN1IBaUJPpp6RW+DYyC8ZeQJH3a44yTQ/pe6jvRdvWuqzbIKYMG8lI
         dW5AKVf2w3DaVrMJWyNn2iCQS2VTQ9sx+a8YZfbdcW3HIpw/xpSzTfY/y9Abr41h77mW
         1GJBzvBbtWmE0LM1lNMS6ehhYxVqQdGvALg6fD25VRI6iRdjMP27lhMh7XgnHdknCdPQ
         xlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778693698; x=1779298498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SpmEe38ixB0yNCM9L2G46PM6Le+IQzZX2ErAyq3Ln7g=;
        b=QhgQI+CKc5VmQFpY8AEuE6/YS+WoV2m+WSQ0vF6AY2lYMlC+Qqu2II9Z3yLovvxa5q
         V1MqHJaLR75OEgj3ytaNDR/BvzBg9FFTjf9Tdz0ihWLyPCfb3+kB5oxOg/392ae2w0Ok
         mp4Cpb6W4Gy4cP04/sWQnakH2CM+UZQlSRT4/dCRTndHezBmHOcyP6ki3SxAMcx2gDZx
         n5NOUPKI5iw1NI0bNhXw7CmS9UQNAqS9EjsRqvToo0scHG8y+7IsEjIjckOATF09Q+3p
         lI9qpAX1Q7II+awDblnFtcgM8ymCWQ3RGDE8U0j6McBo/CRHUOnYdFl1sGEBuSEHfyCZ
         XCtQ==
X-Gm-Message-State: AOJu0YwVS3HD3PkNb/XZwn3t2m5MNIebnTVfp0M7zxpkdbDFUbAt+eGv
	Vr+tMGs3qT8uFFpqPPPt8FpF6eY3hc42TC32bk2IShHVolgWWmMll6mQ6ObOXI2kIcV74/V3i/p
	c5hC63kB9Sm6qDbzYnxr1BNKnHuh8YcU=
X-Gm-Gg: Acq92OHjMtvgfjGlzN3XWTKQOCPA1OlTOmkgj9jmi1TPqr6QX3Y0062sIzh/U7deO6C
	PVMd+gfIR6u7T+zNEIp+0C1h7QO2Z9RO51GZOmRZkwNsCfP9eivhTRi2i47+sLZo+7M0vJq7tv1
	TYb6OOjTo9SIZtR2f/UZ0RfK+TF3HDgprd1UF9UlqnM4olv4LlNMClEWCzjZuj22hDqUdSl95rx
	10mwzTwGYJhBwegfENXXcmHSHjKqL8fesclANE9uFVu/Z7mPK0RTyvh1JW/Kat3PjwM9ZCJLKGE
	wzDFZKGypKGWKq3FjKM=
X-Received: by 2002:a05:7301:198c:b0:2da:d4b4:c85a with SMTP id
 5a478bee46e88-3011747e13bmr2818209eec.11.1778693697976; Wed, 13 May 2026
 10:34:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511135703.62470-1-clamor95@gmail.com> <20260511135703.62470-2-clamor95@gmail.com>
In-Reply-To: <20260511135703.62470-2-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 13 May 2026 20:34:45 +0300
X-Gm-Features: AVHnY4Jn_9cXsf7GdBN5Zma5dh7sHSjSA1xGhyeTeuyfFq_71h-4QZdAyPVKUFI
Message-ID: <CAPVz0n2GkucfHqvgusF=K_KakqaJmZSLP=8VYMyVT5HAVDD_XQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] dt-bindings: usb: ci-hdrc-usb2: Document
 nvidia,external-control property
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: B83E4538525
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287694-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clamor95@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

=D0=BF=D0=BD, 11 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:5=
7 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Document the nvidia,external-control property required, for example, for
> USB lines in HSIC mode connected to a modem, where the modem requires
> precise control over the USB bus to properly enumerate all its stages and
> intermediate devices.
>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml b/Do=
cumentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> index 691d6cf02c27..a13c1ef49a57 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> @@ -75,6 +75,13 @@ properties:
>      type: boolean
>      deprecated: true
>
> +  nvidia,external-control:
> +    description:
> +      Indicates that the controller is configured externally and that th=
e host
> +      should not attempt to touch it. Usually used by a modem which requ=
ires
> +      precise bus configuration.
> +    type: boolean
> +

Would schema maintainers mind if I create separate schema like
chipidea,usb2-imx.yaml is handled? At the moment ci-hdrc-usb2 holds a
mixed properties of several SoC and can cause unwanted/unsupported
node combinations.

>    ulpi:
>      type: object
>      additionalProperties: false
> --
> 2.51.0
>

