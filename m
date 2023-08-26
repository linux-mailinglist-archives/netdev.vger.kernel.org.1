Return-Path: <netdev+bounces-30817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59ABF7892AE
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 02:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708421C2104F
	for <lists+netdev@lfdr.de>; Sat, 26 Aug 2023 00:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B896198;
	Sat, 26 Aug 2023 00:23:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD8190
	for <netdev@vger.kernel.org>; Sat, 26 Aug 2023 00:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9C1C433C7;
	Sat, 26 Aug 2023 00:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693009389;
	bh=p4xIvRkjsP9NejGidMaUBSV/bjLaTX6t/uNfobhVURc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s6RxF9vmYN7wRvFsBmjaD6//Sx1aBbvsMqJhznTc89BIBniNi/npaZW+jmy3MdfJi
	 8ZSVuCIKNvTd8Qsw9+S1ZZ5SkTOcMRPlMdwwGqgqGkNBAloLrRfzN7luzVWZ86oQkW
	 HvkY/3Ac1A7H8krnpnHHc64TE72kmMVNOEnxEvlfqPGaBNTaJOlbRJ6IRr4aL91WUO
	 ZszwEsrVteO4SOgXs4XyStWyISTb+zgBIf39kWw/EG/D/cxXx1mMehiSh/YgoZ6+Qe
	 K+vS+W6hvmLWmTQWTMiEix8yAMUpVa6nIg8RZ6pWeCnpy5HgJWQdwizkZdME5ESdSp
	 HU2lyi+78gfSg==
Date: Fri, 25 Aug 2023 17:23:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Junfeng Guo <junfeng.guo@intel.com>, <anthony.l.nguyen@intel.com>,
 <jesse.brandeburg@intel.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <qi.z.zhang@intel.com>, <ivecera@redhat.com>,
 <sridhar.samudrala@intel.com>, <horms@kernel.org>, <edumazet@google.com>,
 <davem@davemloft.net>, <pabeni@redhat.com>
Subject: Re: [PATCH iwl-next v8 00/15] Introduce the Parser Library
Message-ID: <20230825172307.7fa89fc7@kernel.org>
In-Reply-To: <dbdc320e-bd4a-eb49-5c6d-8f861602046f@intel.com>
References: <20230823093158.782802-1-junfeng.guo@intel.com>
	<20230824075500.1735790-1-junfeng.guo@intel.com>
	<20230824082039.22901063@kernel.org>
	<dbdc320e-bd4a-eb49-5c6d-8f861602046f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Aug 2023 12:52:27 +0200 Alexander Lobakin wrote:
> > You keep breaking the posting guidelines :(
> > I already complained to people at Intel about you.
> > 
> > The only way to push back that I can think of is to start handing out
> > posting suspensions for all @intel.com addresses on netdev. Please  
> 
> Ah, that collective responsibility :D

I'd call it delegating the responsibilities :)

> > don't make us stoop that low.  
> 
> But seriously, please don't. Intel is huge and we physically can't keep
> an eye on every developer or patch. I personally don't even know what
> team the submitter is from.
> Spending 8 hrs a day on tracking every @intel.com submission on
> netdev is also not something I'd like to do at work (I mean, I'd
> probably like reviewing every line coming out of my org, had I
> 120-150 hrs a day...). I know that sounds cheap, but that's how I see
> it :z

Intel may be huge, but this patch is for ice specifically. And the
author knows enough to put presumably-internally-mandated iwl-next
tag in the subject. So how about someone steps up and points them
at a manual before 4 versions are posted?

