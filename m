Return-Path: <netdev+bounces-99233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED78D42BD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 03:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0FA2854BD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 01:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC354E57E;
	Thu, 30 May 2024 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUw9qxeF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F33EAC5
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717031403; cv=none; b=rI9rXiGrU1lLLSGRvHhK7BTaIw3480mj14AyecxqHIz0vPNsvkN61QmDVCYIiWlH+h5wyXp2w9iOnVOkzo5AYq8fdODbjszMx95k6Qso2l5ft0aUq4YBROsnUOrygE8bCKC8qxcZpY0ulqmwUxumzcSQH3ZrI2j/OZ/9qIJAf4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717031403; c=relaxed/simple;
	bh=aXZsLisCpileIKrEqP/aRFHffWt0BPd3XD5fyt4XUhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uq/upKA3z6ubFEasrDDky2hLCohOwofqKG7mVziUYOEZu4uivx2RNpTmJI/alkdz9MRcqKTcxnWYKzWOgVdsJ5apxe6Lk483vQCZ8gBiXfUauSVdm90hJ3AiIInPG3gu/Mmv3F0cNsq7x0jHlFK5vaj6ceSDl3YnQ5a3r71UFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUw9qxeF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CE6C113CC;
	Thu, 30 May 2024 01:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717031403;
	bh=aXZsLisCpileIKrEqP/aRFHffWt0BPd3XD5fyt4XUhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oUw9qxeFCfwyKawYsDhUX1hefWk8LZIZSsD2I3+lhrBQZ/AWvwbhdO+HiRmqT5LK6
	 oKoq2Wyfx2D42j1FATCSwIr2sPUNzJovnuCi+ReNKEAhjc8Z/MgNsP0QjtgF76+26I
	 jsjzAOeL6YiVrPA6eLgCS0s7gz4aU9VzBlOk+JBtjZNe7hzdmFxRZElvdu5ybJdd2h
	 +jsM8VAC+uGdQG7Om/lX/8kKNJ9Y97LNiYM/8A/Fki7STKYD9R8uGW9D7aJGWHei8D
	 B2+VjItDrLOj0EqUxB0VFIjvaNKBgVnhhxGWa5IR42c/M2/2X6mfPP0XcRA7t4pLnO
	 1W06bR+CVAZ6A==
Date: Wed, 29 May 2024 18:10:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Breno Leitao <leitao@debian.org>, Arkadiusz Kubalewski
 <arkadiusz.kubalewski@intel.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 4/4] doc: netlink: Fix op pre and post
 fields in generated .rst
Message-ID: <20240529181001.4f2f8998@kernel.org>
In-Reply-To: <20240528140652.9445-5-donald.hunter@gmail.com>
References: <20240528140652.9445-1-donald.hunter@gmail.com>
	<20240528140652.9445-5-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 15:06:52 +0100 Donald Hunter wrote:
> The generated .rst has pre and post headings without any values, e.g.
> here:
> 
> https://docs.kernel.org/6.9/networking/netlink_spec/dpll.html#device-id-get
> 
> Emit keys and values in the generated .rst

I think your patch still stands (in case there is more such attrs) but
for pre and post in particular - we can hide them completely. They are
annotations used only by the kernel code gen, there's no need to
display them in the docs.

