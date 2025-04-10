Return-Path: <netdev+bounces-181430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8CDA84F85
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 00:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8E339C31B1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 22:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D81220E002;
	Thu, 10 Apr 2025 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="iWtGPfuE";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="N7Sh10wG"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA0B1EDA39;
	Thu, 10 Apr 2025 22:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744323105; cv=pass; b=Xkuv7lMF7eJdUZ4yy8hJT32xiY7Yh99qBS9GNvMaTEbhLu/p9qbG/9ItJyqkpdRWczymNT2oXRZhfgNB2qt8HwCNnc/P3Bm6w1KHaIa/70Gfsc6kGbiLo89Qf8Vmwmc5bhTcC8Tw5dShA8QOFiif667gi+Vn4wnMIL2kNF180Pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744323105; c=relaxed/simple;
	bh=abs5dLAEmXI29j+o7/7/anWk/kwKgdKTZ20Xbem8iQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsIQls/akW1K95YfVJ+vxQuEzJ5wVFhG3HeHbJ/ZUQPWCExQayhfxYtWJ5FWQNzw2XTtKWtw6ck9KU+Wkm++yvq9LWrrA3x9Y+ZOMT7RHNNErgGN70bvUhH5uXHY9b4tMnf3A+wD7thpzfHcbUTbwwEtEN4ZifIGiEFdZRZPBIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=fossekall.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=iWtGPfuE; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=N7Sh10wG; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fossekall.de
ARC-Seal: i=1; a=rsa-sha256; t=1744322728; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QM8hPdqUOuUjCt+rrnwn41HvSYbR6bg57wAoCUSu00yqiBpp1yfXzyflpyXpEMXAQe
    faaUQ4zOqNxRE0EtXyATobr2yW9FQvjIcanqDdVJPzHrWkrl37TvNiXcEMbZxhlSzvno
    SnZ/J2IhV2Cn7hyA9zDDKOw1G2x8dwCgYD9qAcxpW/pRpBPQnZMb2KMF7VDaeKRvVdRI
    3SnXHSznmL5zb9U72ubQ/iytjXUJoh/vIDY8VynuTtWKdjcotPAmV3e3KZnjjUds3Afv
    ILYP7a39u8nrmT2+/WzB+X08J092cxoghEERMJlxMvfFvdfT/2okKdIw/vN+Phg7QWMU
    VWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744322728;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CMkoDCd3i8L7dymZvFc5LYevEboRrRWNS9VBeEdix4U=;
    b=M3tq/+LVcFqH0/jec7DuILHppdi8Kf43wkffmAUTr5N4exB6cq4v/ufLz5aOdpMC6X
    tM+Z6qOl9B6YrTYf4gJsPwQMTaGUChx9TYQatjpWQB6+AMR4vNQ0b2XgruFb6YS7CQR4
    heFeFl0JEnBTKcXAk8nsHNlxAKIXzzH4/hmdh4BeOsf9A0YgJlzvMbzmJbKLzYq6Mn0Q
    uB/Bz7TAymWXfO8ZktcWC6xHlpI4mSys4sAUb+lp3EPr+9ExZ/u0wSWVV6A+s0v49BNA
    aIwqU2C3Upmk0+nr8UANLelqa5HeSXk7E8Yfk+AB9x9bnjIA5SzKQ9Z8p7E2cme4Vzwg
    Sibg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744322728;
    s=strato-dkim-0002; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CMkoDCd3i8L7dymZvFc5LYevEboRrRWNS9VBeEdix4U=;
    b=iWtGPfuErZ+McSn5bjmAQVTNrW236s2kRjrqbk5A7T5GRHQyp8mbh1LjJJ7ngnfzG8
    QHMbOzuhts6dKaDiNONNcDXACxMUtpJL4PjeMO0cC56rks98TdTa7h1KqP9golJoGK+o
    sdDaK3okDPVRiW69uRq2eXc59HoJln3G3rOX0UGrNTmRpfdedz7awzRGAV2yT0rqUYDE
    3YA1m3pNhsPELnSeSr6IxFX/k2uJjX15p4GLniDLNUEC4rBoGqb7RssU4ig2noDYfk9Q
    XY/K9ey84NlWaf72W5WD0N/e6hPcME8EYDVTbzxr4netuDBq2WziqrhGP3Yb5H4BB9xH
    WLKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744322728;
    s=strato-dkim-0003; d=fossekall.de;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CMkoDCd3i8L7dymZvFc5LYevEboRrRWNS9VBeEdix4U=;
    b=N7Sh10wG9CRrx66F98lZpNwAex8pGWRPqdI/WVeapeJ42/BGKFjSyBQAdqqzlV9mke
    L4852dzFnWwi/uwjExDQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3513AM5SGRP
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 11 Apr 2025 00:05:28 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <michael@fossekall.de>)
	id 1u301W-0001KD-2D;
	Fri, 11 Apr 2025 00:05:26 +0200
Date: Fri, 11 Apr 2025 00:05:25 +0200
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Joe Damato <jdamato@fastly.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND net-next v5 1/4] net: phy: realtek: Group RTL82* macro
 definitions
Message-ID: <Z_hApRl14nSgwtCu@a98shuttle.de>
References: <20250407182155.14925-1-michael@fossekall.de>
 <20250407182155.14925-2-michael@fossekall.de>
 <Z_SPgqil9HFyU7Y6@LQ3V64L9R2>
 <96fcff68-6a96-49fe-b771-629d3bef03ea@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <96fcff68-6a96-49fe-b771-629d3bef03ea@lunn.ch>
Content-Transfer-Encoding: 7bit

On Tue, Apr 08, 2025 at 02:17:19PM +0200, Andrew Lunn wrote:
>On Mon, Apr 07, 2025 at 07:52:50PM -0700, Joe Damato wrote:
>> On Mon, Apr 07, 2025 at 08:21:40PM +0200, Michael Klein wrote:
>> >  #define RTL821x_PHYSR				0x11
>> >  #define RTL821x_PHYSR_DUPLEX			BIT(13)
>> >  #define RTL821x_PHYSR_SPEED			GENMASK(15, 14)
>> > @@ -31,6 +40,10 @@
>> >  #define RTL821x_EXT_PAGE_SELECT			0x1e
>> >  #define RTL821x_PAGE_SELECT			0x1f
>> >
>> > +#define RTL8211E_CTRL_DELAY			BIT(13)
>> > +#define RTL8211E_TX_DELAY			BIT(12)
>> > +#define RTL8211E_RX_DELAY			BIT(11)
>>
>> Maybe I'm reading this wrong but these don't seem sorted
>> lexicographically ?
>
>This i don't follow, you normally keep register bits next to the
>register. This is particularly important when the register bits don't
>have the register name embedded within it.

Well, there is no definition for the register these bits pertain to, 
and adding one in _this_ patch would break the scope of this change. So 
I will address this in a later patch of this series in the next version.

-- 
Michael

