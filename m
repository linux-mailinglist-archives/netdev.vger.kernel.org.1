Return-Path: <netdev+bounces-269840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAXfAO8FvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:31:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4C72D73F0
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71C9A308A899
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809CC372692;
	Fri, 20 Mar 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsjkkGcr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C4318EF6;
	Fri, 20 Mar 2026 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773995320; cv=none; b=F5c4m9GGlR6lGdVs4xgB11fG3sTX2QnIHVpmt00vjpEXzZZ4se9fIGcJWUYOnAZ8NLzgKJglE2WFRgwolfAgVhJdcdTu8dLq3yTiboKaw4LIOJ6vhDqa9bxPM8QyMkXhb2Al9OqjCG779ztq03oyvDw08oSrX5PoZm8c4jS91wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773995320; c=relaxed/simple;
	bh=tlp4xNBxwOC67ibIvTtrwojwpUUGN3GRe2mB0LBz81U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fE43CmghVlr9mphtVITspS9PRmrn/NS1KN0NdyAuDm/P+sEQNmRlsAxziuq0idn9ETJ9t+evUCs0/qanJnE7LrMUDQBnGbLyarJRoXnxOkb6KeJxSVqo5gfNkxE2MsAHGMcMCVwFpPtq2N8Su38W8AZe6aAk7Q6kK6Ta3L3wZ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsjkkGcr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D109C4CEF7;
	Fri, 20 Mar 2026 08:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773995320;
	bh=tlp4xNBxwOC67ibIvTtrwojwpUUGN3GRe2mB0LBz81U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UsjkkGcrXJ9SixrUoJWLGTS8JHaqLi4n9gi6Nr5g2Pv/Sja7XNKiv+boBIIM8GCxE
	 RtLeWp2xOYV+H0vYwVl+z+KvCTjUyadmdqmNx/v9HkUJIaRpjhDk9yG62nVXHNa0Xa
	 MiQTBoKwOpF5Ap5oivthC3meWn8sebQG4AP8vifYvi5lIggJ5EX4DiMFLlfvope7fL
	 f2FnBuz1YurKa6OeONwgr2j9ACzkLYEmXRJ+1L7pOZdpYplPRncm8vScWj1fCTF8ND
	 DYOpgtGi4cbz0qIWYrOsw4PCuRhQwZt+x2tT7RRFGGxnzTj7+IcjXYNKmf5ntDDuak
	 dW1gh68lmWN5A==
Date: Fri, 20 Mar 2026 08:28:35 +0000
From: Simon Horman <horms@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: edumazet@google.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net
Subject: Re: [PATCH net-next v2 1/2] r8152: Add support for 5Gbit Link Speeds
 and EEE
Message-ID: <20260320082835.GA1753385@horms.kernel.org>
References: <20260317-rtl8157_next-v2-1-10ea1fa488d1@birger-koblitz.de>
 <20260319165100.1988286-1-horms@kernel.org>
 <3bdcd08a-8001-4343-b150-693b58ead886@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bdcd08a-8001-4343-b150-693b58ead886@birger-koblitz.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269840-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.968];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4C4C72D73F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 06:29:20AM +0100, Birger Koblitz wrote:
> Hi Simon, thanks a lot for reviewing this patch!

...

> > Is the UPS power management configuration incorrect for 5Gbit link speeds
> > without a case for NWAY_5000M_FULL in r8156_ups_flags()?
> The out-of-tree driver also does not set any flags in USB_UPS_FLAGS in the
> 5000M case. Maybe this is an oversight in that driver, but according to my
> tests, the power management works. In any case, I would not be able to guess
> the correct register value with any confidence for the NWAY_5000M_FULL case:
> the bits are different from the speed bits in PLA_PHYSTATUS. The RTL8157
> also has other differences in USB power management compared to previous
> generations, such as introducing register USB_U2P3_V2_CTRL. So, to the best
> of my knowledge, the proposed patch is correct.

Thanks for the clarification.

Perhaps someone can provide insight here. But in lieu of that
I agree with your approach.

> 
> > 
> > This path is activated by the next commit in the series (58ba3b6c476d
> > 'r8152: Add support for the RTL8157 hardware') which sets
> > support_5000full = 1.
> > 
> > [ ... ]
> 

