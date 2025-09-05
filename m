Return-Path: <netdev+bounces-220500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F58B466FA
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 01:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D95D1C83B7B
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 23:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDA929D276;
	Fri,  5 Sep 2025 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ddx2BZAU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747EB72639;
	Fri,  5 Sep 2025 23:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757113415; cv=none; b=LlKTVBln62Sj0ZjO2hXJ80PlrECt3kzS+arVnG/wtl9O+4KiwgGlO1+dzLOxKm7Ef280SfEf2MkWya9VpW70Cr+zkksgRf70udDWZUH+grDloRdB3hRh6117RJsg9sZ99oGNz/0LfrCJ2M1j90HbiVrPKSwEDDf7+lmk/HnZWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757113415; c=relaxed/simple;
	bh=SSR5igEuT2Tf8n+EfMfirwtxqYmk61d5A+Q6qOa4nUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKIYSZoiCwYn3ZQ5svW5xGN3XoFopBpVoiS1d8GjsWPCZuXV9FC2vzPqzCeKBH8D1j4ignmCySnhoCg+8ouRbc9+b2zPq3pvGHYQyeTsXC56UiXtLeYfrnVY44zm1Dr0ybLUPr2lNggCfry7eBSZaR3COkvzM2W2iFSWk1UMSyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ddx2BZAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F8CC4CEF1;
	Fri,  5 Sep 2025 23:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757113415;
	bh=SSR5igEuT2Tf8n+EfMfirwtxqYmk61d5A+Q6qOa4nUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ddx2BZAUkhkz5OFxzcQEkbmKebtXFYcikDJTvGsRE2bKHpDiiE8EfJ86D1oUQ27H+
	 dTQO/eJF6KJIJ0GqPkBAfxBwX9U4ql+FFt2PcQFhoX/SG1fuKyEa2ljZxkkqajob9F
	 cYKddhx0USgUJZ6mGal/Zfc4PdJt4d/bw9q+VpbnrLASSgoBUS5k0GiRnWOBzq1vQ+
	 EDHxfnCsN1d/B36c3GGKz3beQPvUYL4TKuymy71Q1b6bmFhitWNP4H4ifE1/4NhTAL
	 nSgiHGjgjg/PqB52RR/cihCGTQpGs6jOw+mtQh7/0IDdFOF1Zr3VNWeC1mu2n5DElb
	 5mqlQFzt9mr2Q==
Date: Fri, 5 Sep 2025 16:03:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
 <przemyslaw.kitszel@intel.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "sdf@fomichev.me" <sdf@fomichev.me>, "almasrymina@google.com"
 <almasrymina@google.com>, "asml.silence@gmail.com"
 <asml.silence@gmail.com>, "leitao@debian.org" <leitao@debian.org>,
 "kuniyu@google.com" <kuniyu@google.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "Vecera, Ivan" <ivecera@redhat.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "intel-wired-lan@lists.osuosl.org"
 <intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [RFC PATCH v2] net: add net-device TX clock source selection
 framework
Message-ID: <20250905160333.715c34ac@kernel.org>
In-Reply-To: <SJ2PR11MB8452D62C5F94C87C6659C5989B03A@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
	<20250828153157.6b0a975f@kernel.org>
	<SJ2PR11MB8452311927652BEDDAFDE8659B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
	<20250829173414.329d8426@kernel.org>
	<SJ2PR11MB8452D62C5F94C87C6659C5989B03A@SJ2PR11MB8452.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Sep 2025 11:14:09 +0000 Kubalewski, Arkadiusz wrote:
> Please share your thoughts, right now I see two ways forward:
> - moving netdev netlink to rt-netlink,
> - kind of hacking into dpll subsystem with 'ext-ref' and output netdev pin.

I haven't spend much time thinking this thru, but my intuition would be
similar to what we have. One dpll pin exposed via rtnetlink (like Ivan
shows in his reply), and then the selection of input for that pin kinda
looks like the mux problem that we already solved with the DPLL API?
IOW I guess "hacking into dpll subsystem" would be my first choice?

