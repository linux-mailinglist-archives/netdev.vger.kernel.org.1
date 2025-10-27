Return-Path: <netdev+bounces-233079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D46A5C0BE46
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 07:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C49E84E99CE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 06:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151A32D97A8;
	Mon, 27 Oct 2025 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="NDWa+G6M"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF13239E7E;
	Mon, 27 Oct 2025 06:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761545059; cv=none; b=icfF3pixKb8Wk8XScBuxa7M6eIQeeZScpe9X3w9nXpH/hC1g0XLIuy9a7JhivRhPA3JXmokMhZbVRamzvuJndmaK6sCNTIV7d7jgLjh9AKxtwUHjbMSTVJ/Wkolax8w3/AOtt2xHf9w8kMWxgCjVX/hzivi/1chbbuN6o+lFKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761545059; c=relaxed/simple;
	bh=2SUWSfQ5/JEzuD+Pj/+BAvMxTnNY11/j2gq/d5Arp/Q=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NevkuLQ/WCyYhaP5Oo4MS/6vaYBNN7hfMGSfSXxFyk2gA6aZE2I/7qLHw3qrJTyGJ9IrsxHss6EXxIuhLi/w565v0R7aVifMznalBleT9F5GsbcF0bAlU8fOWUY+2Y7ynvnVmNFCEaDivrHvV5gGaARB7ouJBx3ln47U2EOh5aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=NDWa+G6M; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761545050; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	bh=vGQNREQK62jW8RTtaFJj64+WJ4MbuJlL8IZDBtzUYss=;
	b=NDWa+G6M2OJBP2O+epO1OfE0XxMvMSUZS1uj7+OhSI3bnl3v3TKFSLCYlWUjoyqARTkWbPIjj6jByYePNVIVrW/y41eLWzEWU/SrnO6bkQi7L1/57ULufMOWFIkqY679XPtpeFnf9ZFioYQ3J8tS9Br+ZyZW0vz0g42buw5bJFs=
Received: from 30.221.133.61(mailfrom:guoheyi@linux.alibaba.com fp:SMTPD_---0Wr02qh7_1761545025 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Oct 2025 14:04:09 +0800
Message-ID: <5e065a78-b371-4ef7-8ce6-a902f80e2b02@linux.alibaba.com>
Date: Mon, 27 Oct 2025 14:04:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Heyi Guo <guoheyi@linux.alibaba.com>
Subject: Why hasn't the patch "r8152: Fix a deadlock by doubly PM resume" back
 ported to stable branches?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

We found that below bug fix patch had not been back ported to stable 
branches, like linux-5.10.y. Is there any special reason?

commit 776ac63a986d211286230c4fd70f85390eabedcd
Author:     Takashi Iwai <tiwai@suse.de>
AuthorDate: Wed Jul 14 19:00:22 2021 +0200
Commit:     David S. Miller <davem@davemloft.net>
CommitDate: Wed Jul 14 14:57:55 2021 -0700

     r8152: Fix a deadlock by doubly PM resume

     r8152 driver sets up the MAC address at reset-resume, while
     rtl8152_set_mac_address() has the temporary autopm get/put. This may
     lead to a deadlock as the PM lock has been already taken for the
     execution of the runtime PM callback.

     This patch adds the workaround to avoid the superfluous autpm when
     called from rtl8152_reset_resume().

     Link: https://bugzilla.suse.com/show_bug.cgi?id=1186194
     Signed-off-by: Takashi Iwai <tiwai@suse.de>
     Signed-off-by: David S. Miller <davem@davemloft.net>

Thanks,

Guo, Heyi


