Return-Path: <netdev+bounces-167136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34B7A3900A
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 01:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4F191671C8
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F52D101DE;
	Tue, 18 Feb 2025 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuiDvwTj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9EBEACD
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739839489; cv=none; b=I+ZxVkaTHC1Qx72rT3AS0T/8yWSSKkNBIiFslGm5vo/+wEApXuLKx9S8WhsVDCy+i3wPjYs09kdHVOFUr4551eXtwRaxfiS5yRGX5U7+JhnhOCWQf3EXTL6z5omrKzPh50NDRyg2JdvpK/Tx2vd1300S3toOWWCRK7YShp0DkvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739839489; c=relaxed/simple;
	bh=d5gMm+73ESgLpUTuIkZkZCJNPJKXQm2O4OvKJGgu6Sk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ngYDRRzmo0MtTBmN8erx14Dxhq5BvlGMNI0XCUA+cqxfnOfyKapkZEaQ/utDYrBXCErvwBMHE6wOIHbqwi8UNL+wpdq1S3eIqI9SVjdk3H+a3rWZzVZIQ77EsnNqWPpgjOWOXiptf5f8bY4QGteIvEZaDyBpNpDoI2OFuAVvVFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuiDvwTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503CBC4CED1;
	Tue, 18 Feb 2025 00:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739839488;
	bh=d5gMm+73ESgLpUTuIkZkZCJNPJKXQm2O4OvKJGgu6Sk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JuiDvwTjItskxKWuvkAxDGrJ8ksyf6I9NlpYbUzyOg3YsS2fhSOxTiNUV7PrZDh+e
	 VGkUDrU9FBEu7DO9F+5Y5sRBcAvtz5bDG241HCb9rrWmqil4O6XYnNSQJKeotq8oZ+
	 PeokxHor3zSze/zjtUQKkuVtTf3LTlS+Zuxye08a4jSzpbtC+elN4eEYkaIXs+BfZv
	 Dq/x8wDap4QUDjCcKIrpaiXg0T7kgnRhSqU4BwbdLrFWqaI6LhJuTc89tkTKssflZL
	 8KrMLfcP4Yd1CsidQE/acwi4W5BKgnoR/dWp2bzF3A+UrIhSduMmW13IjBwrYbekyD
	 ICzmxTPk+ovsg==
Date: Mon, 17 Feb 2025 16:44:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux
 <linux@armlinux.org.uk>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: phy: realtek: add helper
 RTL822X_VND2_C22_REG
Message-ID: <20250217164447.4d59e75c@kernel.org>
In-Reply-To: <6344277b-c5c7-449b-ac89-d5425306ca76@gmail.com>
References: <6344277b-c5c7-449b-ac89-d5425306ca76@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 21:31:14 +0100 Heiner Kallweit wrote:
> -#define RTL822X_VND2_GANLPAR				0xa414
> +#define	RTL822X_VND2_C22_REG(reg)		(0xa400 + 2 * (reg))

Just to double check - is the tab between define and RTL intentional?

