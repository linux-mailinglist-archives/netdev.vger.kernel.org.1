Return-Path: <netdev+bounces-103979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD7D90AAC9
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 12:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F367281DC8
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 10:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8716193097;
	Mon, 17 Jun 2024 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ma5Bo46F"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417CA1922C7;
	Mon, 17 Jun 2024 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718618918; cv=none; b=TaenAwDl86NDAX4s734cWK1gnPWthDwGY5I8OxEZeow11pNeE2gTaqX/J98l1DztTD2TeTH8Sl5wOPMiHpY6MXZ+k8YFDYSmLZgQflQNZr2YSbXzqCU2i1cYlmS891YVavEaWwt3+NTdxSNuA3RFfdbwYdSXU5sZazf0dMk68Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718618918; c=relaxed/simple;
	bh=TaxsO8A8ub1Kl+G8RAHhURMfNaORdUuzVR35IOWc2Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbFfMvydFkWsPqMdQu40yj71dWO62zSi4s9oEVw5p0KWoBFy+cyy6fqYZPC6BI3rTvE+SQQBv+HAdNsqxCKnvl6WpYp/2f4BfB6xSPBzi9Rx1rwc8D8c53ihKymZDjSv7GM2rzPuY0ECyQm63Yz9P70fsFcUnrrlYz90EuASOfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ma5Bo46F; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718618874; x=1719223674; i=markus.elfring@web.de;
	bh=TaxsO8A8ub1Kl+G8RAHhURMfNaORdUuzVR35IOWc2Us=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ma5Bo46Fv0vhwksF3QxGchVDD11mEG78xEc9FyNlGsbKgZI1LlZRz7Bv72EFMlH9
	 /0En/bGvmlaau/fjcko7qU04lUOj23ckOUMih5Z9FfU8XS8P3mNUs5sIn86HIHkm4
	 BRJFUEW0vLm0UIQXQVmW8bR5pObYcbU2FTpRaRDI8+gm/xb36omiN8CEGRxJnM0Gl
	 7lJztCZlKWTtPZ7FFAMyfsyzZEr3mccH4P+lsBFfrMPL7fc+6LQiVeSEn0oE/sX83
	 uU4TQuz6Q6hf/XtTzhAOig3FUM+m+nx2Ah9MoJW1ypIXLSlb37m7iS4rtUg86nLWU
	 1+Ka/XI1DG+SceKrtg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N8n08-1sPSPM1GJa-00ulRF; Mon, 17
 Jun 2024 12:07:54 +0200
Message-ID: <6b284a02-15e2-4eba-9d5f-870a8baa08e8@web.de>
Date: Mon, 17 Jun 2024 12:07:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v20 02/13] rtase: Implement the .ndo_open function
To: Justin Lai <justinlai0215@realtek.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Hariprasad Kelam <hkelam@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
 Larry Chiu <larry.chiu@realtek.com>, Ping-Ke Shih <pkshih@realtek.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>
References: <20240607084321.7254-3-justinlai0215@realtek.com>
 <1d01ece4-bf4e-4266-942c-289c032bf44d@web.de>
 <ef7c83dea1d849ad94acef81819f9430@realtek.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ef7c83dea1d849ad94acef81819f9430@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0bUc5Xvq0TvjvOY8nCnUp3iYnU/l2VPXA976WEEsyigooLEZn/y
 CwZWd7INAFsvjsmbHp7G2BrI0EPi8ZHJXeh9IpFEb0V2k2IPT7IqWbNNM0wsUYVzffo+Td7
 hU73J1CkmQd+0th4o8yBp2cWTMJZUKwqW5YzONRX+Zq4p4TU39k2hJOBDcyy3YwLY2gM0RD
 /LflWIq8Yy+R3fVeUgc7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6lHu8sL5HPI=;Isuzt4XBBOHDeLdcrnEb4Pcu35p
 eJQH2LVasE5qYiQyEwzS9ihp+KcuvLpi1DrWv1CGJzHiM5to6zagirZ+e8WbsLpYagaj35afN
 PFNh2lStEOus6ndFdUftr1WPFET4NNaSivg8qVZmZdwT4gRKVTtHBKBfOPjmDsM8FYmm9ZIxv
 RIC+yxkRM4NLRh9cQ6wOC93wW4sF1/SVBLIbhs+CTvZnArU5l6kQYFz7XJoPoHwyYhK2ZZ9Uv
 g9AF+yr1iVB69j5PFeU02l8NOpVfvz+MUeSKivT839lVCzCqG/NrZZYW45VFesdeEf3pj3rKB
 flsqqa8MJpt1Wf6Ocnf/I3oR7tQKkWqIshICByQqIReIz5PF2dp1dz5sxRwecTgQyg5shEig6
 bzyGAhso4sPSLQdkIiYUUZbrQIUtpBLa0L+cCo2n9pABQk/cnryxftls4hBj95bKE1vbAs1YZ
 ZlVZHXtiKVl9Mj+G4NyOz1j/JlzLdmWta8q/puR/P1nKbhAoxK67NXcAJNX6+CR8EqhdcR3+A
 tvCMpSOmk3g5Jd7kzFL/1rz+q4CTZuZgnJwaygNnExVzalsYt+B/F+KZf2wQbZWDM6bR97JkB
 VXGqnJckLjwA31qaknLKXjGhPCsJl/TeV/eYPf9TB466snQ4RogD54S8QTablh9Fz0We5HrWP
 kA297vcZSpF7HQH0QpycJt7assOuvFGwLvGOjPQG4NluYrBqV+QHLIeeg4+NOS/p098EniMF2
 wUV4iC6nxCLpDG01C3kmlkZdUPUPpHGF1MooNfgwPsErk7cm3AwAWTMsaWjcpw5VLqjd4Jcoe
 wthttMvysz22q+PD5iM+s8qxYw6Epiv90rRlEUcS5SQI4=

>> How do you think about to increase the application of scope-based resou=
rce management?
>> https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/cleanup=
.h#L8
>
> Due to our tx and rx each having multiple queues that need to
> allocate descriptors, if any one of the queues fails to allocate,
> rtase_alloc_desc() will return an error. Therefore, using 'goto'
> here rather than directly returning seems to be reasonable.

Some goto chains can be replaced by further usage of advanced cleanup tech=
niques,
can't they?

Regards,
Markus

