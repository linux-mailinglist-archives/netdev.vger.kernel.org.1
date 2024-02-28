Return-Path: <netdev+bounces-75866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57D2F86B649
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 18:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 117B928A44E
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA715E5A8;
	Wed, 28 Feb 2024 17:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRcuINA1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5071415CD5D
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142194; cv=none; b=h6B2ygZuH9ZoDK6E8dO9chx6QIAYGovKiac/VzWNRTPAHv+NhbqiGSpk+3V3DmBvbeuVWXo8vg8GS0ONU7O8uOfuM5ZfULWpKkSqOHNwB7IWer7E2eoRAJ9S9aBS4WuMyw6oFPRb8P/CLR6MxsM9Pw3Ba3GF2b37od7E+4aDGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142194; c=relaxed/simple;
	bh=2gLZSZdxUdSmTk3dyeHKxWAfWu/5ZI1JxwssXFWxCFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y5yiRxxWHwyALE6y3NPv8aZo9V0JzWl3AvTzZ/o0Vb90624I4kPjcaTa0bz1qiluxg83312Mv4gcwwkeLaYLUWaRa6pI1CA+iMpszs+OfkTK02SGruvKDKj2KSxsP1NyaBhGayJgpOHgdf1Zrqlmj2X2Cggg3wCMNqGuPfbbHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRcuINA1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604F1C433C7;
	Wed, 28 Feb 2024 17:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709142193;
	bh=2gLZSZdxUdSmTk3dyeHKxWAfWu/5ZI1JxwssXFWxCFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HRcuINA1P4t9mfpxTNmLqwkCSABiUnhLZYo+/5t3sK3DoZuuXTbzLzAqxeiMCpsBA
	 A4c1B9JJvqo+q4DZF17f9exfjXfLLYtKzrzRhEiYC1O4m7cxwT6bkaAaw9DYWNfyZN
	 Zga300PAAa5owNbnJA6S2NCCBOt2U0yjg4YLey0rXWN9IxZbnaiCs9ap2SfbWxG8Rv
	 hsrO0++eh8F0xp1g1Rkf1QA8GfP33VHCk1lhxAlqY24UPaZSy26pdqyNs+GszTFVzx
	 Sv38edTPIunGlU+WBw9trepBhR59uwHy4637scLwHj4fejr+MzQcj8glaM5o/d9uwa
	 Nw+OF8gMr0EWg==
Date: Wed, 28 Feb 2024 09:43:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Tariq Toukan <ttoukan.linux@gmail.com>, Saeed
 Mahameed <saeed@kernel.org>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed
 Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, jay.vosburgh@canonical.com
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <20240228094312.75dde221@kernel.org>
In-Reply-To: <20240228090604.66c17088@kernel.org>
References: <20240215030814.451812-1-saeed@kernel.org>
	<20240215030814.451812-16-saeed@kernel.org>
	<20240215212353.3d6d17c4@kernel.org>
	<f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
	<20240220173309.4abef5af@kernel.org>
	<2024022214-alkalize-magnetize-dbbc@gregkh>
	<20240222150030.68879f04@kernel.org>
	<de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
	<ZdhnGeYVB00pLIhO@nanopsycho>
	<20240227180619.7e908ac4@kernel.org>
	<Zd7rRTSSLO9-DM2t@nanopsycho>
	<20240228090604.66c17088@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 09:06:04 -0800 Jakub Kicinski wrote:
> > >Yes, looks RDMA-centric. RDMA being infamously bonding-challenged.    
> > 
> > Not really. It's just needed to consider all usecases, not only netdev.  
> 
> All use cases or lowest common denominator, depends on priorities.

To be clear, I'm not trying to shut down this proposal, I think both
have disadvantages. This one is better for RDMA and iperf, the explicit
netdevs are better for more advanced TCP apps. All I want is clear docs
so users are not confused, and vendors don't diverge pointlessly.

