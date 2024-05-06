Return-Path: <netdev+bounces-93655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6258BC9D3
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 10:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2C21F22BF5
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 08:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9B1411CE;
	Mon,  6 May 2024 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="SD98I92z"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CBF28DD1;
	Mon,  6 May 2024 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985065; cv=none; b=eMwExnrgYThh3CbyQlRCyae/TqEWA8r0rRnUxbZ68OpOmkouqtSAY1DJZ/Xf+aZW64mVgA0MD64eAtE9AVHWIWhmykRvDoS0G4pgQwL9vJtp3rmhw+MhrAzO632LoXn6j+vQEjLvJXqXJGxvCwmV5VQJi1c/98EwbmTDf4PgJg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985065; c=relaxed/simple;
	bh=TjbpkkZ794tR7dnJwl4XSmaecxKfYD4Yj3mozjWLP7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+7nzBfnWWebA9+PevCt+uO6Xamv9EHAHiZTEX6DvtvR6URDiKUkNA++IuJfuww7lV02eOlb59Y0o6SZHN/OAlmBHKd0opRoCKGqiPHKxa/gIb9USs6vmHTulyJSuAilL8LTsWrN8YPoB9jdHwukq81sIjli57/HY9kILMYLx5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=SD98I92z; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 13B00600A2;
	Mon,  6 May 2024 08:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1714985052;
	bh=TjbpkkZ794tR7dnJwl4XSmaecxKfYD4Yj3mozjWLP7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SD98I92zttS3zulSx8ejP2fSeKAcPByx/Tk9hNJtL/s8/JxxsT9KejIppr9a5m7Yi
	 q4xX/FaXcc5L19iCg/oqS7fJpmRqGtI8je3AHnkBNeodjQJhYHHMNdWPZY2LFUijAC
	 GCiH38AaP6z/jTb8hJTyDKGFl4ARvMyDufooc6K+tWFjstlSNJ9nz6FXLxqI6bBreG
	 wJWpyAjxDnr/Nv09mimFV8ty4WhZhA9ScIIFm+GoU6Z6ovWeGSNS4lqnQwTikRJ8yG
	 jw3BHiNUjRk+hxhm2t/ntRXjJblVyKI/+WoEjqMbObzi4BryiVzynDa65pQFOgAPml
	 AAx4rdg/dPNnA==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by x201s (Postfix) with ESMTP id 3F41820146D;
	Mon, 06 May 2024 08:44:03 +0000 (UTC)
Message-ID: <7cf42f1b-d7e2-4957-bee9-e875c61d19e2@fiberby.net>
Date: Mon, 6 May 2024 08:44:03 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] i40e: flower: validate control
 flags
To: "Buvaneswaran, Sujai" <sujai.buvaneswaran@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
References: <20240416144320.15300-1-ast@fiberby.net>
 <PH0PR11MB5013807F66C976477212B27C961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
In-Reply-To: <PH0PR11MB5013807F66C976477212B27C961C2@PH0PR11MB5013.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Sujai,

Thank you for testing.

On 5/6/24 5:32 AM, Buvaneswaran, Sujai wrote:
> HW offload is not supported on the i40e interface. This patch cannot be tested on i40e interface.

To me it looks like it's supported (otherwise there is a lot of dead flower code in i40e_main.c),
although it's a bit limited in functionality, and is called "cloud filters".

static const struct net_device_ops i40e_netdev_ops = {
	[...]
	.ndo_setup_tc           = __i40e_setup_tc,
	[...]
};

There is a path from __i40e_setup_tc() to i40e_parse_cls_flower(),
so it should be possible to test this patch.

Most of the gatekeeping is in i40e_configure_clsflower().

I think you should be able to get past the gatekeeping with this:

ethtool -K $iface ntuple off
ethtool -K $iface hw-tc-offload on
tc qdisc add dev $iface ingress
tc filter add dev $iface protocol ip parent ffff: prio 1 flower dst_mac 3c:fd:fe:a0:d6:70 ip_flags frag skip_sw hw_tc 1

The above filter is based on the first example in:
   [jkirsher/next-queue PATCH v5 6/6] i40e: Enable cloud filters via tc-flower
   https://lore.kernel.org/netdev/150909696126.48377.794676088838721605.stgit@anamdev.jf.intel.com/

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby - AS42541

