Return-Path: <netdev+bounces-253486-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNSCKXlxd2m8gAEAu9opvQ
	(envelope-from <netdev+bounces-253486-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:51:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E11891AB
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 14:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62D94300A257
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B35632825B;
	Mon, 26 Jan 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVY7QuR9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF933A9D6;
	Mon, 26 Jan 2026 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769434954; cv=none; b=Yl9K5HwXZIeLFCFotzNuJCswX16o4UpOpr9up+Pjx9iQ9MK3RX9ejn4Az4CZ+IYO6TbujWjcmA47bMQrncPCr7l7m15qdh+knPRJalPUpE98qrqtKepBVG+3G11Ca7d477DZikCZir2dWfI/B+8DL1dQEEEg0oXQY1jyvppQmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769434954; c=relaxed/simple;
	bh=jYwExo7rfIbCoeFjaHZI7UEh+OE6XcOeAoCk3DyxBUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+CYImKs09TV0pPdbrgeaZV7zyzmy45gkMg3la4jKnHmKWlKLcP6XaLo4ATNkY4OJqQJVg2xEr8/lOHWB1KNGC66EyOfk7nVBgi7YhFFOMe9Tbuig4PWBAor/mj0pzKwezAy/2EoDFU5SgFmEOZp/VVkrxr9Z5tO4ql+0DMRego=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVY7QuR9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9104AC116C6;
	Mon, 26 Jan 2026 13:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769434954;
	bh=jYwExo7rfIbCoeFjaHZI7UEh+OE6XcOeAoCk3DyxBUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MVY7QuR9EDtIUAYBGw60Z6l+yRWSFK3bjwwtXX9NqsrKPjgGRZwqHuCnOIXWfmgA7
	 WPNJ6drel+xni2qyhRRrMisWnNc2TUQiYP36aPugZow4gCzfee+DOEf52rGH/V55N6
	 Ay9dvBJtweYlTwISHmZa6R11SdLyQWtOnBbPh8+1aTiOBYzhZhtSdT9SMzqV3jOGLG
	 5ZrB3HMnVkh4A2Jos2JvrmPh4QWomHxg28bH7m0FSop9sv5d7hrBYxY7iqwimmMfkS
	 YgihTsL0iCvppFBmjvr6igWcogOUgzG8ZaMMbJd7KteaZmIS5AoV1EjteGNlM5ALwk
	 RhMpXmXXUsVHg==
Date: Mon, 26 Jan 2026 13:42:30 +0000
From: Simon Horman <horms@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH net-next] net: usb: sr9700: remove code to drive
 nonexistent multicast filter
Message-ID: <aXdvRs1hAC5E4Dex@horms.kernel.org>
References: <20260123065842.53669-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123065842.53669-1-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253486-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1E11891AB
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 10:58:32PM -0800, Ethan Nelson-Moore wrote:
> Several registers referenced in this driver's source code do not
> actually exist (they are not writable and read as zero in my testing).
> They exist in this driver because it originated as a copy of the dm9601
> driver. Notably, these include the multicast filter registers - this
> causes the driver to not support multicast packets correctly. Remove
> the multicast filter code and instead set the chip to receive all
> multicast filter packets when any multicast addresses are in the list.
> Also take the opportunity to remove definitions for a few other
> nonexistent registers, and a couple pointless comments.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

I would slightly lean towards splitting this patch up,
say one for the multicast changes and removal of related #defines,
and another for the remainder of the #define clean-up.

But that notwithstanding this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

