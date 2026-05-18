Return-Path: <netdev+bounces-288988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sA0bDlznCmoE9QQAu9opvQ
	(envelope-from <netdev+bounces-288988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:18:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CCF56A8C4
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29E6A30068EC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629813264DA;
	Mon, 18 May 2026 10:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tadl9Ksf"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215EE2FB97B;
	Mon, 18 May 2026 10:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779099481; cv=none; b=bze8KfDkuOvBFXHBqP9gZJViqiPyRoFin26BQsB7Nk2GR9WmYzTsNZ2NjdHjR+wNbMI+WW2fyg6T/UKCXeJbvcffh3jP4H2BEm5CDNltMxLRT5HIMvSxD6qKCJLtdqm2Vj17c2P2yMjt+pMBNoDEVXofKRxtjzhrF2mBMbkHSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779099481; c=relaxed/simple;
	bh=EjDrs1q3Za5zZfmuOIGiz2slmJPoUOEdXowZAzwCNwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+kUaQeov1oQh+wI23pj453/tNR1N+GR3kv89N4FYtyrVF4mYhFl1ZiNTkPssTEffFjgTbcIbtmNUunG1NxgPXlaKsLjpraodtVti/M9irZyYzjgRpXCtKsvY2U70K1lkcUrAUag/A198usV4acFcjnsgv/oNu3ew4KiduU+rKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tadl9Ksf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I6qiVe3469512;
	Mon, 18 May 2026 10:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QZjPD9
	P0PzuV+a5TlqUmXiBAoLDcD5T+lt91CptJ5aE=; b=tadl9KsfaFdLFuIKYQlonY
	6AO7yv2H0eCG4uADvFRCGV7TTX6Vl6J4PUf3VmD0WCBITTxMUiu6z8htxV77gi+K
	24pXlL367pFyx2zlNrdE38cBrpdUfC8bKdY0PK3QSqciukJxN+JqyHPGYrvnQxu2
	cqBZkUi0EVMfjNGLUjNLop35cmLwKIFSR2/eucNuTFIKxY9DZy2omwzprvuYwWa0
	fzLqT13I1pENgagoZLGAGgP5ecf4L+OHMrmIMsEAxR2UDdCUtDUfKZPodJohpOCY
	t32OfC4lMQtNUaQVkMyfy4O1BadYh70bXUvBDQnACC4BHq5stFQ5JxXlExrQyIoQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mffrg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 10:17:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IA9aGs029170;
	Mon, 18 May 2026 10:17:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kxw43p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 10:17:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IAHs4I21693182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 10:17:54 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4379820049;
	Mon, 18 May 2026 10:17:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B29D20040;
	Mon, 18 May 2026 10:17:54 +0000 (GMT)
Received: from [9.52.217.250] (unknown [9.52.217.250])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 10:17:54 +0000 (GMT)
Message-ID: <e8c23b15-e3c3-4f4c-8d5e-d459985181ed@linux.ibm.com>
Date: Mon, 18 May 2026 12:17:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] [net-next] dibs: Improve DIBS prompts and help texts
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <9093259c43e5d1996965d1522562444419196a19.1778838921.git.geert+renesas@glider.be>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <9093259c43e5d1996965d1522562444419196a19.1778838921.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: opaHNRN8AMOxBSJSeztnrPbqouyzmhJp
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0ae754 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=rfkHHJoCX--zoic0QrsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: opaHNRN8AMOxBSJSeztnrPbqouyzmhJp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA5NyBTYWx0ZWRfX/Jn6MXzEdVfp
 XKPTh1gR0qp7dyTRf05i9wp7nllnjpZ4ZG5xy8GRHABd/kXy1+XO7/uoBbQQtlMoyuItq18fJMh
 +j9LqwXGb/nuCMfGLetwJeIFXYJ1tM3CIykap2YwTlloLFkqJhlyUi/+7VsFIVAUjc+vRE+jdPv
 zwCKs3oPng4aVtPrsZugnbS0SsHLW07CURtYCFlSrQrshhm6wrdP8G8Sp9VWRJ55e2zj69J85cC
 ZIylqAt8y4EI4sBRJQ1ocGzOiagVrj1MbGijNlPfFZjmv9df509i4uJGBxS5j2wJeWaEh+671NR
 slcLW5sOwE/WpdDjd790uOmAZhNtWtiTvcmrCIpsiAz7Pyvlpf2Ar4sR4nFG1QSjIfQ1Yp3rH2x
 zMbWndx6xxah6opcFep8hpd6Tz7OsYElRjuXeT+UIBuYEDgT1K3973A9erDARXX9/nylKiQJllq
 omVEfRZ1wGaBqLz8mgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180097
X-Rspamd-Queue-Id: A9CCF56A8C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288988-lists,netdev=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,glider.be:email];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wintera@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action



On 15.05.26 11:56, Geert Uytterhoeven wrote:
> The Kconfig prompts for the DIBS options read:
> 
>     DIBS support (DIBS) [N/m/y/?]
>       intra-OS shortcut with dibs loopback (DIBS_LO) [N/y/?]
> 
> Clarify the DIBS prompt by expanding the acronym.
> Capitalize the first character of the DIBS_LO prompt.
> While at it, join the first two lines of the DIBS help text into a real
> sentence.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Drop changing dibs to all caps, which was completely wrong for the
>     module name,
>   - Target "net-next" instead of "net".
> ---
>  drivers/dibs/Kconfig | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
> index 5dc347b9b2350667..8f41e562210044df 100644
> --- a/drivers/dibs/Kconfig
> +++ b/drivers/dibs/Kconfig
> @@ -1,18 +1,18 @@
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
> +	  uses common physical (internal) memory for synchronous direct access
> +	  into a remote buffer.
>  
>  	  Select this option to provide the abstraction layer between
>  	  dibs devices and dibs clients like the SMC protocol.
>  	  The module name is dibs.
>  
>  config DIBS_LO
> -	bool "intra-OS shortcut with dibs loopback"
> +	bool "Intra-OS shortcut with dibs loopback"
>  	depends on DIBS
>  	default n
>  	help


Thank you Geert

Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


