Return-Path: <netdev+bounces-21173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A75762A3C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 06:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A9221C20EDE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 04:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A065399;
	Wed, 26 Jul 2023 04:22:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B05228
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 04:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A765C433C8;
	Wed, 26 Jul 2023 04:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690345353;
	bh=1jirQfUHBFwJP83uQCnv70KG65q3R7Hr79e7uJ4u0FM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q9igssC0UH0+ldn+tBnobao2FbN24makKknwBCnIIxkwdXZTIBsCc/UvOBObT+6kE
	 VeJ7xSbSs3Ommh0V2Kwd865Q9ov72HjGiDbMRX4+1fdwmVakpOTokgUPs/2alw7Ev/
	 0vGkW+7PkIPB9hSSNuieRqonaDl6LL40txxsTxMBbNtR5AIL6FJoqHYbJzvMxtZa2Z
	 t4HyCQAu+TlSMDzzAimXH0tFLJlU4hNAa9oaULllMpKBarsj5z9Jsf17mhax3JW3Iy
	 gC79Eu2Q+tKtuKB0Aot6iCvupLyKRki0bEBFdde5mLnwHSEj8oPMSnLerpQTx2ixlo
	 Z8qQ03vPSQYSQ==
Date: Tue, 25 Jul 2023 21:22:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <wojciech.drewek@intel.com>, <jiri@resnulli.us>, <ivecera@redhat.com>,
 <simon.horman@corigine.com>
Subject: Re: [PATCH net-next v2 00/12][pull request] ice: switchdev bridge
 offload
Message-ID: <20230725212232.6e6b9355@kernel.org>
In-Reply-To: <87pm4fss31.fsf@nvidia.com>
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
	<87pm4fss31.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 22:32:18 +0300 Vlad Buslov wrote:
> > Reviewed-by: Vlad Buslov <vladbu@nvidia.com>  
> 
> In my previous reply I meant reviewed-by for the whole series, not for
> the cover letter specifically. Sorry for not being more clear!

Oh well, since it's a PR I probably shouldn't try to fix that..
What's important is that you reviewed it! :)

