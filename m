Return-Path: <netdev+bounces-40554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527847C7A80
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CC871C20986
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11E32B5E5;
	Thu, 12 Oct 2023 23:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfOCjje6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B4D1D68F
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 23:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1D8C433C8;
	Thu, 12 Oct 2023 23:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697154035;
	bh=heD+8yiZFfHLd4fBFNBdz9KyyNSpTCkcX5TsIu+70ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nfOCjje6a/cFdAv/+qtuSRFo0LnlOFNKoNpfpiK8H1ZlVGy27gz/kkbKYihIV6cZH
	 08XJ7gGlUDT2XbGoawfWX+7KTEOxhyGLNACCEGebjZxgBUivFa0Hg4Xlcj2Lrm/sE2
	 mwp8Tx7mEHJ6b12Ub7rhTOhSfQn4XAHV7OJ0CsVk8eSQrlCPUgIRUGzWeZq8MI8vgL
	 pLRlXzW7yXm1gVGAPda1lGHC69H/7miivqPZTfMy1wxIQQT6kwSmCH8U3EZ7kFBhuF
	 uOBnuAh4iRP04UFjzE99Ke9D67Jce22HV+LDENiIenG9hkePlrfG2SF2LmicAS6lLS
	 IQMQ0IlqrgEIQ==
Date: Thu, 12 Oct 2023 16:40:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <jacob.e.keller@intel.com>, <vaishnavi.tipireddy@intel.com>,
 <horms@kernel.org>, <leon@kernel.org>, Pucha Himasekhar Reddy
 <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v4 2/5] ice: configure FW logging
Message-ID: <20231012164033.1069fb4b@kernel.org>
In-Reply-To: <a810ade6-b847-28fa-6225-5f551a561940@intel.com>
References: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
	<20231005170110.3221306-3-anthony.l.nguyen@intel.com>
	<20231006170206.297687e2@kernel.org>
	<835b8308-c2b1-097b-8b1c-e020647b5a33@intel.com>
	<20231010190110.4181ce87@kernel.org>
	<a810ade6-b847-28fa-6225-5f551a561940@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Oct 2023 17:40:04 -0700 Paul M Stillwell Jr wrote:
> OK, so what if we changed the code to create a new debugfs file entry 
> for each module and used the dentry for ther file to know what file is 
> being written to. Then we would only need to parse the log level. Would 
> that be acceptable?

Yes, even better!

> My confusion is around what makes the cmdline parsing harder to follow. 
> Obviously for me it's easy :) so I am trying to understand your point of 
> view.

Dunno how to explain it other than "took me more than 10min to
understand this code and I only had 10min" :)  Reviewers have
their own angle when evaluation code which doesn't always align
with the author's..

