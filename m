Return-Path: <netdev+bounces-149850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D42C19E7B3E
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 22:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF9CB1699E8
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 21:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0236F1BC07E;
	Fri,  6 Dec 2024 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="svliQk4G"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D622C6C3
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 21:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733522325; cv=none; b=XpwdCmJPxp6L2eT1w6Ge/aroWq1xN6drCkhqWDxbNtJtadu8SsUacDmf/y/vB+UUNN0crmKSLTN3k8/SKMloHg6/oTFp7p4aY2rOJ2ULphpumZ3X0pxqTCLt2m6A/dhZAgVUhg0N0MVwm7PMOV3CMzcYBd0trL8R4+Ktn45ntzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733522325; c=relaxed/simple;
	bh=HxL+E9E6H5Gn5ihifTKDBnuethTNOpVvgpFfZZTdCbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hC9PvaPSqezh1oNQWulaR3Z3khhe/nVqiG8nbKsQKEFG6wIE6Jsgh/QIhtYfPClDQT0XrRWSyn7XsyMWdWkyrqW1DhY85tvgp6OvWC6mjsUpaO5EzTeHg1dHWAmaZB+FRNVU1X97DGS1gjoRkNClduIhshuKhmkshC8JAK5oVy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=svliQk4G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FtoqhrP5Nno3DaeiM+ydadQnDrbO93dsLmqOBgSx86M=; b=svliQk4G/zd7/B9em/ve4K2HKv
	gJ+r4b038pUffioeNaceLmbtVLGH1HOmdeCQQKScBleZdbHqy6K/7vvKecbUvvUEyBYa/qJhYw9j9
	y9T3DDHPEI2uF1ULhYWST2qqglTJQXCgTqntzVF/1lUQvzupgLfXctP850ZqPOUqlhPU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tJgLO-00FSMj-Cb; Fri, 06 Dec 2024 22:58:38 +0100
Date: Fri, 6 Dec 2024 22:58:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jesse Van Gavere <jesseevg@gmail.com>
Cc: netdev@vger.kernel.org, woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Jesse Van Gavere <jesse.vangavere@scioteq.com>
Subject: Re: [PATCH net-next v3] net: dsa: microchip: Make MDIO bus name
 unique
Message-ID: <b369b789-1515-41bf-af71-3ef48cfd2e06@lunn.ch>
References: <20241206204202.649912-1-jesse.vangavere@scioteq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206204202.649912-1-jesse.vangavere@scioteq.com>

On Fri, Dec 06, 2024 at 09:42:02PM +0100, Jesse Van Gavere wrote:
> In configurations with 2 or more DSA clusters it will fail to allocate
> unique MDIO bus names as only the switch ID is used, fix this by using
> a combination of the tree ID and switch ID when needed
> 
> Signed-off-by: Jesse Van Gavere <jesse.vangavere@scioteq.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

