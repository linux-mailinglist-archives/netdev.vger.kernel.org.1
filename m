Return-Path: <netdev+bounces-81869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E84E88B727
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 073A2293A79
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1833B2D7A8;
	Tue, 26 Mar 2024 01:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4f0bpT7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92CC208A0
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 01:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711418334; cv=none; b=KRN1qwlkolzDeB8mwiqE2ATPitGeCHu6bKTA8+1zq5iNqxGTj+PcVUrd7pZ0XvrASfm0AY91otYa330CZj0xmr+6m3LK8a0rdNpTbhFrpVpsH3RjzXKoYHq3LVbcJLIas48ZOoKVKTal+d5HKiBeJ+PlFdncLnByayfui3yCKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711418334; c=relaxed/simple;
	bh=UTfqvp1AuKc910NwG5qiGCGZVQiS1WHVFUCW62lxd+k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8UeBzf9DCP1eN5ZUHgjMHB5XFpkYaFmRpEgi+0ZcbpiQnxOgYdEK3UMsg66VLpkLX4XoPHX5/cOVkhXSkHcwXmDWkKpc6/GjTfPXelaJ3+d6uAQ5eBEb0/VNzx2aehHJQqK67sBKy9rWeagSQGrlrNBDhU3zYKCZZ590Qof5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4f0bpT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D164CC433C7;
	Tue, 26 Mar 2024 01:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711418333;
	bh=UTfqvp1AuKc910NwG5qiGCGZVQiS1WHVFUCW62lxd+k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X4f0bpT7TpZtBq3aljAY2DZe0ImYoiEB+EPRbT0Vj999mU0Vnm5aRDDDpyedBAa4D
	 O6OLrsWVZLB0adrw0iPqpdqclw83UJ0hIuylLhDtvplSTHRL7F4FJvCObeWJvJdPa6
	 3TNP2513QkRjI9/tl/BuFIY+jcKjmlTwuJUi9shZBGn0hLIJRTFDo28g4XsBjsrAJu
	 wtTkHbdjvD1MaQkeQM6v0PYDjxF50OoxpDh4nr9shFSVZ3tnX/qs86TAFFjEG+2Mfo
	 BVrro+Z7lPGzighwyYrPag4Y8WxQbq01MfdDdXDwZ8WwTHc5OMLSp/UoF1YG3N2zv6
	 SN6JsaFxOBn4g==
Date: Mon, 25 Mar 2024 18:58:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dw@davidwei.uk, jiri@resnulli.us, Sven Eckelmann
 <sven@narfation.org>, Jason@zx2c4.com, mareklindner@neomailbox.ch,
 sw@simonwunderlich.de, a@unstable.cc, pshelar@ovn.org,
 wireguard@lists.zx2c4.com, dev@openvswitch.org
Subject: Re: [PATCH net-next v2 3/3] genetlink: remove linux/genetlink.h
Message-ID: <20240325185851.1c876761@kernel.org>
In-Reply-To: <ZgG4IebcrI1RCKAe@smile.fi.intel.com>
References: <20240325173716.2390605-1-kuba@kernel.org>
	<20240325173716.2390605-4-kuba@kernel.org>
	<ZgG4IebcrI1RCKAe@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 19:45:05 +0200 Andy Shevchenko wrote:
> > +/* Non-parallel generic netlink requests are serialized by a global lock.  */  
> 
> While at it, maybe drop extra space? (I noticed it was originally like this.

Fair, I'll post v3.

> > +#define MODULE_ALIAS_GENL_FAMILY(family) \
> > + MODULE_ALIAS_NET_PF_PROTO_NAME(PF_NETLINK, NETLINK_GENERIC, "-family-" family)  
> 
> I would still make this TAB indented.

That one I'd prefer to keep. Coin toss between going over 80 chars
and having someone atypical indent.
-- 
pw-bot: cr

