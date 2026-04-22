Return-Path: <netdev+bounces-280453-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YD87LxPn6GkHRQIAu9opvQ
	(envelope-from <netdev+bounces-280453-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:19:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7211D447CF8
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 17:19:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A126D30270B7
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD1432B9A8;
	Wed, 22 Apr 2026 15:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from winds.org (winds.org [68.75.195.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1232470F;
	Wed, 22 Apr 2026 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.75.195.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871183; cv=none; b=uSRPiZBrcxJe8+D9AScpj9IMapXdKra/H9nSwQy3rPLDSLg0hA7MJqZCq8ZvGfwNEINj1AaGDQONhuPwAPAgfLZpsVbI5/t81QNdr2c6kfPqeu0zuseOh8dOozqMzZX8dG4N+VVngNsGMOkDUByOv4wrDdpOdkguWSL29xWeA70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871183; c=relaxed/simple;
	bh=n5AnSYUIJdNciSqw0JFqdXr9t6s/FxzrTVOnpRgJ7Qo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZTAd8Y4TEJ+AXNy0EfCN68MIBJKpin/aCl02wCKvCqexyNSdFw736BChGCHs2C9AEfClfZor//U/6wH6Gv8IxFKxvnuD5uAhuHx6deXtmQCtMbsfoQCCY1pqWNjXih+r64knSL4q9H7mjrineBSD0WZDV0k3PnuFXQ7nu/P3H6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winds.org; spf=pass smtp.mailfrom=winds.org; arc=none smtp.client-ip=68.75.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=winds.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=winds.org
Received: by winds.org (Postfix, from userid 100)
	id E2E5F8F95F80; Wed, 22 Apr 2026 11:19:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by winds.org (Postfix) with ESMTP id E1C7013369000;
	Wed, 22 Apr 2026 11:19:40 -0400 (EDT)
Date: Wed, 22 Apr 2026 11:19:40 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: Andrew Lunn <andrew@lunn.ch>
cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
    linux-doc@vger.kernel.org
Subject: Re: [PATCH net 00/18] Remove a number of ISA and PCMCIA Ethernet
 drivers
In-Reply-To: <41d9fe43-9aa5-49b4-89cd-9aa13e4e4ea9@lunn.ch>
Message-ID: <ba9302dd-105c-09e4-90ed-fe56addb6ca1@winds.org>
References: <20260421-v7-0-0-net-next-driver-removal-v1-v1-0-69517c689d1f@lunn.ch> <71d319ef-cd49-e8a8-70dd-cf0763ac6305@winds.org> <e056d348-4560-4df3-85c4-e29393b004e9@lunn.ch> <9a0bc592-fb74-f646-1752-4359c0ac31a2@polinggroup.com>
 <41d9fe43-9aa5-49b4-89cd-9aa13e4e4ea9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-280453-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[winds.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gandalf@winds.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7211D447CF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026, Andrew Lunn wrote:

> On Tue, Apr 21, 2026 at 11:03:28PM -0400, Byron Stanoszek wrote:
>> On Wed, 22 Apr 2026, Andrew Lunn wrote:
>>>
>>> Could you live with v6.18, which has an expected EOL of December 2028?
>>> If you are only updating once per year, security is not an issue, you
>>> just want stability.
>>
>> I could for the time being, but this hasn't worked for me in the past.
>> Usually what happens is the PC breaks down, and the customer swaps in a new
>> backplane+SBC and moves all their PCI cards over. I then find I need to
>> update the kernel just to get the Intel DRM to work properly on the new CPU.
>> Some of these systems were installed back in the Linux 2.6 era, so I've gone
>> through several "Intel DRM not working" steps ever since CPUs started
>> getting integrated graphics. 2028 will come fast.
>
> Hi Byron
>
> I will drop this driver from the patchset.

Andrew,

Thank you very much.

  -Byron


