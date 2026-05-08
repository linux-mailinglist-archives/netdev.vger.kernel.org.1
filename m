Return-Path: <netdev+bounces-285828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKNfIqvh/Wn0jwAAu9opvQ
	(envelope-from <netdev+bounces-285828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:14:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CF24F6DAF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 61FB8300BEA7
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BC73E276D;
	Fri,  8 May 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3E6Jmj3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606EB3DDDDB;
	Fri,  8 May 2026 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246052; cv=none; b=nWcZnficlefQhO5VBewxIq9PMx3rgpd+bbny1DlOz3jAY05a9Gbu5PP+HSdYwz+OHGWZ1/PgR2Sc+13CRYW/60f4xZLhH3ZQ3FmoYu3GV94Gtkj9rQfSEB40Bml3MjvzI/G+Jc1CMhoo9hOKNGH3aTaWfvVayD2056eBQ0STXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246052; c=relaxed/simple;
	bh=T9xjqblfP5Kt4p73w+ZmacLEOzrmjcyyAl7jfGRQ15k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UB1i/DD8qauGYVuBDLBEcaIRiY6btpBH5YEyp7iYmgFMRQ56nQFhTVkxjWPdI1Rwu//L4qWi5imWrSZ/o6P7DfXoSQi4uz8dgHBUfTfZX42xJ0cZdl7+WUEqOuLMT49ou3/ExpX5GoMGQRGxhoiQP1kR4azFv/K6JVxtDdn3DRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3E6Jmj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F36C2BCB0;
	Fri,  8 May 2026 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778246052;
	bh=T9xjqblfP5Kt4p73w+ZmacLEOzrmjcyyAl7jfGRQ15k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B3E6Jmj3TZY8Q+W7JPq2bwUryqyxvF1JQXv5kB1vCMgyhwSrYca1MwK6/xQtzQFN7
	 I7pnjEbnBlsifSii6MAtOoShUJqh6jHeR53SrTO0swPEmmzfjEvdhy2EyqNQkD/YqP
	 BaM+VQCHH3eBl4Uhrd8W3OmdU8pAFUpo1eUuem3S6vRZT0XrNPHZv1I/XzkD3K7jBj
	 vzdifR3loJ1AN4OUg5oOLt0qZXjZclPDpIqB8cH0sn1EWZ7niidcK8V0Z5hfONUwoF
	 gtmbqy5Q/7VEJdz2iuLnNIAPbDVWVTDmmQ2obSCzQYnzN2WHm4GeZEPXJeYANRUcsN
	 JRb50yW9mxANQ==
Message-ID: <151f5b1b-8a82-4d7b-b1c9-67da07853806@kernel.org>
Date: Fri, 8 May 2026 23:14:07 +1000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/4] net: fec: do not use readl()/writel() for ColdFire
To: David Laight <david.laight.linux@gmail.com>, Wei Fang <wei.fang@nxp.com>
Cc: "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "arnd@kernel.org" <arnd@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>,
 Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260506142644.3234270-2-gerg@kernel.org>
 <DBBPR04MB750044F98B1E719AD9DBD93E883D2@DBBPR04MB7500.eurprd04.prod.outlook.com>
 <20260508094043.20f5f3fc@pumpkin>
Content-Language: en-US
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20260508094043.20f5f3fc@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 86CF24F6DAF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285828-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,nxp.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On 8/5/26 18:40, David Laight wrote:
> On Fri, 8 May 2026 02:46:38 +0000
> Wei Fang <wei.fang@nxp.com> wrote:
> 
>>>   static void
>>>   fec_stop(struct net_device *ndev)
>>>   {
>>>   	struct fec_enet_private *fep = netdev_priv(ndev);
>>> -	u32 rmii_mode = readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
>>> +	u32 rmii_mode = fec_readl(fep->hwp + FEC_R_CNTRL) & FEC_RCR_RMII;
>>
>> This is not an issue, but since you changed this line, the new code should
>> follow the "reverse xmas tree" style.
> 
> Looking rmii_mode isn't even used until much later in the function.
> (and then not very often)
> Much better to read it just before it is needed.

Sure, but that feels like a change for a separate patch.
The changes to this file are a global search and replace.
The final produced object is identical before and after.

Regards
Greg


> 	David
> 
> 
>>
>> See: https://elixir.bootlin.com/linux/v7.0.1/source/Documentation/process/maintainer-netdev.rst#L380
>>
>>>   	u32 val;
>>>
>>>   	/* We cannot expect a graceful transmit stop without link !!! */
>>>   	if (fep->link) {
>>> -		writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
>>> +		fec_writel(1, fep->hwp + FEC_X_CNTRL); /* Graceful transmit stop */
>>>   		udelay(10);
>>> -		if (!(readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
>>> +		if (!(fec_readl(fep->hwp + FEC_IEVENT) & FEC_ENET_GRA))
>>>   			netdev_err(ndev, "Graceful transmit stop did not complete!\n");
>>>   	}
>>>    
>>
>>
> 


