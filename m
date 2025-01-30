Return-Path: <netdev+bounces-161571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F07CA22725
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 01:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F025418870A7
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 00:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3294A35;
	Thu, 30 Jan 2025 00:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="aMyXI0oZ"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F2A55
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738196186; cv=none; b=LAsdf02I4n/Z00ffLGCr5DKsyAJbAPsDDHY9LTImQhV+Esj/JWjnmCBU/4mFSHUawWMWJUiKsAuOJfgPUvbmmS2VsQCORh9zU+Q9uphuvNn8dmJMXZq09qEnSb5qBkTLtM1XrUD0qKdKC81zm5hbszZsB47DBVwctjky/9ZRp8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738196186; c=relaxed/simple;
	bh=Zu2+tWtbyHKaJeYtVhx/XfLGdzkVSuE4SSYPqIZ+YLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ru0+jaWFpBYvMnbez3sG4qkyZ9xL+ewj2W7YRVQGcQOQQn4D84ya3VEUMJmmyHegKOuGOSes55upf9OOpCm9KD6tVsJbHi8W1k4lrqKWqm/z1a7v8BtpnrgqaTt3VjZ5mEZNADnGS5Geb8ckhVxX7yErhTGNP9jXSUKrQ2NxqcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=aMyXI0oZ; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [192.168.1.27] (220.24-245-81.adsl-dyn.isp.belgacom.be [81.245.24.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 6D0E7200DF94;
	Thu, 30 Jan 2025 01:16:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 6D0E7200DF94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1738196181;
	bh=qdLYotF5mS3xyK5CHxhu4k0+RSXfKpm9hvYqeFZu+ow=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aMyXI0oZ4J3eCkC1dm0vELhp8AXSRWLYxv04Y4CRRYeZ9Fmgh3pRhpbnu0Ic4pkwc
	 pyEF+Tuft7Zw1LQy6JtniFUKB0mTpv28wB+W2xuWqPj2KUKxg7u3glFsrIq800fGkc
	 LDFr/WCJJHVyv/Q5jpF/O7O41divluZYZ1Imj1fI6MggY7rWvs4EBZwVUG+bEKJwy9
	 Zp6mgGQwYPtQiNTjS/BOl735AOmiFgxRCACBIcB82HxlQnccqmTSQwmcZ/uxo4cJxw
	 DvHBTwQmfiydopbAZmFSlMD28BsGiHIw1F8DgckKPkbRHZR42c8tK14QwY/4AVFxCr
	 WDi0FG/oKTgJw==
Message-ID: <bb85b12c-8c6f-49d7-8192-1ddedffcb2c3@uliege.be>
Date: Thu, 30 Jan 2025 01:16:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: ipv6: fix dst refleaks in rpl, seg6 and
 ioam6 lwtunnels
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dsahern@kernel.org, Tom Herbert <tom@herbertland.com>
References: <20250129021346.2333089-1-kuba@kernel.org>
 <d4cb495d-6549-4b5a-bcf4-38dbbdda202e@uliege.be>
 <20250129122332.20b6b172@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20250129122332.20b6b172@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/29/25 21:23, Jakub Kicinski wrote:
> On Wed, 29 Jan 2025 17:17:28 +0100 Justin Iurman wrote:
>>>    net/ipv6/ioam6_iptunnel.c | 5 +++--
>>>    net/ipv6/rpl_iptunnel.c   | 6 ++++--
>>>    net/ipv6/seg6_iptunnel.c  | 6 ++++--
>>>    3 files changed, 11 insertions(+), 6 deletions(-)
>>
>> I think both ila_output() and tipc_udp_xmit() should also be patched
>> accordingly. Other users seem fine.
> 
> TIPC is not a lwt, the cache belongs to a socket not another dst,
> AFAICT.

*sigh* You're right, my bad.

> I think in ILA ilwt->connected will only be set if we re-routed
> the traffic to the real address already? So the dst can't match.
> CC: Tom, full patch:
> https://lore.kernel.org/all/20250129021346.2333089-2-kuba@kernel.org/

Looks like I was in a hurry when I reported this one. On second reading, 
this is also how I understand it.

