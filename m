Return-Path: <netdev+bounces-284488-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJ14FKQT+mlRJAMAu9opvQ
	(envelope-from <netdev+bounces-284488-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:58:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C21F4D0C1A
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A75D0302E33F
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DD648AE1C;
	Tue,  5 May 2026 15:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="oHMtNo/z";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="rawzbc3c"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D5E48AE01;
	Tue,  5 May 2026 15:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996468; cv=none; b=NksGwhrBo7VukLIOSn7Z1yasI/cSPcttdCh5F1t3SFc8unvc0r7A9YN1nxpfnwNIWRlAuSZmeYVxID0SadOBsKvkmKMQomqY5Tj3bI5BrBA5DcWIJSD/KRIS/f8b7+vlknq2lIaTTvpw7e4+lEHdFcoeiCppMPcQptPiCEvVjHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996468; c=relaxed/simple;
	bh=d3jSNFU4odcki8bw1xHCG7IfNPbfF8hlOZzKbcXN3Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KB6/6v+HJvw0SXPw3T8DVO8+6BJev4S8UO2zBTBiH+8pjeywo+R+QIyvbNtGDrvcZzRdYURwdPbRvEJ7O/jgs4ptoDXsn4vcNpL7ArBvcDJJGOkaPa4ARLDi0/JKVnQ/Q2fXm5EvdKkx4jsZdRXiD6TPPjZxpFKqTZNoFBZ6Z+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=oHMtNo/z; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=rawzbc3c; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777996459;
	bh=d3jSNFU4odcki8bw1xHCG7IfNPbfF8hlOZzKbcXN3Sc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oHMtNo/zmqyDWJXW16kIFUCaEl8G8NeTvdasgoHqoQGJzn2qjx96E20PQjifPeEsl
	 mUBLvWWuaJlbhcLJkMuLnSVbXMGhI0phwb6EJVqSf78xonyPy3VWCAcX/ml1DVlo+X
	 ACIRvf2oVe1RXkRrzWZqitMeFmhHxlm5BVz3j86aeP0ND5jeky0XMlhtdUq16/+sid
	 kFlrHzL0k0Z9mh+1hQtft77DKkpB/vZTje6fajcWAOPm32yIZhJI5pzI7A0wcK+8WS
	 Oaf2F3IKtGxEQGj/Z+138lhjxmEUrWWfHBTYJB90z2DAxZVjFzJ06ZKaHWIA/8wOt4
	 SV3Krxm4BKcNA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 58EC542541; Tue,  5 May 2026 15:54:19 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1777996456;
	bh=d3jSNFU4odcki8bw1xHCG7IfNPbfF8hlOZzKbcXN3Sc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rawzbc3ckh/At9WZOAKPoqLPgegIk69gmyZigm/NfEz2ptwuYUTt9CLnKj6ZWxsoT
	 BmaWAKiHmD1sMn5XLRU0cH9/6Pev5QmCl7ZLyNyAo6KRAbqDZELYamZbx4yWCYRKOP
	 bAFi1qbSnzXwqTRq7J3lM81rehOVnlWAIof3BzVBzhRdCPHyhiCF7aksFtBAuUHokU
	 zbzuql8w98Z++0oRnCAjxVKQY0Jk2zSffgB94A1y8OUFY1rhqdeRNjXc4B4/qA+mnm
	 xuiyOGM4nYwnibFOfxOTTIxc0brcP5MdiMAByZhqfBKIz2NZiCxm4ZJRiLNZlST7b+
	 elro2oil83BVQ==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 7615642464;
	Tue,  5 May 2026 15:54:16 +0000 (UTC)
Message-ID: <ba452675-9ced-4ff2-867c-3ece80919267@birger-koblitz.de>
Date: Tue, 5 May 2026 17:54:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] r8152: Add support for the RTL8159 chip
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, hsu.chih.kai@realtek.com, olek2@wp.pl
References: <20260502-rtl8159_net_next-v3-2-12c895d46cd6@birger-koblitz.de>
 <20260505023022.877676-1-kuba@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260505023022.877676-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9C21F4D0C1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,realtek.com,wp.pl];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284488-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:dkim,birger-koblitz.de:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 05/05/2026 4:30 am, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> ---
> r8152: Add support for the RTL8159 chip
> 
> This patch adds support for the RTL8159 chip as RTL_VER_17, reusing the
> RTL8157 initialization and USB power management paths. The bulk of the
> new code lives in r8157_hw_phy_cfg() to configure the RTL8159 PHY, and
> the USB product ID 0x815a is added to the device table.

> Is the leading space before ocp_byte_clr_bits here intentional?  The rest
> of the switch statement uses a single tab for indentation.  checkpatch.pl
> should catch this.
No, will fix in v4. Interesting, that checkpatch does not find this. I 
am very sure I ran b4 prep --check before, it is near impossible to omit 
that step before sending.

> 
> Small typo, "nomal" -> "normal".
Will fix.

>> +		/* close Sparse NEC, improve connect 5EUU calble performace */
>                                                        ^^^^^  ^^^^^^^^^
> 
> Two typos here, "calble" -> "cable" and "performace" -> "performance".
Will fix.

> Is this "will include in v10" comment a reference to an internal Realtek
> source-tree revision?  It does not appear to have meaning in the upstream
> tree and could be dropped or rephrased.
I will drop this.

>> @@ -8201,6 +8407,11 @@ static void r8156_init(struct r8152 *tp)
>>   			return;
>>   	}
>>   
>> +	if (tp->version == RTL_VER_17 && r8159_wait_backup_restore(tp)) {
>> +		dev_err(&tp->intf->dev, "init failed, backup-restore timed out\n");
>> +		return;
>> +	}
>> +
> 
> Should this path also set RTL8152_INACCESSIBLE on tp->flags, or should the
> init callback be changed to return an error that probe can honor, so that
> a half-initialized device is not exposed to userspace?

I'll set RTL8152_INACCESSIBLE in line with what is done already in the 
rest of r8156_init()


>> @@ -8274,7 +8485,10 @@ static void r8156_init(struct r8152 *tp)
>>   	set_bit(GREEN_ETHERNET, &tp->flags);
>>   
>>   	/* rx aggregation / 16 bytes Rx descriptor */
>> -	if (tp->version == RTL_VER_16)
>> +	if (tp->version == RTL_VER_17)
>> +		ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
>> +				  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
>                                                                   ^^^^^^
> 
> What does BIT(11) in USB_USB_CTRL correspond to here, and is it
> RTL8159-specific?
> 
> The commit message says the RTL8159 "reuses hardware features of the
> RTL8157 (RTL_VER_16)", but this path clears an extra bit that the
> RTL_VER_16 path does not.  Since there is no symbolic name or comment,
> it is hard to tell whether RTL_VER_16 is missing this clear, whether
> RTL_VER_17 should not be clearing it, or whether it really is an
> RTL8159-only quirk.
> 
> Could a named define and/or a short comment be added to describe what
> this bit does?


This was brought up before, and unfortunately, there is no documentation
whatsoever for this bit. Any guess at a name may turn out to be misleading.
But I will change the comment to read:

/* RX aggregation / 16 bytes RX descriptor
  * BIT(11) is specific to RTL8159, with unknown meaning
  */
if (tp->version == RTL_VER_17)
	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL,
			  RX_AGG_DISABLE | RX_DESC_16B | BIT(11));
else if (tp->version == RTL_VER_16)
	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_USB_CTRL, RX_AGG_DISABLE | 
RX_DESC_16B);
else ...

Birger


