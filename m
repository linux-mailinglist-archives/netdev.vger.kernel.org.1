Return-Path: <netdev+bounces-42277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345F47CE064
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 16:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D3D281AB4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E097341B8;
	Wed, 18 Oct 2023 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Pp7xYa70"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E10311C80
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 14:52:03 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93471A4;
	Wed, 18 Oct 2023 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=l5lfKMqIHpjuJJaQLxCr6zq6nQHM5gTGHt5YODyVGPE=; b=Pp7xYa70Xv9OOtFNWrZ+32jMed
	sMDzrVDE+ObrsJNPhN3vW9TZcEbSozsJUH8wqbSbUpAWgRjQ8+X/KRl1Axwf0P2IeLqaMmrbm+QWt
	qmRKnP9Xz+fw7pDOyOoaMTiY6K5fc5gERFJHrg8iAxoPLqpk+7giQ1j8J5qv3BARwLv4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qt7tn-002aqM-P9; Wed, 18 Oct 2023 16:51:51 +0200
Date: Wed, 18 Oct 2023 16:51:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Anwar, Md Danish" <a0501179@ti.com>
Cc: MD Danish Anwar <danishanwar@ti.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>, r-gunasekaran@ti.com,
	Roger Quadros <rogerq@kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net v2] net: ti: icssg-prueth: Fix r30
 CMDs bitmasks
Message-ID: <f33ea0c9-5e7b-4b18-941b-50406fe27334@lunn.ch>
References: <20231016161525.1695795-1-danishanwar@ti.com>
 <11109e7d-139b-4c8c-beaa-e1e89e355b1b@lunn.ch>
 <d7e56794-8061-bf18-bb6f-7525588546fc@ti.com>
 <a322d1c2-d79a-4b55-92f6-2b98c1f2266e@lunn.ch>
 <80240b87-4257-9ff4-e24c-5b9211f2dc2b@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80240b87-4257-9ff4-e24c-5b9211f2dc2b@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Apologies for wrong commit message. I will send next version with proper
> commit message mentioning that this patch is backwards compatible

Great, thanks for looking into this.

Andrew

---
pw-bot: cr

