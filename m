Return-Path: <netdev+bounces-113573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E1593F133
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 11:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35F951C20981
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 09:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23911770E1;
	Mon, 29 Jul 2024 09:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="dgz5M7nY"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF452F5A;
	Mon, 29 Jul 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722245639; cv=none; b=Y9fJafHoaYr1uEmgq99zmVf8uxFhkeK2dY5ux4NzqsGq2l5uMjWKYwGztpYwauSjW4AT/hnYgtUnImb5a6ZUHXHEbJmxN8Lpi0fPBRo1IBdnqVVJO2w6CjTQHAU2PLZeJmJF4x0TDuOoMvVX2xIbnEAdGcFrkPQ+X8lCcnrAveE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722245639; c=relaxed/simple;
	bh=LtwMctIoW35Cjmp4m333CqztOaLR5iM9IC6IWGkwdG0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=SbI25W40xZJfxu1Cu+UIeWGHNQGt1aGz9VKtS55QB5E/qcsSN22KDauTJSDicoVMf9Z9KF9mNxpx5UhfzbUrDh+a9iAQeIwVpzuIW0iP7zOht5+ahh2eOb/pK0k5vMYAuFh+SaGOow5uXpQBLvbpKdzPdCWkRnGtkuxRBOSRcQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=dgz5M7nY; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722245607; x=1722850407; i=markus.elfring@web.de;
	bh=LtwMctIoW35Cjmp4m333CqztOaLR5iM9IC6IWGkwdG0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dgz5M7nYkdUgDwK9phzTsFPm82VqCRTScEFyXZ0xCLqYRMM495yzwB56/yhyJQzJ
	 utDkk5YveJBb48QPLlxsKqUAEM2KzRvdVSij0hZBOS6eu01sz04R1o2uISiZVPdt7
	 2Ck1DFvaPaVkLFMSwux0P69orXfcfr7Q1dOp+YMGZzxNBG/DHhwlRy6Po+3O8jkAx
	 GbD8rHu/h1wsukr0fFfCwQ3TbaI/Sw3TAQXGnIRwWNUMxbV/++JKhJSx1zzg2Ga6Y
	 Z3J1Y8YSH5YzIDNBs9ABAvicf5ZT0CKwJnOc4aWa+3JOstiys+ba8O+RFmA8koS/7
	 lHAbaQZZeH3SXYP2dw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Melaj-1rxvwQ2dnR-00ex4k; Mon, 29
 Jul 2024 11:33:27 +0200
Message-ID: <446be4e4-ea7e-47ec-9eba-9130ed662e2c@web.de>
Date: Mon, 29 Jul 2024 11:33:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Justin Lai <justinlai0215@realtek.com>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jiri Pirko <jiri@resnulli.us>, Joe Damato <jdamato@fastly.com>,
 Larry Chiu <larry.chiu@realtek.com>, Paolo Abeni <pabeni@redhat.com>,
 Ping-Ke Shih <pkshih@realtek.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Simon Horman <horms@kernel.org>
References: <20240729062121.335080-2-justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v25 01/13] rtase: Add support for a pci table in
 this module
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240729062121.335080-2-justinlai0215@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tB92qHy0RNzSNawe8kxkUW5GhwESMFSlcQ1cESk5ZZ4Of7efVBs
 MpxT3NuHDgREIG7J+UhvBS9QgANRTn6hYnkylxliG8vbz2lNiVszASzScSwLaH8JjceTUAS
 zTjCZjach2O33wF1WM6e0gZthuNAqgF7fdyL0pS+Sh3NfcAtUHG544SIQWApFYIvCM4qk5+
 f2Jq3Kyu4swk9QplPzXVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R2nTMJm2YdQ=;luShWSeSJNHJqAC+E4H/cuxFJB7
 9p6+upHxXudW8NPBviaqQ536/urKnv6CccruDWpL1nP5dLq6xq4BlPjiimr/KdBXlLZY0yO3V
 aANQA2HuhydGJJ9S1K/JfW08my5ftIIuhMMZxQrsEhcXEbAU8Ua0fDm+p7KVddnIpg5gvtbcx
 Jqmp/btNBKE0x47xEVXxtS4Qdz3mVtOTQCz7WPcOjToVmA2gRd5kyl7BW9hMdBLbX6Tr2nzQS
 4aFTqB+r3hGOimtyfPEYVDygBJqjf4bl5cL5pYdtVfNt8ENRUnI9D88oodAiKB30b8hpuAqkR
 HEm1Y1Y9j356iUMAPOz6I16zWbVmuvAslzd8ZgDsxDcV8vmO5SG8is9B1ASgqn41TABwsYcEu
 6xt1pDgg9RU/HXuK7lqpHhZowT9eeSQmEGjqULPfKmXJ2QEuj/gHAUAiyp1z5x9G60aRrG2R2
 T1Caee/NRA+m5mujxlQv3dTnMNNp6Amuwc1J24n1qOtlUM4YgfrFzkjn83JzA/UUh5d21xP2a
 sgltc7Hf0RAdze0dNStaZHPVVn56eZPw68PBDOhOUTdyQHllEgaZfnIixqsF1JsyK4rbb1X0t
 iV9vrBPITtmWF1VsqIFodQVCdxqA9moLApd1pTwBAb+IVGVWbnDxI7pRdMCQGBtLfe7tLk7yw
 D/U3NmDFpjN1n9kje5PyR9R2bJAmO0CtvqZKaZoFFUJz6MXk/T+1Lbgr3aGVmGPjbfJZGmtmn
 kRhvBxpJMMvbUB+JZ/Is6A9x8XV75RPw3j9ncY/O5O+Df0JzI3hS6Fh2RgwXCJ74ZWrL+AU2K
 2Ska7KTpkoNsZqFvkQ5QECWQ==

=E2=80=A6
> +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> @@ -0,0 +1,338 @@
=E2=80=A6
> +#ifndef _RTASE_H_
> +#define _RTASE_H_
=E2=80=A6

I suggest to omit leading underscores from such identifiers.
https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+d=
efine+a+reserved+identifier

Regards,
Markus

