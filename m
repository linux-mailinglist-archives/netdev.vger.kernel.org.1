Return-Path: <netdev+bounces-53276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E0A801E25
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 20:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB471C2084B
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 19:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA0118B18;
	Sat,  2 Dec 2023 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KdTHcpqK"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B0311D;
	Sat,  2 Dec 2023 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hILZhULZeuU4D7CkSzLlqvX1D9imsudessJgvQHUhpk=; b=KdTHcpqKq2XjRLSkRGdDGlFGak
	0yjtouapM61SGNda1mGd1bdbqIc/Fj2AEZDjaIkm/05NQFwvAlDSKnlXJyy02dpZ+8/YR7hV0AFRK
	Wshw2dyDSPw5IkQTl/UGIKImneDPTnyuTS7eegj1VehSX0n9VaknHnVApcumt+iQN7BM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r9VMU-001rX6-6S; Sat, 02 Dec 2023 20:09:10 +0100
Date: Sat, 2 Dec 2023 20:09:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Justin Lai <justinlai0215@realtek.com>, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next v13 01/13] rtase: Add pci table supported in
 this module
Message-ID: <0a2b5646-9d24-4a22-b1e3-87517e7cadb1@lunn.ch>
References: <20231130114327.1530225-1-justinlai0215@realtek.com>
 <20231130114327.1530225-2-justinlai0215@realtek.com>
 <20231201203602.7e380716@kernel.org>
 <27b2b87a-929d-4b97-9265-303391982d27@lunn.ch>
 <20231202105845.12e27e31@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231202105845.12e27e31@kernel.org>

> I'm mainly asking to make sure we avoid "implicitly programming" the
> switch, like, IIUC, one of the TI drivers did. And we ended up with
> multiple versions / modes of operation :( Sounds like this driver
> doesn't touch switch registers yet, tho, so all good.

I asked questions about this earlier, should it be a pure switchdev
switch, or a DSA switch, etc. So i think we have that basic questions
covered.

	Andrew

