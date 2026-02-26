Return-Path: <netdev+bounces-261518-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HFfCf6QoGllkwQAu9opvQ
	(envelope-from <netdev+bounces-261518-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:29:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DE61ADA2C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 19:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEEE63252408
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 17:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D857A355F53;
	Thu, 26 Feb 2026 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBD4YB1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1C355F4A;
	Thu, 26 Feb 2026 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772127903; cv=none; b=Jxsc7KgAnqPQd8gIoLqyHpk596u9aurS8wLHAjgCI1FGN+ygWFa7QqjaBJKH6B5Oq6O1AbV1aVrHY+X7OFdb5G7Y1IDxhqYYNY6rcyQ9ootvO/2A0HaCCnbR66oIa2CvZSFLFef1Dt0EPJlFsAV012h0QHd6R+hqy2ltHNaWJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772127903; c=relaxed/simple;
	bh=tannt4lY3Kdup8C/GrObIPOQKpUnEUlTbmhrhsrGr4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVgXkLnuMHzBAe0+QBdS9Zfi8KINCInRnJnM7s6GgbAMaZliWoTVzICXKxnyDOqDxhTdtxAhMVpE6oYMDjG1VUl4tzJ+BygudNqJKTAzN8r9DY2y/6pm3B0aFyM6K3pFBLIRpoAT6DfPcTXn2ayXNYnTD3vnh4ZSOIf4dvCDXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBD4YB1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CD2C116C6;
	Thu, 26 Feb 2026 17:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772127903;
	bh=tannt4lY3Kdup8C/GrObIPOQKpUnEUlTbmhrhsrGr4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rBD4YB1zOn/gj2cwT07DcTYwl9OkPdoVm2NQYGLEwr8NRy0G+RUfZ8Puol5d1AB5R
	 lkZoJFXO0lagf0WSm1F4iMO00rsH7QURykb6PTqBcHKZtfvQHpt5VnIFIIH/43MycZ
	 +KF969kf8k3c36QulKKVQSHexmw8AZIg808yWTvrltT1yl9kXpBQjjh8GGtz3ryy/t
	 0iFxpG4yFP+2OO+69akwGiV4pGDCZoyuK/fdN7wcQvy060kzMaIkBUD/7YsapGLOIO
	 6RTDRzPT1RyKe6V+U68wBM/eeZbJBtGzFduKgrW6oIyIt46LShvfyll31TiMCJfCrd
	 OQ788NgIlA9KA==
Date: Thu, 26 Feb 2026 17:44:58 +0000
From: Simon Horman <horms@kernel.org>
To: Leon Kral <leon.j.kral@protonmail.com>
Cc: john.fastabend@gmail.com, kuba@kernel.org, sd@queasysnail.net,
	chuck.lever@oracle.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, skhan@linuxfoundation.org,
	netdev@vger.kernel.org, kernel-tls-handshake@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/networking/tls-handshake.rst: Fix of minor
 grammar mistake
Message-ID: <aaCGmqqMMPey4nbL@horms.kernel.org>
References: <20260226000915.27898-1-leon.j.kral@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226000915.27898-1-leon.j.kral@protonmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261518-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[protonmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,queasysnail.net,oracle.com,davemloft.net,google.com,redhat.com,lwn.net,linuxfoundation.org,vger.kernel.org,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,protonmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72DE61ADA2C
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 12:04:54AM +0000, Leon Kral wrote:
> The word "a" was used instead of "an" which is grammatically incorrect.
> Fix by changing from "a" to "an". This improves readability of the
> documentation.
> 
> Signed-off-by: Leon Kral <leon.j.kral@protonmail.com>

Hi Leon,

Your change looks good to me.

But looking over git history it seems that an appropriate
prefix for the patch would be 'net/handshake:'.

And it would be best to set the target tree explicitly,
in this case net-next seems appropriate. So:

Subject: [PATCH net-next v2] net/handshake: ...

It also might be best to make the subject rest of the subject,
while not making it too long. But I'll leave that up to you.

Please do make sure that 24h elapses since you posted v1 before posting v2.

For more information on the Netdev development process please
see: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

...

-- 
pw-bot: changes-requested

