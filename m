Return-Path: <netdev+bounces-209025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F4AB0E0AD
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 17:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37244561405
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 15:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2350278E5A;
	Tue, 22 Jul 2025 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="TntS18SD"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7166124DCE1;
	Tue, 22 Jul 2025 15:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753198639; cv=none; b=AH4xoLuooCjuKusGk7kzEUaEdU64QQg46Z0RE5ZWDpvM17v5kiKy1AHnGDJJmX1N2RH7kvhrb8yhTrFPNTUStdhhRGXLeC85z4eToXWyItfazBTcYH/9uOS2EfeTm+Qc1gDVPzXkRbQlR9TwcdLuQkL8XygeLpE1bFf1p6iVhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753198639; c=relaxed/simple;
	bh=9vRudx1kT9fm0OhYSnpTEwatIGsSFR9B5AOqsXa3Mdw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=DllkTSwPDjcqD6b8yta85UsKdzH5mBt961ONF6X5lEvhDPhL0mKVnCDLlyW750/OG+G7oMxvzrWWmaD1/xlKsIA6mrhJIEnQ7bRxKlPrA431sLJOqKL68lYVWwui/Dtu4Qiz2ZFw9X1/B0qxsye9T26sg9t8d46hrdbL30t1dNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=TntS18SD; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753198618; x=1753803418; i=markus.elfring@web.de;
	bh=NaK6/RFxq9QNHVkIk7snI9Kx/nnfVL4eDyfpZlhWR6s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TntS18SDmVH+ZTtQOt5/4Q6XyHUPsnU2rp8adTXXxk0ZW7WARSngDd1SbgD9j09L
	 G80+CKxJ33SuqaJGsrz3eOieG7SBA5oSKgvBdnQuI+vWPQIz27o2jbxbo58NHoyY6
	 ELiBhnyZKZlJX0DEsitQ5PdLBlt5RkjX0ozDPdNR8swFhnktC3Kur3v+47QJohADO
	 RIIqfuTP/8A/P1d+DtgaPk2SMF0sHUACx8hf3n4PJxuKI4YcHM5qhVOtQPDQCyiAq
	 9OLILo/CZoR3yOhDv0jy3TLT5cIjgdaMHLmgl9WmH5WHKXBnr3qzf/SpHP44bdrK/
	 tRiZVR51TSkFwqm1qw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3qY-1v698l2nn8-00i12h; Tue, 22
 Jul 2025 17:36:57 +0200
Message-ID: <46fb997f-ba83-44af-aad3-c8406fc7cbea@web.de>
Date: Tue, 22 Jul 2025 17:36:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Andrew F. Davis" <afd@ti.com>,
 Basharath Hussain Khaja <basharath@couthit.com>,
 Parvathi Pudi <parvathi@couthit.com>, Roger Quadros <rogerq@ti.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Diogo Ivo <diogo.ivo@siemens.com>, Eric Dumazet <edumazet@google.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 MD Danish Anwar <danishanwar@ti.com>, Meghana Malladi <m-malladi@ti.com>,
 Murali Karicheri <m-karicheri2@ti.com>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh@kernel.org>,
 Sai Krishna <saikrishnag@marvell.com>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Simon Horman <horms@kernel.org>,
 Suman Anna <s-anna@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, krishna@couthit.com,
 mohan@couthit.com, pmohan@couthit.com, prajith@ti.com,
 Praneeth Bajjuri <praneeth@ti.com>, Pratheesh Gangadhar <pratheesh@ti.com>,
 Sriramakrishnan <srk@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <20250722132700.2655208-3-parvathi@couthit.com>
Subject: Re: [PATCH net-next v11 2/5] net: ti: prueth: Adds ICSSM Ethernet
 driver
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250722132700.2655208-3-parvathi@couthit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q4vxNDLCNYUx/MWdxPaTqvyXy0TYyiEQrItXy+6yjhKJeurUc39
 iabfAOmXG6R1Xij5VZILZVi7owC38NoG9RQqTd8jQo5OTvqZOfsSslyjU806hovQC1yUsoS
 arWmk5++wRYYiZNSh2RbYYajjEWMp/cYSi2YtXLSPzhhFNRXNyztmCHgBynh1dQzAB5amxh
 LR67e9vxzYMKjqKVsKR+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:N1nOrVbTMis=;/rgcWO5i1NflaRGjsOEhKmS3+02
 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

=E2=80=A6
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> @@ -0,0 +1,609 @@
=E2=80=A6
> +static int icssm_prueth_probe(struct platform_device *pdev)
> +{
=E2=80=A6
> +	/* register the network devices */
> +	if (eth0_node) {
=E2=80=A6
> +	}
> +
> +	if (eth1_node) {
=E2=80=A6
> +	}
> +
> +	if (eth1_node)
> +		of_node_put(eth1_node);
> +	if (eth0_node)
> +		of_node_put(eth0_node);
> +	return 0;
=E2=80=A6

I suggest to avoid duplicate condition checks for such a function implemen=
tation.
Can any code be reused from another function?

Regards,
Markus

