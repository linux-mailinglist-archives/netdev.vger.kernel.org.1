Return-Path: <netdev+bounces-145817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1BC9D1088
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 13:24:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17C85B2191D
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 12:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB271990DD;
	Mon, 18 Nov 2024 12:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="VG3sfCYI"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2C413A86A;
	Mon, 18 Nov 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932637; cv=none; b=KCYTVVBJgk5Mktuyv7z3EN3/D/+NI5Z1Q/bkNCmhO8V4LpmLaXMU6UX7no5E1jAGQvpEiBCQUYrdG3ZbazTgT3hlIdBqHWrouJAIXD9c6YbJjEDpbSN1TzUPTcKuK7bm1lxqQuueuj/m/bnVc4Me01ExtmbFgne8C7o4+DRB89M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932637; c=relaxed/simple;
	bh=1925CAMl6ww1kQwErMsKwYZ82VqKocAWcceGDxp/DLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHWGx1ok+pR0c2aV3xpa+CiVStex2ouaALKOEwC/TzIiJ1kVlSJGn+hkvwMtqNT5J+WO+x3WKz32c7OXxc7aqG38gnmolLoKbVkm4nzJi0KRNpoCuq8YVU8lPIjS2SKIRrscRZYlFjqvAYLlTPxFrAT+T7UgY45khjzAB17im5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=VG3sfCYI; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=/a9kIL9Fe5oBYm4P3Imhxgji5kdM4wV5QzGKEXGXG8k=; b=VG3sfCYIhDsLz9F0
	qKQHGiPsafPr+sDUmCBBWFB9IKENrr9iUAqLFPAdBSbZbXQoFZUiT/thQFNOZVVJ5bNCOawVrczax
	pPzkWH82XQTS6PARQenKkds1wjql5w5Qr3u1UEQz5JNWmrwobIz4kY7gp1eA+TIjEnQASQ1xtN1OG
	Q/He996AobiD2g17efoWJ6I61zHfs7vbGn4wsvv8oix6nVdu50tjH++g5DO+r7ZhNntKZh04sRJZy
	1MBLYMjbxpUSDzGlERFDFuCAQmBtqf9ePy7FcwZXOFCJoCCas8I5uscglm/25m505iA749QweNw8C
	zwM9KzBHNuCdU4D5qw==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tD0mz-000UEW-0d;
	Mon, 18 Nov 2024 12:23:33 +0000
Date: Mon, 18 Nov 2024 12:23:33 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] intel/fm10k: Remove unused
 fm10k_iov_msg_mac_vlan_pf
Message-ID: <ZzsxxXpzA5PByiIx@gallifrey>
References: <20241116152433.96262-1-linux@treblig.org>
 <e8c5b0ad-19aa-44b1-9b08-3929990e81c1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e8c5b0ad-19aa-44b1-9b08-3929990e81c1@intel.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:23:01 up 193 days, 23:37,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Przemek Kitszel (przemyslaw.kitszel@intel.com) wrote:
> On 11/16/24 16:24, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > fm10k_iov_msg_mac_vlan_pf() has been unused since 2017's
> > commit 1f5c27e52857 ("fm10k: use the MAC/VLAN queue for VF<->PF MAC/VLAN
> > requests")
> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> makes sense, and all constants in the removed code seem to be used
> elsewhere, so:
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thanks

> for you future Intel-Ethernet-only changes it would be better to
> target as [iwl-next] or [iwl-net],
> no need to repost just fro that

Ah OK; so are you going to pick this one up via iwl?

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

