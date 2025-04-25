Return-Path: <netdev+bounces-185819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7512CA9BCEA
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D94176717
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BF6156230;
	Fri, 25 Apr 2025 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoltwXdy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F215199A
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745548562; cv=none; b=hd0jLzSAVVgyjqF74iPhbyazESq+B4hUAJzUV0RVyzvOd1Bbq7fnkxIltRmRiCiRSyx/Sb7/ZJcR2igNfBIRGxY8sBWZsjdRp3kR500MSUVFrx82TSobO+XFav3BEJhNWFO3pWfKmRgIw7+BTMThRCkWSUg4ezPx4mESVBfz3ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745548562; c=relaxed/simple;
	bh=KHNSno31GnjRznKqPuf6wF1x74eNemBd6fECLeFlDaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HflGlG+uk2lxXoGfKRMPrjt4eOE+k9DITmiP71DehHndCAyXW7IGtc6UQZZ6nmfLRk+LDqFTh/WZKgN1HPCKInJaUADQiZnD33Kd78BmZEt4mP69MlDuJdoXSbc/+uA38AJuVdoO74uvG6YftJqi9/BUQUDROJj8bU1/wCe6NPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoltwXdy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF65CC4CEE3;
	Fri, 25 Apr 2025 02:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745548562;
	bh=KHNSno31GnjRznKqPuf6wF1x74eNemBd6fECLeFlDaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NoltwXdyX5GJ2N06o+a9z15ibi7dppkCbspJDW80vYQvVVW3Y+gnOXR7wj/3scw70
	 xDjHa01JqgH+onXThr+K2hqleZi+haMBUwUZcUZVA10Fqt5v2pq+ynQq0Plfn4GPtU
	 rZyjICJDgPjf1KEWlVuhWxj3IbVXybVgTEfTO7tLaeF8XRMRYKqXJ1Og/tq5NXrv6D
	 9E884ba7lbiqy4uCDcvv5uvercPT9CW0qMlzuh7Rm9ln6vclPNHfYdHmLBFOAnDgPm
	 zWVncgY52rFgc5SyL3y40gAy3EkqpaxOE93M/ykPiv5lXABwSqxvt3PqPX2hMjQNzr
	 Lt7V5ToxoZJTQ==
Date: Thu, 24 Apr 2025 19:36:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
 <donald.hunter@gmail.com>, <sdf@fomichev.me>
Subject: Re: [PATCH net-next 03/12] tools: ynl-gen: fill in missing empty
 attr lists
Message-ID: <20250424193600.2ae5a2d8@kernel.org>
In-Reply-To: <cf6ca99b-4d3b-4120-aa23-77335fc25421@intel.com>
References: <20250424021207.1167791-1-kuba@kernel.org>
	<20250424021207.1167791-4-kuba@kernel.org>
	<cf6ca99b-4d3b-4120-aa23-77335fc25421@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 08:49:32 -0700 Jacob Keller wrote:
> >  class Operation(SpecOperation):
> >      def __init__(self, family, yaml, req_value, rsp_value):
> > +        # Fill in missing operation properties (for fixed hdr-only msgs)
> > +        for mode in ['do', 'dump', 'event']:
> > +            if mode not in yaml.keys():
> > +                continue
> > +            for direction in ['request', 'reply']:
> > +                if direction not in yaml[mode]:
> > +                    continue
> > +                if 'attributes' not in yaml[mode][direction]:
> > +                    yaml[mode][direction]['attributes'] = []
> > +  
> 
> 
> This feels like there should be a more "pythonic" way to do this without
> as much boilerplate.. but I can't actually come up with a better suggestion.
> 
> Maybe some sort of try/except with a catch for KeyError or something..
> not really sure I like that more than the list approach either tho... I
> guess it would be:
> 
> for mode in ['do', 'dump', 'event']:
>   for direction in ['request', 'reply']:
>     try:
>       yaml[mode][direction].setdefault('attributes', [])
>     except KeyError:
>       pass

I like this better, thanks!

