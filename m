Return-Path: <netdev+bounces-230982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01662BF2D5E
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 19:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8F87934E1F9
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9D093321CB;
	Mon, 20 Oct 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="VbibNkiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C53321D7
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760983168; cv=none; b=IEahsuNg2GR2WNxBmWxC4qvTtcKQbdKZmAlMoscQK9VJllHavrLZrGTJBamKlb+CU3HsH5VW7tNM4a4PcPNZdX8hSiFgm0/dzjePqL432U6bC/yepyqglpSwQ5t4Ap9AyyjYf2Ww0PJcVivJ8rFxPvTjwBbXx7eS9PEwPurfQJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760983168; c=relaxed/simple;
	bh=Vj2Mz+fuzGnAnrlNbMoO4yBT2oo0rsNRmrl0J7/WCaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLwaqxI6IFcNQl1gkfOHtsK/Z0Lwu/gIyrz0edXTaNap6Z0VPq3Q7E7PGNWH6G7+mL2IKVA3sJzfnDD9Nsb3sfmdcqbd9GFnPpR3j82sNIJT2uFrtf+cSEazf4Ns6yBGwOqtJg92zm+vD17I3UEN0sYiXZBNRktUGeh+Z29sny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=VbibNkiQ; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5AFF899Hha1ANwfMovTDwgk4iIHayO4JUPk3ICORhZQ=; b=VbibNkiQDth+k2R7vCU1gf0eBW
	BpkJoCG3tEs9n3Ee7gpxb0VpZmw7XkKQz+FW4FRJjBn/xKbxa3smFUSEA7HwB1BJ8IEyxXdxbQqh9
	avsYhxi1yxrW7GQcHlWlJjcov4Ozm6JMYnvr1KwKGCA1pg1aORvxP9VbMfmw252JhcGw=;
Received: from [178.191.104.35] (helo=[10.0.0.160])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1vAuAG-000000006Af-0cSK;
	Mon, 20 Oct 2025 19:59:24 +0200
Message-ID: <b55a017f-ab51-48f9-a852-c0c4ff37cb7f@engleder-embedded.com>
Date: Mon, 20 Oct 2025 19:59:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tsnep: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20251017203430.64321-1-gerhard@engleder-embedded.com>
 <aPYKDkBaoWuxuNBl@horms.kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <aPYKDkBaoWuxuNBl@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 20.10.25 12:08, Simon Horman wrote:
> + Vadim
> 
> On Fri, Oct 17, 2025 at 10:34:30PM +0200, Gerhard Engleder wrote:
>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>>
>> I took over this patch from Vladimir Oltean. The only change from my
>> side is the adaption of the commit message. I hope I mentioned his work
>> correctly in the tags.
>>
>> New timestamping API was introduced in commit 66f7223039c0 ("net: add
>> NDOs for configuring hardware timestamping") from kernel v6.6.
>>
>> It is time to convert the tsnep driver to the new API, so that
>> timestamping configuration can be removed from the ndo_eth_ioctl()
>> path completely.
>>
>> The driver does not need the interface to be down in order for
>> timestamping to be changed. Thus, the netif_running() restriction in
>> tsnep_netdev_ioctl() is not migrated to the new API. There is no
>> interaction with hardware registers for either operation, just a
>> concurrency with the data path which is fine.
>>
>> After removing the PHY timestamping logic from tsnep_netdev_ioctl(),
>> the rest is almost equivalent to phy_do_ioctl_running(), except for the
>> return code on the !netif_running() condition: -EINVAL vs -ENODEV.
>> Let's make the conversion to phy_do_ioctl_running() anyway, on the
>> premise that a return code standardized tree-wide is less complex.
>>
>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>> Signed-off-by: Gerhard Engleder <gerhard@engleder-embedded.com>
>> Tested-by: Gerhard Engleder <gerhard@engleder-embedded.com>
> 
> Hi Gerhard, Vladimir, Vadim, all,
> 
> Recently Vadim has been working on converting a number of drivers to
> use ndo_hwtstamp_get() and ndo_hwtstamp_set(). And this includes a
> patch, rather similar to this one, for the tsnep [1].
> 
> I think it would be good to agree on the way forward here.
> 
> [1] https://lore.kernel.org/all/20251016152515.3510991-7-vadim.fedorenko@linux.dev/

I already replied to Vadim, but on the first patch version, not on V3.

@Vadim: I reviewed your V3. Thanks for your work!

So this patch can be stopped.

Gerhard

