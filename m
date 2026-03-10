Return-Path: <netdev+bounces-266274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CJUDj5asGmMiQIAu9opvQ
	(envelope-from <netdev+bounces-266274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:51:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9E3255EC2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 18:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63A34300E5B1
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D2A3CCA13;
	Tue, 10 Mar 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAZXCOiL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD12C3C344C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165114; cv=none; b=FIMRhTJzsA9RFk/2u+D7XGuKKbTiRSNVYY3hycGLGHVsbCS8SemotgISOoPS/MkcXXnWfw9PUvxKCu3n7FN0viAO6tzN9qI9h7XG3z7bUQTB7Qzb/CrbPsh69K8Jnt6jjCd+awJA4cK4zfyECa5UTAzjTPTEwFBWUTsUFlAVsE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165114; c=relaxed/simple;
	bh=TSnXaaPqruXs3gdxV+Buu8nwmDzSwImeABfSOuWuGv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwKqV1KC/KfwsC5rHb45eM9rEg42J65Kl7l+a/f8oNHVjOLbFKvLfIud5gtvOcVARS6uECxt5Zw731K6uKxctqFN05t1AHt7DoOsOSamq75ztUvsMZSSBqwzG2vIlj423INKLI+NIk33KJbXlHjYhaeSL6/Fg8ZEy78iemGxF38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAZXCOiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4A0C19423;
	Tue, 10 Mar 2026 17:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773165114;
	bh=TSnXaaPqruXs3gdxV+Buu8nwmDzSwImeABfSOuWuGv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TAZXCOiL/xL4Sih7BB2s5ifjEcM5ZQ4GsEZyHUh25UGKNh0rZl54QgmkiI8K7UjxQ
	 Fn9beUR7PZAgdDnbREr3By/WMb2HRh7P32Edhl4Y/fWC8okChGNRKF8PyJXAUftEx0
	 6HL/CnsvmSW9h9BsmERMEcI/SWNIwPUgZaKMcHXgAquoqG20RewLwC1jcUP56lSG2s
	 pF39y0d8Y+ye8/7BZWc3OHbXGxWfwg8bolKnGtHSrmLXYWO3XRa+jbuOrmc+bZZFU/
	 6jRWB4Qjj0uoC7YDgh0gsrrnvEEoJ93/PMyenMe/RjiBDWxKpFwQa7bCKmhjLLYZjT
	 IgMm4/96kyPdQ==
Date: Tue, 10 Mar 2026 17:51:50 +0000
From: Simon Horman <horms@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH ipsec-next 00/10] xfrm: fix most sparse warnings
Message-ID: <20260310175150.GO461701@kernel.org>
References: <cover.1773051558.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1773051558.git.sd@queasysnail.net>
X-Rspamd-Queue-Id: CF9E3255EC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266274-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:32:33AM +0100, Sabrina Dubroca wrote:
> This series fixes most of the sparse warnings currently reported about
> RCU pointers for files under net/xfrm. There's no actual bug in the
> current code, we only need to use the correct helpers in each context.

Thanks Sabrina,

I'm really pleased to see this addressed.

Reviewed-by: Simon Horman <horms@kernel.org>

...

