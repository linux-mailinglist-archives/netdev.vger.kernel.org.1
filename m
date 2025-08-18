Return-Path: <netdev+bounces-214558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EF2B2A413
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 15:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9B06211E0
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F67131E10E;
	Mon, 18 Aug 2025 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="C6YX7csN"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898430F7F8;
	Mon, 18 Aug 2025 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522632; cv=none; b=VHk3t6SjewtdPfywEppL40hZqUaZwrR+7BTdWcOxqO929zvOoy0n5ObnXsN79pgUJJnBUuCiLyGUVPD0mvXKtAGufhtNJM/5rcVev8Gc+QLjoZBXX1Nk7cK9UX7YjuiVAMLUdTRBJ4P1AFAkv3/XJHQzn+15F/ttkNQqjPC0kr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522632; c=relaxed/simple;
	bh=aznMTAoxRo5LgtSTK4lQ4btu5gj1FbPbhNWVnEuY9hU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=O0VfUFKifGl7Os84UBsGUBbFcegFIYYrzN7ZpbCgrhpScOc8aAK0ZoC/lcN3Yn8ebhoh8GFXogS2D6E07MeIf7bM4kAjvctz/GIDFGBF08ysvwQ3jPubfJ2sS+yRMF0Z2ZjkpcMldNQkqj88TmXdgrjw3UoMb+NGem5eeIk6YMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=C6YX7csN; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=au0sTz/mm51+Sa4SRsMXgzQ5QH8WFCLiHSCeaH4jd3Y=; b=C6YX7csNdrLRHWSgSvP1mSzkpT
	UJi4OaAf6/9RVP7vxZOs0dUgljVQrkiR2XtkmqX8uzP3OzTt6YNZTZA1TwrZ0sTJbOA1qs8rkxltG
	F5l+bi9JhRl5Q9F4rgzkW9pG76GmCEaCg4JQuULtpLfwYqbPQjTjpyqpc0y8z2JlJmZCGGeun1RgN
	GuosDbCfIpQagSF4TEvMm7EMku1SB2O8+UiJxbxK37BF8yF9sYmrbyJ4/ZWhWcPp3wtRLdWIUx7eB
	Kv4JxXfIRKw3IOifi9jboHfDpNbM5FHMvfD/R7tVH7ogcOWK9eOc2Z5gCpTdixRtIBbkRjqrGiABS
	EZk1/Mlg==;
Received: from [122.175.9.182] (port=51937 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1unzcl-0000000EI4Q-3NDO;
	Mon, 18 Aug 2025 09:10:08 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 5A75317816C0;
	Mon, 18 Aug 2025 18:39:38 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 345C21781E41;
	Mon, 18 Aug 2025 18:39:38 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id QVAtmhKDmHst; Mon, 18 Aug 2025 18:39:38 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id CF63D17816C0;
	Mon, 18 Aug 2025 18:39:37 +0530 (IST)
Date: Mon, 18 Aug 2025 18:39:37 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	m-malladi <m-malladi@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	afd <afd@ti.com>, jacob e keller <jacob.e.keller@intel.com>, 
	horms <horms@kernel.org>, johan@kernel.org, 
	m-karicheri2 <m-karicheri2@ti.com>, s-anna <s-anna@ti.com>, 
	glaroque <glaroque@baylibre.com>, 
	saikrishnag <saikrishnag@marvell.com>, 
	kory maincent <kory.maincent@bootlin.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>, 
	Bastien Curutchet <bastien.curutchet@bootlin.com>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1969814282.190581.1755522577590.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250815115956.0f36ae06@kernel.org>
References: <20250812110723.4116929-1-parvathi@couthit.com> <20250812133534.4119053-5-parvathi@couthit.com> <20250815115956.0f36ae06@kernel.org>
Subject: Re: [PATCH net-next v13 4/5] net: ti: prueth: Adds link detection,
 RX and TX support.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Mac)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds link detection, RX and TX support.
Thread-Index: xgy3E4VeZd17NU5MI/nMZAk8d4Qe8Q==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On Tue, 12 Aug 2025 19:04:19 +0530 Parvathi Pudi wrote:
>> +static irqreturn_t icssm_emac_rx_packets(struct prueth_emac *emac, int quota)
> 
> Please stick to calling the budget budget rather than synonym terms
> like "quota". Makes it harder to review the code.
> 

We will address this in the next version.

>> +	/* search host queues for packets */
>> +	for (i = start_queue; i <= end_queue; i++) {
>> +		queue_desc = emac->rx_queue_descs + i;
>> +		rxqueue = &queue_infos[PRUETH_PORT_HOST][i];
> 
> budget can be 0, in which case the driver is not supposed to process
> Rx, just Tx (if the NAPI instance is used to serve completions).
> 

We will add the following check to handle the case when NAPI
calls with a zero budget.

@@ -766,6 +766,10 @@ static irqreturn_t icssm_emac_rx_packets(struct prueth_emac *emac, int budget)
        start_queue = emac->rx_queue_start;
        end_queue = emac->rx_queue_end;
 
+       /* skip Rx if budget is 0 */
+       if (!budget)
+               return 0;
+
        /* search host queues for packets */
        for (i = start_queue; i <= end_queue; i++) {
                queue_desc = emac->rx_queue_descs + i;

We will address this in the next version.

>> +	num_rx_packets = icssm_emac_rx_packets(emac, budget);
>> +	if (num_rx_packets < budget) {
>> +		napi_complete_done(napi, num_rx_packets);
> 
> don't ignore the return value of napi_complete_done()
> --

We will update the code to check the return value of napi_complete_done()
as shown below.

@@ -840,10 +844,9 @@ static int icssm_emac_napi_poll(struct napi_struct *napi, int budget)
        int num_rx_packets;
 
        num_rx_packets = icssm_emac_rx_packets(emac, budget);
-       if (num_rx_packets < budget) {
-               napi_complete_done(napi, num_rx_packets);
+
+       if (num_rx_packets < budget && napi_complete_done(napi, num_rx_packets))
                enable_irq(emac->rx_irq);
-       }
 
        return num_rx_packets;
 }

We will address this in the next version.


Thanks and Regards,
Parvathi.

