Return-Path: <netdev+bounces-131329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D33298E182
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 19:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881301C21E52
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5929D1D14EE;
	Wed,  2 Oct 2024 17:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzEnYJ9C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306291C9B91;
	Wed,  2 Oct 2024 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727889449; cv=none; b=NV6Vz/wvbTHk3Wm5AyqVircuEJ9wslbwktwSV49OX+1x6wYo2GfwYFe2X/qBUqYjVyYWXQVAIvncHbg/013AEZwjvNsyIp2YwhgOLy9hLwT1H5dqQ3N9MgCnXbq5vpJjU+UfquDUifc7xAqKLvy6mJrfx2kFJgzeYShp3Y65I6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727889449; c=relaxed/simple;
	bh=pfIEXJMb4PrK/x6Ayj1gPI5EQfPIRYz2z5v24LdJmEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAt78LLjBk3qRfU7ikCf7Lgk6ECFWs0J62QHvO0GTBNZAKXL6NEasDJwi3KJQWMAIJDGHlAicZeoXrEX5AHuK9NGRjTNeIyHXrHKjPw3XidKP1M7EVqQKAqKH+5Db1TRqEiQ6EEb9I91BBXNxyXzfux5XnPJqMsXgwSjLu/5TJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzEnYJ9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576E4C4CEC2;
	Wed,  2 Oct 2024 17:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727889448;
	bh=pfIEXJMb4PrK/x6Ayj1gPI5EQfPIRYz2z5v24LdJmEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qzEnYJ9CkvJ8iZ4ixy2eyCWweBM9CPz5GeO+p2AgtBUNPETZ6/3NISG/9dC2KI1OY
	 UtwAOkVXxti8ogfSILyF16Jvf/ToKHgA1de0pg7voPLqDgeSkeG77c9u1oVjLXJAk1
	 DsE2bEBwdFm1/EAo7jhlT/fjOT54ScBLPcmr/RIM0QGWOb2LYpNYLE1lFpV6nBxTAf
	 nv3gBJiehRQNktWr9HRujEXZiH4Tbq3hPaDt9Z2kdwSWcMtVkmQeg7/ngel3QRVNxG
	 F6rGxf6gNyw0cVBru74re6uWB2oBF5dHk9+RNEyIN4zzuY6UvONcoOoRf2fbquNsX5
	 J7Ud/KXCYedCQ==
Date: Wed, 2 Oct 2024 10:17:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "moderated
 list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list
 <linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 1/1] idpf: Don't hard code napi_struct size
Message-ID: <20241002101727.349fc146@kernel.org>
In-Reply-To: <ZvwK1PnvREjf_wvK@LQ3V64L9R2>
References: <20240925180017.82891-1-jdamato@fastly.com>
	<20240925180017.82891-2-jdamato@fastly.com>
	<6a440baa-fd9b-4d00-a15e-1cdbfce52168@intel.com>
	<c32620a8-2497-432a-8958-b9b59b769498@intel.com>
	<9f86b27c-8d5c-4df9-8d8c-91edb01b0b79@intel.com>
	<Zvsjitl-SANM81Mk@LQ3V64L9R2>
	<a2d7ef07-a3a8-4427-857f-3477eb48af11@intel.com>
	<ZvwK1PnvREjf_wvK@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Oct 2024 07:44:36 -0700 Joe Damato wrote:
> > But if you change any core API, let's say rename a field used in several
> > drivers, you anyway need to adjust the affected drivers.  
> 
> Sorry, but that's a totally different argument.
> 
> There are obvious cases where touching certain parts of core would
> require changes to drivers, yes. I agree on that if I change an API
> or a struct field name, or remove an enum, then this affects drivers
> which must be updated.

+1

I fully agree with Joe. Drivers asserting the size of core structures
is both undue burden on core changes and pointless.
The former is subjective, as for the latter: most core structures 
will contain cold / slow path data, usually at the end. If you care
about performance of anything that follows a core struct you need
to align the next field yourself.

IDK how you want to fit this into your magic macros but complex
nested types should be neither ro, rw nor cold. They are separate.

