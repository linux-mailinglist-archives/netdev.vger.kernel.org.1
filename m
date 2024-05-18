Return-Path: <netdev+bounces-97107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C68AA8C918D
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 17:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C24F1F2178D
	for <lists+netdev@lfdr.de>; Sat, 18 May 2024 15:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7B94436E;
	Sat, 18 May 2024 15:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YFYszTAW"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44EB2A8CD;
	Sat, 18 May 2024 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716047289; cv=none; b=Uao3Xnzm5d3eQYI6PRsiQQLS2YJ7wo5lDOU490tBKvN5+Bn4m6accJnU9SmOeLTWKpBu9fiD9LeLONHN4rTcu7BBEHX81SweKMhec4h8pwh7J70iUQyeH8HR1ZJfiC+B44hWEeGuBGfqxqcKroN9WrCJ6llTMD/ho93yFEQMGv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716047289; c=relaxed/simple;
	bh=6CQBI/V+OTu0DG9J0ueZD3P2Z4L50xI4hu465oEEtDk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=stXfKOsc0RxzFB2oKnYr/ex3hJLL05+vBRPWXkM1yc7o2galrVmDTZOn76um/+iqmdr+Jm5K5pse5iikXiZ18lO7HBVoPEZrrn5StX3gzhHMy4Dzs6u458qh80N2CoprePYewc6evnRDkJbn8DQV3pm3LAFZLFK+W7mdb0ahf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YFYszTAW; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716047263; x=1716652063; i=markus.elfring@web.de;
	bh=6CQBI/V+OTu0DG9J0ueZD3P2Z4L50xI4hu465oEEtDk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YFYszTAWHMhh+ZHmXEI0ZXxi2StQvVxNr4rdSFrLLFITsbEFiUeKsmxtdxoo9wzU
	 0G9T0gmbIyZJAR+hR3ZUJMVrMkm+iVRp1lzzWX0gfz00l4tbnVnDm1xk+uSu7P2yM
	 s2ESAGDBgfpHdHSeX7mc0F7J/os6DfGbmCZMqp8h8s77962OPpl2BMCVX0ncy/Syg
	 tQrbzGJroGm/UdXGPXLUFzkcUCW7zIHF9isVQ8mzfsotkfUgWM34mTv9WvRq5OJbE
	 x7qRZOm16ELDs9KdCK4UFXGcGqLHAQEnSdP7XeNgZsLlCXUIGe8y8ZmIK3RQtyCI/
	 VstJO+0Wl8HJuU9Tkg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MK52w-1rq88n1oMw-00SgTM; Sat, 18
 May 2024 17:47:43 +0200
Message-ID: <d97d966e-bc95-4d43-83ad-b368ed7d7e71@web.de>
Date: Sat, 18 May 2024 17:47:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Mayer <andrea.mayer@uniroma2.it>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, David Ahern <dsahern@kernel.org>,
 David Lebrun <david.lebrun@uclouvain.be>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
 Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
 Stefano Salsano <stefano.salsano@uniroma2.it>
References: <20240517164541.17733-1-andrea.mayer@uniroma2.it>
Subject: Re: [net] ipv6: sr: fix missing sk_buff release in seg6_input_core
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240517164541.17733-1-andrea.mayer@uniroma2.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kQX8iIydzzNB+PxhL2aj41fD8pK1oP6Q2Gruh58RP4/WeX3kQkh
 JiagPXRe8fZbeAjMIjHQ5pc9Hwpg0ES+Y0lxolmHTdGL/s2PUfsYzGD9sXDJ5E+HnVo/woB
 xWMvnicO+gnpNj0oGhGzg4Xz0rxclgpefY8NlDicCvKPLnwUXPAHr/UfzZBOUAMn5GU6AID
 sG4CtCie1jU+ry8j9nNew==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/bf+4/7Ejmg=;nfNAGY9G9W60Ha9S8uKelk0KCyd
 WJxVb92xqA6cyrG9etcs1ZNUOrbnakEpZub5FVPxPK6u7s4zeI55QTTcef6ymopaYSDKVfHeX
 Jm+TJDZw8vbGjr787ZfAUsMnJo48DF04qL34VTTBJhiarn2TQ0PvqNiKzJ77QLrIVwPCKhOTn
 8oOvtFXq+UlDeD6QwQwLmF/uHKdCy32cFo6ACPv6x3GaXjhRHz4whgsrm+15Ds9m94/ZXQnK/
 bQz9pmgjStKVfrz3ZeAcLwbpN15vTw5tGHBexzpTMOV4ExU0lUhi+4PT3VBINpKeyJ+ZBh9pc
 RKE4ApA/o32gqdlJptPOi9d2/TN20WAZlFPh8AFmgkHARpT8GZdH/0DI/J6dSgqnsYdnhFMhb
 1GTSnV5RBrudagX3qtjJH2gxbNDkIBse1iVoO9tO/TPpBFObRFDxvKPpbc6929aDWzgZSI/No
 5jisMsigX79fXOpTNwxyUvBcI1Qxy7s90nD8leXX7LIXZm5Z+q/I1DTd8YTKoiH9Ou+DJXJcj
 RM7ZSpWElouS7xzNpogs8rqgzCZdToTC3olaOQu2pfypy0iD2xtVa1fCulkDTOJsLb5QCWgDA
 9PUZFjnXMhq2iFjzWCZ395XkK+dxCFam61opKehPUwiPjNO4KxT7svV3VBUVZPxW8NNPjHY7C
 7B6NM5Flf2LDSYnW0MN+iXCE8g6AUZR96LOKl4N1iJfRsS/kUGUA4s+TJXgJ8v7Ql9sZDJ5Fr
 RrJ3I4JXc04RlplAStyC3uGb5Zu8uamBCSCWhx4BvuRaPNezljncIbdmiWTx4Lh3iTVOlhefn
 mCwqlYl49FoNSXKg+EpIp1XV52W9VmBWxIwElD6nMLd7I=

* The message subject would have been a bit nicer with the key word =E2=80=
=9CPATCH=E2=80=9D.

* How do you think about to append parentheses to the function name?


=E2=80=A6
> The proposed patch addresses the identified memory leak by =E2=80=A6

Will a corresponding imperative wording be more desirable for
an improved change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.9#n94

Regards,
Markus

