Return-Path: <netdev+bounces-253814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4IDSNVubeGk9rQEAu9opvQ
	(envelope-from <netdev+bounces-253814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:02:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E17934C2
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 12:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8096930066B3
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9530B51F;
	Tue, 27 Jan 2026 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a494yn1e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E1F30B50D;
	Tue, 27 Jan 2026 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769511768; cv=none; b=G7Xl5xGxvbDTmUpWVdPjMPnJxG2BIyxBAN54fBcTH4pxlFlVmnN9vYdnLI3+5K/+/56nGGu+VQixrWI7TcyLY2rVAC+oTyc9bKYYmDdbv7sVZx/rKMy0162ih8AyyIfjnxsSmmEd7yIdTBR9vnMi7BA3CbWYmRxxQT6Gm+JZL7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769511768; c=relaxed/simple;
	bh=y1iQYc67DVhYxrB/p1GAQkjp9lfULkyMwv5pXHH1MeY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=ShqPFWpt+5+r1dlblnqHDTh+Df3/5KI1irBjKHE2Dr2pEjbp7sLwX/6bvRPSfA5sIrXFLFQ0jA/qGyEc2f9ji1EMCSg7domeVFg/pU9m+e2Qliv92nTUvheaFXHY36sM/egd1yffGalfRJSx7Csa1hXe3hVekfKehslY5gCYo74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a494yn1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E952FC16AAE;
	Tue, 27 Jan 2026 11:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769511768;
	bh=y1iQYc67DVhYxrB/p1GAQkjp9lfULkyMwv5pXHH1MeY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a494yn1earYfQdWtOeC6onTEwHjvoiyDrY14fuT7ksTyakta8da4aokFgA7IBkXxm
	 0Od5vvfE8dRocCFPZJbZTWC+Fx5utr1a2mVBzED22IBREwvFFn2xx/T8F0tYAWmTOu
	 sF30e3qIp3P3dF9+zSZBJKTx8rPwo03w9mE32KcwvYaLptde5SXhcTdoWpesHZ4bXE
	 tMk3S71XjdsRD1gXBRhSepD4pjtfsUZjGC6LHfyhLNBf405Uk8XAI1vVl1QKwb0vJG
	 yOh7tS9LQ/rQ5IABErR0zw2yNgk/hUUP27S2+lZpqTye7jgZSdBo/vsmVT9kmSIt7q
	 mgQSsni2aonpA==
Content-Type: multipart/mixed; boundary="------------KRL6Ja5OIm97DC6q0pB1trVX"
Message-ID: <1c357d72-2a73-47d8-9ec7-56a2912a2e10@kernel.org>
Date: Tue, 27 Jan 2026 12:02:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] net: spacemit: Check for netif_carrier_ok() in
 emac_stats_update(): manual merge
Content-Language: en-GB, fr-BE
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Chukun Pan <amadeus@jmu.edu.cn>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alexandre Ghiti <alex@ghiti.fr>,
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
References: <20260123-k1-ethernet-clarify-stat-timeout-v3-1-93b9df627e87@iscas.ac.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260123-k1-ethernet-clarify-stat-timeout-v3-1-93b9df627e87@iscas.ac.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253814-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1E17934C2
X-Rspamd-Action: no action

This is a multi-part message in MIME format.
--------------KRL6Ja5OIm97DC6q0pB1trVX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vivian,

+cc Mark Brown

On 23/01/2026 04:52, Vivian Wang wrote:
> Some PHYs stop the refclk for power saving, usually while link down.
> This causes reading stats to time out.
> 
> Therefore, in emac_stats_update(), also don't update and reschedule if
> !netif_carrier_ok(). But that means we could be missing later updates if
> the link comes back up, so also reschedule when link up is detected in
> emac_adjust_link().
> 
> While we're at it, improve the comments and error message prints around
> this to reflect the better understanding of how this could happen.
> Hopefully if this happens again on new hardware, these comments will
> direct towards a solution.

(...)

> ---
> This has a conflict in context lines in emac_adjust_link() with current
> net-next, which will show up when pulling that for next rc1. Just remove
> "emac_set_fc_autoneg(priv);".

Thank you for this note, this was useful! Just in case it can be useful
for linux-next and Net maintainers, I confirm the conflict when merging
'net' in 'net-next' due to this patch applied in 'net':

  2c84959167d6 ("net: spacemit: Check for netif_carrier_ok() in
emac_stats_update()")

and this one from 'net-next':

  f66086798f91 ("net: spacemit: Remove broken flow control support")

The resolution is attached to this email, and rerere cache is available
there:

 https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/526c74b

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------KRL6Ja5OIm97DC6q0pB1trVX
Content-Type: text/x-patch; charset=UTF-8;
 name="7daa0aa370b7e9326e11e06fdb247227773bba0a.patch"
Content-Disposition: attachment;
 filename="7daa0aa370b7e9326e11e06fdb247227773bba0a.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIGRyaXZlcnMvbmV0L2V0aGVybmV0L3NwYWNlbWl0L2sxX2VtYWMuYwppbmRl
eCBjODVkYzc0MmM0MDQsODhlOTQyNGQyZDUxLi4yM2I2ZjE1MzFlMGMKLS0tIGEvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvc3BhY2VtaXQvazFfZW1hYy5jCisrKyBiL2RyaXZlcnMvbmV0L2V0
aGVybmV0L3NwYWNlbWl0L2sxX2VtYWMuYwpAQEAgLTE1MzEsNiAtMTY0OCwxNCArMTU0NSwx
MiBAQEAgc3RhdGljIHZvaWQgZW1hY19hZGp1c3RfbGluayhzdHJ1Y3QgbmV0CiAgCQl9CiAg
CiAgCQllbWFjX3dyKHByaXYsIE1BQ19HTE9CQUxfQ09OVFJPTCwgY3RybCk7CisgCiAtCQll
bWFjX3NldF9mY19hdXRvbmVnKHByaXYpOwogLQorIAkJLyoKKyAJCSAqIFJlc2NoZWR1bGUg
c3RhdHMgdXBkYXRlcyBub3cgdGhhdCBsaW5rIGlzIHVwLiBTZWUgY29tbWVudHMgaW4KKyAJ
CSAqIGVtYWNfc3RhdHNfdXBkYXRlKCkuCisgCQkgKi8KKyAJCW1vZF90aW1lcigmcHJpdi0+
c3RhdHNfdGltZXIsIGppZmZpZXMpOwogIAl9CiAgCiAgCXBoeV9wcmludF9zdGF0dXMocGh5
ZGV2KTsK

--------------KRL6Ja5OIm97DC6q0pB1trVX--

