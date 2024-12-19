Return-Path: <netdev+bounces-153449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC59F8047
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 17:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2A2188AC6A
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6746419CCFC;
	Thu, 19 Dec 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="50P/JSMN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B266019AA56
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734626780; cv=none; b=VBrIEUY3BUNK/ZfsN584x4dEKbZKL1nlEQQBqjq6Y/Cw180jgB7Dlm+WjwSbwDyx5QG8LSntwuTd/UfYRWwEep328TKXnyp0QeiHupKoweR/wrQ8nI4dGRYICe9Thhj16ZoVIPbqhSCqo7LRyc5N4jkEtLikdi6QkcaZAnFMNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734626780; c=relaxed/simple;
	bh=HiFfq2UgQnIpNH9x+WZlhxmDnYm50xfDgvdnhgDWMcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIIVlHQ83UaZTFZnpbhdmKxgl9T1lvSD5H4bPpjueQ5K3xYImWsnjx+W+sxacjAj7ONDoFVhZxjkFqcxq+Gph74ZhNb7CTm7jR9fLyvmRMIZcB1N/+Lc+VsQQtpP/lUfMzX+F+8ojwp7BMp3d7nfZ/QAGeuARa37faqRHa0OA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=50P/JSMN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=DRX58ZnfKce86ulD6mf7wguouhZ5KFYp5m/qoq0YuIg=; b=50P/JSMNthnTCpoL+L7qRZ/6jD
	khZ7JXDTyyovvW3P3AnO6nG2DuSW2oSyo2Py0LUJ3KJ/GqBEVza8hzyXgg/CN1e7ohIzfOimJiYkb
	KpuoQKH2bafENXpO2tQUZqN8xE+LFE4KZpYV3KFY5JT+Ul9iryh5K8dpo/wgJohV8cuY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tOJf9-001gWr-IV; Thu, 19 Dec 2024 17:46:11 +0100
Date: Thu, 19 Dec 2024 17:46:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: hfdevel@gmx.net
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 7/7] net: tn40xx: add pci-id of the
 aqr105-based Tehuti TN4010 cards
Message-ID: <608fdd15-d3e4-4b3a-8326-11ca694d0d1e@lunn.ch>
References: <20241217-tn9510-v3a-v3-0-4d5ef6f686e0@gmx.net>
 <20241217-tn9510-v3a-v3-7-4d5ef6f686e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217-tn9510-v3a-v3-7-4d5ef6f686e0@gmx.net>

On Tue, Dec 17, 2024 at 10:07:38PM +0100, Hans-Frieder Vogt via B4 Relay wrote:
> From: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> Add the PCI-ID of the AQR105-based Tehuti TN4010 cards to allow loading
> of the tn40xx driver on these cards. Here, I chose the detailed definition
> with the subvendor ID similar to the QT2025 cards with the PCI-ID
> TEHUTI:0x4022, because there is a card with an AQ2104 hiding amongst the
> AQR105 cards, and they all come with the same PCI-ID (TEHUTI:0x4025). But
> the AQ2104 is currently not supported.
> 
> Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

