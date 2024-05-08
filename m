Return-Path: <netdev+bounces-94607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 616F88BFFBD
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279A4282042
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4668985281;
	Wed,  8 May 2024 14:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mIeKFqpB"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1B5228;
	Wed,  8 May 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715177369; cv=none; b=pU5aEclfeBPxGTKR/acDwNSdhz7WDdAboKz9wSUneD6z/TO360uMPYe93QR9g5nEFW/UHRcbCsv1MdtdZLnBxUhCirElfBIKo9TDpqsTwIY0ocDqtwBswRlsp2JhAcJn4zNyr2wjJsw8cEkGer3INcMYPClYZJw/7Cynj4BGsc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715177369; c=relaxed/simple;
	bh=fzgy4+mHXCfyJ5AoicOHwibfr+aeCNSgI8of7qlT1Ww=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Ng1xxEEusGPLDj2XDUZSo+4PQi07b8VJKxvXuXpXTcm8HmvzUIhw+txGrw+aqGZya9QNpsp4bemmKyd5aoVOAOPr8o6XIhPssAoaeBBywgz9M9UPzYyvmldaHsDjU+ewX7eA9Pg3iiOjArtOxmVZ0bDiN03M4ikA6fu3PL3xEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mIeKFqpB; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1715177342; x=1715782142; i=markus.elfring@web.de;
	bh=Ci8HjQX8tPorewOGkgAMjFb6w69V1gUEGyVbNhMY+G8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=mIeKFqpB9OvrKQ6L34lq2gak9fr5qc1aYD9MuZFHrCYfG4PbW+eaKWX7CBeOzdEe
	 e1xxubPCFrWfUo5qEWaz5ukZ3njIp+QrOrBBsJVVjEpqUPcl3ldtgbtjA6DoYwCKm
	 NiqbsHPYMf0V2TL71V2wgY6V4khDBLE2EjmUwN3aRSt2dLaWrTvYzdqfvOubUJFCV
	 6yr8g25YMeKjOz9S2YDbQf2JzLjkoxhqOQLNmMzTvE/C6ABEu9aDJc8PdXa32hvvk
	 oQ0dBQeeda66bgzcK5aGZDTsRZAEGsFAabbazKrK00Idi46Oa7cuPUE2F+y3DqcIH
	 NSNcjHWiwobFUICfog==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MD5nx-1rvfQ70jE9-001vPi; Wed, 08
 May 2024 16:09:02 +0200
Message-ID: <3e10ff86-902d-45ed-8671-6544ac4b3930@web.de>
Date: Wed, 8 May 2024 16:09:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jeroen de Borst <jeroendb@google.com>, Ziwei Xiao <ziweixiao@google.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, John Fraker <jfraker@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Shailend Chand <shailend@google.com>, rushilg@google.com
References: <20240507225945.1408516-6-ziweixiao@google.com>
Subject: Re: [PATCH net-next 5/5] gve: Add flow steering ethtool support
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240507225945.1408516-6-ziweixiao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:K4H+6zwfaC+6QAg16E2784YO4mIc0G2T9mui64mzKlR5zfH5yzA
 8qc/hLuQqUwRCNv5bxB4odN7DfmMAtVDuieZKYMcqYjXlbIsovXbSlBSYmWHX70uKihg4Us
 EjVSUaMIrPyE3OkGOW5kg9VmFGkR1rDJcLzLpbEvFPGAoWT7+ukvyuHN+E65A5WllIDKILp
 xHdaz1KZ7xT6zewdHpQ+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:37HGseiCCJg=;Bo90SZctH6Pl03ncbBVsfMAV1TL
 xCSXsrtfkfVPuudD6KhmGQGRFt84YDQHeoLhxC0r7UqZdEauv57IzzcxAwa3CFjXvYv2Xlc3q
 /j6nK1BYRbzIILfaUSaTbFgF/YvjEgy3PEkIXfXea5atvoaTCwzfKESJdzSUB3M6x2Ki/I5Ev
 6hxeEsRfY/eaJbzgnaZ1pvjVnNmbCF+eryh3mMNd6wnMGpLZK1fl8JG33dez4NnZV8sLMOODa
 BrbwlTw5vlwVoLiQF13v8a1wWiZCR5QndoqzdKD2fh3afkNyb3xF7RZ+gkIEMETVprJTqUR2H
 g80V8oPO5uIDKIN04d1StpO8safJjD4T9+kkJwOmXr4TcfIefhHr7dSFA4I3csCVug4ZZHcSF
 Ka9dChBRLffkYdnQOMrgn27L3favwBGyWQiqsuOTwFS4of/tq9zd9fC8x76DGrfQcnqAr9bPz
 i1S2pP3J3EdxPJ4SEVFnUyt2uQY7kX/md7nHIeKBZk8UIQFu0YCJtXjHXP00FxyZ6HTRthvf9
 roL/h09cG5v1RH0io7CefP+nEugOUOnRqT92aaylI4l0ooZl9k+i4kKRHzT0FXA7FiYp/IM6p
 LuZoiK0VZbaNU3OBGSyfIutiQ74lYuvnTe0xSVI6HCB71WECE1TssdvVDu2clWb0KNi3Ft03b
 9QKu3k2TXnLjasZLZokB55HaDFMqp0g4hykoQx9scDB3RxRukwtSeIeqsB6+Ml8e0R7nUQzs5
 1o5xWj6KeIDRw7KBVBW0FEU9oJjsx0T58zjxSquuhmzV768jcWW8t+66OmUgDSSNoUWVQIJ0q
 qroxQRLRYfj4UFHDCB+FMTYSiCt7s+v4vmu0XXDrai8C4=

=E2=80=A6
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
=E2=80=A6
> +static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxnf=
c *cmd, u32 *rule_locs)
> +{
> +	struct gve_priv *priv =3D netdev_priv(netdev);
> +	int err =3D 0;
> +
> +	dev_hold(netdev);
> +	rtnl_unlock();
=E2=80=A6
> +out:
> +	rtnl_lock();
> +	dev_put(netdev);
> +	return err;
> +}
=E2=80=A6

How do you think about to increase the application of scope-based resource=
 management
at such source code places?

Regards,
Markus

