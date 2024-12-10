Return-Path: <netdev+bounces-150778-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E83B9EB874
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C9C0282AF4
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353998634E;
	Tue, 10 Dec 2024 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Oxxuf5T3"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2012823ED70
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733852518; cv=none; b=f45BtuuZpTXaVOLT6AcI3OSJM9DfgHusHcK6hcTuxcWe1zMjVWR69X70qJ0b2Czccylzj5quPjZjMZJ+vVKPqB2GqW9BX8hXGVQEzn177pbL8j4oVAqmnrPzX1rr6xWYkBHcU0w1O9SUIbnVIMwXsWBxtHJVAKZN4buQRQGFbhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733852518; c=relaxed/simple;
	bh=HGzlTUcRfqo3akji3LmGL8TFcVwAG4vKl4cD96cfgeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDYaV8i1K9+Dmg4k/n03B8lWG66s/6OymM1aSM7EF7YQUDmC9+B0TtwpxN+RiF8X3BMVVc3WimnbN6KFOLOlrIvI7pD9t5UBYFzGc8MG68ZAdfF5KyeyGk8L5sGZzX+3bPTlSztCeknMb8fSj5WR5mp2HY/c5TwZL+43CTk+JCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Oxxuf5T3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v8sswIeR7WLlL99lHHZhBGKJRY0alIr0GombMFQeTpc=; b=Oxxuf5T34IADkig6GXf3HA0aV5
	2K6E3Xymr/GdN2ap1Yst7HNK22D+KpBVacG5Ya5L5XYEb2qIy83fjZtZIA+aMikVZGKv8eyV9nRUz
	1P7MuTHHjnJLNI0oKQAoG1g65xYhK8nng66qGlXDqf3bEhDWOE6gIexCsShy8o/gUzQs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tL4Ew-00Fprg-Op; Tue, 10 Dec 2024 18:41:42 +0100
Date: Tue, 10 Dec 2024 18:41:42 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@jo-so.de>
Cc: Christian Eggers <ceggers@arri.de>, netdev@vger.kernel.org
Subject: Re: KSZ8795 not detected at start to boot from NFS
Message-ID: <f52b2e7d-e4dc-4afd-8a7f-eaa2d4586fb9@lunn.ch>
References: <ojegz5rmcjavsi7rnpkhunyu2mgikibugaffvj24vomvan3jqx@5v6fyz32wqoz>
 <a578b29f-53f0-4e33-91a4-3932fa759cd1@lunn.ch>
 <phab74r5xxbufhe6llruqa3tgkxzalytgzqrko4o2bg2xzizjv@apha3we342xn>
 <7080052.9J7NaK4W3v@n9w6sw14>
 <zhuujdhxrquhi4u6n25rryx3yw3lm2ceuijcwjmnrr4awt4ys4@53wh2fqxnd6w>
 <njdcvcha6n3chy2ldrf2ghnj5brgqxqujrk4trp5wyo6jvpo6c@b3qdubsvg6ko>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <njdcvcha6n3chy2ldrf2ghnj5brgqxqujrk4trp5wyo6jvpo6c@b3qdubsvg6ko>

> So I think it's a timing problem: the ksz8795 isn't ready after the SPI
> reset, when the chip ID gets read, and this causes the probing to stop.

Is there anything in the datasheet about reset timing? 

	Andrew


