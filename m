Return-Path: <netdev+bounces-246874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF354CF20E5
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 07:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03D0E30011A6
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 06:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2A629D27E;
	Mon,  5 Jan 2026 06:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JllL/YNg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4898A3A1E74
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767594207; cv=none; b=MA/Vnf1F6bHT/rdB+Qyyd0ls4DpJgIatEGkk2mBddDZOgWiwSNmqcF1EhKeAoqMxOeyUKbXnowEBGQ9xNoSh2yaz7ISdBNR6GBKRVItGB9BKo7eCzrUyklfK6Ud3PkmPH0CjlGdctuwjFNpaqvIbW353dvxETscgYpcPEM0Fr5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767594207; c=relaxed/simple;
	bh=CfhvDe+i2+DYvMrRDEilAe/YmobBzpxJvmNEmIuKW6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uq3G3JAwOraQSggXx1H3YJzwyfHRlXWwpbzfpftSj0FNnd8mPlWs0AzMQhGsHDaiSKd8krsFdvP0XpCd+EGqOiodRqttSK5BBGsGLzSnyOb4iZQWyPwTyopW8nedF8zWB4UuOYrrLJRWHWERDpIGyWib09/lejC/N04IZyjMWGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JllL/YNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35122C116D0;
	Mon,  5 Jan 2026 06:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767594206;
	bh=CfhvDe+i2+DYvMrRDEilAe/YmobBzpxJvmNEmIuKW6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JllL/YNgVuVwhStwpEpv4PoGAs2vQaGdiitycutzK0nTIyoph+nHGmufy9k5vO7nb
	 AaCICzp5yfi9F3erIeWbOWL9rRy+qK5YWqwZNruQ7VkNc90JmkIbX3kwlA8T915fY6
	 RLtGfGESRCP5Px0f/iFj5BZR88anHvCBJxQfRnNc=
Date: Mon, 5 Jan 2026 07:23:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yunshui Jiang <jiangyunshui@kylinos.cn>
Cc: arvid.brodin@alten.se, netdev@vger.kernel.org, sashal@kernel.org,
	syzkaller@googlegroups.com, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2] net: hsr: avoid possible NULL deref in skb_clone()
Message-ID: <2026010511-wrist-squiggly-afad@gregkh>
References: <2026010424-calcium-flavoring-6fb6@gregkh>
 <20260105023936.3910886-1-jiangyunshui@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105023936.3910886-1-jiangyunshui@kylinos.cn>

On Mon, Jan 05, 2026 at 10:39:36AM +0800, Yunshui Jiang wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> commit d8b57135fd9f ("net: hsr: avoid possible NULL deref in
> skb_clone()")

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

