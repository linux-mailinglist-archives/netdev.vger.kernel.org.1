Return-Path: <netdev+bounces-37634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C333F7B6668
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 12:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 508722816D2
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 10:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D532030E;
	Tue,  3 Oct 2023 10:29:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22312D302;
	Tue,  3 Oct 2023 10:29:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E11BC433C8;
	Tue,  3 Oct 2023 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696328967;
	bh=jXuGOUwI1yvSy2BEPDdzmf9cHXPyEcMQXrsWAPM3Lpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqcITCWlLywDa065bvePch/EM+Fhc9kRn1Pf1zpPvsI7zEZCyqPb/tzWRbuJF52/S
	 GpnKjE+wRVeGLEE3+29+yE10Hp0MGoCH3PQjW+l4ZWJUJyxeKHCzfitf4LXHOLRkVb
	 GAmvZunFsFc/Z6UoAyJJOiyKX7DfZOk2/q1k5bzhXUPw3j2l4WHusRyEH1VgM9lRXp
	 zvDdzD1Cy+4UBtGbrNvXC8SupHfACPgAOlhjljMEnQXHWTCVLVmHc0E7y304VTCgMl
	 leZc6zYGsJhmVUJUErh5QAziKVNzws+LryHGeTbuSoaUNhocFYW9X2vGZbfah6Fsqs
	 YZRRngcUmIkTQ==
Date: Tue, 3 Oct 2023 12:29:22 +0200
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] hyperv: rndis_filter needs to select NLS
Message-ID: <ZRvtAq7Vxb2G89J+@kernel.org>
References: <20230930023234.1903-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230930023234.1903-1-rdunlap@infradead.org>

On Fri, Sep 29, 2023 at 07:32:34PM -0700, Randy Dunlap wrote:
> rndis_filter uses utf8s_to_utf16s() which is provided by setting
> NLS, so select NLS to fix the build error:
> 
> ERROR: modpost: "utf8s_to_utf16s" [drivers/net/hyperv/hv_netvsc.ko] undefined!
> 
> Fixes: 1ce09e899d28 ("hyperv: Add support for setting MAC from within guests")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested


