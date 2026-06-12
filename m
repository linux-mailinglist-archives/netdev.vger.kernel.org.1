Return-Path: <netdev+bounces-298780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7gmfFpRaLGo9PwQAu9opvQ
	(envelope-from <netdev+bounces-298780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:14:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA4567BF1E
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 21:14:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R2tXRCwp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298780-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298780-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 32E77301A98A
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 19:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC1C3A782B;
	Fri, 12 Jun 2026 19:14:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB433F59E;
	Fri, 12 Jun 2026 19:14:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781291663; cv=none; b=YbTxo31eG7POzGvBMM6bpDfBDmkD2q6u7O8n3yzKnCAUjr2tZB2YSgDAPw2lW5bawaj/hVem7e9NTuHarDmtGgpkoo1xtI9twGdh8iNLaFLWWGMkXsTLxeFw+Ff4Gk4yAaRSc//+iCpCQiUhFdUxfhl2iPK7ZEk0W+fZH0YoKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781291663; c=relaxed/simple;
	bh=Q4o0m8OVNFcAeLms4xGclIrogEu9atsH8BNOvFrWyjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uASB58SD230EGq+jPCqgHmAkiNwpuRjWcdKexj9k7n5f7WDZ8gI0vgQU57pZqbb3VX7ds1VSmdPXdpRFc7ua78Zsyhc3emhBo5cxfMPQUdOjrv1YN1vgySH8vTf4qPDM3vMkVgfdDNLk1AuSP1oGTRi7OfpcGHSqdOu9uDKvENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2tXRCwp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14721F000E9;
	Fri, 12 Jun 2026 19:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781291662;
	bh=kYcDT2xHG5nDU8J2gErMvIxigr1UGMadwCYEhogICLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R2tXRCwpziJu3wsmgdJGwIEZZ96NJekBTrzFkNuXOUS+EQ0MHF6nmWHBI16VJVqJE
	 LqsZFXfA6FfKjQ5QnXAvqAASUoj1w1stgKmRSJYs60Tkja7EvT74CKpaHPpK1/bYYN
	 9iDOcCpV+Xg7J3W/0sfb7oh6SAl5VHMarpdjiJPO+zjw6RwwcARVL1b4SKLMn67qr/
	 WsBAuNUdKwcvvJDX0lQFXixtoGvN03Jy2A0pv3MT3Rw5LOWQjWm4RjhSs21pg1lya5
	 e/PuShKnzBbF1i8h3DQJHqIK00flFztAfGgMZ0RdXBLhT1TFZRb7/1mlrabqEAgyxg
	 TiueNRLYabV+g==
Date: Fri, 12 Jun 2026 20:14:17 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	k.domagalski@samsung.com, k.tegowski@samsung.com
Subject: Re: [PATCH net 0/2] net/stmmac: Fixes for maximum TX/RX queues to
 use by driver
Message-ID: <20260612191417.GM671640@horms.kernel.org>
References: <CGME20260611113403eucas1p1f4b61896c875f1f6833d6ca136472af8@eucas1p1.samsung.com>
 <20260611113358.3379518-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611113358.3379518-1-j.raczynski@samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-298780-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:k.domagalski@samsung.com,m:k.tegowski@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,lists.infradead.org,samsung.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,horms.kernel.org:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEA4567BF1E

On Thu, Jun 11, 2026 at 01:33:56PM +0200, Jakub Raczynski wrote:
> When contributing other changes preparing functions for new XGMAC hardware
> https://lore.kernel.org/netdev/20260601162537.553512-1-j.raczynski@samsung.com/
> there have been reports by Sashiko AI review about pre-existing issues
> in the code. These problems are non-insignificant and are 'net' material fixes,
> rather than net-next features.
> One issue in this patchset was reported by Sashiko AI, while other
> technically part of new patchset, but is reasonable related fix.
> All of issues are wrong DTS configuration, but kernel needs to handle it.
> 
> Jakub Raczynski (2):
>   net/stmmac: Apply TBS config only to used queues
>   net/stmmac: Apply MTL_MAX queue limit if config missing

For the series;

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, there is AI-generated review of this patch-set available on sashiko.dev
However I believe that feedback can be viewed in the context of possible
follow-up and should not impede the progress of this patchset.

