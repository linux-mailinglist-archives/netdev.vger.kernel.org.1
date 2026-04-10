Return-Path: <netdev+bounces-277260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHZSO4iU2GkgfggAu9opvQ
	(envelope-from <netdev+bounces-277260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:11:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A9A3D28FD
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 08:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24DA13015499
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 06:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814F133D4E9;
	Fri, 10 Apr 2026 06:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="BbjEunfA";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="t/n5YiwY"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6214E29AAEA;
	Fri, 10 Apr 2026 06:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775801474; cv=none; b=C5YV5jnWuG5txp5YscLHVvohnPEp5YDBxrs96lZphgxm0sI5xt98VDAhly7wZvTTZVX1kajGLSldVpfa/ZyRwZs5A9ktLGHmSBZdaHS7kPKKZpvie9xocUyjPo6E7NDDg8FB4WzUHuwvzgIy7Oj4oMSCZHZDdH0bgOCF5EFe5IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775801474; c=relaxed/simple;
	bh=bHNbWMueZfUuYJdYPoX5RMXp1JV1ye+G1T6K+YUSiR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkAaLZG586sNC1sElOo69+QtnpWFtcKxyCpLiSa5wrSnFkNwmRqdWcWVmxWKs7r+pIISYqDg4uRQ6MDGRtjZqJactluG2i403IBF0EOIE3H6/H3NAyz+YiXXyR7UmcUZPHt6jd60k1BTDr203MOAJ2sWBL7XTfe25kzTWwOtoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=BbjEunfA; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=t/n5YiwY; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775801470;
	bh=bHNbWMueZfUuYJdYPoX5RMXp1JV1ye+G1T6K+YUSiR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BbjEunfA6wycr02x6Xlm1xIb/3ytIykKN8zFXBftLKglCIk5l6F2J6qVx6n6w2q0Z
	 0Ty1R6Ehy6yCKkK5EcxGX2a6NXKa4wRdTeczqe/ATvjG+JkRWRV1b0geAztAW8M5iK
	 SbYpyGbjucR2hJxRuypvqsrQEf+LfDqh/HqjgQzWPE6xFwfV6Ayti0o/MqfRp5qgfm
	 OTKYLTCtCD2xT1IGYDYBQC0dJVNQtoVSIK3pjKqz5WyjF5/lNSorO6U8+ja9OlboFU
	 SdtNGqkv94U0iirURCB89xsZFmnUPKg4IbQnSmhjoSQLWE6qNch4K1me+6Unqk6BXm
	 8tF1msr0gMmPw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id A029E4117A; Fri, 10 Apr 2026 06:11:10 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775801469;
	bh=bHNbWMueZfUuYJdYPoX5RMXp1JV1ye+G1T6K+YUSiR4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=t/n5YiwYiBrYCd0n4QkXIUKaYA4zrlMgeqACi9VI2Ezy/wHeHcQpFxscrpr/b+HYq
	 2a7ZC+Hr2JCHEbwTyonTuRhMRb7hcbC8QNpvXwTHeSFxCO5foR7V2faOXTdNxPVlXt
	 Z5CmuRB9dsqGT0PshOJ6YSIqQ80fwIN8XBAiK53qb3b0/lDuF9YBDLjiKaoUh/z+pZ
	 83VK+kw2cOKEPI3lrC+V9vuj0l2BF7s1BYwWuJge62E4hiTW7JZP2TJmLhTmbF5kVp
	 DkG12C60MBWZ4mafWUsn+ARrwVf0XoWd/5ZiVgmYTzfN/iVYhn/Eo49/edDhS7jDre
	 5PuMUTsabX5oA==
Received: from [IPV6:2003:c6:9f04:eb00:d892:db88:9ecc:d39a] (p200300c69f04eb00d892db889eccd39a.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00:d892:db88:9ecc:d39a])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id B3BD34116D;
	Fri, 10 Apr 2026 06:11:09 +0000 (UTC)
Message-ID: <2929dbc0-dd40-45de-908a-25f934738667@birger-koblitz.de>
Date: Fri, 10 Apr 2026 08:11:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/9] r8152: Add support for RTL8157 SRAM access
 and ADV indirect access
To: kernel test robot <lkp@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260314-rtl8157_next-v1-2-9ba77b428afd@birger-koblitz.de>
 <202604101309.B9mdviRN-lkp@intel.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <202604101309.B9mdviRN-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-277260-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97A9A3D28FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 10/04/2026 07:17, kernel test robot wrote:
> Hi Birger,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on 5c9e55fecf9365890c64f14761a80f9413a3b1d1]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Birger-Koblitz/r8152-Add-support-for-RTL8157-RX-TX-descriptor-format/20260315-014044
> base:   5c9e55fecf9365890c64f14761a80f9413a3b1d1
> patch link:    https://lore.kernel.org/r/20260314-rtl8157_next-v1-2-9ba77b428afd%40birger-koblitz.de
> patch subject: [PATCH net-next 2/9] r8152: Add support for RTL8157 SRAM access and ADV indirect access

This refers to the initial version of the patch, possibly v1, but v7 was applied, which did not even
have this particular patch. This is probably a configuration issue of what the robot sees.

Birger

