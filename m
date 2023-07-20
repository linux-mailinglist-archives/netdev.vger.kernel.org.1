Return-Path: <netdev+bounces-19326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B975A4BB
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 05:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A32281C1B
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 03:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313D137D;
	Thu, 20 Jul 2023 03:24:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F21115
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 03:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2731C433C7;
	Thu, 20 Jul 2023 03:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689823477;
	bh=YulX0mO1Z33K0iP33Q6hZ0nrby/5DziNCqkBxAomqlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S2UjTeYlrDpe9TC+Lgr1Fg5KFP2vZ+9jQRACUsdu/XUBWPj/fNOJu/irWZNDKxOk3
	 mdp54V0U/oWj/nbOauh7lwdzTZQ0i5MLK3Smd9qaPByyN1juGK537kLyybZKHQFpJ5
	 ve9O8MqDfhlKJFbuGsnqFjdKCcxmu60hvFsyjBUANWDbGrKO9QRc5Hg45jU9nRsCC0
	 ZMXm1wUhgfrI8xkHpxUslhkPmseG1nsns5i0X8V3RcKYVzwWifrEdI0usK9gGrM2U1
	 Nyxi2rma1sZv8GFKGr889q9LOS6F71wboyCt5Wm0Z/QciUfA292KzSRVJB06WTaLO/
	 /gP/c53XpwR7Q==
Date: Wed, 19 Jul 2023 20:24:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, David Miller <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, "Alexander
 Mikhalitsyn" <alexander@mihalicyn.com>, Kuniyuki Iwashima
 <kuniyu@amazon.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230719202435.636dcc3a@kernel.org>
In-Reply-To: <PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
	<20230720105042.64ea23f9@canb.auug.org.au>
	<20230719182439.7af84ccd@kernel.org>
	<20230720130003.6137c50f@canb.auug.org.au>
	<PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 03:17:37 +0000 Von Dentz, Luiz wrote:
> Sorry for not replying inline, outlook on android, we use scm_recv
> not scm_recv_unix, so Id assume that change would return the initial
> behavior, if it did not then it is not fixing anything.

Ack, that's what it seems like to me as well.

I fired up an allmodconfig build of linux-next. I should be able 
to get to the bottom of this in ~20min :)

