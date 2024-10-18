Return-Path: <netdev+bounces-137078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A90409A4469
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 416F1B22D67
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 17:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48690204003;
	Fri, 18 Oct 2024 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YtoGiWOm"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A50F204002;
	Fri, 18 Oct 2024 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729271655; cv=none; b=k6W8JHGFmqFLLkOnbcNft3969jgjfrhpn6g7muNabygqrJ9Fm+D7EjwnhoncahOJyf8cHyj4rQjHuGFjhfITVn0GXc8eP3FEwtnwnce+kWJCEJJcp19memGLw44MUr0ncR+c/AyMZJKdSxkOLcumouwGXgqIsZ0HoS4nhrVehFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729271655; c=relaxed/simple;
	bh=Rb/zOVDyIufcFg3V2qJ8JCkQEb5txVSge8B5tXhpTQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FC0E+lRK8naBKTozmTWQVjgEehHnqH7cqcbAEpjfONFbPSqBVptXk0I3cvFJVh9xJVpWc2/rORwqDVkQbEar2R8XoCbG17c8bQ4+lo4c7j7A1Avp0xXsiV+4DQFTdSq9yvfyImfEsDN/UlnxeOcSv37zj4xcSNCah/q5IXKVUqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YtoGiWOm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dnzmNPsfCG+MEos/kOYI5FnhFvSIGbrGPI9SNgz0LE4=; b=YtoGiWOmuq1uvYSprF4i1P92yg
	X8MxNzddrenXdaln44rRs47wggzTy+X4NU+Y7aYLbb2Qa4j+Gnbv3B+pGlThXBFCJ2FY4H4ap38v9
	hD6z7rKrzX1azGIFzoduj5lVbW1YPxAzlrSdn71kmML3HfbOFRsBUBlzuLYTRLSwYBos=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t1qYB-00AYLR-Eo; Fri, 18 Oct 2024 19:14:07 +0200
Date: Fri, 18 Oct 2024 19:14:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Paul Davey <paul.davey@alliedtelesis.co.nz>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: marvell: Add mdix status reporting
Message-ID: <ec97afdf-89d5-403f-b55e-3ada3cc05d07@lunn.ch>
References: <20241017015026.255224-1-paul.davey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017015026.255224-1-paul.davey@alliedtelesis.co.nz>

On Thu, Oct 17, 2024 at 02:50:25PM +1300, Paul Davey wrote:
> Report MDI-X resolved state after link up.
> 
> Tested on Linkstreet 88E6193X internal PHYs.
> 
> Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

