Return-Path: <netdev+bounces-260395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCUdMmBfnWmxOgQAu9opvQ
	(envelope-from <netdev+bounces-260395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:20:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DEE183892
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54DD2308A152
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381E3366558;
	Tue, 24 Feb 2026 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW/cGA/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1515F366556;
	Tue, 24 Feb 2026 08:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921098; cv=none; b=n9LSAfj2eEsL0dHRYvSpJKbsOuW4aQNYwSTuzfBaCByIILq7DkfbL9P9BL8Rdgam4dpI8Y1VaMponXcaeWREriV2e5GXwrchW1zHc/BeCLsisxgM9YO69Ai/tTrGu4irD5YiKQT7jXrVgl6M73oxki6QmMvaQO6+KbCvTvQVHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921098; c=relaxed/simple;
	bh=hSehRNge/1BxHaGLG3R3Qpdy/EUJPhe/dcHH0SQxtBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFaX/1usRpbjmsBdz9yYtCMXEnjw94qoC6CZn49N25K8B5tXm9u0hdjb5otzoBvxIM8vwd8JkSkekQGQ0OOQDadKq43QaZ6xgY4EOZiEAsP/5RIsWWx3J2mov66IvuDfvftlirGqbBNDc4M8hFAbSOF3vy/8YJbVEnDIA4m0++0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW/cGA/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103A5C116D0;
	Tue, 24 Feb 2026 08:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771921097;
	bh=hSehRNge/1BxHaGLG3R3Qpdy/EUJPhe/dcHH0SQxtBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LW/cGA/SWGT9JSk7kynloUV8dZHjPa1SQdJRNb2PIto6oMNQUn/EESKHJIvvs3vEa
	 UPKYMbh+9u9v1LAkqlRe2sUjvIzmUpa179ESzZNqGDuPMqNIW/F8qPHgLcN4EU1W9y
	 Wu56Aq8wp4QgR/zhHnZDBGFUy2q7M3r15PxPEgrO4RyQC6xzGVB5V3nB1gN6S/WfPk
	 Q2N0aU70Tb8Vu673ApVAhQVLhItr1D14gNvyN/0Zov/mCyndQ4u6bLs65J0dJG2w1Z
	 nJWo8owtkQyOLYCoxnM7NCvOeBZ+EvW/tdrLkrrGuymJ5FryrDydXZ8brtHc5TZsON
	 40OvfraAM5mpw==
Date: Tue, 24 Feb 2026 08:18:13 +0000
From: Simon Horman <horms@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: l2tp_eth: Replace deprecated strcpy with
 strscpy in l2tp_eth_create
Message-ID: <aZ1exV5fL88Kdft2@horms.kernel.org>
References: <20260223074137.321862-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223074137.321862-1-thorsten.blum@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-260395-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 21DEE183892
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 08:41:34AM +0100, Thorsten Blum wrote:
> strcpy() has been deprecated [1] because it performs no bounds checking
> on the destination buffer, which can lead to buffer overflows. Replace
> it with the safer strscpy().  Use the two-argument version of strscpy()
> to copy 'cfg->ifname'.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Reviewed-by: Simon Horman <horms@kernel.org>


