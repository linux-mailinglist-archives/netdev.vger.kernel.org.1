Return-Path: <netdev+bounces-183406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B02A90992
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55433168947
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5647920DD40;
	Wed, 16 Apr 2025 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awnWpg25"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3246B195FE8
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744823093; cv=none; b=mOljN4T82VOeh5Mr/8Av0opOXrlrsReQMTvsSeD5NbxMJRe2qZ6dmVUZRAILFc/sARBFz4QfrGfl9ptuA+l0NrCOwjdrvwXxkK6TI3jG/+znAw6xJGjAungoF0mwKZlpgW01GMYSpTCcw+2hIL0Vb5wA1mfapSrIVKk0n5ofSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744823093; c=relaxed/simple;
	bh=X+hdtTE3I9nqlJM1Kle+k2xO66KF4y9d+l1InnmbIiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFIE0kfrk4ukyDuEmerrm6Cyq5/G7gVhyYabh3UDiN/7Z9upPoUTr/JtxehEPRu5Fq+1vRlvQSrZuadpLECELCmJl+vX8SDl80ajGyD+iKYNZJ+eTws0LWtqEN9ox3IWiX5nGXm1vRbVi5P0O5Z+aNQlCXc7WPb0/bQaQToqXfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awnWpg25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0242C4CEE2;
	Wed, 16 Apr 2025 17:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744823091;
	bh=X+hdtTE3I9nqlJM1Kle+k2xO66KF4y9d+l1InnmbIiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awnWpg25stPGEkodW2n6rnQ3VmVbQtYG8CCZIlZiliFhJs+7xUGxTVNYwRtZvAmJm
	 yNpebVgMFRsUHholtmTylAm/4Th5ePfNID6jHsIkEPlBJMet3GGkIfEKgCNgSwGGVc
	 TdleW0HW23lgmrc5+EA8yXUTZKsFdQ2yONvZs2yiC4xrRnJOD/p83Bo4s8K5gxpi9R
	 IOsjBMM1EdXotdADKeszaGnEH6TapkcQ6v3nLUL7Kx4ZYM8xKH6adys86BhHPsXmQ4
	 qg0moAdibw6QADJc1jxLzUbeBG8u2fNQhmUb94fc+NkERqTRZsYsSjH/YQuNGLWQmh
	 ONEPE20yPI4aw==
Date: Wed, 16 Apr 2025 18:04:47 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: Add missing filed to ppe_mbox_data
 struct
Message-ID: <20250416170447.GU395307@horms.kernel.org>
References: <20250415-airoha-en7581-fix-ppe_mbox_data-v1-1-4408c60ba964@kernel.org>
 <20250416154144.GT395307@horms.kernel.org>
 <Z__S_m9fBEKmoos1@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z__S_m9fBEKmoos1@lore-desk>

On Wed, Apr 16, 2025 at 05:55:42PM +0200, Lorenzo Bianconi wrote:
> > On Tue, Apr 15, 2025 at 09:27:21AM +0200, Lorenzo Bianconi wrote:
> > > The official Airoha EN7581 firmware requires adding max_packet filed in
> > > ppe_mbox_data struct while the unofficial one used to develop the Airoha
> > > EN7581 flowtable offload does not require this field. This patch fixes
> > > just a theoretical bug since the Airoha EN7581 firmware is not posted to
> > > linux-firware or other repositories (e.g. OpenWrt) yet.
> > > 
> > > Fixes: 23290c7bc190d ("net: airoha: Introduce Airoha NPU support")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/net/ethernet/airoha/airoha_npu.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
> > > index 7a5710f9ccf6a4a4f555ab63d67cb6b318de9b52..16201b5ce9f27866896226c3611b4a154d19bc2c 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_npu.c
> > > +++ b/drivers/net/ethernet/airoha/airoha_npu.c
> > > @@ -104,6 +104,7 @@ struct ppe_mbox_data {
> > >  			u8 xpon_hal_api;
> > >  			u8 wan_xsi;
> > >  			u8 ct_joyme4;
> > > +			u8 max_packet;
> > >  			int ppe_type;
> > >  			int wan_mode;
> > >  			int wan_sel;
> > 
> > Hi Lorenzo,
> > 
> > I'm a little confused by this.
> > 
> > As I understand it ppe_mbox_data is sent as the data of a mailbox message
> > send to the device.  But by adding the max_packet field the layout is
> > changed. The size of the structure changes. And perhaps more importantly
> > the offset of fields after max_packet, e.g.  wan_mode, change.
> > 
> > Looking at how this is used, f.e. in the following code, I'm unclear on
> > how this change is backwards compatible.
> 
> you are right Simon, this change is not backwards compatible but the fw
> is not publicly available yet and the official fw version will use this
> new layout (the previous one was just a private version I used to develop
> the driver).  Can we use this simple approach or do you think we should
> differentiate the two firmware version in some way? (even if the previous
> one will never be used).

Hi Lorenzo,

Sorry, I misunderstood the commit message.

Yes, I think this simple approach is fine if there is no
compatibility issue wrt firmwares we can reasonably expect
in the wild. Which seems to be the case here.

Reviewed-by: Simon Horman <horms@kernel.org>



