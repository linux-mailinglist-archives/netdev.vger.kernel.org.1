Return-Path: <netdev+bounces-299685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S7qwASeaMGqmUwUAu9opvQ
	(envelope-from <netdev+bounces-299685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:34:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D09C68AF46
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:34:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=AXOCuLGQ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299685-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299685-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B49AF3015328
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 00:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC101DF254;
	Tue, 16 Jun 2026 00:34:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142A1A316E
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 00:34:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781570072; cv=pass; b=Pz/qp6sdq2Jp63DHAWAsVaxfcf/j43RqEH9Op6w0Graq5226nJZLRG4EGc80SoG6fOXFiHPiohED3XzRAIby/cLyBZKBdG/mV58O+QyfvOt09xKRHRWZE6OGi27MluWF/S8mIMa4oVufzflQv3ETX0+O08F29JaxiLWhvkSq8C8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781570072; c=relaxed/simple;
	bh=+Y/EbmTroEIXOb8ZGWkBw+yCbLIdIXqj7d3eCXNZMxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6Ft4IBwFw8ydHD27bUGt26oZjkRInBDkC52UL9hFNR2rn3gKnoe7jNUBcOaP5AVHfC4xttPMm8oAIMrHNSc7qFlubZ+NGo5gG2wEQ+3f2M3f/0e0DYEfXH0AQjDwteW6b4AFuTYYQU4hxI2qSZnFQ0OmfBHwUvBWOUoLWhhnbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AXOCuLGQ; arc=pass smtp.client-ip=209.85.160.180
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5175d339e8bso115901cf.0
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 17:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781570071; cv=none;
        d=google.com; s=arc-20240605;
        b=Iq12yvQNUmozxvm8fNbbc/iOKFkxGQiwYG0O5f6p6mZxzOi0ruyJVWmgiDsSDpzS6j
         ddteeH2g8Din1klBhRwuCaI1++xHAH8ITKNK6qOFSYI20FlgqimX7LYIAH+llNlvuPGc
         5cPdBUlbzXuR0UQ3CSU4dJe9lWTOXqN5FBnkkKmxu5+Z4h+o1l3HTgTB8colmFapenT7
         1liUheQ+nVXwo/T8N+WHc57FPoH97VN8a/mB1D+GaLYjfy0rDJTzya5rifeXRhZpbP6F
         ICgKF09eqHWMZSz7ZwitDxt1joXQ2yw4I1f2xuF9oHc3o8gpyX+Bj5hJu2TILQAbhBCE
         o6fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/kMYwPART6TwqdV2FoTP7myUd2KBImzKngAy+xn3I78=;
        fh=SiCD7q1/fNoBiJI9NlM6pW2ge2EblkUv3YOIWY8rVtU=;
        b=Z/ELv2qZ+vk2fsC7400yhIUXR75G4EMv766QBALsMRJk7OlHi3i1ac5jjKrrR/4V3l
         MkZ+zLkiogNZ5pZoUthHZI4j+fCCMQS6xjtb+DgBychExAh35ORAgxHwA2w+9E8QCnph
         1yZEf+TFzKrxYBL51QuYN9znl3M8INYYgDl5FYewCkA0ecs+xkAczjchl+YeE4BIAeTW
         Fj2mj6Tn2iGF47/LBcnbGOHOiW/og0gskjk1wozSfsLPWcPoAgTxSpTyyBusd54puwnv
         IMJsOIvviW0Jl55F+k8i/JLFx9y7UokRajOnsY8Ic5XDSRekJpnj4nu8AxfXVaoBTkeL
         StvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781570071; x=1782174871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kMYwPART6TwqdV2FoTP7myUd2KBImzKngAy+xn3I78=;
        b=AXOCuLGQ8/2DlVhe00oEa9+KuOh1Di/cFCGuy8rVEztvP+x1ZxcdX5Bnjtklf1dliR
         9e5qecRAfZZv2ugENTvLDB9U4iJbH8Xgb0ZhBnsaHN4NkyWfmqeEqvexG6pOSCi/D1Uf
         fc5c/b5WXWZYDH3fcT6raWDC/2nbgHHlyT+6Jk+aj+sp/icgSi/j8XpeH27Q3xxmYLPh
         cpC1efc1OskXlAjxgu/J1dUvAHfik/zEpPtL7B4Yj9VzYN9UTQ5c1RcFUicZ7UGDnH9d
         KU2mGrpwibrGm9mgnydqqJbtCY/4463KkNv89iLl5cpwwnhVksvRypxgipDnLAQuHjVl
         SFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781570071; x=1782174871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/kMYwPART6TwqdV2FoTP7myUd2KBImzKngAy+xn3I78=;
        b=KP9YZdK6uWHlbuO8yYkx6oU6Mu/w1D5WLqm2OwlaSbTbQ+e3l/ILSPOg4DDf5O93Fl
         vZPyh/RZACrVXYd61rvwlTfTbLpuy4Qgv2bEKldz3fI10DRkapIGOnzpcAFfAkEWKqHO
         l4/WbW1WILvdaZ9pLBrr6Y2Zicz+vzbNK3tOOz0seK9hVhKJbmofm3JVNQYU2oYw3tAe
         HdeWDupd4Pj3+PGTBMTHZCZ8uMEIvX5zT8T4OmxAKQSpetV2baOqjfpQTNANLXkG6Nmv
         AydL5dRD5JMr01mtPo4XrgMj2U2ugS9EvK7b++7iZx6KJWCH4WD5C3nvIFm9CqZOZ9Ca
         TW6w==
X-Forwarded-Encrypted: i=1; AFNElJ+VcsCdMSTBUys3ISa4rWFwzwLya4ocG7G+npNxZ48lsG2RyWwMfmYFFSxT5hM1HfPgDXGiF4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDQjsxgVSV7dq9lPLuggCwBaz2+212Gk0XUb3y+9E09MfiJZWr
	Uh2U0euZUvmGL7KdO6Bxf9HV9P7bw/hUG5Z/3Fu7ym0Zkz3sHg3YdypChSbkWa1H5NeUI/2xGFz
	nKjBj7NjA+SBZ053BInJBZ8Di3Ja2U1IpGr6Cy1jH
X-Gm-Gg: Acq92OHlj2LHTspmxYkNWdN9/FrUSZUt0yw56iaU1CAK8HZHmwQkm54AAHIDyGwZfVV
	86gO59ri5qGf/cZS/wIr00bqor0VKjKNntX+RfgRU6SMzDQp8qXS5mo9DmeobPO3GdfuE3HJzBp
	EBUG7793nNeENsXa1vxqv/qTlSHvr28KX6oIL18LZV6de9kQDFu1eyulJSgN4xDfN5b2oYYo15n
	HUob3LFLwGe5z9cy2csHxIkwVC8mdId4XR/6oqNzIRWTzKEEJu3yVkCsVBOEyaXB4WLlguPsoAx
	eA1ln+Xkff4VQyQbvNo=
X-Received: by 2002:a05:622a:34d:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-51993a1cd68mr2473791cf.5.1781570070183; Mon, 15 Jun 2026
 17:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615234220.3946885-1-lrizzo@google.com> <20260615172535.080cf94f@kernel.org>
In-Reply-To: <20260615172535.080cf94f@kernel.org>
From: Luigi Rizzo <lrizzo@google.com>
Date: Tue, 16 Jun 2026 02:33:52 +0200
X-Gm-Features: AVVi8CeOrOUpK1NsgldXN4SuTTNLIo0M4rqMqBljDIv29mZJLe4IeoAAQGnLuGg
Message-ID: <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Jakub Kicinski <kuba@kernel.org>
Cc: rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	willemb@google.com, kuniyu@google.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, gregkh@linuxfoundation.org, 
	rafael@kernel.org, akpm@linux-foundation.org, david@kernel.org, 
	netdev@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-299685-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[lrizzo@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:rizzo.unipi@gmail.com,m:m.szyprowski@samsung.com,m:robin.murphy@arm.com,m:willemb@google.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:akpm@linux-foundation.org,m:david@kernel.org,m:netdev@vger.kernel.org,m:linux-mm@kvack.org,m:iommu@lists.linux.dev,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rizzounipi@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lrizzo@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,samsung.com,arm.com,google.com,davemloft.net,redhat.com,linuxfoundation.org,kernel.org,linux-foundation.org,vger.kernel.org,kvack.org,lists.linux.dev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D09C68AF46

On Tue, Jun 16, 2026 at 2:25=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 15 Jun 2026 23:42:20 +0000 Luigi Rizzo wrote:
> > The use of swiotlb causes an extra data copy on I/O.  For tx sockets,
> > especially with greedy senders, this has a high chance of happening in
> > the softirq handler for tx network interrupts, creating a significant
> > performance bottleneck.
>
> What's the use case? I associate swiotlb with debug / testing mostly,
> so it'd be useful for people like me to explain why you care.

Ah sorry, I forgot to mention.
swiotlb is used in guest kernels for confidential computing VMs.
Ordinary memory pages are encrypted and the host or devices
have no way to decrypt them, so the kernel must use
unencrypted bounce buffers to exchange data with I/O devices.

cheers
luigi

