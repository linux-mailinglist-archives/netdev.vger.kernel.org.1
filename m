Return-Path: <netdev+bounces-140450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24C9B6860
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CCE81C213F4
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 15:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AFA213EF6;
	Wed, 30 Oct 2024 15:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="FdfWQI/V"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7269213ED7;
	Wed, 30 Oct 2024 15:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730303465; cv=none; b=RcRQ4A3NhA+x8xQJYlh/6RY0kzjM+diorVm3lVVbAns6P+wSCG19B4KMNWVOuQ6GIlhdZqrPxgE5gHyjRyrsdP+vfmUUAZsBgmnej/OxnAyzYZqWtXPT0xqQh/cJ0wRnyNB7ZLAlsl6XExkbSOTVxsyFUIQFk/AmKblq58YHNS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730303465; c=relaxed/simple;
	bh=9j0EOCeXEWPkrKUDypXUWyLhMwlORH9QQ1nLN8JaxqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RStsqAZMU7Ft2C0wKQJu3fpkCcgCXShVHJFCRjfiul+fDng/krpkBk0z+hqmAAWIlJINXOTnRcDudTkwYek6NF9vrJAjQ0ssY0G3Dnyhsc0X//5vbcy+zbY8NFpMx7aOM6RQywkTcFy5BptoZMsDG4GYq5oPBSPPLwIxr0HfK5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=FdfWQI/V; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3LW9S+kfgV9WToxDcfqLzsE6TKXgvYNxYMz5zw4Bzj4=; b=FdfWQI/VwWMIw8JzThIClefzXB
	yFoM5zNQsBJ0ve3yDbpmakasyfsk243aX3fpKpghkruycThYFstEubGGEXy7piW5q08P8Bv378JKz
	hAQjNtar9QluvvLuICXTfurpjWq3PutDhxy1ojiOgCSpuftAR8BmsfNupBOdkUveL0x8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t6AyL-00Bhpk-Mm; Wed, 30 Oct 2024 16:51:01 +0100
Date: Wed, 30 Oct 2024 16:51:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: Remove self from DSA entry
Message-ID: <cf0f7e38-ec7e-46db-8faa-213173ea49d4@lunn.ch>
References: <20241029003659.3853796-1-f.fainelli@gmail.com>
 <20241029104946.epsq2sw54ahkvv26@skbuf>
 <20241029003659.3853796-1-f.fainelli@gmail.com>
 <20241029104946.epsq2sw54ahkvv26@skbuf>
 <d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>
 <d7bc3c5f-2788-4878-b6cc-69657607a34c@gmail.com>
 <20241030145318.uoixalp5ty7jv45z@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030145318.uoixalp5ty7jv45z@skbuf>

> I kinda wish there was a way for people to get recognition for their work
> in CREDITS even if they don't disappear completely from the picture.
> Hmm, looking at that file, I do recognize some familiar names who are still
> active in other areas: Geert Uytterhoeven, Arnd Bergmann, Marc Zyngier...
> Would you be interested in getting moved there? At least I believe that
> your contribution is significant enough to deserve that.

+1

	Andrew

