Return-Path: <netdev+bounces-175868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02211A67D0D
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 404223B359E
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6511E1DF1;
	Tue, 18 Mar 2025 19:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="dk2UIv/w"
X-Original-To: netdev@vger.kernel.org
Received: from mx09lb.world4you.com (mx09lb.world4you.com [81.19.149.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822121DF263;
	Tue, 18 Mar 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325827; cv=none; b=FZpD80JV9g/Df0TekMbjeFs0j2g5nm59PHQyeKEXEQ2Foq8m29MfwujLSm/LCMrRanbZkh4+9/SCA+vVGiVwwo6qgovkbE5p/zDB5w4/qwB+fYPZas7NMLIb0LtiC4tctShXi9dRaxdJUS5bxJMazPKv4pouyRs3juUVn4V8C0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325827; c=relaxed/simple;
	bh=ryyR+HrYMLoW4SNLndsy19HN0trwbWjPEVMYaDrD0TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OUQD0k7OAVvKtUdHTrh27eruFfQ5+xdtfLPCU8R5npnSkBjWk5yF4S12ln6etlnMCMPQSrGUoqJEPWZgx4NtQ8oAhvz6Ow6jKfbKe3F03guBsW3230u4SH+k2vmEdMEvUZRPkHk/m5som4WjkEUp28kNGre1Xf3BVrC289Yfsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=dk2UIv/w; arc=none smtp.client-ip=81.19.149.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cE39IEPuwH2j4O8dxJdTTPGzr20e/m35SIHAvpjbl1I=; b=dk2UIv/wSC7dmWGu7VRacPeGrt
	05TI9iQ6iWKs1ghiuR6E/qrMYtBj54izlETPj9jKkzKN9Qc9aF+yOdzwOj94aXnkRpcLkIPXHPtb+
	nlciNhey3ztMesIibkFpDwBk/fTIKNIkR0nHt0Lhz5XYBhgkj92uJ2UZDyGKiD76E6j8=;
Received: from [80.121.79.4] (helo=[10.0.0.160])
	by mx09lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1tuc90-000000005MH-3HYp;
	Tue, 18 Mar 2025 19:58:33 +0100
Message-ID: <46a0a5e2-2def-4ed1-ab54-40b6c8393239@engleder-embedded.com>
Date: Tue, 18 Mar 2025 19:58:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH linux-next] net: atm: use sysfs_emit()/sysfs_emit_at()
 instead of scnprintf().
To: xie.ludan@zte.com.cn
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, davem@davemloft.net
References: <20250317152933756kWrF1Y_e-2EKtrR_GGegq@zte.com.cn>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250317152933756kWrF1Y_e-2EKtrR_GGegq@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 17.03.25 08:29, xie.ludan@zte.com.cn wrote:
> From: XieLudan <xie.ludan@zte.com.cn>
> 
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: XieLudan <xie.ludan@zte.com.cn>
> ---
>   net/atm/atm_sysfs.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/net/atm/atm_sysfs.c b/net/atm/atm_sysfs.c
> index 54e7fb1a4ee5..ae0d921157c5 100644
> --- a/net/atm/atm_sysfs.c
> +++ b/net/atm/atm_sysfs.c
> @@ -16,7 +16,7 @@ static ssize_t type_show(struct device *cdev,
>   {
>   	struct atm_dev *adev = to_atm_dev(cdev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%s\n", adev->type);
> +	return sysfs_emit(buf, "%s\n", adev->type);
>   }
> 
>   static ssize_t address_show(struct device *cdev,
> @@ -24,7 +24,7 @@ static ssize_t address_show(struct device *cdev,
>   {
>   	struct atm_dev *adev = to_atm_dev(cdev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%pM\n", adev->esi);
> +	return sysfs_emit(buf, "%pM\n", adev->esi);
>   }
> 
>   static ssize_t atmaddress_show(struct device *cdev,
> @@ -37,7 +37,7 @@ static ssize_t atmaddress_show(struct device *cdev,
> 
>   	spin_lock_irqsave(&adev->lock, flags);
>   	list_for_each_entry(aaddr, &adev->local, entry) {
> -		count += scnprintf(buf + count, PAGE_SIZE - count,
> +		count += sysfs_emit_at(buf, count,
>   				   "%1phN.%2phN.%10phN.%6phN.%1phN\n",
>   				   &aaddr->addr.sas_addr.prv[0],
>   				   &aaddr->addr.sas_addr.prv[1],

Does the alignment of the following argument lines needs to be adapted?

> @@ -55,7 +55,7 @@ static ssize_t atmindex_show(struct device *cdev,
>   {
>   	struct atm_dev *adev = to_atm_dev(cdev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", adev->number);
> +	return sysfs_emit(buf, "%d\n", adev->number);
>   }
> 
>   static ssize_t carrier_show(struct device *cdev,
> @@ -63,7 +63,7 @@ static ssize_t carrier_show(struct device *cdev,
>   {
>   	struct atm_dev *adev = to_atm_dev(cdev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n",
> +	return sysfs_emit(buf, "%d\n",
>   			 adev->signal == ATM_PHY_SIG_LOST ? 0 : 1);

Adapt alignment of following line?

Gerhard


