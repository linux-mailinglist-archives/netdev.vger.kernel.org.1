Return-Path: <netdev+bounces-38028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D357A7B891A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 6015A1F22C46
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 18:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80A51D6A4;
	Wed,  4 Oct 2023 18:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r2bJdY/6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE701D68D
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 18:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350D6C433C9;
	Wed,  4 Oct 2023 18:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696443764;
	bh=3AFIJj51SdZ9DpuF7q6u5IjgQqKGRyOxc+eUae8UTfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r2bJdY/6eZdtjfk1E/zsbvSDLLeZ0Nc6arbyqQEH4UZgzXXHSvXyqivZK9ookBKSD
	 sQI1GvEI1FeZgFIz7T78JEqRvuvgvu+B18nF4/PCk1uCN3WMKAhWyrr1GDSKmsQ7tB
	 Uc/ss1AwHFas0y9p4f2723Xl/ookliXbmnGT+5O+2na3073PDSzsRYnk+O7ZIAkwpW
	 D4U2J4jmblO0sPKaRGOjpTQSWxHtyyAUHzMAcp4XpvGDJkzAo/V3HmzmUyWykf8t04
	 8sUVPkuj85+/ccXCPafdW6JxZFo8tln3t3ixzWRrzjyOGAwmEdUo4Dhi64vu4VBtFG
	 WfCBOPaMtMQ3g==
Date: Wed, 4 Oct 2023 11:22:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, gospo@broadcom.com, Sreekanth Reddy
 <sreekanth.reddy@broadcom.com>
Subject: Re: [PATCH net-next v2 8/9] bnxt_en: Support QOS and TPID settings
 for the SRIOV VLAN
Message-ID: <20231004112243.41cb6351@kernel.org>
In-Reply-To: <20230927035734.42816-9-michael.chan@broadcom.com>
References: <20230927035734.42816-1-michael.chan@broadcom.com>
	<20230927035734.42816-9-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Sep 2023 20:57:33 -0700 Michael Chan wrote:
> From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> 
> Add these missing settings in the .ndo_set_vf_vlan() method.
> Older firmware does not support the TPID setting so check for
> proper support.

Extending the use of legacy SR-IOV NDOs is no longer accepted.
I'm reverting this, sorry.

