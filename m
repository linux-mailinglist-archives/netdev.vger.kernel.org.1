Return-Path: <netdev+bounces-52580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF17FF426
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94FDF1F20ECE
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931F53810;
	Thu, 30 Nov 2023 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RuTYBgvZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AA810E4
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vvjsEOQej4SMoOpa4ZlLrjIRD//hxAlCwhwhZBCdgUM=; b=RuTYBgvZABCqx5XpLLk37YLAET
	0jP0ZH3EpamYDe8uFIgkha+rnfuWJwv2o/wbM/GEurHpsE+aYRY39AVfZ+Llr88CJdqccDUA8do/X
	HoA3hQpK3Wao+dx+kQl1gTz5HUKHp7m+/k2W5xeEkbyQp8GUOqa01dcU8vFT6a4hIWNs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r8jPH-001g9o-D0; Thu, 30 Nov 2023 16:56:51 +0100
Date: Thu, 30 Nov 2023 16:56:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sachin Bahadur <sachin.bahadur@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] ice: Print NIC FW version during init
Message-ID: <6404194f-3193-49e0-8e46-267affb56c24@lunn.ch>
References: <20231129175604.1374020-1-sachin.bahadur@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129175604.1374020-1-sachin.bahadur@intel.com>

On Wed, Nov 29, 2023 at 09:56:04AM -0800, Sachin Bahadur wrote:
> Print NIC FW version during PF initialization. FW version in dmesg is used
> to identify and isolate issues. Particularly useful when dmesg is read
> after reboot.
> 
> Example log from dmesg:
> ice 0000:ca:00.0: fw 6.2.9 api 1.7.9 nvm 3.32 0x8000d83e 1.3146.0
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Reviewed-by: Pawel Kaminski <pawel.kaminski@intel.com>
> Signed-off-by: Sachin Bahadur <sachin.bahadur@intel.com>

Is this information available via devlink info?
It has a section to report firmware version.

   Andrew

