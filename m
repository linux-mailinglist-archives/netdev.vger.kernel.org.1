Return-Path: <netdev+bounces-273005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id i9REMmOGyWl0ywUAu9opvQ
	(envelope-from <netdev+bounces-273005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:06:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD4353ED3
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 22:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACD0F300876D
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BB021257E;
	Sun, 29 Mar 2026 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebelreich.de header.i=eitschman@nebelreich.de header.b="BoIkUrIo"
X-Original-To: netdev@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36701F5858
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774814817; cv=none; b=LMM6XHMo1wjWkYXoSfcv9iixhcNy7wShyikPIVpYBAHa8rhCk2rTWXauEGTdGvl6bRLH6XnbKl7kmXCNfarctV6uGkuc0nzYWXh/uAOsxTcmZPBZqyj3O3j1MCAtnka64+4YZ9DhKDbD7ZAOTO8hHqv9HD1VmVBbTwFo2YgpcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774814817; c=relaxed/simple;
	bh=rOFVWryWour3tdlBTW7iOgqO5UprJfSktFu2+9e3HQk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=KTLjAocIfoQsz3fbDDkQRE2Ay2TAFPzzHVCnEQrgakwsuNbTlUK6wSYBG91kUHvUhRxn97mEm5CRsgwsPS5h4lC47PwWsJhLsjZ2Fu7SnkDdgfVfdYgPI9LZzoXJARIsLc+UVWJvNDi3n6z1uIqgWLXJU2yVpPWaq9EIsnfmMaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nebelreich.de; spf=pass smtp.mailfrom=nebelreich.de; dkim=pass (2048-bit key) header.d=nebelreich.de header.i=eitschman@nebelreich.de header.b=BoIkUrIo; arc=none smtp.client-ip=212.227.17.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nebelreich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebelreich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nebelreich.de;
	s=s1-ionos; t=1774814807; x=1775419607; i=eitschman@nebelreich.de;
	bh=G9wEL7YhtGTlkZIbfzXrBHx4q/WG4oQ21I3JWs74ZMg=;
	h=X-UI-Sender-Class:From:To:Cc:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BoIkUrIojGZGLtTY3jO6p1CJQmhSBYg2Ba83FgUKpcYNqCW0lrSf1ri9ZjPxPOc9
	 7Mk2ewEqOlCfUWVK8wBM0dNTWcrcUit8C+sPIbS3KpQ/r3Xbvl7+H+ls2hmTg5NnW
	 m6sacga51+T7rjZpbnvRjfdwXsWMVg7kyFlNhNSBQu6EhTg0zRYUfxUiyKIEJPqNQ
	 dN21THILPtuTs6DLchPozXKvl9JjL+tHtMSgTvmseIvK0weEyuM7c+DO7fxpKwyQr
	 Fkk1mdHADgTfEATW5ydAYmmsGL2/neKNVhbN7UieycQkpW9isXuSoe4qOblZRlpPV
	 oyYxSgg2B9UbPUA87Q==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from client.hidden.invalid by mrelayeu.kundenserver.de (mreue106
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MV5G4-1vztKd0zA6-00XNt9; Sun, 29
 Mar 2026 22:01:09 +0200
From: "Andreas Haarmann-Thiemann" <eitschman@nebelreich.de>
To: "'Linus Walleij'" <linusw@kernel.org>
Cc: <ulli.kroll@googlemail.com>,
	<netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <006201dcbf63$84593aa0$8d0bafe0$@nebelreich.de> <CAD++jLmVPCL6p3jcdg1y_w=Zij6oVdWTvSmQFjWLn4yRJL4g=w@mail.gmail.com>
In-Reply-To: <CAD++jLmVPCL6p3jcdg1y_w=Zij6oVdWTvSmQFjWLn4yRJL4g=w@mail.gmail.com>
Subject: AW: [BUG] net: ethernet: cortina: gemini: skb leak in gmac_rx() causes kernel lockup under sustained RX load
Date: Sun, 29 Mar 2026 22:01:08 +0200
Message-ID: <000c01dcbfb6$c8fa6b40$5aef41c0$@nebelreich.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLUme4N3xNJ0EwL8UVC5C2k8HMTYAH+30GOs8ZCkwA=
Content-Language: de
X-Provags-ID: V03:K1:9ezzx3KcIaT9BtlchuUc8xv0bbAlDqMAb5FzatEXOkeq3X3bYAX
 MmdUe8KpGFfCjTvxnZbMRkWY7sjTt5Sgg3F2wsOO8S7hg1t8B09CoMcVMD/ieytViedKwkm
 yPUs03mnxrAgqqPPeCOZOB0R5BH5ozWbw/mYTgKtWcUG/Iv5cAFV57eDH7pZ1KdexBh4nOt
 HdzIpLJetkl5m4WliUTPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jpco1jQQQxU=;rizAXQ0hYQcFcbQUwejip2SFiwW
 NvqL+AtXyc8nvlmFT0fHsXcm8fKYpciGFrTZJDUigrkGRKMmcqrRBQX3sF6RDDBRIhDeLhGGr
 fGVsyT5tVdZbI9DPCk8WEopYbKe4U+NVFflDJGKd7Iy/3H47KNmmR4XxGBS1+XYMhSQhdTP4V
 QdAgMX7L06AvBOJ1a8rD3aXrqsQu3o1L0j0gjhdrTtGUa6TgnMEaWr2J+02Pi7r8yDvKd52NF
 0GttkJlmxCtfZ7ofmO5mHGTRzqDgvZNILeitADjiamS6MHasbSZD8THCxqRqmwgo24bcy+kDo
 q/Bpjt6R4XCCHK2+FiCNFwzEh7NtjWpT4EJR0lcaDgNvtP5mj2HKx6B7/qD0vz1VFMIZTVmtg
 ZyZW8a21IvvpK2USQSQuEpJE47Fj3wuBXpqMAVUf2Axe3PJL3ihzt8vsQYEvIS3mKI36Qk3MP
 tCb2QAH0bPxy95IGInyFgL9VHK4d60sWxzn0gqPLJezNgdIZlN7NxK4CUhw6nC/66OfoefI4v
 XaeO6y6qNd7xtaRvIArwGrBb2L83X9EApdHEdRqVJQRvL85EH37fZBMFHQ8IYXf0ZZV/wl1mM
 +lb0Q8cRnsTgxEA6ebmkEBlgkqeeLpNW4u5NNcXqQ5wSYXaHaUMpk7W/VNatNqc2rHENMyXc7
 0RqjqPi1bd8MbJnu2cn8V+O5+f6quvnMl7o8O3xhYdsqq8NKXKcrUks3vb+zSoZ+60UZCfFdx
 J0NO/+/o7JNShHV0PodwEjIEoy5tpuUSeGYuZFidqC/4I1dvwjFkwHjERfADJg3ai3X7WxKER
 gnRDUhu4GetKnTdLgs0RIon+CXpcUOCEUGdgfjzf4OPPoPFjJuGVK8Vh6dbyfxfBdZU+6PGkM
 kyvOtrvF5o1uwylexQVAhT9YrlP2QOZpPKGwsxr2RiitTJuBRqxPKu+vAPi7QIPfe+LTZQDJ+
 8OQY2kNWNlaFZAhWZHRdAvqoTojYA9y9vMaxfxQzujGhFSACbjQbHRjegDDXS6AA4xw+gaB4G
 4drtP883LWDqOM9j6cfztEf1a173H/lbAOdbHraHEldMiApIS48pwZLOwLA1/qTIFjBu3c/sj
 Hvmmg+oubDCTC04GuyLwcsw07mEU22Wa79O15jKjsyEzup1O3NbUceKQU4ZAQvSD9FNhyriZK
 hnmwXgJHXiif9xioPAXwvJWpZiMq5cpEq23xeNGvtVMespZ5RZCNWVo1mPdoVQUcpZmqXoeBN
 RhPhdi6IDjT92AznRS58S/o+02yMqF/d0TEElALI1vvw/H9SuM72mDG3zd1Pr5ma9XFkqNb+b
 z8+FBxsLxMzBLz2yb4Pwkg23KyUu0sBTKgkjhwc37SlGxjoHZoHg+fimrmuIeP0gk7rVvPOw6
 yRTZWZEh7ZRC7DZiWNV8QAWcdiY33i7aXr+z6cz6XOlFlh+HXc72MYTb3lp7i34C/GU2tt4TZ
 vmVJjoJFG49X5ubVHx+SFzj6EzcYTJaUVt8aF9JF/xrLmufG5S0Mtp8HlqMOJLHyYpromZkgJ
 7R35SAU78riSW0dBqjBRAaj3n19S1oIZVf+PDmoe0O2SO7n0tTcOcSH8elowX58LYN/VfDJ+t
 r2k1APQMR4TzlCApsDveq1b4AbTzkGjWTkFvpzhCZH7dckF701ZF/swdlxEJEVf8l96gHW2ko
 6BnR3KNZdIDtABIxdGW9jnFSkhElYygweVE0TxyVGL1e6Sp7MF/VFSkrpy13Jljybu4BqHNLG
 ALfwgn+ICN4+J2+eyiXPnK0vbwoD02B442fnuwHfiVizfoYs3VN9jQR/o3Z7X7Zenjuwp+cdG
 UA8g7/lhvUU7qwR0qRs2UIlfeQ==
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nebelreich.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nebelreich.de:s=s1-ionos];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273005-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[googlemail.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[eitschman@nebelreich.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nebelreich.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22FD4353ED3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Linus,

thank you for the confirmation!

Here is my Signed-off-by:

Signed-off-by: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>

Please feel free to create the patch from the inline code.

Best regards,
Andreas Haarmann-Thiemann

-----Urspr=C3=BCngliche Nachricht-----
Von: Linus Walleij <linusw@kernel.org>=20
Gesendet: Sonntag, 29. M=C3=A4rz 2026 20:54
An: Andreas Haarmann-Thiemann <eitschman@nebelreich.de>
Cc: ulli.kroll@googlemail.com; netdev@vger.kernel.org; =
linux-arm-kernel@lists.infradead.org
Betreff: Re: [BUG] net: ethernet: cortina: gemini: skb leak in gmac_rx() =
causes kernel lockup under sustained RX load

Hi Andreas,

thanks for digging into this, I have wondered why this happens for a =
long time but I'm not the best net developer myself.

On Sun, Mar 29, 2026 at 12:05=E2=80=AFPM Andreas Haarmann-Thiemann =
<eitschman@nebelreich.de> wrote:

> diff --git a/drivers/net/ethernet/cortina/gemini.c=20
> b/drivers/net/ethernet/cortina/gemini.c
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c
>
> @@ -1491,6 +1491,10 @@ static int gmac_rx(struct napi_struct *napi, =
int budget)
>                               gpage =3D gmac_get_queue_page(geth, =
port, mapping + PAGE_SIZE);
>                               if (!gpage) {
>                                               dev_err(geth->dev,=20
> "could not find mapping\n");
> +                                             if (skb) {
> +                                                            =
napi_free_frags(&port->napi);
> +                                                            skb =3D =
NULL;
> +                                             }
>                                               =
port->stats.rx_dropped++;
>                                               continue;
>                               }

This looks right to me, can you send a proper patch, or provide your =
Signed-off-by in this thread so I can create a patch from this inline =
code?

The kernel process requires a "certificate of origin" i.e. =
Signed-off-by, described a bit down in this document:
https://docs.kernel.org/process/submitting-patches.html

Yours,
Linus Walleij


