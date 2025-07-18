Return-Path: <netdev+bounces-208217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78220B0AA29
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854683B14B6
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 18:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604A32E8894;
	Fri, 18 Jul 2025 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="edS32uM/"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F611E7C34;
	Fri, 18 Jul 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752863465; cv=none; b=bYhD9QlaDOfg2f3yQSnVKheHAWMhkcumCfRSoCnns7qoU2D/1jGJKROrqg8lyY6HdMl7ZdUH95gjhOQWt7rdxdbcYn13VKPgluJ6i+OH+dQosRyNgXVxiLY6bB8jxKwXOper6nMYf3FtVou2DjWNLGNxBaFAamAjG1EXaWh5Y6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752863465; c=relaxed/simple;
	bh=iQeC4GU73WtF11zRFShctmi7JWbxLTv1RHdHQ8sH86c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fKOVIw7wyXYedNFwr/+HHo5Oj4fFQNdVxAGCDf5qZR9f3JV4VNL1jVSgX0d0+tHe3buO1GidBvB+O7neDfpP2G1Js4bq/P5hMRbv9p6HFxh57y5tfvy/kaCRfMjrMJew1/r3R+B9uVWhlFVGoEPnB8RevlqLFUDh9uHWOQ5nCbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=edS32uM/; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1752863446; x=1753468246; i=markus.elfring@web.de;
	bh=2xIIPdhqVfGQJUuusBF8KYkPWzXBgEwTeh2fEMZTkaA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=edS32uM/OGSYIGHaj4nlBq8UzHWjarnUtdSqjodh0UznFNY9Oxt1/d/5mf0OYVhX
	 7qwv6Ivkedmh3RlIBA5c25gdbyTEqLa7VfgTNsvNrWziJ/f7rGG5duOv5ndlDqkBH
	 ivBaxCjKW9EWnNj+BoFhkpBRjCSaLifLzs3q/FSOglHUWfQnXjv/HjiFL8P7tRqs0
	 C91rVtzhS+OPNvtLJ/QluT998pcPsGYIcuqPMGQvTJT2bb16pzNCeICvrCHModcsK
	 vo/PbTMcLiudcFtluHrJkqb5g8vzy/HcvaW5PtCzqn+w1T3DDkVapzbECYbZFqPQs
	 cIPgIUgUeu4HPmrDwg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.219]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M1JAm-1ua5lc28jK-00Bk4P; Fri, 18
 Jul 2025 20:30:46 +0200
Message-ID: <effb9b2a-73da-4e0f-8672-b9d3f800b8b4@web.de>
Date: Fri, 18 Jul 2025 20:30:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v3] net: ti: icssg-prueth: Fix buffer allocation for ICSSG
To: Simon Horman <horms@kernel.org>, Himanshu Mittal <h-mittal1@ti.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
 Meghana Malladi <m-malladi@ti.com>, Paolo Abeni <pabeni@redhat.com>,
 prajith@ti.com, Pratheesh Gangadhar <pratheesh@ti.com>,
 Sriramakrishnan <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20250717094220.546388-1-h-mittal1@ti.com>
 <4c677fdb-e6d6-4961-b911-78aaa28130e6@web.de>
 <20250718143225.GE2459@horms.kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250718143225.GE2459@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:REMjXiQwS+2Nygyl+iKV1Dom5ZZBmsPRvkvuE1wCjjg0Ue0IUNW
 8rFCUHAB0PkTMAXVrmE0cLB+pgTGKH6vxNvh2mkC26wvOEHmY/a+nFm45PwwAk6yt11C0dC
 +XtFwS5S5tUn8YBa/wn0/4lmeooDqPC2RrBfPhVtKm/r8DQelgTvmL9JzVbeD8Kpfg+jiev
 soqBMqnic0G0l0+dlotEQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:edaEL2WEa58=;AScAbgCwBAH8Ed9s3wfg8Z9GHFp
 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
 Ht/0AE2iN/uZKM=

>> Can the usage of the conditional operator be extended another bit
>> (also for the function =E2=80=9Cprueth_emac_buffer_setup=E2=80=9D for e=
xample)?
>=20
> 1. (Subjective) The current code seems fine to me

Under which circumstances would you get into the mood to avoid
duplicate source code further?


> 2. (Objective) Your suggestion features unnecessary parentheses, and
>    incorrect indentation and whitespace

Which code formatting would you find more reasonable then instead?

Regards,
Markus

