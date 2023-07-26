Return-Path: <netdev+bounces-21497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDBC763B79
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 17:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E12671C2135C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 15:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A770126B38;
	Wed, 26 Jul 2023 15:44:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FDA253B3
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 15:44:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69E63C433C7;
	Wed, 26 Jul 2023 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690386261;
	bh=JvjAqNzSw7RGl03zCiiOwwXJFn3DlYoUHXuh6xzWd/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RpnOLYopyCZ49Ky3mG+aQnjQTsvSLTvOebr6AWgESRleqJjr2YDmT15izsvi7NN2k
	 2JiLzaEaUretzBaAkWwQ09n/P/kyu1qyg6jQvkZYOsbqq9w31zB9qgSodlCmwk3ntv
	 XOTwMfXCdayMBeFGyWGbJYYcTPhicnARanwRTlrXlvEV+rdB/ZdcpAZkYZyvXFnA6H
	 pFQQq8ChSFzdT9BfgQKUUKSvBhOt0yVkiqfcjWRdY+AtewiXxs1uT0zzxlsmQCPy+a
	 WNuo+mcEY3VR2dUZvzrXq538ky6g35z4ymRVa66yfsBbM+COr1BU5q+DcsXskykD3/
	 FBZBIbeRprDSQ==
Date: Wed, 26 Jul 2023 08:44:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lin Ma" <linma@zju.edu.cn>
Cc: "Nikolay Aleksandrov" <razor@blackwall.org>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, idosch@nvidia.com,
 lucien.xin@gmail.com, liuhangbin@gmail.com, edwin.peer@broadcom.com,
 jiri@resnulli.us, md.fahad.iqbal.polash@intel.com,
 anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com,
 neerav.parikh@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtnetlink: let rtnl_bridge_setlink checks
 IFLA_BRIDGE_MODE length
Message-ID: <20230726084420.1bf95ef9@kernel.org>
In-Reply-To: <7670876b.ea0b8.189912c3a92.Coremail.linma@zju.edu.cn>
References: <20230725055706.498774-1-linma@zju.edu.cn>
	<6a177bb3-0ee4-f453-695b-d9bdd441aa2c@blackwall.org>
	<7670876b.ea0b8.189912c3a92.Coremail.linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jul 2023 15:49:02 +0800 (GMT+08:00) Lin Ma wrote:
> Cool, I agree with Hangbin that another patch which removes the redundant
> checks in driver is needed.
> 
> But I have a simple question. I will send this patch to net one and another
> to net-next one. How can I ensure the latter one depends on the former one?
> Or should I send a patch series to net-next that contains the former one :)
> (I currently choose the method 2 and please let me know if I do this wrong)

You'll need to wait for the patch to propagate before posting.
Our trees merge each Thursday, so if you post on Friday the fix
should be in net-next.

