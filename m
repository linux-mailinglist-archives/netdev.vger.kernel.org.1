Return-Path: <netdev+bounces-274453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GqGG0NBzmlQmQYAu9opvQ
	(envelope-from <netdev+bounces-274453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:13:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 114F3387898
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 12:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41464303A80E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 10:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53F73E1CF7;
	Thu,  2 Apr 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fn5RhOQW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VYRQfAoC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E6E3DEFE0
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 10:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775124617; cv=none; b=f2Ott8CnUgnjK0TGHyU/S59aBmQfCROZaxLN0YHHMbp8w02qXJ+G9I65O7R/kvLsconrK8hqA4OxjcENRjf2whiwqAQjICkyBEbr37S65dEudAc8ao7D1QFEclnkrHCZLTRF9TIvMiFU0+c26WKR/u4WwYYk3K6u44nuUHfCwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775124617; c=relaxed/simple;
	bh=zHFrCPHhU82trU3T1Txy7LHnZJ2znMMSxro8pRXdEog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaqZk0oy8AzgSmOUdUI4idctDuLHs7zRiCwSj43t+MuboeqNx4cM4iv5xxzYHGOmU+fwMaMKtnjHNlVIQ7zGrpJYXHXuRWQqY+Q+dAygRMPMdypXlfSjY9zbpOxSPcnRuyVKtbkr0cY4mSl294T5++jXgTni4BiAQR3iozD9eu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fn5RhOQW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VYRQfAoC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775124614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vI34ad9TZ0aROIv3z6J1CAQ0jr+pvjoqHVYmg8tKBOs=;
	b=Fn5RhOQWYFKdDSAHY6i+BgliUfNONbgeAsmFXRwfe096b2QyO6EZoJ3cdnLFHrdtyD+e6r
	5EcHyBMXVo7BlcVWQif2ZG7Bja26mZ2iBs26PWkew6J41agw9xiD4ZwrFRbkpSUac6nraT
	mRTEIluRBD0/+RS/djyyh5K7FcHGhKU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-jF0JljDHONmRpAhR49i9oA-1; Thu, 02 Apr 2026 06:10:12 -0400
X-MC-Unique: jF0JljDHONmRpAhR49i9oA-1
X-Mimecast-MFC-AGG-ID: jF0JljDHONmRpAhR49i9oA_1775124612
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43cf5b4dac8so715051f8f.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 03:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775124611; x=1775729411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vI34ad9TZ0aROIv3z6J1CAQ0jr+pvjoqHVYmg8tKBOs=;
        b=VYRQfAoCsihuW+YgM7G+OmieWlW7QcB3oYTaylUkuB1qterNJYwfZAjthBBQwsUz4Q
         TllXpn40O/5msTcgCh4mHA8zCSdYmN4O1pQY2xZku/NCbZxt/YaLdoZ1T+MV6ivNVo3z
         mSafhlg1pM185Ainhqj248TyPiNLuYZ1LmNnKUz4f9pM0+4fHQkApWF/lAx55022CP4L
         nXnebY0DU18AKAMC0WWmkYF8eYoMl2OI8Nev8CX582riMHI7QqXwJi+RvuZcAa9wv3ZZ
         Otydikw6yEEJuilWijZhu0w0zbZGG2gokdXAkRWoIe5f0r0+hS/hMvZOm9S1B3w0o/9q
         ooRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775124611; x=1775729411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vI34ad9TZ0aROIv3z6J1CAQ0jr+pvjoqHVYmg8tKBOs=;
        b=AF8g6Azbfht3qQGsVRVpcOe5+QY6r0IC+V34SWkDnHnRGzszAmxjyr4MV7KwZgf7+e
         e4HILC1b+/zhPohJLSpIG22b3OeJ77DccvjFb0AOG6fi07lA4/+qQl/N5LtfVZnvIz39
         RSCWX+AdKotqigc5XGb2P2i8qsMIzbim+zUlvMCFOACb1j+JXJrmvSem9Azi1R1aduSm
         jkn3owcGQ2OHw5qC5e45uAQN+WGVMg0OFi3qhHqbsvDOuEVVkguocyNBT8SpFxrDU5TG
         WHTbDmfHLp2G13HVMnKvZ9+u8y/Q7uRAsjnZCMoxjlaQNTelGFeNbNYJZLszOi/T5+PZ
         muKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlT+zzVe6wz8AM1aqX6k6YmYrzVEw3U70m+WAe9GXKhVTBpckYlnf0vilg0ESrgzoHuoHfzpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxCjouVeM+prZTp4vKi1Z70rIemqYBqeIr3lrZfJ9da3wAv2wu
	rAyDmz6B521uARmqVCu8kVDIdJPfxJ/M+jVH7eqKhCbrxIKp16Kuw9Xss2X5uIsvLlrLDO2cr9W
	C9HThObg20bl+2Ye2iq0UOlk2jG4CTXaCpjR7MXw67XlKW6+ayoSncaddBg==
X-Gm-Gg: ATEYQzyXmbzr3KyqfBCG+hTsjw6KI9IfeiDd5M/PIS85fXZ5N42VLz8qojszg8mLz2Y
	uXxvRe17JVi61tooRy+UmpZFKiVHUF9EBX35cBHpsrwM8NNKYuNQWeJqZMI7DztbZqLJhzKiPk6
	P8ut0xFcqyYBScTJ5sngYRkmUlFGAyNJuQY2aSMmcwluHVeovL8edMdv1eyiEg3zlPo3KL2ynXz
	1q/jNjZs+ROdsQfEjzAmiUN5/+E9FvboDqGB6F45+JQmftJGo/V7q60zmQPKVqeN7ytxNFo0tuo
	Y5dmVHEWcsLKNx6Csu6YVVH/f9UoRVNqkagapGbtV2pkQCwHlLl/jVO1/Ie/gHVHWVz2UpQfVRI
	awhF2F4HO02wTnR66aXLXfGzrwCjr5uGZheVGYvqkXDkVTpmbW9zI9OTKDg==
X-Received: by 2002:a05:6000:288c:b0:439:ddf9:a205 with SMTP id ffacd0b85a97d-43d1f1c0348mr4685302f8f.10.1775124611416;
        Thu, 02 Apr 2026 03:10:11 -0700 (PDT)
X-Received: by 2002:a05:6000:288c:b0:439:ddf9:a205 with SMTP id ffacd0b85a97d-43d1f1c0348mr4685243f8f.10.1775124610926;
        Thu, 02 Apr 2026 03:10:10 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e1fe0b0sm6286938f8f.0.2026.04.02.03.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 03:10:10 -0700 (PDT)
Message-ID: <5b7faeab-77b5-4a3c-a717-5a80f5e76a31@redhat.com>
Date: Thu, 2 Apr 2026 12:10:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 7/9] selftests: drivers: hw: move to KTAP
 output
To: Ioana Ciornei <ioana.ciornei@nxp.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, petrm@nvidia.com, willemb@google.com,
 linux-kselftest@vger.kernel.org
References: <20260330152933.2195885-1-ioana.ciornei@nxp.com>
 <20260330152933.2195885-8-ioana.ciornei@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260330152933.2195885-8-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274453-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 114F3387898
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 5:29 PM, Ioana Ciornei wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
> index f290ce1832f1..ed81bdc33536 100755
> --- a/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
> +++ b/tools/testing/selftests/drivers/net/hw/ethtool_rmon.sh
> @@ -11,10 +11,12 @@ ALL_TESTS="
>  NUM_NETIFS=2
>  lib_dir=$(dirname "$0")
>  source "$lib_dir"/../../../net/forwarding/lib.sh
> +source "$lib_dir"/../../../kselftest/ktap_helpers.sh

AI review noted:
---
Will this test work correctly after installation? The test sources
ktap_helpers.sh but the file doesn't appear to be included in the
Makefile's TEST_INCLUDES variable.

Looking at tools/testing/selftests/drivers/net/hw/Makefile, when
'make install' is run, only files listed in TEST_PROGS, TEST_FILES,
and TEST_INCLUDES are copied to the installation directory. Files
referenced via 'source' need to be in TEST_INCLUDES to be available
at runtime.

Without adding '../../../kselftest/ktap_helpers.sh' to TEST_INCLUDES,
the test will fail with 'No such file or directory' when run from an
installed location.
---

IMHO this is better handled with a follow-up as opposed to a repost.
While at that, please also take care of Petr's comment on 2/9.

Thanks,

Paolo


