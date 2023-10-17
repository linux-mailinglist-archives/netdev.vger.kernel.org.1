Return-Path: <netdev+bounces-41780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D8E7CBE2E
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3D0F1C20983
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101F13CCF5;
	Tue, 17 Oct 2023 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRdfgB12"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91CABE6D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6456DC433C7;
	Tue, 17 Oct 2023 08:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697532794;
	bh=4BtcOmtIRhmOb3TSMmeIT0EH5AmAl2Emrhl0Yz1benQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRdfgB12PRExKpPgHmHGssDmDm1kY/iW6GnNABHD7Kos02DRKzs86m4Jy/qM4Ny3L
	 eyiD6QYb9jxfUPIysp63qTja7AgE9VtutrFrPd6hbMRS4hDw639IKGp7RNuio5V5UT
	 HpOI5EbESGEoyINdeBShFOh1rzAiJn1PBjwBZ9t8fRp+ZbBtnR/Zp0k6/OCZRtjXSs
	 RAvcRCJX50+fZ6+J3t1KhOIsPwOGCt77Ki6Z7Vt1BqvFBVxvizmCt1rncLWn2YCl+l
	 kEKLAP+ledLokQTshozru+PAd6vfYsdmqjFxzubTfTvGEtOhoS84Hg6reSFEwebluu
	 AJK4QawPJiATw==
Date: Tue, 17 Oct 2023 10:53:11 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next v3 6/7] Documentation: devlink: add a note about
 RTNL lock into locking section
Message-ID: <20231017085311.GN1751252@kernel.org>
References: <20231013121029.353351-1-jiri@resnulli.us>
 <20231013121029.353351-7-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013121029.353351-7-jiri@resnulli.us>

On Fri, Oct 13, 2023 at 02:10:28PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add a note describing the locking order of taking RTNL lock with devlink
> instance lock.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


