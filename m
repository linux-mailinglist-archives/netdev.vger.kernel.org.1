Return-Path: <netdev+bounces-264383-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CArmL3p+qWnA9AAAu9opvQ
	(envelope-from <netdev+bounces-264383-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:00:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD56212446
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 14:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53403305BBE8
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 12:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C240639F18B;
	Thu,  5 Mar 2026 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WutLMnNe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504CE3A0B22
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 12:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772715461; cv=pass; b=gAgZE2AT6vS+drslFMRC3XHnLtc9Gk40H+Z+Es0IzLMHZ+6wthfCZl2WSJVKxXXKVBohqKmXbdN0zrGgdNz7lmup3TKqucD48myn8I3ygK2gm/W0H+K46BSXYDWFhkkPOBPqhEtXksdwSOujPW+B7SOsi4eBOVXrjkG5BGdmrBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772715461; c=relaxed/simple;
	bh=hg3VybHGNM8B9fWAA0K4iklWWMcCpPnj8i/igGcKzqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cNtA8LaxXw6uRWKyi1WbTtjd/5/ylSoLKKAoqoJfxbJNiioQwu9MYlExmunSGC6rrYdBcQca7ztzg3JOE92/vDN6ZnqYddsV2B1tKKixKFCMclMO1/x8IAF7QyuPCX9bSqMKGerebKhAh5P0sI/7UpT7rx3v0AuGyRYocviOQLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WutLMnNe; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so1300889866b.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 04:57:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772715459; cv=none;
        d=google.com; s=arc-20240605;
        b=EHGZDxUh9CB/8maCCTbw94U82WIh0oFfimb8DMlACQ7intVa7cxrqw0veAilJC62gq
         EBDy88+AxScL1GjRgp5ZB0diGEHh4V7x7PlcM6pltUDnTHaqfMmmOmrX7dDx5YZvkIIJ
         x8VKEz7dyoUd7YuGOWpzGdvo+8m4uEMYbBGGTYfyvOUrwpcmRvaFYsH7p+w2wZMMz7EG
         N8TwRLLc+NzV/20tURxAv5gHXYB7QpnZonXN1mu0u2o3vGeh1LkBUailzrikxMZHSsnm
         FDrt/MCquPHBwEhf3Ed5eGdbyNbA7yexn57RPZtjHSA7oFFC7TPBUhbxvG1uTe/RG6yO
         UA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TqgYiuwtjyV1UQCdDi018aQv3q0kpjTsempfm/GxWAc=;
        fh=uIcBqKaB72bce4W+1xwYXO5s1YItcMh0skk5kkST6fY=;
        b=CSxoizDqa5knx33ej/dlJaeCFAwgF8PISU1ToE8iKUc0bDOmNCN9Fa0OhssGjA1gEM
         gtcoAvR/jErk9vEvOwxsLORwk9FqXLgn4zFvYkceAtI2I0RJSt6t8uzgKjYDtWBUbt0o
         I1QLZycpczXcrF2NarKmMtcd6Cm0ZKG6xg3kTcSkkNp/ZEbhUpe9cVcShrDVCW3JMUHl
         I+j0NRc4mBChUfsLjyq7rJ64KGdWQ2BlVVsnpimyJrhe4kK3h460pxExnJGnmamovwuF
         umPcJTErEfPP1aOuU3p/IbolDOaXmKaSd9nRE/Wyk9zgko0OfaWVqGHgEY2l1+VU0RMq
         vw9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772715459; x=1773320259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TqgYiuwtjyV1UQCdDi018aQv3q0kpjTsempfm/GxWAc=;
        b=WutLMnNe6cjggZkuJNRbsfipKN+sle821AniV/rIgO4dcGxtk3/Q9ws8EU/7N+1kdi
         faom9xBT1SPQUxUSww72fcNhAdPSdNplLX6UrT+HvqYJz5gusQ0XY4MHNsiAtWMZnFlD
         1Nq+D3m1Rk8z4CA+NmjTCRMLE961j1VZ12Nqe4x5dacL1WN2QLbNfimQzu+Q8RS8lIRa
         3U9/v2Dsl82PmgciuXRrbW2/rL6SdJtncApj4ba5x0E8lI/F36RT/kbhswi+ZB5NWyAT
         bhaNL1Ai5zz1IyJ0eLllOOfbmdzPbrHb3SdXXatcykTN/mrxSEdOGpM9rPME662aDRfO
         xxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772715459; x=1773320259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TqgYiuwtjyV1UQCdDi018aQv3q0kpjTsempfm/GxWAc=;
        b=XAXzjnjs2wTCr7jz8FNp67sRsaLg2yGM3Np1bQZAy37xr33HBuJJpCC0qS6FHdz4FA
         aZG1dtq68usko8AneNl1233Fnd1uVDa0iOvhU8pBM37t0D8HlebrIHsLEHHa4bUvH+Ji
         XQcBViT6MlJgEPxVNZMQ8fi1FW08CWHjZI95h62omx/OImXERkaTtO+fsdsNXEg+cZu4
         v4S6eHCqSYGeRvtkfQZvYCosk2cjwPTwn+iHlf+wepfsFt4gwtG6OsY9RfsahknyLAmg
         /ZqEBQ60lR3EHZ97m/sGUk0fTfaHBIZCDF8EkUnaqnqcG55izfm6T7bKpjtTubPqeuOP
         jUWw==
X-Forwarded-Encrypted: i=1; AJvYcCUjMM3L4PXAXokjboy1u9In2AL0XslqiaHKwcF2oq2PZVX+z/MAUv4iGYXg/6+wFhBNM+fs584=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC7mwJ/Zc74ZwV1L5BuQpnI4hnAIfTDwiTVSWQ8t6fTjGJXoAa
	uSTnTubbgcfsAirr4Cn08yLUnGTcZ5s21KG/GXPICQR3v1kwidT8+r6ZcKf5U3eF/ARb2nyrZHA
	nuqFx0MygMybhnb9DneTK7gx5QL1Ktxo=
X-Gm-Gg: ATEYQzyXPMGZ7kQRvfrNDfsrBCYYAL24hppPT1x5bXffynrJm6DzixhsE+WPBIb35mV
	F96yBF83AbaU18A+NH8jmxUlKhoGrT9O88uKALoTmI6hZZqTmwSVRaeILQGAxUFB2nxjPBF3EQl
	mvswWNbb7uoSzaRv57R+/lQvxfXss6fPVRxnLfgB8l+LBBgJKeEUjMJACWKj9n7W4gzGLLeTLUN
	ifBBVMywWoTrGW2wfXPpuFZEHh8NCoQ/8D8EDGh2L+6ZN4qlxMgTr7jEYJmv/wSrci/oL/WoiTI
	RJTU9S3poyEyMBsDwrURXfxFrewEu+XLmLOx1BKm8gXxu33XMcwoopdHpnGMizMQvLCqBLfKpuv
	/8dM8HZHRRa7dnFOHc+fwXdrZ
X-Received: by 2002:a17:907:3e1f:b0:b8a:f3c0:c09 with SMTP id
 a640c23a62f3a-b93f162c9e7mr352403066b.59.1772715458473; Thu, 05 Mar 2026
 04:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241220073540.37631-1-wojciech.slenska@gmail.com>
 <20241220073540.37631-2-wojciech.slenska@gmail.com> <5bba973b-73fd-4e54-a7c9-6166ab7ed1f0@kernel.org>
 <939f55e9-3626-4643-ab3b-53557d1dc5a9@oss.qualcomm.com> <CAMYPSMr2JCQCX69PGUk1=7=-YfBcyFDpqQ6tMQzFP040srBA7w@mail.gmail.com>
 <f141a098-efca-46f1-bc1a-433ff03915ca@oss.qualcomm.com>
In-Reply-To: <f141a098-efca-46f1-bc1a-433ff03915ca@oss.qualcomm.com>
From: =?UTF-8?Q?Wojciech_Sle=C5=84ska?= <wojciech.slenska@gmail.com>
Date: Thu, 5 Mar 2026 13:57:27 +0100
X-Gm-Features: AaiRm503EZ8xJfGcfxKhcFmT8KmQTYRl_tl6gGC1NdHevXlHzYa69ef8LksZEX4
Message-ID: <CAMYPSMr=2WUvjh9+ZDRkgqq6B3=MB9xmwp4NkKnWpdnNiNXf6A@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: qcom,ipa: document qcm2290 compatible
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alex Elder <elder@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7DD56212446
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264383-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wojciechslenska@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,qualcomm.com:email]
X-Rspamd-Action: no action

czw., 5 mar 2026 o 11:54 Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> napisa=C5=82(a):
>
> On 5/26/25 9:39 PM, Wojciech Sle=C5=84ska wrote:
> > pt., 23 maj 2025 o 01:30 Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> napisa=C5=82(a):
> >>
> >> On 12/21/24 9:44 PM, Krzysztof Kozlowski wrote:
> >>> On 20/12/2024 08:35, Wojciech Slenska wrote:
> >>>> Document that ipa on qcm2290 uses version 4.2, the same
> >>>> as sc7180.
> >>>>
> >>>> Signed-off-by: Wojciech Slenska <wojciech.slenska@gmail.com>
> >>>> ---
>
> [...]
>
> > Once your changes have been integrated, I will resubmit my patches.
>
> That has now finally happened!
>
> Konrad

Nice, almost there :)
Please also submit this one:
https://github.com/quic-kdybcio/linux/commit/cc20384c4484507fbd18b8a01c79b5=
e7f5b6cf8a

With this small correction.
+                       reg =3D <0 0x0c100000 0 0x2a000>;
+                       ranges =3D <0 0 0x0c100000 0x2a000>;

When it is merged I will resend this one.

BR
Wojtek

