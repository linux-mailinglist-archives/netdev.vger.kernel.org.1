Return-Path: <netdev+bounces-22925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A169676A099
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B77B281300
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908B919BBA;
	Mon, 31 Jul 2023 18:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A66318C3D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:44:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFA0C433C7;
	Mon, 31 Jul 2023 18:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690829089;
	bh=g3Lr/Shj430AcLy3upoQKrQHWCX0lvtJx+HQZMenFUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s13XF2bE9SNSwkihwKJPwAXxWY8t23Ytmp7/dTxr2PoDBRRtavEX2dHXVdYkXudmw
	 PHTjB+dzBaIZVM6nh033Kqy06tkT8+1NIyMZST3l9gvEOVgIy94AZa20X9UpZBKqLd
	 sFIsJxFGr9FKu19AJHmUCOLc7ICFDOt/7DzD5HiSeWsVaHDI8XTGaBcvLkqT50HTE/
	 VGlNiX/P2nVuCDgweh8EH67VwcNbs/xclJdLa1Z2tB7bi+bOzWYgvyiPh/WCLqWwxG
	 C2ZJp7uM4AwM4Q1S1Pi46yKyr8DaJbI+JZztrAQYwxq+jbEC72yvdGu2ylFO+0NO6p
	 Bze6WlJNJZ2+Q==
Date: Mon, 31 Jul 2023 20:44:43 +0200
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lin Ma <linma@zju.edu.cn>, michael.chan@broadcom.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	ajit.khaparde@broadcom.com, sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
	simon.horman@corigine.com, louis.peens@corigine.com,
	yinjun.zhang@corigine.com, huanhuan.wang@corigine.com,
	tglx@linutronix.de, bigeasy@linutronix.de, na.wang@corigine.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com
Subject: Re: [PATCH net-next v1] rtnetlink: remove redundant checks for
 nlattr IFLA_BRIDGE_MODE
Message-ID: <ZMgBG2ZpXnsvZ07p@kernel.org>
References: <20230726080522.1064569-1-linma@zju.edu.cn>
 <ZMdfznpH44i34QNw@kernel.org>
 <20230731085405.7e61b348@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230731085405.7e61b348@kernel.org>

On Mon, Jul 31, 2023 at 08:54:05AM -0700, Jakub Kicinski wrote:
> On Mon, 31 Jul 2023 09:16:30 +0200 Simon Horman wrote:
> > > Please apply the fix discussed at the link:
> > > https://lore.kernel.org/all/20230726075314.1059224-1-linma@zju.edu.cn/
> > > first before this one.  
> > 
> > FWIIW, the patch at the link above seems to be in net-next now.
> 
> I don't think it is.. 🧐️

Sorry, my bad.

