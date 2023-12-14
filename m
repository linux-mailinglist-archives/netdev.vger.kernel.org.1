Return-Path: <netdev+bounces-57591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7272E813882
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A54A11C20D44
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6D865ECC;
	Thu, 14 Dec 2023 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDRVwxUM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA573C46A
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 17:27:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD53C433C7;
	Thu, 14 Dec 2023 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702574878;
	bh=jGJcFfxJ77Jia20J5i+bfYpM74CzLhm4TBQhqZKIItE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDRVwxUMKTj8sYYBpuKOJdWVFGa3DUb6CUyS+B7krhljPalhiNlHpZ4jZzjOhX2//
	 suIwCMLFmuGIWt/JuOs0s3u/wXsKVqja3AEyM8ud6dWMObhFe5rHwSJzRDCSN2QsFG
	 GNt1YnFCfY7t79EjLqTn7K+Ze5Anc3Az2lucdMko2tUSwT5LW8Oe+28rw4H5kAyBkD
	 bHNuMpl7/LrETLip4mSdlShzD1UvX+4hl3n1Ry5It1XdoQfbt5krrvwZ/cK9uLwtcN
	 FK0csB8wDH6efkhYLoV5bhMSfcj8KDiJwlsCniOVGxwvVrrdW0kk4cQFI951zLcIVz
	 CcmOC8rooSUBw==
Date: Thu, 14 Dec 2023 09:27:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: JustinLai0215 <justinlai0215@realtek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
 <andrew@lunn.ch>, Ping-Ke Shih <pkshih@realtek.com>, Larry Chiu
 <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 13/13] MAINTAINERS: Add the rtase ethernet
 driver entry
Message-ID: <20231214092757.0456c978@kernel.org>
In-Reply-To: <34d0ca23a5c44dd8853c01379f4848e2@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
	<20231208094733.1671296-14-justinlai0215@realtek.com>
	<20231212112259.658d3a79@kernel.org>
	<34d0ca23a5c44dd8853c01379f4848e2@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 12:51:31 +0000 JustinLai0215 wrote:
> > https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html  
> 
> Larry Chiu is also one of the authors of this driver, so he is added as maintainer.
> I would like to ask if you have any questions about this part?

No questions at this stage, I just wanted to make sure you're familiar
with the guidelines. To avoid mistakes and misunderstandings later.

