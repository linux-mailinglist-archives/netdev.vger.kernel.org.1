Return-Path: <netdev+bounces-230550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFECBEB07B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 19:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2A334E259B
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 17:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213112FE59F;
	Fri, 17 Oct 2025 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b="M02/l1LY"
X-Original-To: netdev@vger.kernel.org
Received: from buffalo.ash.relay.mailchannels.net (buffalo.ash.relay.mailchannels.net [23.83.222.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5222FD1AD;
	Fri, 17 Oct 2025 17:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760721170; cv=pass; b=FNIQVJM3emIL2kkZpoZ8+lC/+hXCVtYl+a63N57g1rjjc47G/wxRdaNTtJ0O/tUrrBsaqCXiGGicSpxp4vSfbQ2Wyc9lf0hDt2sQTA288ORbnqNUvCucyLy5rBDnb44MZ7FFI1UcuTtO0pxtlvMf0tjbnoyVcoZ6sZD8be2erIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760721170; c=relaxed/simple;
	bh=1fP5zpgcHZFicOOflVjB2iFN8P1HFOo4SPs3CO19kQQ=;
	h=Message-ID:MIME-Version:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:Date; b=iTA/H7/KeYfokv3bsBJVl/LV7h6UhI/hYHBWhLcjCqxltiysY71vWnQXwBQ8HmEWaQh1ksXNENoaHxXOINQ85eSxhbsA6dkjjOdhyR+5e6fDOsQxuIc3P5F87Ki+6l1r9wtfByqoU6HPCS9EJVtutu4VYIeLyfYxMUhJhtGD0C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com; spf=pass smtp.mailfrom=rootcommit.com; dkim=pass (2048-bit key) header.d=rootcommit.com header.i=@rootcommit.com header.b=M02/l1LY; arc=pass smtp.client-ip=23.83.222.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rootcommit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id CFFCB701A01;
	Fri, 17 Oct 2025 15:54:07 +0000 (UTC)
Received: from fr-int-smtpout25.hostinger.io (100-117-132-18.trex-nlb.outbound.svc.cluster.local [100.117.132.18])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 602B2701AEE;
	Fri, 17 Oct 2025 15:54:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1760716443; a=rsa-sha256;
	cv=none;
	b=qsbdjJATkXL3pVbVt/nMJLo5Bik+gXYtmu8SG5torvU5Tu6ofvZlAEbLTQVm/ZAPJihpg/
	Kh1MAJNzfUVOr9EF8kPOutx7SZhy6lYppkxmnTtZrIiV4+bYK4/8CTVsxSnLPnrZmn85Kg
	fc06Cs2ZWSzBQ3/tKfcTp/EhtaVa1o+3w6dk8vS+OvninEBCmu7GaQ5/pFpDSpyLpYR9id
	gwJ8fu4L7sz2zvx4WI/VDi3E/qOZ1YBMTURVorMV/vYgjZUx9Dj78YB5ItXVyIlHMP2JmL
	9HYQEjlirZIpGb+wIqnZ2er0gNW002stlHtcritUDc3nRV48a/qQan6AVmd0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1760716443;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=F1FFVJG2rkiUWHHF25ZM11yfG5to6mYY/Am7bSXow1w=;
	b=g4gw5xwKjwzE6nyJqxtt98VD+XSdfMX7m/AsaUhBACTkHpYj8rO73kL7pTTlLm/sIMAfUu
	haDL87tDSS4JdTaHg8W0DL8uNQaIqhCAw+KsE0gA+N659ADCbK/5MBHu03lZR7QK13XjGG
	Imj+q82dRNCureS635wjDw3XaL5/vzM/zO+QTBk7jK/NkJqfJee/7RCMrZFHafwOtIl+Yv
	I9NxOU+wJcV6Y0iEWW6EE1GcCgG67qX3z4qLRgee1qoxGK0ACL49RO2JMxW9mYknvZNKTl
	/fMcPq9zTeu8YXfhS4tV6LxV6AGfC5XU4fg71EPAcyYDKXoSDGzJ1W7mj/tkKQ==
ARC-Authentication-Results: i=1;
	rspamd-fbfbcbd77-nmt89;
	auth=pass smtp.auth=hostingeremail
 smtp.mailfrom=michael.opdenacker@rootcommit.com
X-Sender-Id: hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MC-Relay: Neutral
X-MailChannels-SenderId:
 hostingeremail|x-authuser|michael.opdenacker@rootcommit.com
X-MailChannels-Auth-Id: hostingeremail
X-Interest-Invention: 3d5ae642033bbe25_1760716447513_1362389868
X-MC-Loop-Signature: 1760716447513:724433826
X-MC-Ingress-Time: 1760716447513
Received: from fr-int-smtpout25.hostinger.io (fr-int-smtpout25.hostinger.io
 [148.222.54.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.132.18 (trex/7.1.3);
	Fri, 17 Oct 2025 15:54:07 +0000
Received: from [IPV6:2a04:cec0:1210:4d12:deca:bae:eaaa:c8e1] (unknown [IPv6:2a04:cec0:1210:4d12:deca:bae:eaaa:c8e1])
	(Authenticated sender: michael.opdenacker@rootcommit.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4cp8WD3ntHz1y05;
	Fri, 17 Oct 2025 15:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rootcommit.com;
	s=hostingermail-a; t=1760716436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F1FFVJG2rkiUWHHF25ZM11yfG5to6mYY/Am7bSXow1w=;
	b=M02/l1LY/12rIEeTpPcENXTumRGFuqsL03PFKuftuURXv6DClseDI47zTy3+8tKFYpqX76
	0VQ+9rEgw9PJ80bZ6PXcrTECo7oheathXmj/GV5FNt1UdrXei+fwZyOGqP7trZEtz5UtPg
	+MEvXjkixRqTRa8juNpu1Uj1/6ZTgGToTH6xRG3B+nEyor5laOstctdf9zuGndOFyWZ9zI
	nBv/jGpMxCHcw/A0nw0cwpSVSJeklLbd+XGM4tvdOGrnWBvO7aVjuprKWyvdZ3QXicsfqZ
	1cDKdlfl8i77exoN6n3JgzRQQynSb0za7ZTrTpe99LVXbTRZ08WIq1I3M2WDHA==
Message-ID: <63b2056f-3d5a-4fca-8600-526619c33647@rootcommit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@rootcommit.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net: spacemit: compile k1_emac driver as built-in by
 default
To: Emil Renner Berthing <emil.renner.berthing@gmail.com>
References: <20251017100106.3180482-1-michael.opdenacker@rootcommit.com>
 <20251017100106.3180482-3-michael.opdenacker@rootcommit.com>
 <CANBLGcykz77U_V4CqE7PHvtgmeXiKFo0FXy-sHHiAoZ11HnCjw@mail.gmail.com>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Organization: Root Commit
In-Reply-To: <CANBLGcykz77U_V4CqE7PHvtgmeXiKFo0FXy-sHHiAoZ11HnCjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 17 Oct 2025 15:53:44 +0000 (UTC)
X-CM-Envelope: MS4xfJ9c+Oq6a3xe99yK0EZhAMCEV7n/+Vax87LhLieg7XqJbgnwD5VAarvVM6KCvSMEmHfg5nOc41whlY3NxSYXoCQkRdIalh/pIn9x4gRAnk2Vd/w3J8BV 8+BlmotPVSRFAlCM3amjVpsZDKN8a23XE54m+J0PIowDjfBLXfR3OqPUGpYZ22o82HoMUyBKYEHM7VrcD71CbfiI6NOfPwSjECGCMKOJuX9clYXphkEndH1Z eoGXu3YZ3bxT2XtWKFqBEs98FkRZJ06rdzLtGRjr4gm+JGc5RiDmXaoXlB3MEz8YGpHITKjDURU2tmd0ItVXr6X8MUmf+5nE79861gwIB+T3EiJaqZOUudJK seV2l5MgJbNyPQct/KpUFvoXH1Sl8E9QNpvv5FONjRUe2eRU5UwVlyVCs4FvEWhLkDRpt+qeFz/7h+EkakPaY+VXyOaw88ZKQrvsYPJqGLK8YAtfqTbVC1Ib vjwDhNt1oy05D7dSd6ATeNJq+J4ZkjhuTQ/X39dTk/RBULT9vp2Sd1LLEqUq5s9HgNe9m9V3f6HoKCbLjjTnKIbYMIvNl2x/zlo0Lx9bh6LfBIM1Xr6YBcbl sHL3rf5OblNYUUzdBgPjA00wJPod2kKc1EtqH75mcsrGHnxOLsN5rVnyqi8XlABvjXynwRIjg3GatUnAFHqF8TPyi6U6lAuZBhG12SDE6I/zdjECvGr3ONjI KEdcxt7c/TM=
X-CM-Analysis: v=2.4 cv=GbNFnhXL c=1 sm=1 tr=0 ts=68f26694 a=HZifvgWxdiUQ9LBJ2kG+mw==:617 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=d70CFdQeAAAA:8 a=6my-HHL3l342PdgWGDoA:9 a=QEXdDO2ut3YA:10 a=NcxpMcIZDGm-g932nG_k:22
X-AuthUser: michael.opdenacker@rootcommit.com

Hi Emil

Thanks for the review!

On 10/17/25 17:33, Emil Renner Berthing wrote:
> On Fri, 17 Oct 2025 at 12:03, <michael.opdenacker@rootcommit.com> wrote:
>> From: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>>
>> Supports booting boards on NFS filesystems, without going
>> through an initramfs.
> Please don't do this. If we build in every ethernet driver that might
> be used to boot from NFS we'll end up with almost every driver
> built-in and huge kernels. If you need this there is nothing
> preventing you from building the driver in, but please don't bloat
> defconfig kernels for everyone else.

Understood. You have a point. It's not really a problem to customize 
kernel configuration for each board as you said.
So, please forget this particular patch :)
Cheers
Michael.

-- 
Michael Opdenacker
Root Commit
Embedded Linux Training and Consulting
https://rootcommit.com


