Return-Path: <netdev+bounces-262599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LeKLvtmpWmx+wUAu9opvQ
	(envelope-from <netdev+bounces-262599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:31:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD841D68C2
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 11:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFA3E300955A
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 10:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E4239C636;
	Mon,  2 Mar 2026 10:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="qejSHz/m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC0239B95E
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447004; cv=none; b=cEJ93L00Q5DTdfywuqGRPMTnl4CY7EgCRDS+lIfVDhjVlDRjxNh/4YUAdGN2ok8rHBbWF6p6On8UddPz5IrZQxQIQIJyEzcuzs78DPq6V3bpQbHvmV4O4QdUVq4cqvaSe2Wbh6YaO5UxJ50PEHtV8D0cvBEbtrOHYhznfnqKD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447004; c=relaxed/simple;
	bh=DxIjiuRLSsy1tFjfqwnUtZGdPPrFPa2emHdfIPwLGaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CKUq//8CLnOJLqR58SJB46LfXBNAzq9if6Lw/Fe5Ne6wHqiIMfzvxCe7OfZy5VQNPcNePq5tKgbZdp6cRlRzUqtgOw/W2jkfs3biJSjhc/14s3tT5Un8XADf74lsbyjpGuARjNi7TTmAS/Llj2TmDbdpTl2UIOReAc6xS1BYauE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=qejSHz/m; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439aa2f8ebaso998019f8f.2
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 02:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772447000; x=1773051800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyf5aAwmciBE7QFfA+/PpQQaPUYccIgX3fQYsSxVl+U=;
        b=qejSHz/mv7HaqVvybUq9mMdRh91/klcPbrp8m9TDyN6bXhHdCoYkRcI+r0+jbsLuON
         7V780DKi5GhyAkBytjq2KpvODxTn0X03VlsAQQpYS6py12jJWPQrJU7/rm3LBHu7lD7i
         UjCVZcSmmNp9mKBlkHOADSXgpl8s9AyI1yxAK1XFCzUbfbotkL1mOYOqvkD2AjRVQ+RF
         53EouXoHMx31/vSAx9ke/y4E26GeiroFmRLRGzYCSy169dWOQmA9ViMFPosIwtLRY8kX
         1mfWQ4UXY5lnssavO4yvfLH+vmR2Zt/3QzPiKwI8xtJiuEaxHRgMNv+JLyrRZdMDBTru
         SN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772447000; x=1773051800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyf5aAwmciBE7QFfA+/PpQQaPUYccIgX3fQYsSxVl+U=;
        b=ZeqeIQOBJZELGpsMsHK7YzvAMnIpr0S5Y1gqflLrq4dR4QGSDuryAd8LJI+6ZdMry3
         m4QGHPUiEp5vzCV7cAW4JfkceVHxvg7Iiueo2sjSHoi7/IKviGWK1n2LhOB1ZsA7KVqF
         TFaHhnmudksJVoLPaN9ZJAIb1Ig9MIB5jBJn7MLAbdSOOLoLLm/zP1asKdGkzZzOz+Ys
         KIB3uSDtkxAq9Am1k+4RmHqHz/De+L3UghHDvcE7PAqK57uzuf+SUejFYllqdPPSjdE6
         jtymSSJj837S4Lu3XSZy9qllSF/DpynT5/cawS74mjUNynPMSiYHSC+G4Y+3nOjn7H3U
         Wpkw==
X-Gm-Message-State: AOJu0YwAfEVHeLz4FLD14Ge2uDiKSzUeRsqIhZ+cheV69hFfyrc8/J2j
	UGYVedYk44VAHUIwec4rZpDeQg+FBLg9HK2H1GsaBcpkWjxdHkJv0D3x/EY4LeSBEp7/mUWQPtK
	sX1V6
X-Gm-Gg: ATEYQzwwOW5waL6ZkS+823WDBNH4yzCRfe1y+xvWAs5fa2pCWf6A1NLhKFLLCGh7+Lu
	8hRYEvoOLyQ/p2QWBBz5vyRHxTn/6+WNWb1ep+Jz2Fs7yI2cqxJrTFQVWlZ6I/p5oxilF4KVzfv
	czHcb2FTchxo5aAes0K4tsEq5QkoVYYqyeSAR+UvY43cLxZ1dRZ/KN7b1GN+ngGyTV9Suw7YNjs
	VSLIq3egmM1tecEyE5KkkkBCaC3F82kvs6FzCA4a+hUMDjwsgG4OuidSrsz2vAZ0Wm7ySbD0QwT
	zME6DGgcxeboX48DIKyuw2+jMYJWVqnb7RLknAMmnnVKP9Xr9DFeBWwRzitygprLM3efruIc9YT
	GvMcs+weqRk3W5EoGv2EmUgd9FnWTKZB+Gqoa9yui1HbGPbK5f4XAot0rgsy0Khuo/j/QsYStzx
	P/GP0vUuTmTtF6D5mZV/cOrsWChRK5fj4=
X-Received: by 2002:a05:6000:186e:b0:439:b374:c6d3 with SMTP id ffacd0b85a97d-439b374c7b0mr7633629f8f.32.1772447000348;
        Mon, 02 Mar 2026 02:23:20 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b1116698sm12378754f8f.16.2026.03.02.02.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 02:23:19 -0800 (PST)
Date: Mon, 2 Mar 2026 11:23:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, przemyslaw.kitszel@intel.com, mschmidt@redhat.com, 
	andrew+netdev@lunn.ch, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	daniel.zahka@gmail.com, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/10] devlink: allow to use devlink index as
 a command handle
Message-ID: <onwmw7ql5g2xqacrqnawcphdlzfu5v5ohgslsbvoeraszm7m4m@2ywv2ql37wu7>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-5-jiri@resnulli.us>
 <20260228144846.40f5dfeb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228144846.40f5dfeb@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262599-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CD841D68C2
X-Rspamd-Action: no action

Sat, Feb 28, 2026 at 11:48:46PM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:16 +0100 Jiri Pirko wrote:
>> +	if (attrs[DEVLINK_ATTR_INDEX]) {
>> +		index = nla_get_uint(attrs[DEVLINK_ATTR_INDEX]);
>> +		devlink = devlinks_xa_lookup_get(net, index);
>> +		if (!devlink)
>> +			return ERR_PTR(-ENODEV);
>> +		goto found;
>> +	}
>> +
>>  	if (!attrs[DEVLINK_ATTR_BUS_NAME] || !attrs[DEVLINK_ATTR_DEV_NAME])
>>  		return ERR_PTR(-EINVAL);
>
>If both INDEX and BUS_NAME + DEV_NAME are provided we should check
>that they point to the same device? Or reject user space passing both?

I implemented reject. I don't see much of value of allowing both. The
code that would do the checking is too much for this hypothetical case.

