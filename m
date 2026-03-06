Return-Path: <netdev+bounces-264756-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDbnKyjEqmnVWwEAu9opvQ
	(envelope-from <netdev+bounces-264756-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349A22037E
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 13:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BDEE3131DAE
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 12:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE2A38B7DE;
	Fri,  6 Mar 2026 12:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ed0+SS4y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051D1364EBC
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772798666; cv=none; b=WSL+tFuBHhkJUiYr3ABMfYJhIkg2rwqjw5k342+uJgkmNTJfVLa1zTO+soSdZV0+RofUSF/owsFr1e6Eukz0A5fAdskFhT4Jz8aQaLNkk/ZaozLQwNo8veWddqqsFFCiXixr/17Rqax9PAHAC5i55VwN9qHkU+S38Z6C21nMBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772798666; c=relaxed/simple;
	bh=Lvg4T9vwXaSkwPljjOx0RhjLAAXOTiGJbwWWRFgFLKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmJ5pTwsuo6/WQ6dt9BFFIsd2YDXbJHB4E0FOmHeQGZbLeSEAOH6SRuVJI956cfVbGsCi6wkMP3PKizBM/K2EfiCFZvN8fpnTQLEs4Pe1JG3dzOS99mAsn0wszSI9fzFho7ZYh4i6AOuRiF1iwUXiv8ifL6dXCR+9/jH2k8WEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ed0+SS4y; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-482f454be5bso93796745e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 04:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772798661; x=1773403461; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lvg4T9vwXaSkwPljjOx0RhjLAAXOTiGJbwWWRFgFLKI=;
        b=ed0+SS4yZkwyoqttqz2qhbV/2mXNHH4wCtpAcaaCajm0MKG1iFTOd5yOmdpRIncx/m
         R/MzrkIZ2LQ60MJ69EPr89d1dMLHMdPYwiPpQkZ6e43aLUCFard78WjMci2mFPqHk3zE
         K9PmPYHKPVjwu1BQ+vsQlaoLywKOQyU6kPYN0eES7hoglcneNTsGh6Su+rltrQGPrAgX
         AVUDDRvqec7UY9kIxT+7ljR35MXzDQjYVSlNrKTOXtfEpZ/aSloyWQL81KEtXnaA2n5c
         P6TAQo0u4IcKG9/orcbzxAtwZSXskYGtfVyQBE+m2gVJ/Rytx2ezl3DSD95+4ntGlPab
         Sj+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772798661; x=1773403461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lvg4T9vwXaSkwPljjOx0RhjLAAXOTiGJbwWWRFgFLKI=;
        b=fgUV8/L+zmPOO4cIH8ZMYluCxewv+jFmcmUmhyj4d6+SaG1eJlzZiOcERWVa5l2S7F
         xlb1DFQBV/7kI7BnmblINfN6+q6z4S3dPjVSoK1W3BFnnKsuYFmgjDh5+xxRFOv0u8d9
         ucUF3mcVDnwknbD03HmD7AAGaAAIUb3iaxMRhXKIMhheDKMzym4Me2jg/MG7Doo/kkon
         1tUKP+THZhzJNR1GPTcxx+afHO6cWQ4w6JIno/rrET/3nKpS7SdKqzPbJMHj5rYI2AXY
         5NTE263KTHoUQX2yBs4cZl5dXQ1aO3V9PyAiN2P8CQb14rBpPRq6QLBcKJkQwLKt9O7a
         LAJA==
X-Gm-Message-State: AOJu0YzUoiEv3TXY089NO81KmlkP1W5627xF5eUdDNpeSxZM6UcC6VzI
	ex78BL0x8Rx7Pp6WfvjpLxVfMOtn4CqngUjq209urUJab92gPSJDna0asI1r/T/RqhM=
X-Gm-Gg: ATEYQzwUqKJ+8/hL3vYDuGToXx+ebh3cStmUFDsg7C4m3hosCmUjIeEhaMR2h9PtxC6
	3JzVGW7LCvhecevOg2JbuEELPjV8FPrno7eCLEShOO1F8ZpcBB4y6coP9BdbyB6ztvuKr3b5PWq
	rqQk7TOITbXcoMnTcuOYU0SSr4BP8trZmjgFMSLL5BxeALJ+jXmRUyzmzno/ywknpGcvOF0txhY
	MJSsBH4lr1xhPVRN4/DOq3M0p1UMd3AvAeFWpWYpIiv+AfyUlXrb5dGyrWoeyZpII3koFWlV2kF
	DfquGhdlSb1rLORpL53GgVUZNCSz/B6umk7Zdjnn+V/sJpylxBLuSpo3yodSrOcaqSxF0+VZS96
	OAeesYxhWW6CyqpRKJ3TgMQSHK7mbELHPDXwz3BRAk/0GP1i13wDfchZLh1fHB+7BJsLqNieaoP
	RIlTy1JIU1W02NQlWx0hm9noA1hPmsUwE=
X-Received: by 2002:a05:600c:45d1:b0:483:7b99:131d with SMTP id 5b1f17b1804b1-4852675e55cmr30233535e9.16.1772798660534;
        Fri, 06 Mar 2026 04:04:20 -0800 (PST)
Received: from FV6GYCPJ69 ([208.127.45.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851fb27a20sm207763565e9.9.2026.03.06.04.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:04:19 -0800 (PST)
Date: Fri, 6 Mar 2026 13:04:16 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH net-next] net: rocker: kzalloc + kcalloc to kzalloc_flex
Message-ID: <x6bh5b7btkboaso726etps5t5hlka256nxeobbr46n7s7sj6kl@ddcxvax7xsc2>
References: <20260306025449.12333-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306025449.12333-1-rosenp@gmail.com>
X-Rspamd-Queue-Id: 3349A22037E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264756-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20230601.gappssmtp.com:dkim,nvidia.com:email]
X-Rspamd-Action: no action

Fri, Mar 06, 2026 at 03:54:49AM +0100, rosenp@gmail.com wrote:
>Combining the allocations simplifies things, especially the free path.
>
>Remove ofdpa_group_tbl_entry_free as a result. kfree is shorter.
>
>Add __counted_by for extra runtime analysis.
>
>Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

