Return-Path: <netdev+bounces-299779-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2p5DKMAQMWpFbAUAu9opvQ
	(envelope-from <netdev+bounces-299779-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:00:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C47968D59B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 11:00:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iPBiG6Jt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299779-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299779-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D90A23071D9B
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405F635E937;
	Tue, 16 Jun 2026 09:00:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1DF30566D;
	Tue, 16 Jun 2026 09:00:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600441; cv=none; b=dKDe/Ykw9ekJJq5aqxHJiy6o23vJwmqGOupGoDWHhYy9tw3j6EPG38xCc2Zh33W9FkecNyvsW61PoAPwzumglKXZs6sCNLwdQi29AeXY1vcbwN8ntm8klSgfC61qKY0CZCyE+7J2MkKFnSt+ALHrFbFZ3bOCm35OxRtizbBo8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600441; c=relaxed/simple;
	bh=txUFyQ4KMotM1B7DPdaK7rfGZihY0uS7PixfkN/P50I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptu8jZM7XVXZesAjCSu6rRWCetq5goaAaNzumMXvqkGPResmnAEPaDBm9QpRalT7UGOvltEiYAysaRla0yClTM73v3IUzgFg7U+AcuZvdS4XDYSJVXsYkL0QXM8NNDig5FtH2cPr5GO9ITu1KkT323kc3/MY7VTFBXJmbHPrgbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iPBiG6Jt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C8E1F000E9;
	Tue, 16 Jun 2026 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781600439;
	bh=8Xac/pcyCaJiZ7nV6s+6xpBg5hN1rRtkHwd7W/lqNg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iPBiG6Jtt3f1+KZ0LWIRX5XIKyueDkb1yabsWU+sRQ1wHdJhFnBPmVu58QDXsLWwS
	 P1ipiN+z0Y7ErHC5Ao+rIJRLXIfRTKWnPrw/VAjEDjdE/+QLtcihQ4EAi3jBgF9ct9
	 xP/yOAHxJPRVuZts22psbPkZqX82+aWEbXiswQGE/o6AXotmhOKI4OGbt7y26Fgjhy
	 IhKGdYbZnPl2VsnX4zXVKtqlSMTt1Ssnu900QhGFvNc126WCE8XSwTVpfR5IIJHIfP
	 CGzTYkCiTMP6q14QeYHl5Kdzdq6ajBmg3a5Yh+N0W2sItx0c9nYqxu4DuZs4IPdnkK
	 QUiwhcU89028w==
Date: Tue, 16 Jun 2026 10:00:35 +0100
From: Simon Horman <horms@kernel.org>
To: hexlabsecurity@proton.me
Cc: David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org,
	Robert Dolca <robert.dolca@intel.com>, netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev, Samuel Ortiz <sameo@linux.intel.com>,
	Kang Chen <void0red@gmail.com>
Subject: Re: [PATCH] nfc: fdp: reject an oversized device-reported packet
 length
Message-ID: <20260616090035.GS712698@horms.kernel.org>
References: <20260615-b4-disp-f42dce2d-v1-1-186ff3dcbf37@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615-b4-disp-f42dce2d-v1-1-186ff3dcbf37@proton.me>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299779-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[ixit.cz,vger.kernel.org,intel.com,lists.linux.dev,linux.intel.com,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:david@ixit.cz,m:linux-kernel@vger.kernel.org,m:robert.dolca@intel.com,m:netdev@vger.kernel.org,m:oe-linux-nfc@lists.linux.dev,m:sameo@linux.intel.com,m:void0red@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[vger.kernel.org:query timed out,proton.me:query timed out];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RSPAMD_EMAILBL_FAIL(0.00)[hexlabsecurity.proton.me:query timed out,horms@kernel.org:query timed out];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C47968D59B

On Mon, Jun 15, 2026 at 03:04:02AM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> fdp_nci_i2c_read() reads the length of the next packet from the device
> into phy->next_read_size and uses it as the i2c_master_recv() byte count
> into a fixed on-stack buffer:
> 
> 	u8 tmp[FDP_NCI_I2C_MAX_PAYLOAD];		/* 261 bytes */
> 	...
> 	len = phy->next_read_size;
> 	r = i2c_master_recv(client, tmp, len);
> 
> When a "length packet" arrives (tmp[0] == 0 && tmp[1] == 0), the next
> length is taken verbatim from two device-supplied bytes:
> 
> 	phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
> 
> next_read_size is a u16, so this can be driven as high as 65535 - far
> larger than the 261-byte tmp[] buffer - and it is never bounded before
> the next iteration's i2c_master_recv(). A malfunctioning, malicious or
> counterfeit FDP NFC controller (or an attacker tampering with the I2C
> bus) that sends such a length packet makes i2c_master_recv() write up to
> about 64 KB into the 261-byte on-stack buffer: a stack out-of-bounds
> write that clobbers the stack canary, saved registers and the return
> address.
> 
> Reject a next_read_size larger than the receive buffer the same way a
> corrupted packet is already handled - drop it and force resynchronization
> - so a device can never drive an over-length read.
> 
> Fixes: a06347c04c13 ("NFC: Add Intel Fields Peak NFC solution driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
> ---
> I reproduced the out-of-bounds write with an in-kernel test that drives
> the fdp_nci_i2c_read() buffer geometry verbatim under KASAN
> (CONFIG_KASAN_STACK=y), modelling i2c_master_recv() delivering
> next_read_size device bytes into the 261-byte tmp[] buffer:
> 
>   next_read_size = 281, no bound:
>     BUG: KASAN: stack-out-of-bounds in i2c_master_recv...
>     Write of size 281 ... [48, 309) 'tmp'   (the 261-byte buffer)
>   with the device length bounded to <= FDP_NCI_I2C_MAX_PAYLOAD (what this
>     patch enforces): no KASAN report.
>   a well-formed packet (length <= 261) is unaffected, no KASAN report.
> 
> The full device range - next_read_size = 65535 (tmp[2] = 0xff,
> tmp[3] = 0xfc; the u16 field truncates the + 3), a 65535-byte write =
> 65274 bytes past the buffer, smashing the stack canary and the return
> address - reproduces the same way under userspace AddressSanitizer on
> both -m32 and -m64.
> ---
>  drivers/nfc/fdp/i2c.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
> index c1896a1d978c..0392bb49bb4b 100644
> --- a/drivers/nfc/fdp/i2c.c
> +++ b/drivers/nfc/fdp/i2c.c
> @@ -166,6 +166,20 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
>  		/* Packet that contains a length */
>  		if (tmp[0] == 0 && tmp[1] == 0) {
>  			phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;


Thanks Bryam,

I agree with your analysis regarding overrunning tmp and that the
fix for that is correct.

But I am concerned that there is also an expectation in the code that
next_read_size is always at least FDP_NCI_I2C_MIN_PAYLOAD (5).
But that smaller values can be achieved if either:

* tmp[2] is 0 and tmp[3] is < 2.
* the addition above overflows 16bits. e.g. both tmp[2] and tmp[3] are 255.

So I wonder if the check you are adding below should also guard
against phy->next_read_size < FDP_NCI_I2C_MIN_PAYLOAD.

> +
> +			/*
> +			 * next_read_size is taken from the device and is used
> +			 * as the i2c_master_recv() count on the next iteration.
> +			 * A value larger than the receive buffer would overflow
> +			 * tmp[]; treat it like a corrupted packet and force
> +			 * resynchronization.
> +			 */
> +			if (phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
> +				dev_dbg(&client->dev, "%s: corrupted packet\n",
> +					__func__);
> +				phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
> +				goto flush;
> +			}
>  		} else {
>  			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
>  
> 
> ---
> base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
> change-id: 20260615-b4-disp-f42dce2d-055035ea37ba
> 
> Best regards,
> -- 
> Bryam Vargas <hexlabsecurity@proton.me>
> 
> 

