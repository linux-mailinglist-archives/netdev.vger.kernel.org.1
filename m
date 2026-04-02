Return-Path: <netdev+bounces-274400-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMtnH3cYzmmnkgYAu9opvQ
	(envelope-from <netdev+bounces-274400-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:19:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C6F38508E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 009C63103B9E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BD91EFFA1;
	Thu,  2 Apr 2026 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="4eUAifkw"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44131282F
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775113904; cv=none; b=jqVbiIsyHkvn024bfsQc6N9ebfJO/bQUP3/plN8KQ/i7lvgALSZPAa9WXomdBWhsEXQrkLhZA6tCkGgm3XfFAZFV5xZiKdY1+sLp3P61tlERys2lQg7i9szSZOYmJPD83PaQQgEndTmHjZweijf0Mq4xEA0QAUpgI6/qcaIE88A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775113904; c=relaxed/simple;
	bh=maDL0r1nwq+s5hNZu7y70VYFLrIX11hW8/tEcL7LVbM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=i4d/KbBJHY+rwK9UXIkc7pD+dxueH9LI/OACQbnksiGnLZJUsEXoARZ/z/c3l/UUDAYmY/n5wRAp0BnCps8DdXUSBIrfiMkWCZ4jesMPQoyJ92Sz78QYjkrgdiRsGWFhRSV/RyGDOAhS7pabDW1ZQ/3Rh0LdDDV873X6+n1zn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=4eUAifkw; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A2042A5870;
	Thu,  2 Apr 2026 09:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775113883; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LQnb0cSvMVZAKHjYuTbOfPHhBGVPX1yp8SB7YxT5h0Y=;
	b=4eUAifkw6VDQRmGAaR6T8ePIPR5NqMC5S6kZ5AHj6VB5ND6fAAp4m13YQSklvS40ywIxv7
	mUj/m7bWztfyfI/tfaxgbC1lljLKzJ5RWI8baDacVpgbwld2hRfhZIxAPrUXtz1Giw9tnR
	yQDvJ1LCsu6D8fwQvDqHJqKhOqTFExLPviXx7DD9FvDpGMAfGyvWIy3NsDafWVGPM67Hhg
	m9BBzXoRB2z+isiGfX391IgDSn6S+ThOw7+b0vH/2831AFjFQ7L5+L9j/Iuki9DfzZ6Z27
	BpnVBsOOLc6cntROlNKBWM5TIugMk/5UdjhAbBWV5NclJW4uL4DNQLL4LUiV7A==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 02 Apr 2026 09:11:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v3 0/2] net: phy: microchip: add downshift
 support for LAN88xx
In-Reply-To: <20260401184833.024cdb7f@kernel.org>
References: <20260329224202.500229-1-nb@tipi-net.de>
 <20260401123848.696766-1-nb@tipi-net.de>
 <20260401184833.024cdb7f@kernel.org>
Message-ID: <bcc3c223b6da280259f84ec99da559f4@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274400-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C1C6F38508E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2.4.2026 03:48, Jakub Kicinski wrote:
> On Wed,  1 Apr 2026 14:38:43 +0200 Nicolai Buchwitz wrote:
>> Add standard ETHTOOL_PHY_DOWNSHIFT tunable support for the Microchip
>> LAN88xx PHY, following the same pattern used by Marvell and other PHY
>> drivers.
> 
> Please do not post patches in reply to a previous posting.

Sorry, that was accidental. Previous versions were sent as fresh
threads and I'll make sure to do so going forward.

> Add a lore link to the previous posting in the changelog.

Makes sense, I will add a lore link to the previous patches in future 
changelogs.

> You're submitting quite a lot of patches, it'd be great if
> you could give our docs a read before sending more :/
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

Will do, thanks for the pointer.

Nicolai

