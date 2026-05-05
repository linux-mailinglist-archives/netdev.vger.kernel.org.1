Return-Path: <netdev+bounces-284343-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN4gIAHV+Wk1EgMAu9opvQ
	(envelope-from <netdev+bounces-284343-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 13:31:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B994CCAB8
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 13:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 556963183D3F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9AC317176;
	Tue,  5 May 2026 11:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="gjXYnDtm"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA78324B2C
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777979282; cv=none; b=CBXfUzlTEAg1b5cJudM0Dmipc/wTs16DorO1m3/R7HfZX6NxKKCE+4IRyr+IatObman92KjYZ+ZrWRnVsa4pVEtqo9qCZO2XRmEmi8mX9YxetqQ5LZF4qsKiQHZy+q25Nm8e7MRX9zxLiLmiqSJTdV/dG2dSg0ouFe3tBQbZM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777979282; c=relaxed/simple;
	bh=Fii/dsbfAyXWJL7iw+03+orRhArbE2fhaoRBiGFLhGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtDMCp7NObMwt6t9sbqxoa0j1iJIBFs4VRfd4eiUjFkfLMJUK29rdBdl+F95WM6bKFQ9SxZJdpaouSRM+Anyf//a6WqOxxDwiXmrJNZIf78OPo6oiIQIDXTmI8Mv4gTdqRHEVdub/kNXD8AHjOolveHKAJipQsOEKXVPlquPVMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=gjXYnDtm; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 659F01127D0;
	Tue,  5 May 2026 13:07:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1777979272;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zWUvHbmQg2gLg9orv/4xYL+TetgUltH2/efGS+YxUmE=;
	b=gjXYnDtmlWGdogF8E40yOAx1IlLmTxNveXGIzfIGNnejnFHIrchBOrN5l0nOXX3o0qbXTh
	BFDEijiyEXXnTC97InXdx/yT8ippKvKCkuqTmcUWKJUXg2m5DfaPI+zV+8j518MsAlsYic
	3as7tjdHV0UZZrKhB67e7YoobtsfixiIhuae1eL9CNefCTj7BG1dBku/eMwPzJNVm6Si3C
	CSJwDYiSesa//OSYi+jALaQ3zkPEiz444XP0B5yxMQAwb3633q3r0O+SbgdJsX0HcsNb/s
	JWneHQs0we32Xt3/c4edM4hFdkmNww4rcPV9Umprka7VjYFTntCXRV1Q6Yt6mA==
Message-ID: <8b77f257-6fed-4429-ae8e-6a2bf266a0ab@nabladev.com>
Date: Tue, 5 May 2026 13:07:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fixup! net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Fidelio LAWSON <lawson.fidelio@gmail.com>,
 Sai Krishna Gajula <saikrishnag@marvell.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Woojung Huh <woojung.huh@microchip.com>,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260417-ksz87xx_errata_low_loss_connections-v4-1-6c7044ec4363@exotec.com>
 <20260417155025.488290-1-fidelio.lawson@exotec.com>
 <BYAPR18MB3735885B13017500E153FEA2A0202@BYAPR18MB3735.namprd18.prod.outlook.com>
 <18cfeb86-9879-4644-b2f8-ab7775287b1e@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <18cfeb86-9879-4644-b2f8-ab7775287b1e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: E6B994CCAB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,marvell.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nabladev.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284343-lists,netdev=lfdr.de];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 4/17/26 6:30 PM, Fidelio LAWSON wrote:
> On 4/17/26 18:10, Sai Krishna Gajula wrote:
>>> -----Original Message-----
>>> From: Fidelio Lawson <lawson.fidelio@gmail.com>
>>> Sent: Friday, April 17, 2026 9:20 PM
>>> To: netdev@vger.kernel.org
>>> Cc: Marek Vasut <marex@nabladev.com>; Andrew Lunn <andrew@lunn.ch>;
>>> Woojung Huh <woojung.huh@microchip.com>; Fidelio Lawson
>>> <fidelio.lawson@exotec.com>
>>> Subject: [PATCH] fixup! net: dsa: microchip: implement KSZ87xx
>>> Module 3 low-loss cable errata
>>
>> Since this errata is a fix and pushed to "net", adding fixes tag may 
>> be required.
>>
> 
> Good point, thanks for spotting this.
> I’ll add an appropriate fixes tag referencing the commit that introduced
> the KSZ87xx support, and follow up with an updated fixup.
Could you maybe collect the fixes and send a V5 ?

Thank you !

