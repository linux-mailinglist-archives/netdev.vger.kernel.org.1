Return-Path: <netdev+bounces-289260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0JtdHRXSC2qaOgUAu9opvQ
	(envelope-from <netdev+bounces-289260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:59:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 269B5576A97
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 712A130089A2
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 02:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86823321BD;
	Tue, 19 May 2026 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlrSbn9D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CA331A77
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779159570; cv=none; b=AIaQU2+C8mLbYhwLqBtJWy8EBBxyiykaMNwNjYBHKCpvc7lLapwJRrKy3zQnO/4rx83d/cfHtyDIjfcpmh0+bUvu9eKWAjmA9Q7KneHE/TDl60MXyx2LoE31DxU1pMx3dd6LuJy7UPxkxIsKSEE7SWvs1YU77k6SJE1TfRrVwgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779159570; c=relaxed/simple;
	bh=yZNn/HwJCjS5JEmqMarBZ+dAVdQKOwgMxQSaU/H+u7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnDNW6ki4Z7mJzcKCBuTBHyrFnOyTI56R9EV1aXUOoAscB+i5K80wP/evq/hc7yHSv8wIB8c8BqalNX7Ioh/pGKfn2FLcu29nck5BO4dDRENTVj2QiKEf7HKxUXeGkW1NDo4oumau1/WT08NFRKlWKjw2XF3LOZbdHIRcpYT0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlrSbn9D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540E0C2BCB7;
	Tue, 19 May 2026 02:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779159570;
	bh=yZNn/HwJCjS5JEmqMarBZ+dAVdQKOwgMxQSaU/H+u7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mlrSbn9Dx9QLJu7tOOhf0RcIeyxie3BgDMDevuI0P9KVJXbqQrAuurmUYSNwQGvx7
	 VIlBtviPs0VzsH58FWm+ZJWWgXcVeN7VeCEm+yZyVJz5tkHp/vFGR5f4/dM/X2Eo75
	 MQ7oKe/waGnpzU1H3iKj42IjkUPnv8lwBdMaUPxFytrXyoPSRS7S7wCbOak7XF0lSw
	 EUiO19Iq2tVpHf7sJzppmQ+Z/r2ROMJ1UUdVAX/lZACXVdS4OQGW29l9qud0ONrEhx
	 cazICLNVR4z+wGeRm/w1A+8VUQAfxc4VTwDUw2XNFD0t7V9oEplBKQbVRCyutHUtKL
	 ln3KPnDzyWQGQ==
Message-ID: <ccbe47f5-5895-4db4-a472-1288a55a2b50@kernel.org>
Date: Mon, 18 May 2026 20:59:29 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using VRF to limit 'ip monitor' and 'iw event' messages
Content-Language: en-US
To: Ben Greear <greearb@candelatech.com>
Cc: John-Paul Powers <john-paul.powers@candelatech.com>,
 netdev <netdev@vger.kernel.org>
References: <e89dd0e7-3eaf-6385-7cfa-5f0079fabc96@candelatech.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <e89dd0e7-3eaf-6385-7cfa-5f0079fabc96@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289260-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 269B5576A97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 3:51 PM, Ben Greear wrote:
> Hello David,
> 
> We are interested in filtering out iw and ip netlink events for
> processes bound
> to VRFs.

are you trying to filter out the events kernel side or in `ip monitor`?


> 
> For instance, Chromium starts spewing errors when we try to run it on a
> system with many
> network interfaces, we guess because it is being confused by all of the
> other network devices
> going up and down.
> 
> I think the crux of the problem is to know if a netlink listener socket
> is bound
> to a VRF or not, and also to know if the generator of the message is
> bound to
> a particular VRF.

so you are running `ip vrf exec` on ip monitor? ie., how is the netlink
socket getting bound to a device?

VRF is only a Layer 3 construct, and a netlink socket is not AF_INET or
AF_INET6.

> 
> Do you have any suggestions for how we might go about this?  We'll be
> happy to post
> the resulting patches for consideration to be included upstream.

You could add try a filter in `ip monitor` that looks at the device
index and only emit a message if "sk_bound_dev_if == N" where N is 0 for
default VRF or the VRF device ifindex. From there, you would have to
parse the message, identify the dump type, find the netdevice attribute
and then figure out if it is a VRF device or a port of a VRF device.
Going to be complicated.

Kernel side, netlink layer has no knowledge of the attributes, so I
don't see how a filter could work at that layer.

This reminds of the kind of filtering (ie., fine details) that Jamal
wanted to do for tc. Kind of hard to do given the various layers.

