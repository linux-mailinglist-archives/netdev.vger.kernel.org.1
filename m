Return-Path: <netdev+bounces-70781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF449850605
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 19:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42627B20B21
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 18:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6075F471;
	Sat, 10 Feb 2024 18:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b="CyDMWDDp"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D455C8FB
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707591264; cv=pass; b=OkVq1liNla1mher7/bAtuC3krno3ePAfnzuJWw1qoAFk0VZfZY2E3vTJe3nIh1JBP8no/yL/UHkz8vyeoOVeRA7CfIkyCzsKRbFXYy6AePGijHl6ynlxbBJU/B1gtkS+8vyo6VgEAxgoCqx1Rew/SSeNxx6IIhQLZwluiaclOTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707591264; c=relaxed/simple;
	bh=d+FMo6j9dQ/8zp04YQMoD+ZBMyp5fAERXRkpMLGk/sk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OmTv2TUk691CO8Sh82qxpPBFEwCTGboZK2v6liC2DTndHJHhrrBkPqfMLwr0+y2A/2/ROIq465hyWa45owQHw8medG1XdQNuSL9YTvF19rcDFomKjgxX9m6yWW9eIx3V+Cbg65TYB38Gjl9QmVDCm/2Lx7vhWHh8GFSZdlKlXwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net; spf=pass smtp.mailfrom=machnikowski.net; dkim=pass (2048-bit key) header.d=machnikowski.net header.i=maciek@machnikowski.net header.b=CyDMWDDp; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=machnikowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=machnikowski.net
ARC-Seal: i=1; a=rsa-sha256; t=1707591253; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IsrJGEeFziZQJ/V2O5JJMuqhQ9I0sh+bNhKPQ9gepXoxpDii7bkkR6TjaULZq/j+1GRgk37QJN48qS+dHgcrF/SOy80iAH/Mlr1IJkQSpa5xmROgTw0rP14NBiA8xhy+vO7zw7Z3IwF7YLPFGS1ywHs1Da9iZeW9SnLmgC0nt3M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1707591253; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OBOp4m+nZZtkNcYzFH6PExZdaMFghNe3hJr5UWThAFo=; 
	b=Dfr/WqQVoGW9matLOgCt0MCBFKWy+2Wjsp7zvsLzCrNMulPxea5faO1IbkcYBTKTcAnoB0Dh2u39JOQleaQHztyyHBk9oYAkv4OdAIKw3jNyjQE70HuCSRKveTDwnKJOOv3nxImZ/0UHXLhvZtHckjO21kXoGlkDX0oUK+a4mng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=machnikowski.net;
	spf=pass  smtp.mailfrom=maciek@machnikowski.net;
	dmarc=pass header.from=<maciek@machnikowski.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1707591253;
	s=zoho; d=machnikowski.net; i=maciek@machnikowski.net;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OBOp4m+nZZtkNcYzFH6PExZdaMFghNe3hJr5UWThAFo=;
	b=CyDMWDDpM8DQVjXudVbBXL2plcldzjxSIdy/6MXldRS5qNUudsTECGk4kqn9lScc
	LrtSEy2kb3zGoQ2r4JmHRzM+jB1a7lDRZiH5Q5T5+XNjnw+g57gSPjVE1y3Gg6lUqfD
	5fkMwqN4JL7t8Ua5W96l5fXZd1E0HjnBM1ndiKeuvajQYmp9onrpoT9ftAhg+PfDRd7
	Q58eZ8WcDdnTDn6GPHkHLrwuPUCxjRUnXOo4p2IldMhtqhxIRqLzpIyAE12Lo95FEl1
	KmLhOR/62mnWINv6/yLKWCsreUa9vWuYUn5oOirH3NJiFXjdDlDjWyAOzJazeMQi9eD
	uRnUzK3MTA==
Received: from [192.168.1.225] (83.8.237.114.ipv4.supernova.orange.pl [83.8.237.114]) by mx.zohomail.com
	with SMTPS id 1707591243488292.8013708728265; Sat, 10 Feb 2024 10:54:03 -0800 (PST)
Message-ID: <b3fc2f7f-4bd4-4b87-a55b-4dd7d6072ee9@machnikowski.net>
Date: Sat, 10 Feb 2024 19:53:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v9 3/3] netdevsim: add selftest for forwarding
 skb between connected ports
Content-Language: en-US
From: Maciek Machnikowski <maciek@machnikowski.net>
To: David Wei <dw@davidwei.uk>, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Sabrina Dubroca <sd@queasysnail.net>,
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
References: <20240210003240.847392-1-dw@davidwei.uk>
 <20240210003240.847392-4-dw@davidwei.uk>
 <01747e34-c655-4dbf-bda9-544f4e3f8ebd@machnikowski.net>
In-Reply-To: <01747e34-c655-4dbf-bda9-544f4e3f8ebd@machnikowski.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External



On 10/02/2024 09:48, Maciek Machnikowski wrote:
> 
> On 10/02/2024 01:32, David Wei wrote:
>> +###
>> +### Code start
>> +###
>> +
>> +modprobe netdevsim
>> +
>> +# linking
>> +
>> +echo $NSIM_DEV_1_ID > $NSIM_DEV_SYS_NEW
>> +echo $NSIM_DEV_2_ID > $NSIM_DEV_SYS_NEW
>> +
>> +setup_ns
>> +
>> +NSIM_DEV_1_FD=$((RANDOM % 1024))
>> +exec {NSIM_DEV_1_FD}</var/run/netns/nssv
>> +NSIM_DEV_1_IFIDX=$(ip netns exec nssv cat /sys/class/net/$NSIM_DEV_1_NAME/ifindex)
>> +
>> +NSIM_DEV_2_FD=$((RANDOM % 1024))
>> +exec {NSIM_DEV_2_FD}</var/run/netns/nscl
>> +NSIM_DEV_2_IFIDX=$(ip netns exec nscl cat /sys/class/net/$NSIM_DEV_2_NAME/ifindex)
Can we change these to:
NSIM_DEV_1_FD=$((256+(RANDOM % 256)))
NSIM_DEV_2_FD=$((512+(RANDOM % 256)))

to prevent a 1/1024 chance of drawing the same indexes?

>> +
>> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:2000" > $NSIM_DEV_SYS_LINK 2>/dev/null
>> +if [ $? -eq 0 ]; then
>> +	echo "linking with non-existent netdevsim should fail"
>> +	exit 1
>> +fi
>> +
>> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX 2000:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
>> +if [ $? -eq 0 ]; then
>> +	echo "linking with non-existent netnsid should fail"
>> +	exit 1
>> +fi
>> +
>> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX" > $NSIM_DEV_SYS_LINK 2>/dev/null
>> +if [ $? -eq 0 ]; then
>> +	echo "linking with self should fail"
>> +	exit 1
>> +fi
>> +
>> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:$NSIM_DEV_2_IFIDX" > $NSIM_DEV_SYS_LINK
>> +if [ $? -ne 0 ]; then
>> +	echo "linking netdevsim1 with netdevsim2 should succeed"
>> +	exit 1
>> +fi
>> +
>> +# argument error checking
>> +
>> +echo "$NSIM_DEV_1_FD:$NSIM_DEV_1_IFIDX $NSIM_DEV_2_FD:a" > $NSIM_DEV_SYS_LINK 2>/dev/null
>> +if [ $? -eq 0 ]; then
>> +	echo "invalid arg should fail"
>> +	exit 1
>> +fi
>> +
>> +# send/recv packets
>> +
>> +socat_check || exit 4
> 
> This check will cause the script to exit without cleaning up the devices
> and namespaces. Move it to the top, or cleanup on error
> 
> Thanks,
> Maciek
> 

