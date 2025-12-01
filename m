Return-Path: <netdev+bounces-243041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0692CC98C73
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 19:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B85563A4C98
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 18:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2149F22B5AD;
	Mon,  1 Dec 2025 18:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b="mgu5CaTK"
X-Original-To: netdev@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0E336D513;
	Mon,  1 Dec 2025 18:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615280; cv=none; b=Jo3qMZf4bRF9//IhMaHz0FeOiMTKejAkoQraG9+wXlovtAHE9HqB90ogOPNHN/QC6cuVhhxvM136qnnjd2mUCGHommRWUtzqRY9Qs9DGCisKV6XpwewnONUMtxanfzEzVfqKU6SvsTUoiFfm2wORLHHjI20DLpE3CUiawEzOQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615280; c=relaxed/simple;
	bh=F1J5HJgnTo000aaP9JAHz7BWhsVsZhh2IvjCGYiorcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJIt1Sj5nD1n/GG6Ci3+yyIcN2Tk2drHreUJnISIxotOchAeVWdznWsZBbEY+lxOPL1vmpQLFympJTEeRSicsp/2LW0RVHTxqvh00TkJ6meE/uOl60Tr3zoGZK/xyHm87fwGBVEAY9lgWXRS0PVeFGk+lBem8CF00PxCcCO2/1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx; spf=pass smtp.mailfrom=cve.cx; dkim=pass (1024-bit key) header.d=cve.cx header.i=cve@cve.cx header.b=mgu5CaTK; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cve.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cve.cx
Received: from smtpauth1.co-bxl (smtpauth1.co-bxl [10.2.0.15])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 1DB47EB3;
	Mon,  1 Dec 2025 19:54:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764615268;
	s=20250923-2z95; d=cve.cx; i=cve@cve.cx;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
	bh=FjkuA9Mn+WW4eMbFra24Oh8tOwwOgRi8g3G7uyVJM7o=;
	b=mgu5CaTKWlUI8EsTrU6/VuCcKYQgboNBgSJMXwbGilqL30PNFgp5WVJgDkLAv7VN
	DjWVexDyCntDSkellSWlAWNX6bxO8zXW9cu5jJ9SR1G6HnDMPzOKiXie2Gj5wnyFFOJ
	TkZyU+ItpaFc1abVdr/Bs4NjXA2p3r0lYNWaEho0=
Received: by smtp.mailfence.com with ESMTPSA ; Mon, 1 Dec 2025 19:54:25 +0100 (CET)
Date: Mon, 1 Dec 2025 19:54:23 +0100
From: Clara Engler <cve@cve.cx>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] ipv4: Fix log message for martian source
Message-ID: <aS3kX7DApnSfJtT9@3f40c99ffb840b3b>
References: <aSd4Xj8rHrh-krjy@4944566b5c925f79>
 <20251127181743.2bdf214b@kernel.org>
 <aSnSJZpC8ddH7ZN0@c83cfd0f4f41d48a>
 <20251128104712.28f8fa7c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128104712.28f8fa7c@kernel.org>
X-ContactOffice-Account: com:620022785

On Fri, Nov 28, 2025 at 10:47:12AM -0800, Jakub Kicinski wrote:
> Could you explain how you discovered the issue?  (it should ideally be
> part of the commit msg TBH)

In the past few days, I toyed around with TUN interfaces and using them
as a tunnel (receiving packets via a TUN and sending them over a TCP
stream; receiving packets from a TCP stream and writing them to a
TUN).[^1]

When these IP addresses contained local IPs (i.e. 10.0.0.0/8 in source
and destination), everything worked fine.  However, sending them to a
real routeable IP address on the internet led to them being treated as a
martian packet, obviously.  I was able to fix this with some sysctl's
and iptables settings, but while debugging I found the log message
rather confusing, as I was unsure on whether the packet that gets
dropped was the packet originating from me, or the response from the
endpoint, as "martian source <ROUTEABLE IP>" could also be falsely
interpreted as the response packet being martian, due to the word
"source" followed by the routeable IP address, implying the source
address of that packet is set to this IP.

[^1]: https://backreference.org/2010/03/26/tuntap-interface-tutorial

