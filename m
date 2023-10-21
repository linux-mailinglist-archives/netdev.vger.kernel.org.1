Return-Path: <netdev+bounces-43214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E217D1C4E
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 11:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F210B210AE
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 09:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC3ED52D;
	Sat, 21 Oct 2023 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vvgBSlRp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24009D30F;
	Sat, 21 Oct 2023 09:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328C9C433C8;
	Sat, 21 Oct 2023 09:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1697882092;
	bh=RA9K1fGVTjS0IKGqX3NOaImRlEySMzvLyeKaUfb88qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vvgBSlRpT7MpWvWslncuyQpwyyA9b9128lDlRRmAtRdAaosZ6SsTPwWCQ/KeDRjxM
	 dcCicMiQm1GQYAhB+BjhaB56gSK3LjZEBpKdEGBtXROleiIYc+H+3L0Ef2Yh7jNLvZ
	 VB1mzK87iCitGed47hERpxIlsdMOAh2xQu0oSulA=
Date: Sat, 21 Oct 2023 11:54:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
Cc: Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Coiby Xu <coiby.xu@gmail.com>, netdev@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	kumaran.4353@gmail.com
Subject: Re: [PATCH v2 0/2] staging: qlge: Replace the occurrences of (1<<x)
 by BIT(x)
Message-ID: <2023102122-ripcord-prune-8516@gregkh>
References: <cover.1697657604.git.nandhakumar.singaram@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697657604.git.nandhakumar.singaram@gmail.com>

On Wed, Oct 18, 2023 at 12:45:01PM -0700, Nandha Kumar Singaram wrote:
> This patchset performs code cleanup in qlge driver as per
> linux coding style and may be applied in any sequence.

Sorry, but this driver just got dropped entirely in my tree, see this
link for the details:
	https://lore.kernel.org/r/20231020124457.312449-1-benjamin.poirier@gmail.com

