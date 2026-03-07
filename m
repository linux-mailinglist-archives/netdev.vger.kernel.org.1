Return-Path: <netdev+bounces-264987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHPXK197q2kSdgEAu9opvQ
	(envelope-from <netdev+bounces-264987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:11:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28334229445
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 02:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3AF8301FABF
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 01:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55A328640C;
	Sat,  7 Mar 2026 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJaryAMX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921421B4156;
	Sat,  7 Mar 2026 01:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845916; cv=none; b=R6kYOwBGuxbb9jo/mIiKtPcm7LtYVZQ04HTtu5nIpLs23e5XiFc5pvKcGkPn2TdR8xah+9Ms7gfdwvMlmV6LbyyprJVwJAlbgUm+Ao3EdWjcNTgCcimKUh63AiE8VDwMFeKNu8U4Cqgl4Wxw3Fk1UVlxcpxZ7skLrTh4wN6K1A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845916; c=relaxed/simple;
	bh=Lf1FtGXNZyNA0EbItAQcMxegGIAfcopurtKeFYJ5JxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YEW+51aFXa9NBbP7mNQ+nk0qAaN7/f2RmbkZBg0rsl3JwuAT5jVzY5gHKi2x7LLI55I+l6+hA60rv0EitlTZNliDKMsZ/NgUflRUP2IcC5Bfs4klrlSwmtKfhxbLpHV3B5ewNYYURBPnYCzJhOedJrkrXLTBaIas9/DS4pHNjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJaryAMX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67D2C4CEF7;
	Sat,  7 Mar 2026 01:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772845916;
	bh=Lf1FtGXNZyNA0EbItAQcMxegGIAfcopurtKeFYJ5JxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KJaryAMXiGzs/50S+o2z/dARF6VCPnf6k6EXqI1E7wOwfxzcVg84fS8QZadXTJ2Sm
	 V8jkR0PHsLreJrUMveAspKDSMN4QA0jbdU+w+GphvZDVvTZJQLbKQHX+4JCun0ZIt5
	 GHQKfh+2us40tB1AaPI3N3gYperD7VJ7dRRCZ7DT50azHSiaURMWJ569kk9Qq/KaCV
	 bNQH7eVdCVt1DhEUk9bE6+KV9Bu043RvjceYQ2m6foX7/5o8R9hyCyAVEPJmFLUDct
	 yIR6uhUVVXIlWfnhu/746cW2fD3Md0RAQWqQ0Fm8lzoWaY2YwpowJHqKpKYp6rYDrM
	 2e5gcZ3epW1pQ==
Date: Fri, 6 Mar 2026 17:11:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: cedric.jehasse@luminex.be
Cc: andrew@lunn.ch, pabeni@redhat.com, horms@kernel.org,
 edumazet@google.com, olteanv@gmail.com, jiri@resnulli.us,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, jhs@mojatatu.com, davem@davemloft.net
Subject: Re: [net-next,v6,2/2] net: dsa: mv88e6xxx: Add partial support for
 TCAM entries
Message-ID: <20260306171154.6cb256e1@kernel.org>
In-Reply-To: <20260307010712.1201087-1-kuba@kernel.org>
References: <20260305-net-next-mv88e6xxx-tcam-v6-2-32c7fbac129d@luminex.be>
	<20260307010712.1201087-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 28334229445
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,redhat.com,kernel.org,google.com,gmail.com,resnulli.us,armlinux.org.uk,vger.kernel.org,mojatatu.com,davemloft.net];
	TAGGED_FROM(0.00)[bounces-264987-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri,  6 Mar 2026 17:07:12 -0800 Jakub Kicinski wrote:
> > +	reg |= MV88E6XXX_PORT_PRI_OVERRIDE_TCAM_MODE_96_BYTE;  
>                 ^^^
> 
> Would ORing the TCAM mode work correctly if the firmware has already
> configured the port to 48-byte mode? The TCAM mode field (bits 1:0) in
> the Priority Override register is a 2-bit enumeration where 0=disabled,
> 1=48-byte, 2=96-byte, and 3=reserved.
> 
> If bit 0 is already set (48-byte mode with value 0x0001), ORing with
> 0x0002 produces 0x0003 (reserved mode) instead of the intended 0x0002
> (96-byte mode). The standard pattern for setting an enumerated register
> field is clear-then-set:
> 
>     reg &= ~MV88E6XXX_PORT_PRI_OVERRIDE_TCAM_MODE_MASK;
>     reg |= MV88E6XXX_PORT_PRI_OVERRIDE_TCAM_MODE_96_BYTE;
> 
> In normal operation (hardware reset value 0x0000), the current OR
> produces the correct result. The issue only occurs if firmware or a
> bootloader has pre-configured 48-byte TCAM mode before the Linux driver
> initializes.

FWIW doesn't look possible from looking at the code (we seem to always
disable at init so field should be cleared?) But clearing the field
before setting it seems like a good practice, the rest of the driver
does follow the:

	reg &= ~MASK;
	reg |= val;

pattern. So consider this a stylistic nit pick, I guess..

