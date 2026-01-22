Return-Path: <netdev+bounces-252425-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kB8DOc5KcmnpfAAAu9opvQ
	(envelope-from <netdev+bounces-252425-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:05:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F6A697DE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 17:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 459EB3001AC6
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 16:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723A54968FC;
	Thu, 22 Jan 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEoUtXJy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158A7145355;
	Thu, 22 Jan 2026 16:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097931; cv=none; b=fKA7OUkSRY1gFOVqU0qEy6hCP5vLedGLNm8m/NzJ+JCIc7nP6H6I8pQksLUFIibmRpcTv++ur8KXVxzVJHmcHHPXJ5AsLNnoGwuRrPOlpla2B+tlsXwJZRT5x/6SvEBvOqQHOcY9rfeFjvaObH/RVbgoQUEW/Y9P3j9yHecbhMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097931; c=relaxed/simple;
	bh=jTSfHd23Mmfb0kTv5tEAIVkwXaNkstr+cwjFAKhd/Fk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jslg/Cgma4BkN57QqRhcc3ciuejLSLHp97/LcyW8UxBdsHkp2QhTf5XiPKKMk/M2Gs3E3wnEDWXOtvBmWNyrObJj1kkcjMwBvqde2Au21ZbCTBARUj/nXBtASZDTG1st7v0rCF5C22d1UEQ7Fy7KwaLSlRNAWmd39LAqEks7Ls0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEoUtXJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFE7C19422;
	Thu, 22 Jan 2026 16:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769097927;
	bh=jTSfHd23Mmfb0kTv5tEAIVkwXaNkstr+cwjFAKhd/Fk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kEoUtXJyFuoClXVSzXxVTxCHpsNEn6uWNrrHqiMwfkNyrm5Gw/NwVUyf8tkOcVaIm
	 rH6FLuYx6xZAZtsAy7Cr9+JC2v3SK97XaXeRjpMpIjYGhasfARR0zWv2kcvqSxJpOm
	 fNNsxGn3p2tCOBVaHHkVO88w4PAcEM+iClRcNn4K5zW1S8Zr460ILQHc6OJuRiEci8
	 2JTp0y6/hr1v1BY4vw9713H5+Y68PEdicLtpF7ZAr3Hlgu+RmhTWdhk+bBw9KtuKEd
	 0RY4tToSq1uCcRdwArSq5a5Thk9xdku5MIRYTyd7hO1lB2MyuAnKcz/BiGX2+WD5Y7
	 y8yH4Xi2xgiAA==
Date: Thu, 22 Jan 2026 08:05:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Wolfram Sang
 <wsa+renesas@sang-engineering.com>, Jeremy Kerr <jk@codeconstruct.com.au>,
 Matt Johnston <matt@codeconstruct.com.au>, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mctp i2c: Enable SMBus ARP discovery
Message-ID: <20260122080526.4fe83a3a@kernel.org>
In-Reply-To: <d681a9d5-ff37-45a0-8398-3e770052177e@redhat.com>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
	<20260121092328.2308705-4-heikki.krogerus@linux.intel.com>
	<d681a9d5-ff37-45a0-8398-3e770052177e@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252425-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dmtf.org:url,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59F6A697DE
X-Rspamd-Action: no action

On Thu, 22 Jan 2026 15:36:05 +0100 Paolo Abeni wrote:
> On 1/21/26 10:23 AM, Heikki Krogerus wrote:
> > Since the SMBus Address Resolution Protocol (ARP) is now
> > supported with all I2C host adapters, every ARP-capable MCTP
> > device will get automatically enumerated. Those devices just
> > need to be bind to this driver.
> > 
> > The SMBus ARP-capable MCTP devices are identified by
> > checking the interface (MCTP SMBus/I2C Transport Binding
> > Specification section 6.5). The interface must match the ASF
> > protocol, so all devices that use the ASF protocol as their
> > interface will be probed by this driver.
> > 
> > Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP0237_1.2.0.pdf
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>  
> 
> This patch depends on 1/4 but it looks like it could be a follow-up to
> the main series. If so, I think it would be better to re-submit it after
> the relevant code landed in net-next to avoid cross sub-tree problems.
> 
> Otherwise I think it should go via I2C tree - and we will solve
> conflicts as needed later on.

+1 I don't wanna speak for Jeremy and Matt but with their Ack, and
assuming there's no dependency in net-next I think i2c tree may
be the easiest path? There isn't much code in the series under
drivers/net.

