Return-Path: <netdev+bounces-152318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734159F36E6
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F54616EB88
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B1207641;
	Mon, 16 Dec 2024 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="ey42xlTe"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B801CEAD8;
	Mon, 16 Dec 2024 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368213; cv=none; b=M0IBoJ/IDwll4l8QJGDbVKYFhRXBt7LXVVNarbziAtRgLeM/PEbL6q+KQQOUXTOVhes3Nq1Ey51r9TfxNth+3PkiJterP0XA9yPiuor2GW2e/n3WGfCj7HCkeP+BqBAYs9C/yC4MqhMxWTq65FGbu3Gf/YgUoO1q+F0F6uQww2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368213; c=relaxed/simple;
	bh=99jUtqNZPFlgP9O2E9iIbyQppB2GC16vKTnn7VuC9qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av35zfs7OUzu3SKpG66EObjEz2GEwHzSzR0aEGjMc4IQUeH3gfWuwW5R63cud1XWeDLjYGBDZtrEv5P6mKF3lm0ygZgtcv7cMqwf9Vr5Jb+vb567Za+IIuS1TbhkpR1sHLxWvlmgq/KL7S+2tpUiOwbgvlW6YXK1uLUEakP2Z1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=ey42xlTe; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=m1Sgsvg30lO0ZBuoFRCva6n5RXpXVTLhOLjnkVbtOmc=; b=ey42xlTewX0tcnAy
	V6Ou37XbQyU0/rnWSkdVSfsSLJxKuKouYDFNXrPT5+KTUMkpTftANI4ylrBEVb7GqaXQTnwQNMxm2
	xLs1VuMUEsU/d4ray9VtiJ6KFJ2daSDr0bKzArHfa5kIq/ClCoVHUYICAp0azS5+L8ceDBC8OoSp0
	9m8gqRWcO3esckBlwgdBRhQc1/694+V3VfwKV/8DziAceOsNRqaj0bYq5Vc90Wa/4bwwb619yxJdD
	IiZWQ+5sCUhfqNKcewtleSB6PmfB20w1qV/Py9GhIKewad7WQhtABHgz8xufSahbXcDsiXjd2fwGn
	9frrdUQnDdfMRlBohA==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tNEOk-005fN9-0w;
	Mon, 16 Dec 2024 16:56:46 +0000
Date: Mon, 16 Dec 2024 16:56:46 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Simon Horman <horms@kernel.org>
Cc: jes@trained-monkey.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] hippi: Remove unused hippi_neigh_setup_dev
Message-ID: <Z2Bbzm7rATuaMypf@gallifrey>
References: <20241215022618.181756-1-linux@treblig.org>
 <Z14-sYvgzEPZSTyR@gallifrey>
 <20241216161401.GG780307@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20241216161401.GG780307@kernel.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 16:56:16 up 222 days,  4:10,  1 user,  load average: 0.04, 0.02,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Simon Horman (horms@kernel.org) wrote:
> On Sun, Dec 15, 2024 at 02:28:01AM +0000, Dr. David Alan Gilbert wrote:
> > Note the hippi list address bounces:
> > 
> > <linux-hippi@sunsite.dk>:
> > Sorry, no mailbox here by that name. (#5.1.1)
> 
> I suggest submitting a patch to MAINTAINERS to drop the that ML from there.
> In general, patches for MAINTAINERS can be targeted at net.

Thanks,

Just sent, see 20241216165605.63700-1-linux@treblig.org

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

