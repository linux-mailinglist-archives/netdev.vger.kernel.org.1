Return-Path: <netdev+bounces-274424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFF4CewpzmnIlQYAu9opvQ
	(envelope-from <netdev+bounces-274424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:33:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9EF38610C
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 10:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A00F304F5C8
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 08:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6081533D511;
	Thu,  2 Apr 2026 08:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kApNznKQ";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="kApNznKQ"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0674E31195B;
	Thu,  2 Apr 2026 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775118489; cv=none; b=YDNKVAcCl0giQa6IyiN2DvI/Mc2mXknGDjVHbsTxsxYGuhKDXzBFkpHIR+5hKNAWsdCRaEtF63vQBDDfpEJ8Sc8gLIaGBlewqu8dXmzUe+KejVT7Kn2a2/RaHG3TCcbDwnsQEtc95UXBOAO8EylVwWy4PL9dAgR3f0MGWS6C3xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775118489; c=relaxed/simple;
	bh=hVfGpAJTqyQRDdHBTIYGWkYYfiFdJfEiPDa7HlPTy9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NOPpJf+lD4BbKEs4E25e77zp+gs8SZFsnLStfvKR+Su/DInhGHsRuxj9OF2kTzqASEDo8AiBrYzF/MdPeiqj2EdktgNVUEX96bSrGjwEh0cpioN6Q4VyAWtFMtnBpstudsEAy3zZAs0sIvA6u/TzITC6mFt+3RAM5oM+NW5ER/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kApNznKQ; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=kApNznKQ; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775118479;
	bh=hVfGpAJTqyQRDdHBTIYGWkYYfiFdJfEiPDa7HlPTy9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kApNznKQZXCs5GNhAaJkqQo4JztwnlvrK/dd4hr0EVhI5UJdi8SESyBEOIotJkH+1
	 Mh05uzPs+0y80Gu//FCt7tlpuy40qp94pRtzfiho7FjMqD1Va1ilG9dngPGks0YiCc
	 /xWnVIHlTDB+nlVHL6uzLYlN5G5ZXUVjaeLif2sbe9AYH6TC+looy0BuARe5zscmIv
	 JjRFZ+GR5GCwHHFvSeDXpO0BZskScZQ3fEyZbR2DfVNoGSipxg75GdnSjV/gQHGN2E
	 8xvwp2Njj43fXfQ2MKMr/SHduXCVN85yq/eatBmWn9/Sjptfk9CPCcXUMHDwu7sJrt
	 t0Nwsy8TkeB3g==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id D96B6408C7; Thu,  2 Apr 2026 08:27:59 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775118479;
	bh=hVfGpAJTqyQRDdHBTIYGWkYYfiFdJfEiPDa7HlPTy9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kApNznKQZXCs5GNhAaJkqQo4JztwnlvrK/dd4hr0EVhI5UJdi8SESyBEOIotJkH+1
	 Mh05uzPs+0y80Gu//FCt7tlpuy40qp94pRtzfiho7FjMqD1Va1ilG9dngPGks0YiCc
	 /xWnVIHlTDB+nlVHL6uzLYlN5G5ZXUVjaeLif2sbe9AYH6TC+looy0BuARe5zscmIv
	 JjRFZ+GR5GCwHHFvSeDXpO0BZskScZQ3fEyZbR2DfVNoGSipxg75GdnSjV/gQHGN2E
	 8xvwp2Njj43fXfQ2MKMr/SHduXCVN85yq/eatBmWn9/Sjptfk9CPCcXUMHDwu7sJrt
	 t0Nwsy8TkeB3g==
Received: from [IPV6:2003:c6:9f04:eb00::1c8] (p200300c69f04eb0000000000000001c8.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00::1c8])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 43692408BC;
	Thu,  2 Apr 2026 08:27:59 +0000 (UTC)
Message-ID: <2d8ae453-9b1a-40b2-886c-8558d6026331@birger-koblitz.de>
Date: Thu, 2 Apr 2026 10:27:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chih Kai Hsu <hsu.chih.kai@realtek.com>
References: <20260331-rtl8157_next-v5-0-deb3095f8380@birger-koblitz.de>
 <20260401203711.7e56ff95@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260401203711.7e56ff95@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-274424-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F9EF38610C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/2/26 05:37, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 17:55:52 +0200 Birger Koblitz wrote:
>> Add support for the RTL8157, which is a 5GBit USB-Ethernet adapter
>> chip in the RTL815x family of chips.
>>
>> The RTL8157 uses a different frame descriptor format, and different
>> SRAM/ADV access methods, plus offers 5GBit/s Ethernet, so support for these
>> features is added in addition to chip initialization and configuration.
> 
> This version does not seem to apply to net-next.
> Please make sure you base it on net-next not linux-next.
Sorry about that, I was not aware of the parallel changes. I have rebased
to net-next and will send a v6.

