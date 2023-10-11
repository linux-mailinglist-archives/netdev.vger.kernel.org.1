Return-Path: <netdev+bounces-39783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2897C479A
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 04:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 883FC1C20C59
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 02:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64881A5D;
	Wed, 11 Oct 2023 02:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+SAnBzA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44941819
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 02:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84727C433C8;
	Wed, 11 Oct 2023 02:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696989672;
	bh=kbWICzSB4IKAHMv/+9GW4UxQ64X13NVNXGJ6Mchx14I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O+SAnBzAZxt2yAxcJcTnlGbrGefRa0Z8GYgs6FBiVcPoA2wZsrpaGtub8Bxzg6U1N
	 Wzk+kiA8MCKEimqgMGgRQssGOhrretwKPtfneBFvfNp9kfrf2Y7Trx+0pCkx6POhMH
	 icegletrzbTJiD4YY+a3l3uUQatPHVIOQBi74h7AxkEPKlJ1CnNGC+iRZTq4yo0L4N
	 0QvuEdM6RVw4RsgZRW/PzLP+WN3DqWa2bcakIcXmNY2/Jsckj7roGcvc/lusopzZtk
	 jaNk56SrSKNEEzHKS2uB6uDZGB7Ica11cpr25DgFuRuhZ+RsaHTSJbwPFWNsCQrcKH
	 wnv2oJ3WdxTXQ==
Date: Tue, 10 Oct 2023 19:01:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <jacob.e.keller@intel.com>, <vaishnavi.tipireddy@intel.com>,
 <horms@kernel.org>, <leon@kernel.org>, Pucha Himasekhar Reddy
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v4 2/5] ice: configure FW logging
Message-ID: <20231010190110.4181ce87@kernel.org>
In-Reply-To: <835b8308-c2b1-097b-8b1c-e020647b5a33@intel.com>
References: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
	<20231005170110.3221306-3-anthony.l.nguyen@intel.com>
	<20231006170206.297687e2@kernel.org>
	<835b8308-c2b1-097b-8b1c-e020647b5a33@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Oct 2023 16:26:15 -0700 Paul M Stillwell Jr wrote:
> I'm probably missing something here, but I don't know if this will do 
> what I need or not. What I have is a user passing a module name and a 
> log level and I'm trying to match those strings and create integer 
> values from them so I can configure the FW log for that module. I'm not 
> seeing how the above gets me there...
> 
> I was trying to not use strncmp and instead use the built in kernel 
> string matching functions so that's how I ended up with the code I have

You're supposed to do very simple and targeted matching here.
The cmdline parsing makes the code harder to follow.

