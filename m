Return-Path: <netdev+bounces-145015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E59C9181
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6512A1F23B16
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 18:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C248018CC00;
	Thu, 14 Nov 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8IrDprB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37D262A3;
	Thu, 14 Nov 2024 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731608148; cv=none; b=kLZTaV5rPsiUb8Nh9C4FJLfkic/AMLF015OuYyL+P3Iekp/kp3I1c2mOk5Nk4Qn9k/RJcb6BlCa0gtHjeDSt6Jif5ZXOXTbchww1/EIxQFMsKhwzsquMCUl9EM5Y0eDIPKs6ubH4oio01BXDTwQec1xyOsC+z8f6yhmqWJ/TA3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731608148; c=relaxed/simple;
	bh=UbZ/o4ojrMJw253X19jpmNHGN/RI+kaPe4CgSbq8avI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nY22EGZqeNqDCpaWMelkvusTkCqsIUZPDPpl9Nm5aQEmcVPg80I7XIfwEb0t3siiZEoCQEyn71ZeckO4JIpXCEu3Us8vV5Rr4f4PetbujonyQjUuRGTHdOwS8S1XdaLzPeZfYyfE3NRP/iGsKZbNxArmhvGrxd98/wLXaAz0WKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8IrDprB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D3BC4CECD;
	Thu, 14 Nov 2024 18:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731608148;
	bh=UbZ/o4ojrMJw253X19jpmNHGN/RI+kaPe4CgSbq8avI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G8IrDprBR0iXRDRlqq2va24ERX6NrHJyE4lvmAAGBe7VRzsV97iK2eo0as96qYG8B
	 KFOwuqoczWESL0pcS5+WoOU18HgAUBcqLWXKvBxUA+KOOLp/mEXQij00MtQX7pNO6l
	 er9S+61QhJjUlNFdQAOMnzfuecMVttFFGQYhoQRjLNKflCaram4Q3iyCc495hL5MP4
	 bkWvjdLAznK4CDiMP9rAcaZQo/s0z8QWSn4/AICyLmI48rqAKD36ctWisj8zZrTV+9
	 PL5H3w3pbfcfJ/WIlp8uPmlyOijY2Hc+N6VV2iw1rXCNTI2BYgIrW/uQv+b1eM7mLt
	 4uwUo1CVdgaDA==
Date: Thu, 14 Nov 2024 18:15:43 +0000
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next 2/2] rtase: Modify the content format of the
 enum rtase_registers
Message-ID: <20241114181543.GD1062410@kernel.org>
References: <20241114112549.376101-1-justinlai0215@realtek.com>
 <20241114112549.376101-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241114112549.376101-3-justinlai0215@realtek.com>

On Thu, Nov 14, 2024 at 07:25:49PM +0800, Justin Lai wrote:
> Remove unnecessary spaces.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

As this is in the context of other work to improve this driver
I think cleanup should be considered for inclusion upstream.

Reviewed-by: Simon Horman <horms@kernel.org>


