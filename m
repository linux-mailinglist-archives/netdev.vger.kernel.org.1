Return-Path: <netdev+bounces-153602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F919F8CDC
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 07:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2340818927C7
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 06:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A987E107;
	Fri, 20 Dec 2024 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="jBAdBjLt"
X-Original-To: netdev@vger.kernel.org
Received: from va-1-32.ptr.blmpb.com (va-1-32.ptr.blmpb.com [209.127.230.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B551531C8
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 06:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734676852; cv=none; b=sj2DX1HZyeTMH8BeG8w643j3YVUyKT0oY0nubcfLtdFn3yBCoMyRYypM6mY+SRjOmAFkp4eE1mxgXd63xHz0DlmOBldVx/VxU1Cdw5YkSPpT6lOIagztUu1IEzz2g/MBDLKo+4LeBcKwmd6kcsBdPho1bTZNCazh8HcudSjKaPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734676852; c=relaxed/simple;
	bh=zz/HJasqriqgLBxrnrAwuCbZdp1Ln0TBRpQHIsA3dRw=;
	h=References:To:From:Subject:Date:Message-Id:Mime-Version:
	 Content-Type:Cc:In-Reply-To; b=J9zD+p6JcDjxPSTC6qMsJaZqRiqR5QjbrlZSoLfD+XdelG2YxAnNEJwKUJn2jYoJycjrNkFJRnUdgXMZBTZxkuzrMRJpL/ZjL/TQ8xvuZPZrrfINy4Kiu6SmmbThK/GjkGGgx1hzu3/DHFYzs2cj6sfgDrCCdyrza7W/PX6gzdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=jBAdBjLt; arc=none smtp.client-ip=209.127.230.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734676838; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Lv35BesDMzjO3pgypGTa7SLtjXpWal/M9s/35ir72No=;
 b=jBAdBjLtTf7bPpfTimvTEpcruLIypoP17eg9mgDDlglh0+OkyejS1EROT2kpcc72PdOaEQ
 vDAy/0x4FGAYMEUvRyW/8pxuy6AocUE8QT1HqQgqoNVAEERsC69DA320zEND0XiOPL+s2c
 iDzJqZ+X3t24wQM3UpOcDDHWf3F3mpHwBLgLB5VeFFz47YbNYnpJKLRiQovXJIYxhySrCT
 GU+WLo8q/bZkeXP/giypyQ3uSV++tgnv+92H9nHV/oHOAVGxHgC7/GbPiS8jjd8jkAKFLL
 PZpqrj4NelVgQW+pkVi9Ld9TUrpHIgHBTz8ROZeTM6tbLwxEV3tzv2PmWQGU7g==
Content-Transfer-Encoding: quoted-printable
References: <20241218105023.2237645-1-tianx@yunsilicon.com> <20241218163509.008d1787@kernel.org>
To: "Jakub Kicinski" <kuba@kernel.org>
From: "tianx" <tianx@yunsilicon.com>
Subject: Re: [PATCH v1 00/16] net-next/yunsilicon: ADD Yunsilicon XSC Ethernet Driver
Date: Fri, 20 Dec 2024 14:40:33 +0800
Message-Id: <c39a3ba3-ab66-4b0f-9881-f5d98049949a@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: tianx <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
User-Agent: Mozilla Thunderbird
Cc: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Received: from [127.0.0.1] ([116.231.104.97]) by smtp.feishu.cn with ESMTPS; Fri, 20 Dec 2024 14:40:35 +0800
X-Lms-Return-Path: <lba+267651164+46a0a4+vger.kernel.org+tianx@yunsilicon.com>
In-Reply-To: <20241218163509.008d1787@kernel.org>

Thank you for the feedback. I will remove the last two patches as=20
requested. However, I would like to keep the third-to-last=20
patch(ndo_get_stats64), as it ensures "|ifconfig|/|ip||a|" display=20
correct pkt statistics for our interface. I hope that=E2=80=99s acceptable.

On 2024/12/19 8:35, Jakub Kicinski wrote:
> On Wed, 18 Dec 2024 18:51:01 +0800 Xin Tian wrote:
>>   45 files changed, 12723 insertions(+)
> This is a lot of code and above our preferred patch limit.
> Please exclude the last 3 patches from v2. They don't seem
> strictly necessary for the initial driver.

