Return-Path: <netdev+bounces-52557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0067FF32D
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F74AB20DD3
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8615851C42;
	Thu, 30 Nov 2023 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIY9u2fc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E61448CF7;
	Thu, 30 Nov 2023 15:05:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B61AC433C7;
	Thu, 30 Nov 2023 15:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701356742;
	bh=E8R3+0hXLh0qc5ZynnQNCLMHS7lZrhkDk9GDBZI56nU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VIY9u2fcuqy0jrFeWhhU8p0XhEkQMIjwTpWZC+7jpQeLBZEDal2SeIYsWPznDgIes
	 QcaO6cOTqKK2Qoc/JKYF8hMobtCpNhR+2/8iEIGC6tldR55nJK0FuYezPq77+M5gUJ
	 GelD/c1LEeXrNQXwiLBKn46GW0cd8IdSEZV9/vzqDLsVP6s2IPRW+MSdnVzXFo4jm3
	 gDq0+o6Qzj2dfZlADSgeXPXMLAiat+AQzKETkS25lomecmFMyhxd0Uk8nOTw4pgE8l
	 s23l1TdElKfehE2dIqhlxoGpt2reWkbdR8XdWkecZ/8dWj8Z1v/HtbqoCAGsXVaFb2
	 T4KDiN0HIA2Iw==
Date: Thu, 30 Nov 2023 07:05:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yujie Liu <yujie.liu@intel.com>
Cc: kernel test robot <lkp@intel.com>, <davem@davemloft.net>,
 <oe-kbuild-all@lists.linux.dev>, <netdev@vger.kernel.org>,
 <edumazet@google.com>, <pabeni@redhat.com>, <corbet@lwn.net>,
 <leitao@debian.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next] docs: netlink: link to family documentations
 from spec info
Message-ID: <20231130070541.105b9e34@kernel.org>
In-Reply-To: <ZWhNOvnxSMAudjXM@yujie-X299>
References: <20231127205642.2293153-1-kuba@kernel.org>
	<202311280834.lYzXIFc4-lkp@intel.com>
	<20231127190611.37a94d4c@kernel.org>
	<ZWhNOvnxSMAudjXM@yujie-X299>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 16:52:10 +0800 Yujie Liu wrote:
> > Is it possible that the build bot is missing python-yaml support and
> > the generation of Documentation/networking/netlink_spec/index.rst
> > fails?  
> 
> Hi Jakub, this is indeed due to missing pyyaml module in the bot so the
> doc file is not generated. We've installed it now and the warning is
> gone. Sorry for the noise and please ignore this report.

No worries at all, thanks for confirming!

