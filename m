Return-Path: <netdev+bounces-160620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1E8A1A8D8
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 18:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024DC3A93F9
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5786112C7FD;
	Thu, 23 Jan 2025 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="evapiPAK";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="IAaHXFW5"
X-Original-To: netdev@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F62213D891
	for <netdev@vger.kernel.org>; Thu, 23 Jan 2025 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652832; cv=none; b=MciNeZR8DseAoiajdDRdTWeBaugOt5ol1++nbTTVR6QBxxZtgzGNd9kKMvrrmSt/s0LtgCxs2zmv5OcoeuXPLbZXjy6DAiXKfSPCjPaUFycX6XBDkDsXPQk9GNGdD+s3I04KTaueNkP+nUQeMGmnYpcMMNKa4Ho476HZWO1bbMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652832; c=relaxed/simple;
	bh=WhTsnlpcnQq4WidHbXE5ciYxnPBAP916V3sS7V7tWVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ij6wV9VfHTKLbYOcbTJUnH+RzhRYaKmK8VIeHYVRc1whipq0hPpM/CeEm7VkLDsKZw5qHmPNUY80ldRlFLVIhFMxlC9QegzSFSN7rXsqNrGu+2dGBgMu/OhpTrps7YP/3VYzd5Y4kyuvHQsDMEF+UieSTKHx2Qwo6AxyzB1o5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=evapiPAK; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=IAaHXFW5; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id DF6E460281; Thu, 23 Jan 2025 18:10:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1737652222;
	bh=CBXShc47+4kX7A6JXFFPx3Pz+0aI99upTCBf/QitxbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=evapiPAKGKNbCGPBlcwOwhr+32vOueQLuAzPZtI3SW7FT04LvRNEWyHltPF0G93YT
	 yLajO7Otcwl2v+qi2kOWsXu2IPMeyT0q78hmiYuNtIxV+C8GHHTVzFojddHH5bgqvJ
	 fJVpKfCLTmyZ0OZilFdK9lZxi9JBr358tGlDNCB4okC65X8gmvqoDP2lprD/HrYOWY
	 QzZs1iNB2xi3Dfje6jyvR78BE83CtvJ2byMfRMx4L4VTOG4+mKzTHaMei8RXmnx63E
	 0nNrvVkcGHRCkY/3FVmvfrPkKopYNXevGbDqkW7QVAX09djZRUtLWQa1JivVEpgPee
	 MUi7TQ0eojApQ==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id B5A5D60281;
	Thu, 23 Jan 2025 18:10:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1737652221;
	bh=CBXShc47+4kX7A6JXFFPx3Pz+0aI99upTCBf/QitxbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAaHXFW5rT/GPD8xMR8e53JoSe4odOYOCkoBnl4wr86Kpd5sv5pRBIEjtRRHTa0Zu
	 +Mi1u0RgLpCTcRf4M8z1a91ERIR6a6vHaTysH9PCOu6Gi/Lo6xaZZDOSjbgzEXAkI+
	 BYWebfk69uebUOLmkzukh5RI5I/KwsPLIh1yPCC9F510IqdqCfaetgFAkKgYHX5kgq
	 nHKeM8ovF/zFw2V812lOt+b2PD5QS0nEfFMOs6Te8kg6fX6Ao/u12Ujj1WjPLICV7i
	 llUTGXA3ym/KrD0qwwPLhdSqAuZREG/5J1vZVoRoHUdoHN3wH71j7SLLQCbttD9FsD
	 sT4gFb4uC9pkg==
Date: Thu, 23 Jan 2025 18:10:18 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, fw@strlen.de
Subject: Re: [TEST] nft-flowtable-sh flaking after pulling first chunk of the
 merge window
Message-ID: <Z5J3-ppgAuRL5P9U@calendula>
References: <20250123080444.4d92030c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250123080444.4d92030c@kernel.org>

Hi Jakub,

On Thu, Jan 23, 2025 at 08:04:44AM -0800, Jakub Kicinski wrote:
> Hi!
> 
> Could be very bad luck but after we fast forwarded net-next yesterday
> we have 3 failures in less than 24h in nft_flowtabl.sh:
> 
> https://netdev.bots.linux.dev/contest.html?test=nft-flowtable-sh
> 
> # FAIL: flow offload for ns1/ns2 with masquerade and pmtu discovery : original counter  2113852 exceeds expected value 2097152, reply counter  60
> https://netdev-3.bots.linux.dev/vmksft-nf/results/960740/11-nft-flowtable-sh/stdout
> 
> # FAIL: flow offload for ns1/ns2 with masquerade and pmtu discovery : original counter  3530493 exceeds expected value 3478585, reply counter  60
> https://netdev-3.bots.linux.dev/vmksft-nf/results/960022/10-nft-flowtable-sh/stdout
> 
> # FAIL: dscp counters do not match, expected dscp3 and dscp0 > 0 but got  1431 , 0 
> https://netdev-3.bots.linux.dev/vmksft-nf/results/960740/11-nft-flowtable-sh-retry/stdout

Thanks for your report, let me take a look.

