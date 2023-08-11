Return-Path: <netdev+bounces-26957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B31E779A85
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 00:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8B3281CC1
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 22:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05FE34CC2;
	Fri, 11 Aug 2023 22:16:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CBB8833
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 22:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81EBC433C7;
	Fri, 11 Aug 2023 22:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691792162;
	bh=Ij056HVqFHgqVXcA004wcrzjBrMfGIXZ2pH3gqMs54o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=piYIWLXO3De10Yzl/eflmy8NnxbNRowYoN/jd7Px7u2f0wo9SoJtHEkpA+3OegWCp
	 qt8A9DCQnjy540FJFSYVJ7SFUF9wfKZxuEUe9IRpa6LfufYmSa6T945GXdQJFJusXF
	 8l4I2bFA4JRXFKqWWzJpaSyPAJzu3HM7TzzuHi7sX7XZXsTLfrC52p+NKcqju0/qS/
	 ixjlH4HwuGmkAKTM3vPiwfVQzlOn8L2A86uK81vZcTbRfbXTjXCLnWm2EHG1Q12zvY
	 pE9rCDcgmg0i9ET+lXi+J+0V2rQTa5bKOlgl0zsICqKPGdy9+jCE+aJgxYg3kq25Q4
	 Q0ikIuAFQFSqA==
Date: Fri, 11 Aug 2023 15:16:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, netdev@vger.kernel.org, Paul M
 Stillwell Jr <paul.m.stillwell.jr@intel.com>, jacob.e.keller@intel.com,
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: Re: [PATCH net-next v2 2/5] ice: configure FW logging
Message-ID: <20230811151600.6d59eaad@kernel.org>
In-Reply-To: <ZNYH705yA5qGxnvJ@vergenet.net>
References: <20230810170109.1963832-1-anthony.l.nguyen@intel.com>
	<20230810170109.1963832-3-anthony.l.nguyen@intel.com>
	<ZNYH705yA5qGxnvJ@vergenet.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Aug 2023 12:05:35 +0200 Simon Horman wrote:
> >  	if (status) {
> >  		pr_err("failed to register PCI driver, err %d\n", status);
> >  		goto err_dest_lag_wq;
> > +		destroy_workqueue(ice_wq);
> > +		ice_debugfs_exit();  
> 
> Hi Paul and Tony,
> 
> this new code seems to be unreachable.
> Should it go before the goto statement?

:o catch of the week! :)
-- 
pw-bot: cr

