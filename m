Return-Path: <netdev+bounces-260209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCZZC87HnGkwKQQAu9opvQ
	(envelope-from <netdev+bounces-260209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:34:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53FDD17D9C4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 22:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D07630086B8
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5AB378808;
	Mon, 23 Feb 2026 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="gjFD5Old"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E8721CA13
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771882440; cv=pass; b=gzWgMsvQ3jzD5Dw/ATnwVMy0+3NyvcJ7qOfipaW52sPEi2ZLNiH8lwheAotXpj+hrl0oHU0pR6ouXlr3kv+FpkAdeP52FmVeVxw2PjY4QKV51cmmGBMfAs+AVO8PTlC/W1Rfc+V1bI1anBD24azsaXSKNDHqIl5XthARGhW+RcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771882440; c=relaxed/simple;
	bh=021jXtMyhDZMJO8ezaqBggjzpQ8P1QfsLyb0to/BQ24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urWcp76RoCjpKAleQ2UC2zPZelSHfEf4KGKaaL4PwLLHYeQTaAFVOm/PFWIVqme7JkOeNAX3zghNbHDg1nqPctYGd0RBVJSXyP4AElQe73xkEF4nSjCJr++C1ZkBcFoMMn5vUaE4sUIyOyP24vLuMdqrwoQ6CaDi/AnAhVfJaKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gjFD5Old; arc=pass smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-566fe6a4ceeso2338855e0c.3
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 13:33:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771882438; cv=none;
        d=google.com; s=arc-20240605;
        b=FHy3FgzHzT9TFvS8y3DKsW/T8AxIEqNCH8a/AKw8u3vwVxpkUflpfLIOxWcL1k6Nen
         syTzjtGW6ZVPTMpw4LDa7wFyDKTe6AwgFuEwU+aKLMHS2WyeXOGOAnoHUPCEl0GvRNYD
         0AzWezGg63nwx8uiNPJ72g4H5ue2Z/7Irv+02qrmrZd2jaElYCDUREo4bCYkYPXVUFZX
         R1wqZ4xT9zKPizEhPUpN4CXr+fMFqCxImI2X8WAKAeqmoffhh/E/H0Rd/SA02iBTsTfo
         FXNREOq3HiwNz6diN70h2Hzb6nM+RFnWDR2vIgGg9q2sr/jd/fKv8U+ez/OQ3cpu5QHH
         ANnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0zit8S7iwHJ5QSy6Eg/d7T533BFQll8AvWNa/glAiUQ=;
        fh=AncD0AS9UsLKDFSJyg9EIrmTarBUaKA1UHVIu3FeFWo=;
        b=Ji860sBbVpBJCh8CrWLDlh6lLDkOTP32m7S8f0Y07MdY0iQrU/DBvv/WRUsiLRGIDU
         BOc2PSVWQ7iFlgbjj2CAKlDXBYNf8fBnIaPuN7ANUxCxXmrWAAqwh0EBnR7vcwmO8Gw0
         XslWEGuUWkMe/g2eVCQBr2or/BKZxfcnNVkl8kfIYOcNxjs4nRmj1X/mA9W85MNGgiNL
         SEIdMg1KgZmZ6PGqjMKYEaBGU28WHSagijpYR4gVi2H2dICircvr2E0MzP2jqnPVm2FE
         AHqpGCIv9ZF61vTxoBjlnWLUAxfbkA/eatLcRoIoXnHIvOnZM/+yc+lDyZopZeKKSdq1
         Xjug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771882438; x=1772487238; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0zit8S7iwHJ5QSy6Eg/d7T533BFQll8AvWNa/glAiUQ=;
        b=gjFD5OldWi7iMD4LJL9AjP5kse852W3IQ+4E95LBSLl8+Gk4k4zCUFQh09VG5RwEnb
         xmbwAFTlpDTtc9CPE4qMRYQAust7VCoI8G+G2O9RQb3/WaX0FIJB9k1QRodfD1l2Z7mn
         Ua6ICLMMzL8+syTGmC23RZq6z76OyOhqlKaWM5G8TgblO7qyb8kOq1YhahsE6rZ1aKxM
         n2S8yumuz05SeMn3UL+bG3rImndzYJQx7oS1jE9I46ce6XpsD/iq2zvaqR4D/ueG60Jf
         upbF6R2zguY54oZL6mu2YBG50SqoSmiRnRb6fNTIamyKUhu+wxjX3UTye57+facrd9rj
         oh6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771882438; x=1772487238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zit8S7iwHJ5QSy6Eg/d7T533BFQll8AvWNa/glAiUQ=;
        b=UcG7FiIHt1ryICrysbUAnDPV5dJPdfHshvxm82TjL8wygO2SXB222tX4D2vFgVQPhn
         +5LGIPZYLrc1wjQw3ejcaoDpeJfZOvXHkJ204yMetC+oKx0/DGJ+1WImuTBW9Pmvr8vr
         TtvTuhptEj5pjO8unnXRVwC8rZ4/lQN+Q9BcS2EE2p++OfXGM8zXMSHyJCzBojmPhWKp
         jBg7Rh00HnwKalLClEpkgo4h5+432IkIfOkRr6sKqdUHG6QK5xwJE/r0/Q2o/7ABqHcD
         7GuoOx841EMSvVfMopxOqkrYhvFuFg/7WtHOfSArHwxzsi255pcckqs0mwfm4wxGuzCq
         0grw==
X-Gm-Message-State: AOJu0YwAFOo7ezY56OtehJirzFJ1eiXLnXlnsnzIP0npZwvBUKipBFRV
	yPUL3XTgF7uqFbcU20N5zq3fa78amG9T6eYR+yOohAV03dAuIfDsRBNKS46HbSRL7Iaz3t3onM3
	n7Xa59NeaR0di2R5JRF7WhxlPbGNMtocmVF4vUQ/bpQ==
X-Gm-Gg: ATEYQzxSvbsfGtmXSplAtXfD1pvg9oiEeMisSFYbm3IWjPl4IghPQe/5JH1W3A9fBfn
	bJvf5iB7yfDb7LKj+3FoR4cf/DmUdSdnKkxCLOu87gyBBBzJ3rPe3Bh5X5KxOo+RNgaBQe9yHfX
	M/++lI309Y8pOjV6pxJoFu9ExJ72GAfQjMz7dOB+MkLuWRb4KA20XFHx6152O5Sw5pfJzMGv3WR
	9TsEL6XapPI0o/fsnRas4kW396oMOa89KEg7tsr42+t4iGIpQ5gW+eF7Sh3jzClzfQfHB8Ux9Hb
	uLNRPg0g
X-Received: by 2002:a05:6102:6cd:b0:5f1:70fe:3027 with SMTP id
 ada2fe7eead31-5feb30293bcmr3146247137.24.1771882438099; Mon, 23 Feb 2026
 13:33:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205231558.139818-1-rjethwani@purestorage.com>
 <20260205231558.139818-2-rjethwani@purestorage.com> <aZxlWCVi4RZhRWB4@krikkit>
In-Reply-To: <aZxlWCVi4RZhRWB4@krikkit>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Mon, 23 Feb 2026 13:33:46 -0800
X-Gm-Features: AaiRm50DG7fysrEN3Ci7bb2fXhMD-eUDkwoYkF23RbVwv6qUfiaU2HdkufnKrYQ
Message-ID: <CAKaoeS0a7AMdY1TvYsc0TvF0xv=WjNin+6bQ5NqJAnGnR+yWtw@mail.gmail.com>
Subject: Re: [RFC PATCH v7 1/4] tls: add TLS 1.3 hardware offload support
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260209-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,davemloft.net,redhat.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 53FDD17D9C4
X-Rspamd-Action: no action

> Maybe a silly question but if we have this fallback to the dummy_page,
> why even bother trying to allocate?

Existing append tag code comment explains this:
         * use socket memory to improve coalescing (re-using a single buffer
         * increases frag count)

