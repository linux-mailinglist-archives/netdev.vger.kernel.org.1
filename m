Return-Path: <netdev+bounces-169640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9D7A44F44
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 22:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3986189CED9
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464EC21171A;
	Tue, 25 Feb 2025 21:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="Vsohr2Pq"
X-Original-To: netdev@vger.kernel.org
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793353209
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520416; cv=pass; b=FAIseP7NAmyRmc6rU757P6lmAaNfLhc2RrQycx988lmKJzW9WXPexVDMnokysTUT3g+8bpvvV5cqmpsJeCMhbnhWsxJy3FWQ1BOFB9hgxBgzib4pFc8mmCSg0kI9b71zvcuTzsBuPt/PQBPcrOR4CoykNWnE24wC7sqETMABC2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520416; c=relaxed/simple;
	bh=4eEvkX4bWBJQeXiVjDsxJA6T/kbM5/kr89ODp98jW0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4JWB+Jtn3ejVG+ZYDCWU4B2FcbsJgKJBX0maW6bEsEOomUOTwYpPIBOg+9u3YKshWDg2yN4EsCREPuhSZsUX5BLAnsy0Cca7zQNvfeFy8YYqN0WbWFiJmHtq+eR+9Gv+r4LIPtL5DYUTLbmXcPeyv3k6FZqFblHOgShS7Oa6tY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=Vsohr2Pq; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id C453522FC6
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 21:53:28 +0000 (UTC)
Received: from pdx1-sub0-mail-a239.dreamhost.com (100-99-192-59.trex-nlb.outbound.svc.cluster.local [100.99.192.59])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 76B17226FB
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 21:53:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740520408; a=rsa-sha256;
	cv=none;
	b=F/NnMBIDjbEjg9FqIIJ80ONP87L5hfbEmng5RhciPRdb+35BxK6aZcXEM5WsWKjMt7lHdO
	7U8FDZTVMFEumDZJfcUvgMTa8pm20hB3/JiHdX2FA2YPFjHaMlTlii+9G7U//u20Yr1fU8
	VRbrBfGt64x25yC9BCl6cdsRONQhaEPWZN+2Q2KWpkbqH3/nCHKYq0ys9UugjlGaSx8xpz
	/krdKkI4WZ0MdVW0IV89ele20eC/d7f/ThNMmqtGZBMfHNoYqhxhKGx7RNB7MVD0vPJy1v
	8Vf9UTOm6rz5BmzzV6yx1iAXNlBXhYYON1fItqf3wpvkW+Is4K1BshW2VPEF2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740520408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Z/s8F0fUEzFPMT5zIMTWfFvhlY4uSR/7qZbV0QqiP6k=;
	b=4wJx3koQ56IpI4AENq+E+AH0nQmq81VUpNdAvAjjdpdf71ffYm1Itn+OmBS1P5SI2hv9S5
	dD1DUibMhr5tRh+DBkbjfv1USfEanGP2KozZqkkfWEy/DfTmUV0LN9W/rEJBJqoK+MNLO/
	4EHnlyOVpUm0qeI6ECA+p6OIfWd0YWcbdpETJ82bbUqT+e2nn5oH9rOAP8bQ8g6qBij7r1
	4MvDVguINWZPLLfv9XM1wgbd3p6ooZsOhSlb/utcHtr7gIxO0JHOD7EkCkigdEaKutGGed
	VzTKhCF7kKn9ZWcr6T5MyeXeyHPesIhWgaoCCFluA1GBgHUVLGP16s3hmJQtVg==
ARC-Authentication-Results: i=1;
	rspamd-6d7cc6b78d-lz4wh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Occur-Celery: 269669790ff9dd90_1740520408694_3002488501
X-MC-Loop-Signature: 1740520408694:2089438862
X-MC-Ingress-Time: 1740520408694
Received: from pdx1-sub0-mail-a239.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.192.59 (trex/7.0.2);
	Tue, 25 Feb 2025 21:53:28 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a239.dreamhost.com (Postfix) with ESMTPSA id 4Z2WZH6Q3dz11p
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 13:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1740520407;
	bh=Z/s8F0fUEzFPMT5zIMTWfFvhlY4uSR/7qZbV0QqiP6k=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=Vsohr2PqnfytkNcxbyKYcOXk+4rOhO7j4jOXbdeyWkRiF2syAc4rpAJVw4Wz4PekA
	 hjwYUVeIdOH9iIy2M37bhi3GjDBqSFCZ4215dM6S2SRSrs+DnwuPEqPlXCaJAr2Z+3
	 Bgd/jVUzUWqDTj9sAcrtEHZBMm6u5VIwRIgppkCImkWqvIR/FOAB4yfJt+32606nUQ
	 jny0dJgtR701CC9em9lV9BLcz5yiAJd5TTOctploPLzPrf/2dVQC420qwF24kiK3hA
	 9iElWGPyjOGiCr5DGvEOPuI8MhijGF8PU6/JdyACzQM36fEyeJoQGOY7hJjbRnLLi2
	 Pr++wALgBGsCw==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00d7
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Tue, 25 Feb 2025 13:53:25 -0800
Date: Tue, 25 Feb 2025 13:53:25 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: Re: [PATCH v2 mptcp] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
Message-ID: <20250225215325.GC1867@templeofstupid.com>
References: <9ef28d50-dad0-4dc6-8a6d-b3f82521fba1@redhat.com>
 <20250224232012.GA7359@templeofstupid.com>
 <e8039b96-1765-4464-b534-d6d1385b46eb@kernel.org>
 <20250225192946.GA1867@templeofstupid.com>
 <30663725-7078-4b8d-bc75-8a9cd15b0b02@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30663725-7078-4b8d-bc75-8a9cd15b0b02@kernel.org>

Hi Matt,

On Tue, Feb 25, 2025 at 10:41:55PM +0100, Matthieu Baerts wrote:
> On 25/02/2025 20:29, Krister Johansen wrote:
> > On Tue, Feb 25, 2025 at 06:52:45PM +0100, Matthieu Baerts wrote:
> >> I'm going to apply it in our MPTCP tree, but this patch can also be
> >> directly applied in the net tree directly, not to delay it by one week
> >> if preferred. If not, I can re-send it later on.
> > 
> > Thanks, I'd be happy to send it to net directly now that it has your
> > blessing.  Would you like me to modify the call trace in the commit
> > message to match the decoded one that I included above before I send it
> > to net?
> 
> Sorry, I forgot to mention that this bit was for the net maintainers.
> Typically, trivial patches and small fixes related to MPTCP can go
> directly to net.
> 
> No need for you to re-send it. If the net maintainers prefer me to send
> it later with other patches (if any), I will update the call trace, no
> problem!

Thanks for clarifying.  I'll hold off on sending anything further and
will either let the net maintainers pick this up, or have you send it
with your next batch of patches.

Thanks again!

-K

