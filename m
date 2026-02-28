Return-Path: <netdev+bounces-262075-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lUmpF6hpoml82wQAu9opvQ
	(envelope-from <netdev+bounces-262075-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:06:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19661C03D4
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 962F130470ED
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F933624A3;
	Sat, 28 Feb 2026 04:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="EU9flSfb"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F6786329;
	Sat, 28 Feb 2026 04:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772251556; cv=none; b=QkMt2lxaqX+XfXeyEkrv2Jv4epvopPS0faGkaaY/bVr2K7NElDAulOaa+UgJ3grTI9u2YXvrH5DqRma7T9/c+KlABnExlRSkkcgvSfjX316bZLhcJE0bMJ+DZW+JV7q5Z990o/rNyskut7Q6K5ySSKvlsNvN/nZe390KaIynqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772251556; c=relaxed/simple;
	bh=NVo/x8wI3sBzRix9ZdBw48lx6RNIhk8vsoord1JNpPo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XTbUDk3FvntsvC4XlTe8e93Vha+o8e8r++lId0FF+XiCZpIpg3jdLVsCRs+7EPHLAEEA8diH09mfqk1MYSiHp+2ZgGH0GVHKjXH+Qf1ibdtJTOeesLcWLVlNygrVyWUaYp5vN0UJJ//Q44+VBre/rv8GmxfQuIuivxt5vcCO46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=EU9flSfb; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fNBGz2Tccz9tNn;
	Sat, 28 Feb 2026 04:57:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1772251051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVo/x8wI3sBzRix9ZdBw48lx6RNIhk8vsoord1JNpPo=;
	b=EU9flSfbYNytwylV0LeK991Ml7Y0745opPa8s8x3KG33XqJ6heUtjhhN/BBIN+BcgyHnCy
	mjqBrpK9g1r3N0Y8ly0hhJmWPVBBCk1rA4AeBxViZM0yAtl+bZ+7rXM7lPwNUafysfMrcG
	fbILcxVz9deTl1/HTvKvMcpQHtymWahuiPKRuyzgR2ACc3wBnuydhQumvsbMYIzPqswRXE
	ALHiQGZ0KZKciVRi9AXkvqsMhh5ANI5+/5Lf3kXpWnSoGpkLX5r69exCmgXLi5dQAdKACh
	W3ZYj/vcrgWGb8LiS0RxPGIp6pKUYdlxFvEHETvT74tEltULGpPVfC1s04V+vA==
Message-ID: <d6c83860-85ba-4a99-b2ab-486ad040ea55@mailbox.org>
Date: Sat, 28 Feb 2026 04:57:25 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next,PATCH v3 3/3] net: phy: realtek: Add property to enable
 SSC
From: Marek Vasut <marek.vasut@mailbox.org>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Aleksander Jan Bajkowski <olek2@wp.pl>, Andrew Lunn <andrew@lunn.ch>,
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Ivan Galkin <ivan.galkin@axis.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Michael Klein <michael@fossekall.de>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, devicetree@vger.kernel.org
References: <20251218173718.12878-1-marek.vasut@mailbox.org>
 <20251218173718.12878-3-marek.vasut@mailbox.org>
 <a37be87a-e1aa-443a-9005-da62e4f51d63@mailbox.org>
Content-Language: en-US
In-Reply-To: <a37be87a-e1aa-443a-9005-da62e4f51d63@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: deqoxt48yyi1ib7kgunqjmrsiwtdprne
X-MBO-RS-ID: abd2de6ed91807ff2ca
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262075-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,wp.pl,lunn.ch,kernel.org,google.com,gmail.com,axis.com,fossekall.de,redhat.com,armlinux.org.uk,nxp.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A19661C03D4
X-Rspamd-Action: no action

On 2/4/26 3:25 PM, Marek Vasut wrote:
> On 12/18/25 6:36 PM, Marek Vasut wrote:
>> Add support for spread spectrum clocking (SSC) on RTL8211F(D)(I)-CG,
>> RTL8211FS(I)(-VS)-CG, RTL8211FG(I)(-VS)-CG PHYs. The implementation
>> follows EMI improvement application note Rev. 1.2 for these PHYs.
>>
>> The current implementation enables SSC for both RXC and SYSCLK clock
>> signals. Introduce DT properties 'realtek,clkout-ssc-enable',
>> 'realtek,rxc-ssc-enable' and 'realtek,sysclk-ssc-enable' which control
>> CLKOUT, RXC and SYSCLK SSC spread spectrum clocking enablement on these
>> signals.
>>
>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
> Is there anything that should be adjusted in these patches ?

How can we proceed here ?

