Return-Path: <netdev+bounces-287622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8J1kF3GKBGoxLQIAu9opvQ
	(envelope-from <netdev+bounces-287622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:28:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED4E5350B5
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 16:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 30AF23002905
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16CB41325C;
	Wed, 13 May 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MmP/7yYB"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED94F40DFDC;
	Wed, 13 May 2026 14:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778682021; cv=none; b=V6/U2ec56RW9wADI1XsP0dZLxT+YNSjaUO/eObCTPk8bKRH1Gu4CgK1vVPpqIb3l2J/H1WKYZe/vI19qVvRPIQPcb7H4HTTl5DOTr2GeaAA2DHGMhRVvvuIEKTBwMniwBnjV0HkjqnRpNdwRIOAjDGxkeAri1jg5tN9RHI9PbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778682021; c=relaxed/simple;
	bh=gUgHAYjyKivgyxMRke/4UbOk9QT1gfNwOzQISxBby1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9oHOLia7hSTUqAkSllTLuJbmFu3DxnZItQI9KpiU+EZgeaNXlAZd6cMhXRv6Mf5oGuSeYprppxWFap7WiHJajcUJSLu8Jho1XDruPTofREWbGfMR+vHBOP5Ws4MvqAPYL3W3wWAHi+vD1Es6KwaRJMiQdCYJWg3o5OLEUUi5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MmP/7yYB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1KGdq3185884;
	Wed, 13 May 2026 14:20:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JT2NkC
	zwtcz8NARQRzDvGWcV/Afdd7Qc3nv3RUHAqLg=; b=MmP/7yYBqtRZoEWHiNb/3B
	ByREnMs9YfKEfxTH8ccO7gd0Mtu0Gvkh9UH17USkcAqm3RoIql616mofD5sRtnWB
	NyGTagZOcon+BfAR4lxS4nqIX0Fz3+k5Vx9rqBbB1VLkOxI3JwoOw4LT3eXGPWXd
	77m12a4Cgrrnt8orwecobwJ8sJWQcFeZfSSa4Bm47iVBAfs51bDFeZab8cuRiyy/
	88BhP59BajYOZBUdbsVIb9S4OyvqmG7MJQUpvmC8TfuWIezZWfISMsrbFLisU6Re
	ggV01qYCKTyOGPI/d/qnpLiSdawEjJIP2Do96L9cZWjVfLsaN7HKpJtOm4JSUwkw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5g57t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:20:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64DE9Qpv027553;
	Wed, 13 May 2026 14:20:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgr2xw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 14:20:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DEK3Og50987416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 14:20:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3D812004B;
	Wed, 13 May 2026 14:20:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9080C20043;
	Wed, 13 May 2026 14:20:03 +0000 (GMT)
Received: from [9.111.147.252] (unknown [9.111.147.252])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 14:20:03 +0000 (GMT)
Message-ID: <fd5245fa-b46c-4f83-955a-dc0376610b89@linux.ibm.com>
Date: Wed, 13 May 2026 16:20:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [net] dibs: Improve DIBS prompts and help texts
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1afbbbc74669f053414dcbabd909e52e7eae66e0.1778678915.git.geert+renesas@glider.be>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <1afbbbc74669f053414dcbabd909e52e7eae66e0.1778678915.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a048896 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=tvvughekWicG6Jq8Y3cA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6g9g0uh12dN4EMLANuLQjUXB4hJKe2zJ
X-Proofpoint-GUID: 6g9g0uh12dN4EMLANuLQjUXB4hJKe2zJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE0NSBTYWx0ZWRfX137RAU8Z1YXr
 LmrRVbp2DtQO04acYB1bDejyB7jKlmxHGxBX7szKJnC3AX8eM8OhZRpj5PDaA0w115hWv8syRX/
 0jlBtZEeeTreDEDduoKMkw7Yg5/g5GPWK6mAXW5L4yIZDgKp7LIEjnSydp+6dhPwbmJVZLCDT7c
 8j6TFilwJnl9HW3HATEk7niUCGrZ0fkgTeBFSDn1nAiNhQLYAqSxKR8cZ48HTjjOSUCiSIEcGrI
 RCjmcd/SXr74Kj8qkSrOJJJLA0gR86x3LC9+ddoj+Fze/dBB4TFztjoLlTjYgFeeVpIXVwnkNx6
 x9qN+IJ1AAnOw33kNsFq8D4lUJk9g7qZzDQJf+t0GHbiwVgJD8DXg22tsAgen+LJg3pE8U4CNxv
 whu+pU+V1i+vkVlWyJfAdnDZ0ziu9vdMLi+3/40AEl+g9irNVXtcthHBraGlzwxlLp8INI4ZfWk
 37u6/VNxjNfR6rOpqmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130145
X-Rspamd-Queue-Id: 4ED4E5350B5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287622-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,glider.be:email,linux.ibm.com:mid];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 13.05.26 15:29, Geert Uytterhoeven wrote:
> The Kconfig prompts for the DIBS options read:
> 
>     DIBS support (DIBS) [N/m/y/?]
>       intra-OS shortcut with dibs loopback (DIBS_LO) [N/y/?]
> 
> Clarify the DIBS prompt by expanding the acronym.

Thank you, yes that is an improvement.


> Capitalize the first character of the DIBS_LO prompt, and always write
> DIBS in full caps.

dibs is a shim layer between other kernel components and code pieces are
typically lowercase, same for sysfs paths. It is not some formal standard
that is documented anywhere in uppercase. So I'd like to keep it lowercase
in the help text.

> While at it, join the first two lines of the DIBS help text into a real
> sentence.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/dibs/Kconfig | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
> index 5dc347b9b2350667..f2dd4c3e7c5f6d72 100644
> --- a/drivers/dibs/Kconfig
> +++ b/drivers/dibs/Kconfig
> @@ -1,23 +1,23 @@
>  # SPDX-License-Identifier: GPL-2.0
>  config DIBS
> -	tristate "DIBS support"
> +	tristate "Direct Internal Buffer Sharing support"
>  	default n
>  	help
> -	  Direct Internal Buffer Sharing (DIBS)
> -	  A communication method that uses common physical (internal) memory
> -	  for synchronous direct access into a remote buffer.
> +	  Direct Internal Buffer Sharing (DIBS) is a communication method that

I could consider changing this to (dibs), if people think that is easier to read.
But I thought it more obvious this way.

> +	  uses common physical (internal) memory for synchronous direct access
> +	  into a remote buffer.
>  
>  	  Select this option to provide the abstraction layer between
> -	  dibs devices and dibs clients like the SMC protocol.
> -	  The module name is dibs.
> +	  DIBS devices and DIBS clients like the SMC protocol.
> +	  The module name is DIBS.

The module name is definitively dibs in lowercase.


>  
>  config DIBS_LO
> -	bool "intra-OS shortcut with dibs loopback"
> +	bool "Intra-OS shortcut with DIBS loopback"
>  	depends on DIBS
>  	default n
>  	help
> -	  DIBS_LO enables the creation of an software-emulated dibs device
> +	  DIBS_LO enables the creation of an software-emulated DIBS device
>  	  named lo which can be used for transferring data when communication
>  	  occurs within the same OS. This helps in convenient testing of
> -	  dibs clients, since dibs loopback is independent of architecture or
> +	  DIBS clients, since DIBS loopback is independent of architecture or
>  	  hardware.


