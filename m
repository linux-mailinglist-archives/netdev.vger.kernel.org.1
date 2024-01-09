Return-Path: <netdev+bounces-62713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4D4828A8F
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 17:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E161F24C7A
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D63A1D4;
	Tue,  9 Jan 2024 16:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="RUgHr1nZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4842D621
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d3e2972f65so10962395ad.3
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 08:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1704819482; x=1705424282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3i4U5T2qK3drvXnIzh95NqDrXtOKODn4t71aPM48HQM=;
        b=RUgHr1nZ65wruV04Ze1O3YY608w98Fzt1IYms0IFxCF0I2CZsKqkAWfZRvMj/EO+Y8
         7NNtmxcMnO8YUCjCRI5WUg+FbAc2gBZ2df33qdFO7dkIiK++Nn5Nh6LEDZ3voVq0vmPj
         gYccjjhnB5NnoLYeHueNlKCGJcOsxoliS30u83Q94ia009s+KgxTu2VR4HHWOGlGUE2G
         VdGH7hTjDxfcRwMmC2ryZ8oZEbTC8R8qMlCgxsE9o+U0jEf+RNu7DFh/0oS/7GkiE6GS
         M5qi6BHwGdSbpbtAqdLeN3TVrGpdVJdTo9BMX2oQJbMe6wvSPyptuxIw7qYYfrEgZok1
         oDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704819482; x=1705424282;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3i4U5T2qK3drvXnIzh95NqDrXtOKODn4t71aPM48HQM=;
        b=HW5QEe/Ce4iAYODdPG0nO2057hKW0O2txPypotpG01k3m5HCJqaTjOgye8R7HxvTvX
         vROnppgEHJHcNl+kHysmu4Cj9cp2nzsj1p2jv9NO83z9y3qj5VsuWiHZ5R69SxDt8NQE
         hzqAtFeYHIeHyl3JghrNRU+wv3zQnwNRw2oHzjBKLenf3+6SYHDq7JH/hFHD4oPuUb67
         DGvrDJV41MuHfoHwmzoWNJJwAap1gSmonFSjoTNmFcG5HDsWV87JeGb80x/ildyZfTtp
         eh50jRNDyycxGYbCh6kyOxK2CGhi0bAaG96u0doSgX3PxVhp+BnCEUVZYaBQuoLhWeyc
         BtKQ==
X-Gm-Message-State: AOJu0YxuagCb31q1PU3b8LnIst3R94ijoIoI7z9gxLGX9GvLibWmCN0Z
	WgM2LcIoi2thZ6W+iTQX1R0qJxdFPTAv/2yTQnsMw0XzR6k=
X-Google-Smtp-Source: AGHT+IHKQIRFLN9owgwTU6rvvKCBZ9KjKefCp1c+M4zseJIRBmhOyLX4mJS5/xnWsIOG3Y2PHO8YaQ==
X-Received: by 2002:a17:902:a3c5:b0:1d5:5991:affe with SMTP id q5-20020a170902a3c500b001d55991affemr875660plb.2.1704819481836;
        Tue, 09 Jan 2024 08:58:01 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:1cbd:da2b:a9f2:881? ([2620:10d:c090:500::4:ea02])
        by smtp.gmail.com with ESMTPSA id az5-20020a170902a58500b001d398889d4dsm2010576plb.127.2024.01.09.08.58.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 08:58:01 -0800 (PST)
Message-ID: <725ad89a-038a-45bb-b710-24c2798f0dba@davidwei.uk>
Date: Tue, 9 Jan 2024 08:57:59 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 2/5] netdevsim: allow two netdevsim ports to
 be connected
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231228014633.3256862-1-dw@davidwei.uk>
 <20231228014633.3256862-3-dw@davidwei.uk>
 <20240103173928.76264ebe@kernel.org>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20240103173928.76264ebe@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-01-03 17:39, Jakub Kicinski wrote:
> On Wed, 27 Dec 2023 17:46:30 -0800 David Wei wrote:
>> +static ssize_t nsim_dev_peer_write(struct file *file,
>> +				   const char __user *data,
>> +				   size_t count, loff_t *ppos)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port, *peer_dev_port;
>> +	struct nsim_dev *peer_dev;
>> +	unsigned int id, port;
>> +	char buf[22];
>> +	ssize_t ret;
>> +
>> +	if (count >= sizeof(buf))
>> +		return -ENOSPC;
>> +
>> +	ret = copy_from_user(buf, data, count);
>> +	if (ret)
>> +		return -EFAULT;
>> +	buf[count] = '\0';
>> +
>> +	ret = sscanf(buf, "%u %u", &id, &port);
>> +	if (ret != 2) {
>> +		pr_err("Format is peer netdevsim \"id port\" (uint uint)\n");
> 
> netif_err() or dev_err() ? Granted the rest of the file seems to use
> pr_err(), but I'm not sure why...

I can change it to use one of these two in this patchset, then I can
chnage the others separately in another patch. How does that sound?

> 
>> +		return -EINVAL;
>> +	}
> 
> Could you put a sleep() here and test removing the device while some
> thread is stuck here? I don't recall exactly but I thought debugfs
> remove waits for concurrent reads and writes which could be problematic
> given we take all the locks under the sun here..

Yep, I'll test this.

> 
>> +	ret = -EINVAL;
>> +	mutex_lock(&nsim_dev_list_lock);
>> +	peer_dev = nsim_dev_find_by_id(id);
>> +	if (!peer_dev) {
>> +		pr_err("Peer netdevsim %u does not exist\n", id);
>> +		goto out_mutex;
>> +	}
>> +
>> +	devl_lock(priv_to_devlink(peer_dev));
>> +	rtnl_lock();
>> +	nsim_dev_port = file->private_data;
>> +	peer_dev_port = __nsim_dev_port_lookup(peer_dev, NSIM_DEV_PORT_TYPE_PF,
>> +					       port);
>> +	if (!peer_dev_port) {
>> +		pr_err("Peer netdevsim %u port %u does not exist\n", id, port);
>> +		goto out_devl;
>> +	}
>> +
>> +	if (nsim_dev_port == peer_dev_port) {
>> +		pr_err("Cannot link netdevsim to itself\n");
>> +		goto out_devl;
>> +	}
>> +
>> +	rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>> +	rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
>> +	ret = count;
>> +
>> +out_devl:
> 
> out_unlock_rtnl
> 
>> +	rtnl_unlock();
>> +	devl_unlock(priv_to_devlink(peer_dev));
>> +out_mutex:
> 
> out_unlock_dev_list
> 
>> +	mutex_unlock(&nsim_dev_list_lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations nsim_dev_peer_fops = {
>> +	.open = simple_open,
>> +	.read = nsim_dev_peer_read,
>> +	.write = nsim_dev_peer_write,
>> +	.llseek = generic_file_llseek,
> 
> You don't support seek, you want some form of no_seek here.
> 
>> +	.owner = THIS_MODULE,
>> +};

