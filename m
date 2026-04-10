Return-Path: <netdev+bounces-277208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGWsMqJi2GlCcwgAu9opvQ
	(envelope-from <netdev+bounces-277208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:38:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C47A23D179D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 04:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66D1E300FEC3
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 02:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DA4275B1A;
	Fri, 10 Apr 2026 02:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hD5zTxDZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602C13B7A3
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 02:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775788700; cv=none; b=WB/mYIRFHFRIKC82+rmMwrg5nefGZcfWYFIYeagaTzAN2sYDOFmFPgOutArQew3oPQ1wLMaoMluONBa2Ihf7fLR7PSno5xMmj9SMXrxuJVgqiULqFf0DQt6oL2uUwlam50T7aSsMA/7tOae1xVQRj2FqFqeICdiYjuCQ6afq33o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775788700; c=relaxed/simple;
	bh=lvIVnWe+ukxMNeNAEgvAFAcXvh3LwY5dEsSYMMOglvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IXGUIfkWSwJf8kqYuaF+R5OsRlSZ/H3AxF9LUlLpc2yik4ISb1lh5LY/TC/XzEbIcsXh8YHnHCeZXt9K7AuqQwS7Mig66mK6uskbHnLu0yQS6y0Oy/B/E1ktvNskZvJ02A2kqMGJTY9l/nnlEHogERl9qd6LiGJMvEcykY1UEo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hD5zTxDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E88FC4CEF7;
	Fri, 10 Apr 2026 02:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775788699;
	bh=lvIVnWe+ukxMNeNAEgvAFAcXvh3LwY5dEsSYMMOglvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hD5zTxDZOx15Mz6GiKNj0t/26wYD/poyy/dcmav8WV7OAT8W2dR0okQeTzmQuFgdq
	 jbT3vVpEoyg6VfD6i8ViLXKhSu62+jgav4vjW4Q0XtX/Ws35/jYc3GsjW5/IoA4btC
	 TX0iZWgRD04HCFwwu469/bG3ntlZjAtB1yCdir33ExSCq6ulou7ddjKmI8ub2bxIgh
	 bPxXarYjcWjS5sbGMkybNJQTW2UMEA8A1dr6KlvBVJXgynj0X4+h3BJ/baFnbq+tEk
	 ZSB/117yQuFw8b8vyb4l/Whxv1umYqeJGSfr09T1OrZAVh/8TlPv39Zb2WBBus5DAv
	 iS1K5JMAaunoA==
Date: Thu, 9 Apr 2026 19:38:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Scalbert <louis.scalbert@6wind.com>
Cc: Jonas Gorski <jonas.gorski@gmail.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, jv@jvosburgh.net, edumazet@google.com,
 pabeni@redhat.com, fbl@redhat.com, andy@greyhouse.net,
 shemminger@vyatta.com, maheshb@google.com
Subject: Re: [PATCH net v3 0/5] bonding: 3ad: fix carrier state with no
 valid slaves
Message-ID: <20260409193813.249061e4@kernel.org>
In-Reply-To: <CAJ5u_OdU_okwjuEdm5zUBibW0PJsTng5ooZtXRX=wjhHpANdoQ@mail.gmail.com>
References: <20260408152353.276204-1-louis.scalbert@6wind.com>
	<20260408201341.68f31247@kernel.org>
	<6631e1e7-8728-46a4-9999-ea9910a1abfb@gmail.com>
	<CAJ5u_OdU_okwjuEdm5zUBibW0PJsTng5ooZtXRX=wjhHpANdoQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lunn.ch,jvosburgh.net,google.com,redhat.com,greyhouse.net,vyatta.com];
	TAGGED_FROM(0.00)[bounces-277208-lists,netdev=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C47A23D179D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 9 Apr 2026 13:49:06 +0200 Louis Scalbert wrote:
> > Signalling link up too early can cause issues for some protocols that
> > may change behavior in the absence of PDUs from a link partner.  
> 
> I agree with your point. I have observed issues with
> keepalived VRRP when it is configured on top of a bonding interface.
> 
> When the bond reports carrier as up while no slave is actually able to
> receive traffic (due to the partner not being ready, as indicated by the
> absence of LACP negotiation), the VRRP process interprets the interface
> as operational. At the same time, the absence of received VRRP
> advertisements is interpreted as if it were the only router on the
> segment. As a result, it transitions to the MASTER state.
> 
> In reality, another VRRP router may already be MASTER and actively
> sending advertisements, but those packets are not received due to the
> bonding state. This leads to a split-brain condition with multiple
> masters on the network.
> 
> Such a situation breaks the assumptions of
> VRRP, where a single MASTER is expected to handle traffic,
> and can result in traffic inconsistency or loss when upper-layer
> processes rely on this behavior.

It's been like this for what, 15 years?
We have to draw the line between fix and improvement somewhere.
In Linux we generally draw the line at regressions+crashes/security
bugs. If a use case never worked correctly it's not getting fixed.
It's getting enabled.

That said, if Jay wants it as a fix I'm not going to argue.

