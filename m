Return-Path: <netdev+bounces-55978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB51180D0EC
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 17:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A4A1C219F2
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 16:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A2F4C624;
	Mon, 11 Dec 2023 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fbjkb/q2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7BB193
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 08:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=GYs+toveH8V7/rfN4cLtBxV65f0vdngIeciD3Cx6ReU=; b=Fb
	jkb/q2Ug0YI2zuVz6POUFA4ME8tbgrAH8Kh6BMTCUnBDr65afnvhC58nLXwht+OLOEBFHxjCIFCkI
	zEphJ1Lbv732Cq4xoxadShWFiX3VdVhsCHjgdrrCKcOAXM5B00qpKyK3HF1k6Fy/3vsZLjoygilm6
	BfuLRJVV7g9F5Eo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rCiwt-002ddh-O5; Mon, 11 Dec 2023 17:16:03 +0100
Date: Mon, 11 Dec 2023 17:16:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Richard Tresidder <rtresidd@electromag.com.au>
Cc: Jakub Kicinski <kuba@kernel.org>, vinschen@redhat.com,
	netdev@vger.kernel.org
Subject: Re: STMMAC Ethernet Driver support
Message-ID: <2139624b-e098-457a-bda4-0387d576b53a@lunn.ch>
References: <e5c6c75f-2dfa-4e50-a1fb-6bf4cdb617c2@electromag.com.au>
 <20231208101216.3fca85b1@kernel.org>
 <8a0850d8-a2e4-4eb0-81e1-d067f18c2263@electromag.com.au>
 <41903b8b-d145-4fdf-a942-79d7f88f9068@electromag.com.au>
 <f47b0230-1513-4a81-9d78-3f092b979c48@electromag.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f47b0230-1513-4a81-9d78-3f092b979c48@electromag.com.au>

> We use the SOC's internal  STMMAC interface to connect to a Marvel switch IC
> and expose each port individually using vlan, I'd forgot that part.
> It's an  88E6352-xx-TFJ2I000  device utilising the 'marvell,mv88e6085'
> compatible driver  in drivers\net\dsa\mv88e6xxx

Its odd you need VLANs. Each port should already be exposed to the
host as netdev interfaces. That is what DSA does.

     Andrew

