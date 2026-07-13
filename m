Return-Path: <netdev+bounces-307007-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JbZdLHBcVGpslAMAu9opvQ
	(envelope-from <netdev+bounces-307007-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:33:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4982E746F15
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 05:33:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=c1lOdL9I;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307007-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307007-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A759300F123
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 03:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D909D29D267;
	Mon, 13 Jul 2026 03:31:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2AC1DFDA1;
	Mon, 13 Jul 2026 03:31:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783913487; cv=none; b=ks5LFlCbMBFpCmHy+DJIWIsgJHRpscMA69SE6ZuI7K91rnMYupj1+WqPA4IuhxDFV5aINRlDV4zuRGcAvkcvKe2iMKvnn8+CjeWBzjwN5F2jX9gdHmHmydf47S52Vdl+l1Uj06Q1BVMB2uyck58Q15J4K38lsI/1aGFsvx6lixw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783913487; c=relaxed/simple;
	bh=yn6CSO24b0+nwTv1JL4Wh60XfPU/R6sqVcXQSImzD30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWtSXQ5JsS++qQOLwo3uFPxEyE90CLCwkYrxhaOKV5Bxh1zlfEFrDybZ7AWDlZgHf6aKBYzArwud64QawJSgu0Y3rWsQATmc4+80wWwFJFghyW1RgjxSi+sB085D/MSOgInqvsxqgwb8Ni1/6xLY5Gi4h60+gOsK5ZW+h9AlI9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1lOdL9I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5721F000E9;
	Mon, 13 Jul 2026 03:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783913486;
	bh=EWoh0L1t9pHsEoOde9LON+LMQGauZWMksz8lAEpdX3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c1lOdL9IXZei1QwCMdadD29SCABuIXIxxKc9OliXqMeDMsIbNkhL4c/rCTSdWIKOB
	 l+EIO5JnR8myyg5kLL0EpEZbFcFst5hhM2nZoISNtOfrTBHeD5BXa4LYvrKQsQDaJ4
	 /w1NgwcW8X+3WVy8Qkk/tlXzZMvxl7UiIrTYYs9WC1AJeWqAMS72+jRhcESDCUAzB0
	 AFx6ajYLfLC6U5Hu8dZEAUaRucTZVZlgBvHP/Ynr8FSKl/1SiRjY1ZtBLDTP1syeZR
	 IFBHNR4kzVRQNRhxiFuNRsk7qADssNFd4MD6NWNijLD4d4xedFHJnUMTztBBZQMDXH
	 sOUP22hqumXRg==
Date: Sun, 12 Jul 2026 23:31:24 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] crypto: pcrypt - Remove pcrypt
Message-ID: <20260713033124.GG4362@quark>
References: <20260713032600.44355-1-ebiggers@kernel.org>
 <alRbsLpptbdSsBlf@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alRbsLpptbdSsBlf@gondor.apana.org.au>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:linux-crypto@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:steffen.klassert@secunet.com,m:thuth@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307007-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,quark:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4982E746F15

On Mon, Jul 13, 2026 at 01:29:52PM +1000, Herbert Xu wrote:
> Looks good to me.
> 
> More than half of kernel/padata.c is only used by pcrypt and can
> also be removed if pcrypt is removed.
> 
> Thanks,

Yes, that would be a separate patch.

- Eric

