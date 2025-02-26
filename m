Return-Path: <netdev+bounces-169657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2AEA45202
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 02:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C151A3B0ACB
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 01:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85143154423;
	Wed, 26 Feb 2025 01:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6RyuVP3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E742A9D
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532351; cv=none; b=oGqDXZSpPqYm2AC5ftAltJOKYSPrt+hamz41Z0ryCsjAcOwmUo2F1IsNmDKXYbzfpbpbbnVNKn0gTYn8O5R0h/G2oE3qHw9uygc4f5RUHhN2PXBsCfICdeW0iWlTsNFfQ7cEd16ga5lWQQO6JFbRDZXYRJc3gh5eNRCoOU85Umg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532351; c=relaxed/simple;
	bh=Q7XNbnyHVAO/AJkzOQub1PmkrtWAzONU+a89IzTOhbg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aj5/f10kv04TenjeBr9nB7RnAIDP1Miu24JecxtY/sVxnKltXeB+gxC1zsB/CFRz1bINIBcke4TYNNCrnZgCkAKSqWMOt9uvnMkFFUOGOGytctdsG/LjHgTgXi28QnI+GuGlUDFMgDGCZs1VW6mTARnx7OVecTALKf1v20R4dLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6RyuVP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37576C4CEDD;
	Wed, 26 Feb 2025 01:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740532350;
	bh=Q7XNbnyHVAO/AJkzOQub1PmkrtWAzONU+a89IzTOhbg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H6RyuVP36/hX8I0JJ4a0gT2WLAxdQfra+wyrEsonhRFqX7TL6gthPJJuSogm9X3mD
	 Todx73voTJ6OmQcYfjkaruU+vrfK9UHdmSs9hGBvzjEgoDTj5AF7jq+GemS/QUCTXT
	 +xAVMvUgVJkRXf4XSkaI6FZgPpn/+DsZQlf/OyQ3L3TQD6Jli3aJ1g3Iv4fR1br6wZ
	 /1n1TcoOf2L9avMOxi/aX2WmMKTh8/NKWK6YmvtDqf0oJDhjqD0D1w3e5/asvYzdYh
	 o1MwcFQjb9XM+H0KDZIZkKTc3FNp4iP326SIlhLIwMbcqxwgZSvMJl63/MQYkSvNWZ
	 IqhN/aA+w42Qw==
Date: Tue, 25 Feb 2025 17:12:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Xin Tian" <tianx@yunsilicon.com>
Cc: <netdev@vger.kernel.org>, <leon@kernel.org>, <andrew+netdev@lunn.ch>,
 <pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>,
 <jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>,
 <weihg@yunsilicon.com>, <wanry@yunsilicon.com>, <horms@kernel.org>,
 <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>
Subject: Re: [PATCH net-next v5 07/14] xsc: Init auxiliary device
Message-ID: <20250225171229.0721fabb@kernel.org>
In-Reply-To: <20250224172429.2455751-8-tianx@yunsilicon.com>
References: <20250224172416.2455751-1-tianx@yunsilicon.com>
	<20250224172429.2455751-8-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 01:24:31 +0800 Xin Tian wrote:
> Our device supports both Ethernet and RDMA functionalities, and
> leveraging the auxiliary bus perfectly addresses our needs for
> managing these distinct features. This patch utilizes auxiliary
> device to handle the Ethernet functionality, while defining
> xsc_adev_list to reserve expansion space for future RDMA
> capabilities.

drivers/net/ethernet/yunsilicon/xsc/pci/adev.c:90:6: warning: variable 'ret' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
   90 |         if (adev_id < 0)
      |             ^~~~~~~~~~~
drivers/net/ethernet/yunsilicon/xsc/pci/adev.c:104:9: note: uninitialized use occurs here
  104 |         return ret;
      |                ^~~
drivers/net/ethernet/yunsilicon/xsc/pci/adev.c:90:2: note: remove the 'if' if its condition is always false
   90 |         if (adev_id < 0)
      |         ^~~~~~~~~~~~~~~~
   91 |                 goto err_free_adev_list;
      |                 ~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/yunsilicon/xsc/pci/adev.c:82:9: note: initialize the variable 'ret' to silence this warning
   82 |         int ret;
      |                ^
      |                 = 0
-- 
pw-bot: cr

