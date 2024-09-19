Return-Path: <netdev+bounces-128879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9908B97C453
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A84B28362F
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137CE18D627;
	Thu, 19 Sep 2024 06:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="uGkFj5x6"
X-Original-To: netdev@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E8C54658
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726727498; cv=none; b=HdDGKSS9AxR+fHzSWo6Pd3/f8frxlxaFX7koUAp8/CyC1qRGcXP3ZJuIwESUHOdGh0TiupZqW93zb7hzJvU5Ar8reU/k0w2QmeCFv3DP3FSWhgollbVJYQSGUUbnSEccv1hOCL5aWmGddE+jYWPAwwcbhBUt6Ul8QNl4DHOzyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726727498; c=relaxed/simple;
	bh=AC7J43hmCJKiEBLU4koOSSmIfJc8z8ctPJzkCKWNpgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f/bnEpz+9BgPk1V7kxfIVvUj0bKRsltX2392HyrCGEFDSHoMWZKxfd/6S9UiyQkgspV4Q6yFpGwD6QfoJzMCrIAJAbJuD8cRjygUffughzdoXOkUCm/Ah3dnCERTVRabxxe/Bsx/vfydYf3PCeBm3S7NHet9L2weGrmSqEgXa2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=uGkFj5x6; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726727486; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=n0q6PIHtO8Cq6Q9yX95Wo+HWdLaScedbIMIDBrSuZR4=;
	b=uGkFj5x6G2CDEgFktcnS924MMguORwGcJAo0G0gU9jXsF2iYLJIbyDSPU4atfsI29ypg95IzTOuvEW7tnPVd302EdN/Gegnu+VZYfpO04AIoWuR22SnBZUuZhWfB2zvYtDPGXmZHF8+uW3A6CeKaWkNBBKOBJaCGPKNEOWKZlQ4=
Received: from 30.221.128.108(mailfrom:lulie@linux.alibaba.com fp:SMTPD_---0WFGZeX2_1726727484)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 14:31:25 +0800
Message-ID: <17c8bded-5d29-49e9-b38d-3f0c95e4b15b@linux.alibaba.com>
Date: Thu, 19 Sep 2024 14:31:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Submitted a patch, got error "Patch does not apply to net-next-0"
To: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
From: Philo Lu <lulie@linux.alibaba.com>
In-Reply-To: <SJ0PR84MB208883688BD13CC7AA8F880ED8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matt,

On 2024/9/19 10:23, Muggeridge, Matt wrote:
> Hi,
> 
> First time submitter and it seems I did something wrong, as I got the error "Patch does not apply to net-next-0". I suspected it was complaining about a missing end-of-line, so I resubmitted and get the error "Patch does not apply to net-next-1". So now I'm unsure how to correct this.
> 
> My patch is: Netlink flag for creating IPv6 Default Routes (https://patchwork.kernel.org/project/netdevbpf/patch/SJ0PR84MB2088B1B93C75A4AAC5B90490D8632@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM/).
> 
> I followed the instructions at https://www.kernel.org/doc/html/v5.12/networking/netdev-FAQ.html.
> 
> Here's my local repo:
> 
> $ git remote -v
> origin  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git (fetch)
> origin  https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git (push)
> 
> After committing my changes, I ran:
> 
> $ git format-patch --subject-prefix='PATCH net-next' -1 95c6e5c898d3
> 
> It produced the file "0001-Netlink-flag-for-creating-IPv6-Default-Routes.patch".  I emailed the contents of that file to this list.
> 
> How do I correct this?
> 

It's recommended to first correct the mail format, such as adding a 
"Signed-off-by", and send the patch with `git send-email`.

May this doc[0] helps you.

[0]https://www.kernel.org/doc/html/latest/process/submitting-patches.html

-- 
Philo


