Return-Path: <netdev+bounces-160664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C38A1ABA7
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 22:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB467A10B1
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 21:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16B11ADC62;
	Thu, 23 Jan 2025 21:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GCllMqzV"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26078BF8;
	Thu, 23 Jan 2025 21:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737666085; cv=none; b=Zsw/C+N7k2thyiZsx/6nu8P22LRoOKuXROGvcBntt6z0hyNMxN7Xcd80eMshqQrhaUSLqe3ZKlYNyRzpHU9TaDvh7AWs76cytKF231ALDQ7ZKo3IZQO2jvVD5YoAY7ir58STKcqiuXLAB5bfmyxwG5YQwygNZr2kw5q+xcgykxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737666085; c=relaxed/simple;
	bh=YfMsiSGRXJijeoxUm83+tSim7wE5vWp96BmQA7YMYCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=irIQruu9Yjqt0LF2XeUV5MSEkF9p6xZw2T4gVQyRN7/HkeeiK8HsWkGjfMC0EbUNPLrnrHKwrC2k01RzQytkvP4PiHHabSmm/hrurJKyM3qd/1p5ACQ8cXuaGst+duD+kX/y3Wr6x+vJJVMFmAMUP0s+AaTVd5KkkF4W82VrQ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GCllMqzV; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C37511140093;
	Thu, 23 Jan 2025 16:01:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 23 Jan 2025 16:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737666082; x=1737752482; bh=LU5rkcGQUeXxabnsaZIkggdRgnJZufUXvxq
	Djh5U7Jo=; b=GCllMqzVT9sw2OwR4eVI56aO//Mlfpu6DAbolXlPTwCrvy9WZjO
	dCrf9hEy/If9OomhSuEF3msWNgVZt0YENco4hSDzSVRgUjKnl+zqmhMM3xZ8EOx9
	q8rxHGwXuGFtaLcJr9K64IMTpnyAXJ72aHuchFr0+XzCrw4YulsJOhw3MMAxQ3fa
	x+sYEjxlnbXeEAufKUz21WtWIrIuM7crdrAtpP0olOrfuoUkTD3T1b52wtUTvwbQ
	6XsA48uGgTeVSSXC1CGSmGyE3NiE9e6uVIhTymp+2tNXQfk3CAQCTtrG2rfg4pXR
	PHEObb2wzNlWSR2EWMGrDJwl290IpZULqVA==
X-ME-Sender: <xms:Iq6SZxPxBh2NfQWuOCMgNrnERqpTYCEZT-ncoOdLpbFxFHNmd3WfIg>
    <xme:Iq6SZz_TBZhEgu-tHhyjTfu7gr6w2tNHC0wP4RaBe9vBIgcBpL4ryfRrPuZbv2P9j
    PVFU3xhdXtQHhc>
X-ME-Received: <xmr:Iq6SZwTkuU3CWh6nGQK1S552OfIl7FhVSUtQmtOdJQ3j2UZ9IDKrZPNSZ7KW9lix4D_3_PeuZ8YzXQ5D7rF0-Fw0bkyvxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgvdeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshihoshhhihgurgesrh
    gvughhrghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhn
    rdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpth
    htohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehshiiikhgrlhhlvghrsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:Iq6SZ9sZlQtLc3uNY_y-aq8riqHkAQCI2ALYgbheZiT_oXyHtgLkug>
    <xmx:Iq6SZ5eI3t_Ffj3KWPhXJs7w2mwo29G1O80GAWSnnJlf7pZ07sG4sA>
    <xmx:Iq6SZ51ukp6G3HspJumzEGzLaOeyfdI2cfLC6KHHbrS9pr9DobMuHA>
    <xmx:Iq6SZ1-4E6X4y4Z2A6oyYTjbTFAqZys-rsYb2DC59LMRDZcw9E05Ag>
    <xmx:Iq6SZ4zVeTlMwxfLgBeZrzlUjS4UfA-i7EgsoihonSZYuITCkNPD4FtL>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jan 2025 16:01:21 -0500 (EST)
Date: Thu, 23 Jan 2025 23:01:18 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] vxlan: Fix uninit-value in vxlan_vnifilter_dump()
Message-ID: <Z5KuHjOPMb_zv5z3@shredder>
References: <20250123145746.785768-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123145746.785768-1-syoshida@redhat.com>

On Thu, Jan 23, 2025 at 11:57:46PM +0900, Shigeru Yoshida wrote:
> KMSAN reported an uninit-value access in vxlan_vnifilter_dump() [1].
> 
> If the length of the netlink message payload is less than
> sizeof(struct tunnel_msg), vxlan_vnifilter_dump() accesses bytes
> beyond the message. This can lead to uninit-value access. Fix this by
> returning an error in such situations.

[...]

> Fixes: f9c4bb0b245c ("vxlan: vni filtering support on collect metadata device")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

