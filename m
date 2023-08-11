Return-Path: <netdev+bounces-26951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3030E7799D6
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 23:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626ED281A2F
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 21:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41ADC329CD;
	Fri, 11 Aug 2023 21:45:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351338833
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 21:45:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE93C433C7;
	Fri, 11 Aug 2023 21:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691790308;
	bh=EjqSQ9sVbqPtwEN0LdKgdnSCHddBC7vSGqAi57qUfmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sKc2JuW+OizLw2iug6zux2qse6QHjt9aaWPhem2iz9WA0fcciAxXyCKViuM4MBv7X
	 EFfW014kpszcecQDuL5mJZHNGUdVlGKY9Z4joGTXEJcqgZRv4Clf6c7tnrSJc9ovkn
	 wPzz29c//tn2VXRRiXXV9Lo37lOhRvTh7NVD3cycbCFUGLFaXlbM9KqiQwK1ikCuH8
	 hZ3HbwcgjE8Ir/e2pfZopfEjT8OKcoOtewNx+tLdQcfV8d3uBxI6RwmBsLfTdMom8+
	 Y/Iyw0efqlHwnrQlQfDSCan5Q1+RV3mCDuppsIJ2NVBH3r10vK1hD7eFbzKGzCpKkE
	 P5W1YiXYfC1eA==
Date: Fri, 11 Aug 2023 14:45:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Manish Chopra <manishc@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Ariel Elior
 <aelior@marvell.com>, Alok Prasad <palok@marvell.com>, Nilesh Javali
 <njavali@marvell.com>, Saurav Kashyap <skashyap@marvell.com>,
 "jmeneghi@redhat.com" <jmeneghi@redhat.com>, "yuval.mintz@qlogic.com"
 <yuval.mintz@qlogic.com>, Sudarsana Reddy Kalluru <skalluru@marvell.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>, David Miller
 <davem@davemloft.net>
Subject: Re: [EXT] Re: [PATCH v2 net] qede: fix firmware halt over suspend
 and resume
Message-ID: <20230811144507.5ab3fdae@kernel.org>
In-Reply-To: <BY3PR18MB4612F2621E50B2F12F2BC342AB10A@BY3PR18MB4612.namprd18.prod.outlook.com>
References: <20230809134339.698074-1-manishc@marvell.com>
	<20230810174718.38190258@kernel.org>
	<BY3PR18MB4612F2621E50B2F12F2BC342AB10A@BY3PR18MB4612.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 09:31:15 +0000 Manish Chopra wrote:
> > Does the FW end up recovering? That could still be preferable to rejecting
> > suspend altogether. Reject is a big hammer, I'm a bit worried it will cause a
> > regression in stable.  
> 
> Yes, By adding the driver's suspend handler with explicit error returned 
> to PCI subsystem prevents the system wide suspend and does not impact the
> device/FW at all. It keeps them operational as they were before.

I'm asking about recovery without this patch, not with it.
That should be evident from the text I'm replying under.

