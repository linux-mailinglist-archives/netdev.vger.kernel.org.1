Return-Path: <netdev+bounces-260609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GxWHP7hnWnpSQQAu9opvQ
	(envelope-from <netdev+bounces-260609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:38:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64318A9E6
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A67A30160F4
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF683A9D97;
	Tue, 24 Feb 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHCKBZvj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8893E555;
	Tue, 24 Feb 2026 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954612; cv=none; b=o6FOha5nvzNlTTQamkkhRC8jUAvQ5HIukOFsI+6Ch2PWT6UseseJKfkqwgjHSiqoXpDxkrC/+EiEzln5b1bXV60vW3sSdB5+qDK+mYp9woi7QmFt/PMxdvO0DWddNjph7WpbC3GvmvZKyGNHXvy88P4c5G7qX+JD4TLcWDMjAl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954612; c=relaxed/simple;
	bh=D2ttvjm0kDTDRJSJsU4I6IT2so61IzcGQYqgQil448U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NljVWlxHvKs/OUui5bg7+pfN1iODJU3VUl4D47/2KOOZf2O8CHFuPMN/z29q3Ny49yPqINQyWSxPzaWZbdV8KHnrjdm0vYZkXxDxQajcT81seYN3kHdxbg7hjQCaGrj1yPqANEnq2lRcCht6EOWRe0Hx8FQBDKr0CV9b6rC5MNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHCKBZvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27490C116D0;
	Tue, 24 Feb 2026 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771954612;
	bh=D2ttvjm0kDTDRJSJsU4I6IT2so61IzcGQYqgQil448U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cHCKBZvjHpSEtIHnJF1gPsw4Z4CBV1bEIGIZBUKzwOfuMRK1v04Eajx2tTQcNIJJS
	 aVD6FcNF60XKXaN60frgafhQlVg7qx8GJmxe3h4aNsclNH/zNGeue9ElGyyjW3IS4S
	 1cZo67R+5fHxkvKMx7MKCgn+PXJPl2K/4C5QInGP0Inpq7TRON2zh+N01ejvBGoSfQ
	 xEouHhsJtgWtFJxJXuUp9gzQ+CRMbpHBiLy/Q1sO6d2//tiE2HlSpQs32FmbBBzURi
	 b1s4f6svMojDR3luceLEu+WaNDyYjXrogCx0U3CmXOQG53aKQcYH3x7WpXgXPuzGWP
	 Klcuw7gM4ZPLA==
Date: Tue, 24 Feb 2026 17:36:48 +0000
From: Simon Horman <horms@kernel.org>
To: kexinsun <kexinsun@smail.nju.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
	xutong.ma@inria.fr, yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: Re: [PATCH] net/hsr: update outdated comment
Message-ID: <aZ3hsP_GoUN8Yn-7@horms.kernel.org>
References: <20260224021205.1285-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224021205.1285-1-kexinsun@smail.nju.edu.cn>
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
	TAGGED_FROM(0.00)[bounces-260609-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nju.edu.cn:email]
X-Rspamd-Queue-Id: CC64318A9E6
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 10:12:05AM +0800, kexinsun wrote:
> The function hsr_rcv() was renamed hsr_handle_frame() and moved to
> net/hsr/hsr_slave.c by commit 81ba6afd6e64 ("net/hsr: Switch from
> dev_add_pack() to netdev_rx_handler_register()"). Update the comment
> accordingly.
> 
> Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>

I notice that you have sent a number of similar fixes recently.
I am curious to know how you found these problems.

If you are using a tool, please consider using the Assisted-by tag:
https://docs.kernel.org/process/coding-assistants.html

Also, both git grep and our AI generated code review
tell me that this is not the only instance of hsr_rcv lingering
in comments in this driver. Please update all of them.

-- 
pw-bot: changes-requested

