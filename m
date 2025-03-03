Return-Path: <netdev+bounces-171364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1A8A4CA7D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 18:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8008A1886579
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 17:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71EB215F5C;
	Mon,  3 Mar 2025 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VCjExzwX"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55167210F6A;
	Mon,  3 Mar 2025 17:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741024539; cv=none; b=D+XTYlPTqceFaJAZ5qRLB3BkItjwyaeefs/dT71uCgpOdRJ1s3bi/BtLyxp/aPGNToP19L7eTXVIeHXI+mCd5k/OJPeIk8M/9u+z6aecdZp+7gykdQIudhPmkRqR67Ba5Z3Ncn/YuyU5PwT2bl2NxludgB2eLMEuLBxqvF4L12s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741024539; c=relaxed/simple;
	bh=W7ZlCwZ1+R+xVlIL5I/gw+m7bAv/kknFtFmT1LHwQjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AnGTUgB3ZYYnd71b8tkH43kMiBRDLK2bw7/1y/5WNpqSBs+vDjdXzwid7MYDRkIrRJ0gIcocCjWJDbCOK5dRcSx8/a4xlAq7DgDMiHSHYncJVcnjO2cs/dq0xtemz5OoL5p6yB2dN24gv3Mw5eeR2v6vUZCxwGAayyyHsuQX8a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VCjExzwX; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741024522; x=1741629322; i=markus.elfring@web.de;
	bh=W7ZlCwZ1+R+xVlIL5I/gw+m7bAv/kknFtFmT1LHwQjk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VCjExzwXxHw1/2HeQkqv28mPWPiBgd1Gncc9aqN7Xwky7OF2aldFP6mMEUTnZHqo
	 J/wIYFbcGQc/uYpDHmKDhDE13bStN7Cui5BkeKcNK8ZxsHBivyELjsm8j9iXwA375
	 NAnQBtYlLI+cwAPq+TAX8I2aPcUdPsS0jmz7DOZ5bLchzOOLi2yTVZU3c1bjK6zqL
	 bNb2yEvt3YoHrAtuMpMJj6fhCPicRrmVEuEsKQdXB1KLavCUoK6/aGpXAQe4rRZvg
	 wtF7/AChsyBsLKzfWoh/K9x2nPRESrpFTyuswRGzR0XbWnx+fX16hhMq2BL0gXgoC
	 oSgi7EPR+SU6IJxG7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUl9B-1tfyxc3XGL-00LaLm; Mon, 03
 Mar 2025 18:55:21 +0100
Message-ID: <30ea63cd-4389-4b07-879f-011e1b1af421@web.de>
Date: Mon, 3 Mar 2025 18:55:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qed: Move a variable assignment behind a null pointer check in
 two functions
To: Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ariel Elior <aelior@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>, Ram Amrani <Ram.Amrani@caviumnetworks.com>,
 Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
 <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
 <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
 <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
 <20250303183532.580eb301@kmaincent-XPS-13-7390>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250303183532.580eb301@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PrKHLpQ0y3itZPb+HSXogN+l+7pWtXNc95tU8bv3IEFkVAePhKS
 IkZI6Izg/xnX6ByP/uCgX0TzjSuXHJtZ7QsId1shUQoONR30dOKSJrO5V/x30bufh3qnSOU
 1/XQ4EW1hsF+9qv8wZ6K6dzONC8bkSZGeySx0UVyVS2G4oIdWDuUPlI/7yD3/HRnmV0b3xi
 IoidclaePdKo7lfDxWsAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ivk4gQMFeBc=;em3m2FPQLtScHCPjq7yxppgF0lG
 RRQCcX1FzRUUPmF9fUbMlgQqiFCq1qNyXpXArSbZV8ul7SuOaRu5EtsM6UMY1gM1uJETvWB/0
 ipMhirwYsMYTfBOtltbwDpcHu0hWPUG6dEYCdDn/d59G7JvMH33G/AVrsrUtUd0D3i21JiXkS
 kAPyqULu1Vi7FAae5JIPUpzc807P7VSyRTVCWJdopli6BGiCiHZ6kIQ9B+DO6o6m47E3h5DqZ
 wuqHQoIEltuMg59vY8MpjZ6rVoBkYJ3BGd/6jiZhjgxNjUMkOCsc/5Q7lMYV/W9ZGfSoVrjFP
 iuDzc8BNY9GyZqxL5xVtqc8p+Q+ikhZ5kQ0TrFAgGLrpRPt0oVuXtpgPPp+dM8rg+JHFtlv3T
 Fh8StOR02wclCqzRBHuoh9bR5dwpLi4wBNipT9xtzVzkflym9k96Izh/uboAdddKZLVnYKtmI
 B8moxI1J2UjTOdrX0N9I/8vUB/V4Dt35Ewn89ATXUTImhGghvvOkMBwVSQh8KmJsewFd3zZIr
 tVb2tpc813pRqJuY5Pm77GmYFz2JcVmJvhcujBdno4iCmDCmTUKq2V9TkLlqN5dAeGvTACEoT
 QGXJICbHkVhytwvIWY67LaGbMPNYlE8mMVyAZ9u0l4dEf05ojgEKTpI215PISr7xSB7vOXnwT
 Qivz/GWwg+qWTaf5y+nh0WGhzIU0FVs+7FHx3FfHfiM46ypJgGWudH7N0W/Ingp7UfXyLn3Wi
 9jzDOONxP0/Mxgfk/YO4zxR6Wp4LC5PjXLuRkF2AY9v4I53kgddAVb7u64+Nduhj+XMpF+hxE
 LkXzf1iqIqUowxUBuN1OhevuhACykrXSuofo895L6LCNvhBt2GTrqslgEHlsAiE9FJ0b6vGLE
 qXLf1IGMqGWWRnjGLDmdBxvaVlzI+INry3YsPdT40BsfasPj3Gf8PvHx2OLapZssf9mPXbwdb
 XoKXn58f71Pk3W7GQpUkdm/wcyExU/3DlyvCkwGGNwQvVssGan2MzSj6U1boEITPKDhck3zVX
 7lZ9LaYCr8+x7z3inVrHQAWs5BcrQIVnmAV3u6sy8gcUODlwQU+3ZTIl8TeitthG2yu6ypYcL
 tpmkNr7uJ2w4VrUkiWSRTDhOMKO+Oayh8Fs6g0dpTLPLyn400KLqQFmTP/pXhhMvH9sA52DlH
 otcM4uqG0NlHgv2vYAkh1+KRK3VNAIyAUWQ+XQPXAaWLrsV/Po8O3guajaBmBdG/Sfev6dvI0
 vgRQtSzivCrqo5Q+NaRzEnQLoDRIZbDky50mTVZnMG46yUAuvNjxXU1jV7SEdJpQps83aYV8U
 xIEZUMPKQjAcohGrtNUWnfoec07FD511kffWb2kEozw54vEH5cjDKVGu3mVN8Hu1hP4N98na7
 qkxqJ80JhrP7nJnY+GTuB0H5IM2qmU2eHJUQPiIQ1HHWLkMEuxclsWaRcRtGlSq3iLvcQ6+MM
 ki0T0Lg==

> There is a lot of chance that he is a bot.
I hope that corresponding software development discussions can become
more constructive again.

Regards,
Markus

