Return-Path: <netdev+bounces-269540-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL4+If0nvGkxtgIAu9opvQ
	(envelope-from <netdev+bounces-269540-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:44:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2DC2CF04C
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 044DB32A0174
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E85683EF0DD;
	Thu, 19 Mar 2026 16:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="xjr9l2qd";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="d8FbnP+M"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DF93ED5B8;
	Thu, 19 Mar 2026 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937921; cv=none; b=k+2JuqGoa5q29cLfHkkj4D03irImwpIN9xRGJRJC9h5IPObR2st39+O56ZXWRSgWtW4NkHJ54egFoqB1ZjdT28QoNggqPNty+82jmpKweNhVByjSiS6cEcvwF6L30VfVdywmRqytpMzJoMOD52ZLp+22bEN3s6GPJsBPs6oOG7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937921; c=relaxed/simple;
	bh=cjOJRGM5EfY+bva2MdjDHWNLLJjDVfgTZxBmEQFxoOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LFNXQMe0e62gB8Z0ongciM5unqWxdF6jKMqC+3c1I1jOvlV4z12yJ498KfdoG3bKLcuw7tMqrmQVCokZc93j3/JiGRrLigSQY5hIkIG8Dfyy2Wn3+n/aSX7OV0CY/7Ox5ULJTA73x2hM5FbPwSGRhOiJ/tfOGMTp9aZU8CBuzrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=xjr9l2qd; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=d8FbnP+M; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773937908;
	bh=cjOJRGM5EfY+bva2MdjDHWNLLJjDVfgTZxBmEQFxoOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xjr9l2qdo03bJ8PUO2qHbojVf84pH6gFkogkx8+H7nT/MCBfAH69kecfYvnJOujsh
	 amMZhG2gEKIgd6KMtiBW9j9Yi+7W4CbrypETaCA3DE6gUSGxAoCmJNHChCEeqK3eGZ
	 JPZfR5UyfkKqqFJrnIHx0l6KuXFrXlkBHbQkfuyQ7xz0/PNFOexRMPXh4IXqJlqThb
	 0B+18/6rxWDLy48FmWgGhbXIfVSTa87gLY5mL2PsnfGT40uODjOwin+tjeaM5yzi15
	 PkvOhAGMjIyaExqZP/L6g1Fmv3PizAPWSLoVhpbaMpQFqqjV4I3eHdaQrmHbBvnP4v
	 LyrTmGFAdRCfg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 44E8B3FE95; Thu, 19 Mar 2026 16:31:48 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773937907;
	bh=cjOJRGM5EfY+bva2MdjDHWNLLJjDVfgTZxBmEQFxoOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d8FbnP+MeAABtslW5aIs5lp2eKysEzl+RnbL3UuUXCug6klWQ1vK/h0YpdYJg5sB1
	 whMhuSi6kPE7xUTcTZ7ejA5KgxxAaPRmPnIwM0mYE/WTlmJOP9cNKzaarCNxLypO3S
	 TLkNj2qAf2ZdZnpiYRpymk97t7/a7uVDQUD3XsIEfaEVkgnafYo1U43ZJV60v2+9Bz
	 1JIFbmdSPJz60Skfjh0UMlBiW+teClajV9Cy9r74PhjQOJU6xwhAKfFu8nKBrjFyei
	 j2+vZizu/rkqfaAGvgzKuQPulQx3Yv1AX2aSTa5JiSKkKQzuz04XiZsWSW9Uf4NOZU
	 NfsIMsNqBnDYg==
Received: from [IPV6:2a00:6020:47a3:e800:1acf:2b46:72be:2ba5] (unknown [IPv6:2a00:6020:47a3:e800:1acf:2b46:72be:2ba5])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 958AA3FE49;
	Thu, 19 Mar 2026 16:31:46 +0000 (UTC)
Message-ID: <44ef7491-dc20-40ae-a695-2c71b5ca575d@birger-koblitz.de>
Date: Thu, 19 Mar 2026 17:31:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
 <339655b1-59e3-42d6-a460-b8424d7fd279@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <339655b1-59e3-42d6-a460-b8424d7fd279@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	TAGGED_FROM(0.00)[bounces-269540-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: DC2DC2CF04C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/03/2026 16:53, Andrew Lunn wrote:
>> This patch is on top of linux-next as the code re-uses the 2.5 Gbit EEE
>> recently added in r8152.c.
> 
> Is 'linux-next' a typo? net-next should also have the EEE code, that
> is the patch networking code takes.
> 
> 	Andrew
I based it on linux-next, but the r8152.c driver file which is patched here,
is in both cases identical. The patch will work with net-next. I used
linux-next because I had planned to submit the patch for the next
kernel release cycle, but then was much faster than thought.

Birger

