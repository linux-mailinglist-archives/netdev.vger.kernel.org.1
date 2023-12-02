Return-Path: <netdev+bounces-53206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8888019FD
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4551C20ACF
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 02:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B71567C;
	Sat,  2 Dec 2023 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVofHzzs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7322C9C
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 02:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3689EC433C9;
	Sat,  2 Dec 2023 02:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701483599;
	bh=jv+tdtTf6KOSM4NMkkH6kJ/ll3oQ44CqAOvTnC9Q+y4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cVofHzzsiVx3/gqRJ83x7+hO/RjUlLHNWJhDChEXamTwmQBWAznIwwl/8gzvp1QOK
	 b2LiyJMWvFmC9lwQ7HFpe+kuoMI7pHV4DRBLPe1FcGRXDEBSKKDuMh1iVs9yZzIlvM
	 OvUHcYT8h2LQ8Jvn/m2URQN8/sjN8CwJdk9wKSSYSVFewFv6XJYh1DFzvY4hiFjWab
	 BxfZNOVHLqlwqzB3Pq8lOgw87ADY97oM2py7Nt/sc64XVPRl4WHa6uOBHwMJHJgQ3M
	 YyGyC+Pvx/WY/6AomRLjCBT/1yAn7B6XMy9ZsksDWo2LwFz6JZPgKWQix/hrmljFab
	 XvaSAElvd7mcg==
Date: Fri, 1 Dec 2023 18:19:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Liang Chen <liangchen.linux@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hawk@kernel.org,
 linyunsheng@huawei.com, netdev@vger.kernel.org, linux-mm@kvack.org,
 jasowang@redhat.com
Subject: Re: [PATCH net-next v6 1/4] page_pool: Rename pp_frag_count to
 pp_ref_count
Message-ID: <20231201181958.31f72a43@kernel.org>
In-Reply-To: <CAC_iWjKBE5s9iiTPKgsoDx5LSWjsSXE-7SSPSk+EVJXLC10-GQ@mail.gmail.com>
References: <20231130115611.6632-1-liangchen.linux@gmail.com>
	<20231130115611.6632-2-liangchen.linux@gmail.com>
	<CAC_iWjL68n-GRN7vs_jwvzbnVy8sPh4_SP=wVDq0HkFOmSU-nQ@mail.gmail.com>
	<CAC_iWjKBE5s9iiTPKgsoDx5LSWjsSXE-7SSPSk+EVJXLC10-GQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Dec 2023 12:10:10 +0200 Ilias Apalodimas wrote:
> Jakub, are you ok with the name changes or is it going to make
> bisecting a pain?

It's perfectly fine.
I should probably mention that I asked for this rename,
so I'm not impartial :)

