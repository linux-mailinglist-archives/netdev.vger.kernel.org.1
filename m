Return-Path: <netdev+bounces-153997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C194E9FA9D5
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 05:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1306C1885546
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 04:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715302B9A5;
	Mon, 23 Dec 2024 04:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="KEfuySRH"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-39.ptr.blmpb.com (va-2-39.ptr.blmpb.com [209.127.231.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBA64A
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 04:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734926768; cv=none; b=qc0u34h6litGKSwxelpnywDtF8DXHxXGkOG7vPkxfLFqeGF96eFvmNOSrQIyGPR5cx1n9yQt1bMihwKc4mTsp+gcgevkicabA4x/MSe+kH5STHRBkrahVDTkChgkTjxFxDk33SCBeD+DGQebTwU+QACG4C28u9W8oWieDGSzuWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734926768; c=relaxed/simple;
	bh=OR2Sedhk219Jt8JI1P5JQjE3lOxuRMDPBKYTDvgsw0w=;
	h=Date:Subject:From:Mime-Version:Message-Id:Cc:Content-Type:
	 References:In-Reply-To:To; b=kj1UVTOC3pBvWXnhNgC43cLM/+6EcZcYK9YwjhncYpC1ksBGN6O5nxgxlLoouHzQBtaWrrWhVRsPGFDFXn4xHhq6uKPZeTE5l03pd5dOw3jgfACBzqGaCWmz44OiIR7idTw5GHHJLXK+FFieOrekCzAhHTDRf2fA0+y3RZfr/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=KEfuySRH; arc=none smtp.client-ip=209.127.231.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734924025; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=QoIRy9JxyB1MN/yPq4UDpPEerDUfOBGAg2UqYw6pBqs=;
 b=KEfuySRHMWaP6CUfjBgp8nVQlJhwY2gqZv4ofMTLm+h8A+6S0AXMp/NBmgUdIbAbqW04dJ
 xcmN+FzIULaPzEN0ozMU0ie7yNMNLgDcce+4kdAL/znqKLTPbMHVvSPAl+Ok7NKWeQ6efL
 TaQERtJWvoEpYdzQ468eUsyQkEN1nuJNOyK4QCCIwpDJiRkYy+IyBS9x1guQWseQzoYvKR
 6W7zLBGErV3AZQlmskl7UFMd01GlhmbcKG1/Mlt3LeKf0pt8F5pAd7th2qXLbQkUBblEsQ
 I3PY0ErYFE0j6oIEOSMfTBKMQMuF4KR//sJqCuspYW/ArmrXa1VF3iVK/IDyUA==
Date: Mon, 23 Dec 2024 11:20:20 +0800
Subject: Re: [PATCH v1 01/16] net-next/yunsilicon: Add xsc driver basic framework
X-Lms-Return-Path: <lba+26768d6f7+8a7c90+vger.kernel.org+tianx@yunsilicon.com>
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Mon, 23 Dec 2024 11:20:22 +0800
From: "tianx" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: tianx <tianx@yunsilicon.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <e219e106-72ef-4045-9fc0-db2639720aa6@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
References: <20241218105023.2237645-1-tianx@yunsilicon.com> <20241218105023.2237645-2-tianx@yunsilicon.com> <2792da0b-a1f8-4998-a7ea-f1978f97fc4a@lunn.ch>
In-Reply-To: <2792da0b-a1f8-4998-a7ea-f1978f97fc4a@lunn.ch>
To: "Andrew Lunn" <andrew@lunn.ch>

On 2024/12/19 2:20, Andrew Lunn wrote:
>> +enum {
>> +	XSC_LOG_LEVEL_DBG	=3D 0,
>> +	XSC_LOG_LEVEL_INFO	=3D 1,
>> +	XSC_LOG_LEVEL_WARN	=3D 2,
>> +	XSC_LOG_LEVEL_ERR	=3D 3,
>> +};
>> +
>> +#define xsc_dev_log(condition, level, dev, fmt, ...)			\
>> +do {									\
>> +	if (condition)							\
>> +		dev_printk(level, dev, dev_fmt(fmt), ##__VA_ARGS__);	\
>> +} while (0)
>> +
>> +#define xsc_core_dbg(__dev, format, ...)				\
>> +	xsc_dev_log(xsc_log_level <=3D XSC_LOG_LEVEL_DBG, KERN_DEBUG,	\
>> +		&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,		\
>> +		__func__, __LINE__, current->pid, ##__VA_ARGS__)
>> +
>> +#define xsc_core_dbg_once(__dev, format, ...)				\
>> +	dev_dbg_once(&(__dev)->pdev->dev, "%s:%d:(pid %d): " format,	\
>> +		     __func__, __LINE__, current->pid,			\
>> +		     ##__VA_ARGS__)
>> +
>> +#define xsc_core_dbg_mask(__dev, mask, format, ...)			\
>> +do {									\
>> +	if ((mask) & xsc_debug_mask)					\
>> +		xsc_core_dbg(__dev, format, ##__VA_ARGS__);		\
>> +} while (0)
> You where asked to throw all these away and just use the existing
> methods.
>
> If you disagree with a comment, please reply and ask for more details,
> understand the reason behind the comment, or maybe try to justify your
> solution over what already exists.
>
> Maybe look at the ethtool .get_msglevel & .set_msglevel if you are not
> already using them.

Apologies for the delayed reply. Thank you for the feedback.

Our driver suite consists of three modules: xsc_pci (which manages=20
hardware resources and provides common services for the other two=20
modules), xsc_eth (providing Ethernet functionality), and xsc_ib=20
(offering RDMA functionality). The patch set we are submitting currently=20
includes xsc_pci and xsc_eth.

To ensure consistent and fine-grained log control for all modules, we=20
have wrapped these logging=C2=A0functions for ease of use. The use of these=
=20
interfaces is strictly limited to our driver and does not impact other=20
parts of the kernel. I believe this can be considered a small feature=20
within our code. I=E2=80=99ve also observed similar implementations in othe=
r=20
drivers, such as in |drivers/net/ethernet/chelsio/common.h| and=20
|drivers/net/ethernet/adaptec/starfire.c|.

The |get_msglevel| and |set_msglevel| can only be used in the Ethernet=20
driver, whereas we need to define a shared |log_level| in the PCI driver.

Please let me know the main concerns of the community, and we will be=20
happy to make any necessary adjustments.

>> +unsigned int xsc_log_level =3D XSC_LOG_LEVEL_WARN;
>> +module_param_named(log_level, xsc_log_level, uint, 0644);
>> +MODULE_PARM_DESC(log_level,
>> +		 "lowest log level to print: 0=3Ddebug, 1=3Dinfo, 2=3Dwarning, 3=3Der=
ror. Default=3D1");
> Module parameters are not liked. You will however find quite a few
> drivers with something like:
>
> MODULE_PARM_DESC(debug, "Debug level (0=3Dnone,...,16=3Dall)");
>
> which is used to set the initial msglevel. That will probably be
> accepted.
got it.
>> +EXPORT_SYMBOL(xsc_log_level);
> I've not looked at your overall structure yet, but why export this?
> Are there multiple modules involved?
The two modules we are currently submitting (xsc_pci and xsc_eth) both=20
need access to |xsc_log_level|, so it is being exported.
>
> 	Andrew

Thank you, Andrew. Looking forward to your reply.

Best regards,

Xin Tian

