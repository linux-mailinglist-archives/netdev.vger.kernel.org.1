Return-Path: <netdev+bounces-56498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348C880F21D
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 17:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 655221C20981
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529D877659;
	Tue, 12 Dec 2023 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw/EDLVh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187F5D494;
	Tue, 12 Dec 2023 16:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300B1C433C7;
	Tue, 12 Dec 2023 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702397678;
	bh=plkrYSA2Q6+IorymQw0Z+34ixdevQX94H+3vO4fTE3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fw/EDLVh3qMZt4C+fYO4XVL8FR81FZMp6gD4axs1/M4VNCDMw83+atx0KdiJobeG2
	 QL0/606ivEtcvXpaxztYNybTaPH7QIm2w30ualoryspBKyH8VxZ2P3YSyCfZXmQvSb
	 FYhNx3qyitLgJ9r+YiQn/Uy+u+SrQLWH5Xea6Sfyiu19HNK9cpFFhuZqz4vc2qTG9T
	 dXFVOO8r42nS7ZmFCGAbHz9wxlbxVaC3jtWgmWcGl6DgBXYVzoHmgrHhjYchrwl2DU
	 sN6d/y43AGWUtnAjfire1eTO+RhwMXTj2TUPtqBMTo0AKW26oVLvuqQkpHHeQwhWpJ
	 iccSc8G+P6zyA==
Date: Tue, 12 Dec 2023 08:14:37 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 00/11] tools/net/ynl: Add 'sub-message'
 support to ynl
Message-ID: <20231212081437.0a42f82b@kernel.org>
In-Reply-To: <m2v8937isg.fsf@gmail.com>
References: <20231211164039.83034-1-donald.hunter@gmail.com>
	<20231211153209.2d526d99@kernel.org>
	<m2v8937isg.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 11:38:07 +0000 Donald Hunter wrote:
> > Seems to break C codegen:  
> 
> Ick. Sorry about that. How do you test/validate the C codegen?

make -C tools/net/ynl -j 8

