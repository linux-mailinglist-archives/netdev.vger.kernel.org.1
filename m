Return-Path: <netdev+bounces-270312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gixmGmcEwGmSDAQAu9opvQ
	(envelope-from <netdev+bounces-270312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 16:01:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C162E9BC2
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 16:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6F82300E3B1
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 15:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE4F331A56;
	Sun, 22 Mar 2026 15:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iEN9aNnT"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC06195811;
	Sun, 22 Mar 2026 15:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774191714; cv=none; b=R8kNvk+ufaap/9Sh7BTkvCGx7SuKF8vVHKcsFf7ey6KDpPMt9+HpoSh/WwuvW4DuK62JEq97OmJP2fct3swNVYGIqn+OsjIj0eT7ThFerg39cHaQSFu/KKCBR6gFYD0NOPz8EGkyBNRwb3cdAu4M1xr+57bwz21MLklhS0e5m5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774191714; c=relaxed/simple;
	bh=H0tCRU4sKRGyRexS6MVvaQ7KD2nFF1rFJq52qRgvF4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVM42Rj+jNWmgITUTGiBCwz8GAoUYUFtGo+4BVAI/5aoU+5h8RG23IynceVtv5SnSofK1iD75EIIIEs9j1Q6hb872ogeqJwCNDOo8n8g9FF5r0JMr3Uy3n82I/Jw5X02o0xiuXv5M8FqPehb8qavWHVKwfwxNJpbdNydOtrtOGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iEN9aNnT; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EU9OnLKzYRo8qwcEvhx9hmAKyUXQqaFj2HbhTn37BzA=; b=iEN9aNnTxaAkgzRxw6XeVnYv9H
	T9U6tXBtGDgtluftso2ufFD0kiMeHwfQ9WNUo+N3Ejh/HKCd9+xiI5xCNobRIQYhTrCdsWw65x957
	QwlNglAGVMhnIft/PjN4QlxhulvjZuN0kdIhKURLOpwxxIXX2+1rM80mBO0t+QiOUloY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w4KJ7-00Cp8X-3E; Sun, 22 Mar 2026 16:01:37 +0100
Date: Sun, 22 Mar 2026 16:01:37 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Frank Wunderlich <frankwu@gmx.de>,
	Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Liang Xu <lxu@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	Jose Maria Verdu Munoz <jverdu@maxlinear.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mxl862xx: add CRC for MDIO
 communication
Message-ID: <dadf47ea-f4af-45bd-b80b-aa99dc69291c@lunn.ch>
References: <cover.1774185953.git.daniel@makrotopia.org>
 <620453b9a150bbe5b7ea4224331cb5dc5e57263b.1774185953.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <620453b9a150bbe5b7ea4224331cb5dc5e57263b.1774185953.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	TAGGED_FROM(0.00)[bounces-270312-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A1C162E9BC2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 01:27:20PM +0000, Daniel Golle wrote:
> Enable the firmware's opt-in CRC validation on the MDIO/MMD command
> interface to detect bit errors on the bus. The firmware bundles CRC-6
> and CRC-16 under a single enable flag, so both are implemented
> together.
> 
> CRC-6 protects the ctrl and len_ret command registers using a table-
> driven 3GPP algorithm. It is applied to every command exchange
> including SET_DATA/GET_DATA batch transfers. With CRC enabled, the
> firmware encodes its return value as a signed 11-bit integer within
> the CRC- protected register fields, replacing the previous 16-bit
> interpretation.
> 
> CRC-16 protects the data payload using the kernel's crc16() library.
> The driver appends a CRC-16 checksum to outgoing data and verifies the
> firmware-appended checksum on responses. The checksum is placed at the
> exact byte offset where the struct data ends, correctly handling
> packed structs with odd sizes by splitting the checksum across word
> boundaries. SET_DATA/GET_DATA sub-commands carry only CRC-6.
> 
> Upon detection of a CRC error on either side all conduit interfaces
> are taken down, triggering all user ports to go down as well. This is
> the most feasible option: CRC errors are likely caused either by
> broken hardware, or are symptom of overheating. In either case, trying
> to resume normal operation isn't reasonable.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

