Return-Path: <netdev+bounces-285084-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id H1rVG3Tb+2n1FgAAu9opvQ
	(envelope-from <netdev+bounces-285084-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:23:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 012524E1ADC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 02:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B523C3009CDB
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 00:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC9F2F87B;
	Thu,  7 May 2026 00:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0BK1kPi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE36422F01
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778113392; cv=none; b=RHI3KVPv4XAMsOfiLkqJSjGHkdt92jW+cJTfLCekM4AJQMKOScUjEwT6o0W3IbjWSpmBwc87Ie/36idzaUd04b8Yvy2GLwquL4nyA49/Qw15EOD9e5UwK+acxf6552C9IjPehYnUnHEtDLQBHwpO1og2wl8/e01YLUDn9pWVnT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778113392; c=relaxed/simple;
	bh=D6CnPkhKcUvr2Nis2GUZOCpAJdt4Z5NZEplZC44coyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BbqDY+8LDZPH9PgAGrtkjMDT2jDNbzGR46RH5VATqn/gO3PdUuNhNQ1eAbktG9KWTb3LgoE3L61fbUW1U4FqSYBGHKm4OK/wDk9HCvQJ4RSLM3v6srJqYNfRmhfHeYFU/7y5TQLFfgnzLJ/iiQlg41xwMym1M/kTeHqF0nbFqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0BK1kPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54679C2BCB0;
	Thu,  7 May 2026 00:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778113391;
	bh=D6CnPkhKcUvr2Nis2GUZOCpAJdt4Z5NZEplZC44coyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z0BK1kPiTwf01qp9HRBc8JV+AfYlYS62bBvP/EiLZgepxXR80C3AsJX70XBhtACKU
	 fjLL+7OQ32wNOHgDauxzJJDNYBpx79OYC9vrQyDL3MZohJLeVjsVGf2dbnulHX+ZhN
	 jwe2M0rR2+09uVBY6+N0NUVf9mmY/JZJWZP7tgMZhbn+PzO4v6t8x1w380A8E+QKmZ
	 ejYDP4pfJwxEUtH2J+cXPX40sDNhMg9O6VFCLOaE+37M10KF8CezQcIEcsijv/zPCs
	 qW6WEVZcAEt62veS0v3Ir5HrcKBFkj+fflwExtaZ3ndX/ceEpyp2umcPrLQz7DPxki
	 Zx52FcH4xhnJw==
Date: Wed, 6 May 2026 17:23:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Herbert Xu
 <herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
Subject: Re: [PATCH 4/8] tools/selftests: Add a VXLAN+IPsec traffic test
Message-ID: <20260506172310.64188c0e@kernel.org>
In-Reply-To: <20260506170435.34984dfc@kernel.org>
References: <20260505132326.1362733-1-steffen.klassert@secunet.com>
	<20260505132326.1362733-5-steffen.klassert@secunet.com>
	<20260506170435.34984dfc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 012524E1ADC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285084-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed, 6 May 2026 17:04:35 -0700 Jakub Kicinski wrote:
> Oh, sorry, changed my mind we can't pull this:( both the Makefile and
> config break alphabetic sort, our CI will flag every incoming as red 
> if we merge this as is, we need this on top:

Eh, let me just commit this and move on..

