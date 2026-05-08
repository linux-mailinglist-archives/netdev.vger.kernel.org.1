Return-Path: <netdev+bounces-285785-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABqoBoDT/Wl2jgAAu9opvQ
	(envelope-from <netdev+bounces-285785-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:13:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAEE4F62F5
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 352583087288
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CC93DBD4F;
	Fri,  8 May 2026 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iyPcTCBv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CBA3A1A54
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242049; cv=none; b=QZR2Xug27xdtMxiF+dQyqJ32U3azMJbOqW+QNBBbdmjzb3mDlTQsFPQvebtJ6T15Ft/Oppo22Rtccimrtd6cP4WNh9eRSPw5tkoPsdXH1iHGF3lzn524ADWLQhZ/8DRLa4XJCaywCQJ616LQoUU22fg4z0u72hZ91GKp2wf2zeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242049; c=relaxed/simple;
	bh=QbDTVF2ImXMDl2jgCVZV89KZ7SBcRmn9NE8pN7GIF7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gi2bg7+e7J7Bltw63QD2huUcmsFBind3OkQ/y5eVstMk+dKUZHkFFHTs5teM1/YoNFlefvxsL3qw8HjsU2n/LqgJ39eRW2V7Jz6MpasD6SBZFaiF6pCEmcy85AAoNaaxUD7apyD/CTbpfmCfn14+zemCwRvN224etRFa9KOnAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iyPcTCBv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8zKC6bgCNQ22N5CFjyOJGIo+pSm6Ry0GOh6h1WUxHF4=; b=iyPcTCBvpkw+uSGyG3dNh174BJ
	pocFtQ3A/q4eOQSeqRmqCxg78qnY3uh55h70tU9Cy4MrIlS/x9FiI1EHVFj77Qm0fG5PjSqcrB3iJ
	gOez8KbmRnpskikzAHEECCi7hDVDZ6cFCJGfWMTS42Qr1kQ9klspJKjiQjnE0kqztq+I=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wLJyy-001xgE-6u; Fri, 08 May 2026 14:07:04 +0200
Date: Fri, 8 May 2026 14:07:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Tao Cui <cuitao@kylinos.cn>
Cc: leitao@debian.org, vadim.fedorenko@linux.dev, davem@davemloft.net,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net v2] net: ethtool: fix missing closing paren in
 rings_reply_size()
Message-ID: <1c5f2275-17f0-4a80-97db-61af3129e6b4@lunn.ch>
References: <af2tj9AkacSUfsp9@gmail.com>
 <20260508100435.186819-1-cuitao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508100435.186819-1-cuitao@kylinos.cn>
X-Rspamd-Queue-Id: 4CAEE4F62F5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285785-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,kylinos.cn:email]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 06:04:35PM +0800, Tao Cui wrote:
> sizeof(u32) on the _RINGS_CQE_SIZE line is missing its closing
> parenthesis, causing nla_total_size() to absorb the subsequent
> _TX_PUSH and _RX_PUSH entries. The resulting size estimate
> happens to be numerically identical due to NLA alignment, but
> the nesting is wrong and misleading.
> 
> Fixes: 4dc84c06a343 ("net: ethtool: extend ringparam set/get APIs for tx_push")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Reviewed-by: Breno Leitao <leitao@debian.org>
> ---
> v2:
> - Added Fixes: tag as suggested by Breno Leitao.
> - Added Reviewed-by tags from Vadim Fedorenko and Breno Leitao.

Please always start a new thread for a new version of a
patch. Otherwise the CI/CD system just thinks it is a comment to an
existing patch.

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

	Andrew

