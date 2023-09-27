Return-Path: <netdev+bounces-36551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9355C7B05C0
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 54B10282BC4
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B8B37159;
	Wed, 27 Sep 2023 13:48:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F827734
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 13:48:14 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96644126
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=upWcfxFHp21c3N/P/Zf9mRzfCLqhI1aD4eMLF3ok/Vk=; b=zpKuWcYUCROCbiL5d33QV6GJe6
	K+sLFFPnrw5610zFse0PD5AcMNI/KulQXr4sbCyaWKhtAxUch9xTQa/H1xUwBbVAUQ+pSZVhU5kAO
	jjxnRVPXNdq/SzfPEAwV4rjlucaoDtkzls5m/XqHcpqX4y60us59DZeLLpLEsDXDZWew=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qlUtc-007eMG-R4; Wed, 27 Sep 2023 15:48:08 +0200
Date: Wed, 27 Sep 2023 15:48:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Konrad Knitter <konrad.knitter@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Marcin Domagala <marcinx.domagala@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v1] ice: read internal temperature sensor
Message-ID: <7e525cbc-1f68-4826-9d70-f2f4c99776d8@lunn.ch>
References: <20230927133857.559432-1-konrad.knitter@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927133857.559432-1-konrad.knitter@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 03:38:57PM +0200, Konrad Knitter wrote:
> Since 4.30 firmware exposes internal thermal sensor reading via admin
> queue commands. Expose those readouts via hwmon API when supported.
> 
> Driver provides current reading from HW as well as device specific
> thresholds for thermal alarm (Warning, Critical, Fatal) events.

Hi Konrad

Please also Cc: the hwmon Maintainer to get his review comments.

       Andew

