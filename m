Return-Path: <netdev+bounces-106067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11DD191483D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 13:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434541C2203D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A0F13790F;
	Mon, 24 Jun 2024 11:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jIh/w1QV"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAA8130AC8;
	Mon, 24 Jun 2024 11:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227639; cv=none; b=GsC9OLnx0O3fVXTiEpc18edU3kv7xo7MWCdanWHI0z7bzO0hYT2RnAa8Kr39RvLYrnaGghLLKn42wJZuDQYlSxyK777JI9JUgv/mNiMFpOHnLFuhwQ4L6AkD9Nqc/JPfjkZMYYFibpUPxKY6KD3yMp9dYc3JGtCOdig7ocMfzRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227639; c=relaxed/simple;
	bh=o3voOc2ZEL+GyoIX5pkUWkNiG8dPBwXxRD6wYAksTHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=DkCKkN9lyFD9n1PwYkhedDtuqUhzfd2eUhTuqreUcFKYypj8IaBCyfPcCaiRSZgZZZ8yneBttoyXGSTearyWcnDneRc9+TW9GOGoH24EiF+MVq+aG0bwNKF0ZVAy3ryu0o8vHmaMsicn+CypaywKfnEsV5wnRHrvWNaC8I544z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jIh/w1QV; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719227616; x=1719832416; i=markus.elfring@web.de;
	bh=o3voOc2ZEL+GyoIX5pkUWkNiG8dPBwXxRD6wYAksTHM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jIh/w1QVgkXZq7UDw5BZWSCJmhbrZ2G6WZow9cUvFnfj6xUcHffVLx85og3TCUlV
	 SYX69R16st/6T/ISujQ9IYGH3wzbWuFqCt4lifBLUBo0FNegU83u/jvF1SnV5vpCp
	 s8ef2rivMAf/sbmDGYqQupTN2h7ZPYS7Wo7mVbumnEHNGckA57AsokfG/fJu98vz5
	 09JBkVJBE90l0P8p+TQSzI/E7C9ZPk6EwL9BPhABvA+IaxJFzNzZzwBsUq2rpWdmT
	 zV+EM2WF8LGAE8rfdYGTLdD6AwVOTnmJTkzta5z2gWqmYoz3UtgEKDgou1juP3ntb
	 xvWrEGRRJFJDHk5law==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHEXc-1s8WLw1KzY-007YbV; Mon, 24
 Jun 2024 13:13:36 +0200
Message-ID: <6a70fb9a-fa15-4ee1-9a44-c727bd610469@web.de>
Date: Mon, 24 Jun 2024 13:13:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net PATCH 0/7] octeontx2-af: Fix klockwork issues in AF driver
To: Suman Ghosh <sumang@marvell.com>, netdev@vger.kernel.org
References: <20240624103638.2087821-1-sumang@marvell.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jerin Jacob <jerinj@marvell.com>, Eric Dumazet <edumazet@google.com>,
 Geethasowjanya Akula <gakula@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, Linu Cherian <lcherian@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Sunil Goutham <sgoutham@marvell.com>
In-Reply-To: <20240624103638.2087821-1-sumang@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V+R6WXZ2lZrjghmpjNmWqnBP7H2DU1itTFGmqhrBHQdHhMc5x7k
 x52YYp1mFgLzTnBTzGjXJ8vnj+Cbz8dV6lVc110pvPGnh+Lmy5EKTV0T0CAzHP+wbFhtCYV
 wMQ1zQt92F0hnT9yvmj5/ON2wgz2/UCLCsNNhYldCBb3B41NEDzoOCgSGaoy1/DHABzA8Vg
 Ql2QwJbTAOhv6qy08zhhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:f9mxQdM7m8M=;HIAp20Swcn0Vrbf5owupbQdpw9F
 8Yza4InDaPlYAZjUAQ/yMlQ2Pgxl4YP4Yz2vWNgAnsuN4RJ1bRbhxefYQWC2XpVnKSZhvnzFE
 YNaqaSiVv3NU1uC3vpny3cn6zH66d+3usyyAiNo3iOn3pfgn44gqwTNgH3FT+41A7VDUvdQ3o
 abkDIzkQDKwwVgKsNatz/yVTyuNRR1sxy49cZRx1PqRJe2Gc70dl3Ls+4xJHegMOv7lw8tJnt
 xSZtRMQeDo8rrq/yOejzsaLHOxPbRyfpK+At3yaAeFieYz/EHs9YV4yJTbD7O9AaonhMStMwW
 PWFmuGv/80DHxR3nZ0YKWZhrn0LbB2yCbV2JsJV0Hm44OVIKRYPm5kpBDhQZE/gZvHGF090Xw
 +Bo7LukVyZevv2e+GKCe8Eo5VAByarKcJpKutXG/zYfqlaIG4IFCg9T0O2/pMFFGoQyKjCt4h
 2sH6eC5yT4fa5TZ4uptJgUA3G0kyAjJS6BGs+Rq3N3/ddLFIglepSUy4WfaVGkwK3pVKzncLD
 BWu7QJs83b5uhivAeUwz/m48ydQVzJRHdOlqfK2RTf2yhOB7hX73PQnO3dnjdnNU7Y5gx3EAr
 9GAnFDxkxwTsFbqUiKF4pgi/ckJ+ANTbd7i6KMKC22tooJ7Yvex9NFDwIgpUv+SBp8K7IRbJj
 MM+y6s1k2ykupVec4M2MqWSqH7RvVc+bE407yz0IjPR8g1vA292Uwd4ZzY4MPX3uiOKbvlMhU
 ldSRn6ktswAIvjthzbUC/AH6aRMoU/2UM530bovtliFzOj3ZIR4HvY/1q1VyKmt1jDul+jMO9
 OSPWl3a/Y5jLgNKtRSG8MNebgTIMCf4us5zPZ5/yYbkhM=

> This patchset fixes minor klockwork issues in multiple files in AF drive=
r
>
> Patch #1: octeontx2-af: Fix klockwork issue in cgx.c
=E2=80=A6

Please improve your selection for summary phrases.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.10-rc4#n646

Which development concern categories did you pick up from the mentioned
source code analysis tool?

Regards,
Markus

