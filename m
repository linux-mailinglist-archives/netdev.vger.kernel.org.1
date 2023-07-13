Return-Path: <netdev+bounces-17412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D0B7517F6
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2990E1C212A7
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA28953AA;
	Thu, 13 Jul 2023 05:20:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A962539F
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13CEC433C7;
	Thu, 13 Jul 2023 05:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689225631;
	bh=z6zuH7daBzbcGYtDcnZ439Wv5nCYbKqhRoUY8isgFv8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=quNv0cvF6oB6HahcBuOl/c7UiHvHpeZ4eM0E92Mu1dzFhEudhYIwrwM0mjFflc5+s
	 h++O8z4z/cQy7iQh7IFld0SOyhp3I6Geu2mLfgwNXGmh1ru6GVgzoZeSsMkpOCp5xk
	 M8bK2MqtVWf2K5CZDa0O5N50stSDmqck0p8ppzRfENTz4qDZbGboC2CjGE/eLYNpJN
	 LREnVL6ioycpFeJh/RaFJEcyiUA3nhz4e7j36LFT+MfhQiOBVnHnu05nINUy5CcsDY
	 rZ1NpymSDAepPyknMppha8MVAov0DyMG4+VFhKUaAfDBtJVnm9SkI1rLShkKU1cKqa
	 EqHAzFV455gqw==
Date: Wed, 12 Jul 2023 22:20:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH 2/3] octeontx2-af: Fix hash extraction enable
 configuration
Message-ID: <20230712222029.6a918a58@kernel.org>
In-Reply-To: <20230712111604.2290974-3-sumang@marvell.com>
References: <20230712111604.2290974-1-sumang@marvell.com>
	<20230712111604.2290974-3-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 16:46:03 +0530 Suman Ghosh wrote:
> As of today, hash extraction was enabled by default for the default
> MKEX profile. This patch fixes that and enable the support based on
> customer specific MKEX profile.

I'm not sure what this means, can the commit message be readable for
people who don't know your HW, please?

