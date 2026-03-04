Return-Path: <netdev+bounces-263560-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFPhHDqbp2ksigAAu9opvQ
	(envelope-from <netdev+bounces-263560-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:38:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 851F61F9EC2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 03:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 316533021C3B
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 02:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF12F547F;
	Wed,  4 Mar 2026 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D77iwDtm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE192D248D
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 02:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772591925; cv=none; b=Vs+rlA92yjYML5Oc5UufsYuknnnADEpaSEut2lUiHnzK/NJkLLkvma4F6AAmm11vpZ7lXVR8iLUux92x6o1OQ/+YqXsaVEY2VbL5aAPrXeyhSk0m44UBTOCmzB3IxHpGuqDBfbeR6P3HspEqScJ6jBSwwMQ3HorflnlmgcqiaLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772591925; c=relaxed/simple;
	bh=Sr0j9IgcWtQ1wT13ly7SqxReMpYnIbndM57oeBFW1MI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7UM9Ezqx73snDDFH1YeaY4i2a2oabddf97C0xyyPhOrvyF4UDLr9UNjCaYHyYt52EK9BHyfxmrZB8D/N6Ea/XPKXBO1RFTm4qfptFTNO8GD+O8d4Rka1Ff8PVpOxkLWlZfWIWAt9/sPatPOtUu6uDgHShoHUdUega24Rf67VDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D77iwDtm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5176DC19422;
	Wed,  4 Mar 2026 02:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772591924;
	bh=Sr0j9IgcWtQ1wT13ly7SqxReMpYnIbndM57oeBFW1MI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D77iwDtml/kjRK6YxVqFRt2be6EWwksSdtcZDm/lzVAur0Afow1ZDu74qKbUrQULh
	 X63k9sctR4HibavXp9b9oswZC+Vs1yRNTMQp9apBADmK1PFAqBJovAQ/3F2QJ+9J9j
	 3aMZMkCfaqaaVDuujyUYNKHH3JdlsrJlgoeek9icgnRF69ueOzovmJsUNclD85sNLb
	 bgqmaFZv9CLIij33uiUcG5LxZisXJdtS1SCwrO/K+hKd2DUjagXMyg2XErNQl9uCam
	 qEmS0xkaFS7HedDzFjRd+9HLIO2rY3BYW7ghIB019CdWoC5Mc6xzvXvl467Ad2OP5H
	 FR2GP734uSdQg==
Date: Tue, 3 Mar 2026 18:38:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, tgraf@infradead.org, horms@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
 davem@davemloft.net
Subject: Re: [PATCH net v3] ipv4: bump rt_genid when a relevant devconf
 value changes through netlink
Message-ID: <20260303183843.5b29d5b0@kernel.org>
In-Reply-To: <20260302130858.5197-1-fmancera@suse.de>
References: <20260302130858.5197-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 851F61F9EC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-263560-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon,  2 Mar 2026 14:08:57 +0100 Fernando Fernandez Mancera wrote:
> +			switch (nla_type(a)) {
> +			case IPV4_DEVCONF_FORWARDING:
> +				if (nla_get_u32(a))
> +					netif_disable_lro(dev);

why not dev_disable_lro()??

> +				fallthrough;
> +			case IPV4_DEVCONF_NOXFRM:
> +			case IPV4_DEVCONF_NOPOLICY:
> +			case IPV4_DEVCONF_PROMOTE_SECONDARIES:
> +			case IPV4_DEVCONF_ROUTE_LOCALNET:
> +			case IPV4_DEVCONF_DROP_UNICAST_IN_L2_MULTICAST:
> +				flush_cache = true;
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +		if (flush_cache)
> +			rt_cache_flush(net);
>  	}

Looking closer at this I'm struggling to connect this to
devinet_conf_proc(). The attrs you're snooping here are completely different!?
Logic for when rt_cache_flush() happens is different.

inet_netconf_notify_devconf() is missing even after the patch.
-- 
pw-bot: cr

