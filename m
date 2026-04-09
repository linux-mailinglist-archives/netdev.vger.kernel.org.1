Return-Path: <netdev+bounces-276889-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDydFMZi12nvNQgAu9opvQ
	(envelope-from <netdev+bounces-276889-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:26:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C593C7BE0
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 10:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 553773006D5B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 08:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA253A4503;
	Thu,  9 Apr 2026 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="F8YKfrx0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC604384238
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723198; cv=none; b=ch9uXhqkrbaXwoqT1Eh0im7sANRQhougp4MdyUo+yIUzplwRRevmBBjzEAOgU1tgcgnOZ6yvKONGHWXxvrY3M1QibCFkZZyj/lfbOqXdNu34CGTthZogxTg9j8iJ8BurGvPdWuhrInMTyfU7DQVrRvqemgQuS/kgcCuCUChU4Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723198; c=relaxed/simple;
	bh=EuhRbZ6NpCilnQOmXdYdPa2U1G2yQC2oX9aabqLBekk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Rs/W4jA2TmKggUcpJ11crMfXYHnk1l8CiWcdPXH5rpCO4udo7iCOEFZuF0Mza0oKph5TtrzzJWBqZHm9DIJyHgyZTXlV/KdwSm033DeDD6nRYuXsJg15b9l1dnVeUejSCETpFzBq9/i70CrniSbLoGFi68H8dVsQmqe0fFrZM6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=F8YKfrx0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b9358bc9c50so82122466b.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 01:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1775723194; x=1776327994; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZivT/Wgfja7s2ciPCKX2XjEYiV4fDrABVz+SXmA49Y=;
        b=F8YKfrx09xf3HEsEiLZPCjzfK56Ui0QSCWfc9Flpn/p/jP6pYv05lq8A8hbWqaNgZB
         4ifa1kEXSx5cDhQkHOquIMTKYAlSzms8Qzz9q1TMumEv/J8mtlPgiFX3Ki1uBvF+q4UC
         6zpBvniAWWbTuwdDolDdXHEIc9S/HwDzUJFYypzV/4DMXjnPouO+dMciqqCdvsjp0Sjd
         V8gigTd/kAe4Gl1JgmLq7Dz7bGP7lYKV8W+b2oAYzrkw3WvPCDdrro+yzHEuWCMVM6Uk
         RhBKaXKYs2tF5oC2D0DB3ukawNrgWeDEOmAyuICU+wW7EmDaebvIGK2bQy+KUdl4J7uB
         3pbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775723194; x=1776327994;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZivT/Wgfja7s2ciPCKX2XjEYiV4fDrABVz+SXmA49Y=;
        b=peQ5rR9jNPjfO6GHucyI5qtwhbZ8mEXc8voQLrm6xpGAmrIzrDaSwQOqD/17zNQkUg
         uWpR0RqDaPt3AWAQ1tOIkybq33+gPngVC8r9R0IstIPJUP/RF54uueQsIpgtcqboE2uN
         EQeQMj0gwc2i6TdgAhAIwmvLMk8Ni2m091iC5VeuBifPspIPNbl2MzgACeWFaRW4NoAS
         0dVTPKjoqT4Fn2Me12m30JMhbPRKlJAFgROF4JxPnrLkTB3NppiMYBqbpKl/P+8BElaX
         1StwcyX19iIXH1ZjZu86FlzQI8QnD1HG4OUKXiSdzWsL0ZnrG6yKpTVGqK8lzL1n5xFY
         xrxw==
X-Forwarded-Encrypted: i=1; AJvYcCWRKTSgqp47W/zYNdJvTIoVMV2b10vSG/zKKUVuagOps6/exBO20TuORS91fTqESn8l7CGjclE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKW0fC1M0LbjAvcofqXBnvZkWV4hpApknOl9xo77kG47m1KnOq
	8SmxLz0wwuPI2pr0lceaLNOlNU0yBstDYx6rdnoregIGsAHzXPCTh/bb2V86Pxo9wEyco0bskkZ
	d9MJKflU=
X-Gm-Gg: AeBDieuCzXXFSW6sYQhNNE5LV923zlDXUrg5JT34kHjC3SJeoMUOJrFuTxGdz1CVYHe
	h5sCHtE5NNUcatJaDhzpMn0+/kTUYTTRdAZJoVY/hMHRsFPV33sY1FL0i5y6tmsB6EVCCruZ1NO
	SUezOb1XQRJIO/wMkhg/YSwCRkTQsSwVph20a04RNl+P6M5oq66nZy32u4mrTYzxmLTCr3+ixy0
	2GoYv3inMItxRDt/iaUAPwm7TkZEkoOCUIBFxG7t8rAesyt7w0Wwb5H7mbKqbHu8DkLgL1viShk
	WNu3828Eo0EsLOhFfwwLXIZE6Juza82UV9c/tgi4iVpKBjRgsYvCimWUme59qXhhfvLQ+ZNAV5S
	AzO1jbrRokv+ATxUe4nrmGg1SPmA7KoZmBl2W/vReaawtwGuPeCgjLGWz1bGZPocvob93FClbgI
	ALbx/WzJ+ktll/7Pdca4Iukdt16v+aVQaWLXxj24ZGCWu97TejGISMN7e/cXlM6/Us3CoUQ7K0u
	kY6R/A=
X-Received: by 2002:a17:907:1903:b0:b97:1d24:c004 with SMTP id a640c23a62f3a-b9c6742f6b4mr1299851566b.21.1775723194150;
        Thu, 09 Apr 2026 01:26:34 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c3c972293sm715510466b.11.2026.04.09.01.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 01:26:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Apr 2026 10:26:32 +0200
Message-Id: <DHOHC560BPB4.F35KB93S9D97@fairphone.com>
Cc: "Alex Elder" <elder@kernel.org>, "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Alexander Koskovich" <akoskovich@pm.me>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 6/6] arm64: dts: qcom: milos-fairphone-fp6: Enable IPA
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260403-milos-ipa-v1-0-01e9e4e03d3e@fairphone.com>
 <20260403-milos-ipa-v1-6-01e9e4e03d3e@fairphone.com>
 <ku4w5dbfk4ihxfslyf7lcxtxnbzabim5mmtm7xlhqbnmav36iv@zt3dky3vbfbo>
In-Reply-To: <ku4w5dbfk4ihxfslyf7lcxtxnbzabim5mmtm7xlhqbnmav36iv@zt3dky3vbfbo>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276889-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[fairphone.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fairphone.com:dkim,fairphone.com:email,fairphone.com:mid]
X-Rspamd-Queue-Id: 50C593C7BE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Dmitry,

On Fri Apr 3, 2026 at 9:27 PM CEST, Dmitry Baryshkov wrote:
> On Fri, Apr 03, 2026 at 06:43:52PM +0200, Luca Weiss wrote:
>> Configure and enable the node for IPA which enables mobile data on this
>> device.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/arm=
64/boot/dts/qcom/milos-fairphone-fp6.dts
>> index c1899db46e71..31c6d6627619 100644
>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>> @@ -690,6 +690,15 @@ vreg_l7p: ldo7 {
>>  	/* AW86938FCR vibrator @ 0x5a */
>>  };
>> =20
>> +&ipa {
>> +	firmware-name =3D "qcom/milos/fairphone/fp6/ipa_fws.mbn";
>> +	memory-region =3D <&ipa_fw_mem>;
>> +
>> +	qcom,gsi-loader =3D "self";
>
> Are these two common to all Milos devices? Should they be a part of the
> milos.dtsi?

All qcom,gsi-loader properties are in device .dts (or device-common
.dtsi) files, never in SoC .dtsi files. Based on this, I guess it would
mostly differ based on the boot firmware used. If Linux is booted in
EL2, then probably it needs to be changed?

Regards
Luca

