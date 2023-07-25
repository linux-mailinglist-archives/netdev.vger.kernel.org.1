Return-Path: <netdev+bounces-20992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D53C762180
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 20:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E6661C20F97
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 18:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB6C24182;
	Tue, 25 Jul 2023 18:36:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104E323BFE
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 18:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3088BC433C9;
	Tue, 25 Jul 2023 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690310216;
	bh=bjmPK5i8hRDzGjUnFu1I3rEttWK5DLd8NhrusoG1LHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SdcIkVwfwM8nNchwnyAIYUyNEQfIrLNu4VzEIYuK/6yR399E7HquUzR/dEqLDwynl
	 cs+FB8L8PqQoFeknYUPYeowW+xWD6OekN6l/qDJixjEoe/qvUSv000ZEbMnilgzoFK
	 iWFmJyTNaRFJ9FXuDqJfTWqKLFHGv72a3Hf8BSbDFjglnjwciYyPG5YtvrCxnfokXZ
	 f7VYTKBs5OGzYR725ZwuO+mGVGSSvWMD8y5bmlBdzNoKOPRJvrrWkOT7WUzs3fh+fk
	 uvEePo1Adzoa0h0Eqnn0xXtyVmeLUJdR3LA+GNYvxiM94trezxoCn99BSE8nB7PLMY
	 2jvafCCIQiVjA==
Date: Tue, 25 Jul 2023 21:36:52 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lin Ma <linma@zju.edu.cn>, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] i40e: Add length check for IFLA_AF_SPEC parsing
Message-ID: <20230725183652.GR11388@unreal>
References: <20230723075042.3709043-1-linma@zju.edu.cn>
 <20230724174435.GA11388@unreal>
 <20230724142155.13c83625@kernel.org>
 <20230725054046.GK11388@unreal>
 <20230725095327.385616f1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725095327.385616f1@kernel.org>

On Tue, Jul 25, 2023 at 09:53:27AM -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 08:40:46 +0300 Leon Romanovsky wrote:
> > > Empty attributes are valid, we can't do that.  
> > 
> > Maybe Lin can add special version of nla_for_each_nested() which will
> > skip these empty NLAs, for code which don't allow empty attributes.
> 
> It's way too arbitrary. Empty attrs are 100% legit, they are called
> NLA_FLAG in policy parlance. They are basically a boolean.

I afraid that these nla_length() checks will be copied all other the
kernel without any understanding and netlink API doesn't really provide
any hint when length checks are needed and when they don't.

Thank

