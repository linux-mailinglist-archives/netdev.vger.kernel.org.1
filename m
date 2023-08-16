Return-Path: <netdev+bounces-27878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B4477D81A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 04:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4811C20DB8
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A826E138E;
	Wed, 16 Aug 2023 02:06:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46C1388
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94CBC433C8;
	Wed, 16 Aug 2023 02:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692151604;
	bh=CGNr34szINxLhBzT8NdUd8WHz2+azRMk174GL2+Z4hE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e9Ntgg0olOvNh+a5uKYokd8H7stTFDGNz/3BiOmxBZLfGP1z8fOCYBQoUocGIhiqh
	 n4Y14Qujq4xkSJs3aBQAQD9g1rj2O5IBL6KIHgD/UuKMY26fLuaCGIaoLAxRJ1qrWV
	 DMiQdxuvV86nTaenT5hVNE89q1pWsRqt5D+CNRsHDNwsrv2mhbUSpeXp8wS+hr4XBt
	 YMfwFthRPru5Z2tfNOh11eFN2GjLy13PyUZgzOCWL+MJexHUO3ZGmv0bs1jlAaDXJ1
	 24GWtneX/VSEnvCyaEBBkmdGZ3E1xvsJEokwQq5EzKKd6f9p00VEoYv/zUJlj+jQms
	 5qv0LL5BWo9sQ==
Date: Tue, 15 Aug 2023 19:06:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Yue Haibing <yuehaibing@huawei.com>, <jesse.brandeburg@intel.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: e1000e: Remove unused declarations
Message-ID: <20230815190642.315fa2af@kernel.org>
In-Reply-To: <2ef66ad0-d8d2-ae28-9624-04a3fbe94de4@intel.com>
References: <20230814135821.4808-1-yuehaibing@huawei.com>
	<2ef66ad0-d8d2-ae28-9624-04a3fbe94de4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Aug 2023 15:19:10 -0700 Tony Nguyen wrote:
> On 8/14/2023 6:58 AM, Yue Haibing wrote:
> > Commit bdfe2da6aefd ("e1000e: cosmetic move of function prototypes to the new mac.h")
> > declared but never implemented them.
> > 
> > Signed-off-by: Yue Haibing <yuehaibing@huawei.com>  
> 
> I believe netdev has been taking all these unused declaration patches 
> directly so...
> 
> Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

Thanks! We do have a bit of a mixed record either applying these 
or deferring to maintainers...

