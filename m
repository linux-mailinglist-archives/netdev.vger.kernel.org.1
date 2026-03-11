Return-Path: <netdev+bounces-266521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFiSGOMisWkOrQIAu9opvQ
	(envelope-from <netdev+bounces-266521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:08:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401225E9AB
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 09:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CAD813058149
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 08:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7195B3A75B4;
	Wed, 11 Mar 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="oUqoX8kq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C9286D4D
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773216265; cv=none; b=Wq5CmbCxsI0FWR9zEO8ZJ/3SyZsWcKy0/Hm1MtaGxHOAh5jSgVCye28ujw1uuUgFVib7/gQmMm4lKqRJ0TOlBCgHmgIaPDAL9mxbl8fv+hBVKySnLY3Ox7kXmbHtfymCFoXtZ/estmC3OJvReP5HSnLL3X6Q6u+I2u3no38qCbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773216265; c=relaxed/simple;
	bh=khDVMinyRktjp81VmTv78vhuR5dfLwAEQX0dFp8erl4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Y+VTiKaGqg0iwp9I5//dFV4eaI9TrPwrHVO7ASDM8TODKyqN/DGaxi8R4LO4TZ+ZVVV6c7jSSHO0OfqeNG/XcWoov+aBFhCnc9xy6SY/Eol4/S39jf/hhFcuJO9ahJET76ifkscZFsrRvzkmpXRPfDaO3mwBxdlNOZ9uizMGZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=oUqoX8kq; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b932fe2e1a7so1781196066b.1
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1773216262; x=1773821062; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSG8jCrZgvSAYH3ST0w7E15BQnOuBJZtxXBK3xYNciI=;
        b=oUqoX8kqAP89jNayDviF3q4pftyP1lM14c5hxiJpdKaU9ScxErvL8+kNw/uZrRFBFJ
         HzZWhtoEzEu3bHw/CkOX29AXUMUO1dJGGdhJ+/gEG0D9QD4JA4IVLoV0EAz/uBCRnF7w
         svTFaOFM8EMKKb/8/n1dz5/xzHbzzY6OUm7cW2rGzrk+N6x8a2QIz76lDwjOjdjaPyFW
         16PqMotxrtSDONDngnDtikJRVJaIWvQhmeAC5w/Cga0nczajBEwibTIvtDNG8zn3PBbQ
         5mk5BGgwpMGzKWOOhZ8IZwg75OKNVGCbQBZcLFrtVfGGbNrxAFyNUDKb2JAAYT4nkPB1
         HXDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773216262; x=1773821062;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSG8jCrZgvSAYH3ST0w7E15BQnOuBJZtxXBK3xYNciI=;
        b=QYHTA78lHcA25O+As7WyO/fmCHrMCrkkNx/2aqlAxNtYfLreA7Ox2TyZ2jWqxAjj6A
         HHr629KZ4r8xYaiQhIpRrmu1sQJtQyOlBR4iUCL7a7y3ZbWaDxFVwOicRYjBMo7K5Hwq
         +k8brnZhmSvUjwrmkI4jMtXBN/wf6hm2wCa8JZqgWBPDTBuQjxxvmkEkJAKMAHaOP85B
         qfhngWskwVt8Mmrh19tZqGY2REpeMugsxCuCxt5WfFspOTtwWMi7eWDUVw1/o3bIFfzR
         ojKgmk0eDmxuel/Dd1LiLVJBuFgN61TR30nBJrA3GxeIhy/fOKtA2jgsFSGGw4lIEAWm
         iBDA==
X-Forwarded-Encrypted: i=1; AJvYcCX16vHfWySEz+ByEIc1wd5GRBbeHViI92vmxQBijZHMLOtKTGyozz/ZGw1KpF3/9uGDVT98raU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqXwQD6dXVbXdwfaf3OllqH/DRXoy9zfYj5D0yNfahoL1ZGdW+
	uooPDZtQajFDTfFo7cCMp4cB0YKQHah2emDkAMq4LnkABRhsg2jafsPr+L7wQWh1OOY=
X-Gm-Gg: ATEYQzwrL7LcE8vzIYhevFZVGDendiFDlLvjtJ/qo6bull+kzzNAu2QN8dA+Con98ou
	1D8t1V/U4J5no1QH9OPJFwHHVfCIwUYqKGYBWbgAtYk7jlnezSeScepLLr0BbngMjagBrr8rzKi
	BAjg+yoUpusWfPFNIdiHBqUpt3ZcumNoQFLMl/Ydchnmtm8b7GZn23jObOoMeepfERXTOfGGrMQ
	dJ1vAdE+iHjBsvIONYo4aSlMNOLdqx0W0B5e9uoCCdgMFSKgtk59Bsxd7kzuumoxdNYKm2uFiQI
	U8kKgQF5q6tgvkelYdlpGWrPp+/Tf6lK3W7583J2GUOBiyaTdJLKCpdc8lTuCNbBj07CbPrm7Nn
	CJ5AV81NNx65qwMkjM1to0NTmB+Qz/GpduIvX8yIfqHQn0IWhrnMLsQCICK+Q1zOKh1JtzAN05I
	UOv3sBODL3UbfHBpDpbwzeYSYonesHD06VXRLvXtSnjlG+HwfZcVNHWfndTVYRjhTQV6JI
X-Received: by 2002:a17:906:7314:b0:b97:23c7:2b54 with SMTP id a640c23a62f3a-b972e61897bmr85765466b.49.1773216261981;
        Wed, 11 Mar 2026 01:04:21 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972de0bd42sm37527166b.9.2026.03.11.01.04.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 01:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Mar 2026 09:04:20 +0100
Message-Id: <DGZSPC64B8K5.3HBPHWMWXR482@fairphone.com>
To: "Conor Dooley" <conor@kernel.org>, "Luca Weiss"
 <luca.weiss@fairphone.com>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "Marcel Holtmann"
 <marcel@holtmann.org>, "Johan Hedberg" <johan.hedberg@gmail.com>, "Luiz
 Augusto von Dentz" <luiz.dentz@gmail.com>, "Andy Gross"
 <agross@kernel.org>, "Bjorn Andersson" <andersson@kernel.org>, "Konrad
 Dybcio" <konrad.dybcio@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: qcom: sm7225-fairphone-fp4: Add
 Bluetooth
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20230421-fp4-bluetooth-v2-0-3de840d5483e@fairphone.com>
 <20230421-fp4-bluetooth-v2-4-3de840d5483e@fairphone.com>
 <20260310-maritime-silly-05e7b7e03aa6@spud>
In-Reply-To: <20260310-maritime-silly-05e7b7e03aa6@spud>
X-Rspamd-Queue-Id: 3401225E9AB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266521-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linaro.org,holtmann.org,gmail.com,lists.sr.ht,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[fairphone.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fairphone.com:dkim,fairphone.com:mid]
X-Rspamd-Action: no action

On Tue Mar 10, 2026 at 7:02 PM CET, Conor Dooley wrote:
> On Fri, May 12, 2023 at 03:58:26PM +0200, Luca Weiss wrote:
>
>> +&qup_uart1_cts {
>> +	/*
>> +	 * Configure a bias-bus-hold on CTS to lower power
>> +	 * usage when Bluetooth is turned off. Bus hold will
>> +	 * maintain a low power state regardless of whether
>> +	 * the Bluetooth module drives the pin in either
>> +	 * direction or leaves the pin fully unpowered.
>> +	 */
>> +	bias-bus-hold;
>> +};
>> +
>> +&qup_uart1_rts {
>> +	/* We'll drive RTS, so no pull */
>> +	drive-strength =3D <2>;
>> +	bias-disable;
>> +};
>> +
>> +&qup_uart1_rx {
>> +	/*
>> +	 * Configure a pull-up on RX. This is needed to avoid
>> +	 * garbage data when the TX pin of the Bluetooth module is
>> +	 * in tri-state (module powered off or not driving the
>> +	 * signal yet).
>> +	 */
>> +	bias-pull-up;
>> +};
>> +
>> +&qup_uart1_tx {
>> +	/* We'll drive TX, so no pull */
>> +	drive-strength =3D <2>;
>> +	bias-disable;
>> +};
>
> I recently made some changes to pincfg-node.yaml to detect if there's
> conflicting properties used, and these got detected. Should these not
> do what has been done on the msm8998-xiaomi-sagit, and delete the
> inherited bias-foo from the dtsi?
> &blsp1_i2c5_sleep {
> 	/delete-property/ bias-pull-up;
> 	bias-disable;
> };

Yes, you're completely right.

In the final dtb qup-uart1-{cts,rts,rx,tx}-default-state contain two
bias-* properties, this must be wrong.

Thanks for pointing this out, I'll prepare a patch soon!

Regards
Luca

