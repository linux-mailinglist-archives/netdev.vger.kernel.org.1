Return-Path: <netdev+bounces-234238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E67C1E0C5
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 265F44E2271
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419192C1597;
	Thu, 30 Oct 2025 01:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="x8WO5h9m"
X-Original-To: netdev@vger.kernel.org
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235A52BF013
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 01:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761788709; cv=none; b=GJlCMhOYcXpM/IAhzwb+lV9PObhxxpLbfb85ie+gUwvZh1G5njwnu0WNpyPPXJqs0JNP+zzmPRNethSNfn00BqlOXwX27B5koTM2DKxQmT0Z6JJGHCH2spPydxcA7KqXjF4aii3/jcJH+1p4i5c2AoZjpUTGZZ7KrWNSb6xiSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761788709; c=relaxed/simple;
	bh=gvQ2/8sLam7nJ9g95qzIpQxQ5oGzzw8/vjEsM27A4oQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z933xVWqNZKQsuObFwevykYJAbkIDxhVI2JMmwyJrB/dXBMeLDJwDPflavP+vBlD/uU86EEP+7/WTVQwAlS2NtjugZOp2rzFFXeksjODZ10xsEfjNI4RislEN9ZfHAR16/OXEXo1WtW5CJM8oG7JzzKUXX3abQl+fBxdQOXUzpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=x8WO5h9m; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from [10.20.0.32] (bras-base-tsrvpq3242w-grc-02-70-53-247-144.dsl.bell.ca [70.53.247.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id D2E42200BE45;
	Thu, 30 Oct 2025 02:38:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be D2E42200BE45
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1761788308;
	bh=nwEpSzD8LNPD+3oKTiyONHoWtZJPmcTTuf+jrGUntKg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=x8WO5h9mhFiROplkYjZyR5Iub5tbjNbHdwBb1+5Cop9OsNJSO2stm8V72D4l5POjz
	 AkPIvYYwCVv47VqGjx9wsrU2RSAZtCh6HDvbmicPUTGczQ09yEdDQbE7M+eTEbGf6K
	 5W5BRi+zkqZdedfwyJfxqccRfO+QKpI44Id9XyTVjAB7uJrOo01MsFfzLd5kW8hslN
	 fzPgEmE1mmw1DifM9QA0PPIisauSMn5LaZNaNJQyGQX05In/pEwr8nivYcs5b0Xsaz
	 kfEEZK7wBw3Mmx+qXNgbloU/gYlGsPsLCjnqUnM6g5lJuzpa+RtWmG/b2jpDqkwDMH
	 CUcTLlPnYbwHQ==
Message-ID: <6c8e2c11-2550-43cd-8c02-dd1b19303842@uliege.be>
Date: Thu, 30 Oct 2025 02:38:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] icmp: Add RFC 5837 support
To: Jakub Kicinski <kuba@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, horms@kernel.org, dsahern@kernel.org, petrm@nvidia.com,
 willemb@google.com, daniel@iogearbox.net, fw@strlen.de,
 ishaangandhi@gmail.com, rbonica@juniper.net, tom@herbertland.com
References: <20251027082232.232571-1-idosch@nvidia.com>
 <20251028180432.7f73ef56@kernel.org>
Content-Language: en-US
From: Justin Iurman <justin.iurman@uliege.be>
In-Reply-To: <20251028180432.7f73ef56@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/25 02:04, Jakub Kicinski wrote:
> On Mon, 27 Oct 2025 10:22:29 +0200 Ido Schimmel wrote:
>> This patchset extends certain ICMP error messages (e.g., "Time
>> Exceeded") with incoming interface information in accordance with RFC
>> 5837 [1]. This is required for more meaningful traceroute results in
>> unnumbered networks. Like other ICMP settings, the feature is controlled
>> via a per-{netns, address family} sysctl. The interface and the
>> implementation are designed to support more ICMP extensions.
> 
> Is there supposed to be any relation between the ICMP message attrs
> and what's provided via IOAM? For interface ID in IOAM we have
> the ioam6_id attr instead of ifindex.
> 
> Would it make sense to add some info about relation to IOAM to the
> commit msg (or even docs?). Or is it obvious to folks more familiar
> with IP RFCs than I am?
> 
> cc: Justin

I concur with what Ido said in his reply. There is no direct relation 
between them, unfortunately. The interface ID in IOAM context could be 
totally different, although one could see the benefit of having the same 
value.

