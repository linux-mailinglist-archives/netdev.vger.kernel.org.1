Return-Path: <netdev+bounces-294809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A3UsEsdIIGql0AAAu9opvQ
	(envelope-from <netdev+bounces-294809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:31:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0051639365
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 17:31:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=V1kJK4hg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294809-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294809-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D70E31E10EA
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 15:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B213D1709;
	Wed,  3 Jun 2026 15:18:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C683AA1BB
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 15:18:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499923; cv=none; b=BNazvt5bv/o+ZSkBc1Abw6jF/fLUD0BUUF1kigYAii+ATzgx2ykdx/nLxbKPdb31nJAupaWrluOAhsqW3KGC2qZxLBb3ocfeN7YB+3yAkMfjpWWHzZsH6GIBY8oLvFPPXXqJ70z0fajnJRer28JQGr1vdutmT1HM0bEj7OG/uCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499923; c=relaxed/simple;
	bh=VKkPxkdeWrc8eTUaVr1ll/x/2lw6qaNLgAq3sVYCTO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SpOLhIcwlSkO4u2TbRL357yhfj/XiLhsCnRpzst7JujtkVZx7gnP+QeXoBSf5VmmtU5NduF2/HvvUWC3Lsdw2mFO2cqcVF7zoZftmYnYrbuX7kVJ/4NyyM6Y2qsKvBxs+iKdQlZQqaDu47/EfIL2Dormq49DPoGH6ye7mVW7DgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1kJK4hg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743871F00893;
	Wed,  3 Jun 2026 15:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499921;
	bh=L4CAxIJULwPw5hybaGw2n5JW1n4yAgxXpgBTwpka+w8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V1kJK4hgTeaheLWDhGHtJjwRA+/XNJ1euZH/v+QPdAFRHPeR6RkfxhGFZg/kHgO2M
	 ekU3ME6eSqvD0xLMzD8D/tm/H5C9WoT9vYix3njhC/94gdG1i6VsOOiVJoBGZJHTgb
	 BzNm6GIa+sRdcDSS5GkYbPO9LJIwRDOrNdmtTPFygoqO2weB6jUDlyMI9f0p1SP7ak
	 dXecp3GDfCjGLaQVkOE6f7WbXzH1yaWiA9GVE9wf/FbW86ABgJgSI6tFI4MltD7bH/
	 Vy9EAagPVeqKa9Lq7hfOcbVB0zZKcRAnXIahyiEKrcbDEp2UtBv6eBcPN7DN3RvMft
	 T4t58MrOYYUWg==
Message-ID: <0bc2dcd4-b29e-4a82-8d1b-5170e78c2d74@kernel.org>
Date: Wed, 3 Jun 2026 09:18:40 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iplink: add support for setting IPv4
 devconf parameters
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, nicolas.dichtel@6wind.com,
 netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com
References: <20260601143242.6729-1-fmancera@suse.de>
 <6365ef1e-d62d-4b2d-8e41-526881bbbe37@6wind.com>
 <491689b6-95f9-4e32-ae70-fdae464af353@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <491689b6-95f9-4e32-ae70-fdae464af353@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294809-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:nicolas.dichtel@6wind.com,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,6wind.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0051639365

On 6/3/26 7:24 AM, Fernando Fernandez Mancera wrote:
> On 6/3/26 2:50 PM, Nicolas Dichtel wrote:
>> Le 01/06/2026 à 16:32, Fernando Fernandez Mancera a écrit :
>>> Currently, modifying IPv4 interface configuration parameters requires
>>> interacting with sysctl (/proc/sys/net/ipv4/conf/*). While
>>> ip-netconf exists for monitoring these values, there has been no native
>>> way to set them directly through iproute2.
>>>
>>> This patch introduces the support for that via 'inet' at the 'ip link
>>> set'. It uses IFLA_INET_CONF netlink attribute to set the parameter.
>>>
>>> Example to enable forwarding on an interface:
>>>
>>> ip link set dev enp8s0 inet forwarding on
>>>
>>> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
>> Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
>>
>> Do you plan to add the ipv6 part also?
> 
> Yes, it is cooking but I want to get merged IPv4 first.
> 

If I merge the ipv4 patch today that means you are signing up to send
patches for ipv6 set and then ipv4 and ipv6 show in detailed device
dump. All of that in the next 2 weeks before 7.1 is released. Just want
to make sure we are clear on expectations.

With respect to this patch, the usage is getting long and wading through
all of the inet and then inet6 options is going to be a challenge.

Stephen: opinions on location and details? Should the list even be in
the usage vs only the man page? ie., usage just has `[ inet <devconf
options> ]` (and similar for inet6)? If the all of the options stay
listed in the usage they should be in alphabetical order (and added
after the existing gro_max_size line?).

