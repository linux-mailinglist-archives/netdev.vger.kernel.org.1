Return-Path: <netdev+bounces-218426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C6AB3C64D
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 02:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3AFF5E4E52
	for <lists+netdev@lfdr.de>; Sat, 30 Aug 2025 00:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368A926281;
	Sat, 30 Aug 2025 00:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3xeKX/o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1F1799F;
	Sat, 30 Aug 2025 00:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756514056; cv=none; b=k8XnuCPvgkOO/PhfmeR2fWSN3EdWsh7vogttpjL3dQTIa5LmuOylaFMd3dw2OYtXZV+1Inye9lj3B2MIVvZYQBtBDAZAWRXJJs8ROiEsDFnyWvCbS+yJ40KkB0iH/I58LtMLS11RFgi4ozs0hqMjY/pPNzQFd2xlO67PYpslab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756514056; c=relaxed/simple;
	bh=CGKuUnFLIgZQcIQRjehK7VdSIVKubM4b+zXerCXihrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GzxuoUq4fwIv9r2bRa704nUsxH67bwJmT3dUARQ4XxH4+U+dKTOKI1kwCs76WvDkKRCpItgIjRFTM1neRGo8S8IU7wYAq+JH8OedqJOh6kbT4zTB1lamP3zktFnWPjke4CHnBkxcLi3HTH/VxJndgdq4zViU2RfRzyBanFSLSyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3xeKX/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2D2C4CEF0;
	Sat, 30 Aug 2025 00:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756514055;
	bh=CGKuUnFLIgZQcIQRjehK7VdSIVKubM4b+zXerCXihrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s3xeKX/oBi5t9Q1S6/8eq9nmxlf2jzimRN2vm3MVth0Apswa0mSPSEJpISRqlYJ+O
	 lx9jmYDvF5wUNPXsGnPRcqW9jGt8Fl6pFhE78KDYoLAILYaJZwJYhAETRIdDy0PSGk
	 V2Opm5uLwAiwbfXXBsNJlkTMQ5LVmwDJGVTXZ0loEGHbFHscxhQiUrb9rAaVmhsZIq
	 5etA2tWEQi+Zi3SFD+9r+kIDLx2vmaGH3fEXoGiCLrIIFBw8GyNRcdUTdkdGvzqFRt
	 5GTkuL+f8kqZEDynRMNsmtjAl4+4dDBG0FKXVBpC9KxkXTgOctUcLVsVouiScCCse2
	 jOJUy4m4eN3Vw==
Date: Fri, 29 Aug 2025 17:34:14 -0700
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
Message-ID: <20250829173414.329d8426@kernel.org>
In-Reply-To: <SJ2PR11MB8452311927652BEDDAFDE8659B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
References: <20250828164345.116097-1-arkadiusz.kubalewski@intel.com>
	<20250828153157.6b0a975f@kernel.org>
	<SJ2PR11MB8452311927652BEDDAFDE8659B3AA@SJ2PR11MB8452.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 07:49:46 +0000 Kubalewski, Arkadiusz wrote:
> >From: Jakub Kicinski <kuba@kernel.org>
> >Sent: Friday, August 29, 2025 12:32 AM
> >
> >On Thu, 28 Aug 2025 18:43:45 +0200 Arkadiusz Kubalewski wrote:  
> >> Add support for user-space control over network device transmit clock
> >> sources through a new extended netdevice netlink interface.
> >> A network device may support multiple TX clock sources (OCXO, SyncE
> >> reference, external reference clocks) which are critical for
> >> time-sensitive networking applications and synchronization protocols.  
> >
> >how does this relate to the dpll pin in rtnetlink then?  
> 
> In general it doesn't directly. However we could see indirect relation
> due to possible DPLL existence in the equation.
> 
> The rtnetlink pin was related to feeding the dpll with the signal,
> here is the other way around, by feeding the phy TX of given interface
> with user selected clock source signal.
> 
> Previously if our E810 EEC products with DPLL, all the ports had their
> phy TX fed with the clock signal generated by DPLL.
> For E830 the user is able to select if the signal is provided from: the
> EEC DPLL(SyncE), provided externally(ext_ref), or OCXO.
> 
> I assume your suggestion to extend rtnetlink instead of netdev-netlink?

Yes, for sure, but also I'm a little worried about this new API
duplicating the DPLL, just being more "shallow".

What is the "synce" option for example? If I set the Tx clock to SyncE
something is feeding it from another port, presumably selected by FW or
some other tooling?

Similar on ext-ref, there has to be a DPLL somewhere in the path,
in case reference goes away? We assume user knows what "ext-ref" means,
it's not connected to any info within Linux, DPLL or PTP.

OXCO is just an oscillator on the board without a sync. What kind of
XO it is likely an unnecessary detail in the context of "what reference
drives the eth clock".

All of these things may make perfect sense when you look at a
particular product, but for a generic Linux kernel uAPI it does not
feel very natural.

