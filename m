Return-Path: <netdev+bounces-124499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A715F969B1F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 13:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D55B1F23437
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 11:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F90C187874;
	Tue,  3 Sep 2024 11:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d7cZlICq"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85351B12CE
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361607; cv=none; b=jpmYlVm+i46jeC0iXgImUrOCf9YDkap6Vfca9rUciOxdg5qPZQSDhTVv6olZbPrZwrTsnGZ13dlDz9zDgN8k8BV/4Uxu6tJnVP5hFHJt+o8L978uIzJWeyn/34vFnY9tQPk74IJo20BtdSb+3HGkP6VKuLT2ow3YSpfVWaeBCPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361607; c=relaxed/simple;
	bh=A3uCNUqg0aXC0nQ1MBC9shQCq0f3YwwO/qoiNUzE6S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYLRDlyhTZyG1QN8CjIJ9TL2cKUZRL7T0xEIhBoFttN4HUfiUsQnx16Uopz/7q/u/vYEuUt6Ub+nk+ueom2QkIsJ8PXBSLajRlsvNf07z/sx7AQM+oiFK6NCMdoIwfXwziKUElzj4lbdGutcKfHbGTaZuRkK9YY6DDI5vGhIqro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d7cZlICq; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2cae6633-ee5c-48f1-a546-8b334a3e8f39@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725361602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WT5bUJD3hPhbxv/OCZwCqOZkIZZKpIlHGsucs0wZo2Q=;
	b=d7cZlICqUt2O9sFwm5r95DPoc9kqUMWQVVcoPLdgN9KixxAtXLHxDCmX7LTzwUh9R4KVkp
	aI/anyjtxH8ooY85GHHAMls4o+wRtp8NxYtpcR/ria231qheIQHU5QzLe4GoHOFawqnAGJ
	gj8zsZ5U0A4JMmlGDP26dFdk6bYH2f4=
Date: Tue, 3 Sep 2024 12:06:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v7 2/3] ptp: ocp: adjust sysfs entries to expose tty
 information
To: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jiri Slaby
 <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org
References: <20240829183603.1156671-1-vadfed@meta.com>
 <20240829183603.1156671-3-vadfed@meta.com>
 <e767ec8e-e25d-4880-86be-d23e1875a428@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <e767ec8e-e25d-4880-86be-d23e1875a428@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 03/09/2024 11:35, Paolo Abeni wrote:
> 
> 
> On 8/29/24 20:36, Vadim Fedorenko wrote:
>> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
>> index 46369de8e30b..e7479b9b90cb 100644
>> --- a/drivers/ptp/ptp_ocp.c
>> +++ b/drivers/ptp/ptp_ocp.c
>> @@ -3361,6 +3361,54 @@ static EXT_ATTR_RO(freq, frequency, 1);
>>   static EXT_ATTR_RO(freq, frequency, 2);
>>   static EXT_ATTR_RO(freq, frequency, 3);
>> +static ssize_t
>> +ptp_ocp_tty_show(struct device *dev, struct device_attribute *attr, 
>> char *buf)
>> +{
>> +    struct dev_ext_attribute *ea = to_ext_attr(attr);
>> +    struct ptp_ocp *bp = dev_get_drvdata(dev);
>> +
>> +    return sysfs_emit(buf, "ttyS%d", bp->port[(uintptr_t)ea->var].line);
> 
> Out of sheer ignorance on my side, why a trailing '\n' is not needed 
> here? do we need to copy the format string from the old link verbatim?
> 

Hi Paolo!

Yes, I would like to preserve the format used with old symlink option.

Thanks,
Vadim

