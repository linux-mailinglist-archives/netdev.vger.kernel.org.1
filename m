Return-Path: <netdev+bounces-180182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A21A7FF9F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C104D3B3CBF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F725267F48;
	Tue,  8 Apr 2025 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VPQjH5tL"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA71B2673B7;
	Tue,  8 Apr 2025 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744110746; cv=none; b=UEHh2W4Jtcr+3eZ3X+kgyq4TsQ3hhZ1QsZLap63tdOOzxchMfieBCHVwRBcaq9JGeSB4GLKUzT9bwU2jioFTrSJCntfZ5DqmeE0yYEQ+hN1MXiSbI47Fpi+uO+acEF+I7hCyiLPFXzqmBCDEtBu/83uFvWsag7ngrt3FlfdkrsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744110746; c=relaxed/simple;
	bh=3bA+vF5JVbmC0TnjptRY4rNilWV3bxvP9R94bb5l30E=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=lMGwbieJ2Mx3f1nlrY54jfumGgCAXME4RTGV+XfHgNPTL+Au/25LvYPvbtgstlrcEGZPm2EBf/L0DJpq9FtwmU2yBPqnbRNhmCJQOIer6maoo+6+jkVSBGsf5KlG0Wcswjl3F2wHf3f9HgYlcyIX/HVfoiybvJQftaRMFzhNaZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VPQjH5tL; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744110727; x=1744715527; i=markus.elfring@web.de;
	bh=qW4+zeMTplvB06ndGSbY7x8YIfv7UeLRUmB1CtDRzyk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VPQjH5tL29xdPVeLSEJWjd6CboTvZok802+ySqWZY/VSKkgdsh3Rc779cMrZaKMh
	 6PyQR+qhGVySi542hlmt9o9pdAyUV58O4WpKRsntNX/p1xpWv3Fu7NVZmYEmtYPtZ
	 GCykoN5l+ZZRCydDU/PLGSu4aejdClaa2OOPJ3iws8zyyC54rLGw4gzmtjhH63hms
	 OuB77THvaHcXYv5b+q2xklGbDTKBpxTi4KjXamj1Y9pwsH3lXMsSQ/ivXRyZK/TaQ
	 s1pj9Fju/TADs0MuY+Prd9dIGr9QB4GY5WMU0LdwBFiB05b6wBQGW5GOLy5EmdRc9
	 yMWE+SyQDudD/zf1OA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.41]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7Nmo-1typcg3iV2-00GmSL; Tue, 08
 Apr 2025 13:12:06 +0200
Message-ID: <377e2597-fc15-473d-a191-15281c6c4149@web.de>
Date: Tue, 8 Apr 2025 13:11:56 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cindy Lu <lulu@redhat.com>, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mike Christie <michael.christie@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20250328100359.1306072-4-lulu@redhat.com>
Subject: Re: [PATCH v8 3/8] vhost: Add the cgroup related function
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250328100359.1306072-4-lulu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UlJYAawipnbT5ZM/bbEThLglIdknanN63vVE3V7Hn+4+qkYtUgz
 sE7aaLgutmAhXuf/9PkW/jRAXLbP4EQxBNEo3oTgQSJeelUvsofQvOG8PLLwKERWGl3gKvu
 Tb89+UTofWmNHFT6ME8l60YegHktrxQ3jIf8ykDsSMx2EmzMwW7xt+PgXbh7Ngh2rb2RG5X
 G3p3+g2WX8jawMbH0H7Ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p8iIsgqLzIA=;5k/sZ9KTfZXf5BFNHxGmMDPGqbM
 omH/sjxgsy6nWBZexohfSC25Yb+XPJidKWc0JCjWG1Ph+T+0n1PFOwpXsdbPqpS1jo5gqwt+R
 x9nXlkyYyWdavQmKwFp6ZVRTgpB/7fBM+9C5kAItHTU/F8bRMCH0Ss9JxDGjETuNzVlCfnTp3
 wUS8H234fcud+awtbZQIhVPtM0C0apYnODTz/O8IdjZbXbL+2HRFEwuE6P+Y0YqA5WHslMvkt
 +TXaj+SfjcsvxURKMeZL4so6dgyODXeSpP7AIn28qi7wf5MR43tz9Twe96Wv9lL/tkg7ZcmEC
 arovWLebZQgATTAMetYu61Oiohg/S7n14emPxgEu5betOBNwNfnOT6/MT1Jsdkv3lpAqLDfrg
 eCzBaAnmNkPcC3G69D7w+KllwO7+1QyTLxtsg5kdBeZDIIn0+cLZCNPVPuD+l7g5c92YVya42
 FtFZdgHQiDoV33NyABArF2lzBxEGgErcR59SaPDErEmv8LBJjuTg7/zQ1iyRmqUMzRxchZB/5
 oU4MuSjKNHAbxOtROKU1/PJIG5HfDdxqLyw6PiM/e/b18nq1T/2pdqBCervAlF7d4LoOP1JT0
 /76ovINCNcP/z58lyAizCxDbMq4DUe1HPHq353Nsnn4j3D3r9eeIEoJSzNnbQQzZtzrnyvQBa
 N+iJnHDRooehx+c1Vz8g8Xs4BjS5tL+XbNgCiPQyvPqKrFDG8XZr1QwNdl82fjeIellxi0XjK
 U5S7i1Bov6A38UTSua7mwgTfo9dgX/ruAOHqc9o5Z9qV9/56C1FudYunLfWpefLO0FzKbaQv1
 WVLBrKZUdP6ctTMWDH11XNTJocXv/epIDUJJUa1K8//vwb3zuzZxwZanectagY00Y3yMXSt/+
 yGQzimCQymjxys5m4EBGCf1l60Ma1fNnCp4fjuQH3DmloDNIppGv/3bXHCAgx8aZeyfu4O13l
 CspAbfJK+vpgsIKWeJk31E7GwzPIf8Q2cCs7WB5xM9aXWVpMja15ATRu3YrFaut+LTOKKWZcu
 9nVdzphyJP/3jgSFjF2X67HaC9fuj7cBaQpaRQj+MCpKoPOiR2msXJrhJUVWQ+uQCUVK3Irnc
 AJ89kj6hvCX91DiRPmAvxXRViQMqNFdJkp+iQ01nUMUNORG5QBtdAc8zusOyKA5hnx3k0vQYv
 3233exMP3Phv9sXFTYN62KszGzd2hEKlajRAEGIKDYIRlkJsZkVhwoL6iCFsLyNaVxMYrqo2O
 DGaEr2QlTCM8Fed9VRr8EJx6z9PR9aVrNlH0zW1KEtYIhE4cdR0zvtG9XsjV7vz8EWHeL1057
 mZ2pkwHdtPuoKCKrKZIz5QZ9rE3d6lKfZLSwn37j5O7uShxYVYrCp0QNxdYuH8EY8GG8UXNSW
 cwd17gnxMFAlCmlHpqBzNcKTktX3yAzjxRiqDZmNSf53eWel8txwB3WsspAT6wgsNF9U0GmhA
 We1qb+atlAChTrbGrGuXG2x9PqQDb+kWDSPJDaem7EhYTv4sA

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
> +	mutex_unlock(&worker->mutex);
> +
> +	return attach.ret;
> +}
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(mutex)(&worker->mutex);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.14-rc6/source/include/linux/mutex.h#L2=
01

Regards,
Markus

