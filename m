Return-Path: <netdev+bounces-13143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 141F673A706
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 19:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F601281A30
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 17:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0493C200BB;
	Thu, 22 Jun 2023 17:14:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD80E200AC
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 17:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B7EC433C8;
	Thu, 22 Jun 2023 17:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687454039;
	bh=6KZs/nSTvPw2lJ6rpQ5KBcWQJe/VnKfj+VA7J0zTEt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rw85entlyUI/Jp1Qsv1BLtcMJ6KOdq0soKPHsltPtobRmlEfzYQfGwwZEKC0UJI/3
	 xD9xMEi2QgnKrYfL3uZ0Kn5YM1ZYmjFzG+zKqCR8gG/uDi7RWDupeD2uNo9leN5Ynu
	 aA0mhrLcbb8dQBPsm7s2roUYT+b3CENCOz0m0vuBekSWMhi6i7tmBRrIsQPLljelVC
	 UFu/HGFH43ZJW85a/aFRk2R3RxrG98xAN1dVQ45hIqzeuxTrbYqfTfZYhQslLffDCb
	 /1iHpqBFNRyhH0pIEArRtb1FdMctJBAY9KR2cPIEmss8HGuSmYiw0JRCdC405EPBUn
	 CZViUQ4wcBVbg==
Date: Thu, 22 Jun 2023 10:13:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
 <pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
 <wojciech.drewek@intel.com>, <jiri@resnulli.us>, <ivecera@redhat.com>,
 <simon.horman@corigine.com>
Subject: Re: [PATCH net-next 00/12][pull request] ice: switchdev bridge
 offload
Message-ID: <20230622101358.0c30a0a5@kernel.org>
In-Reply-To: <87ilbgvcim.fsf@nvidia.com>
References: <20230620174423.4144938-1-anthony.l.nguyen@intel.com>
	<20230620111240.24b1f6a9@kernel.org>
	<87ilbgvcim.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jun 2023 22:25:39 +0300 Vlad Buslov wrote:
> > Hi Vlad, it would be great to have your review on this one!  
> 
> Hi Jakub. Sorry for late response, I'm OoO till next week and seldom
> check my work email. Will try to look at the patches tomorrow.

Thanks Vlad!
-- 
pw-bot: cr

