Return-Path: <netdev+bounces-280819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEDyFrhX6mkhxgIAu9opvQ
	(envelope-from <netdev+bounces-280819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:32:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0FC455879
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95E733001A46
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 17:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B312DFA25;
	Thu, 23 Apr 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvHl1IXn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E083770B;
	Thu, 23 Apr 2026 17:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965185; cv=none; b=Ye4dIr8jmwfTsFg+LS1a4I/5MnYITktYUdxSu8lCiDArYEiaAv0dWSJoSbsH/gTMr/Ik9kLue+RD2ZaHbz8xjNSU0fDxBT06HRNhbqQ0ApDYK9xfjoDul271258FmxuZFREOoqJ+FNQFhrsy0/LLI+O0zVXpCp7dROFg45KZ2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965185; c=relaxed/simple;
	bh=CiUhr3+0FahWgH56+muDl88e4mdB/EH/RfWfs7RNfNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G4fzuXTllmRydnim8CuPN4dqugeGn6+zcQS5AvSlDi7UyCxJaLW6iSg0cOcHBRDiIDBrhNAtRa8Pf40pmfK0hpm4xYYZX3FRxKQQ9vyPAHvPqAHFKLsdpjer61ux342JDCx1+vtS8BjJp9YS4H6PtYBfUUOOfvit9Ux7AAf9thA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvHl1IXn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD0EC2BCAF;
	Thu, 23 Apr 2026 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965185;
	bh=CiUhr3+0FahWgH56+muDl88e4mdB/EH/RfWfs7RNfNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tvHl1IXnWxfLgxhHWQRwVcIJ2M5m3ZcPETKdJ3KCJ3nD7Oc6Af+kVBV46E8mFfiBI
	 F6yCha9/rzkVB127KiS1JkpRsUH3NNmTIQnSzop6+5PuuI1VaBBQ8/ENU4RrbaSHkN
	 bw1EyDoF+5pP7BnOy8+ZukUIN5YF0bwJBUeJxBxqo8KqHgbBJEgmXxSqoqeghRkY+X
	 vqJR9lJJeUl6ZpHGFtU2qI+pHEatdk8+GYupK7setqfiCf+rGN8XtH1r1ZjuEqNwHs
	 dDOZ8KSHoNtfwYO6lqSttaz5N1f9ebCPBo63oNasY4iSM6ka5omznq2uAU2x6gIgx7
	 8m/X6QcIWDOWA==
Date: Thu, 23 Apr 2026 18:26:21 +0100
From: Simon Horman <horms@kernel.org>
To: Ernestas Kulik <ernestas.k@iconn-networks.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] llc: Return -EINPROGRESS from llc_ui_connect()
Message-ID: <20260423172621.GH900403@horms.kernel.org>
References: <20260415063457.1008868-1-ernestas.k@iconn-networks.com>
 <20260421060304.285419-1-ernestas.k@iconn-networks.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421060304.285419-1-ernestas.k@iconn-networks.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280819-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iconn-networks.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 1B0FC455879
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 09:02:26AM +0300, Ernestas Kulik wrote:
> Given a zero sk_sndtimeo, llc_ui_connect() skips waiting for state
> change and returns 0, confusing userspace applications that will assume
> the socket is connected, making e.g. getpeername() calls error out.
> 
> More specifically, the issue was discovered in libcoap, where
> newly-added AF_LLC socket support was behaving differently from AF_INET
> connections due to EINPROGRESS handling being skipped.
> 
> Set rc to -EINPROGRESS if connect() would not block, akin to AF_INET
> sockets.
> 
> Signed-off-by: Ernestas Kulik <ernestas.k@iconn-networks.com>
> ---
> v2:
> - Add note about discovering the issue
> - Make rc assignment conditional
> v3:
> - Fix commit message after v2 changes

Reviewed-by: Simon Horman <horms@kernel.org>


