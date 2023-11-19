Return-Path: <netdev+bounces-49033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7487F0751
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 17:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1A1C1F21843
	for <lists+netdev@lfdr.de>; Sun, 19 Nov 2023 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15EB13FF1;
	Sun, 19 Nov 2023 16:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wiv31T6A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCC2115;
	Sun, 19 Nov 2023 08:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PqNhOHVUB0q9RpdnJQBOzBuTWvuux3ZuN7ljk9fyTT0=; b=wiv31T6A2ILuj9mkka+/EopnqN
	DogKvvni8xh2OnKytcwm08LvRVlRPh1u/5oCtBDj4f6U4HlX4M1vnkPjfzo9b9aWw7QGh5pDiIhM6
	kEKg32RbF4Pp845l/zcN2rjOWA5OzOnzTpKzt8gUwAi0WyoJWCcAC5jmOTa9W8n+Hcsw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4kLN-000ZTH-Gn; Sun, 19 Nov 2023 17:08:21 +0100
Date: Sun, 19 Nov 2023 17:08:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: aliceryhl@google.com, benno.lossin@proton.me,
	miguel.ojeda.sandonis@gmail.com, netdev@vger.kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH net-next v7 1/5] rust: core abstractions for network PHY
 drivers
Message-ID: <dc65b6f9-66ae-4a51-bbfc-bd7af90789ed@lunn.ch>
References: <20231026001050.1720612-2-fujita.tomonori@gmail.com>
 <20231117093906.2514808-1-aliceryhl@google.com>
 <20231119.225114.390963370394344723.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119.225114.390963370394344723.fujita.tomonori@gmail.com>

> I don't intend to make them separate lines. If I make thme one line,
> it's too long (over 100) so I made them two lines.

Any networking prefers 80 anyway, so shorter is better.

    Andrew

