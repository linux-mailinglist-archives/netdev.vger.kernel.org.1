Return-Path: <netdev+bounces-59827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617781C26B
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 01:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAE2D1C21FFE
	for <lists+netdev@lfdr.de>; Fri, 22 Dec 2023 00:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458CE38A;
	Fri, 22 Dec 2023 00:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="yf3vVkgX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A3A23D5
	for <netdev@vger.kernel.org>; Fri, 22 Dec 2023 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d9344f30caso998342b3a.1
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 16:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1703206081; x=1703810881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVkpdWuBcpSOLpg1HMPMKedLGPHIMRG1QFkPxybfEf0=;
        b=yf3vVkgXyyJSJs+49zq/p3d3ag6r9rYIoQDyFQR7C9WVh95iu7LbR9bdTL/imiCUUl
         F2UK3kDZphW6TL9e7ABHc8f32JkDxLq5FWAVThsCkdyeLHGbsEaGcPM43DYi21eWkYIW
         GlasjTE12GIjIEo+eDJNvoVjVK0NF0Gbx2r8d1X4zW5FeeLMXU6PSMWguJz6mxrYmgLG
         5OMwu8lqCU/lTwRCjaL7sOCId2NMcVUnhoYoQYYapkz+pomhCQY4qcVnyfjNENv0amte
         I2vSW2w5+48gJ/BNc6TJ5C6TCf2hY2drK61pneHJTUzGuOtyesX8fIJRBCHk4zqJt/iM
         AO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703206081; x=1703810881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVkpdWuBcpSOLpg1HMPMKedLGPHIMRG1QFkPxybfEf0=;
        b=BcVfjVMXsRchiqZxPu/MK/j6SSWrK8amNlzQJ8qRtuGomdxN1TsugjM5z/mh0NAGKu
         B6LbcadMhhirqIksG1buwkzj4n6juRVEb5KKbJSpq83+ehR+3B7xeLN0EWPB9HsPdWbo
         elOqd9QMs93Uantt80lBJV51OFb7E/szSDs5dMDdb2PDGz4UKySOjp7u2DvB51/gN01H
         UB2swCGZ1HuF8ewvIiNpP5uv1g48aT3O0MlW7ETYy4j0McI2jTez5ahLkLFVpakeLVSd
         IlXyDd+IYrEgKWbSkUS+45a1DIwwsQWOyOcpqKqbp3wK7OddqtzQhs5cO21JpvkDH+BA
         m9rA==
X-Gm-Message-State: AOJu0YxdEV2PviMCNQC1+h4Q2UmYqyHo40xambUUP2bdREMLdAo/uXM9
	LYZeyJlth+JhK7hlBjW+vG/BXCwDu4azbw==
X-Google-Smtp-Source: AGHT+IEHZnfTrdVEk2Cs/dXMGhmSdK+O0uvNZVBgwtOuOiaOryJfG2xRo795xKU2JDVUUHRcm3h5PA==
X-Received: by 2002:a05:6a00:1791:b0:6d9:847a:3f2e with SMTP id s17-20020a056a00179100b006d9847a3f2emr424219pfg.28.1703206081064;
        Thu, 21 Dec 2023 16:48:01 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c1::14f8? ([2620:10d:c090:400::4:865e])
        by smtp.gmail.com with ESMTPSA id 9-20020a056a00072900b006ce7e75cfa7sm2165026pfm.57.2023.12.21.16.48.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 16:48:00 -0800 (PST)
Message-ID: <df202c29-a9e0-4806-a30c-8d20453bf397@davidwei.uk>
Date: Thu, 21 Dec 2023 16:47:59 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 2/5] netdevsim: allow two netdevsim ports to
 be connected
Content-Language: en-GB
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20231220014747.1508581-1-dw@davidwei.uk>
 <20231220014747.1508581-3-dw@davidwei.uk> <ZYKvMxvEkE3Kq425@nanopsycho>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <ZYKvMxvEkE3Kq425@nanopsycho>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023-12-20 01:09, Jiri Pirko wrote:
> Wed, Dec 20, 2023 at 02:47:44AM CET, dw@davidwei.uk wrote:
>> Add a debugfs file in
>> /sys/kernel/debug/netdevsim/netdevsimN/ports/A/peer
>>
>> Writing "M B" to this file will link port A of netdevsim N with port B
>> of netdevsim M. Reading this file will return the linked netdevsim id
>> and port, if any.
>>
>> nsim_dev_list_lock and rtnl_lock are held during read/write of peer to
>> prevent concurrent modification of netdevsims or their ports.
>>
>> Signed-off-by: David Wei <dw@davidwei.uk>
>> ---
>> drivers/net/netdevsim/dev.c       | 127 +++++++++++++++++++++++++++---
>> drivers/net/netdevsim/netdev.c    |   6 ++
>> drivers/net/netdevsim/netdevsim.h |   1 +
>> 3 files changed, 121 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/netdevsim/dev.c b/drivers/net/netdevsim/dev.c
>> index e30a12130e07..e4621861c70b 100644
>> --- a/drivers/net/netdevsim/dev.c
>> +++ b/drivers/net/netdevsim/dev.c
>> @@ -391,6 +391,117 @@ static const struct file_operations nsim_dev_rate_parent_fops = {
>> 	.owner = THIS_MODULE,
>> };
>>
>> +static struct nsim_dev *nsim_dev_find_by_id(unsigned int id)
>> +{
>> +	struct nsim_dev *dev;
>> +
>> +	list_for_each_entry(dev, &nsim_dev_list, list)
>> +		if (dev->nsim_bus_dev->dev.id == id)
>> +			return dev;
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct nsim_dev_port *
>> +__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
>> +		       unsigned int port_index)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port;
>> +
>> +	port_index = nsim_dev_port_index(type, port_index);
>> +	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
>> +		if (nsim_dev_port->port_index == port_index)
>> +			return nsim_dev_port;
>> +	return NULL;
>> +}
>> +
>> +static ssize_t nsim_dev_peer_read(struct file *file, char __user *data,
>> +				  size_t count, loff_t *ppos)
>> +{
>> +	struct nsim_dev_port *nsim_dev_port;
>> +	struct netdevsim *peer;
>> +	unsigned int id, port;
>> +	char buf[23];
>> +	ssize_t ret;
>> +
>> +	mutex_lock(&nsim_dev_list_lock);
>> +	rtnl_lock();
>> +	nsim_dev_port = file->private_data;
>> +	peer = rtnl_dereference(nsim_dev_port->ns->peer);
>> +	if (!peer)
>> +		goto out;
>> +
>> +	id = peer->nsim_bus_dev->dev.id;
>> +	port = peer->nsim_dev_port->port_index;
>> +	ret = scnprintf(buf, sizeof(buf), "%u %u\n", id, port);
>> +	ret = simple_read_from_buffer(data, count, ppos, buf, ret);
>> +
>> +out:
>> +	rtnl_unlock();
>> +	mutex_unlock(&nsim_dev_list_lock);
>> +
>> +	return ret;
>> +}
>> +
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
>> +		pr_err("Format for adding a peer is \"id port\" (uint uint)");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ret = -EINVAL;
>> +	mutex_lock(&nsim_dev_list_lock);
>> +	rtnl_lock();
>> +	peer_dev = nsim_dev_find_by_id(id);
>> +	if (!peer_dev)
>> +		goto out;
> 
> Tell the user what's wrong please.

Okay.

> 
>> +
>> +	peer_dev_port = __nsim_dev_port_lookup(peer_dev, NSIM_DEV_PORT_TYPE_PF,
>> +					       port);
>> +	if (!peer_dev_port)
>> +		goto out;
> 
> Tell the user what's wrong please.

Ditto.

> 
> 
>> +
>> +	nsim_dev_port = file->private_data;
>> +	if (nsim_dev_port == peer_dev_port)
> 
> Why fail here? IDK, success sounds better to me.

I don't want to link a port to itself. In my mental model a port is e.g.
a port on a switch. It doesn't make sense to connect it to itself.

> 
> 
>> +		goto out;
>> +
>> +	rcu_assign_pointer(nsim_dev_port->ns->peer, peer_dev_port->ns);
>> +	rcu_assign_pointer(peer_dev_port->ns->peer, nsim_dev_port->ns);
>> +	ret = count;
>> +
>> +out:
>> +	rtnl_unlock();
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
>> +	.owner = THIS_MODULE,
>> +};
>> +
>> static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>> 				      struct nsim_dev_port *nsim_dev_port)
>> {
>> @@ -421,6 +532,9 @@ static int nsim_dev_port_debugfs_init(struct nsim_dev *nsim_dev,
>> 	}
>> 	debugfs_create_symlink("dev", nsim_dev_port->ddir, dev_link_name);
>>
>> +	debugfs_create_file("peer", 0600, nsim_dev_port->ddir,
>> +			    nsim_dev_port, &nsim_dev_peer_fops);
>> +
>> 	return 0;
>> }
>>
>> @@ -1702,19 +1816,6 @@ void nsim_drv_remove(struct nsim_bus_dev *nsim_bus_dev)
>> 	dev_set_drvdata(&nsim_bus_dev->dev, NULL);
>> }
>>
>> -static struct nsim_dev_port *
>> -__nsim_dev_port_lookup(struct nsim_dev *nsim_dev, enum nsim_dev_port_type type,
>> -		       unsigned int port_index)
>> -{
>> -	struct nsim_dev_port *nsim_dev_port;
>> -
>> -	port_index = nsim_dev_port_index(type, port_index);
>> -	list_for_each_entry(nsim_dev_port, &nsim_dev->port_list, list)
>> -		if (nsim_dev_port->port_index == port_index)
>> -			return nsim_dev_port;
>> -	return NULL;
>> -}
>> -
>> int nsim_drv_port_add(struct nsim_bus_dev *nsim_bus_dev, enum nsim_dev_port_type type,
>> 		      unsigned int port_index)
>> {
>> diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
>> index aecaf5f44374..434322f6a565 100644
>> --- a/drivers/net/netdevsim/netdev.c
>> +++ b/drivers/net/netdevsim/netdev.c
>> @@ -388,6 +388,7 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>> 	ns->nsim_dev = nsim_dev;
>> 	ns->nsim_dev_port = nsim_dev_port;
>> 	ns->nsim_bus_dev = nsim_dev->nsim_bus_dev;
>> +	RCU_INIT_POINTER(ns->peer, NULL);
>> 	SET_NETDEV_DEV(dev, &ns->nsim_bus_dev->dev);
>> 	SET_NETDEV_DEVLINK_PORT(dev, &nsim_dev_port->devlink_port);
>> 	nsim_ethtool_init(ns);
>> @@ -407,8 +408,13 @@ nsim_create(struct nsim_dev *nsim_dev, struct nsim_dev_port *nsim_dev_port)
>> void nsim_destroy(struct netdevsim *ns)
>> {
>> 	struct net_device *dev = ns->netdev;
>> +	struct netdevsim *peer;
>>
>> 	rtnl_lock();
>> +	peer = rtnl_dereference(ns->peer);
>> +	if (peer)
>> +		RCU_INIT_POINTER(peer->peer, NULL);
>> +	RCU_INIT_POINTER(ns->peer, NULL);
>> 	unregister_netdevice(dev);
>> 	if (nsim_dev_port_is_pf(ns->nsim_dev_port)) {
>> 		nsim_macsec_teardown(ns);
>> diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
>> index babb61d7790b..24fc3fbda791 100644
>> --- a/drivers/net/netdevsim/netdevsim.h
>> +++ b/drivers/net/netdevsim/netdevsim.h
>> @@ -125,6 +125,7 @@ struct netdevsim {
>> 	} udp_ports;
>>
>> 	struct nsim_ethtool ethtool;
>> +	struct netdevsim __rcu *peer;
>> };
>>
>> struct netdevsim *
>> -- 
>> 2.39.3
>>

