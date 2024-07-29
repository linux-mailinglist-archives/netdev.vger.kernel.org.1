Return-Path: <netdev+bounces-113751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9726893FBB0
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8A1B1C21931
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3849915ECD2;
	Mon, 29 Jul 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="E/Qowm//"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E861553A2;
	Mon, 29 Jul 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271492; cv=none; b=m6DHE+6zsMv5uaZie3YAkIYh+sraEAu423TE3WFnnv1eW997vzo07Q5DqDHyVgL8SnGgMs91U8ziDJT/jsDdDQElw6TCO55BIOv7uqiKw9LmstnczGYygz/0mJQXUeKmLiLhoV4YXaYiTcsydDOiJlDkIyVr4b2oSpQP97KY7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271492; c=relaxed/simple;
	bh=oH+olM6I7y3I1y9P3irFOh3arxrk8pcDdOtNWjRHv/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X11dubpZURCPFrkty1W37MeYckygU8iHZx8jkDGNMHY4+EDkeWTqMYl5ZpZaMhGbd68/s1I5cLiqlIqQnaRDI6LtLNNYLbFgTsBO9WmoBsdtS6gQjmbWTZJ9mGDXdO+TgRtWSx2CyctKFylBRN50mbuPQoJ8F3GyiCr0rJykIok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=E/Qowm//; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722271461; x=1722876261; i=markus.elfring@web.de;
	bh=oH+olM6I7y3I1y9P3irFOh3arxrk8pcDdOtNWjRHv/M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E/Qowm//FEJpjRev5Ap4irpO9l+cXikVkU3zc3zGZsoxJYOusI2ckl4veusxgiQb
	 Rg2yhNrrMWoDhKWMpt9DXcAOLhfgXmCKJ1MT9LP+xEP67oFF18lFkzqkvZ1pvW6K8
	 B0+3NpEdcAoWpbHN2u9hONx1EW/r7lQNRs0gBHrJ0ncPVLmwCpOxj3ITkTAQtYJ6D
	 vKzkhJPFPM8Gj81sWfAtZkHYEDJBycetO+Q3uUNrMukhSPP6+Nb5Pfz3ypbZx5Ogh
	 7Ly+BG6nS1nUci1VglWeSrpxm49RxJOZHYdWdmvwmTA8NZr/BrhmDQHZzvgXPRmEO
	 VL6hFUlPZkGYXnDUEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MT7aV-1shW8o2Qjn-00OxHK; Mon, 29
 Jul 2024 18:44:21 +0200
Message-ID: <c8a42211-3b39-4258-93a7-354ce729eb7f@web.de>
Date: Mon, 29 Jul 2024 18:44:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 01/13] rtase: Add support for a pci table in
 this module
To: Andrew Lunn <andrew@lunn.ch>, Justin Lai <justinlai0215@realtek.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Joe Damato <jdamato@fastly.com>,
 Larry Chiu <larry.chiu@realtek.com>, Paolo Abeni <pabeni@redhat.com>,
 Ping-Ke Shih <pkshih@realtek.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Simon Horman <horms@kernel.org>
References: <20240729062121.335080-2-justinlai0215@realtek.com>
 <446be4e4-ea7e-47ec-9eba-9130ed662e2c@web.de>
 <7d85ae3a-28d3-4267-9182-6e799ba8ae0a@lunn.ch>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <7d85ae3a-28d3-4267-9182-6e799ba8ae0a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O/ElXgFssvC7tc0PdUY7AJiUcYrBLQNGzSHieilyUsCDP9652fx
 xFi+HliWX4SGt8W/kDYov/j6hrtD0P6HNs+SozINunMOPI38nv1kzhBpEoWsgYSyCzlRqfN
 Bm5+bYHennkBpGCi2U5uFUPRw/Jx1wup9BzRZ9hG44ovKdl3TzdzZ0F0xin+O/N3v1XUe5V
 oj8ECaf9H6Yiv33P20SeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hhE2jWa+UT4=;yRxzkVhsLJGIPVHoMN7YdqsBOF/
 Gm/rlHexnZG7P2mlsPM+/jfj2qRAKFudxIJTL9/WYfqDWrpGwpYXzM/mtelILaRFSorWL66CY
 N0K6LD9wjJoxBhoGFJehpnwwZJ+YPA6lsyjQVifaJErTbHXLxZxn69/F1iIBXuIBn26UTPmLH
 a1uWXqFNDhNEa6Rh88dFQWvp9EXaS+Ig5ixjrci1tERg5CNKgQQ0dpADJz6V4MteHfHIXTICS
 ml6pAP/4e1IAI/U4IkVz2XCvymZhdLQkt3vI42KWY8cczdekZYQ8ZcVgEbEnmOb06+XRvAiL1
 Bmx/jT5f7D+uORkC0ulb7U8DjF108xZYoanHCxJ0OZvqX5IQxtdtGqr0T7DHGIpSYVOTLGAtN
 r/Q1QLwAEZRJmfyVyCmgQs2EA2dqsTFgcNX/nvfpgDTATVxOoJNOn/mBo4l2fOvLSv8gSM1Dp
 NgIPLXrVXiob6yYtUXE1z4Ps1nDHaIiLIJDnXN67MQJiJH7Ahj1hcMei8mxrqgWCT4NlVvu4r
 RYVzqZlpDlqlSGpVLlDeMPpA30hfftQnzhJm5sPCbY7YIhb3+TZUzK10qs1LSwKNdX/xFbSZu
 +S/AN6iDslSBlaqSYxeMIKFND+aeE8eCVr19KFL7MxBI/lc0QfnA0h6VwweaWML/mBGaX8jdM
 BjglKXN+7Fr/Q2VT1zOrpRdUkXVLx7ZliXU6F7AQ3HtOYEUOKhk76qQjqJE5nDKe3SpforiSW
 6Jvhts676oIKcBWbUkP7rwJMcyOI63JXVomuWip8FFPsa5ljHWakE9RUCrPjdEwtcR3ToCLu2
 QVQmPFUzcogRqjgOS7OBh0hw==

>> =E2=80=A6
>>> +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
>>> @@ -0,0 +1,338 @@
>> =E2=80=A6
>>> +#ifndef _RTASE_H_
>>> +#define _RTASE_H_
>> =E2=80=A6
>>
>> I suggest to omit leading underscores from such identifiers.
>> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+o=
r+define+a+reserved+identifier
>
> Do you have a reference to a Linux kernel document which suggests not
> to do this?

I assume that you would become interested to clarify corresponding concern=
s
according to compliance (or deviations) from the standard of the programmi=
ng language =E2=80=9CC=E2=80=9D.


> My grep foo is not great, but there appears to be around 20,000
> instances of #define _[A-Z] in the kernel. So i doubt adding a couple
> more is going to be an issue.

I suggest to improve case distinctions accordingly.
Can it be more desirable to avoid undefined behaviour another bit?

How will development interests evolve further?

Regards,
Markus

