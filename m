Return-Path: <netdev+bounces-52645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0B97FF921
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 19:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15D69B20E1A
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739C359148;
	Thu, 30 Nov 2023 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1u73PJS8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCD31B3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 10:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8ckDCFnG5XwkvZJDpsjOjyKrOSn4bB8xpoBOW5kTJ90=; b=1u73PJS8ErIXGW/BgzzndLKFdb
	tMMz5JZV0BQ7fPqGP4geiwZa3Wt9cZz6bGRAkokp0tmsqu2yDgfWlRre5xwSjTkmXIPSWXsPxLGei
	qjfP1gWqrJ0gAqiGZ6gXV1vZ16rLnktKhPp8z/da3T0Fngih6NeAhIkylXo1omZwbtF4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r8lXD-001gy5-Qw; Thu, 30 Nov 2023 19:13:11 +0100
Date: Thu, 30 Nov 2023 19:13:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Bahadur, Sachin" <sachin.bahadur@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH iwl-next v2] ice: Print NIC FW version during init
Message-ID: <fadae2d9-68ab-4a1a-bfe1-78d0f1c2fb13@lunn.ch>
References: <20231129175604.1374020-1-sachin.bahadur@intel.com>
 <6404194f-3193-49e0-8e46-267affb56c24@lunn.ch>
 <BY5PR11MB4257E2D47667F2108BEDBE0F9682A@BY5PR11MB4257.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB4257E2D47667F2108BEDBE0F9682A@BY5PR11MB4257.namprd11.prod.outlook.com>

> Yes, this info is available via the "devlink dev info" command. 
> Adding this info in dmesg ensures the version information is
> available when someone is looking at the dmesg log to debug an issue. 
 
Ideally you would train your users to use devlink info, since you get
more useful information, and it should work for any vendors NIC, not
just Intel which is spamming the log with firmware versions.

  Andrew


