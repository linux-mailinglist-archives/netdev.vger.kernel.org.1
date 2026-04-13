Return-Path: <netdev+bounces-278206-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELzvFmBl3WnmdQkAu9opvQ
	(envelope-from <netdev+bounces-278206-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:51:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D293F3A1C
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 904543037E53
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 21:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B04352C54;
	Mon, 13 Apr 2026 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUHIbIS3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0C934404A;
	Mon, 13 Apr 2026 21:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776117043; cv=none; b=ncXaP/OpXkg8EasG1uj/nPl2fbFW1gq3+507Xy2GzsIwAqwbRsnCC4Ph8Ys3ZeUchretjaOh7xyRiiOcxT0hfVnlIfE9qWZfqXUOJor25KZTTdeH5PLGdvrIqNZWVB3uptJZ4hQ7svrkYzbzZKii1qtE4uYbFdNmZkDstvcmM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776117043; c=relaxed/simple;
	bh=NV9UHlwhuReuD8gNnxIaHmrJEY9DrCjcPy8Iyk8djOs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ge7FfPrw9WMqWgASFKlKGhHiNjw1+GLZtcSKWJvf0oPUda+Vmq8/CMCE1l6CnBNTEsp1Vh4C7jWtJbUOBu/febKuPovZCnBIjCB4c3ROhNfYQvPa4yPnJPIz+dJ33TNdqTums2YXDIIurroW4edzZ7wtHD32G+MNy0LVo9fZm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUHIbIS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73A5C2BCB3;
	Mon, 13 Apr 2026 21:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776117042;
	bh=NV9UHlwhuReuD8gNnxIaHmrJEY9DrCjcPy8Iyk8djOs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uUHIbIS3h7/vYfZLRGdNt0RtiBNQ4C/XAw1QzVFRi4ed2YE6fyQ4YWg7WJL+GK5E3
	 iN0L72Fktpssk1ajUD+yJ2aUyCqSr1tj2JHlu86W+Dmbv1jZ372U9bpX1gOugqSAOm
	 zvP92tfBpTYmkNe8Zeix7xHsxM64jxAKsfTfn9vSFqgCDNbZ63jSSnuu2tdAXQJfn5
	 Uup1+ZYs/vkLVdHmiK8wekXEc0QTgxbu5WqamVCbAN8TLAm+wVv2WrJWmOSP7g9Htn
	 gpjDlYct3lkh4sLkqy9i+mgjbHd7rjKmTrRorKJlcylVmzfmyNQfuY8ftXYdxqE9PJ
	 7gHx0h0YV0SoA==
Date: Mon, 13 Apr 2026 14:50:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, ast@fiberby.net, chuck.lever@oracle.com,
 davem@davemloft.net, donald.hunter@gmail.com, edumazet@google.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, matttbe@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next] net: shaper: Reject zero weight in shaper
 config
Message-ID: <20260413145039.43f7b162@kernel.org>
In-Reply-To: <20260410225123.2341672-1-mohsin.bashr@gmail.com>
References: <20260410225123.2341672-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,fiberby.net,oracle.com,davemloft.net,gmail.com,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-278206-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D5D293F3A1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 15:51:23 -0700 Mohsin Bashir wrote:
> A zero weight is meaningless for DWRR scheduling and can cause
> starvation of the affected node. Add a min-value constraint to
> the weight attribute in the net_shaper netlink spec so that zero
> is rejected at the netlink policy level.
> 
> Found while prototyping a new driver, existing drivers are not
> affected.

AI review points out that if the netlink attr is not present core will
leave the DWRR weight as 0 in the struct. I guess we need to think this
thru a little more carefully. What should the "default" weight be?
What if user specifies weights only for subset of leaves?

This part of the uAPI seems under-defined.

Maybe a better adjustment would be to make core set the weight to 1
automatically if the user has not defined it? Only when sending it to
the driver tho, because we'd still want it to not be reported back to
user space. Not sure how hairy it'd get code-wise.

