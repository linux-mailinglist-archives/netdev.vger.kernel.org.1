Return-Path: <netdev+bounces-294259-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XouqH6ntHmr7ZAAAu9opvQ
	(envelope-from <netdev+bounces-294259-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:50:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A862F746
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 16:50:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=WULXRrZl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294259-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294259-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 510FE338ED27
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E1C3F1AD8;
	Tue,  2 Jun 2026 14:39:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50C3EC2F8;
	Tue,  2 Jun 2026 14:39:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411186; cv=none; b=aslyffyOAzUPgyRxv7J8pO8C5FSCPMW+WgXkSOyM2BNfzQwHW+Y9lggYLZSmapvH1pSpKNheS3dspDUv3C2Eei8Pda2tnOdpyyjti1KtKrGuFv8HAvKU9VtPYCNzC8CbG1pc+cv3dkqYGSiDBveo5qm+JhxKNdWvD12rnpVVo/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411186; c=relaxed/simple;
	bh=LAMBj6aYpplXAlYLN4ZUEnGZPujKLvNggGo2VH8mzXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSiw1VUxT1RwQ1f0uu2SBT2QCRCH+gt4X5Fbi9Ktbs/9I7x8Cpe0whCYJkCUQGTJwry/oAeMElXsK+yq1DsYjA7owE1ufQLN9rBvWUlD8+Jmamxpu36jFz0iQF6HZ2g5cadYsWGSEclgbnRjtCWDMQ533AhIMIl1pclwnQF9TjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WULXRrZl; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2yTFg8zXujpXN4UZD70cI8WNKyrOKFmDDdxuAIlK6M4=; b=WULXRrZl/m6pxN5DUaHQlSF4jL
	4YjRfLR7mN64uq3KofcwYOhCkBt4Hxrlp563PwImPTAcFiA4yMeLTUiAXH5Pb/ZgMRKBFFlyw0UBo
	EjZEufnwHJTXBPBj7pUJk/zThgzML0DE+sbYfGA78HLZopWHwmeN7yKCsg2QXSX79ZSNZBcRogEuT
	ahBE4rOF8Z84zaM3Rk05ByKPdRpdwMk80jlstERsCfQQ+xd6qBplXZV5pM9vRZ/VPMGyC/OX/dvSt
	OMrzqis44gIjnfUHSgTbvk42krzadxuBNoPGCttRNEJvSyVKN7JY8JYs6zOKJ/p4y/TIQBLgj3c0P
	jl68NzlA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wUQHE-0031kP-1a;
	Tue, 02 Jun 2026 14:39:32 +0000
Date: Tue, 2 Jun 2026 07:39:26 -0700
From: Breno Leitao <leitao@debian.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Ben Hutchings <ben@decadent.org.uk>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Brett Creeley <brett.creeley@amd.com>, 
	Kees Cook <kees@kernel.org>, netdev@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [net-next] [v3] net: sfc: avoid format string warning
Message-ID: <ah7qyOv2aCAOIKO8@gmail.com>
References: <20260602135347.3179200-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602135347.3179200-1-arnd@kernel.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294259-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:arnd@kernel.org,m:ecree.xilinx@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:arnd@arndb.de,m:ben@decadent.org.uk,m:nathan@kernel.org,m:nick.desaulniers+lkml@gmail.com,m:brett.creeley@amd.com,m:kees@kernel.org,m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:ecreexilinx@gmail.com,m:andrew@lunn.ch,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,arndb.de,decadent.org.uk,amd.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,decadent.org.uk:email,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C45A862F746

On Tue, Jun 02, 2026 at 03:53:04PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Three sfc drivers contain the same *_fill_test() function that takes
> a format string argument that gets passed down to snprintf(), producing
> a warning with clang-22:
> 
> drivers/net/ethernet/sfc/falcon/ethtool.c:227:60: error: diagnostic behavior may be improved by adding
>       the 'format(printf, 7, 8)' attribute to the declaration of 'ef4_fill_test' [-Werror,-Wmissing-format-attribute]
>   210 |                 snprintf(test_str, sizeof(test_str), test_format, test_id);
>       |                                                                          ^
> drivers/net/ethernet/sfc/falcon/ethtool.c:210:13: note: 'ef4_fill_test' declared here
> 
> Rework these to take a varargs based test_format that allows better
> type checking and a non-varargs unit name that gets pre-filled by
> the caller, so that the compiler can validate all format strings.
> 
> Fixes: 3273c2e8c66a ("[netdrvr] sfc: sfc: Add self-test support")
> Link: https://lore.kernel.org/all/20260325134557.3406655-1-arnd@kernel.org/
> Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Ben Hutchings <ben@decadent.org.uk>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Breno Leitao <leitao@debian.org>

> diff --git a/drivers/net/ethernet/sfc/siena/ethtool_common.c b/drivers/net/ethernet/sfc/siena/ethtool_common.c
> index 76cbce2b9592..9df08f1e2347 100644
> --- a/drivers/net/ethernet/sfc/siena/ethtool_common.c
> +++ b/drivers/net/ethernet/sfc/siena/ethtool_common.c
> @@ -199,18 +199,17 @@ int efx_siena_ethtool_set_pauseparam(struct net_device *net_dev,
>   * @strings:		Ethtool strings, or %NULL
>   * @data:		Ethtool test results, or %NULL
>   * @test:		Pointer to test result (used only if data != %NULL)
> - * @unit_format:	Unit name format (e.g. "chan\%d")
> - * @unit_id:		Unit id (e.g. 0 for "chan0")
> + * @unit_name:		Unit name
>   * @test_format:	Test name format (e.g. "loopback.\%s.tx.sent")
> - * @test_id:		Test id (e.g. "PHYXS" for "loopback.PHYXS.tx_sent")
>   *
>   * Fill in an individual self-test entry.
>   */
> -static void efx_fill_test(unsigned int test_index, u8 *strings, u64 *data,
> -			  int *test, const char *unit_format, int unit_id,
> -			  const char *test_format, const char *test_id)
> +static void __printf(6, 7) efx_fill_test(unsigned int test_index, u8 *strings,
> +					 u64 *data, int *test,
> +					 const char *unit_name,
> +					 char *test_format, ...)

Should you keep the 'const' in test_format?

