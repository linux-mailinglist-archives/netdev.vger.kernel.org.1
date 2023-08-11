Return-Path: <netdev+bounces-26953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59422779A5C
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4878F1C20A59
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB950329D7;
	Fri, 11 Aug 2023 22:04:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0BA8833
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 22:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5DE1C433C9;
	Fri, 11 Aug 2023 22:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691791490;
	bh=R79FmNVLkjyVIXv6tcSmcPvmWYKleg4cZwFL8d//vZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QIeCOjJ3kgBHaAngByoR+7WKXG5S3MUZzf8VNz4lm5p93cp034lXuqIByZvWT3QWE
	 B3GG5Uz7waECrMAkotSKH3qKsLzzW8jxT0I5FGlWJBg6qvSh5osqDiDZLOwj5Tx43t
	 s7gfbB+ZiflZvnrVAChWKhUqOWqqDnQ255PPJZNFblCZCIICRiOFeSBDCMNZMEftNx
	 Cb5wpLLLHabXpfMq87yxFAnux0CV4c1uwqoaKHVId1f7aFp1cu8z7fmWZ0Y03SSNJ+
	 LYAYffE0I2Uup57miARef5Pb+nxLSizI/bAxkvLV6Dvw1/AXJsvENaOLz6YWlsKuek
	 KFSynfrpfgHXQ==
Date: Fri, 11 Aug 2023 15:04:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sai Krishna Gajula <saikrishnag@marvell.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sunil
 Kovvuri Goutham <sgoutham@marvell.com>, Geethasowjanya Akula
 <gakula@marvell.com>, Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
 Hariprasad Kelam <hkelam@marvell.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, Naveen Mamindlapalli <naveenm@marvell.com>
Subject: Re: [net-next PATCH v2] octeontx2-pf: Use PTP HW timestamp counter
 atomic update feature
Message-ID: <20230811150449.64ce3512@kernel.org>
In-Reply-To: <BY3PR18MB470745294C1B03C0DA5364E6A010A@BY3PR18MB4707.namprd18.prod.outlook.com>
References: <20230807140535.3070350-1-saikrishnag@marvell.com>
	<20230809155022.132a69a7@kernel.org>
	<BY3PR18MB470745294C1B03C0DA5364E6A010A@BY3PR18MB4707.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 05:48:38 +0000 Sai Krishna Gajula wrote:
> > If you reorder the includes - maybe put them in alphabetical order?  
> 
> There are some structure definitions in rvu.h which are required in
> ptp.h. So, re-ordering in alphabetical order will give compilation
> issue. 

Headers should be self-contained. Such dependencies are hard to figure
out for people doing refactoring so it'd be best to clean that up.

