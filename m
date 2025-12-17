Return-Path: <netdev+bounces-245135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 802B8CC7D77
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 14:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 304B23090083
	for <lists+netdev@lfdr.de>; Wed, 17 Dec 2025 13:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E47534F24D;
	Wed, 17 Dec 2025 12:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OgaFBuMJ"
X-Original-To: netdev@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D73334EEEA;
	Wed, 17 Dec 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975217; cv=none; b=bnEa6RAxri3M5uuByCAxQBdJYybm8GeK6PVa+zVKy15HTpm2NG64xGCg/PMn5Y62iR2tuTXVwOR1mY3Bq6n9tNs1Y0grW5xpBJFA1fEoKMh0yP2Fe5Bh27pKh1U4ehZQ+R2oX022pZNREHLbwIf0U3EbhYBo4iK0FayUCrEyENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975217; c=relaxed/simple;
	bh=h3rBdCc8vzcf1+28RqdKJYZ5kvf0BpukXPUymtfnUaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEPqToPxBDkKHJeyef+Md+NZYjUaf3RdxjNc7ksY6mF4W9qZ3vq9RJq20ZJsIAEBGXR6zUphNguI+vFob37EGNcHe3ouX4EdxqeKGLRTO7xYuBl3zjya8SavJQQCFAw8lensKz7rgh/4eF+lYZ7wiwxTPcf3T1LFf8lYLKbRnAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OgaFBuMJ; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1765975203; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=h3rBdCc8vzcf1+28RqdKJYZ5kvf0BpukXPUymtfnUaE=;
	b=OgaFBuMJeDxi0FPsmIxPaBz1eUxADEsTPuY4Pun+YhHPyg0vtUVdo0wOwyDew4AgKGT35DSEAVTZwZNyBgsAIgN28CEimbfTPPBEe+DDxtG6ss3tRGho+ixfPp0oIe8vpZUzUJmPlr3wQijpWnqgJIZ+5ghcRdu1nsf2dkeU4ik=
Received: from 30.221.129.233(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Wv3edwX_1765975201 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Dec 2025 20:40:02 +0800
Message-ID: <e39cb477-a011-4c55-98d7-124f00301654@linux.alibaba.com>
Date: Wed, 17 Dec 2025 20:40:01 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 xuanzhuo@linux.alibaba.com, dust.li@linux.alibaba.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
 <20251030121314.56729-2-guwen@linux.alibaba.com>
 <20251031165820.70353b68@kernel.org>
 <8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
 <20251105162429.37127978@kernel.org>
 <34b30157-6d67-46ec-abde-da9087fbf318@linux.alibaba.com>
 <20251127083610.6b66a728@kernel.org>
 <f2afb292-287e-4f2f-b131-50a1650bbb1d@linux.alibaba.com>
 <20251128102437.7657f88f@kernel.org>
 <9a75e3b2-4d1c-4911-81e4-cab988c24b77@linux.alibaba.com>
 <c92b47cf-3da0-446d-8b8f-674830256143@linux.alibaba.com>
 <20251213075028.2f570f23@kernel.org>
 <fb01b35d-55a8-4313-ad14-b529b63c9e04@linux.alibaba.com>
 <20251216135848.174e010f@kernel.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <20251216135848.174e010f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/12/17 05:58, Jakub Kicinski wrote:

> I talked to Thomas Gleixner (added to CC) during LPC and he seemed
> open to creating a PHC subsystem for pure time devices in virtualized
> environments. Please work with him and other vendors trying to
> upstream similar drivers.

Thank you for your patience and help.

I’ll work with Thomas and other potential vendors, likely starting with
an RFC to collect ideas and reach consensus on a dedicated subsystem for
PHC in non-NIC scenarios.

Regards.

