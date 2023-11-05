Return-Path: <netdev+bounces-46108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0186D7E166B
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 21:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D321FB20D51
	for <lists+netdev@lfdr.de>; Sun,  5 Nov 2023 20:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F30C154;
	Sun,  5 Nov 2023 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KOPrsX6T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A12D6AD6
	for <netdev@vger.kernel.org>; Sun,  5 Nov 2023 20:36:30 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3630B8;
	Sun,  5 Nov 2023 12:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=qAfkqj3nY8C1kL+AlbMQMg/WrQw3CtDlJR2733wvnQk=; b=KOPrsX6T5E6qGe4iy0q6KjR6+z
	bOQ+UJXz4wBFJ+fEiStHAx18JE7EhtQNAJWc+sltGs7nKihWm4esVAxHjHFo37cZF+K9qjCbXnnfU
	TilJEPOytgdEvReq6qsesB+eBQXRNS1jgiq7TIq3RCR8ePCFjjEC61GIv+28xBUHUE7M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qzjqs-000wmI-Qv; Sun, 05 Nov 2023 21:36:10 +0100
Date: Sun, 5 Nov 2023 21:36:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, nic_swsd@realtek.com
Subject: Re: [PATCH net-next v6 0/5] Coalesce mac ocp write/modify calls to
 reduce spinlock contention
Message-ID: <7f0e29b4-a34d-4e38-bba3-b179d0484942@lunn.ch>
References: <20231104221514.45821-1-mirsad.todorovac@alu.unizg.hr>
 <da4409f3-d509-413b-8433-f222acbbb1be@gmail.com>
 <edee64f4-442d-4670-a91b-e5b83117dd40@alu.unizg.hr>
 <344fc5c2-4447-4481-843f-9d7720e55a77@lunn.ch>
 <b9573c0e-3cdb-4444-b8f2-579aa699b2e1@alu.unizg.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9573c0e-3cdb-4444-b8f2-579aa699b2e1@alu.unizg.hr>

> The command used for generating the assembly was taken from .o.cmd file and
> added -save-temps as the only change:

make drivers/net/ethernet/realtek/r8169_main.lst

is simpler. You get the C and the generated assembler listed together.

   Andrew

