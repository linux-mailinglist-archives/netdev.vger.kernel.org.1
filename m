Return-Path: <netdev+bounces-207252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2DB06637
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 20:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE015800B3
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A322E2C08DA;
	Tue, 15 Jul 2025 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nkWAA7qv"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECF32C08BD;
	Tue, 15 Jul 2025 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605035; cv=none; b=ZdRCyl/MMH2xvxv0sK5ffw/GAr1qUyyGpTcR9o9677KFVQOdtu9BNz5kM/7FPmUR/AFRQ0svo4dB43yJb5+TxAS1hi0jE0iZ5Q3kFMCDumslvzlPlaWdM3/gGI+dhXRwE1DUToW2R20rH5sS+0iAFejjTo2ff5UyYpxBVYBOWn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605035; c=relaxed/simple;
	bh=iFd9GaUwBZZ8hKLWk61RAMzqE4jTygDop/hnKYS6V/4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=YWRW8aosFKw7uZ/g2/se5a9VWyHrTc2qWIi1c10F2epRxujPs6fnsj+tELDCj3ASHnHcsKhEAtmNtOvY/dWSgZZDuJqs3zPIy69lUTKTcGDDpvUJKVc4NpIPF5UHzbNBSNyyEbND05Bo20dRxhBm0ZxIsoK9nVKjTUpc9wRG27Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nkWAA7qv; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752605028; x=1753209828; i=markus.elfring@web.de;
	bh=tkko6bLjsxZ5JFjBU07V5JcT/pFFwCD8KRbhylid18U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nkWAA7qvhCj3R6hUJzIFnWX08PQSRGugVpQ8zKB9ApbaEctUKxOw4sijXHL0ZBSY
	 DlhWzStieceqxuPHYNe7iyvab2GaoSVi+aPQz61u0qD08jeeNoaqSCEnhtSIcGdDZ
	 /dUQa4FlcojSwy/2dIVxtfaxxWQwnqfLXfg+UnTHrcNPq3QjuO9ZIFZAC5qigltjW
	 r7SsnTAbtzjDxd2IVq/QrFWgmMbP8NjONixSGlTqiUBRD373dYcCGw3Yz87wjEWKA
	 UGOCwl4vaE/XUxS5NlkDWnjKzhKfQUrL6mbOaUX/9DEbRFNyPM3xy4w9AOCAwaX+h
	 x+RWOKxAgrhit62xTA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.1]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nig-1uYTua0Uhw-00GfnV; Tue, 15
 Jul 2025 20:43:48 +0200
Message-ID: <9dd21a72-9451-4b77-9ab4-d9b31b408e25@web.de>
Date: Tue, 15 Jul 2025 20:43:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mike Christie <michael.christie@oracle.com>,
 Nicolas Dichtel <nicolas.dichtel@6wind.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250714071333.59794-2-lulu@redhat.com>
Subject: Re: [PATCH v13] vhost: Reintroduces support of kthread API and adds
 mode selection
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250714071333.59794-2-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sUaZL8+JVg34mBLItXeLK8kPlW/5K4UgwziQgnDobooT3ypkWjw
 mNyDGVqJP6mhZHiKJRaDutRDxX9lezBc77EWyGJKkFwdt/eD1eydQw+u2Wpd16gRiGuLwxK
 IhDQLYvllls+kgePQASUFNNu9sVgyvl40jHkK6hDiJ3LvnAfl7SGmTgCc+MUiHFiMX1s+7F
 BI+3Ec1rYau9E/6TgaLbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kdoj7AkojzA=;g4GN23NZsiF4pfxmueYnMYEof6U
 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
 PlHpFPII7StgNf2mMj+1rcsqFXG7NGlZi7m

> This patch reintroduces kthread mode for vhost workers and provides
> configuration to select between kthread and task worker.
=E2=80=A6

Is there a need to reconsider the relevance once more for the presented
cover letter?


=E2=80=A6
> +++ b/drivers/vhost/vhost.c
=E2=80=A6
> +static int vhost_attach_task_to_cgroups(struct vhost_worker *worker)
> +{
=E2=80=A6
> +	vhost_worker_queue(worker, &attach.work);
> +
> +	mutex_lock(&worker->mutex);
=E2=80=A6
> +	worker->attachment_cnt =3D saved_cnt;
> +
> +	mutex_unlock(&worker->mutex);
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&worker->mutex);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.16-rc6/source/include/linux/mutex.h#L2=
25

Regards,
Markus

