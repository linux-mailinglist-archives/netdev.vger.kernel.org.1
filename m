Return-Path: <netdev+bounces-17414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A29751801
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC998281B7D
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03925663;
	Thu, 13 Jul 2023 05:21:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737225662
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6ED5C433C9;
	Thu, 13 Jul 2023 05:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689225699;
	bh=3lUl6XQkY1VlNWjhof7PyxxMgzH+ocQU21QLbaafvq8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=euIL5EzlXfRfn/FGUKw0SLJMclUku4PWXH8xCJms8Hoa4ikPVGFrIFEZyGx/SChwM
	 nMDD3CMJVmNgRZ0Q8JR6klU2fx4mwyXzXUFaNOS9c7WodJ3UG0qODUlRQVUA0iF3Uj
	 ipzKml5V3uTGQbSFhY4fVKgtZMYdbLKsSdjF7Sj2MzWUUPgjdv4fiydC/DfbfgEGNc
	 t9LWbeha3nBLKYIDaCqwIHj4euGAOucqSBUgf8ybv4KpVHMAJz4Ydc5KZxx3x8+QMT
	 SU1ZWBjfixPtwpGhBdbG+3XUpZgpnX/TDklaeXcfX6TL+MDzCDQU0HHeQYvIkpnoAK
	 UwqSUhyu87CwA==
Date: Wed, 12 Jul 2023 22:21:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Suman Ghosh <sumang@marvell.com>
Cc: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [net PATCH 0/3] octeontx2-af: Fix issues with NPC field hash
 extract
Message-ID: <20230712222137.5f59c92c@kernel.org>
In-Reply-To: <20230712111604.2290974-1-sumang@marvell.com>
References: <20230712111604.2290974-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jul 2023 16:46:01 +0530 Suman Ghosh wrote:
> This patchset fixes the issues with NPC field hash extract. This feature is
> supported only for CN10KB variant of CN10K series of silicons.

All patches look like features / extension.

Please describe in the cover letter how user of upstream Linux kernel
can take advantage of those features.
-- 
pw-bot: cr

