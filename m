Return-Path: <netdev+bounces-19692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 178EC75BB25
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 01:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2E042820CC
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 23:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C61DDF9;
	Thu, 20 Jul 2023 23:27:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF8E1E505
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 23:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE63C433C9;
	Thu, 20 Jul 2023 23:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689895677;
	bh=F/lLf6VoBWh6m+upBr0z/vTAwH2Fc7QsSDH7ZudA/xY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i2+QknZDMwRO3chfdCYhK1wlWzoPWWih6w72El36t7v8Z9I/q0n6Nq+dTw669e6hT
	 K8dcTerAng0UPlEs6H5YpPAk964lhUzVPNtVkxZQuhPOuYjBsxSmWCC91v+Ge8ZX4i
	 FTEDDFLks3n09elZ+GB1gzo3d3dWICekuHrtewPbcyhuQSdXmsGpEXKT1u29YLUcFK
	 w8oI7+uBFFdnBFSQUKQLFbHdOokNkCsiKfHaSb3pvdHvSVzhbSo9/z6IJ7J33nhmZQ
	 Z7iaHwI5wEik/M2so7YYgcXuP7dvpLotpm98c6jQc0NPvb6miADIeMaW5U73r6Xjw6
	 /6XnkInEw3kEw==
Date: Thu, 20 Jul 2023 16:27:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: "Von Dentz, Luiz" <luiz.von.dentz@intel.com>, Marcel Holtmann
 <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, David Miller <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, "Alexander
 Mikhalitsyn" <alexander@mihalicyn.com>, Kuniyuki Iwashima
 <kuniyu@amazon.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230720162756.08f2c66b@kernel.org>
In-Reply-To: <20230721081258.35591df7@canb.auug.org.au>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
	<20230720105042.64ea23f9@canb.auug.org.au>
	<20230719182439.7af84ccd@kernel.org>
	<20230720130003.6137c50f@canb.auug.org.au>
	<PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
	<20230719202435.636dcc3a@kernel.org>
	<20230720081430.1874b868@kernel.org>
	<20230721081258.35591df7@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jul 2023 08:12:58 +1000 Stephen Rothwell wrote:
> > I kicked it off and forgot about it.
> > allmodconfig on 352ce39a8bbaec04 (next-20230719) builds just fine :S  
> 
> Of course it does, as commit
> 
> 817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
> 
> is reverted in linux-next.  The question is "Does the bluetooth tree
> build?" or "Does the net-next tree build *if* you merge the bluetooth
> tree into it?"

Sorry for being slow, yes. I just did a test build with net-next and
bluetooth-next combined and allmodconfig is okay, so you should be good
to drop the revert. Fingers crossed.

