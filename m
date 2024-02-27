Return-Path: <netdev+bounces-75283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E8B868F64
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 12:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDA41F23EEC
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 11:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461AB13958A;
	Tue, 27 Feb 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="DFSuvy0P"
X-Original-To: netdev@vger.kernel.org
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242D41386DC
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 11:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709034419; cv=none; b=M6wLSWiGVBPCl7g52YBnv5KJDqqzymmuh/WvIx50ZcU/BKk7v4tC2ofcgh3JfnrdPNhOuXl/eOChSuzaLyb1B9Xcprq3ap84ez/W+V3Rx/jKBp17lzNpiTvNTJf55TY2MAibOBkXHI8O+HwxpcFg41811KVy0NdfKKvNyl4FyAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709034419; c=relaxed/simple;
	bh=RCWkA/LV3dYJPFejTHRXAkQ3Cnwynpsgw9QvvgSGaD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvlSRWGplArxCuDmblN4517Ae4kluWN7LG1nkIVXrXvuScbT+BQ5PNSyky8VTe8E/7DKsVO3U36bbttG/Rck4Xh0uL2PSn8dVwQFpglE1MVUv3pLDrEUhpQz9WIMJ5uzn40bFlFpKzR9u1DfVHPSpTXQZyXSJFfc11M8H0Zbmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (1024-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=DFSuvy0P; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202402271146509bd4075fd87b5f17fd
        for <netdev@vger.kernel.org>;
        Tue, 27 Feb 2024 12:46:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=O9MtN3amMckTj4yG25B4boLtlatA/jeZ6MoIj8UNgmM=;
 b=DFSuvy0PeMOp5IfO+EgBY0uFGeJrupHUxfOc/+NN3b5mmjwoDEvIajHlSQdkWFaEyQdjZo
 mmC6zb17Tpz8qWXc3zYiBU7XY2y8TMQ9/RFkmzEzkVGETfOIyvFNA3/W4RPkDiKbo2+EHSrW
 95NAkRoAdY1ejsNfNf2rAyenQWjFg=;
Message-ID: <1a2c7175-e7f5-42b7-9a3e-dd727eed259a@siemens.com>
Date: Tue, 27 Feb 2024 11:46:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 04/10] net: ti: icssg-prueth: Add
 SR1.0-specific configuration bits
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew@lunn.ch, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Cc: jan.kiszka@siemens.com
References: <20240221152421.112324-1-diogo.ivo@siemens.com>
 <20240221152421.112324-5-diogo.ivo@siemens.com>
 <5337e08b-a4dd-46d0-bc2e-a30b82aeeb15@kernel.org>
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <5337e08b-a4dd-46d0-bc2e-a30b82aeeb15@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1320519:519-21489:flowmailer

On 2/26/24 17:23, Roger Quadros wrote:
> Hi Diogo,
> 
> On 21/02/2024 17:24, Diogo Ivo wrote:
>> Define the firmware configuration structure and commands needed to
>> communicate with SR1.0 firmware, as well as SR1.0 buffer information
>> where it differs from SR2.0.
>>
>> +/* SR1.0 defines */
>> +#define PRUETH_MAX_RX_FLOWS_SR1		4	/* excluding default flow */
>> +#define PRUETH_RX_FLOW_DATA_SR1		3       /* highest priority flow */
>> +#define PRUETH_MAX_RX_MGM_DESC		8
>> +#define PRUETH_MAX_RX_MGM_FLOWS		2	/* excluding default flow */
>> +#define PRUETH_RX_MGM_FLOW_RESPONSE	0
>> +#define PRUETH_RX_MGM_FLOW_TIMESTAMP	1
> 
> Should we add suffix _SR1 to all SR1 specific macro names?
>> +#define ICSSG_SHUTDOWN_CMD		0x81010000
>> +
>> +/* SR1.0 pstate speed/duplex command to set speed and duplex settings
>> + * in firmware.
>> + * Command format: 0x8102ssPN, where
>> + *	- ss: sequence number. Currently not used by driver.
>> + *	- P: port number (for switch mode).
>> + *	- N: Speed/Duplex state:
>> + *		0x0 - 10Mbps/Half duplex;
>> + *		0x8 - 10Mbps/Full duplex;
>> + *		0x2 - 100Mbps/Half duplex;
>> + *		0xa - 100Mbps/Full duplex;
>> + *		0xc - 1Gbps/Full duplex;
>> + *		NOTE: The above are the same value as bits [3..1](slice 0)
>> + *		      or bits [7..5](slice 1) of RGMII CFG register.
>> + */
>> +#define ICSSG_PSTATE_SPEED_DUPLEX_CMD	0x81020000
>> +
> 
> How about bunching all S1.0 related changes at one place in this file?

Both suggestions sound good, I'll add the missing _SR1 suffixes and move
things together down in the file for v4.

Best regards,
Diogo

