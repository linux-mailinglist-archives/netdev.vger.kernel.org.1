Return-Path: <netdev+bounces-295364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CWs3Ffe1IWp5MAEAu9opvQ
	(envelope-from <netdev+bounces-295364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:29:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3806424D9
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 19:29:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hKC1thbz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295364-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295364-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E4413024392
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F271B4C6F1E;
	Thu,  4 Jun 2026 17:28:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4194C77AA;
	Thu,  4 Jun 2026 17:28:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780594126; cv=none; b=BhE8LLrX38yBQ4AdkvdvqAS5XT3HrAYZcUCMigvfGowzYBHmDz/cIlaClC3lf0tzLhzQihym5kHn+xYr9PGjkNPDo2r3iqhA0hC0sFQcVWbzFiBOysFXOFtJikyO1VaRF8mqg3FK9QNtWFW5ErM2pITW3wAqZINLJagLWW7q/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780594126; c=relaxed/simple;
	bh=FE/zpAIJ3+uA18zKSazKJm+9T9PyK7kLMINlO/kRdrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObaxksVd9+8Wx9/dh41t6UCgH87PT08s/p4FbVtUU5xqlbvVGbo2kLFdbOgSd7YgBrBfLUUT/F+PPQ7bYNBzvUGd3OClmgKI5hzvd/WhX+4ihOogKriB+ddfEUV+Q3HXHoAGCO9HaeklZ1Sa12CoO5pCJJ6UddiEPKCo8O8LZPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKC1thbz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E350A1F00898;
	Thu,  4 Jun 2026 17:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780594125;
	bh=7im0k5oW5XfUrXHH99zBcEKuYwrSW9WmaNTeeDdHU6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hKC1thbzicUfYEznOZQjP8v3o0MykMvpy8aNDZ2HICZbqfqyuykI/CQKdLpQovnMk
	 g6bO/deQYdXem8HKUhPUuiK44853VxmMdifZRzi+h9YAG1U2v/054Fr/tComocdigm
	 Uc4BfTHo6pPqJig1DsVE8fSpP+/kGtkRA+7toSz0l5S8uC7mQn6v/b8NJHX0Ou0Rsc
	 qJfoOV9Fx6KoLZmOzbYxaepwa6YO2ZjtyI5jZHSv6KcFwNzumi6sUcjZXP2OIaKjCi
	 pQpQYVThxH0ZsiVl9BCRtDOQrv9ifPgpBDoZsrOQFKOlndl3w9XD/9KeCrrjraG8pm
	 mvLF3K39AIZFA==
Date: Thu, 4 Jun 2026 18:28:40 +0100
From: Simon Horman <horms@kernel.org>
To: Robertus Diawan Chris <robertusdchris@gmail.com>
Cc: alex.aring@gmail.com, stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com
Subject: Re: [PATCH] mac802154: Prevent overwrite return code in
 mac802154_perform_association()
Message-ID: <20260604172840.GE3920875@horms.kernel.org>
References: <20260602054133.470293-1-robertusdchris@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602054133.470293-1-robertusdchris@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295364-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:robertusdchris@gmail.com,m:alex.aring@gmail.com,m:stefan@datenfreihafen.org,m:miquel.raynal@bootlin.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-wpan@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kernel-mentees@lists.linuxfoundation.org,m:skhan@linuxfoundation.org,m:me@brighamcampbell.com,m:alexaring@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,datenfreihafen.org,bootlin.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linuxfoundation.org,linuxfoundation.org,brighamcampbell.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB3806424D9

On Tue, Jun 02, 2026 at 12:41:33PM +0700, Robertus Diawan Chris wrote:
> When assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL, the
> return value assigned to either "-ERANGE" or "-EPERM" but this return
> value will be overwritten to 0 after exiting the conditional scope.
> So, jump to clear_assoc label to preserve the return value when
> assoc_status not equal to IEEE802154_ASSOCIATION_SUCCESSFUL.
> 
> This is reported by Coverity Scan as "Unused value".
> 
> Fixes: fefd19807fe9 ("mac802154: Handle associating")
> Signed-off-by: Robertus Diawan Chris <robertusdchris@gmail.com>

FTR: An AI generated review of this patch is available on sashiko.dev.
I believe that review can be treated in the context of possible follow-up
and should not effect the progress of this patch.

