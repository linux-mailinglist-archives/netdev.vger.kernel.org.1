Return-Path: <netdev+bounces-246309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BAFCE931A
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3022C302B74B
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656482D7398;
	Tue, 30 Dec 2025 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="NGKwMX2M"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D452D480E;
	Tue, 30 Dec 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767086120; cv=none; b=t8wKDaMRtrm6btnabD/7hwPHCOjnJn2g405G0A8MffdYy4RTB8SvC5q6pMXh9webH7ogN+fuifujMxav4/TlIc6xtIA1r11B5TbAwii+PGvTrag/dmubpxFax07AFkVVsRHaAi4bv7K9PB+lsGHss41y0Ga0zbj5jknKRbDyhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767086120; c=relaxed/simple;
	bh=nKlGD0iOh/5/xMlfN3ETty6x8mzuOc5TnJO1QjTdUPA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=j/PUe+lCFSs6JAo5o39e/Y8cQrFyYebHICKWvt1XG80m6JLq0H6uxMAMM3HtJ2pOVGzssd+G6195MY31tae5RaitklAFf9sHH6akCkkIlUoa/twPMF8E+8gHxg290dFRdRhNn7INiPjiXE7ypGwQAwnSf4pd9tQs6YDhtS40ueM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=NGKwMX2M; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1767086109; x=1767690909; i=markus.elfring@web.de;
	bh=w2En0UyjEUsIhglvZPuZfS3PKF17UZ3RB3fhzFfpiBI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NGKwMX2MMSfpy3NrlKW15e4NL37xyE64pwEsqexWN3xDyYaxY271EmoSUE3MtxK0
	 JehDimpNug4PTRbUSVHq+Gaxu1sYmyrGbqnMBDcB6uRBAfK4REuY7BruRBPr0j78w
	 w5I9KB3qL+6NbcCs2lJZgAQssaeUOuKCiH+aXzJkX94ieH9+9ZKLlH8cInKp+4s1d
	 4AZyCk6ZmdAEN+4gHOzONgyFHcKW+a1doSihd0RG4frtEokYM9G0955ywOv3H2G8b
	 AGv1DpJtlkdXyafjrNaz+eUATxrWiGK1KieSnkFEebBcKorm/HIT7yIalc65XkbnV
	 JwrUsYQBN1o5cdgAsw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.0]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmyr7-1wIgo73ojH-00ZQ2j; Tue, 30
 Dec 2025 10:15:08 +0100
Message-ID: <2835cc53-326d-41d4-9ca5-1558c0ccbbaa@web.de>
Date: Tue, 30 Dec 2025 10:15:05 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jianhao Xu <jianhao.xu@seu.edu.cn>, Zilin Guan <zilin@seu.edu.cn>,
 netdev@vger.kernel.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Paolo Abeni <pabeni@redhat.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>
References: <20251230071853.1062223-1-zilin@seu.edu.cn>
Subject: Re: [PATCH net] net: wwan: iosm: Fix memory leak in ipc_mux_deinit()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251230071853.1062223-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fInRbEpN2lz+Mbs4YicpQSScntASu/ilH8zQdUwZ3QLroJjN7Fd
 HHo2VigRj2B31Ou8Tv7DaUty/mDXItKnjo4izPHajhT0FF2PSA+IgUq7T63xasWa/JfM7Lx
 MLR+PLSBxRh2GXRLNWT97zu4KvuOP6Vx/Ht6Lc8q+LhW0qEjMuxfK6Ua9u85OxDmCvC0Blx
 c+y/4hRftnpkS2y1akyIg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eaKYI5gbp+w=;Or7S8spFstaNbZepLsLjYRaM++D
 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

=E2=80=A6
> +++ b/drivers/net/wwan/iosm/iosm_ipc_mux.c
> @@ -456,6 +456,7 @@ void ipc_mux_deinit(struct iosm_mux *ipc_mux)
>  	struct sk_buff_head *free_list;
>  	union mux_msg mux_msg;
>  	struct sk_buff *skb;
> +	int i;
=E2=80=A6

May this variable be defined in the loop header instead?

Regards,
Markus

