Return-Path: <netdev+bounces-245717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14831CD60DB
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 13:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 127613068005
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 12:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65532F12BE;
	Mon, 22 Dec 2025 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bDpHWYsk"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C02F12A1;
	Mon, 22 Dec 2025 12:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766407478; cv=none; b=GjL226Dp/bBy2YU0htpifyWIVt2ahb9JfgUbnP6j2wWWF7V/SJf6vzom6N8YRQa5nlQGNWm36uZNjiE42Yp/N6y4oo9KWRz6wp6zwAHC4xqU1roBIh7j01bPq5BoKxtXr0Ue7my+Bez1HBGrW7SwaCkc5xUiN9KAypnOui5KK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766407478; c=relaxed/simple;
	bh=EkNr6F35O2JxDl8h9VmfFpZcN/MEl/UFreXW83MRRCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kdCfeWaUJ9No+kkxVIeGKg+6tXTZVFfnvlf4U02ukMoTKBCdjJRfU4AN5nUqwKo8Eid4zMuGVGz/fl5+el7QnZnXy4llquqo7F/a/ZjMHXlhD8+IyMrN+19ZWEkdkQThB1rLexghtRZwBAEuWu0fEp2b8QdLbrRoCy/oVIjZ86o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bDpHWYsk; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766407472; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=SfbPxWa0qOrgdf9xPvgtxlOB8A/ZDsBdIVTcqLTsk/U=;
	b=bDpHWYskkic3NxoFkghFCCnUhX73StUHj+Qu0MFS4c+x/Eaoy8Qt+sJvchYudf00Y/iixXr7DsFSlf7HIIuNsM6QJbxvyegnXgvrMTwgc88x8Nj4ym2VvPxeBc+I0YyIGCvCuJpD8yZx7hR2P0ER/Puziw9vJkx1xJn+mJYJxtc=
Received: from 30.221.129.67(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WvQp5kT_1766407469 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Dec 2025 20:44:30 +0800
Message-ID: <6e729b11-74de-4f9d-8aa4-ecac0edb7681@linux.alibaba.com>
Date: Mon, 22 Dec 2025 20:44:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 1/2] ptp: introduce Alibaba CIPU PHC driver
To: David Woodhouse <dwmw2@infradead.org>, Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
 dust.li@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251030121314.56729-1-guwen@linux.alibaba.com>
 <20251030121314.56729-2-guwen@linux.alibaba.com>
 <20251031165820.70353b68@kernel.org>
 <8a74f801-1de5-4a1d-adc7-66a91221485d@linux.alibaba.com>
 <20251105162429.37127978@kernel.org>
 <c68eecd8b5b0636842b2f4022c80e283649fed85.camel@infradead.org>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <c68eecd8b5b0636842b2f4022c80e283649fed85.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/12/18 20:28, David Woodhouse wrote:

> 
> Having said that, it does seem rather harsh to refuse to accept this
> one when there are so many other examples already in the tree. I'd
> suggest that we accept it and then it can be moved to the new setup,
> whatever that is, along with the other legacy snapshot-only PHCs.
> 

That's also my thought.

That said, I'm open to either: accept it and re-home these similar
drivers when we have a better setup, or agree on a dedicated "pure
PHC" subsystem now and then merge it there.

Regards.

