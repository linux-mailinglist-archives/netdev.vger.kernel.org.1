Return-Path: <netdev+bounces-29732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04973784843
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 19:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3558E1C20B2C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A3E2B56A;
	Tue, 22 Aug 2023 17:15:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323BA2B554
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 17:15:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260D0C433C7;
	Tue, 22 Aug 2023 17:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692724516;
	bh=M6RtlzTT8KLxbjFSf6ftJNn0kyweLFk9Z4vKdjaRKK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MSETz7GQ3Yx53+vwrR9Fy+BXAD7ssrOkiO5bp1NG350ad8q/hqftNAhPwnFRWhiYc
	 ZKCoTYI5AyWM89HdHR2bkWIUqk9Psyp2bYwkhsLBT+DaE+8WEaZgUBRGvi26q2S2xq
	 fRnXNZDqWgDB8y9brXVIxAeVW9CFXUapIWtZu5A2cNyErPcPqg87+30rKGxdwWR9Aa
	 OcRlHTaNYpKUtCEddoNk128hxGaU5alsUfeoiuBJo6RRr7R0dmn9UKtFZt0IT/kmdc
	 kCLBroTQeSZnGbiqei0uTMCp6yL/XNl3KQA1EUPzC6Wn2tH3trXIrO1UUDRq+41guc
	 hyXWqbcItxvsA==
Date: Tue, 22 Aug 2023 20:15:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com, "David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	jesse.brandeburg@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Saeed Mahameed <saeedm@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-next 1/9] ice: use
 ice_pf_src_tmr_owned where available
Message-ID: <20230822171512.GO6029@unreal>
References: <20230817141746.18726-1-karol.kolacinski@intel.com>
 <20230817141746.18726-2-karol.kolacinski@intel.com>
 <20230819115249.GP22185@unreal>
 <20230822070211.GH2711035@kernel.org>
 <20230822141348.GH6029@unreal>
 <f497dc97-76bb-7526-7d19-d6886a3f3a65@intel.com>
 <20230822154810.GM6029@unreal>
 <8a0e05ed-ae10-ba2f-5859-003cd02fba9c@intel.com>
 <20230822160651.GN6029@unreal>
 <20230822095301.31aeeaf2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822095301.31aeeaf2@kernel.org>

On Tue, Aug 22, 2023 at 09:53:01AM -0700, Jakub Kicinski wrote:
> On Tue, 22 Aug 2023 19:06:51 +0300 Leon Romanovsky wrote:
> > Can I suggest change in the process?
> > 1. Perform validation before posting
> > 2. Intel will post their patches to the netdev@ ML.
> > 3. Tony will collect reviewed patches from netdev@
> > 4. Tony will send clean PRs (without patches) from time to time to
> > netdev maintainers for acceptance.
> > 
> > It will allow to all of us (Intel, Nvidia e.t.c) to have same submission
> > flow without sacrificing open netdev@ review which will be done only once.
> > 
> > Jakub/Dave, is it possible?
> 
> That sounds worse than what they are doing today. And I can't help
> but think that you're targeting them because I asked you to stop posting
> directly for net-next. Vendetta is not a good guide for process changes.

Are you real? I had this idea even BEFORE you started to be netdev@
maintainer and had put it on paper BEFORE your request.

Should I add you to our internal conversation about it so you will be
able to see dates by yourself?

Thanks

