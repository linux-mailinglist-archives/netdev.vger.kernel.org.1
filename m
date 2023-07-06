Return-Path: <netdev+bounces-15832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB92674A14F
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 17:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8CA1C20D91
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 15:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7C4AD23;
	Thu,  6 Jul 2023 15:44:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8BF9453
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 15:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE362C433C8;
	Thu,  6 Jul 2023 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688658275;
	bh=bMABdl+5mCBcPYoYi5ad8hwP76ZhZJrs6kKcX7qC/oc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZiIl5FR7GEqBWmRPrQRwxkVFBdOU/g4Z7qFnzQearUQpc46s4tKhkpjMg2KawIrys
	 MgdcIZqfu9aTBxr27lQFOSAPdt3LfVGgYGi+aNXkEPc6RGmBa9ps7MrZEu8ekvvCQn
	 pT1pzWATA5Iu5PrcX+uylWBTSwiCWkBerpKe+1Ou6m5XL2WpiAjkoch/R6n3XwYojB
	 YsMfzXaDGjOBMaWrZVY51fB+LADOED4ywNZFXEyPifRt2jVsjl0jUWZojylrZYcCMs
	 Ylj22aWxs3LlP4picrmKWBDwjiJ88DoAyWItMOxDabHsyhCBCms0J7FK0D45kky2TO
	 SQ0KtwZwS+/Lw==
Date: Thu, 6 Jul 2023 08:44:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Justin M. Forbes" <jforbes@fedoraproject.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jmforbes@linuxtx.org
Subject: Re: [PATCH] Move rmnet out of NET_VENDOR_QUALCOMM dependency
Message-ID: <20230706084433.5fa44d4c@kernel.org>
In-Reply-To: <20230706145154.2517870-1-jforbes@fedoraproject.org>
References: <20230706145154.2517870-1-jforbes@fedoraproject.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jul 2023 09:51:52 -0500 Justin M. Forbes wrote:
> The rmnet driver is useful for chipsets that are not hidden behind
> NET_VENDOR_QUALCOMM.  Move sourcing the rmnet Kconfig outside of the if
> NET_VENDOR_QUALCOMM as there is no dependency here.
> 
> Signed-off-by: Justin M. Forbes <jforbes@fedoraproject.org>

Examples of the chipsets you're talking about would be great to have in
the commit message.
-- 
pw-bot: cr

