Return-Path: <netdev+bounces-261349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF5LGphMoGnvhwQAu9opvQ
	(envelope-from <netdev+bounces-261349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:37:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D399D1A6B21
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 14:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0034630C367A
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 13:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4031E361677;
	Thu, 26 Feb 2026 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KsTS9u2U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C236213E;
	Thu, 26 Feb 2026 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772112797; cv=none; b=hn58zQg6v7NCUtCr4bkNPwJ0wI89df9m7a63zFh7EEkfQExHbUCtVdb6fYdaoQe3+29eoUk+bnaWt+/MUALDfjoNY31Ngs/+EkHH17h9+CFAN3zxN+RnFLK/aFn/xhgSWUr8MWwBgfcdcTNWCCw27iYruDe/TMofWTQ6liYTM9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772112797; c=relaxed/simple;
	bh=SXJFppxWUm/YXXdkvyUruOdJHlBV/gZGSuq7rtyW5MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7lANMJBRrwucxmyaCkBpv4zLV+hWcjJKM+JfuTfYUDwNVcqJC8yVV/VZVRygS4jZQSnCoW99cEKhsY7dRjlUYWY/BwloBeCE5NWCHQaPLFuLb8BpKJkwS8ue3x2cAIwAS1JPCBl+SnAQ6mLjj03IfgzmffWmFk4DWm5kGJ6x5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KsTS9u2U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E61C116C6;
	Thu, 26 Feb 2026 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772112797;
	bh=SXJFppxWUm/YXXdkvyUruOdJHlBV/gZGSuq7rtyW5MI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KsTS9u2UyLqPp0D8teli+dTbuMSj2ZZGaojDMInwxrJT47HEJDBKXPsHdYTT3zo1f
	 khGl0SLSwzKWoVI4EsiYfacNFUgrC81WiJ9BliGNvY4rNd6can1JoW9oNqcEbQvbk9
	 qQ1pZwz7v2opW0GtEQdKma6+DXwjirAIF0eui31/GnJGmqh5jd/aW75kRjPYjkDQTS
	 TOOi6fdOjIPjOq0f91I6QyBLAYKGXN1BPAl6j1bzz67Mnw1QC4q6iAzjtWYAMCefGf
	 XehfVug8DfwfKJqFn46h9rIGIBWwV0plCSDyVbJ2SPpERPTbdYw5BkpCc5NRrPS+dQ
	 Ux0hjYlOBJ9TA==
Date: Thu, 26 Feb 2026 13:33:12 +0000
From: Simon Horman <horms@kernel.org>
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
	xutong.ma@inria.fr, yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: Re: [PATCH net-next v2] net/hsr: update outdated comments
Message-ID: <aaBLmF9w7jf8pqTT@horms.kernel.org>
References: <20260225145159.2953-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225145159.2953-1-kexinsun@smail.nju.edu.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-261349-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D399D1A6B21
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:51:59PM +0800, Kexin Sun wrote:
> The function hsr_rcv() was renamed hsr_handle_frame() and moved to
> net/hsr/hsr_slave.c by commit 81ba6afd6e64 ("net/hsr: Switch from
> dev_add_pack() to netdev_rx_handler_register()").
> 
> Update all remaining references in the comments accordingly.
> 
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
> Hi Simon,
> 
> Regarding your question about how these were found: we are building a 
> research prototype for identifying and fixing dangling method references 
> in comments. Generally, we use Coccinelle to check for dangling references 
> and DeepSeek-V3.2 to generate the fixes. 
> 
> Since it is still a work-in-progress, we haven't settled on a proper tool 
> name yet. Therefore, I chose to omit the `Assisted-by:` tag in this v2 
> patch for now. Do you have any suggestions on what would be appropriate 
> to use in this situation?

Hi Kexin,

I think many people are experimenting.
And likewise, the use of Assisted-by is evolving.

My reading of [1] is that an Assisted-by tag is appropriate here.
I would suggest:

Assisted-by: deepseek-v3.2 coccinelle

or

Assisted-by: unnamed:deepseek-v3.2 coccinelle

[1] https://docs.kernel.org/process/coding-assistants.html


Overall, this now looks good to me.
Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>

