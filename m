Return-Path: <netdev+bounces-262978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOF9Its5pmnQMgAAu9opvQ
	(envelope-from <netdev+bounces-262978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:31:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D041E7B22
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 02:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 444803012B75
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 01:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B33136B062;
	Tue,  3 Mar 2026 01:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TF5B/smj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DF3603C3;
	Tue,  3 Mar 2026 01:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772501465; cv=none; b=e7WamQ3BnDb5OjW65h2CBZWm9BfVRtaa1NdmANlxpY6zHI3y1VpbAIr9mZweu9H33UpZbDbY9n2F/TFB994AOv8cW1HFdwIK2jzTqCVQqZxqoO73o5t208yyKnNyTaGPfbyJo858vMFv5BNWDt7lyQvJrO5wnkCdVIbebprlKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772501465; c=relaxed/simple;
	bh=4YJ21+u9iaHR/3fliCDM5sQsRGumRp1QiMPhtK95E8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBUwYZ3X1qNinBIIMA+ZSzTdETGKNNs+vdzrtfYvByn1P4Zkt9RUg65qFHucCbqbelQzK2UJvbmwNiRk5Gpj5bLHzdIZ8jA+nvp7HY1WDsxdTrx6OB4vJnUJM/5Kyamzs+FQd+Y7vDkcqjjQRY8Uu3iqehockj0FLip/sqL/66w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TF5B/smj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HUKL9Y5s8qQvy223sWGjb++3da04HXQ26Z6GEuwMerc=; b=TF5B/smjiLlQUtcGCfFsFPta+Q
	1ont1wMORchdXMOo5dHeQKh92q1h4bXTT8IichY2T2BiPzhYhKw9xqEvdkPCBG6A50bik8lgs2ZTZ
	b0F8FKG1cnbzD68qMusKDyL+TXyi/JRRIkyxbRJ/c5cUfoXXONa7rrnAkTQctM7hqLR8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxEar-009mO2-I2; Tue, 03 Mar 2026 02:30:37 +0100
Date: Tue, 3 Mar 2026 02:30:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, taoren@meta.com
Subject: Re: [PATCH net-next v6 0/5] Add AST2600 RGMII delay into ftgmac100
Message-ID: <ef88bb50-9f2c-458d-a7e5-dc5ecb9c777a@lunn.ch>
References: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-rgmii_delay_2600-v6-0-68319a4c4110@aspeedtech.com>
X-Rspamd-Queue-Id: 25D041E7B22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262978-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 06:24:27PM +0800, Jacky Chou wrote:
> This patch series adds support for configuring RGMII internal delays for the
> Aspeed AST2600 FTGMAC100 Ethernet MACs.

I've been thinking about this some more. And i would like to propose a
completely different solution.

What we are trying to achieve is allowing the correct phy-mode to be
used in DT, rgmii-id. Being able to specify internal delays is nice to
have, but for most platforms should not be needed. It is only needed
for badly designed boards where the designer of the PCB did not take
care with the length of the traces.

Part of the problem is that the MAC driver is not actually
"broken". It does what we recommend, read the phy-mode value from DT,
and pass it to the PHY. The real issue is that the bootloader enabled
delays in the MAC, behind the MAC drivers back. Because the MAC driver
is not "broken", it is hard to "fix" the issue in the MAC driver.

So lets solve this in the bootloader. I suggest you patch the
bootloader to no longer enable the delays in the MAC. It also needs to
patch the DT blob. If the blob says "rgmii", change it to
"rgmii-id". u-boot should be able to do this.

That should give backwards compatibility:

* Existing DT blobs with old bootloader gain the delays in the MAC.

* Existing DT blobs with the new bootloader gain delays in the PHY.

* For new boards being added to Linux, we NACK them with "rgmii", tell
  the developer to upgrade the bootloader, and use the correct
  rgmii-id. This is a power we do have.

* Developers of existing .dts files can submit patches to replace
  "rgmii" with "rgmii-id" once they are happy all platforms have had
  their bootloader upgraded. That might be never, since developers are
  lazy, and we cannot force this on them.

	Andrew

