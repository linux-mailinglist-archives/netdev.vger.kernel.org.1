Return-Path: <netdev+bounces-32049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6080B792214
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 13:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E2E1C20932
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850AECA66;
	Tue,  5 Sep 2023 11:15:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276AC2F7
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 11:15:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E67EC433C8;
	Tue,  5 Sep 2023 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693912536;
	bh=tYMC5mFOHoZooyYp0v59p//CvAfTaT1mvVu1GIr5Tt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/0oL7N6efQB3vgWR+OpkIVMYP7vH48x2YluuFC+9bJxeeJe7RxMoH6Rcf+TyvaLd
	 zEIrjlSr58Ppjmz20zNCNM7v8Le9fMWLfcDFar0n50gZEt4JzuIE7VqF815sJUVNbX
	 xbcpDBpL9lY1UO2nz5MMTyAe/FCHToKxefq6+pmacmq/aU4uVV67vvQ0UdmzTvFkQR
	 1XD973O7hdwp/178CgCV/9gHFVLA3UPC/qrRrcW1uphdMbBFJV80dAuW1BmWR7Fuuo
	 OIPxeXW+mqL+KlhqiaRUFDNlDQWUSuKPHM04NWBW+4kGjH8s3KT7sOS9FF5jXngUt/
	 qPDpl+kdYWkVg==
Date: Tue, 5 Sep 2023 13:15:26 +0200
From: Simon Horman <horms@kernel.org>
To: Shubh <shubhisroking@gmail.com>
Cc: =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: dsa: mt7530: refactor deprecated strncpy
Message-ID: <20230905111526.GE2146@kernel.org>
References: <20230905041614.14272-1-shubhisroking@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905041614.14272-1-shubhisroking@gmail.com>

On Tue, Sep 05, 2023 at 09:46:14AM +0530, Shubh wrote:
> Prefer `strscpy_pad` to `strncpy`.

I think this needs some justification.
Why is strscpy_pad() preferred in this case?

Also, assuming this is not a bug-fix for 'net', then it is an enhancement,
and should be targeted at net-next.

   Subject: [PATCH net-next] ...

As it stands, net-next is closed:

## Form letter - net-next-closed

The merge window for v6.6 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after Sept 11th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle

> 
> Signed-off-by: Shubh <shubhisroking@gmail.com>
> ---
>  drivers/net/dsa/mt7530.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> index 035a34b50..ee19475ec 100644
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -836,7 +836,7 @@ mt7530_get_strings(struct dsa_switch *ds, int port, u32 stringset,
>  		return;
>  
>  	for (i = 0; i < ARRAY_SIZE(mt7530_mib); i++)
> -		strncpy(data + i * ETH_GSTRING_LEN, mt7530_mib[i].name,
> +		strscpy_pad(data + i * ETH_GSTRING_LEN, mt7530_mib[i].name,
>  			ETH_GSTRING_LEN);

The line above is no longer indented correctly.

>  }

--
pw-bot: defer

