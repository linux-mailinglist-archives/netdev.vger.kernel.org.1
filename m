Return-Path: <netdev+bounces-63743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2FB82F226
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 17:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839581C2297B
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 16:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403081C693;
	Tue, 16 Jan 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="BIRPdy0K"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8731C687;
	Tue, 16 Jan 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ozrR6mvaMcGjsAqplzlM0RuDR6tbFj8/N3MLRkpuxHM=; b=BIRPdy0KhzeQeHDjIFgvNfHQ0b
	tNylCHN372yU62m/aerFlrtG0Oh3JoRv7/hgDFq8dQooa3CEw8R6YthJzazqQxiTEcjfE6s8dKlXt
	89LFVwsx4NGyPzW4HOigEZ52HJuuiOcXECvOs4h3ohmGFBmsseP5wJ7WnaoA7Hrq3BeI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rPm1H-005KRw-Pl; Tue, 16 Jan 2024 17:10:31 +0100
Date: Tue, 16 Jan 2024 17:10:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Jan 16th
Message-ID: <52a1f5ed-37d0-431b-8faf-b2e5bbb659f7@lunn.ch>
References: <20240115175440.09839b84@kernel.org>
 <Zaaek6U6DnVUk5OM@C02YVCJELVCG>
 <65a6a0cf8a810_41466208c2@john.notmuch>
 <ZaapI9zDaP1YI7AA@C02YVCJELVCG>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaapI9zDaP1YI7AA@C02YVCJELVCG>

> Thanks, John.
> 
> This one is a bit odd what happened is that by the time this problem was
> reported (on an older kernel), the code changed out from underneath.

Hi Andy

Talk to Florian

He has dealt with Fixes like this in the past. It generally works out
fine so long as you are explicit about what is going on, in comments
under the ---. That, plus correctly marking what kernel version the
patch is for.

    Andrew

