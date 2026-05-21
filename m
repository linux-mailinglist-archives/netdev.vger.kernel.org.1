Return-Path: <netdev+bounces-290191-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MzZNFFmDmqp+QUAu9opvQ
	(envelope-from <netdev+bounces-290191-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:56:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B93159DD3F
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 03:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 05CD7300C32B
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 01:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC8E27FB2A;
	Thu, 21 May 2026 01:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4ppQ1a3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EBE234964;
	Thu, 21 May 2026 01:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328590; cv=none; b=fIfzziBSFCK//Pv1ioS7jTA3gudcGUPrcREAB401w+UF/V5DTeTjN2bsBBLu1BwSB1cbFQCwHUcDIa+pwq0icZ7udeM7BiYHrMnVkhNycUvZBeGtwTknyeXs/UkWmBPaVXWgXzgpHanXQncR3x4vk63PgRwhlAccdBR8IS44iP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328590; c=relaxed/simple;
	bh=Xq+oayIoghIbwqV0ZhTC/NlI+RjO8Ta+rFOp5kHRJmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AVMHY61Em5rDCwS+T4NVMjxBlAfwZbCV1YWCkoFMtQ17FMntwEvjSLv8uPVW7o0384N7P3t2AIbgbrRzHW/SrTN6WTZ7s/rykYTRIKcDf5CKtZn9FvfNJnx/G9iAsrtqIfhyr+qsLBeajExEEqaVmOoI/S/aTIHcfM/DsMVLHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4ppQ1a3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB1A1F000E9;
	Thu, 21 May 2026 01:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779328589;
	bh=Q3HW2AI414iLaJB/mOyx74kIg0KtlFPdIzdQn3kLba0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=N4ppQ1a3FnAUvRijadlj3/k6nfK4ufiMWMO3/VU58kknj0lqCf2+hm7VIIJhJF+wh
	 EX3KTpXZP8184d0uqtZrPokbH0sEz6yzCwDoeRLOrk8QyThVD6+rIH1tS9z1Z9dbec
	 W2PGuB18uyyWdi37wYEPDxVb82nFn5+d9eP/7tBC510y/OMS0uJMBqQ1pQox+/TgGs
	 h+Ji+d29wNqhr/IVurl3VWRMECy3r90xxkImOFXNWL05x8VYjNWLCsAEl/kybURtUW
	 ZpV+ZSCfD7WQNod3UDR4CacF/+JGjXmt362TM3JZp5GcbjtQ8Z7HkFwqPX+pEt4wTw
	 G49M78ovEBA0Q==
Date: Wed, 20 May 2026 18:56:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Joe Perches <joe@perches.com>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: fec_mpc52xx: Fix resource size format
Message-ID: <20260520185628.5dcb3a1b@kernel.org>
In-Reply-To: <CAKxU2N-88yEQeGcMbj0_3Hd6RWMANEKKTvw3i6qVriG6wk38SA@mail.gmail.com>
References: <20260518044047.1002235-1-rosenp@gmail.com>
	<20260520170607.27cdf572@kernel.org>
	<CAKxU2N-88yEQeGcMbj0_3Hd6RWMANEKKTvw3i6qVriG6wk38SA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290191-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7B93159DD3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 20 May 2026 17:42:37 -0700 Rosen Penev wrote:
> > Not on 64-bit x86 builds apparently. Please provide more details
> > on which platform and compiler you see a warning and the warning.  
> 64-bit powerpc. How would this driver be built on x86? 

Hm, CI did rebuild a bunch of fec objects when this patch was applied.
But looking closer indeed not this exact file.

